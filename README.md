# Ubuntu12.10 で 簡単CakePHP開発環境構築

## 事前準備

- [Virtualbox](https://www.virtualbox.org/)
  - 公式サイトから installer をDLしてインストールしておく

- [vagrant](http://www.vagrantup.com/)
  - 公式サイトにinstaller もあるが、gem install vagrant でインストルするのが一般的
  - rvm等が入っていないと root 権限を要求される。

- /etc/hosts (Mac OS X の場合)
  - `192.168.40.11 cakephp.example.com` の1行を追加しておく
  - host名やIPはVagrantfileで設定変更可能

## アプリ

このRepositoryと同じ階層に `app` というディレクトリ名でCakePHPのソースコードを一式設置しておく  
ディレクトリ名はVagrantfileで設定変更可能


## 使い方

	$ git clone http://github.com/makies/vagrant-cakephp.git server
	$ cd server

	// vm起動
	$ vagrant up


	// vm 終了
	$ vagrant halt


	// vm 再起動
	$ vagrant reload

	// chef-soloのみ実行
	$ vagrant provision


	// vm　破棄
	$ vagrant destroy


	// vm sshログイン(鍵認証)
	$ vagrant ssh


Return-Path: <linux-pm+bounces-41532-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKFYFVWyeGkksQEAu9opvQ
	(envelope-from <linux-pm+bounces-41532-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 13:40:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F03059466A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 13:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28B883004F3D
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 12:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ED035503E;
	Tue, 27 Jan 2026 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ncj/8cfM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3015635502A;
	Tue, 27 Jan 2026 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769517651; cv=none; b=Xtj7AwZtldjYZ1ZmQP/rlVa7asOyCHTUydKrJAv9WsIBvmQPOJBq3U70shbWC+crZf7FTC8KovW9Xa1yynAx0OlX1hsdOPN1ylHtbLzSvts6yAUpHnq4vL38hJHqI/yfVd/h/VGN0yjJ4K7bq6GSZv3Arp0xs2dnh6Jr/bqm8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769517651; c=relaxed/simple;
	bh=Pk9BaCSYWTL34kArksEQ7zusmyhi7lPpqYOwXRWTJKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaV5Xj7moXgC7Q6ttNgylSZanKRJUkRllWZ7US40QKQhnjD+Q8THPdeXs49lYD8oEmvZyBEOi+D5QNiiBnzImKRfqOJ4bGB55L94Nq/gDC/y1grAkIBUjP+bCFXQpJL7vQU9mJ3b2Ba5tS0vrmEh5w0cu2qgJUDThoVVEweg7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ncj/8cfM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769517648; x=1801053648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pk9BaCSYWTL34kArksEQ7zusmyhi7lPpqYOwXRWTJKI=;
  b=Ncj/8cfM1QH1224RvxVLHi1xR/wQO5fUA6hIybq3niQc80TalP2uxw3H
   aAnYEUv2Cwt+oxiSAx36Mfll5Lf8yDeZc/jx2Wy3cLCEEcTPZPU3T1mOD
   uFvbvmB54O7tBfqzZTpSiHR2qkgl3TzhlUzhRt/TodshjfJeJMgV1yjrr
   3tsMkgKi16XuY1RbKRHYqU19hOF/xw83MvVMjkikqTNpL4zCxBZRRYefD
   hM+vdCHDs5NojeGsFgXrWOCdIvVOQbVqUcHSJmtv0wdqlX42c1Tf5kzKA
   sRINXbEKCLxjOjJzFDwL2YXKHWHK6h7IOvsqXu2XjiI1uncmwTlw+9dxn
   g==;
X-CSE-ConnectionGUID: dl8ec/kqQkmLE+Fed/yguw==
X-CSE-MsgGUID: wE3oEorrQU6IfOGLfvfwNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81343375"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="81343375"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 04:40:47 -0800
X-CSE-ConnectionGUID: wPxRd7xlT4+HlVIuh8Cd+Q==
X-CSE-MsgGUID: OE1kwsSSR5GKff1XzUJOyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207985200"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 04:40:43 -0800
Date: Tue, 27 Jan 2026 20:40:40 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, donald.hunter@gmail.com,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, lenb@kernel.org,
	pavel@kernel.org, kernel-dev@igalia.com, linux-pm@vger.kernel.org,
	netdev@vger.kernel.org, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for 6.19 4/4] PM: EM: Add dump to get-perf-domains in
 the EM YNL spec
Message-ID: <aXiySM79UYfk+ytd@ly-workstation>
References: <20260108053212.642478-1-changwoo@igalia.com>
 <20260108053212.642478-5-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108053212.642478-5-changwoo@igalia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41532-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,igalia.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi1.lai@linux.intel.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gitlab.com:url,intel.com:dkim,arm.com:email,igalia.com:email]
X-Rspamd-Queue-Id: F03059466A
X-Rspamd-Action: no action

Hi Changwoo Min,

Greetings!

I used Syzkaller and found that there is general protection fault in __bitmap_weight in linux-next next-20260126.

After bisection and the first bad commit is:
"
380ff27af25e PM: EM: Add dump to get-perf-domains in the EM YNL spec
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/260127_162751___bitmap_weight
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/260127_162751___bitmap_weight/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/260127_162751___bitmap_weight/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/260127_162751___bitmap_weight/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/260127_162751___bitmap_weight/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/260127_162751___bitmap_weight/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/260127_162751___bitmap_weight/bzImage_v6.19-rc7
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/260127_162751___bitmap_weight/v6.19-rc7_dmesg.log

"
[   19.746792] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 I
[   19.747509] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
[   19.747982] CPU: 0 UID: 0 PID: 710 Comm: repro Not tainted 6.19.0-rc7-v6.19-rc7 #1 PREEMPT(voluntary)
[   19.748561] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org4
[   19.749261] RIP: 0010:__bitmap_weight+0xb9/0x110
[   19.749574] Code: 89 ee e8 3a cb 64 fe 45 85 ed 74 3e e8 30 d1 64 fe 48 8b 45 c8 48 8d 1c d8 48 b8 00 00 00 00 00 fc8
[   19.750681] RSP: 0018:ff110000151ef488 EFLAGS: 00010206
[   19.750982] RAX: dffffc0000000000 RBX: 0000000000000030 RCX: ffffffff8324fe06
[   19.751388] RDX: 0000000000000006 RSI: ffffffff8324fe10 RDI: 0000000000000005
[   19.751779] RBP: ff110000151ef4c0 R08: 0000000000000001 R09: ffe21c0002a3de7b
[   19.752188] R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000000
[   19.752585] R13: 0000000000000002 R14: 0000000000000030 R15: ff1100001e531a00
[   19.752984] FS:  00007f0bbbba3740(0000) GS:ff110000e34b5000(0000) knlGS:0000000000000000
[   19.753441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.753779] CR2: 0000000020000b00 CR3: 000000001e6bd006 CR4: 0000000000771ef0
[   19.754194] PKRU: 55555554
[   19.754357] Call Trace:
[   19.754505]  <TASK>
[   19.754639]  dev_energymodel_nl_get_perf_domains_doit+0x140/0x4b0
[   19.754997]  genl_family_rcv_msg_doit+0x23d/0x330
[   19.755285]  ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
[   19.755594]  ? genl_get_cmd+0x1c9/0x630
[   19.755832]  genl_rcv_msg+0x580/0x840
[   19.756058]  ? __pfx_genl_rcv_msg+0x10/0x10
[   19.756315]  ? __pfx_dev_energymodel_nl_get_perf_domains_doit+0x10/0x10
[   19.756698]  netlink_rcv_skb+0x174/0x450
[   19.756934]  ? __pfx_genl_rcv_msg+0x10/0x10
[   19.757192]  ? __pfx_netlink_rcv_skb+0x10/0x10
[   19.757460]  ? netlink_deliver_tap+0x1b9/0xca0
[   19.757734]  genl_rcv+0x32/0x50
[   19.757928]  netlink_unicast+0x7e2/0xc80
[   19.758179]  ? __pfx_netlink_unicast+0x10/0x10
[   19.758446]  ? __virt_addr_valid+0x10a/0x5f0
[   19.758707]  ? __check_object_size+0x3c/0x9b0
[   19.758973]  netlink_sendmsg+0x957/0xe80
[   19.759219]  ? __pfx_netlink_sendmsg+0x10/0x10
[   19.759481]  ? __import_iovec+0x1df/0x660
[   19.759729]  ? __might_fault+0xe0/0x1b0
[   19.759963]  ? __pfx_netlink_sendmsg+0x10/0x10
[   19.760236]  ____sys_sendmsg+0xaa3/0xc70
[   19.760479]  ? __pfx_____sys_sendmsg+0x10/0x10
[   19.760754]  ? __this_cpu_preempt_check+0x21/0x30
[   19.761032]  ? lock_release+0x14f/0x2a0
[   19.761283]  ___sys_sendmsg+0x121/0x1c0
[   19.761516]  ? do_anonymous_page+0x4c0/0x1a30
[   19.761784]  ? __pfx____sys_sendmsg+0x10/0x10
[   19.762051]  ? __handle_mm_fault+0x656/0x2d60
[   19.762334]  ? __lock_acquire+0x412/0x2210
[   19.762590]  __sys_sendmsg+0x177/0x220
[   19.762813]  ? __pfx___sys_sendmsg+0x10/0x10
[   19.763074]  ? lockdep_hardirqs_on+0x85/0x110
[   19.763346]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[   19.763729]  ? __audit_syscall_entry+0x393/0x4f0
[   19.764023]  __x64_sys_sendmsg+0x80/0xc0
[   19.764274]  ? syscall_trace_enter+0x14d/0x240
[   19.764551]  x64_sys_call+0x1d98/0x21b0
[   19.764787]  do_syscall_64+0x6d/0x1180
[   19.765020]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.765324] RIP: 0033:0x7f0bbb83ee5d
[   19.765546] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d8
[   19.766615] RSP: 002b:00007ffdd5009908 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[   19.767059] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0bbb83ee5d
[   19.767485] RDX: 0000000000000004 RSI: 0000000020000b00 RDI: 0000000000000003
[   19.767897] RBP: 00007ffdd5009920 R08: 00007ffdd5009920 R09: 00007ffdd5009920
[   19.768322] R10: 00007ffdd5009390 R11: 0000000000000246 R12: 00007ffdd5009a78
[   19.768746] R13: 0000000000401829 R14: 0000000000403e08 R15: 00007f0bbbbf0000
[   19.769176]  </TASK>
[   19.769316] Modules linked in:
[   19.769547] ---[ end trace 0000000000000000 ]---
"

Hope this cound be insightful to you.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

On Thu, Jan 08, 2026 at 02:32:12PM +0900, Changwoo Min wrote:
> Add dump to get-perf-domains, so that a user can fetch either information
> about a specific performance domain with do or information about all
> performance domains with dump. Share the reply format of do and dump using
> perf-domain-attrs, so remove perf-domains. The YNL spec, autogenerated
> files, and the do implementation are updated, and the dump implementation
> is added.
> 
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  .../netlink/specs/dev-energymodel.yaml        | 25 ++++---
>  include/uapi/linux/dev_energymodel.h          |  7 --
>  kernel/power/em_netlink.c                     | 68 ++++++++++++++-----
>  kernel/power/em_netlink_autogen.c             | 16 ++++-
>  kernel/power/em_netlink_autogen.h             |  2 +
>  5 files changed, 80 insertions(+), 38 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/dev-energymodel.yaml b/Documentation/netlink/specs/dev-energymodel.yaml
> index af8b8f72f722..11faabfdfbe8 100644
> --- a/Documentation/netlink/specs/dev-energymodel.yaml
> +++ b/Documentation/netlink/specs/dev-energymodel.yaml
> @@ -42,16 +42,6 @@ definitions:
>            missing real power information.
>  
>  attribute-sets:
> -  -
> -    name: perf-domains
> -    doc: >-
> -      Information on all the performance domains.
> -    attributes:
> -      -
> -        name: perf-domain
> -        type: nest
> -        nested-attributes: perf-domain
> -        multi-attr: true
>    -
>      name: perf-domain
>      doc: >-
> @@ -133,12 +123,21 @@ operations:
>    list:
>      -
>        name: get-perf-domains
> -      attribute-set: perf-domains
> +      attribute-set: perf-domain
>        doc: Get the list of information for all performance domains.
>        do:
> -        reply:
> +        request:
>            attributes:
> -            - perf-domain
> +            - perf-domain-id
> +        reply:
> +          attributes: &perf-domain-attrs
> +            - pad
> +            - perf-domain-id
> +            - flags
> +            - cpus
> +      dump:
> +        reply:
> +          attributes: *perf-domain-attrs
>      -
>        name: get-perf-table
>        attribute-set: perf-table
> diff --git a/include/uapi/linux/dev_energymodel.h b/include/uapi/linux/dev_energymodel.h
> index 3399967e1f93..355d8885c9a0 100644
> --- a/include/uapi/linux/dev_energymodel.h
> +++ b/include/uapi/linux/dev_energymodel.h
> @@ -36,13 +36,6 @@ enum dev_energymodel_perf_domain_flags {
>  	DEV_ENERGYMODEL_PERF_DOMAIN_FLAGS_PERF_DOMAIN_ARTIFICIAL = 4,
>  };
>  
> -enum {
> -	DEV_ENERGYMODEL_A_PERF_DOMAINS_PERF_DOMAIN = 1,
> -
> -	__DEV_ENERGYMODEL_A_PERF_DOMAINS_MAX,
> -	DEV_ENERGYMODEL_A_PERF_DOMAINS_MAX = (__DEV_ENERGYMODEL_A_PERF_DOMAINS_MAX - 1)
> -};
> -
>  enum {
>  	DEV_ENERGYMODEL_A_PERF_DOMAIN_PAD = 1,
>  	DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF_DOMAIN_ID,
> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
> index b6edb018c65a..5a611d3950fd 100644
> --- a/kernel/power/em_netlink.c
> +++ b/kernel/power/em_netlink.c
> @@ -18,6 +18,13 @@
>  #include "em_netlink_autogen.h"
>  
>  /*************************** Command encoding ********************************/
> +struct dump_ctx {
> +	int idx;
> +	int start;
> +	struct sk_buff *skb;
> +	struct netlink_callback *cb;
> +};
> +
>  static int __em_nl_get_pd_size(struct em_perf_domain *pd, void *data)
>  {
>  	int nr_cpus, msg_sz, cpus_sz;
> @@ -43,14 +50,8 @@ static int __em_nl_get_pd(struct em_perf_domain *pd, void *data)
>  {
>  	struct sk_buff *msg = data;
>  	struct cpumask *cpumask;
> -	struct nlattr *entry;
>  	int cpu;
>  
> -	entry = nla_nest_start(msg,
> -			       DEV_ENERGYMODEL_A_PERF_DOMAINS_PERF_DOMAIN);
> -	if (!entry)
> -		goto out_cancel_nest;
> -
>  	if (nla_put_u32(msg, DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF_DOMAIN_ID,
>  			pd->id))
>  		goto out_cancel_nest;
> @@ -66,26 +67,50 @@ static int __em_nl_get_pd(struct em_perf_domain *pd, void *data)
>  			goto out_cancel_nest;
>  	}
>  
> -	nla_nest_end(msg, entry);
> -
>  	return 0;
>  
>  out_cancel_nest:
> -	nla_nest_cancel(msg, entry);
> -
>  	return -EMSGSIZE;
>  }
>  
> +static int __em_nl_get_pd_for_dump(struct em_perf_domain *pd, void *data)
> +{
> +	const struct genl_info *info;
> +	struct dump_ctx *ctx = data;
> +	void *hdr;
> +	int ret;
> +
> +	if (ctx->idx++ < ctx->start)
> +		return 0;
> +
> +	info = genl_info_dump(ctx->cb);
> +	hdr = genlmsg_iput(ctx->skb, info);
> +	if (!hdr) {
> +		genlmsg_cancel(ctx->skb, hdr);
> +		return -EMSGSIZE;
> +	}
> +
> +	ret = __em_nl_get_pd(pd, ctx->skb);
> +	genlmsg_end(ctx->skb, hdr);
> +	return ret;
> +}
> +
>  int dev_energymodel_nl_get_perf_domains_doit(struct sk_buff *skb,
>  					      struct genl_info *info)
>  {
> +	int id, ret = -EMSGSIZE, msg_sz = 0;
> +	int cmd = info->genlhdr->cmd;
> +	struct em_perf_domain *pd;
>  	struct sk_buff *msg;
>  	void *hdr;
> -	int cmd = info->genlhdr->cmd;
> -	int ret = -EMSGSIZE, msg_sz = 0;
>  
> -	for_each_em_perf_domain(__em_nl_get_pd_size, &msg_sz);
> +	if (!info->attrs[DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF_DOMAIN_ID])
> +		return -EINVAL;
>  
> +	id = nla_get_u32(info->attrs[DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF_DOMAIN_ID]);
> +	pd = em_perf_domain_get_by_id(id);
> +
> +	__em_nl_get_pd_size(pd, &msg_sz);
>  	msg = genlmsg_new(msg_sz, GFP_KERNEL);
>  	if (!msg)
>  		return -ENOMEM;
> @@ -94,10 +119,9 @@ int dev_energymodel_nl_get_perf_domains_doit(struct sk_buff *skb,
>  	if (!hdr)
>  		goto out_free_msg;
>  
> -	ret = for_each_em_perf_domain(__em_nl_get_pd, msg);
> +	ret = __em_nl_get_pd(pd, msg);
>  	if (ret)
>  		goto out_cancel_msg;
> -
>  	genlmsg_end(msg, hdr);
>  
>  	return genlmsg_reply(msg, info);
> @@ -106,10 +130,22 @@ int dev_energymodel_nl_get_perf_domains_doit(struct sk_buff *skb,
>  	genlmsg_cancel(msg, hdr);
>  out_free_msg:
>  	nlmsg_free(msg);
> -
>  	return ret;
>  }
>  
> +int dev_energymodel_nl_get_perf_domains_dumpit(struct sk_buff *skb,
> +						struct netlink_callback *cb)
> +{
> +	struct dump_ctx ctx = {
> +		.idx = 0,
> +		.start = cb->args[0],
> +		.skb = skb,
> +		.cb = cb,
> +	};
> +
> +	return for_each_em_perf_domain(__em_nl_get_pd_for_dump, &ctx);
> +}
> +
>  static struct em_perf_domain *__em_nl_get_pd_table_id(struct nlattr **attrs)
>  {
>  	struct em_perf_domain *pd;
> diff --git a/kernel/power/em_netlink_autogen.c b/kernel/power/em_netlink_autogen.c
> index 44acef0e7df2..fedd473e4244 100644
> --- a/kernel/power/em_netlink_autogen.c
> +++ b/kernel/power/em_netlink_autogen.c
> @@ -11,6 +11,11 @@
>  
>  #include <uapi/linux/dev_energymodel.h>
>  
> +/* DEV_ENERGYMODEL_CMD_GET_PERF_DOMAINS - do */
> +static const struct nla_policy dev_energymodel_get_perf_domains_nl_policy[DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF_DOMAIN_ID + 1] = {
> +	[DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF_DOMAIN_ID] = { .type = NLA_U32, },
> +};
> +
>  /* DEV_ENERGYMODEL_CMD_GET_PERF_TABLE - do */
>  static const struct nla_policy dev_energymodel_get_perf_table_nl_policy[DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID + 1] = {
>  	[DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID] = { .type = NLA_U32, },
> @@ -18,10 +23,17 @@ static const struct nla_policy dev_energymodel_get_perf_table_nl_policy[DEV_ENER
>  
>  /* Ops table for dev_energymodel */
>  static const struct genl_split_ops dev_energymodel_nl_ops[] = {
> +	{
> +		.cmd		= DEV_ENERGYMODEL_CMD_GET_PERF_DOMAINS,
> +		.doit		= dev_energymodel_nl_get_perf_domains_doit,
> +		.policy		= dev_energymodel_get_perf_domains_nl_policy,
> +		.maxattr	= DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF_DOMAIN_ID,
> +		.flags		= GENL_CMD_CAP_DO,
> +	},
>  	{
>  		.cmd	= DEV_ENERGYMODEL_CMD_GET_PERF_DOMAINS,
> -		.doit	= dev_energymodel_nl_get_perf_domains_doit,
> -		.flags	= GENL_CMD_CAP_DO,
> +		.dumpit	= dev_energymodel_nl_get_perf_domains_dumpit,
> +		.flags	= GENL_CMD_CAP_DUMP,
>  	},
>  	{
>  		.cmd		= DEV_ENERGYMODEL_CMD_GET_PERF_TABLE,
> diff --git a/kernel/power/em_netlink_autogen.h b/kernel/power/em_netlink_autogen.h
> index f7e4bddcbd53..5caf2f7e18a5 100644
> --- a/kernel/power/em_netlink_autogen.h
> +++ b/kernel/power/em_netlink_autogen.h
> @@ -14,6 +14,8 @@
>  
>  int dev_energymodel_nl_get_perf_domains_doit(struct sk_buff *skb,
>  					     struct genl_info *info);
> +int dev_energymodel_nl_get_perf_domains_dumpit(struct sk_buff *skb,
> +					       struct netlink_callback *cb);
>  int dev_energymodel_nl_get_perf_table_doit(struct sk_buff *skb,
>  					   struct genl_info *info);
>  
> -- 
> 2.52.0
> 


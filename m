Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4BC18841
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 12:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfEIKXZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 06:23:25 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33871 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbfEIKXY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 06:23:24 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 459A3155A8;
        Thu,  9 May 2019 06:23:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 09 May 2019 06:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=C5Kt50
        Zn7uloNUav3T5eCOtcBzViQn5Dx3VKkV1Ch8s=; b=F/nWylnnH37S5lM3Fy+hFV
        2wCHwWziMjN2LDAXU/y+BawQLnjsOJJxV5OSgSLohdRQADtRkXmkGQ5pHaRFw9Js
        SC58CyYuW9/UgmT2jrncV9rj8FaVj2D40qA/kVPi1P0WLTrHv6CCWD4fG2+cyIfq
        lbMEJT+fn9H4nW046wb6rxhM9zoSrs+90R4971GC5chArl46uHx+56eGYgEWNS3i
        TuiH0IpxXwsdx0ZwjVvD69NE2uELlD/S38eNK/wYf45NE0YSqWphkdFRkbA19ySy
        Zj+8i/13sD+77cSM6201c5Xu06IqU+f85nYtWdVfghLXF2IlfZxC0Rlyzv6opjzA
        ==
X-ME-Sender: <xms:l__TXCVwD4dMjurF0hRUWl9HwilfHUarTyyYAbZczzy87YurSeR-qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrkeehgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucfkphepuddtle
    drieehrdeffedrudeftdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehi
    ughoshgthhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:l__TXFfDtYIv9dK5oxaq2L2prlqYQh54Urr8jwjz4DQzgcW6VwwcDw>
    <xmx:l__TXID6y60Qy24s0QTUzRFleU70cx5fqY-J2RKjTxT-bNVzus4NVg>
    <xmx:l__TXAj60K9WP0Q70CGdQ0oh0PqTUatq1vHtVOxg-eRwIEWUHfxe6Q>
    <xmx:mf_TXCSgT0h3J_gAMwQWKrDRvO2JHh-BZXkFuivuY-tKhMEMJYpsLA>
Received: from localhost (bzq-109-65-33-130.red.bezeqint.net [109.65.33.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 518F91037C;
        Thu,  9 May 2019 06:23:18 -0400 (EDT)
Date:   Thu, 9 May 2019 13:23:15 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs
 interface
Message-ID: <20190509102315.GA31824@splinter>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
 <1762575.ER2xjzr9E1@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1762575.ER2xjzr9E1@aspire.rjw.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 21, 2019 at 11:20:17PM +0100, Rafael J. Wysocki wrote:
> +static struct attribute *intel_epb_attrs[] = {
> +	&dev_attr_energy_perf_bias.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group intel_epb_attr_group = {
> +	.name = power_group_name,
> +	.attrs =  intel_epb_attrs
> +};
> +
>  static int intel_epb_online(unsigned int cpu)
>  {
> +	struct device *cpu_dev = get_cpu_device(cpu);
> +
>  	intel_epb_restore();
> +	if (!cpuhp_tasks_frozen)
> +		sysfs_merge_group(&cpu_dev->kobj, &intel_epb_attr_group);
> +
>  	return 0;
>  }
>  
>  static int intel_epb_offline(unsigned int cpu)
>  {
> -	return intel_epb_save();
> +	struct device *cpu_dev = get_cpu_device(cpu);
> +
> +	if (!cpuhp_tasks_frozen)
> +		sysfs_unmerge_group(&cpu_dev->kobj, &intel_epb_attr_group);
> +
> +	intel_epb_save();
> +	return 0;
>  }

Hi,

I just booted net-next and got the following NULL pointer dereference
[1] during boot. I believe it is caused by this patch.

CONFIG_PM is disabled in my config which means 'power_group_name' is
defined as NULL. When I enable CONFIG_PM the issue is not reproduced.

Thanks

[1]
[    1.230241] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    1.231043] #PF: supervisor read access in kernel mode
[    1.231043] #PF: error_code(0x0000) - not-present page
[    1.231043] PGD 0 P4D 0
[    1.231043] Oops: 0000 [#1] SMP
[    1.231043] CPU: 0 PID: 12 Comm: cpuhp/0 Not tainted 5.1.0-custom-07273-g80f232121b69 #1392
[    1.231043] Hardware name: Mellanox Technologies Ltd. MSN2100-CB2FO/SA001017, BIOS 5.6.5 06/07/2016
[    1.231043] RIP: 0010:strlen+0x0/0x20
[    1.231043] Code: b5 20 75 eb c6 42 01 00 0f b6 10 f6 82 40 bf 4d b5 20 74 14 48 c7 c1 40 bf 4d b5 48 83 c0 01 0f b6 10 f6 04 11 20 75 f3 c3 90 <80> 3f 00 74 10 48 89 f8
48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 31
[    1.231043] RSP: 0000:ffffb587c0cd3dc8 EFLAGS: 00010246
[    1.231043] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000100
[    1.231043] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    1.231043] RBP: 0000000000000000 R08: ffff8e6137a160c8 R09: 0000000000000000
[    1.231043] R10: 0000000000000000 R11: ffff8e613652ec80 R12: 0000000000000000
[    1.231043] R13: 0000000000000000 R14: ffff8e6137a160c8 R15: ffffffffb4690120
[    1.231043] FS:  0000000000000000(0000) GS:ffff8e6137a00000(0000) knlGS:0000000000000000
[    1.231043] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.231043] CR2: 0000000000000000 CR3: 0000000200409000 CR4: 00000000001006f0
[    1.231043] Call Trace:
[    1.231043]  kernfs_name_hash+0xd/0x80
[    1.231043]  kernfs_find_ns+0x30/0xc0
[    1.231043]  kernfs_find_and_get_ns+0x27/0x50
[    1.231043]  sysfs_merge_group+0x2e/0x100
[    1.231043]  ? __switch_to_asm+0x40/0x70
[    1.231043]  intel_epb_online+0x2a/0x30
[    1.231043]  cpuhp_invoke_callback+0x8f/0x550
[    1.231043]  ? sort_range+0x20/0x20
[    1.231043]  cpuhp_thread_fun+0x9b/0x100
[    1.231043]  smpboot_thread_fn+0xc0/0x160
[    1.231043]  kthread+0x10d/0x130
[    1.231043]  ? __kthread_create_on_node+0x180/0x180
[    1.231043]  ret_from_fork+0x35/0x40
[    1.231043] CR2: 0000000000000000
[    1.231043] ---[ end trace c8ea60276791261c ]---
[    1.231043] RIP: 0010:strlen+0x0/0x20
[    1.231043] Code: b5 20 75 eb c6 42 01 00 0f b6 10 f6 82 40 bf 4d b5 20 74 14 48 c7 c1 40 bf 4d b5 48 83 c0 01 0f b6 10 f6 04 11 20 75 f3 c3 90 <80> 3f 00 74 10 48 89 f8
48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 31
[    1.231043] RSP: 0000:ffffb587c0cd3dc8 EFLAGS: 00010246
[    1.231043] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000100
[    1.231043] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    1.231043] RBP: 0000000000000000 R08: ffff8e6137a160c8 R09: 0000000000000000
[    1.231043] R10: 0000000000000000 R11: ffff8e613652ec80 R12: 0000000000000000
[    1.231043] R13: 0000000000000000 R14: ffff8e6137a160c8 R15: ffffffffb4690120
[    1.231043] FS:  0000000000000000(0000) GS:ffff8e6137a00000(0000) knlGS:0000000000000000
[    1.231043] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.231043] CR2: 0000000000000000 CR3: 0000000200409000 CR4: 00000000001006f0

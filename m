Return-Path: <linux-pm+bounces-38364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0A3C79182
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 13:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1712F34CEA1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 12:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5307433D6E2;
	Fri, 21 Nov 2025 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F5cTtkdK"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2260C79F2;
	Fri, 21 Nov 2025 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729853; cv=none; b=D5AJ5OpkR3/dhQNmsF/C+d51yZF3sc5KEE1vCWtGGaLHtCi/N1ca20+VmSDLuaJQ7wnTwB6ri4/+oocY9FoPfZfBJKfme0Khatd6RdHF5pGo4wdjl9sfjymJS/xguBnFXem9emDoYW1bsIP0TGnx4CD7SDXa0eQ5eC6/GE23+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729853; c=relaxed/simple;
	bh=uQZQOflm9Sc4aylG7aWUMGJjhPExvEzrDVdEJoBwgMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciqOZo7tY3QgqAi0Neq6XGn0GdHcXbc4mrIjnyZzmrPkeY5ddC4C/XnZqN8iJtlYj/jygGSOCq37S3A/EAlwGsw8W2VAJlYF4Jcq2r3oQy8V0Jxnbq+XJAT0j2kpRF+E7OvS/CNVIqrRqInIkKn4NOSGP9gf6hXQCwFmGBrgar0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F5cTtkdK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763729849;
	bh=uQZQOflm9Sc4aylG7aWUMGJjhPExvEzrDVdEJoBwgMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F5cTtkdKBRfaLuXogoJ9NV0r6lI/yLb7H1Urc8nFK601NUZ+hr5mHnwmu3CxQNJbo
	 u4xfVAZAl+EfZr9S2qmfXIYGkIPVVG9/Kp490YLh8cG2qlpwqYU+1n97EHmlSBTaRC
	 +7E3pzvBSFxWN0Af5z+azdXkjJ/lqdL8ktaRmxgw1G4D1BdMg9kDdOIQ7rOIwL8tpG
	 YBUsiNAfbno9MT2a/M4GEasgQUuD91oRNseVRwtBcp2z293tNlwSzNnCsMVIx60zrr
	 irgXDqO6tuAKMbhAXTP6fuhGCJMTIZpMFeZXWxTDMvK+JKsTUwRRd8ART5xjlBL/Oz
	 dIC+11XHh4Tmg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 975BD17E05BE;
	Fri, 21 Nov 2025 13:57:28 +0100 (CET)
Message-ID: <5db8017f-715d-4a30-b6b6-d3360ed53dec@collabora.com>
Date: Fri, 21 Nov 2025 13:57:28 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] pmdomain: mediatek: Refactor bus protection
 regmaps retrieval
To: =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Sjoerd Simons <sjoerd@collabora.com>
Cc: =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 "lihongbo22@huawei.com" <lihongbo22@huawei.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 =?UTF-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
 "mbrugger@suse.com" <mbrugger@suse.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 Nicolas Prado <nfraprado@collabora.com>,
 "macpaul@gmail.com" <macpaul@gmail.com>,
 "wenst@chromium.org" <wenst@chromium.org>,
 =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "y.oudjana@protonmail.com" <y.oudjana@protonmail.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?= <MandyJH.Liu@mediatek.com>
References: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
 <20250805074746.29457-5-angelogioacchino.delregno@collabora.com>
 <a2eae87efe46ebf397bcec3580eb9bc152b80846.camel@collabora.com>
 <be3a2d50-044b-429a-820c-5260c6ce730c@collabora.com>
 <0d8da30aaec2a5dc4bda6d67b640081dcc320f37.camel@mediatek.com>
 <21f51f37-787b-48a5-a871-d61810adff42@collabora.com>
 <3ea6f9cbdd36c0dc17a9627c543cbea26eab635d.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <3ea6f9cbdd36c0dc17a9627c543cbea26eab635d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 29/10/25 16:01, Macpaul Lin (林智斌) ha scritto:
> On Wed, 2025-10-29 at 11:56 +0100, AngeloGioacchino Del Regno wrote:
>>
> 
> [snip]
> 
>> Thanks for the logs! Getting issues on MSDC is really odd because the
>> MSDC
>> controller does *not* use nor have any power domain...
>>
>> I'll take a look at this as soon as I can, anyway.
>>
>> Thanks again,
>> Angelo
>>
>>> [    1.291055] mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=8
>>> arg=000001AA; host->error=0x00000002
>>> [    1.292775] mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=55
>>> arg=00000000; host->error=0x00000002
>>> [    1.294539] mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=55
>>> arg=00000000; host->error=0x00000002
>>> [    1.296293] mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=55
>>> arg=00000000; host->error=0x00000002
>>> ...
>>> [    1.430408] mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=55
>>> arg=00000000; host->error=0x00000002
>>> [    1.433766] mmc0: Failed to initialize a non-removable card
>>> [   22.297240] rcu: INFO: rcu_preempt detected stalls on
>>> CPUs/tasks:
>>> [   22.298723] rcu:     6-...0: (2 ticks this GP)
>>> idle=104c/1/0x4000000000000000 softirq=45/45 fqs=37
>>> [   22.299827] rcu:     (detected by 2, t=5256 jiffies, g=-1051,
>>> q=200
>>> ncpus=8)
>>> [   22.300689] Sending NMI from CPU 2 to CPUs 6:
>>>
>>> Best regards,
>>> Macpaul Lin
>>
>>
> 
> The command retry only happens in the very beginning during linux boot.
> 
> The following rcu_preempt and cpu/task stall are keep appearing until
> poewr off. It is more like cpu not responding or runtime-PM? I've not
> try to disable any power related kernel option yet.
> 

Hello Macpaul,

I have located the source of the issue that is showing on your machine, and
I have sent a fast patch to resolve that.

Please have a look:
https://lore.kernel.org/all/20251121125212.43093-1-angelogioacchino.delregno@collabora.com/

Cheers,
Angelo

> [22649.698912] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [22649.699687] rcu:     5-...0: (0 ticks this GP)
> idle=1b7c/1/0x4000000000000000 softirq=32/32 fqs=976599
> [22649.700835] rcu:     (detected by 1, t=5662102 jiffies, g=-1055,
> q=216 ncpus=8)
> [22649.701728] Sending NMI from CPU 1 to CPUs 5:
> [22659.701734] rcu: rcu_preempt kthread starved for 2495 jiffies! g-
> 1055 f0x0 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=0
> [22659.703592] rcu:     Unless rcu_preempt kthread gets sufficient CPU
> time, OOM is now expected behavior.
> [22659.704746] rcu: RCU grace-period kthread stack dump:
> [22659.705386] task:rcu_preempt     state:I stack:0     pid:15
> tgid:15    ppid:2      task_flags:0x208040 flags:0x00000010
> [22659.706784] Call trace:
> [22659.707097]  __switch_to+0xf0/0x1b0 (T)
> [22659.707590]  __schedule+0x3b0/0xca8
> [22659.708039]  schedule+0x3c/0x120
> [22659.708453]  schedule_timeout+0x8c/0x130
> [22659.708956]  rcu_gp_fqs_loop+0x140/0x6c0
> [22659.709459]  rcu_gp_kthread+0x208/0x258
> [22659.709951]  kthread+0x14c/0x230
> [22659.710365]  ret_from_fork+0x10/0x20
> [22659.710824] rcu: Stack dump where RCU GP kthread last ran:
> [22659.711517] Sending NMI from CPU 1 to CPUs 0:
> [22659.712109] NMI backtrace for cpu 0
> [22659.712117] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.18.0-
> rc3-next-20251028-mtk+modified-04392-g5c921b2c5975 #1 PREEMPT
> [22659.712123] Hardware name: MediaTek Genio 1200 EVK-P1V2-EMMC (DT)
> [22659.712126] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [22659.712130] pc : cpuidle_enter_state+0x2bc/0x720
> [22659.712137] lr : cpuidle_enter_state+0x2b8/0x720
> [22659.712141] sp : ffff800084473d00
> [22659.712143] x29: ffff800084473d00 x28: 0000000000000000 x27:
> ffff0001fef7d8c0
> [22659.712151] x26: 0000000000000001 x25: 0000149be00653eb x24:
> 0000149be01736ef
> [22659.712157] x23: 0000000000000002 x22: ffff0000c2d38880 x21:
> 0000000000000002
> [22659.712163] x20: ffff0000c2d38968 x19: ffff0001fee7e9f8 x18:
> 000000005bd3baae
> [22659.712169] x17: 000000040044ffff x16: 005000f2b5503510 x15:
> 0000000000000000
> [22659.712175] x14: ffff800084487540 x13: ffff80017b8c8000 x12:
> ffff8000816f9830
> [22659.712181] x11: 0000000000000000 x10: 0000000000000000 x9 :
> ffff8000801dc64c
> [22659.712187] x8 : 000000f2b5503510 x7 : 0000000000f0000f x6 :
> 00000000ff0ffff0
> [22659.712193] x5 : ffff80017b8c8000 x4 : 0000000000000000 x3 :
> ffff800084473c10
> [22659.712199] x2 : 000000449d287e7f x1 : ffff800084487540 x0 :
> 0000000000000000
> [22659.712205] Call trace:
> [22659.712207]  cpuidle_enter_state+0x2bc/0x720 (P)
> [22659.712212]  cpuidle_enter+0x40/0x60
> [22659.712219]  do_idle+0x208/0x298
> [22659.712226]  cpu_startup_entry+0x3c/0x50
> [22659.712232]  rest_init+0xfc/0x120
> [22659.712236]  start_kernel+0x7a4/0x920
> [22659.712243]  __primary_switched+0x88/0x98
> 
> Regards,
> Macpaul Lin
>   



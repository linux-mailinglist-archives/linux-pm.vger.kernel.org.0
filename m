Return-Path: <linux-pm+bounces-42551-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNG3JlK2jWl96AAAu9opvQ
	(envelope-from <linux-pm+bounces-42551-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 12:15:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB0D12CE5E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 12:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADF94305DA7F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2172E3B1C;
	Thu, 12 Feb 2026 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ps0HFXzU"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B29B17B50F;
	Thu, 12 Feb 2026 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770894927; cv=none; b=hJsip6bDXalOpLPq06UhDnPdqnNSDDG44YVESFZdqQ8hUBXuQFSFmlT0EqSe8FDnvIshPyR/XFR1BcaQEgS7JB+ffrSNTUqCtJVvsSGxCHRElR2UHlYEGdFRFbn+jA1rIJ80Nu31MTa3xUfjNWd2vxHVgXDmtdw5JtMTAF/S9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770894927; c=relaxed/simple;
	bh=PkNrrH4GKmmT+PDGVmEmRURG14F9GTcvVWwsKASKDEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXodBvT9nFlF4QgUlynbc4KCmYz6bf6VrO79b4b3hhfkJCR7rob88YMz5V/F5ZNVbo1sCo+dRBV54YZWUvZJsew3VNCW8umLUvEQFpFHPPu6ZoDiZoVEKNo9ckQC8E+ka+fhNfqvU6PbiPQ9xvyk8I/j5ts6igcbFxUtcx+rvwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ps0HFXzU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770894918;
	bh=PkNrrH4GKmmT+PDGVmEmRURG14F9GTcvVWwsKASKDEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ps0HFXzUSqRov8F/80F/npFPUEy86MI3CeLp5Bu0UBisLMYSj7UUMDMsYU/gIpH2+
	 eSNhecsxai16QHW33cSZL9DEU2bgG25iYJQpR4LW2GwBAD7StBr5eBgS2VgagX07Eq
	 Pa4pn8sa3UbOMYYU/y5aoc4YlY3ga/KVTjkdYnLD0LSFlaaPfB0o5zXVnArft0hnUZ
	 Uiu6eVaoq4dqTc28hkgQe4QCN4z3Og6otA0m5X3OfFwwHnYW+7cFyuJdHvqOyAytPe
	 3HrPVOyBRYA7ZTphoCmQe60+5MctsshmmOK7qOuY5hQrVfAbdspQjYghYK4kh6I6ra
	 l/pB+lIPMBYaQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CCA2D17E114C;
	Thu, 12 Feb 2026 12:15:17 +0100 (CET)
Message-ID: <8fc93d93-7d99-4d38-9fa8-92951a0acdcf@collabora.com>
Date: Thu, 12 Feb 2026 12:15:17 +0100
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
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 "lihongbo22@huawei.com" <lihongbo22@huawei.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 =?UTF-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 "mbrugger@suse.com" <mbrugger@suse.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 Nicolas Prado <nfraprado@collabora.com>,
 "wenst@chromium.org" <wenst@chromium.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "y.oudjana@protonmail.com" <y.oudjana@protonmail.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?= <MandyJH.Liu@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Sjoerd Simons <sjoerd@collabora.com>
References: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
 <20250805074746.29457-5-angelogioacchino.delregno@collabora.com>
 <a2eae87efe46ebf397bcec3580eb9bc152b80846.camel@collabora.com>
 <be3a2d50-044b-429a-820c-5260c6ce730c@collabora.com>
 <fd071501b66fb332439617f2b270c837043b0862.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <fd071501b66fb332439617f2b270c837043b0862.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42551-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,huawei.com,kernel.org,collabora.com,linaro.org,vger.kernel.org,suse.com,chromium.org,lists.infradead.org,protonmail.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[angelogioacchino.delregno@collabora.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:mid,collabora.com:dkim]
X-Rspamd-Queue-Id: 0AB0D12CE5E
X-Rspamd-Action: no action

Il 12/02/26 08:58, Macpaul Lin (林智斌) ha scritto:
> On Tue, 2025-10-14 at 11:59 +0200, AngeloGioacchino Del Regno wrote:
>>
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> Il 13/10/25 15:41, Sjoerd Simons ha scritto:
>>> Hey,
>>>
>>> On Tue, 2025-08-05 at 09:47 +0200, AngeloGioacchino Del Regno
>>> wrote:
>>>> In preparation to add support for new generation SoCs like
>>>> MT8196,
>>>> MT6991 and other variants, which require to set bus protection on
>>>> different busses than the ones found on legacy chips, and to also
>>>> simplify and reduce memory footprint of this driver, refactor the
>>>> mechanism to retrieve and use the bus protection regmaps.
>>>>
>>>> This is done by removing the three pointers to struct regmap from
>>>> struct scpsys_domain (allocated for each power domain) and moving
>>>> them to the main struct scpsys (allocated per driver instance) as
>>>> an array of pointers to regmap named **bus_prot.
>>>
>>> Trying to boot v6.18.0-rc1 on a Genio 700 EVK using the arm64
>>> defconfig,
>>> ends up hanging at boot (seemingly when probing MTU3 and/or mmc,
>>> but that
>>> might be a red herring).
>>>
>>> Either reverting this patch *or* having CONFIG_MTK_MMSYS builtin
>>> rather
>>> then a module seems to solve that.
>>>
>>
>> Thanks for the report.
>>
>> This is not a problem with this patch specifically, but surely some
>> race condition
>> that was already present before and that does get uncovered with this
>> one in some
>> conditions.
>>
>> Without the devicetree updates (which are not upstream yet) this
>> patch is
>> fully retaining the legacy functionality 1-to-1.
>>
>> I'll check what's going on ASAP.
>>
>> Cheers,
>> Angelo
>>
> 
> This issue also happened on mt8195. I've done bisect on linux-next
> master with mt8195-genio-1200-evk board.
> The result shows c29345fa5f66bea0790cf2219f57b974d4fc177b is the first
> bad commit.
> 
> I cannot simply revert this commit since there are some dependencies
> commits.
> 
> I'm not sure if there are any API or flag change would
> affect interaction between the pm-domain driver and scp firmware.

I'm 99% sure that the SCP firmware has nothing to do with this - but then
even if it did, there's some quirk to be uncovered and properly handled.

So - if it is (again, most probably not) a firmware issue, it was only a
matter of time until this situation would've happened. It's pretty common
to see two wrongs making one thing right (but in 100% of the cases it does
eventually break).

> Just a remind it is hard for MediaTek to update scp firmware for a
> mass production chip. Each scp firmware seems specifically designed for
> each chip separately which leads the API might be changed between each
> chip.
> 

Adding Louis-Alexis to the loop;

Louis, can you please try to reproduce this one on any of our boards?
I can't seem to be able to reproduce here.

Cheers,
Angelo

> The error log occurs on emmc at first and than rcu_preempt happens.
> [    1.291055] mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=8
> arg=000001AA; host->error=0x00000002
> [    1.292775] mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=55
> arg=00000000; host->error=0x00000002
> [    1.294539] mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=55
> arg=00000000; host->error=0x00000002
> [    1.296293] mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=55
> arg=00000000; host->error=0x00000002
> ...
> [    1.430408] mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=55
> arg=00000000; host->error=0x00000002
> [    1.433766] mmc0: Failed to initialize a non-removable card
> [   22.297240] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [   22.298723] rcu:     6-...0: (2 ticks this GP)
> idle=104c/1/0x4000000000000000 softirq=45/45 fqs=37
> [   22.299827] rcu:     (detected by 2, t=5256 jiffies, g=-1051, q=200
> ncpus=8)
> [   22.300689] Sending NMI from CPU 2 to CPUs 6:
> ...
> 
> Best regards,
> Macpaul Lin
> 



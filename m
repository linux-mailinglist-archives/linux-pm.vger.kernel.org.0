Return-Path: <linux-pm+bounces-26311-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B79A9E5E5
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 03:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E02F1898C2B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 01:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA0B78F51;
	Mon, 28 Apr 2025 01:46:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C178F3A;
	Mon, 28 Apr 2025 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745804766; cv=none; b=q8Dslv3ei98zFCCdz0BNlVj8j5ofnzVsLlNBAc43LM+qVWYAmPVXVztjnc+/9SocwIctID0YV9ntUGaQ5FPmAE8L7RvGoahWKOZozDjBN79hpxChIbVLshupUsbhJBxKgj/b2LtYnYNK4BTOrajGDWf8J4yo/zHKBcNILGsuP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745804766; c=relaxed/simple;
	bh=rYzY7gFszM0NTeia4+X10ntaNKfRj91C/mMCa5zWimg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDxP/ELDJtRG3OKfs9hW8ODorVdJmIfJhbg1EdalGuc+1EHU19tujs6nf1kYFs8myjSTZOcd0DeMeDkA8EQ5W8n4b0cul2eY2Gfk1iiz9n/+e9cz5p3dH/AdR/rQRheBLclUmrMDvq4SCV1q3u5UHpAEG8o7C+dZyie/P35zlLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 83148fc823d211f0b29709d653e92f7d-20250428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:d4566bb6-7311-4dec-ae06-1c685e1af6ef,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:5e9ad0bafa72133953d51cd63cc4738e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 83148fc823d211f0b29709d653e92f7d-20250428
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1229247605; Mon, 28 Apr 2025 09:45:49 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 93ABBE006100;
	Mon, 28 Apr 2025 09:45:49 +0800 (CST)
X-ns-mid: postfix-680EDDCD-5078585
Received: from [10.42.13.21] (unknown [10.42.13.21])
	by mail.kylinos.cn (NSMail) with ESMTPA id E6AEFE0080FF;
	Mon, 28 Apr 2025 09:45:48 +0800 (CST)
Message-ID: <ea6bfcbc-7665-4808-8188-b444d425b516@kylinos.cn>
Date: Mon, 28 Apr 2025 09:45:48 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PM: EM: Fix potential division-by-zero error in
 em_compute_costs()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael@kernel.org, Yaxiong Tian <iambestgod@qq.com>,
 Lukasz Luba <lukasz.luba@arm.com>
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
 <tencent_2256A7C02F7849F1D89390E488704E826D06@qq.com>
 <1ca192e6-3a45-45c6-b4f0-be6a89eaf192@arm.com>
 <tencent_91D93A837FF94A06C7FE8492461472B86D09@qq.com>
 <1a7f6279-c21c-4d6f-a5ee-48766b1ca34e@arm.com>
 <tencent_F59412B7B14221D391FE1C1ADBAF4EBD5F07@qq.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <tencent_F59412B7B14221D391FE1C1ADBAF4EBD5F07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/4/18 09:26, Yaxiong Tian =E5=86=99=E9=81=93:

> =E5=9C=A8 2025/4/17 21:27, Lukasz Luba =E5=86=99=E9=81=93:
>> I have run with the GPU EM registered in the boot:
>>
>> -------------------------------------------------------
>> [=C2=A0=C2=A0=C2=A0 2.753333] panfrost ff9a0000.gpu: EM: created perf =
domain
>> [=C2=A0=C2=A0=C2=A0 2.759863] panfrost ff9a0000.gpu: mali-t860 id 0x86=
0 major 0x2=20
>> minor 0x0 status 0x0
>> [=C2=A0=C2=A0=C2=A0 2.768530] panfrost ff9a0000.gpu: features: 0000000=
0,00000407,=20
>> issues: 00000000,24040400
>> [=C2=A0=C2=A0=C2=A0 2.777678] panfrost ff9a0000.gpu: Features: L2:0x07=
120206=20
>> Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0=
x7
>> [=C2=A0=C2=A0=C2=A0 2.780746] mmc_host mmc2: Bus speed (slot 0) =3D 14=
8500000Hz (slot=20
>> req 150000000Hz, actual 148500000HZ div =3D 0)
>> [=C2=A0=C2=A0=C2=A0 2.790905] panfrost ff9a0000.gpu: shader_present=3D=
0xf l2_present=3D0x1
>>
>> root@arm:~# cat /sys/kernel/debug/energy_model/ff9a0000.gpu/flags
>> 0x1
>> root@arm:~# grep . /sys/kernel/debug/energy_model/ff9a0000.gpu/ps*/*
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:200000/cost:0
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:200000/frequency:200000
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:200000/inefficient:1
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:200000/performance:0
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:200000/power:404250
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:300000/cost:0
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:300000/frequency:300000
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:300000/inefficient:1
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:300000/performance:0
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:300000/power:606375
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:400000/cost:0
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:400000/frequency:400000
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:400000/inefficient:1
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:400000/performance:0
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:400000/power:808500
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:600000/cost:0
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:600000/frequency:600000
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:600000/inefficient:0
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:600000/performance:0
>> /sys/kernel/debug/energy_model/ff9a0000.gpu/ps:600000/power:1505790
>>
>> --------------------------------------------------------
>>
>> The EM for the GPU is not modified during the boot like the CPUs'
>> EM are, thus this code is not triggered. Although, the API is
>> open and in theory the GPU EM can be modified at runtime
>> as well and it will reach that em_compute_costs() issue
>> with 'performance' field having value 0.
>>
>> So this v4 patch would be needed in this case.
>>
>> Please re-send this v4 patch as a completely new message.
>>
>> Thanks for looking at that code path and the fix for potential
>> issue.
>>
>> You can also add my:
>>
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>>
>> Regrds,
>> Lukasz
>
> Got it - patch resent with Reviewed-by.
>
> https://lore.kernel.org/all/tencent_7F99ED4767C1AF7889D0D8AD50F34859CE0=
6@qq.com/=20
>

Hi Rafael:

This bug appears to be stalled. Are there any alternative fixes we could=20
consider?



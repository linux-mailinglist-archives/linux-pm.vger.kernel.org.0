Return-Path: <linux-pm+bounces-33605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEFDB3F5BF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 08:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE42205C5B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 06:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B802E1F0A;
	Tue,  2 Sep 2025 06:43:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F012E540C;
	Tue,  2 Sep 2025 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756795403; cv=none; b=iG5KB642WPnYIf+d7+jwqv4GnRqdAq4gYnQoE+xTzp1cNTs4qU0ePCpyIjNbMcWuptuKDvnBlkh+JvvahDUkM4s59dlu72qTVjJrYjUsYr9TcHCg+EDkPVf8Yz5W27/Ps4OkSH8e9Cl0Virwp0iOc0pXCOiCybJgiOFHUtjPtIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756795403; c=relaxed/simple;
	bh=0osj3VmMlfU9dKszOIeAlMHSZRgQtv6OleFIcfWZFCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2YnQ6AmhrFcF+o8jA1ZlsyCJsTryxungyVKhqNpWr8b42CW3gkewM7iK7pf0miOfzbtmAWIjUVSWH6SMNafwhir6KmAN9GnRQWMqRL4QMWMGRA8sy6eY0YcM4HedUELTqgzDbueP+Gwk5FbJJilDTEo3nI9MK+t5EXHHDpkIPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1a8ef74a87c811f0b29709d653e92f7d-20250902
X-CID-CACHE: Type:Local,Time:202509021406+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e043e921-4bb4-48c6-b031-630dc9eaff29,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:e4e9c6f290b3746950f8ceea0acc2412,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1a8ef74a87c811f0b29709d653e92f7d-20250902
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 678506594; Tue, 02 Sep 2025 14:43:15 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 89299E008FA3;
	Tue,  2 Sep 2025 14:43:15 +0800 (CST)
X-ns-mid: postfix-68B69203-467683221
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 03174E008FA2;
	Tue,  2 Sep 2025 14:43:14 +0800 (CST)
Message-ID: <124d4b02-5268-4919-aba8-eab7945fff28@kylinos.cn>
Date: Tue, 2 Sep 2025 14:43:14 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] cpufreq: sh: drop redundant freq_table argument
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
 zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250901112551.35534-1-zhangzihuan@kylinos.cn>
 <20250901112551.35534-3-zhangzihuan@kylinos.cn>
 <20250902054009.rhqu4ki3bl4kr5a7@vireshk-i7>
 <34092883-c04d-4dbb-a756-eac89fbe6f3e@kylinos.cn>
 <20250902062349.cxg5377chzqtb76r@vireshk-i7>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250902062349.cxg5377chzqtb76r@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/2 14:23, Viresh Kumar =E5=86=99=E9=81=93:
> On 02-09-25, 14:06, Zihuan Zhang wrote:
>> I also noticed that in some drivers like acpi-cpufreq.c, if freq_table
>> allocation fails, the driver won=E2=80=99t be registered at all.
>>
>> In such cases,
>>
>> should the NULL check be done inside the core helper functions, or sho=
uld it
>> be left to the drivers?
> Not all drivers need a freq-table and so it is fine for them to not
> have one. This driver looks like can work without a freq table too.
>
Understood, Thanks!


Return-Path: <linux-pm+bounces-32392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5C1B261C3
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 12:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1F51B6590D
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2974D2F7441;
	Thu, 14 Aug 2025 09:57:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097D2F6599;
	Thu, 14 Aug 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165443; cv=none; b=tR9hGncgsso/c8snj/3anlBu8QPFQRlGBc69iVU+JiyF5z/+NQfodkplhsgkmNBojE7EktVWf5b0IX8SNtiJ4qwyZkyxzvn5FVUfJtbnCU5aw/adK8Zy9Qxx43HsZuJFObho1Y7UrO8gZtBK63ITGYmBralyaHMdnRV6Hors0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165443; c=relaxed/simple;
	bh=AFmQW3s817yYNoHLbcU7I5ZtCWhEg4P0VV83vq1w460=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPqqScZi8Mf1BTSYe5a5+01Hj/pQmo4UjNSKNUNw9fgkGgilSygZxrE7ZGDhz/SLTFyculOA7cnR74hC+lcvV8YNzVCn5qkCxFK2UmZ9eH+wGjDWA2UMJ4k8zkwbe00gAlOLc5IWT3IRuUAPKVQ4RtSM00VawLqsxb9Igiakwko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0e07284e78f511f0b29709d653e92f7d-20250814
X-CID-CACHE: Type:Local,Time:202508141724+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:9f6f0721-ee35-4d2f-b97d-82be5c063267,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:4e9b3f680a37dbdb16fbf95a0e950642,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0e07284e78f511f0b29709d653e92f7d-20250814
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2136356546; Thu, 14 Aug 2025 17:57:14 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 6E6B7E008FA5;
	Thu, 14 Aug 2025 17:57:14 +0800 (CST)
X-ns-mid: postfix-689DB2F8-408393812
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id ECD3FE008FA3;
	Thu, 14 Aug 2025 17:57:11 +0800 (CST)
Message-ID: <711f7b99-e881-4c55-b748-23ac38770ff2@kylinos.cn>
Date: Thu, 14 Aug 2025 17:57:11 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpufreq: Return current frequency when frequency table
 is unavailable
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
 zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250814085216.358207-1-zhangzihuan@kylinos.cn>
 <20250814090201.pdtvxqq3st65iooq@vireshk-i7>
 <3f901678-c75e-48ac-985a-2834f9ba4c8f@kylinos.cn>
 <20250814093149.ob36l2gxo33snbac@vireshk-i7>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250814093149.ob36l2gxo33snbac@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/8/14 17:31, Viresh Kumar =E5=86=99=E9=81=93:
> On 14-08-25, 17:24, Zihuan Zhang wrote:
>> I just feel that it might not be ideal to set a frequency when the fre=
quency
>> table is unavailable.
>>
>> Perhaps adding a log or warning when the frequency table is missing co=
uld be
>> a better approach.
> There are a lot of drivers that don't provide a frequency table, i.e.
> drivers with setpolicy() or target() callbacks. Only the
> target_index() ones provide a freq table.
>
Thank you for the explanation! I now understand that some drivers do not=20
require a frequency table to set the frequency.

I will drop it.

Best regards,
Zihuan Zhang


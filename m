Return-Path: <linux-pm+bounces-34132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C87B4859C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 09:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8554417F1AF
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B5E2EDD7D;
	Mon,  8 Sep 2025 07:36:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548092E9741;
	Mon,  8 Sep 2025 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317009; cv=none; b=Pon51YqNsttl40oTup9XjhNikpW63SovE8lReBTYykxZspIkQvqA5/d4TPJ6Hf8BtGK1v7A2SIwUnvkQ8Q1rCl1iN93z37JwepfRSJ30gEHcaQv9aqFR44IWCiImooxRIyNFoSmPAzF/kQUM66sbAh976VZZhG+2TvTbDz6Sab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317009; c=relaxed/simple;
	bh=rhMUG4/AcKJ0wBBqdSgZc045WqEYWJre1gSPDfVVHSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHXdtgl0DWp1t3wlchQ/RbsD+gDaLRmWTrZ8deSmImHXWJH+6NYYW2b3pVZI3YLsgrt6sV3ZsSwffmhDAO4gjvUh/r+QHmfNMV74Ab4U0hxh+AaRogG0cME9iLi5fnCxMadEaZQah6zCQjVMKj10QMEcliagETPxKLpmMPi0dkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8cd7b37e8c8611f0b29709d653e92f7d-20250908
X-CID-CACHE: Type:Local,Time:202509081451+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:5df52faf-dd0c-4de2-8e8b-19184aa7ff79,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:f6a7994fb7f88b258705a5b9368f90b6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8cd7b37e8c8611f0b29709d653e92f7d-20250908
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 909605093; Mon, 08 Sep 2025 15:36:36 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 395D5E008FA7;
	Mon,  8 Sep 2025 15:36:36 +0800 (CST)
X-ns-mid: postfix-68BE8784-12002628
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id A56AEE008FA3;
	Mon,  8 Sep 2025 15:36:35 +0800 (CST)
Message-ID: <fecd3bf1-c8a5-4514-b3be-311a09abe5a9@kylinos.cn>
Date: Mon, 8 Sep 2025 15:36:34 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] cpufreq: Always enforce policy limits even without
 frequency table
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
 Saravana Kannan <saravanak@google.com>, zhenglifeng
 <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-3-zhangzihuan@kylinos.cn>
 <20250904044812.cpadajrtz3mrz2ke@vireshk-i7>
 <540469c3-9bc5-444e-87da-95dc27fc481b@kylinos.cn>
 <20250904053700.abdkh23zwi5x65do@vireshk-i7>
 <e91bd1e9-8db4-4923-92fe-52893623487e@kylinos.cn>
 <20250908061333.rwzq5dj4nxlav6x5@vireshk-i7>
 <cbe36377-6f92-4913-8cd7-087e718af368@kylinos.cn>
 <20250908065551.d5jhp5ejix4fzgd2@vireshk-i7>
 <67b55ae1-60b0-4d54-8220-59f7e3ba7c29@kylinos.cn>
 <20250908071920.f6ppfr7shy2cb2wg@vireshk-i7>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250908071920.f6ppfr7shy2cb2wg@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/8 15:19, Viresh Kumar =E5=86=99=E9=81=93:
> On 08-09-25, 15:08, Zihuan Zhang wrote:
>> One idea we are considering is to check whether driver->verify points =
to
>> cpufreq_generic_frequency_table_verify and use that as a heuristic to
>> enforce the presence of target_index():
>>
>>  =C2=A0((driver_data->verify =3D=3D cpufreq_generic_frequency_table_ve=
rify) !=3D
>> !!driver_data->target_index)
>>
>> I haven=E2=80=99t tested this approach yet, so I=E2=80=99m not sure if=
 it will be fully
>> reliable.
> I don't this is a good idea. It isn't necessary for any driver to use
> the generic functions.
>
Understood, I thinks there is some reason that the two separate=20
verification functions exist.

By the way, Do you think it=E2=80=99s necessary to add some defensive che=
cks=20
during driver registration?

For instance, we could enforce that a driver cannot implement both=20
has_target and has_target_index at the same time.



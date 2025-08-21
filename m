Return-Path: <linux-pm+bounces-32799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C405B2F524
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 12:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1337B5A0262
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 10:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E03A2D374D;
	Thu, 21 Aug 2025 10:20:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D124A06D;
	Thu, 21 Aug 2025 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771659; cv=none; b=qp/HnoTqa10uZ3C2U5IG0PM8QcliLeVpQJokYOSp86uBV8x5+7qPfOueZ+KUE+OMYd6a/mdRlFhaNcJWfHLfMTE0eq4GaziRBbnHk9dhk4fUrx6YE3ybb3EtJRvuau0tP8CSFByw/I3+gFXXKgy/KT0hb0VJf/nOf5kBuQ8QxP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771659; c=relaxed/simple;
	bh=khuc9araJn2/64bJVce4KTDXKnYR0AH07r9m064BpOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FlLAsjXdTAfHHiEF9dKBvB2+poAqtkViiIgowWyE2skkSaYxjsbEVu7ztHI1f+dtPh92u+MkalrBLOl3Q5Jh8TxIkcal1iJdQK8mRb2e65ApFqa/CnEfY+upYpG5TZ9RRUzG5fVzm6FLl16o2T6TESfRYf38HzMY6bQkki+TQic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 827d94e67e7811f0b29709d653e92f7d-20250821
X-CID-CACHE: Type:Local,Time:202508211745+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b172de88-91c3-497c-97bd-dd2e2cc7a02d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:183395a8de58174fc9f9b764b8bf8282,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 827d94e67e7811f0b29709d653e92f7d-20250821
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1476147086; Thu, 21 Aug 2025 18:20:49 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id AF39FE008FA3;
	Thu, 21 Aug 2025 18:20:49 +0800 (CST)
X-ns-mid: postfix-68A6F301-63201223
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 3C1C8E008FA2;
	Thu, 21 Aug 2025 18:20:49 +0800 (CST)
Message-ID: <0f420eec-d171-4d23-8b69-93c38f8938f1@kylinos.cn>
Date: Thu, 21 Aug 2025 18:20:48 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq: simplify setpolicy/target check in driver
 verification
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
 zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250821090020.167786-1-zhangzihuan@kylinos.cn>
 <20250821090020.167786-3-zhangzihuan@kylinos.cn>
 <20250821091716.x7y76wfvvez6g7el@vireshk-i7>
 <b72c666e-b286-45b6-92d9-7c6dfe5753eb@kylinos.cn>
 <20250821095634.t6hfkmfkzjwsy4se@vireshk-i7>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250821095634.t6hfkmfkzjwsy4se@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/8/21 17:56, Viresh Kumar =E5=86=99=E9=81=93:
> On 21-08-25, 17:45, Zihuan Zhang wrote:
>>> I would rather do:
>>>
>>> 	(!!driver_data->setpolicy =3D=3D (driver_data->target_index || drive=
r_data->target))
>> The current version of the code is much better and safer.
> You can actually do this.. This first converts
> `driver_data->setpolicy` to bool and then compares both of them, and
> both can't be true or false.

Thanks. I will.



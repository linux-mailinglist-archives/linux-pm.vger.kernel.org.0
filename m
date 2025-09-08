Return-Path: <linux-pm+bounces-34130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490FEB484CB
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 09:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8C53A9968
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 07:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A982E1F11;
	Mon,  8 Sep 2025 07:09:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5533B7A8;
	Mon,  8 Sep 2025 07:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315350; cv=none; b=HUWp/2HhCTH7ci2jBqRTBijJaKnkpoclSc6uGm5wVUPjT5KBx7PjpOlj56puLcaU8fWeOiHV7w7rxKtXLsAjZy+rWdzf/HTOkGNBjrikB/UCaL3hCoA1rpyHFAsTxzkBANXO2G3Vl5+sOeBJvT2quDHRa39dR1OqpLblLEFs/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315350; c=relaxed/simple;
	bh=ILeYBopdnA00d/cPRukls2d6V0ls3WcQ7uIMlRk2eEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqPczxB1sgM5mRJgafy7CsWgFtrPtTILd1hwysVbP0nsQWoIARcsKIH8uOHI5ZcsPtn4RcFglX9tOw1hPGLsmQv4AgwMVXznbUm6k/2rWKJ2LprJ5EjvrEOCH1pbAiRIDv26fUQSQjXUg0rzNyK0QBMHoh7uHMCL7/rBweLbe7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ac9e8fec8c8211f0b29709d653e92f7d-20250908
X-CID-CACHE: Type:Local,Time:202509081451+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:741e69a4-7eac-423f-af7f-03fd36c51edc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:f6a7994fb7f88b258705a5b9368f90b6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ac9e8fec8c8211f0b29709d653e92f7d-20250908
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 930198300; Mon, 08 Sep 2025 15:08:51 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 69711E008FA4;
	Mon,  8 Sep 2025 15:08:51 +0800 (CST)
X-ns-mid: postfix-68BE8103-330781192
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id CAB86E008FA3;
	Mon,  8 Sep 2025 15:08:50 +0800 (CST)
Message-ID: <67b55ae1-60b0-4d54-8220-59f7e3ba7c29@kylinos.cn>
Date: Mon, 8 Sep 2025 15:08:50 +0800
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
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250908065551.d5jhp5ejix4fzgd2@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/8 14:55, Viresh Kumar =E5=86=99=E9=81=93:
> On 08-09-25, 14:51, Zihuan Zhang wrote:
>> We are currently considering moving the check that ensures a driver
>> providing a freq_table also implements target_index() into the driver
>> registration path.
> That won't work AFAIU. The freq table is initialized during
> policy->init and that's not done at the time of registration.

One idea we are considering is to check whether driver->verify points to=20
cpufreq_generic_frequency_table_verify and use that as a heuristic to=20
enforce the presence of target_index():

 =C2=A0((driver_data->verify =3D=3D cpufreq_generic_frequency_table_verif=
y) !=3D=20
!!driver_data->target_index)

I haven=E2=80=99t tested this approach yet, so I=E2=80=99m not sure if it=
 will be fully=20
reliable.


>> This way, freq_table.c no longer needs to defensively check for NULL
>> pointers.
>>
>> Additionally, we are thinking about merging the two related APIs into =
a
>> single one. Do you think this is a good idea?
> Which ones ? target/target_index ? I am not sure if that can be done.

If this approach=20
works,=C2=A0=C2=A0cpufreq_generic_frequency_table_verify=C2=A0and=C2=A0cp=
ufreq_frequency_table_verify=20
should be the same because we dont't need to check pointer is NULL=C2=A0 =
in=20
freq_table.c.

> We are fine with improvements generally, but please make sure whatever
> you send doesn't break existing users. That will help saving some of
> our review time.





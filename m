Return-Path: <linux-pm+bounces-32388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49095B260E4
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 11:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064271C234FD
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 09:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8E52E92CD;
	Thu, 14 Aug 2025 09:24:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4027FD76;
	Thu, 14 Aug 2025 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163489; cv=none; b=JeCID+OGJW7cs1WJpOfO3dotx2ZqLEL1sLNwK3aQr1RmpFnYLzwmj8pZTblotq6MCRxkKltEFGzAbvr38kouwLh6TbtSE/rxyP3+Oo2H4DLQ8Vf5IhK7efZvRw2R3WYcdrOgqNSQKYdIiPGwtxp8DQYOKNwGS0TpJF2zP3sAcQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163489; c=relaxed/simple;
	bh=YxB9QQd/l0CoRAo14FnGKrVxm4Mi8uhaqKkyvouUgDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSxKLoGYZXE+G1hAx0XPk190/lQIY1Ky3Ssi7M6IfTzghU5l9NroFJAUmFHV+wgy19NMjjc/K2BF5HUPm6Mejn/8mXr6i8Ym13AL9C7MNESax2Wn4m1UMx0okWy8leDBuX/gELKe97QMoKsf6klYpBIcaFaLaKH23AW7bZDWaxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 80e2862e78f011f0b29709d653e92f7d-20250814
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:353daeb1-bbb7-4731-b7de-538d556ff993,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:4e9b3f680a37dbdb16fbf95a0e950642,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 80e2862e78f011f0b29709d653e92f7d-20250814
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1219007302; Thu, 14 Aug 2025 17:24:39 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 9D6DDE008FA5;
	Thu, 14 Aug 2025 17:24:39 +0800 (CST)
X-ns-mid: postfix-689DAB57-548626715
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 1BE24E008FA3;
	Thu, 14 Aug 2025 17:24:39 +0800 (CST)
Message-ID: <3f901678-c75e-48ac-985a-2834f9ba4c8f@kylinos.cn>
Date: Thu, 14 Aug 2025 17:24:38 +0800
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
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250814090201.pdtvxqq3st65iooq@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/8/14 17:02, Viresh Kumar =E5=86=99=E9=81=93:
> On 14-08-25, 16:52, Zihuan Zhang wrote:
>> In cases where the CPU frequency table (freq_table) is not available,
>> the __resolve_freq() function will now return the current frequency
>> (policy->cur) instead of the requested target frequency. This ensures
>> that the system doesn't return an invalid or uninitialized frequency
>> value when frequency scaling is not supported or not initialized.
>>
>> This change improves the stability of the frequency scaling logic when
>> the CPU frequency table is not populated, preventing errors related
>> to unavailable frequency tables.
> Is there a real problem you are facing ? Or a code that path can do
> some harm ? I think this patch may end up breaking users.

Haven=E2=80=99t yet.

I just feel that it might not be ideal to set a frequency when the=20
frequency table is unavailable.

Perhaps adding a log or warning when the frequency table is missing=20
could be a better approach.



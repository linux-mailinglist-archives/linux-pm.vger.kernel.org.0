Return-Path: <linux-pm+bounces-34125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F7B48476
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 08:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AC7189F698
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 06:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD4B2E2299;
	Mon,  8 Sep 2025 06:51:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF872DE71C;
	Mon,  8 Sep 2025 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314310; cv=none; b=fWpM700K9KE2VOEaPh8w28TlOhD4h3wDM7ddZ7P28PBhGe445IS49tBj4nopIwMWG49ToYeLeuoTw/0RTvemp5IOYDtEBj9IxhCgdcQOtmc+j4+S7LKzhgimjGYbkcX4V961KiIRRricQExDxWPCsQ53vHtLZAeOO/mCaU1w378=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314310; c=relaxed/simple;
	bh=oRwcKR3Rnw7wjg+ZTVkb/70S0fOkg6QBMnIuoZHQwmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIzRk9Q4HfHEGAM+pv83qPf2Z6EVtxkVidur6uS5TtR/6troLRpskp9CxD6uMrcv2I2XaeCdBOAOkSFuF4QLUh5vXjDMS0mQodjuE724Veg8qt1lCMZdYSxB0XUUue7+ytTllscQXqSOs379u3uDMVE92Lg2AGYjB0HROUpSmXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 454919548c8011f0b29709d653e92f7d-20250908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:8e69cfff-4f9f-4122-a335-cb4fa4821e28,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:f6a7994fb7f88b258705a5b9368f90b6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 454919548c8011f0b29709d653e92f7d-20250908
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1382312738; Mon, 08 Sep 2025 14:51:39 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 422F7E008FA4;
	Mon,  8 Sep 2025 14:51:39 +0800 (CST)
X-ns-mid: postfix-68BE7CFB-151394164
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 77254E008FA3;
	Mon,  8 Sep 2025 14:51:38 +0800 (CST)
Message-ID: <cbe36377-6f92-4913-8cd7-087e718af368@kylinos.cn>
Date: Mon, 8 Sep 2025 14:51:37 +0800
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
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250908061333.rwzq5dj4nxlav6x5@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/8 14:13, Viresh Kumar =E5=86=99=E9=81=93:
> On 04-09-25, 13:48, Zihuan Zhang wrote:
>> I understand your point about the potential duplicate call to
>> cpufreq_verify_within_cpu_limits() for drivers with a valid freq-table=
.
>> However, in the third patch of this series, we removed the call to
>> cpufreq_generic_frequency_table_verify() from the table_verify path.
> Yeah, I missed that.
>

We are currently considering moving the check that ensures a driver=20
providing a freq_table also implements target_index() into the driver=20
registration path.

This way, freq_table.c no longer needs to defensively check for NULL=20
pointers.

Additionally, we are thinking about merging the two related APIs into a=20
single one. Do you think this is a good idea?



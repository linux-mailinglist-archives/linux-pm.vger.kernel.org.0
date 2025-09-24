Return-Path: <linux-pm+bounces-35265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5375BB97F6B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 03:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EFE1AE2329
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 01:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1431F03D7;
	Wed, 24 Sep 2025 01:00:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2361F7098;
	Wed, 24 Sep 2025 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675629; cv=none; b=KG/AnWUsaiFN1KG01Lk2eSqvSaRCJekAAODzm+TGkAptBkbgJ1ZMRL3REDaH7EjGpOk2VEMzSI4uwR+MuFbP1U7tT8YzQ/tOrOnZafpAd4iqbVEWj9OZ3KLjTjKQ3vIPuudSiOBwrjtE0tWm/UP2NBLv7ks1ZDIKUNUT/FlKpmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675629; c=relaxed/simple;
	bh=Nk1g4ku8dxZZgN0tf4Jk2H4C9o1qccWvhVZSs0ZWgXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4aPRFejZKOf2VzK6sQ9EjSFej4c5PM0GBdqeSEFesJZ3lIia3C+wOvvr4w+E0M1z1htb4Lj5n0Hc9rU5G1ZsBKvAVFNQe7uTZWkd9JbKicDRR5SIS5KCuIn+SCJRRxVNKVvqBEgnOTY5SyxdFCw3c9QDyDzW36doaXH1mcRABI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d734ac6c98e111f08b9f7d2eb6caa7cf-20250924
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:20483527-f023-413b-822e-9f124f81867f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:fa1afb3533ded305ab9cc63470a62c62,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d734ac6c98e111f08b9f7d2eb6caa7cf-20250924
X-User: zhangzihuan@kylinos.cn
Received: from [172.25.120.24] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 373270739; Wed, 24 Sep 2025 09:00:19 +0800
Message-ID: <b10d1dd4-fa10-4f45-b395-d62a085eb63a@kylinos.cn>
Date: Wed, 24 Sep 2025 09:00:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: Replace pointer subtraction with iteration
 macros
To: Dhruva Gole <d-gole@ti.com>, "Rafael J . wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250923075553.45532-1-zhangzihuan@kylinos.cn>
 <20250923090910.6ojsyi333ijyjmmo@lcpd911>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250923090910.6ojsyi333ijyjmmo@lcpd911>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/9/23 17:09, Dhruva Gole 写道:
>
> Usually, it isn't advised to touch code that's not strictly relevant to
> your patch. However since this seems like a minor fixup it's fine by
> me... Upto Rafael whether he prefers to have/not have this unrelated change.
>
> But atleast mention in your commit message that you're also removing the
> initialization from cpufreq_table_index_unsorted as part of some minor cleanup
> (which seems kinda unnecessary to me TBH in the first place)
>

Thank you all ！



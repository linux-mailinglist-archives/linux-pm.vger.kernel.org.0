Return-Path: <linux-pm+bounces-33823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6C5B43927
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 12:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFF2568301
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13572E54D6;
	Thu,  4 Sep 2025 10:47:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46B62D3EE1;
	Thu,  4 Sep 2025 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982853; cv=none; b=gOwlUx4QpV9VM/YLkd5wnuixYcRLNXMFdzTyaQkxan+1GuhR6mOivI5p/Msf9dpAnnS7UGTKVNY1NRJhREZz2yw6aHZ9H34DaYqCiI1E5XHPah5gEfmIquuj+hguHluBmT3Pf3EqnpuxXWw/c4GLoKSSW8a/vvxGt/n28XLTiU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982853; c=relaxed/simple;
	bh=Gj5asRFR6sSZAb0fMHZ8hSd9lHxZe6gkdrfTf1S3qE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoJTgALL2azkgJaop5Q7H2ZV2GQLxZPXbPFpb5RFzLrAQu3gXFtUt5UUomk7tC2kQyNylHWzzRvLcw37t6QAc0gApkumRe45qWNgZ08yArtSed7wDvcmgiOO6VF2pY9YvjrvILAdN+EK1tdoqXIcp3okVm5zaY1hAYfdIZ/38ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 895d9cb6897c11f0b29709d653e92f7d-20250904
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:ada2efff-1531-418a-8421-c63ffc6a35d1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:ea9584713e4b478c9bd0e44140e46635,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|817,TC:nil,Content:-10|-
	8|-5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 895d9cb6897c11f0b29709d653e92f7d-20250904
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1198488497; Thu, 04 Sep 2025 18:47:22 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 0A35FE008FA5;
	Thu,  4 Sep 2025 18:47:22 +0800 (CST)
X-ns-mid: postfix-68B96E39-8502081323
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 77002E008FA2;
	Thu,  4 Sep 2025 18:47:21 +0800 (CST)
Message-ID: <54bcd1e6-aa6d-425d-8ba1-575ae0b67823@kylinos.cn>
Date: Thu, 4 Sep 2025 18:47:20 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpufreq: core: Rearrange variable declarations
 involving __free()
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <4691667.LvFx2qVVIh@rafael.j.wysocki>
 <20250904041433.v675m7u36sxfeuov@vireshk-i7>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250904041433.v675m7u36sxfeuov@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> On 03-09-25, 16:56, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Follow cleanup.h recommendations and always define and assign variables
>> in one statement when __free() is used.
>>
>> No intentional functional impact.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>   drivers/cpufreq/cpufreq.c |   27 +++++++--------------------
>>   1 file changed, 7 insertions(+), 20 deletions(-)
>
>

Reviewd-by: Zihuan Zhang <zhangzihuan@kylinos.cn>



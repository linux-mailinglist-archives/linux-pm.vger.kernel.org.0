Return-Path: <linux-pm+bounces-27078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 942D8AB5539
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 14:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB2F1B45E75
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 12:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4076D28D8DA;
	Tue, 13 May 2025 12:52:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82463286439;
	Tue, 13 May 2025 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747140771; cv=none; b=l2M/ljFEhmEfFj4HBM/HlAVYK9MjQAQ9+OsjYTZRr4KfTW0W5t6nSyLxUEZOjaaX9mZTO7D2cNYEnmyq6UcIQqRr66PXXWk4VSz5cBv9arGjNcMcM+1R9hN0TX24jSYwKvrVYXXrX2COli1CM9DxFfH069W95LEOYKxSP8pj2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747140771; c=relaxed/simple;
	bh=YNzHMvoCaswGru/vsyN1RIpOmYesDhhx7LLNN/WcS6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MFD735KDj+LqqBd9uMrWd3J1O6L7gOAy2jmaeGB5++Jti4LeOW/AnIfT0BcmpuNgjw7ZltCnA23V2JWQxkaoijongq3RKwsSbJ/SM6Gz/X2mxYynx9WdMia+noxSBiEhfY3AS+omz5B+SXlH5bbbRMvLjjQzCxrXaVSw4rkXICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Zxbvx1kFtzsTL0;
	Tue, 13 May 2025 20:51:57 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 3609314013B;
	Tue, 13 May 2025 20:52:40 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 13 May
 2025 20:52:39 +0800
Message-ID: <a379625e-ece7-4b94-a482-014639624171@huawei.com>
Date: Tue, 13 May 2025 20:52:39 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] PM / devfreq: Some optimizations of devfreq
To: <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<cenxinghai@h-partners.com>
References: <20250421030020.3108405-1-zhenglifeng1@huawei.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250421030020.3108405-1-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Gentle ping.

On 2025/4/21 11:00, Lifeng Zheng wrote:
> 
> Lifeng Zheng (4):
>   PM / devfreq: governor: Replace sscanf() with kstrtoul() in
>     set_freq_store()
>   PM / devfreq: Limit max_freq with scaling_min_freq
>   PM / devfreq: Remove redundant devfreq_get_freq_range() calling in
>     devfreq_add_device()
>   PM / devfreq: Check governor before using governor->name
> 
>  drivers/devfreq/devfreq.c            | 20 +++++---------------
>  drivers/devfreq/governor_userspace.c |  6 +++++-
>  2 files changed, 10 insertions(+), 16 deletions(-)
> 



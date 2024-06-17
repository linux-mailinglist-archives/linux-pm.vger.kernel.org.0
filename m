Return-Path: <linux-pm+bounces-9273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D97B690A36E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 07:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CE31F21B1C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 05:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F87B7344E;
	Mon, 17 Jun 2024 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HAGpwSj6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5A52F5B;
	Mon, 17 Jun 2024 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718603388; cv=none; b=EA3xezwcJrtKxTiV/kq7cN8FhmyDpldQxrl+RvtR7plCPCUYtESz68pxmgBHVYkm0fAVALG5OP/cFVsPu4nKsDW/zQbCRjcCm7f/iRTm0h1ywKPj8u1uB+gKvbYGBUWpKiMcuslghzT3WZ/fiZGeYdKecFf6QLLz0vWHr+7F5KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718603388; c=relaxed/simple;
	bh=DdzV5cy7QdPS7UuDA+bGlmPydEEP1sGZJScyk9xBbT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dncDRy0tmsLgh7Lx6qmsmB8mcrRnLac934lByrAmc2ZLRJbxRdZIWpWLwytjcZtj8VqionZWqGu0i7QRiX8ajtsxpJXUTPazL+e+ibzWWI8mZlW0+7X2M6rDttzXojTS48VQhEDyHUJvdOQNnNf/VJOirzNaUdnp03ulMnyOQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HAGpwSj6; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 62655b662c6d11efa22eafcdcd04c131-20240617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=n+g/uEy3+i2rd2NsZqxgYj3I30F85HQmdcdBnVw2k/I=;
	b=HAGpwSj6mzAao2z8tlwKfhxpj3Wqdb5g803tqF3TWeqadz5csEWKFHuqLxueyzmWjyvOfxgrf+rNtkwdrYQPNY8sa7X2budWimTtGsrwDACCVRJ3DeMMj4YnM+6PlT7BR1kY/Zhd0ih/FmA0dTrmnH+1BxY2sbyc7A0KvPRhpQ0=;
X-CID-CACHE: Type:Local,Time:202406171327+08,HitQuantity:3
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:fddd3bb1-c546-4eb1-9615-f2f78256dbc0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:e994ab88-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 62655b662c6d11efa22eafcdcd04c131-20240617
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <poshao.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 25052257; Mon, 17 Jun 2024 13:49:38 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 17 Jun 2024 13:49:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 17 Jun 2024 13:49:37 +0800
From: PoShao Chen <poshao.chen@mediatek.com>
To: <viresh.kumar@linaro.org>
CC: <ccj.yeh@mediatek.com>, <ching-hao.hsu@mediatek.com>,
	<clive.lin@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <poshao.chen@mediatek.com>, <rafael@kernel.org>
Subject: Re: [PATCH v2] cpufreq: Fix per-policy boost behavior after CPU hotplug
Date: Mon, 17 Jun 2024 13:48:38 +0800
Message-ID: <20240617054838.9224-1-poshao.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240613092054.f6obecbvf45frcqw@vireshk-i7>
References: <20240613092054.f6obecbvf45frcqw@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 2024-06-13 at 14:50 +0530, Viresh Kumar wrote: 	 
> Please try this instead:
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7c6879efe9ef..bd9fe2b0f032 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -43,6 +43,9 @@ static LIST_HEAD(cpufreq_policy_list);
>  #define for_each_inactive_policy(__policy)             \
>         for_each_suitable_policy(__policy, false)
> 
> +#define for_each_policy(__policy)                       \
> +       list_for_each_entry(__policy, &cpufreq_policy_list,
> policy_list)
> +
>  /* Iterate over governors */
>  static LIST_HEAD(cpufreq_governor_list);
>  #define for_each_governor(__governor)                          \
> @@ -2815,7 +2818,7 @@ int cpufreq_boost_trigger_state(int state)
>         write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> 
>         cpus_read_lock();
> -       for_each_active_policy(policy) {
> +       for_each_policy(policy) {
>                 policy->boost_enabled = state;
>                 ret = cpufreq_driver->set_boost(policy, state);
>                 if (ret) {
> 
> -- 
> viresh

Thank you for the suggestion. However, calling ->set_boost when
the policy is inactive will fail in two ways:

1. policy->freq_table will be NULL.
2. freq_qos_update_request will fail to refresh the frequency limit.

-- 
poshao


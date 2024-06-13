Return-Path: <linux-pm+bounces-9069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D9090686F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 11:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF31128637A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206F113DDD7;
	Thu, 13 Jun 2024 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c98QJvKJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9737D13DBA4
	for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270460; cv=none; b=pmCDZ+J368gSP+fg8ioD9dwMF2625t3ePqbHSbdtOLJ4S5MsKW7odUPtXK45TYySMvWEFJYyOEaAxPve6RaVJ6T6cziisgWqDAQvvrrPWVTKpCcZPxXf6i8Vjd3at8hvBOCAIMRL4wkjbjQjBZhLE0NFCIM/mzkoJeV7aElPWHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270460; c=relaxed/simple;
	bh=alNyO9/sj1YRmgy/7Nt69dqKXHxEncHp72eRrpWp2kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzGDVnDLO7+Bgwd874GF8PhuXr1WSC+ZHJJdNCy4bm9MeUrOK/DgiaLrCaVoQGB61OTlPuk8AvzR80m1JxemoEhqnyxGe/GCNBdNeYsjT0fzET3guUJNCCgOuy+bh7VCzKNvZGfKuOgUnt+jf+XewrpzYOm0i4vE9QOGpAtga2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c98QJvKJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f68834bfdfso6673795ad.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718270458; x=1718875258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GEP3MgFKp5YZRNheHta5OmSF5R3qRkcckrOw8cWXEiY=;
        b=c98QJvKJLvxHRchJwe1OAeGi8a3f9XnoH7q/dOkZH74LESTimHfqkY8U34X3upLXlV
         uDsKz2i0NTeLFvtdGIdrDZznyfwmSWqHkSnTap+pbJ1/oJeCiE0cjAEdqN0n38ecEj0P
         YPE13CAG9KHHmIxOmmpsuZxCEvBrQD3+nWWr4Ms1+0MRlfVqzPEjOelXnggEiZoCMyc0
         VyDSTpB14LJXNFQHG+lJdQO/AN8Nr0mtvUU0/ymcK2svtqB5ykhzuOhRMVcbNAQ6nU7t
         Ls0krQzTznFrBpONJNrZ4MWKpkA7acVwdve+ZFJlNXC0c+UdR7mmBRR3uRLfVz33dWJc
         lGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718270458; x=1718875258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEP3MgFKp5YZRNheHta5OmSF5R3qRkcckrOw8cWXEiY=;
        b=pT7DGFNCwevu9ZTrpJuAWCS4+REECKjws0bb1WxxGb4Sr5JNuLJ2qzxldIt2wY+32g
         sq11j7C1eHyLi50RyQzGorR5lg5MIE4Q1+xxJVNYKWfa/sqjnPqivJwQihoHG1wWR5fU
         qiHn7UE8Tp7NT1iuGHr8Lhm6eCXnOi3Euaxn1IZOvm9k7iL4i4yXCjtXTm/hOv7/RIyh
         URA4TnBx8XOUfOeFLEXaXKwUiz2sv1aixmugGfVvCNv4hoKXee0Sro+d1xDJp4oD2i4K
         vfeC0d7D+Lpwa0siwz33Z2jdnx/izjk38/+AKwd9H7JsjDxNVjU3oApjNFSOePOJaQih
         L+1w==
X-Forwarded-Encrypted: i=1; AJvYcCU9qujRRrHzx2XAU/s6Pi4VjoDnVLbq9SofKYJIe6pbSI/TJywpSNRAf43F4letGHkNwx5qRJPrR+f05sgMW6KndfIgh/0Nwno=
X-Gm-Message-State: AOJu0YxkMGLW9oNZ11gYMB7CI//9MkMSOCZGHBsVgCAIa+G8FFm50RHP
	ik30n2ILAPHioHuekjjTE/AJ3YFV/TxAJ4yXiuPKxL/iWPPlyBj3o0YEN1uWTHA=
X-Google-Smtp-Source: AGHT+IHY4mtcH0EaPDbLamBRJaLJfGhaEvqnuTUowWgzf2jmKqKPj9g2XmtfD0ZcA5Q5yUh94ns2bQ==
X-Received: by 2002:a17:903:2301:b0:1f7:243d:821f with SMTP id d9443c01a7336-1f83b6fb72bmr45345845ad.35.1718270457557;
        Thu, 13 Jun 2024 02:20:57 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e6fdf0sm9035435ad.74.2024.06.13.02.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 02:20:57 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:50:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: PoShao Chen <poshao.chen@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, clive.lin@mediatek.com, ccj.yeh@mediatek.com,
	ching-hao.hsu@mediatek.com
Subject: Re: [PATCH v2] cpufreq: Fix per-policy boost behavior after CPU
 hotplug
Message-ID: <20240613092054.f6obecbvf45frcqw@vireshk-i7>
References: <20240612033112.29343-1-poshao.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612033112.29343-1-poshao.chen@mediatek.com>

On 12-06-24, 11:31, PoShao Chen wrote:
> This patch fixes the behavior of the cpufreq boost when the
> global boost flag is toggled during CPU hotplug offline. This action
> previously led to incorrect scaling_max_freq values when the CPU was
> brought back online. The issue also manifested as incorrect
> scaling_cur_freq under the performance governor.
> 
> For example, after the following operations, even if the global boost
> is disabled, the resulting scaling_max_freq and scaling_cur_freq
> will still reflect the settings of an enabled boost.
> 
> $ echo performance > /sys/devices/system/cpu/cpufreq/policy7/scaling_governor
> $ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_cur_freq
> 3200000
> $ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq
> 3200000
> 
> $ echo 1 > /sys/devices/system/cpu/cpufreq/boost
> $ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_cur_freq
> 3250000
> $ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq
> 3250000
> 
> $ echo 0 > /sys/devices/system/cpu/cpu7/online
> $ echo 0 > /sys/devices/system/cpu/cpufreq/boost
> $ echo 1 > /sys/devices/system/cpu/cpu7/online
> $ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_cur_freq
> 3250000
> $ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq
> 3250000

Please try this instead:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7c6879efe9ef..bd9fe2b0f032 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -43,6 +43,9 @@ static LIST_HEAD(cpufreq_policy_list);
 #define for_each_inactive_policy(__policy)             \
        for_each_suitable_policy(__policy, false)

+#define for_each_policy(__policy)                       \
+       list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
+
 /* Iterate over governors */
 static LIST_HEAD(cpufreq_governor_list);
 #define for_each_governor(__governor)                          \
@@ -2815,7 +2818,7 @@ int cpufreq_boost_trigger_state(int state)
        write_unlock_irqrestore(&cpufreq_driver_lock, flags);

        cpus_read_lock();
-       for_each_active_policy(policy) {
+       for_each_policy(policy) {
                policy->boost_enabled = state;
                ret = cpufreq_driver->set_boost(policy, state);
                if (ret) {

-- 
viresh


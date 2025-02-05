Return-Path: <linux-pm+bounces-21359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF402A28383
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 06:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64D587A285F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 05:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D181721D586;
	Wed,  5 Feb 2025 05:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rbbg5Boo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9200A214202
	for <linux-pm@vger.kernel.org>; Wed,  5 Feb 2025 05:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738731713; cv=none; b=oDvDNZ1mTI83c7Fs8SgglJOZzNmUh9G0rUZsdi6lFg+PZirO+j7KNpCVrlCtWqSDPH+9+BJulZPhkwrW0H6I5gfPC375wBoYD+vr6CmK9jeBa0gYD70Vjxqh0MT2CPpCNBBu2Ki1kvblx8CJQtzPpvoUCGsauGg9ufS/O/WjQLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738731713; c=relaxed/simple;
	bh=fwCHjFRk35mzj5sI7+uT1IUow+zrDz9kGdE/IzX1SzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAycq38EgzQ/yX/n1EI6zp+WJp7dmoAJcPR/AV+SBuLhEy0rSY0Ht2ZrFW3L/vAIcputzkKR3umElkHztMpQhZ5amMrBKXhelP7/HxiEtkEghCyKIVTj1GEalCL16xhR42wqdwMw/uUSiK3lPHjlH4lqa4LR1zlIAyeSl5ZQv/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rbbg5Boo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166f1e589cso55642165ad.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Feb 2025 21:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738731711; x=1739336511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p0swfSSPD+og1Pzr3e9g725D1t2rKfUqhh/5xRm6XfU=;
        b=rbbg5Boo/jAoCrZcDMGrBTmTWachS5HOHzpWMVaW9OREBxBnWDScGhFhSbUHTLs06g
         8Qf2B/hbOw6e+GP29aT0NniVBnxozpqPXNyeZkW+y37dU29B4vdgCC8bRGIISfKy6Kg3
         rbk3tzV/0OdudVEhnZO5E00IaMup+zWd4+eY6U4GDyGKLO/jUEsdyknkIKNyWVegIns6
         ye2KxuLww6QTeBywpuYgEOu9GqyyhmygWiHUNwfzYfZbGj6PgR+8DNm6uLWiTz9k1CXc
         JOeQ8bi7yvl8tz6urYNJkQveSW7ZAGJhaRb9gNZwRKbKExT5ZoEWUHykdMB1cvxJ+4T7
         MlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738731711; x=1739336511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0swfSSPD+og1Pzr3e9g725D1t2rKfUqhh/5xRm6XfU=;
        b=QygWg1LFJpafvU+DK8+EaqDOcTi9TIIN9oiSKVHIyzTjG9EtRQQPcH5Y3cgpFBbofA
         vxaJ1/dqP0MxWRqUVRJNiNoZR6yh0w3Cm2H6GyMlkAnB3wA2kE+B6GTrsOitO016dJUo
         HRzaPuQfIKu0vpK5tbFQhxux0OAushjSNsP+/8xnLy6U/8YKb74ZPoi0lZCq2nGEvaR6
         xSNOcflwhgbSkUEhGLNeHS+x5ss38vutYMEURIKnjvXYw5hjKzyEjsM9/GXub4o2Gn3A
         K1TbHfn41oY0CL6vn33nOFNkn2qQtgzjwOx3GRjyqMLxtCxVVkdhiuCUJaxK1962sxcN
         7NPw==
X-Forwarded-Encrypted: i=1; AJvYcCVbhpR4OTEG/2EJFv1e0pK9H1O9btrjamszrQWyjjcC1HVtEdM451+DldrL9ui3bnvFdqiK2XQ8SA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvvIsuaWV8rDxfFB7b7Ql5sh4YfeeHYdBfZ1ENtwVwp42JeWMe
	oSkwPQCOu7p2jBT+QlYg1StC1ewPN8SbeDDwxonnfijwvZ5pug7iucK7oUNE8mg=
X-Gm-Gg: ASbGncsG5smp6uT/X5gJNAcEI7Uv679BLXQe332OIp2bK/BxhlOmFXXzoLatzFy8kp+
	X8PPx8qVeLI8b8R8odYchNBf3eet5z0WRPPdzSm3LQ9FNv5KfxaHGDRu1z7dKL91Oc411rhJW6E
	yd4ABLYagVoapQ4NE/g01R73xdhZEe8GqnSYOgU/h327+TzsSXEi+B0S/RV//Fgq3o6uopYcVNo
	BD9v8gICykbxDLuaQ6g8lv7SGly6VLrd0EfVGUBI3ajCkYYjO7s4kSnGELYLXCASumzMnQZC1uo
	8wfaSOAM3wUvPRCFnQ==
X-Google-Smtp-Source: AGHT+IEK1SsVPM3FY80ZXjnzpYTsubF/iE9BdMFRWlXVghXMGUaasnmObK/mq0H2BixXG4K9ZJcJIw==
X-Received: by 2002:a17:903:2291:b0:21f:1391:171b with SMTP id d9443c01a7336-21f17f115dfmr31036995ad.44.1738731710796;
        Tue, 04 Feb 2025 21:01:50 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea495sm105426275ad.126.2025.02.04.21.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 21:01:50 -0800 (PST)
Date: Wed, 5 Feb 2025 10:31:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, lihuisong@huawei.com, fanghao11@huawei.com,
	gautam@linux.ibm.com
Subject: Re: [PATCH v2 2/4] cpufreq: Introduce a more generic way to set
 default per-policy boost flag
Message-ID: <20250205050147.hfctwo6aw75rardc@vireshk-i7>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
 <20250117101457.1530653-3-zhenglifeng1@huawei.com>
 <c9e56c5f54cc33338762c94e9bed7b5a0d5de812.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9e56c5f54cc33338762c94e9bed7b5a0d5de812.camel@linux.ibm.com>

On 04-02-25, 22:11, Aboorva Devarajan wrote:
> I noticed that Viresh is working on a similar patch [1] as part of a broader patchset
> to simplify boost handling, which should also resolve this issue.
> 
> Should we merge this patch [1] and related patches since this is causing a crash,
> or submit a separate patch to fix this?

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d434096b7515..7c1f7f5142da 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1590,7 +1590,8 @@ static int cpufreq_online(unsigned int cpu)
                policy->cdev = of_cpufreq_cooling_register(policy);

        /* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
-       if (policy->boost_enabled != cpufreq_boost_enabled()) {
+       if (cpufreq_driver->set_boost &&
+           policy->boost_enabled != cpufreq_boost_enabled()) {
                policy->boost_enabled = cpufreq_boost_enabled();
                ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
                if (ret) {

I think the right fix for now should be something like this. My series
(which will be part of next merge window) can go in separately and
revert this change then (as we won't see this problem then).

Please send a fix with something like this if it works fine, so Rafael
can apply.

-- 
viresh


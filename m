Return-Path: <linux-pm+bounces-25592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02C2A9123E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 06:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A0E5A1D0E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 04:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEC11B6CE5;
	Thu, 17 Apr 2025 04:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sk4wdvgL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422579F2
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 04:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744864265; cv=none; b=NiyAeAeYWhjUYqe6Q+2XtsfZ83DxmKvdGm/alyTNzy1ZoLyyh1bdXswZZVqCg6D3G9tFd0b14kPDQrYywcZv+LItnRH/eDMuKV2Op1vVmB3xZhC+KvRCMV1v/k7r15FopQDu35GtWvoBfSL7pCFPMt+Bwm0iK38RfR/C3BUNuhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744864265; c=relaxed/simple;
	bh=+sk7hb8P47bWgI1AKQvmM/ONosvVBAHXLTSOV6y0dT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeHXKpYf1nZduzc54TY6p+cf96TZRH9q/JVA8cTXEBKK/tWeej6TfsCR/asZ8kPDBJ9Z5WdXqbmGwf5NWPGzfus7n68UailKOwEdhTl4UQ1lECgNrI/SVs3Rgqx3K8HH6nhTDinVXstQrMqIXyCJQSc5ZVn6rzvxXU6v/VZ5Dek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sk4wdvgL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so242179b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 21:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744864263; x=1745469063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlaUAntWl+FAG4ssmQ8ExU+LE+kWPisBX4TPYFCKWz8=;
        b=Sk4wdvgLxh7t8CnDvpPrsGOBwWqDUGeCuhEaERDm0wi+2YMM9Ddou6atk9/CW2vwjs
         yYsQFzViefx/70pcNDEnWx8s93az7hA24r6uGwr5aj5BdYf5Dx0+pcDANpelOrjzwrSw
         wByuo35f1in7gBts/M+sebAu4lfHEEO8EQyT8VdIxRTxA6ZdaYxlpnWzbY9IgZrSLs9v
         wXnhC+v0V0sd6kY5ofbbV6hy+Aw/zhD52xwL2Zq050VYUgxcrtz8L3blXzLvAHQ7MUys
         GxEQFFXU2lOH9Zgh8e4NM4ROsR6c1tjHGhyPOmH4jeZvqgU3x9+6qMTk22o1kTCJ/vKB
         KPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744864263; x=1745469063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlaUAntWl+FAG4ssmQ8ExU+LE+kWPisBX4TPYFCKWz8=;
        b=H2UvpokbcrGC6JKF0f4umg4MSVqRV0glGJb1M9CFNtnbqe1hHmeSUYJUKe07jEeufP
         ZNVidbErYrrmXRYBjK0oPrpRPEQznJ2Yxx6+oxYakB190qRElEQWBS8URiMsCTIpdr7g
         +VIb/ejvoPGZtsXTbgq87JbCO/s1CCavhkdarz2fX1+r6r7t2wcS8OBgHRQPyzRgVNnX
         I/j41J2lT9slEG5aW7ZBe3eIVy5I4aYDUfZlPUtj+XUH83amljOApZwAZHGssGb1ekNo
         BkYe7Ez6idegsRADliMqVf60LgMGNBlFUy0aDfqetpyLtsk7XpLcUC93SlmeZGvLwtCR
         WRSQ==
X-Gm-Message-State: AOJu0YxKOY/uVvnaj+rmPi5vAfkZrfgBLL0ZxC/yD/t7JRjdc/kIXgau
	BE2mtFiEYCzfhYDPCy3l1Zf5FQ8Wh85fuSyFObdbob5BwxemMpB66IFJPE7fQh2B0gv/cnr7T6c
	4
X-Gm-Gg: ASbGncu8+rxb3VqzAfqCOY3D6aF6AEZfuqc7MXtE9bnyH9/sCW2gGDUwE3Eo2RClzF3
	C8uU3b863H15QDUora41hl+eQw9ElGrnT1Y3AASuH7e3lFE3OuTs1fxiSepwr2t9/t9+HZMvJ8N
	Vt9MHqhPgVZ4lEl1GPWH2R/FEWERdB/5Ez6/CCzs28wIXlRC0z4aJQMUczxfWF/dCdrSuyuoEqw
	su+AR1fDQibYNRK5rFWMdOjueAgC/IvMmjuForUOuR3LVDCH7e1BGFJWnNB4F+XpunzvK5HqZOU
	jdeFb6qwbiCH6Qxi5vnzA/ci1K/IU6Pz/kMzwmnEfA==
X-Google-Smtp-Source: AGHT+IEg1IOSKx3TC5x7KXjPRVc1J+SeCE9LoLwfSMtCe4XckXlEc0yAzy5LghooDosu7gaIzIG1lQ==
X-Received: by 2002:a05:6a00:240c:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-73c266b9927mr6133644b3a.5.1744864262953;
        Wed, 16 Apr 2025 21:31:02 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f120csm11306099b3a.85.2025.04.16.21.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 21:31:02 -0700 (PDT)
Date: Thu, 17 Apr 2025 10:01:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sultan Alsawaf <sultan@kerneltoast.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3] cpufreq: Avoid using inconsistent policy->min and
 policy->max
Message-ID: <20250417043100.dq6yw4ktbimms2au@vireshk-i7>
References: <5907080.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5907080.DvuYhMxLoT@rjwysocki.net>

On 16-04-25, 16:12, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since cpufreq_driver_resolve_freq() can run in parallel with
> cpufreq_set_policy() and there is no synchronization between them,
> the former may access policy->min and policy->max while the latter
> is updating them and it may see intermediate values of them due
> to the way the update is carried out.  Also the compiler is free
> to apply any optimizations it wants both to the stores in
> cpufreq_set_policy() and to the loads in cpufreq_driver_resolve_freq()
> which may result in additional inconsistencies.
> 
> To address this, use WRITE_ONCE() when updating policy->min and
> policy->max in cpufreq_set_policy() and use READ_ONCE() for reading
> them in cpufreq_driver_resolve_freq().  Moreover, rearrange the update
> in cpufreq_set_policy() to avoid storing intermediate values in
> policy->min and policy->max with the help of the observation that
> their new values are expected to be properly ordered upfront.
> 
> Also modify cpufreq_driver_resolve_freq() to take the possible reverse
> ordering of policy->min and policy->max, which may happen depending on
> the ordering of operations when this function and cpufreq_set_policy()
> run concurrently, into account by always honoring the max when it
> turns out to be less than the min (in case it comes from thermal
> throttling or similar).
> 
> Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
> Cc: 5.16+ <stable@vger.kernel.org> # 5.16+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This replaces the last 3 patches in
> 
> https://lore.kernel.org/linux-pm/6171293.lOV4Wx5bFT@rjwysocki.net/
> 
> v2 -> v3:
>    * Fold 3 patches into one.
>    * Drop an unrelated white space fixup change.
>    * Fix a typo in a comment (Christian).
> 
> v1 -> v2: Cosmetic changes
> 
> ---
>  drivers/cpufreq/cpufreq.c |   32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh


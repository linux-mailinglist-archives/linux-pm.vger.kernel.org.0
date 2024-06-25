Return-Path: <linux-pm+bounces-9937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1F59164FC
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 12:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067F21C21FCC
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 10:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4159D14A091;
	Tue, 25 Jun 2024 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p37bItN1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D179146A67
	for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309933; cv=none; b=DB4Ug3e0zUDcbSdJZ04CjyrEbjAnX0lvI8evFJ0yS2IBNJJGMiC4ZNb/RBO3AubgxNDHUuVjGTPNUO9vR+s50FDZBlP7nrKZEmYce7DNNejUCUd6I/WObcI7UZ3SlbjHf2v4MSzKP+GBzjHXTU7aO90pq2PCV8fuStFamGUsvAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309933; c=relaxed/simple;
	bh=deHdQhGznFT9aF6hYlSiGKg0Yl20Y/u0JHKvCPZG/Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwydnitjQfsPxypja0WhM2uAc0c1iEkRvQrBKu9DF81+no4k7JauM5Hz22hK30d47NKu+oQeDlnWhr6sTvYsodBiPmi2O84p9iFfZnHvQXSnhq/LycPNSzt/lonn9cwg5apgbVPYbH0HFDISg8+Wt1z+I4nxihsm9ZVlkpSgj7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p37bItN1; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-70df213542bso3784319a12.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 03:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719309930; x=1719914730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZF3vQrTyioliznoWyRBeH+6GBupISmZQ6zBtmnyWKY=;
        b=p37bItN1aPu6USR2F40Oh2EBz/JmTPjStRneQDAav5oMwZDYbIcuDgIbgN7pNjXKHk
         Htt3LLqXCHciakHR6QVhiH6YFGJsDAX74f2bP8k9liE19qOtTy9hG4BsaijYjCYpABQA
         3Qglp3OW2Olf3VlW15O1w1OV3gOBIThc7aXYHJJ1KAW+4owGGUMUNKyluzoE8SY+Mg7K
         WzCAIHWpi82NFp4vF85Eo9aMXjLvulvMLwz2uUvG0hjqYkMawgABfjCX78jugbDF8IfK
         5j1BcOJEoarCo3HMSAuRfrAWYIUzahJeeguDEYWGVGi3MjRWj7C76ISZ+QzsKr2BvCTl
         AW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719309930; x=1719914730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZF3vQrTyioliznoWyRBeH+6GBupISmZQ6zBtmnyWKY=;
        b=ns5boEZLEWhvDWLPPWr1Lk35+QBTfXIZOKjYGJcLSuisTXveDICD9YTP9brV8Bi8Ar
         eapyGhy1FHuLBYNKImL5wd5l7TxXyafvd+jAMwZuan3e8QJEmkYl+KV+xCi1i8Znptfq
         fcz6F5FLoR2rqmxT6YjbS4ZjguLrM6IK0vTtS7lW7OsPHxEKV3WnofEjw17DJBnfOrax
         9Wm8QQ+08qE6j/1y6ypX+sdGvY34es3hkjby5/QwFvCZ/9cFXk75cFW44ZqJGHfaQPNn
         OH3vMcAUjXHLyeiVn1OhMvveDQ/1hujvzhSJPW1ycTi7SWJ/PaS2TyZjNuLTB7gN6qwr
         yOcA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ4juzW2QtfFU0ThUMgLBeqTMO7IfFgi8DCNbKXxfhG+6wby+qgniX1BBQlOXfjiMtGXbiYLQbZeuQ9oZA+Hxzqr9MtG0Dxq8=
X-Gm-Message-State: AOJu0YylPqznEEszZ4PoJjKi/LHznJNHP1HPAdeuJEHI0YLBDI5KqNGk
	hm35LkScO43xTxZsAMRYeOPKD83/ElS9Vn9E0587+sNyBsmExyyxqMID/jQ+UPg=
X-Google-Smtp-Source: AGHT+IGXXj6DR2cMaEROxwusRXtJYBeV0zTXJVstUhfxjV/+UE4LVIwOqAwTOF2ISwX7nwpr9TDx1g==
X-Received: by 2002:a05:6a20:7a96:b0:1b6:a7c5:4fbe with SMTP id adf61e73a8af0-1bcf7ead34amr5467925637.14.1719309929728;
        Tue, 25 Jun 2024 03:05:29 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c5c18sm77349345ad.173.2024.06.25.03.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:05:29 -0700 (PDT)
Date: Tue, 25 Jun 2024 15:35:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: PoShao Chen <poshao.chen@mediatek.com>
Cc: ccj.yeh@mediatek.com, ching-hao.hsu@mediatek.com,
	clive.lin@mediatek.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v2] cpufreq: Fix per-policy boost behavior after CPU
 hotplug
Message-ID: <20240625100527.cdy6gaajemlplmxu@vireshk-i7>
References: <20240613092054.f6obecbvf45frcqw@vireshk-i7>
 <20240617054838.9224-1-poshao.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617054838.9224-1-poshao.chen@mediatek.com>

On 17-06-24, 13:48, PoShao Chen wrote:
> On Thu, 2024-06-13 at 14:50 +0530, Viresh Kumar wrote: 	 
> > Please try this instead:
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 7c6879efe9ef..bd9fe2b0f032 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -43,6 +43,9 @@ static LIST_HEAD(cpufreq_policy_list);
> >  #define for_each_inactive_policy(__policy)             \
> >         for_each_suitable_policy(__policy, false)
> > 
> > +#define for_each_policy(__policy)                       \
> > +       list_for_each_entry(__policy, &cpufreq_policy_list,
> > policy_list)
> > +
> >  /* Iterate over governors */
> >  static LIST_HEAD(cpufreq_governor_list);
> >  #define for_each_governor(__governor)                          \
> > @@ -2815,7 +2818,7 @@ int cpufreq_boost_trigger_state(int state)
> >         write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> > 
> >         cpus_read_lock();
> > -       for_each_active_policy(policy) {
> > +       for_each_policy(policy) {
> >                 policy->boost_enabled = state;
> >                 ret = cpufreq_driver->set_boost(policy, state);
> >                 if (ret) {
> 
> Thank you for the suggestion. However, calling ->set_boost when
> the policy is inactive will fail in two ways:
> 
> 1. policy->freq_table will be NULL.
> 2. freq_qos_update_request will fail to refresh the frequency limit.

What about just this then ?

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a45aac17c20f..8e92ba7dda4b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1430,9 +1430,6 @@ static int cpufreq_online(unsigned int cpu)
                        goto out_free_policy;
                }

-               /* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
-               policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
-
                /*
                 * The initialization has succeeded and the policy is online.
                 * If there is a problem with its frequency table, take it
@@ -1446,6 +1443,9 @@ static int cpufreq_online(unsigned int cpu)
                cpumask_copy(policy->related_cpus, policy->cpus);
        }

+       /* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
+       policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
+
        /*
         * affected cpus must always be the one, which are online. We aren't
         * managing offline cpus here.



So the cpufreq core sets the policy boost to whatever the global boost
is at the time CPU comes online.

This won't call cppc_cpufreq_set_boost() (I think that's the driver
you are using ?) though. The freq_qos_update_request() thing we do
there is driver specific and the driver itself needs to take care of
this, perhaps in the online() callback.

-- 
viresh


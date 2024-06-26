Return-Path: <linux-pm+bounces-9988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EE99176C5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C616E1F2400D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 03:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBE561FE8;
	Wed, 26 Jun 2024 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZHyBN+m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F8953E23
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 03:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719372426; cv=none; b=m4Oe2IEuvJ+EZR+/1u7MCfGdkAtwp7qJQF38XGXwmv+44FQ/xOrlAPcOxu+ZjHsQsw+ZerRUQIk49aVAhBcBnNGL2ytJlkBcvNRvHYcRCRsvpPlruUI8AVwp6lVePcOTzX/XWbJJFZF3Yf3iLmiELD6QvE9uUpsOvStsOrZUAEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719372426; c=relaxed/simple;
	bh=O5JW+lsRdcg7zCwz5fPHPjVrIzu2DuLlFspPxJYZ1Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTfGLd8IbOmT2gj5s5Mcc5CbfpRdqSELIg1pFQ5JhfFbfDoHd/Tfdg2MiSZNSfSlr5NfUbMfsBAnzGg4HQX7kh5XQtZwAHpMWs2hwRBoZJ4tr8Wz0W+T1/L6EYEs7QpiihY9d3Xt9BkWMrBK4h19XqKahB6QoGwvP+ov+pmB0aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xZHyBN+m; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6c4926bf9baso5145323a12.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 20:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719372425; x=1719977225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1a9MC4iRowlWxPSzuWf76G+KR48wB9zNNCH6SoeX4qw=;
        b=xZHyBN+m2I0A35Z0rVJOa7cmCxvj8CJMY9Xc8bFL2NQwqweTGZi9jAWnpfZyWxxDqb
         dfV3QfWwYzok6XlTIS2oSlQWxGt2cI19gmV2fPGuiLZTWAvUlHMBHpQT3Qc4YFK77ICn
         F5OHwK9ZcOfySdNWbH4KBqO67/FVV3ypf5w4W+Odsou2HiFkOQxG9sLnfVGyOwC1D769
         YcSTac+qV4kb5v6KTbRY5PwVQ1xbC4IytxfQtqzV2/gKTyfIwZvTkAgtxW28wv+C1PYI
         rwOPB9tQIC/KNWg+C2CqJolvhJUtsIiyt0PsGcCZ1BF8bInX7KcAYNEkbCvRWztE+C26
         lPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719372425; x=1719977225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1a9MC4iRowlWxPSzuWf76G+KR48wB9zNNCH6SoeX4qw=;
        b=SZLwYMKTXh9b3Hme6wund7JZ6+W/jjRBRW/uRPCv9RNfpzEyfBG8IbdjqDAN75Sl0Z
         oJQ7fFqsemoFy0G2MTLh3+ufF6LryRSlYxNIgeC9+st0aPmdf2q0yniy8Ugk5LFsJsrn
         pR7pGBib56cvlqbojfPtP+SSlV+ZLgH/BAYKosDMtnDdqxwO5dl7US9KxclT5T7qKuT3
         Z5BBDeOEFpmN6NxUR8o0kWQ/JC4+wugIdZG+b0xJW7t0Lr+PEgdl66INw2w1oZ5yiICr
         oWiqiN0Op2anyUdL7WGHfQ3aCzJM3TUlwg6iErIA79SNGF5UYCY205phdZBdtV9sPffr
         Q79g==
X-Forwarded-Encrypted: i=1; AJvYcCVK2Tg2VH/iiiLdecXvVmgQq+rFnpC31z6UgzLJ9FTZUf+Jnr7GvIVs7R5EO9qK9kbZitHnIdZjilfNRJeovHFO07nNtamk7CE=
X-Gm-Message-State: AOJu0Yxl+a+6BC1ejbj6CYHb8rLycm4CjEaXRI6J0/lQcdGxfZPuKcda
	4CP2i7PceTs9afOoJItgvbJ6EEjiAX8jNR2sXa/vvKS9y0TG+T4FkugF5sfSW4M=
X-Google-Smtp-Source: AGHT+IGfI9LF5Khn3LtZER4fB1xkWuv6KExsbPdOEJkX+IFg9PO0lPWd8Nr0tYO61DBeu5MxXtuNHg==
X-Received: by 2002:a17:90a:b30a:b0:2c4:b32f:4fd2 with SMTP id 98e67ed59e1d1-2c85820a300mr9236834a91.29.1719372424879;
        Tue, 25 Jun 2024 20:27:04 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d7e590c2sm431450a91.1.2024.06.25.20.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 20:27:04 -0700 (PDT)
Date: Wed, 26 Jun 2024 08:57:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: perry.yuan@amd.com, gautham.shenoy@amd.com,
	Linux PM <linux-pm@vger.kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dhruva Gole <d-gole@ti.com>, Yipeng Zou <zouyipeng@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v14 5/5] cpufreq: Only disable boost during cpu online
 when using frequency tables
Message-ID: <20240626032702.fai3hlybfe6czmjd@vireshk-i7>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
 <20240624213400.67773-6-mario.limonciello@amd.com>
 <20240625063003.cw62yt46b7uaskrp@vireshk-i7>
 <27c030be-d06b-46ab-87d0-2fbfd1dd9e13@amd.com>
 <20240626031142.ytzpyuflgo73piaw@vireshk-i7>
 <056cc207-678f-48ad-bc44-6b3b06bcc5a3@amd.com>
 <20240626031753.dti6ixxi2jlykjqn@vireshk-i7>
 <e8275758-e0f7-46c9-8131-094abe363292@amd.com>
 <20240626032557.5vsjmzyzmtkbzom6@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626032557.5vsjmzyzmtkbzom6@vireshk-i7>

On 26-06-24, 08:55, Viresh Kumar wrote:
> On 25-06-24, 22:20, Mario Limonciello wrote:
> > Yeah; that's effectively the same result as Gautham's suggestion.  He had
> > just said to change policy_has_boost_freq() for the same.
> 
> I know. The problem is policy_has_boost_freq() (as its name suggests)
> needs to check if the policy supports boost freqs (in a generic way)
> and it is used at several other places and it would be wrong to hack
> that routine to fix this problem.
> 
> All we want here is for the core to not touch boost_enabled if the
> policy->init() function has already done so.
> 
> > I'll test it with yours and reconcile the better one to submit back out for
> > v15.
> 
> You can send it separately to be honest, and it looks like a fix, so
> Rafael should be able to get it merged a bit sooner. Add a fixes tag
> too.

And maybe send patch for acpi-cpufreq and any other platform that is
broken too..

-- 
viresh


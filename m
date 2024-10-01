Return-Path: <linux-pm+bounces-15012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE88898B8C9
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 12:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBE01F222B3
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 10:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303361A01AD;
	Tue,  1 Oct 2024 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdLn4AH2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4AF1A01B8
	for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2024 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776811; cv=none; b=uFT7Q8JmSPbaJei8umv4Lw1fF8dz25PM0XUpEadnVRzkN2ptxuXWHNSYHN8BNiIDZktm0NPdrdUqIH6jFZcFxVZEpMrkD7SwsfElXwRPcmpVhQZNMhwKPjOEtpPsW/yyiLIRfuXGGdQptK2XhB929tqqeOxXWTrciJZ43NOp9s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776811; c=relaxed/simple;
	bh=chVTHdhd0gDdOEdbDvm09Wc61YsjZvYCuI3ACeLNtaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQpyy8dl388iQjdDD+oEKvpyyMYSEbWcDYAvEw9uKW1LrrDtl7spOROyQiFjo16Spu67o2BxtjRzeQozluq9C6prI5RVQOGF7FR8E6nMG6bZ5G0z42i0KxwodRq+X1Ncxxux0APCoDs3yJcQd+Ma3vbK1DIpNfyDPW3xuRG9fcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jdLn4AH2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b9b35c7c3so16080245ad.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Oct 2024 03:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727776809; x=1728381609; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fgo6NQBG2E2Q+wVlE8fJfIpF8d3CXP6kqHrR2eYck7Q=;
        b=jdLn4AH2yhaPnkhvuJkYyoy7UhKwYHYEuipeyeUz/e+UmUHxgizXe2AkyOeb96bY1b
         oOSKRbsP0a5cO721/iywbuUXeYwugLdio7jNyGeMFwOg95gAo4rXwY2m5K6ipVejl0e8
         ZVXjXUr9nJkoKh6KLxx0gELqoJkVqZC/ZCeFJ690EAjIw98i2rP6m1O3aUSTYSzIIGKa
         nSJbD4sCyqMTOP8lLeQEtCbo6vy/fpoCNixU4saoZN9xnM1B/s4e8NylST92En2nkAWX
         +E+CigiRe9qdS3zXOH12ougYGOiQTtDn6X4nHSPsPn0UZUn3mYJfBnGKGXyg4cScKXyS
         iNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727776809; x=1728381609;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fgo6NQBG2E2Q+wVlE8fJfIpF8d3CXP6kqHrR2eYck7Q=;
        b=smup00ocPNA19NLm7Mj8zljfUCVgNz1fEAMrR4rnb4HQH9xFVWnu7ug9swLcBaifCT
         jzZ+S3A6iECsb1seG2hmbr6a7a440z/4tNi7SqNqvluMiLms7m7hDgwnuhYj4DiUavQh
         PC/Jf7IVr9PAZ8TgIBJrzO/5LBRxTS03Fv21VmQujQH7pFBjn/cYk6duaHBGWMr5ZA6m
         UnbjVwTjosIHREZgv3supuxbiVfTSweuh6qGYMVfJpVKtam0zAPGCJGxN2PP4xjAU/A5
         XrPQhz9wLdrrx3CAVQ2QhCzFrJ7vlCwNtzEpgpACV9lYaQkFtTMwHCAu1h6D+OLym8Kh
         rcjw==
X-Forwarded-Encrypted: i=1; AJvYcCXFIZSmgZl2mXmo0X4C2xDwUu3p7p8GOlJNjJSsg04sxDQgEF38BoovAkC4UUAbg9tNmqEbzL7E+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YweIdFFTCvoydjitTPYElWUHvJ6syv3CAa/K6cexNz34p+o++Ow
	l0TD3+NStUVC1YmZWsFilOUZMOsv+Y62wTGHOupzdOSQO6T/wni50qxqwObWpSU=
X-Google-Smtp-Source: AGHT+IG/DI2UjrjSYePkW0ACa5mp6kJ3VOpU6rqNfNhLfoLoPo6XSArOKM/sBe5dyxG9nqD/EHVSqw==
X-Received: by 2002:a17:902:e74f:b0:20b:6457:31db with SMTP id d9443c01a7336-20b645736a4mr144453445ad.30.1727776807347;
        Tue, 01 Oct 2024 03:00:07 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d596sm66955565ad.166.2024.10.01.03.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 03:00:06 -0700 (PDT)
Date: Tue, 1 Oct 2024 15:30:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pm <linux-pm@vger.kernel.org>,
	Qais Yousef <qyousef@layalina.io>,
	Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH] cpufreq/schedutil: Only bind threads if needed
Message-ID: <20241001100004.nbok7s7zmgbcmqnz@vireshk-i7>
References: <480f2140-ea59-4e1d-a68d-18cbcec10941@arm.com>
 <CAJZ5v0h_AFNe2ZynDseE7N_5U9DV4NnLEhw9w=ErGuBswfpWow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h_AFNe2ZynDseE7N_5U9DV4NnLEhw9w=ErGuBswfpWow@mail.gmail.com>

On 12-09-24, 17:41, Rafael J. Wysocki wrote:
> On Thu, Sep 12, 2024 at 3:53 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > Remove the unconditional binding of sugov kthreads to the affected CPUs
> > if the cpufreq driver indicates that updates can happen from any CPU.
> > This allows userspace to set affinities to either save power (waking up
> > bigger CPUs on HMP can be expensive) or increasing performance (by
> > letting the utilized CPUs run without preemption of the sugov kthread).
> >
> > Without this patch the behavior of sugov threads will basically be a
> > boot-time dice roll on which CPU of the PD has to handle all the
> > cpufreq updates. With the recent decreases of update filtering these
> > two basic problems become more and more apparent:
> > 1. The wake_cpu might be idle and we are waking it up from another
> > CPU just for the cpufreq update. Apart from wasting power, the exit
> > latency of it's idle state might be longer than the sugov threads
> > running time, essentially delaying the cpufreq update unnecessarily.
> > 2. We are preempting either the requesting or another busy CPU of the
> > PD, while the update could be done from a CPU that we deem less
> > important and pay the price of an IPI and two context-switches.
> >
> > The change is essentially not setting PF_NO_SETAFFINITY on
> > dvfs_possible_from_any_cpu, no behavior change if userspace doesn't
> > touch affinities.
> 
> I'd like to hear from Viresh on this.

Looks good to me.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh


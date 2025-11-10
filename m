Return-Path: <linux-pm+bounces-37711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114C0C460F7
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 11:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4B63B916C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 10:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605D0305964;
	Mon, 10 Nov 2025 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ah5RHcia"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86CB305064
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771797; cv=none; b=rIBSe4i1n6xYHj4X+t4LIfCP9NDcQzEXucNj/Ulw0Wzo2Ikg69RCJcfdvrc7jBmwk+1ivpCKwvIirc6OIC5nA/3yuNiIOyZs41YhxudVOmW+2TjmW55nnFjkA0IaQZoS0Yen7qPBw9TkkPn5k6P9Dy+nZuD2N+tbAwZARCTnnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771797; c=relaxed/simple;
	bh=xU8sY/U+Epx6hzvm3hj005tB6987LtJ6SFDdcl10XMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SARUXD7cnx83k6ByY7WVdGccEjq8AIHT2QRijnuYV9WOoXp/6Wc2Xo78Y+PvybwZ3XWrQEscXEa8s0wv3ShyMDrcLlgDZusCZjeu0w05BLr5awxXyxU4hhvaUItIi5zaNJZVjYQBy+6l0cOGnFMiyeCK5J/j30xteHzEyzfITbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ah5RHcia; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-298039e00c2so13197695ad.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 02:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762771795; x=1763376595; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lDeRZdyYag4vENzRo1TPNmjEaRs7VZvYUM0bgVV1nn0=;
        b=ah5RHciatagk9ieZy3rDKP94q0y6TzWYXWC6Qm9tT7OCveuxMncgPdsZ+1bg6/HHCi
         nIlOdvLn+4E7daZXIL+lR8Op7fKvtr/ibeBana9wzrcKSHfcpenc8yIW8TapuD3Mvrxb
         RA9qiPJ0mbut1d9pzMCKeOQ9gMC+1bDNocd/LSlPR2E3k3eYqEiBF2x9XvYw0tJ8St3S
         6Jf/qJnJycO0FUJxiKhMiRzS7omXZ8/2GXuEADppV/ai9Tti1H/GMX9zvXG1Cn/OrgXP
         XNWge2oFgIB0uAMOlfDcPh/4tY3ayZNUQG9KbMSQvLH6g4jZb5C7PqtRYcNOEAO5NS8o
         NRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762771795; x=1763376595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDeRZdyYag4vENzRo1TPNmjEaRs7VZvYUM0bgVV1nn0=;
        b=hqLat0x4IA46iM2qZRfAPKqBzS8MPIgP9fIGJIjKs0wCaN/cYS8rHwjanU3gvK/0dj
         VqXRfEiPhBNerHIvPzjR+KT2MbG10EI6x40bYUmACVzyvNbBvcnwdHeHrwGIFjAHACf1
         Jktiw4GkVnrTqBJffEBUFsljhUnCKPTflBGcywR+DBp9bIFjIRNmtbB1ZWy/GoHaF8Gr
         klSP+0G+kdhDc6ollsgMe47I87yAtHanRtWL8oMe3KNDYk+Osi+bMlZgvFbSb7SuLV8C
         1NOKj8VY83TvGyqxhq1Nx8qm4I++oAVxqZ5mqjP1uTMg81iKY6atZ9Kd2M9nxyfFLolZ
         +z1w==
X-Forwarded-Encrypted: i=1; AJvYcCVO0s2bhPaCkDO7EtjiHRqOK9Xzxj+SPmm8j6Ht0wyX8RmMpXEUeLfLNt/xKPu7nbnKvOIJOlrCZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYjMDW7sh90+X7J6jxsesv/MHmdRd2w8ZFu645xo4LpjPLoxP+
	JUz8yQ+kVZcYCQwV80Keq2z6AO9Obii/nfw4gZimrL0ECEaCdAzok+GKkQFNqQpBSs4=
X-Gm-Gg: ASbGncsDIAnXl+v7pXMZahP3LXPG6ZEvsoETy36q+IjBRra1RI/IOKNtnRo2AwynVOO
	bMoiBas7djM/TDvlWhoTSBN5wsJzb7cgt/vc2d6KHCaImHPWoFHBEZTJZTpr2dWqmUcI0xd9pfx
	FUV8dzn0erJP1QX8ZGgknOqjMrczoHk2LEa+BTJC22DdaYOEMea4bo5wjdahbdoDWqsGFPfwzZO
	/OTl5y5Tify1ClfWFtoxpqeWayQ5ALdgLyADPUzLqpxhiy9VJ917axSTK8q7ONvsR4SorCp4zLP
	K4N2FfV4/iQDB95CZ9iwxcfN3SkkJIPztyc4KX7sf3CXrzZRTVGCKjs2+1+RzjaKsaCvwpdm/9G
	+JVK4IW+O2EHcJQ8Ux6fSr0WHvtqpIv82qmzEYSwe6sZFReoxCcyxPI4AJhutT7NxxUVjCP5Kjh
	mY
X-Google-Smtp-Source: AGHT+IEdNDr6Otbb2RROj5/vAfBaFYdws8NbdFblgDxxPFWLMhWpkRHK+/9t+JYyBm57B3EBrBmAnA==
X-Received: by 2002:a17:903:38cd:b0:297:dad8:f265 with SMTP id d9443c01a7336-297e53e7df9mr96877135ad.3.1762771794882;
        Mon, 10 Nov 2025 02:49:54 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968298sm144484165ad.6.2025.11.10.02.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:49:54 -0800 (PST)
Date: Mon, 10 Nov 2025 16:19:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] cpufreq: add WQ_PERCPU to alloc_workqueue users
Message-ID: <atnzuecdwp77svypw76e5z5occyh4tkswfc7rg4yqh4joeh7fn@ayygwyjdpe7x>
References: <20251106163341.336989-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106163341.336989-1-marco.crivellari@suse.com>


On 06-11-25, 17:33, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
> 
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.
> 
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> This change adds a new WQ_PERCPU flag to explicitly request
> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
> 
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Updated subject to:

    cpufreq: tegra194: add WQ_PERCPU to alloc_workqueue users

Applied. Thanks.

-- 
viresh


Return-Path: <linux-pm+bounces-9797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1898091306A
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 00:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79502885E8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 22:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1CD16FF3F;
	Fri, 21 Jun 2024 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWTKVkbx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCA216F8EB;
	Fri, 21 Jun 2024 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719009558; cv=none; b=bulKo37lv4dEtdUAAC053c/xeC+1jl0AT+jw9hAdTcw3XJMOqTQNrINLgHDY8QW2gyPnubM3ot4pYU2yI+glznXTs82J6syljm5EwvDus0eib7lJwyYwn+SLLU9koDL6aPLAb4iiZm2cjr1VkiEYvoFVUp8+CuohH9FOkLs8ruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719009558; c=relaxed/simple;
	bh=3FslPl0z1lsr0r15RJMn+3ebQ3RZ8TNFsumiLRrjTNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iORWGRS1U1zYnn08MEJCyuVrY2nZu72l/nMTm+PPSTPo03rbRrK6vlPSwYVo5VlH3ewEzlXLFfnzq/TBSbnFQC3P94kNsr3XeHCuiRjwQLr9MKjyRtBlBK+yzsIylYXqPfSAACs+vxpPTGCy1dDGhvrKdJPQGg3XDUwsOYwouII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWTKVkbx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9b52ef481so22441495ad.1;
        Fri, 21 Jun 2024 15:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719009555; x=1719614355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84xlG0RFkWqZzTZs4oPKt0M6Xd1r+ZZ1W+UC4V77keU=;
        b=dWTKVkbxRmdRez5/rKJnxViUcocG3KyIey33KIyDXRRUKpNPpYELDAMO8auPWFPMPV
         uJYgKkwQNYuiNQLFVNxRON+UJU6fZsn28C5cYPD4omPmk5G1pwm8xcLmjTYQOC5ejpuP
         q1nVe8WRT7FLAvVLIa4ath51YYQeOg78bxWXWUyIPe7rldA5BkRc1x/SLMSw473p5doS
         qh8dZs2gZJBEp/VHweHhOY9L/haREIMdOhydd2SiqyttJOrtQXNbqXf7jefBXrhpVT7+
         Kro4Dqdrso3/Q9l5q57IR2tHzLja6dCg7ajuH5oUhB6YvtpkIn/IyGdTOAr4zIDX7a0d
         n5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719009555; x=1719614355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84xlG0RFkWqZzTZs4oPKt0M6Xd1r+ZZ1W+UC4V77keU=;
        b=uno5B2bVh9r+MiYrepceYwsuJ2mxzzpovK6Tw0r4h6ijxQJSpYd6bkhma6NtzDcLCK
         JSOrQisF4UAi4ugi+ch5MuVvigvnF7UX/nI27VeJCqyxrnlKPTNc+Yf+hvtgptIP1CmR
         Qr3RnFIylDQeUaSQjkKz2JD3T2nzQobNtV31nJzPoSUVkFTFlja3/n8TPTPAX3f77cZ1
         VgSsToPQfjT1A4+9t4LKofpJGoKOg/sp7Ezd6PHYu0+Fo2zBEQRXjvxq9GBIRneh9BgV
         ftztSyKmk6X4KNJYiVtELg0exh/ICa8PloJDw9jJPT5o4K2j9AGaDWmnhHG+aUJFu6CG
         mKCA==
X-Forwarded-Encrypted: i=1; AJvYcCW/7rtbj0hOjsZGdt8hT7Tg1h6X+pUwsUdrj/ZPkqMYs2C0IxGQjYET54Mf/DP/qHkFLpewS3ZlXKTHxhmV9GYWB8AbGHPx8TiBJEyl
X-Gm-Message-State: AOJu0YylfhJ94JPyge/hQyWWckopdz0fbawuSx0tb9uHS5e7m8xTzYFB
	ya4N+HEfXP0bjNvG/ANtps0PRjLRYpyHm+JSSqZ/1S71BLOXXgWt
X-Google-Smtp-Source: AGHT+IEI8ZlgZkwjeYIY3LNhn9nbBGUfVLjL/V9WwJfcDbpobLN6+2WWlAKFXR4tNvSUqayxG3FaWg==
X-Received: by 2002:a17:902:e5ca:b0:1f6:a606:539e with SMTP id d9443c01a7336-1f9aa471fefmr109125935ad.61.1719009555258;
        Fri, 21 Jun 2024 15:39:15 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb302csm19144595ad.252.2024.06.21.15.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:39:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 21 Jun 2024 12:39:13 -1000
From: Tejun Heo <tj@kernel.org>
To: rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, void@manifault.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Add cpuperf support
Message-ID: <ZnYBEdSE3K2ukTI2@slm.duckdns.org>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-3-tj@kernel.org>
 <ZnM2ywDVRZbrN6OC@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnM2ywDVRZbrN6OC@slm.duckdns.org>

On Wed, Jun 19, 2024 at 09:51:39AM -1000, Tejun Heo wrote:
> sched_ext currently does not integrate with schedutil. When schedutil is the
> governor, frequencies are left unregulated and usually get stuck close to
> the highest performance level from running RT tasks.
> 
> Add CPU performance monitoring and scaling support by integrating into
> schedutil. The following kfuncs are added:
> 
> - scx_bpf_cpuperf_cap(): Query the relative performance capacity of
>   different CPUs in the system.
> 
> - scx_bpf_cpuperf_cur(): Query the current performance level of a CPU
>   relative to its max performance.
> 
> - scx_bpf_cpuperf_set(): Set the current target performance level of a CPU.
> 
> This gives direct control over CPU performance setting to the BPF scheduler.
> The only changes on the schedutil side are accounting for the utilization
> factor from sched_ext and disabling frequency holding heuristics as it may
> not apply well to sched_ext schedulers which may have a lot weaker
> connection between tasks and their current / last CPU.
> 
> With cpuperf support added, there is no reason to block uclamp. Enable while
> at it.
> 
> A toy implementation of cpuperf is added to scx_qmap as a demonstration of
> the feature.
> 
> v2: Ignore cpu_util_cfs_boost() when scx_switched_all() in sugov_get_util()
>     to avoid factoring in stale util metric. (Christian)
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: David Vernet <dvernet@meta.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Christian Loehle <christian.loehle@arm.com>

Applied to sched_ext/for-6.11.

Thanks.

-- 
tejun


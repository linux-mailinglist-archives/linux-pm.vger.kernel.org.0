Return-Path: <linux-pm+bounces-28626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB33AD818D
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 05:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F793A0C84
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 03:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D894F1F03DE;
	Fri, 13 Jun 2025 03:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YfRTC7l2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0A15278E
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749784614; cv=none; b=hp4rMr6B609vb9MEvVqsxrAasHim00OIy3j8l0PKj36om7s4R61oyqucqa3d+j7U0/VMObWeIOKxooj26xHkfjJaErcMXsgELkQPRcQXsQJ4Pkb0LEKZmgxHfSl04+ylCWxShIqNZrEcdeUKFMd/ydSibC9PI/ksxbEU8cjs6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749784614; c=relaxed/simple;
	bh=TulGS3xeFhRMM98s6deFwT2NXoIcoFFPD7Ay9V9fBBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE+BIfMmrR6SWLcON9m4QHZkNmRurhHmc390KNK4cUGawQQ7lw4qO2pdiQ0xvqUepbaMpJ67hz7b4Rvw7phpkrlL3tOLQwwd16JUx4AFzUF6ENKnkJnT1qxPe29mFCEQG5B0Lb8QoHfHQYR8hDn98c/I2+GujosEcfxpxJQzmOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YfRTC7l2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235e1d4cba0so16358505ad.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 20:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749784612; x=1750389412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap98I+eDUm9/OncRY5L40akvtMUL2MyqVOzfhknq874=;
        b=YfRTC7l20mMPPz88rdZ7bhGYZXtGVY2nQhj2F5VqjEw748yMrVXeHgyXXrPdpd2QcZ
         hpO3ClaS9YXb5Q4GvRfv23Vkx1Anuj6r0OlkXb9lLLwu3rlcxdzi0naT+AAJ591QNfSw
         kVH/L29AkU/aK8Mh1D0gCnr/KyqrxnU0l3AqUFSpjE2HQx7J2ghiMNRvS2cbSy2sC1wR
         Xe6GhXT/Xm1CvQ+L2yDfR/e1tPLtUqI7m9yFBQaIvypGo+TodIHXBJ+YQjXs4qjUAZla
         NPyHbMNruzisDZe9+4yluatuGbfBaPoPhFqJMC3YdYeX4BoYCnyabpHiNStQFvdSEHea
         rG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749784612; x=1750389412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap98I+eDUm9/OncRY5L40akvtMUL2MyqVOzfhknq874=;
        b=P1HiVKHTafrz0XGV00sWYfDVtcl002frlQv2GlSc6O+imjBPMovnYg4plxm6tMTzUV
         4fc5XLPv8eJUANqprCkIWfgp4id85MmquFif8nMcKWoENKot90rarfzvyuviOOIegxz5
         DakB6KYk+Fjfv2KWhggDM4+48ZCZhiSKuK41ovDxmR/MWbJ6jugOdDdOobkENljkjdHx
         jyX+jtON/2L2+7bZgZ/sM0BiTvIJ7oxFDbMNb6DLOkBH47c8wcNLcw4nnFBBazX6ZzWG
         6RSzd7vxCaGNakfpPblp+qejSu4ut3qDKt5l21G3/KwVr+Dc582Re7qAV1ffmOKFaXm2
         qLuw==
X-Forwarded-Encrypted: i=1; AJvYcCW/zk0+6VkRjluMhQ5kRrJ/c2ksViEpY+STdx5VnvYSbL6jnUqcQeyfsaLGFJsEGfLX7psn0Hz60Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp3N4Nfhg8/HLcbOmvJls2Km9m+a1iCp8O5PzckZeEhuY2uzNP
	TmNeX2hN7+6Xn6ITQJCOyCl4KJuAZVITrHKmSIN/02j4GA+HBCQ/M4FvvIxq+q0zZF8=
X-Gm-Gg: ASbGncvr4B/2yjmUn7+0+MXoHzjPqElmfcXjaYtM+r73QehwS8FnJ6CULE6RxlXq9Ul
	19L6EvWxdjT2NGwEFtwyFhKrq7lkScpEkKuz13Ze6m/f17qpPJFITKBeRYLY1Tad76v198Yved4
	njUhn27eDcjMIZua4Ec0r83ZNkBCPSYJaajtrVv+FlOuYF5FdtrybeguOl9WM415svQoFKTyH01
	OqICRQkMr4DxnniFT7ZxmGyxYInxDBifJI03EaRT6xa42QbOIS4K8NFdHy04Vp+bTh1LaHgw3II
	wCo9dHvDMUnUelEidm/b12Y6HP013LXLYERlnvrvzvGA1e/hAsQVBxtnCA2nm3w=
X-Google-Smtp-Source: AGHT+IHNXC3txXNOUer9QYDOQjxZSJ6IgCaYAHTJUBWcCsiS3vra7fop+grtC6B10VdAfwH4GdqnXA==
X-Received: by 2002:a17:903:228a:b0:235:f70:fd44 with SMTP id d9443c01a7336-2365d8bf339mr21709775ad.21.1749784612494;
        Thu, 12 Jun 2025 20:16:52 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea8fe6sm4650285ad.164.2025.06.12.20.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 20:16:51 -0700 (PDT)
Date: Fri, 13 Jun 2025 08:46:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/4] PM: cpufreq: powernv/tracing: Move powernv_throttle
 trace event
Message-ID: <20250613031649.lj5zdvw3wl6dtfft@vireshk-i7>
References: <20250612145310.563358597@goodmis.org>
 <20250612145407.906308844@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612145407.906308844@goodmis.org>

On 12-06-25, 10:53, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> As the trace event powernv_throttle is only used by the powernv code, move
> it to a separate include file and have that code directly enable it.
> 
> Trace events can take up around 5K of memory when they are defined
> regardless if they are used or not. It wastes memory to have them defined
> in configurations where the tracepoint is not used.
> 
> Fixes: 0306e481d479a ("cpufreq: powernv/tracing: Add powernv_throttle tracepoint")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  drivers/cpufreq/Makefile          |  1 +
>  drivers/cpufreq/powernv-cpufreq.c |  4 ++-
>  drivers/cpufreq/powernv-trace.h   | 44 +++++++++++++++++++++++++++++++
>  include/trace/events/power.h      | 22 ----------------
>  kernel/trace/power-traces.c       |  1 -
>  5 files changed, 48 insertions(+), 24 deletions(-)
>  create mode 100644 drivers/cpufreq/powernv-trace.h

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh


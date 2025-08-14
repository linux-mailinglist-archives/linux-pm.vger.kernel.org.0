Return-Path: <linux-pm+bounces-32415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C10FDB272B2
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 00:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED171CE051E
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 22:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEB02820CB;
	Thu, 14 Aug 2025 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WMZiefd7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460E27A906
	for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212181; cv=none; b=m0UwEgIsLypXfd7YP/wesbURIVHNWVMGB+cqK5mPtbM0nwAZQF9Vgg1/NCPpptMtBSfkW7qf489IPguStTpJfW7ejpb+6V8Y0b2kZKh4atP9nlgcrk5lUJEYp7+Gs68ru/r3EMRsL5LSHt9vWb7+BTYM4hdQ6Bja6B7o76FVlyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212181; c=relaxed/simple;
	bh=TuQdYyfC1yIWhxjScSpcNegwCVaacUXhoF1hDJbeJi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KATJfRO4Uzd5yiAnmLDOUoUHdL4Dh20FA89Ut0mGL/p+E5qBAFYybPh7JNQiwYnKeU6yEKt/l+QENiik9kAVYH3S0i9lg0mpq64MRUQAxy3/qXK6Qtm9hkr83/hM5fs3y55+baR35rBqUcdx0UuOYaLhQAbLpyJYkd6CSBgvb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WMZiefd7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b47173749dbso899968a12.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 15:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755212179; x=1755816979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wcrBnBmOS7pCtFakKhA5D/9PwZjIEBEaJU2UeFpetNc=;
        b=WMZiefd7EEBvmIqgx+vkFbOiCPwgt81mPJmbhuRZNFKunRh0XcpxywCB8n0edMd1fm
         tj4dggWHlTXtEY8dxheksC3P/sWIN2rf3aDXUgOC548sWom5ko9rd53szYYJp6rkMEZW
         AMXZVCOnjq+fXXqoMbZZIWunFxAAXAiuudxTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212179; x=1755816979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcrBnBmOS7pCtFakKhA5D/9PwZjIEBEaJU2UeFpetNc=;
        b=gWkPzgkHIwM2EVgpNanaRoM/WUS7W5t2D3ssT5bRtwwnWDMsIBP18khkioVoq3rZ2+
         B9uw7EN34lcFN4fwXhCSPLww4jBeKMNEmupCXeNE4olU1ON34Jl+RmX9RDxeHixVWTp6
         SplaAeRSUimj+2fUEQr06ApjHW4WCatskjrnrshWCvnsIdz4IlSgGqafebF8lj75hiO+
         EXc1lTyboAeQoODlX42MM3qN6tTsfIUwPgbf+xTG53i49qj2K+5NSmSV1N5HS7TCkc6v
         Ty4dKK6pRuf1k8t2WmJIjT9d52Q501ZG30vJXBckD/Th2fiPirbBvr83pihiktrqjD7k
         dkQw==
X-Gm-Message-State: AOJu0YxF7/vw+DEcYGXuMxU/wfthHilzGLAFu0XPWjGpK0Fi+f/kqma8
	5QK66vFBVy+uXpbp8WY5HKKVNe0l7qJjvA0Xz9VjubkqhVlAeH3Fr8JN2ioftI8MYA==
X-Gm-Gg: ASbGncuO0DFAYcuibygPLji/ngiEEnRUr3xyo/EHgB5fcn8gb5any5O/pFYxipPFoOh
	jamfxJeafuAa9RRBpZh8D59lJOqgcIS5CmDfHt62Gd2fvT5gL1hlLptoNXWpnwJUMf4k+32D2e2
	7ZxoAesA0OJaYuTqSZfAfTvoi94UT34G19kLb/3mbBOfATZKGMMF2JaHZyopIBgUvje+B4xvsmJ
	EbAYR3nneSN0DIFLpefK940aj5Igqwu+jMY5VaalH06vdKZzdfajdEwu2sf3xCo+EZRBjEaJ8kX
	EggMmqqDU6/Qx5T4hRimJJIO3vGhw4XeBCT5NpBmk4P5PB408MOAXb67oVtg3kGyhYglv38gcaf
	CPPQLb+GnA9CButoM5xociV8I5OOMSgc2Ldgf/KYLGVY0i+ir/iqWsXAxwDLB
X-Google-Smtp-Source: AGHT+IFKhveKatQOIvJc1bpP9TW96f0hvtojyrJRdLEgZ5SXv1DdmapB8La5Xfq6q01JNnvP8SEd6w==
X-Received: by 2002:a17:903:2d2:b0:240:640a:c560 with SMTP id d9443c01a7336-244584fe05emr81234325ad.24.1755212178838;
        Thu, 14 Aug 2025 15:56:18 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:8aeb:b204:6721:5e9a])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241d1ef48fbsm362033935ad.36.2025.08.14.15.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 15:56:17 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:56:16 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 1/6] pm: runtime: Document return values of suspend
 related API functions
Message-ID: <aJ5pkEJuixTaybV4@google.com>
References: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
 <20250616061212.2286741-2-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616061212.2286741-2-sakari.ailus@linux.intel.com>

Hi,

On Mon, Jun 16, 2025 at 09:12:07AM +0300, Sakari Ailus wrote:
> Document return values for device suspend and idle related API functions.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

I appreciate the documentation attempt here. I've often found it a maze
trying to weave through the indirection and figure out the actual API
contract for some of these.

But I have a few questions below:

> ---
>  include/linux/pm_runtime.h | 147 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 138 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index e7cb70fcc0af..9dd2e4031a27 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h


> @@ -464,6 +525,17 @@ static inline int pm_runtime_resume_and_get(struct device *dev)
>   *
>   * Decrement the runtime PM usage counter of @dev and if it turns out to be
>   * equal to 0, queue up a work item for @dev like in pm_request_idle().
> + *
> + * Return:
> + * * 0: Success.
> + * * -EINVAL: Runtime PM error.
> + * * -EACCES: Runtime PM disabled.
> + * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.

^^ Is the "usage_count non-zero" true? For RPM_GET_PUT, we drop the
refcount, and if it's still nonzero, we simply return 0.

> + * * -EBUSY: Runtime PM child_count non-zero.
> + * * -EPERM: Device PM QoS resume latency 0.
> + * * -EINPROGRESS: Suspend already in progress.
> + * * -ENOSYS: CONFIG_PM not enabled.
> + * * 1: Device already suspended.

This part isn't very clear to me: can we even hit this case? If the
usage count was already 0, we'd hit EINVAL, since this is a PUT
operation. If the usage count was non-zero, we can't already be
suspended. At a minimum, we'd be RESUMING (e.g., an async resume), no?

>   */
>  static inline int pm_runtime_put(struct device *dev)
>  {

If these are indeed errors, I expect they're repeated on some of the
other related APIs too (like pm_runtime_put_sync(), pm_runtime_idle(),
and probably more).

I ask mostly for my own understanding, but I might consider patching the
docs if I'm not hallucinating these errors.

Brian


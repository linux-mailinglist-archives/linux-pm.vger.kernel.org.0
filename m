Return-Path: <linux-pm+bounces-40230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4324CF5AE4
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 22:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AF3D3109EB1
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 21:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4B92F5A36;
	Mon,  5 Jan 2026 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SxOMrIet"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88973279DA6
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767648702; cv=none; b=XfPf3MRoLaoFlSDRkjr/sykIUi6BdyeXnhY3use6qfUA6ozIQv4lXzusBPlt3W0fqdHNK+7oHnWDgddkB6zE/6SESdlr8rtCL5kY9bVCbBHAa/WoXeUVnGy3zvyudnEMi6GbVHVKgg+o8HqgUynp81mCQieAI7WfGgzNTsa5zng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767648702; c=relaxed/simple;
	bh=vPp3AvTGPchLW2c+AGwJirbOQoWxFBkOxQEfOGFlo5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqm2Y7iYlod7OVqtgXNkOH3eigccSqz4I6E0KTizH+Nh0YHF3mTg1nnCLLSYNPqn/dTrjKcaQuxzUKYrq/cph3ZprDtk8gcZJvS5nluDc1AHr4lRtr7YIjoRY8VTIvJSr6ebYnO6K4dWfDSeFtE1430k6j4SA7ay2U4OBbuek+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SxOMrIet; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c0224fd2a92so259712a12.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 13:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767648700; x=1768253500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLE/vO3ZvnLaOBduDAh1SAq6McjdOl4HC6YjHnCaxmk=;
        b=SxOMrIet7JfKlkTB+MNkBl05ryUqtI6mSdQdkby4YxvwiNVLQwaV+4/knhONuWuXBR
         4JbXmUWqWccayE4HTctV0vnvBhW0XYh2xYQHxCOpzLaCHthiiAz/QHwzeC4VrVnechvz
         bwIwWyd59EzOIQLAWT8wwscaePjMnO2EGlyzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767648700; x=1768253500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLE/vO3ZvnLaOBduDAh1SAq6McjdOl4HC6YjHnCaxmk=;
        b=Kb2FYZEq+rZA/A4GaDPb2c1wSsMaRaxuuYyuAw0ERhJrvKBPbqg9i2MO4OBEUmgeva
         /LHjglqKU5CSZKZA4df77HELZmXQlHPUQY7DnOPzfGEAe2yOc38Z7mKfo2pUsMQY1K0q
         RyIrcovV+Dynry1k/dhkLB06vXc+BeuMIgj2/s1KIKiNqPzDL5TBiNSmegAq5TUSFKh5
         4VWIBxVqm6rmJEjk4doQr4OWTDU+QOobclJmiQ/8ZzhtNa/87f3j78fNy/MboVJyBVT4
         Mrx9BSPMSDiBeaBElxLITWcqZNRrFtHPetu4EU5Ru1ZQUh+/RdZCmoGXxX4Oyj0VYAox
         +kDw==
X-Gm-Message-State: AOJu0YzOI8gU8y+IoKmRxJqOpfHEs2EU0rVYzvwi2PUG8es68yCiF6zt
	fAtg+YUfA2ZZpcQdtCsy5F84bREcEj0d8Klfu35pft3MC5bCmH1XSyJoMVgfRMJdHocTRMdKQO9
	nS5o=
X-Gm-Gg: AY/fxX4xt2sliynndnbbRI3UUD1xjaVNBlpK2qppy1m1m7KwlZh9zBw7fN8cktcUqZo
	Xuwv8uoUp1QS+7dVbcxOlrjv9/MdnWikTnT9ZrYXBGWpiOqMzZyFw3UI+raZQy3f3vgk2YulAIU
	92v5N3Vne/2dYvABYk51AOQXMFTFtV174ykAFc+5ER19Qs3hdhbm7Nlp+fmjdDhs0fgxSTwFn2B
	SgDybRy94CbG+LLsuzZsA0FKuFeIIkwpM5CYYpTwE3K9BBWFta+FxgcjFDS7vyli0+1moMfOfjw
	dsMAi2YA1bGfhBX3/Z2otohW/iRz1OFJH8qBG/g6PqtHxpXRF9Q2Bo5JftgCgPxNKZfn5oyYAcI
	5RX1LYPunrlCzPRGwmR8x4XYbCUYn1DxrIpRWrIpdP51WHEXQRKjwbL7P7XG7eASEOxc9Vc3Wo2
	jf6EXrCXNminFYWOr1PSv0OZMnOrz2gS0s+GZ+I3e7+XM5J3+ipw==
X-Google-Smtp-Source: AGHT+IFJ9JDeRFynFjJTq4iT72J0gsfQX5pc9IxuV9lkM7nLv2iM1FuklTdwLW++i3XlTEDta9dRgA==
X-Received: by 2002:a05:7300:b295:b0:2a4:3593:6474 with SMTP id 5a478bee46e88-2b16f92f172mr559835eec.36.1767648699808;
        Mon, 05 Jan 2026 13:31:39 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:526d:9db9:4a72:4149])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b1706a53f0sm498920eec.10.2026.01.05.13.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 13:31:39 -0800 (PST)
Date: Mon, 5 Jan 2026 13:31:36 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 23/23] PM: runtime: Change pm_runtime_put() return
 type to void
Message-ID: <aVwtuIfYH6CgQDP_@google.com>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
 <14387202.RDIVbhacDa@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14387202.RDIVbhacDa@rafael.j.wysocki>

On Mon, Dec 22, 2025 at 09:36:25PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The primary role of pm_runtime_put() is to decrement the runtime PM
> usage counter of the given device.  It always does that regardless of
> the value returned by it later.
> 
> In addition, if the runtime PM usage counter after decrementation turns
> out to be zero, a work item is queued up to check whether or not the
> device can be suspended.  This is not guaranteed to succeed though and
> even if it is successful, the device may still not be suspended going
> forward.
> 
> There are multiple valid reasons why pm_runtime_put() may not decide to
> queue up the work item mentioned above, including, but not limited to,
> the case when user space has written "on" to the device's runtime PM
> "control" file in sysfs.  In all of those cases, pm_runtime_put()
> returns a negative error code (even though the device's runtime PM
> usage counter has been successfully decremented by it) which is very
> confusing.  In fact, its return value should only be used for debug
> purposes and care should be taken when doing it even in that case.
> 
> Accordingly, to avoid the confusion mentioned above, change the return
> type of pm_runtime_put() to void.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/pm_runtime.h |   16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)

I'm always happy to see rough edges of the runtime PM API sanded off.
Thanks for doing this!

Reviewed-by: Brian Norris <briannorris@chromium.org>


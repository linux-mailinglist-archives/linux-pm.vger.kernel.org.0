Return-Path: <linux-pm+bounces-4419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61672868697
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 03:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927CB1C21CF2
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 02:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA9FEADA;
	Tue, 27 Feb 2024 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VN3fDdh0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007417BB5
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708999697; cv=none; b=fZjln4IxvICajHGIikHk/azhAfcNzJ/KEq4WLjgAblQWfSzUMXmi5U+MN7iyuELiRmwlG/AXcDhri+CNT8b98W0vRO+ATIIHHxqSUo1Mjbysxf96AwSM6a37FCzVhx2SfV4p9eP2T6EUdVqjfnhEP1wEHAMZQCrPij+J4w0BdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708999697; c=relaxed/simple;
	bh=1nrHMmEG51Sj437E4s1EkfyuxGl2jRLjyHs/cGUfhXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuzAfuNsnb2XHo+eyDlGvFR0VtL0Ml5GSAvwv+eTvkHdyIQ5LQNbCyndcN5F8rz7+bm8JGpOr4TYDBsd80sqLNxMKBVqttbW69L/Lh4xTC7vqKJU1+DGGLlMeR2e3DAGELRHOpYG3a/xGgyblbnso0UeMhGt4tDreYWHlifCB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VN3fDdh0; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2960362a12.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 18:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708999695; x=1709604495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oVkpTbipxCiUrmv2gBFC6axIfIqg3FWn8ARyZarMPgo=;
        b=VN3fDdh0y5kZtNXMiVduELns1/LtGi0eSX7gEYeiZJ45KXPE9TRJg+vqINyXbqLYDh
         6Gdt2zD00qOTn439iZfqo6Cq7A30wkr755wXL8M326ysJUmslnHeUvGPQWN6P9tyRw9v
         shuuA/mFvrsuO82KKvuAgR89tD7FkSEsreLrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708999695; x=1709604495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVkpTbipxCiUrmv2gBFC6axIfIqg3FWn8ARyZarMPgo=;
        b=C3kRCRNWY84Ru9m+2zJxhMwJ0qkz4uKavYl9id/eS3/lr83FuoanOGfcvzA31x9N0t
         0qV4LSYnK77AN3JyprgedUxE7gF063+RRpEcReqdcqvGbHe2VD3W3GZTnuu330olHW9p
         vvaB8Jx98uHS2yOczgSmQ+Cz5lnFG/HlpE3zFKpimLrUY5nMxZ78kH4nbEJvN92fYEO3
         +LV2oGCKzwpqK68Qds+NLJHvyNOVo9NpWQXoG9Pppek0Ge2KHOyMgvpc9aEoQ/F+KpDH
         gPIS7OaChsQu2u0awlQGoGPfV/sVqCCgmtwocQF3zUS4Ezk/Ajs3ggcutNBzVcqTNhYu
         qlZA==
X-Forwarded-Encrypted: i=1; AJvYcCUaSbm/1vzJqEcU8yEQHOG+CMVUySY2EpM0U79LshGPK6zBDrobu6RYUfqOTVhiwkr2vRRIL0eVAz5D0imHhwUuO3LxbL+mcQg=
X-Gm-Message-State: AOJu0YwvpKfjIZ2UoOlHIsaHNOvndr7IOggazamDbPDWVBFngJfyTIaj
	F1kFJxglf7SWticYmQi8XrNYFtzbpZhEDhejIrLjFs47dRV0O1qDdC4XWOa4dQ==
X-Google-Smtp-Source: AGHT+IF6zdQ/2mc8pHy3ltuh8A68wKo1/k8qw2couBJUhs2wfECHjSq4AtVGKGBQE7knMNxjo75dzg==
X-Received: by 2002:a17:90b:124d:b0:299:32ee:a426 with SMTP id gx13-20020a17090b124d00b0029932eea426mr5747343pjb.32.1708999695238;
        Mon, 26 Feb 2024 18:08:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s62-20020a17090a2f4400b002992f49922csm5774240pjd.25.2024.02.26.18.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 18:08:14 -0800 (PST)
Date: Mon, 26 Feb 2024 18:08:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, gustavoars@kernel.org, morbo@google.com,
	justinstitt@google.com, stanislaw.gruszka@linux.intel.com,
	linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] thermal: core: Move initial num_trips assignment before
 memcpy()
Message-ID: <202402261806.A8340C71D@keescook>
References: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>

On Mon, Feb 26, 2024 at 05:54:58PM -0700, Nathan Chancellor wrote:
> When booting a CONFIG_FORTIFY_SOURCE=y kernel compiled with a toolchain
> that supports __counted_by() (such as clang-18 and newer), there is a
> panic on boot:
> 
>   [    2.913770] memcpy: detected buffer overflow: 72 byte write of buffer size 0

Yay, the "better details" output is working. :)

>   [    2.920834] WARNING: CPU: 2 PID: 1 at lib/string_helpers.c:1027 __fortify_report+0x5c/0x74
>   ...
>   [    3.039208] Call trace:
>   [    3.041643]  __fortify_report+0x5c/0x74
>   [    3.045469]  __fortify_panic+0x18/0x20
>   [    3.049209]  thermal_zone_device_register_with_trips+0x4c8/0x4f8
> 
> This panic occurs because trips is counted by num_trips but num_trips is
> assigned after the call to memcpy(), so the fortify checks think the
> buffer size is zero because tz was allocated with kzalloc().
> 
> Move the num_trips assignment before the memcpy() to resolve the panic
> and ensure that the fortify checks work properly.
> 
> Fixes: 9b0a62758665 ("thermal: core: Store zone trips table in struct thermal_zone_device")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/thermal/thermal_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index bb21f78b4bfa..1eabc8ebe27d 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1354,8 +1354,8 @@ thermal_zone_device_register_with_trips(const char *type,
>  
>  	tz->device.class = thermal_class;
>  	tz->devdata = devdata;
> -	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
>  	tz->num_trips = num_trips;
> +	memcpy(tz->trips, trips, num_trips * sizeof(*trips));

Looks good to me; thanks for catching this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook


Return-Path: <linux-pm+bounces-4456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 043A4869D04
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 18:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39852861F9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 17:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EE13839C;
	Tue, 27 Feb 2024 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h8IsAKtw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8EE25757
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053249; cv=none; b=HO329wqUQ7tDpsdoQ9gZXEh3g5wZGJ906c6LwZWmStzmgOhiNcMd9Ya5Og8cBf1edUwQIrLkynI/gsSjVrD9svFN0lcK8uCT955dXW5viZNojjoapS/RozavLKJEKsYwdz40HhuJsKY6G8H7a5ud75Owadi+W4knyydenYsYTKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053249; c=relaxed/simple;
	bh=kaZPwy1DnnJwKmEiqW49+N4tGBugK5KqDPoQuOPHqX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PONRKASsTCwjsONT//4cLEi0z2u46uS6z3PqZ5BrVQAw2w22sBufhEQG0iEBELUMNbZjgAau5tB8xmNx1GQai6w+2Qx9XsJTnJFVUm2+OKGoEGlpdR+bTRgkzKetYLx432XI91SGafQgQWVUnffcDOlJVgI++Qzy14n7aCC5ZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h8IsAKtw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-299a2456948so3138532a91.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 09:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709053247; x=1709658047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVB/mgTuOok+gnoF/FjLnOVs65Yn1KQT4qK8xBXRKZk=;
        b=h8IsAKtwLq4NbTtRLrIFV/bMl+10yUh/J82+Opm7iJASboxzGvaKTgcwZqzXnDZObH
         Tbd22PMnsydlCmb3JVxTJRSzQXgCmTJsHhtot2yc5FH1XYVHRQ0sVeorvjCuPnkzWQoG
         +Gl+OMMdAPMS20IqC2Jvv5q5Lqrl2xpYWEZ9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709053247; x=1709658047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVB/mgTuOok+gnoF/FjLnOVs65Yn1KQT4qK8xBXRKZk=;
        b=p7nCio1b+GvSi1XFEbqwCSztjPmZrKvzl+rkanh/soJ9plBq7FH1GQjp9JhLvjHlo8
         NuY0ZvjNWvKDIOzZtqMSoVBP/djMzf8GvxwLOnag7BilCP+bDww7YJpadBTSf9nfqFUW
         ljTxWji0gZrXmsBAuSR4bXvYqvAQDtIxrXaX683a/NikCCh7tiSQ4Eku0BvPbBoL/Bee
         iqlwGFdZ8bZYXBTndpM9i20mHvi/MHSW7Q/W+O7yAGLM1A09EsUHwYlWfw1Pv+2Xwawt
         zqeY1PhfZgmPJYsZbJHUHZx0Ta1/glT/v4sVALFJRluwGcjLDKWmKFaofdikfd+CrWdP
         AfpA==
X-Forwarded-Encrypted: i=1; AJvYcCXMXiJsV78YAM8bUDStDoIO337msqyE8vZpdn9h+oBOC1TT/xda5qu2OAhUsA5/YEaJsL+xF/2GFlrO021kokGcRtm3VOY6zKA=
X-Gm-Message-State: AOJu0YxZIzroXOmz2nr7HNSaRbPRVBKEubTbp1C/zEdYiyk3Z05nrc1l
	FFUP7vCKw+SrEn+9jkpuYQj2d96rR+t4sl7Y4gxTidTM7uWAUOyP9EtJpSn72A==
X-Google-Smtp-Source: AGHT+IFg0NCtYbETJpvRCOpzy0XTL7KtmhpC1VhxZupEkO0MpW4B3yevf7ZLibVvBRAtyz/LEba0cQ==
X-Received: by 2002:a17:90a:d90d:b0:29a:a39e:e651 with SMTP id c13-20020a17090ad90d00b0029aa39ee651mr7555235pjv.11.1709053246818;
        Tue, 27 Feb 2024 09:00:46 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090ac88300b0029a4db713b9sm8760981pjt.39.2024.02.27.09.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:00:46 -0800 (PST)
Date: Tue, 27 Feb 2024 09:00:44 -0800
From: Kees Cook <keescook@chromium.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, rui.zhang@intel.com,
	lukasz.luba@arm.com, gustavoars@kernel.org, morbo@google.com,
	justinstitt@google.com, stanislaw.gruszka@linux.intel.com,
	linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] thermal: core: Move initial num_trips assignment before
 memcpy()
Message-ID: <202402270852.E46A5268@keescook>
References: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
 <6a6be01d-3453-4268-8b2e-0279cc20835d@linaro.org>
 <CAJZ5v0h87k6xoi-9V0Cfb2rHQcr-STfG_bNWpzfoj4Dy46U0Lw@mail.gmail.com>
 <f81af0ae-7458-47d3-90ae-71d5217ee7dd@linaro.org>
 <202402270816.0EA3349A76@keescook>
 <bbc65508-eb0e-4d63-921b-85d242cc556f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc65508-eb0e-4d63-921b-85d242cc556f@linaro.org>

On Tue, Feb 27, 2024 at 05:47:44PM +0100, Daniel Lezcano wrote:
> Ok my misunderstanding was I thought sizeof() was calling _bdos under the
> hood, so when calling sizeof(flex_array), it was returning the computed size
> inferring from the __counted_by field.

Yeah, sizeof() has a very limited scope. __builtin_object_size() has
more flexibility (via the 2nd argument, "type"), but it was still
compile-time only. __builtin_dynamic_object_size() was added to bring
runtime evaluations into the mix (initially to support the alloc_size
attribute, and now includes the counted_by attribute too).

-- 
Kees Cook


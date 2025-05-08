Return-Path: <linux-pm+bounces-26882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE5FAAF79A
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 12:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC411BC3305
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 10:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DB21F5402;
	Thu,  8 May 2025 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IEwe50iX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9537D17D2
	for <linux-pm@vger.kernel.org>; Thu,  8 May 2025 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746699321; cv=none; b=OUHyWPGFqRNKZMyXZz1t3w//bbOtefOJ7D/Ah/MiBqBEYCfKGoJChj5WBHVQni/TD25R/xXczsvNjXj+V8e8CwA/vwLPLnePZOYFXiOkC6vR9l0oAMFrydP5LR+Z8OsM+DYAkLARODCqZMV9uyQ1YYciKSMOh4DXXH37ovXvcDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746699321; c=relaxed/simple;
	bh=qhNsKNLNw5tmwB3UAIDERkC8dHitaFy99n00D7sMtvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dETJ3zycajtq8TtCMh98DCZuKmW32Yx7dRU4fBhPcDvjKcm2Y2Al6Bt9nVzydkTyjlTQkhDSp00vQMxweMMz8LrmJGPhOlMu0dcpLeWu1qvvT2vPmsfygAIIHvkrMszmRyc1DUEH0a3zJ9N59NvMNXmncmivh+r9T99ChQ0FIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IEwe50iX; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e7569ccf04cso824423276.0
        for <linux-pm@vger.kernel.org>; Thu, 08 May 2025 03:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746699317; x=1747304117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gpNKcie2UhGLpgDU+EfoQWjK/q5dcvHwia1KJeJcP0Q=;
        b=IEwe50iXy+VAW6dWq6aFlqUo6/kvIHAy5zsrJeV5WqOniEaizm+QpVTzvAtiDU6fLj
         VHvWROTzS+NJBP0XBcFR1Q2WQFZ42nYEQqX9CMUJLqi7zfgFapgK7uu3vjY0YKQMYVy7
         qNfh2G10V+io7+iwENa5VY2pkfyCiJRIuwbFv4qF+GNtJzUIxEc1Q5A/etLdxrcpA/9R
         RAaehVuSzY0rP4mQM63SQfykZnPUpQgmErVoFTUSKooJPBL4DNhzzSWsQ+Pre6y0gDs9
         u04RpUTzqqFGJ28r4LVrsYHtKSmJUJ/vtI9tEn8bn5CDuoDXLZn0gN9CFfd3Mjd9B5AJ
         g1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746699317; x=1747304117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpNKcie2UhGLpgDU+EfoQWjK/q5dcvHwia1KJeJcP0Q=;
        b=nU19QqxQkMrujxJlpq8NFoQ2bQApapeX5v+hM86EVsTLSmbypYbCHXaM3YniytU9LQ
         eEBMhkKxpPDQeQJUQLghTONqMJGqDwGMYYnTM3MR6UYsuvlwpOQwaV3tFssAJPlEWSbV
         IBU6AyuigoHzr8qmoaf+hRDMAxFSUtLhcsw6Z8j6/CCafIzdvECIOzeOyR5wrdc6r0K9
         rm7dEf8FKkNtZN8gZW0jagHbhLiIEgsgwCEmh3bG09toeZ0nm50w8/Us0DR3w5PIK5xp
         UiIf52T2P9UreMBDz7Ij2cUOsXfAqEgJ4s5C0Dd3YmtzRKWFx4Ls+HedyOZFS+KQM6n8
         MokA==
X-Forwarded-Encrypted: i=1; AJvYcCUp/hOnuFe9LyP4CUQJBfKzyL7AlbzMnIDCf4SqWBcksH4RGqW/rdCKin9fg+9u5PZCy3wmTLbwMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBOdAQneMfXdx26V+HWs2oamd5FhEWq5lT3SmcMkFjpgMwn3aK
	6+LZUlV+fPi96rG44WWL8SbM3fC/8HmgAD4KWF+agYmgxHZmQ2033VLegd5krkersBMMnXxZBkO
	QSu9dBXkyEJjyvfJQXdCATGfu5w0bTvXIXeYgWw==
X-Gm-Gg: ASbGnctzWQQjPiqX3Y6Otkh8wG/o0Mq8BxTPk+yIR4AuIogN++eoP38kF+ziOAg6RY3
	ejBv3exUT26QWhaYgg9b+8FFK1ulnbGyjm58nNOzJabyKFEcywtJWvwtMdVkA8arsnER0hga7nh
	5dYiSwuYN8hRlwhpffAp7JqmQ=
X-Google-Smtp-Source: AGHT+IFZR+3HdpndujRIwAKAXYMyHzJt6gQWJhlrflCknDzCNNPyqtjJEyMg55oFZwNVRamj1dH6embSLYS37XFNcDM=
X-Received: by 2002:a05:6902:230f:b0:e73:1ff1:ca2f with SMTP id
 3f1490d57ef6-e78ef6f7c55mr3056251276.32.1746699317373; Thu, 08 May 2025
 03:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aBxPQ8AI8N5v-7rL@stanley.mountain>
In-Reply-To: <aBxPQ8AI8N5v-7rL@stanley.mountain>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 8 May 2025 12:14:41 +0200
X-Gm-Features: ATxdqUHgbU1sftWGZFEYCFbWV60qCjH22SvLEOP-bV81E5it0iQHN0cHPsZak-8
Message-ID: <CAPDyKFoZiEAn8yT8a9VZqayR1=HPnMn+a51O3zUAUR3L6RXH=Q@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Fix error checking in genpd_dev_pm_attach_by_id()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Niklas Cassel <niklas.cassel@linaro.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 May 2025 at 08:29, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The error checking for of_count_phandle_with_args() does not handle
> negative error codes correctly.  The problem is that "index" is a u32 so
> in the condition "if (index >= num_domains)" negative error codes stored
> in "num_domains" are type promoted to very high positive values and
> "index" is always going to be valid.
>
> Test for negative error codes first and then test if "index" is valid.
>
> Fixes: 3ccf3f0cd197 ("PM / Domains: Enable genpd_dev_pm_attach_by_id|name() for single PM domain")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks for the fix! It looks correct to me!

What puzzles me though, if this is a real problem I am sure we would
have been receiving bug reports, don't you think?

Kind regards
Uffe

> ---
>  drivers/pmdomain/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index cd4429653093..ff5c7f2b69ce 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -3176,7 +3176,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>         /* Verify that the index is within a valid range. */
>         num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
>                                                  "#power-domain-cells");
> -       if (index >= num_domains)
> +       if (num_domains < 0 || index >= num_domains)
>                 return NULL;
>
>         /* Allocate and register device on the genpd bus. */
> --
> 2.47.2
>


Return-Path: <linux-pm+bounces-14133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F90977CE2
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 12:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A181C24B81
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6121D6C4D;
	Fri, 13 Sep 2024 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EE+xqlTm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF021D6C47
	for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221972; cv=none; b=kbcRxMtL8MxpheVC2P/L9tg9iKJriA3ifn/h/l6ZxjIvs83e+oRcMi0P9VvKt9Obd5ZLFQv1gZGRtaInUKuxxy27pLRA5KD78mXuJz0GloX6WegFEN2ktbW+YXlcTMS4LgQaYKtcFXkhMRvezW6Srh9A4+6ZcfBjYUgX6y7bKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221972; c=relaxed/simple;
	bh=h0dHyMTecMwGQ8g5Pbl4LrmGMguv0lNiZsBtgT+cFDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orIzTUs2mhH0uF0V+hIlWDD18p6wv1l4UrCCpfjzvN6pwwt13novJ4ig0tOPEPJd8mHk4kXXguNULpYOISnoknS+J5jj4w0jYWNX96d+whQZodPM1Qd7Wlav8iaG681eiJQTE7ajU3ixu/0qsKBTZKCC6Lw4RzgiyftL6Zee/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EE+xqlTm; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1d0e1bffc8so1916823276.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 03:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726221970; x=1726826770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JaPQBzemrMXh8Nln+1kZCDqId0bwswOL4QtLu+Mpca8=;
        b=EE+xqlTmfQqqs33Pz8oHKaL77XrEErGeSlvP5cLJ4HGOp2z3/29JFRfHuGLYf5Eevu
         ruYZjivFF4navnztuRBzSe7p8Ii896yjMJkYgklKAcKL3O9LeWc0rp3wLleaJGyHxT9M
         oBivF2QKLUa4H9GNGghRCyL8xuKFXF/ZHUpcVDMrPk2Od86MA777LZPLqg8Oo/578UTN
         ltFhpWj0A7XJK8otlgcZfsz03lWFdW/4ezc420FtX+bh8aONZROQUUArf/p3DNO+TYRf
         mbBFBVuKat0gXutJEjT97sesAwE2BodkvsF39hCIwtg+ye3atZBM/fmfsiBbzirE5Ygz
         tQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726221970; x=1726826770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JaPQBzemrMXh8Nln+1kZCDqId0bwswOL4QtLu+Mpca8=;
        b=mnxYZwVe5y3nNvHu1syogLtlLJfXUqCs2bRHJzS67GBbyHFsJC+F1+lnYMSRt3ZUES
         0WMvtXEhBG++TepFvjcIttxjZeqWSVPzO9aQC8AmfiV0ElfjnD+YbLCttUa/ljnRA49y
         IdJjbfD3mGLmgVuNpNN+O0oD5o3u4vbcdRz1mqioLLNqh2hjpyrJslpdqXcOmGdXAw4S
         OAx2P329O9/MklBWBc6rxBepfwdtCGwUk//7gd+CuZpwbHO/NXXAlplxJSTraoQrUrpl
         TFmF5NBQf8ilkdUVMm8Gu1K9/EOk0GF3e7lmXj/K09nVSA8VY48NO4y8JfWVxgVa+ip0
         mhkw==
X-Forwarded-Encrypted: i=1; AJvYcCVcffZ8E0xgGoENkLt51l/T6MItr10kY+AoKOsOO9zlYBT+c8WEGFsAgiVqGTmV6HxqvzaMKrX25w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdM7e19d1ACXq1qRzThzA+Z9uyws5s4rAvO37oaX/nGDAIEOm
	5ePSH1/dYxl60YfK0ZGTBdnVPsCxbpQvte8EEnTHPlwyD9JYe7NYO6wuBHvoQUhOzy69B16xRob
	2pi1AtbcMGyfTX9DRhpRL811lsFbaVFHkiqyhwGRCGe8DVGLK
X-Google-Smtp-Source: AGHT+IEdBtSHPjgvKfhDiixzaJBbhBz3OX5f2jjbd7KMPteTt4+C/OWa+HjJZTd8tIa9XJ/KQBvlrLnb31OCiW0A+Cc=
X-Received: by 2002:a25:2946:0:b0:e1d:a3bb:d5f6 with SMTP id
 3f1490d57ef6-e1da3bbd81cmr3324432276.6.1726221969729; Fri, 13 Sep 2024
 03:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822130055.50113-1-zhangzekun11@huawei.com> <20240822130055.50113-2-zhangzekun11@huawei.com>
In-Reply-To: <20240822130055.50113-2-zhangzekun11@huawei.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 12:05:33 +0200
Message-ID: <CAPDyKFpfB5z0GRJAJMLVhJowpyZMHgZx9hkWB5migJp=K0bn6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: ti-sci: Add missing of_node_put() for args.np
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: nm@ti.com, kristo@kernel.org, ssantosh@kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 15:14, Zhang Zekun <zhangzekun11@huawei.com> wrote:
>
> of_parse_phandle_with_args() need to call of_node_put() to decerement
> the refcount of args.np. Adding backing the missing of_node_put().
>
> Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 1510d5ddae3d..2b5c26713958 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -161,6 +161,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>                                 break;
>
>                         if (args.args_count >= 1 && args.np == dev->of_node) {
> +                               of_node_put(args.np);
>                                 if (args.args[0] > max_id) {
>                                         max_id = args.args[0];
>                                 } else {
> @@ -192,7 +193,8 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
>                                 pm_genpd_init(&pd->pd, NULL, true);
>
>                                 list_add(&pd->node, &pd_provider->pd_list);
> -                       }
> +                       } else

Usually we have brackets here too, as it was needed for the first if-clause.

> +                               of_node_put(args.np);
>                         index++;
>                 }
>         }
> --
> 2.17.1
>

Otherwise this looks good to me!

Kind regards
Uffe


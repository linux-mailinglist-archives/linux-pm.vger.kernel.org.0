Return-Path: <linux-pm+bounces-37376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D58C3215B
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 17:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F29C189BA0E
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FA433345B;
	Tue,  4 Nov 2025 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+oOM1zV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF89333457
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274079; cv=none; b=ef8CszxrFdaO7gTSssMciEjtPQ32TJ8JdYCR/5ZnKCWG65nIm2OsmT7nycjgwsG69Z4XY4JiSZtLEZdmG/RXTtgtSPA6hziW3xzubp3Iidz7MTQjkWFEsFvKjkRgqji74nXr8uAXDTQum1ne4bwbk3HFiievUqwi5d3c9l7x7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274079; c=relaxed/simple;
	bh=ZCRrsNnGD1S09B2y5p35lTy0oeCos0DFHrUpZ52om0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1jNIwROSM1bkkOQBd1Jc1ezNsjGzkNFoYQCCVnKVLa/SklHtUe3vte7UE2sGgnCORbVktbwfR1MUwCVqxf+BNpppk8bfrjmeCQbam9HSzto2GzynUAQI8UwFSlNojoZSXZoNjU7u83YvKh6Aa/oEiypYUIombNSEyL5545oduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z+oOM1zV; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63cf0df1abbso6128038d50.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 08:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762274077; x=1762878877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ddGDx7DY8ZvT+UQbsTdKBb2vYIe/GE/fB2OEWm/nLJk=;
        b=Z+oOM1zVJKti99ORIdAEPWGKiTiHHMt4gN9j9j9VyTpsH0FJke8b/o2PeTufKQf06+
         QMGhAVamfy9AVHbZlkGtLIPCHRWeHsFT3McddFfWJLRpWDPsudiIqN7t0Z5R31nStK1C
         h4/kZfPW17y0TrZn5XYIuiZp4JbVDHMY0DAym3KOad5SqR+Rc1ShRMDog6uwjoQmdI93
         n4XagCCKQCTAi8sjfGYMGeJv7HspXwS5eP/VGlUSxjr/fem8qVnlLs9E9/dCHS7ZI6vg
         HSFZUKhdmFDMfEP3hTCbQxbgSQv0i1NuyaIBP/OEPh8x37Zvb0Tn77bW9bT7nlBGQqZZ
         ssVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274077; x=1762878877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddGDx7DY8ZvT+UQbsTdKBb2vYIe/GE/fB2OEWm/nLJk=;
        b=oUdddcA0a5NpGmh6Vu0AUmvcnSNfoPvBrG40iStRqPfnrc+gggO5P+Gqo8LozV2TBg
         FlyRk7mZHr7KmN3rn+ZRmagdGwNhHdNw5oFj/u9o0FZKDNCqlb8hscljt+H7ce28kOLk
         zfXuaqLk+6eXEMR9W8WIIlp6MFZzdd2slaYpclx8oWo6gFXRYJ5SCIS7UIN20nbG7LmR
         plPhyz8UbiuUt6MXSdQ+aquzncTw1QpDGwkaX7R13IO3cqgy/BUY28Zv6ImSs+QluSUF
         vrYCdJONvmSb6azj3yGYDByauzroKVzNN9Gjh6l3wg0Xdg/Vt37x+fAmEX2FRGskpeCC
         d+1Q==
X-Gm-Message-State: AOJu0YxBVuUFSr+aeyvQybtQd+sEhp/93Td+VaV3+8abPhuJPogq4Pez
	brfTBccc9kfXcv+jUM5SOioWbYL0Q4STrTd+qGUb2QbwZ+YPyRuQmExn+G/dUQQGboWPhHdzLXb
	Ugd8ypkiSt5j+Ps9ZWz5fO789HjdpXvEqS2iK8nWoNQ==
X-Gm-Gg: ASbGncsEvBYTgQfhFnJEHQZ7AqBEwJvjNGoiZYQqLB2CEkx25WKkiz+51kiGSwQjrp/
	EFM359qnG4u+wB57o1zHDXclBzHOxT0aPk+tC0NSDp7WGTG04zHm3U4l0IA/+lWcbtbaGHO4OWW
	rCiCOpef7uMjwUETojFLki1TEPQt4vtPzgTsat1MvbVX/U6A41T2aTnham/2znl60AGAtYGZJdB
	t6+n1NXshRjse2fOj5+A4wHpWbnzRnwKfXe/19ls7G4zJTNRGFNpbboA642SQ==
X-Google-Smtp-Source: AGHT+IHbMYmustVhhlT+m6xRfPZ0ZgypdMtcu7VuUMd6mP1bXe2DJ9gFsZnpH6bI4QSialr+pLyKljrmmrvqLPvCmm8=
X-Received: by 2002:a05:690e:23cb:b0:63c:f5a6:f2ef with SMTP id
 956f58d0204a3-63fd35bd9d8mr38659d50.65.1762274076778; Tue, 04 Nov 2025
 08:34:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20251027125521eucas1p206cd5a0dd4c3a80bc8abe7d9a5e61706@eucas1p2.samsung.com>
 <20251027125515.1219940-1-m.szyprowski@samsung.com>
In-Reply-To: <20251027125515.1219940-1-m.szyprowski@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Nov 2025 17:34:00 +0100
X-Gm-Features: AWmQ_blmnc7xyq9khBlGTyV4UvzKjRpkE7cFZ6cuEA1Z_dVEpjKnivKnW8fVoDI
Message-ID: <CAPDyKFr3JDgh2c_XVvSdWrzTeiH_aSy2AE3pqW7HC2sWJZsrRQ@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: samsung: Rework legacy splash-screen
 handover workaround
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Peter Griffin <peter.griffin@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 13:55, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Limit the workaround for the lack of the proper splash-screen handover
> handling to the legacy ARM 32bit systems and replace forcing a sync_state
> by explicite power domain shutdown. This approach lets compiler to
> optimize it out on newer ARM 64bit systems.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Fixes: 0745658aebbe ("pmdomain: samsung: Fix splash-screen handover by enforcing a sync_state")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> v2:
> - removed label check, as this violates ABI
>
> v1: https://lore.kernel.org/all/20251024093603.3484783-1-m.szyprowski@samsung.com/
> ---
>  drivers/pmdomain/samsung/exynos-pm-domains.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
> index f53e1bd24798..5c3aa8983087 100644
> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> @@ -128,6 +128,15 @@ static int exynos_pd_probe(struct platform_device *pdev)
>         pd->pd.power_on = exynos_pd_power_on;
>         pd->local_pwr_cfg = pm_domain_cfg->local_pwr_cfg;
>
> +       /*
> +        * Some Samsung platforms with bootloaders turning on the splash-screen
> +        * and handing it over to the kernel, requires the power-domains to be
> +        * reset during boot.
> +        */
> +       if (IS_ENABLED(CONFIG_ARM) &&
> +           of_device_is_compatible(np, "samsung,exynos4210-pd"))
> +               exynos_pd_power_off(&pd->pd);
> +
>         on = readl_relaxed(pd->base + 0x4) & pd->local_pwr_cfg;
>
>         pm_genpd_init(&pd->pd, NULL, !on);
> @@ -146,15 +155,6 @@ static int exynos_pd_probe(struct platform_device *pdev)
>                                 parent.np, child.np);
>         }
>
> -       /*
> -        * Some Samsung platforms with bootloaders turning on the splash-screen
> -        * and handing it over to the kernel, requires the power-domains to be
> -        * reset during boot. As a temporary hack to manage this, let's enforce
> -        * a sync_state.
> -        */
> -       if (!ret)
> -               of_genpd_sync_state(np);
> -
>         pm_runtime_enable(dev);
>         return ret;
>  }
> --
> 2.34.1
>


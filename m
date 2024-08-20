Return-Path: <linux-pm+bounces-12552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCAE958269
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 11:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7701F24905
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777CA18C93E;
	Tue, 20 Aug 2024 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPoEcWqM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E3E18C935
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146480; cv=none; b=b2yiNrJAdveBL7bW6WyYpa9CZZ/M/M0e0Vc+hopZa7x6Br9Epds1MUmv9o91s4GamQoY544GR8g9ZMHIq6hNpXGd26srrzx+IqxXc54dHHMteCfljrgU69vSGJ82srrfyUtMLUB5SiNhcRq72H6IfmGGnGx8wqg1/aZ8RoeSziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146480; c=relaxed/simple;
	bh=q3VmJMrtkypyZKZPXbQf5ORs7gJlfS9HqxLR593EpnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzRx5oN5VI+7waU9vwzZYlk15/O6toTIIYHrtDK6APIpjZNwKZEHup+7sUJPvvpk8EkAuRIEK5o4g8ZgpRPH09C5jzBsbwDrwxqYZ8mBKkixoiK+Zmos54s0Wzs3DLCdoJ1Bm6WhENh+z7MDWJUrhlNB5UyOuOk2CWfFrjzx5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wPoEcWqM; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso5437806276.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 02:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724146478; x=1724751278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ByHOgOffZ4FCUab4oBWyAbW75LpWNmQMey2scrFqOl4=;
        b=wPoEcWqMncUH1pxMyUdvJQQlBL+ULZ0TGqazy+ux/jQKdhEmepGDAqt89dfQHbcoYP
         tLOE4Vrns6SqXHY6YftF8I1bkJaHZY3bkckJAEhi5Dpv2FV/18V69IUDnEzpa+geWgho
         s3/uO2Lzx43qdxiB0ieaqLXwX085HO5wS8F0SSD+b15ljkF153GI5aGDtL5r9qLImTiS
         Xu+G0fUA4FhKhc2ZGQ5kYnfeyRBdFp9+Wfg7kVvM1iC0FtQmufcOunyVjo9/C4atYzca
         CSIe+MsDUsPjsFt6mih15TxJDb6F1Pe+N4XypPhOHMQcfa51i7fABTAxn9IXnbdndAS+
         oZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146478; x=1724751278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByHOgOffZ4FCUab4oBWyAbW75LpWNmQMey2scrFqOl4=;
        b=TH8YOiKsHjGaFfUTTsmwR6YNCIHe3kezH6bnG/dG9d6Z2oeZ/OBnH0Fi37IDpc18jJ
         hvfzlIBio97GyfCA/llOlp+bo+O+gWBsR6PDUjrgyd5Y4EkIMKqVCvJT2KqpXnMfYIMs
         IB85xaA4fE8hpG3Wdm70pOWKeQ10//tYeeAvuTp8T2r7XvIfNJvdcsiivJN7JOLzOkyS
         6NCHrojtULQ6+hV7165D7wbeCtB9aSzWbzaEj2TY/tmxyURb8MK5Dz73tGu1fd4G4NVG
         D6wJMa2xJriS+zwo3DpKqvqwroMUcpMulyd799lDlxIp0Z6+4tGNXuWF/GLRB78wB1bl
         sk1g==
X-Forwarded-Encrypted: i=1; AJvYcCXCJEob++6vjMMVwV+Kq6tpnu716ReLJDpbhFnBfUSz6t33D8Sero00igex784kKtlMhxE0mHDUiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYbWOYsRc/O8VMhOTd/jcRhtqotp0IkueCNo4XOPcIFPsoWJVp
	5vk3kKEUiWSSuW08xG1/Ngly6bCl1qp06X/ja5qukrhdqLD9x3DIIyNeTLXispY+wmfeSKcMqzw
	Sr4hs7vAsw1PT460DhDEjFjlKOul2Qnc4yJZ57Q==
X-Google-Smtp-Source: AGHT+IEbxH4GptztooNFuoXDju48XVH90lm30Q/Q0dq7s90J5WvHI8CWcxOQbTh1Wo9JikFSeK8fTVrWlAsuHtUWMNg=
X-Received: by 2002:a05:6902:2183:b0:e11:5e69:37a2 with SMTP id
 3f1490d57ef6-e16513bf2femr2009936276.40.1724146477730; Tue, 20 Aug 2024
 02:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org> <20240816150931.142208-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240816150931.142208-4-krzysztof.kozlowski@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 11:34:02 +0200
Message-ID: <CAPDyKFrh4hUrw65SurJpZh=oqq31E1FsJOpV8i30uqceAD2bfg@mail.gmail.com>
Subject: Re: [PATCH 4/4] cpuidle: dt_idle_genpd: Simplify with scoped for each
 OF child loop
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Aug 2024 at 17:09, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/cpuidle/dt_idle_genpd.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cpuidle/dt_idle_genpd.c b/drivers/cpuidle/dt_idle_genpd.c
> index 1af63c189039..203e9b754aea 100644
> --- a/drivers/cpuidle/dt_idle_genpd.c
> +++ b/drivers/cpuidle/dt_idle_genpd.c
> @@ -130,11 +130,10 @@ struct generic_pm_domain *dt_idle_pd_alloc(struct device_node *np,
>
>  int dt_idle_pd_init_topology(struct device_node *np)
>  {
> -       struct device_node *node;
>         struct of_phandle_args child, parent;
>         int ret;
>
> -       for_each_child_of_node(np, node) {
> +       for_each_child_of_node_scoped(np, node) {
>                 if (of_parse_phandle_with_args(node, "power-domains",
>                                         "#power-domain-cells", 0, &parent))
>                         continue;
> @@ -143,10 +142,8 @@ int dt_idle_pd_init_topology(struct device_node *np)
>                 child.args_count = 0;
>                 ret = of_genpd_add_subdomain(&parent, &child);
>                 of_node_put(parent.np);
> -               if (ret) {
> -                       of_node_put(node);
> +               if (ret)
>                         return ret;
> -               }
>         }
>
>         return 0;
> @@ -154,11 +151,10 @@ int dt_idle_pd_init_topology(struct device_node *np)
>
>  int dt_idle_pd_remove_topology(struct device_node *np)
>  {
> -       struct device_node *node;
>         struct of_phandle_args child, parent;
>         int ret;
>
> -       for_each_child_of_node(np, node) {
> +       for_each_child_of_node_scoped(np, node) {
>                 if (of_parse_phandle_with_args(node, "power-domains",
>                                         "#power-domain-cells", 0, &parent))
>                         continue;
> @@ -167,10 +163,8 @@ int dt_idle_pd_remove_topology(struct device_node *np)
>                 child.args_count = 0;
>                 ret = of_genpd_remove_subdomain(&parent, &child);
>                 of_node_put(parent.np);
> -               if (ret) {
> -                       of_node_put(node);
> +               if (ret)
>                         return ret;
> -               }
>         }
>
>         return 0;
> --
> 2.43.0
>


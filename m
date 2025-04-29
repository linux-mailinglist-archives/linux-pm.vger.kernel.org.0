Return-Path: <linux-pm+bounces-26362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 262E1AA074D
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 11:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B93482F07
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 09:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFF02BD5A7;
	Tue, 29 Apr 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jg+2Ryxa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210E2BCF54
	for <linux-pm@vger.kernel.org>; Tue, 29 Apr 2025 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918930; cv=none; b=KDQXJIt+KMz7gEAVBZ5d+hc1Ym46pGem6iKscqjqxxVZlyW2BFw6FmtgM2zbjQKCZtQKl2uq1HpJf7fs45Lg246Umenb96ghp8mn9SGbxISq41kQAcnXctveJz092ax4pDUBeHkFDP4TU9G5l3vC306e48rjtGoYdIwpYbxvj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918930; c=relaxed/simple;
	bh=rz7GEU+cLgkTuSJ7/jJk4YnGG3C+NyOdb2kkdvOKqoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NU2d4VRqNrp9ZXimia6LFJe61rdh20QDzvo5DJKI6JVRJNHdiLrjgW+gQOe5QnFvxw6HpB7oTzZ3zZLYKCMSX4S4Kd5WZMFjHJ4OEu/864kpkBfdtenS8TMbnwbx61KgTogN+qP+WQMohsyiINOll9LXb2Exl+IAwKx6Q9frNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jg+2Ryxa; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6feab7c5f96so51807787b3.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Apr 2025 02:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745918928; x=1746523728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rfeG3dd0iHg4ZedR6tUQEk3LD+qMPNa78G6OKmslOhw=;
        b=jg+2RyxaUusP3lqtdJDfxgTskd2m9gt+J4D5jf3VmZ7wcu70DqNlwsXl/ieVmE+BCi
         jrFn08X+Umw6fS43ItgMnqc19ppRjrgmd1A52CnFP9QjoddsXfrazZVhNiqXR2ZVSQ+R
         pSmUkLhixX17hkKZw7NVepQpG6ixkxFa4IJeuhXE/lydqvghtCrSPTaIJMPXmMroN9ZL
         pto9RQD2u0+sHEgnYIPCHQs6xERs4r+FIpXRIzuusi+u6hniGHT3O1HpZGUce+tt9yqE
         O7oY1VluOLJgIfmw5sIfv007JTMyEtLfLTmNy3cj5ZBxcX6AErS6H8dX5U68ob/Njl0O
         Q1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918928; x=1746523728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfeG3dd0iHg4ZedR6tUQEk3LD+qMPNa78G6OKmslOhw=;
        b=iqMkQ8+v4fpmy4BsAfBiBryP3TSZ7n/qXxKZXe31j20NQ4OE9kGNq25MPRm2Nq9gWH
         8T+B/zHipHxGSP7nhdwphUDy4sl5dquUeJlOa0th/3YuvOZvoVlByM4JOByaA0qjGsNK
         BRsr2DnXSun7CetE7Fyy7Zayzmc1QGGYEu7mJUqjOEC+0AlzIqOIxkTAbkVIO5jGSovt
         n+BIR3VUvTGGHt32xlrXTTZKMOkxI81zwC9P3MWjGVDiqzhHUqqVRpayNrCunWoAIQo8
         +G3SfmyzrtykimOjddeczUTwggM/dvXBIj3Z008xV7Qy6uqPawxcQWgHVEk37NB4ZVem
         U5hA==
X-Forwarded-Encrypted: i=1; AJvYcCU7XfyDI52LXoc8bT1gaHI3QP7dbiODmULTfy1c+gaF5gc6z3cBbkIKv+zVJNC8TEvqfHqDfGussw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxG+wlSy/Cv2bZHH4APUNfBI2xRNYj7n+09plOJ5dic3AU0ZC3m
	WqCazafDiMhNEE1egGVsq9m/AjSmKFdMgD2PFFlmkP+atDIFFLQDIerO3jGX1QlwU9EwT/o/3rJ
	vZcekFJlN7HB4N0/xxqhMgeDmpN5Zk9pyjgd5AQ==
X-Gm-Gg: ASbGncv8/DjE9KURT1d9wnQyTCl5m0RkSTQ+I5X+xVUEK+G8ME6AI2/EMC9tFSNTXHh
	06zJ6NYA+lY5HcdFS6scFq12zC2B3rG2P1KVWpQ07O3SJjOCiAJZ36+E6k6Qa5wySfxnSgTJFQ9
	q/eBDReOVe07Elg6VWFzkmaag=
X-Google-Smtp-Source: AGHT+IGqaZACXqvr7JdmMVvJ8PR+gCTsx+pGcWiJ4NHfME0mBxihXmiMZvORJMcNAuMeeOrgqZTMEz2gRJvInQo+C+U=
X-Received: by 2002:a05:690c:4913:b0:706:b3c1:3d00 with SMTP id
 00721157ae682-7085f255a3bmr182926527b3.37.1745918927853; Tue, 29 Apr 2025
 02:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <107f2bf9f13b29f0f623d2959a5347ec151fb089.1745840768.git.geert+renesas@glider.be>
In-Reply-To: <107f2bf9f13b29f0f623d2959a5347ec151fb089.1745840768.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 29 Apr 2025 11:28:11 +0200
X-Gm-Features: ATxdqUHJBHA0aHhbwsDUsk737mmH_eoVJSA36tbcF6B9qrh4_o8nqg_lRGoC3LA
Message-ID: <CAPDyKFrvPub5qd3bnf5gmmgB59BjR6infOXcFibfxs2E7MnTLg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: renesas: rcar: Remove obsolete nullify checks
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-renesas-soc@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Apr 2025 at 13:56, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> All nullify users and helpers were removed, but the R-Car SYSC drivers
> still checked for nullified domains.  Remove the obsolete checks.
>
> Fixes: c8d87704444a8ac7 ("pmdomain: renesas: rcar-sysc: Remove rcar_sysc_nullify() helper")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/pmdomain/renesas/rcar-gen4-sysc.c | 5 -----
>  drivers/pmdomain/renesas/rcar-sysc.c      | 5 -----
>  2 files changed, 10 deletions(-)
>
> diff --git a/drivers/pmdomain/renesas/rcar-gen4-sysc.c b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
> index 66409cff2083fcd8..e001b5c25bed0051 100644
> --- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
> +++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
> @@ -338,11 +338,6 @@ static int __init rcar_gen4_sysc_pd_init(void)
>                 struct rcar_gen4_sysc_pd *pd;
>                 size_t n;
>
> -               if (!area->name) {
> -                       /* Skip NULLified area */
> -                       continue;
> -               }
> -
>                 n = strlen(area->name) + 1;
>                 pd = kzalloc(sizeof(*pd) + n, GFP_KERNEL);
>                 if (!pd) {
> diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
> index dce1a6d37e80127d..047495f54e8adc0d 100644
> --- a/drivers/pmdomain/renesas/rcar-sysc.c
> +++ b/drivers/pmdomain/renesas/rcar-sysc.c
> @@ -396,11 +396,6 @@ static int __init rcar_sysc_pd_init(void)
>                 struct rcar_sysc_pd *pd;
>                 size_t n;
>
> -               if (!area->name) {
> -                       /* Skip NULLified area */
> -                       continue;
> -               }
> -
>                 n = strlen(area->name) + 1;
>                 pd = kzalloc(sizeof(*pd) + n, GFP_KERNEL);
>                 if (!pd) {
> --
> 2.43.0
>


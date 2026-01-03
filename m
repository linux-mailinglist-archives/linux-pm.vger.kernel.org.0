Return-Path: <linux-pm+bounces-40148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4662ACEFDEC
	for <lists+linux-pm@lfdr.de>; Sat, 03 Jan 2026 11:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34FAE304A8FA
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jan 2026 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DFF2F60A7;
	Sat,  3 Jan 2026 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vp6S6RnO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA42F6903
	for <linux-pm@vger.kernel.org>; Sat,  3 Jan 2026 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767434616; cv=none; b=KqEQVxkRm/46a7BTXLjQgamsNKV1uSZJ/Q9PZN2bu3jmgAC8COJJoA8jqBU63N115V2s4vQkemEweGf9xqmrR0dbbPOUAZjinvzbuT02W+3HzRVd6TS9j6NFpywMzIIDzocDmTNZ/EHMgBpDWB90YohIDCXuasdtvjoBDg/smGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767434616; c=relaxed/simple;
	bh=QC+ZoVwyUeUlTXpAffQgFa24aSqRBVpLFHFV1L2tTKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YquB2E4BTHKqPC94HnA5fs3QzIiKYTAzIyIzqsnNv4o/sYBy9LmnsF6Q6+QmNTSOof8ng5HHHs2lf/Ndyon6EUsFPwUTASYW/GbUGVBvdQbfVh99qJ8NBBZEdfL8TyFjNHyOguin2dvY/dT/doU/8JLSRKIRU8g/i9o78R265bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vp6S6RnO; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59581e32163so14750998e87.1
        for <linux-pm@vger.kernel.org>; Sat, 03 Jan 2026 02:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767434609; x=1768039409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OYf6bvkaEWvrggi0yuuffaRuhv37HK8SVIBsgUUmv1A=;
        b=vp6S6RnOyYVEFAp6xdhil+vfjhlGh1gO1nxbqrbziGRkjjn6UAahPYDSrVqvsq9Mm+
         dMYiM3hkyTxJOithwnWvtyl4w7XW8v7kspxaE2piuTOIQxJHFn1AHuFYtsraP8D+u7br
         rw1UVYJj2vZPdNHWiyn/+4wc3fN90BY9krrfzejV3KvLSv96EHceCKtBqNrSj21AHp7y
         ZsdJ/Gfdqwl91uKwLXC95NB4O3zEbrp3cgmKIma6V9AKJVebPwDFg1dTsOb3Dg/UsUAg
         s99uSwx5msRAd5Et17gqCxKM24y1e+kaMNQvC1PpOZu21xx+Y/hvrUwVFqV6FtRjjT3d
         sBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767434609; x=1768039409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYf6bvkaEWvrggi0yuuffaRuhv37HK8SVIBsgUUmv1A=;
        b=eaYDLfsk8i3s9YHQ5sdrQpegzLnbqE2ZDKmbNfk4QQrnHcaqipNg614lNpZnMI4hT0
         tfymXtODYVhKyBNhTClr4dtuJEzAEV8h1LxicZJNBJnltjll36AxMSnuKklmCfci/6CY
         sawXPzFixHkmsuhpUq/V9tMOL62Fc/4oCHjSfCdlbH5htBctshxjFQU1gNa0MV/s25x0
         cDga+1XIeP+ZNV93V3m6vifBWJQz8Vp4ujDRlv0EqCwTY8T9X6Ke7pORCjvev3Iij+1t
         dN8TsWUoZd3QkAC5jvKv0h+0kL3Z/vFeGS208p54FC8FnKqAyEuKKgTJMl7DEqEmUTua
         Nxzg==
X-Forwarded-Encrypted: i=1; AJvYcCUeSszbwfsm5MX6SiVxafapGXO2qgCI0/5CjopH6hM4P+ZvrRPbF2/o1LAWHAg1SjhrqkgfVp/7Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEciI7wi760/CnBdq6ZZvIWAgurze5tpqTqnzEG0IbCmLoyTEU
	Bj9aT1IyP4aGRmrrivY1HSvY5mwbFaLA3e/ujzI0Kqg8o6yW2o1dOcVzclKuRbEuRctdJixzda7
	o3c+C0u96v8w0PFeBWfzATbTGkpu+2/b9dX43TSG29A==
X-Gm-Gg: AY/fxX7vD39GoJpL/jJTJ0d1Q4s+8QjwheeIELt0JjDP3ZKfeO4Li4T21emfTSLMVFm
	uNeyU4KzQNR2tCKi8n91+o+jOP+1w2EgG4h6ivDtMSRKCG/tggEvY2x5DtPZP0LQRNLSsgd/5Dc
	RS4lPqF1fRYM154Au8nLPw/wqcl7Aw8NHXT6/iSrhypA96Ex3XW546cSSRaWKcvwWTjIS818ntk
	qWfQuJPeQW65vbXwx6dqzoUQk4nOb6wb8RQs/4WUURBqDm7fSxWEbOD5jXYsy78VPk64Zfq50jH
	xE3euNE=
X-Google-Smtp-Source: AGHT+IGNyZ6pT/xuZoiBS1OalP/VwiTV2zPp40cAw0CI5np24s1GG3PVuf+rgxF02Pij4HSXYC6sqLVM0BYsiEuGK2M=
X-Received: by 2002:a05:6512:3f09:b0:594:4e9f:98ec with SMTP id
 2adb3069b0e04-59a17d253ffmr17191725e87.20.1767434609415; Sat, 03 Jan 2026
 02:03:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230-pmdomain-v1-1-3a009d1ff72e@ti.com>
In-Reply-To: <20251230-pmdomain-v1-1-3a009d1ff72e@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sat, 3 Jan 2026 11:02:52 +0100
X-Gm-Features: AQt7F2rBg1MhVL6_AIF2mPeFOu0N7IPe2SjP0xQ7-SqCBNvV7cnprqAVZvFVSCk
Message-ID: <CAPDyKFqP+k9HPSLG4SSmz5iaNiY4yLf3-7q9p0ChJt1dj4aSiQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: ti_sci: handle wakeup constraint for
 out-of-band wakeup
To: Kendall Willis <k-willis@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, d-gole@ti.com, vishalm@ti.com, sebin.francis@ti.com, 
	msp@baylibre.com, khilman@baylibre.com, a-kaur@ti.com, s-kochidanadu@ti.com, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Dec 2025 at 22:37, Kendall Willis <k-willis@ti.com> wrote:
>
> For devices capable of out-of-band system wakeups via I/O daisy chaining,
> prevent sending wakeup constraints to the PM co-processor. This allows
> the system to enter deeper low power modes, as the device is not marked
> as requiring power.
>
> Replaces the logic from commit b06bc4727991 ("pmdomain: ti_sci: handle
> wake IRQs for IO daisy chain wakeups") since checking out-of-band wakeup
> will cover the same functionality.
>
> Detect out-of-band wakeup in the suspend path, and if it exists, skip
> sending the constraint.
>
> Signed-off-by: Kendall Willis <k-willis@ti.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
> Implementation
> --------------
> This patch is intended to be implemented along with the following
> series. This patch has no dependencies on any of the other series:
>
> 1. "pmdomain: ti_sci: handle wakeup constraint for out-of-band wakeup"
>    (this patch): Skips setting constraints for wakeup sources that have
>    out-of-band wakeup capability.
>    https://github.com/kwillis01/linux/commits/v6.19/uart-daisy-chain/pmdomain
>
> 2. "serial: 8250: omap: set out-of-band wakeup if wakeup pinctrl exists":
>    Implements out-of-band wakeup from the UARTs for TI K3 SoCs
>    https://github.com/kwillis01/linux/tree/v6.19/uart-daisy-chain/uart-wakeup
>
> 3. "arm64: dts: ti: k3-am62: Support Main UART wakeup": Implements the
>    functionality to wakeup the system from the Main UART
>    https://github.com/kwillis01/linux/tree/b4/uart-daisy-chain-dts

FWIW:
I had a quick look at 2) and 3), both seem fine to me.


>
> Testing
> -------
> Tested on a AM62P SK EVM board with all series and dependencies
> implemented. Suspend/resume verified with the Main UART wakeup source
> by entering a keypress on the console.
>
> This github branch has all the necessary patches to test the series
> using v6.19-rc1:
> https://github.com/kwillis01/linux/tree/v6.19/uart-daisy-chain/all
> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index e5d1934f78d9ee0a02eb05aa1301cd5a59e134d6..18d33bc35dee1b3bf6107af1e414db377d515199 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -91,8 +91,9 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
>                  * If device can wakeup using IO daisy chain wakeups,
>                  * we do not want to set a constraint.
>                  */
> -               if (dev->power.wakeirq) {
> -                       dev_dbg(dev, "%s: has wake IRQ, not setting constraints\n", __func__);
> +               if (device_out_band_wakeup(dev)) {
> +                       dev_dbg(dev, "%s: has out of band wakeup, not setting constraints\n", \
> +                                       __func__);
>                         return;
>                 }
>
>
> ---
> base-commit: f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da
> change-id: 20251230-pmdomain-e71bed9b40f8
>
> Best regards,
> --
> Kendall Willis <k-willis@ti.com>
>


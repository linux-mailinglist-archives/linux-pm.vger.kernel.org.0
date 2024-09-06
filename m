Return-Path: <linux-pm+bounces-13762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DB796EE97
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 10:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692261C21B3A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 08:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6764C155CBD;
	Fri,  6 Sep 2024 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t34t0/LS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB104594A
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612937; cv=none; b=CQ38SGMiEtTS+IPLZsqcwo5jdiJHpQ6sQgcw6VTNXYzFuZBOLI15RZDX7ba6LOGETc8BGN/we8h+NxnGbnim6BX2LG3Srg2KvV7hxuf5/eQGByh7Vrj2QxEwZNZk1YUUy9AqIef0XZHPZKmV3+VtJQNtkl/8u9WtbVIuJ96/ocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612937; c=relaxed/simple;
	bh=1tKIDlnB3KkJtGr5ZP7mpRStjsQ42s/bsGiQCaSCx3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgjLUfXclf2d66fxRJDk6SsA9upi10xFUoC9nGoVYxdFM765JAS1woFoZ53oMB8cd4GRfH6DClO6SHmYV+GdjLtPC0b4xdC642n4UqBE0nbXs3wxoMxVL9CJDcp5MEG9PIwghxnDXuevPjXPufOVUGgmfRuIqTbz/lP+jCusyEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t34t0/LS; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso1859730276.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 01:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725612935; x=1726217735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M3BuLJ0oJF3nW7k2dmOfDC2I3AF3RStkd1D/ShFKctU=;
        b=t34t0/LS6bsIrCg+26Ee/pejyHgR6YlY9wg4l6F3HW8nbteaPnR7My7Pce+x0RhnXR
         1I2s6MTxFiiTEW06IIR5c2En8H/WHBi/UZ7e1uUL6+VmgS6wclt+w7FyGatQkMkssPqd
         Pe6I3NaeM09Stg4o75GhCnsvKNT3pRu/gIOAb1PDBi32H9lMQwwRUvAJ+gdxj2yTFk6f
         FuZXEblom7Q4F4qAQVc+52Ix3RDgCOaPBLnCt29skCJkRUnwj2g0BNNYmf43krz2l9yg
         5btsP0egWzQn4s+tYSMKFMadCw+X+JmyLYNbw9UMTvHz0hMd0LVNHrvIg25Whlv/VFZc
         nqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725612935; x=1726217735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3BuLJ0oJF3nW7k2dmOfDC2I3AF3RStkd1D/ShFKctU=;
        b=kwZuqUdUMVZnQY7lYERmurT07uP2/caQumiHAQuKjgZc6QnjxFrJ8eZRO6xiLo6SEC
         RopvfEPIMaUJnY9vHsK7Jn0zEUHsCjzoxRSXHKJ3A4OqplsniNkXDOrp/ToJN7YrpPoU
         NvDOOZH08PNSWVIOulQWofJyN2jQZRyn6snTxaeeouaK8pQ+jj8QNovNIlRKNgWY1qoj
         3YE+IbvM5rgT/RlIcxIcHTaFmnloqdFNv7nNxdAMLBH7UvUtoDmZW05+/YzMPjf8oP3u
         OHwqCEp4Pf9Qt84F+YSJV0Wf0mtrJ9eZuW92vyZv7N+BJwq/F028XIUxQE/iKWHtlAJG
         Zs3g==
X-Gm-Message-State: AOJu0YyEqkDJR7OCmeCpxOL7UIx/zYokBCuleH2pvZr4etUz+l+oVXnj
	5sTzePGkVSJZH8D6pcoOSOR5V9N5uR/cQeNZgWjQMVB9IAX7p52jAbitWjXCubKySaVBkLrQw1f
	MITj4OFN23GH3WQXiCp+Yzb5+rvzIhOr/9B74zw==
X-Google-Smtp-Source: AGHT+IHtYWG+Hz8JJJa4zYxXRaKyd0MoxOK8rolwdv2JTB/QiteDyUjIyfsFBEnuK1KLoEFT3fbCCFgXam+ue5yETyc=
X-Received: by 2002:a05:6902:844:b0:e1a:a665:1db4 with SMTP id
 3f1490d57ef6-e1d3488379fmr2023197276.14.1725612934767; Fri, 06 Sep 2024
 01:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905-lpm-v6-10-constraints-pmdomain-v3-0-e359cbb39654@baylibre.com>
 <20240905-lpm-v6-10-constraints-pmdomain-v3-3-e359cbb39654@baylibre.com>
In-Reply-To: <20240905-lpm-v6-10-constraints-pmdomain-v3-3-e359cbb39654@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 6 Sep 2024 10:54:58 +0200
Message-ID: <CAPDyKFquSHYLGzd288K3JSOF_p+UyRO8GoBP9TGCR_3syGXTDw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] pmdomain: ti_sci: handle wake IRQs for IO daisy
 chain wakeups
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 00:03, Kevin Hilman <khilman@baylibre.com> wrote:
>
> When a device supports IO daisy-chain wakeups, it uses a dedicated
> wake IRQ.  Devices with IO daisy-chain wakeups enabled should not set
> wakeup constraints since these can happen even from deep power states,
> so should not prevent the DM from picking deep power states.
>
> Wake IRQs are set with dev_pm_set_wake_irq() or
> dev_pm_set_dedicated_wake_irq().  The latter is used by the serial
> driver used on K3 platforms (drivers/tty/serial/8250/8250_omap.c)
> when the interrupts-extended property is used to describe the
> dedicated wakeup interrupt.
>
> Detect these wake IRQs in the suspend path, and if set, skip sending
> constraint.
>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 1ab1e46924ab..747a7a33c0a9 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -82,6 +82,13 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
>         int ret;
>
>         if (device_may_wakeup(dev)) {
> +               /*
> +                * If device can wakeup using IO daisy chain wakeups,
> +                * we do not want to set a constraint.
> +                */
> +               if (dev->power.wakeirq)
> +                       dev_dbg(dev, "%s: has wake IRQ, not setting constraints\n", __func__);

return; ?

> +
>                 ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
>                                                                TISCI_MSG_CONSTRAINT_SET);
>                 if (!ret)
>
> --
> 2.46.0
>

Kind regards
Uffe


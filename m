Return-Path: <linux-pm+bounces-13884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4AE97152E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 12:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1532857AC
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 10:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22781B3F2C;
	Mon,  9 Sep 2024 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qdd/TaBo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5731AC8BF
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877148; cv=none; b=Dfd19355oMnCWJAmo7WfoeeqC2kAYh5hQsvQRAz2bQlB7vlQNrXIPD8FXALsvLKvHTJ+9yOO+UaXc2K6XA8FcxaJX3whZwxsGtwrsY4XEyPFrFZGSxiMky7H5HQOHznzQI0alzcEU8xW3Ver6BJwVkGK9L29vu3tVcf0rdSKdqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877148; c=relaxed/simple;
	bh=/MtOZqjYjXOZxWyvRKziMN3PpN+drwQz+IQM3d0lnqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c90yuBD833hXnFNFat7ePJPh2xc9RN+ojBZWi4D3OwHFg5QGJ/VmYe4yzxhg6hwxmIruWSloeW3N5SrYYYx0nepeY40CUBOyTYfr0L3aKvgU2wuR8vCSP7qeLmoRJ5J6NDRa5mXiJ0fOrPYOeOTuyoQJoesKp3OTxeDcM0IT+p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qdd/TaBo; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e1a8ae00f5eso4368145276.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Sep 2024 03:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725877146; x=1726481946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0gO+UN0cBDH4/yTsxd+kVbLwUAMxEmBNCCbdpfIZTbQ=;
        b=qdd/TaBoMgV8f92e5i9FBEVOvqvBqpeNKgeShg9FXgouklQ7GGQzYxB/mxgWFkKrS9
         gfSIenOpJY62wkhF4ZLRfvU9gs4tybSsovKwz4alZ3tSpfwKPyuaAZ8fOMgYorMwZ4L1
         +6JWCdV0vnOt7q5xJ4KlUOlFV+h3GZbXH7E98yrbcgow8OC5TaQQoX57XczrtqmdCNuZ
         h3aDk8xDzghLYX3pLZt1Rz+0cMTi2Cyy0C0LKwxmpaBq04f7k5jn0bcj850z6VJcKM0H
         jUwr8mxKLTz0p2/HzuP2170IbRjbVg1cYswFl/DzHXpvpfTgQSZCvJQU77t6jsf7oe48
         8pFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725877146; x=1726481946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gO+UN0cBDH4/yTsxd+kVbLwUAMxEmBNCCbdpfIZTbQ=;
        b=ejt9eTklfkkHnXK1VRkG9/8XY4eSJH78hsqIyZXdnh6jeG84GGOX64o519KuFL0zvI
         zEv+DS1gO2HMVrZjQolWDSrTfPCM6jumVivCtrq65HegJm7dlqNoFtRfPR1OUb352HGI
         K19UEMnVttnT3gj15m2SvzXAkd9C4dPcmurkjpHv6KFcVC1Eetzxy7Ha0l/7L1oR/htr
         Wk+E7AfRUZmOHE2Wj46O7EWc0bmhnpz3Q2XvtHt2Us18mWDm0GcGDan5LmoiIJMLjMxK
         v73N6A22+fmGMjsNQYFTI7iY1v0rEDjkJrd1yzFjyW9S1jWU5x2ipTvb9E2qGwFlmuP9
         7QaQ==
X-Gm-Message-State: AOJu0YzWwGpqwKlqOfPf2Qtb/Yq+sSz4rRD2wza7NZmQRxDVYkhKZVdo
	eKaxLsLDs+0bcgxo/MSrPXE28HSOvQMFhmWdHQXbGGov0JI2LyzbMLyqZ0qW4FYiW2sV3SLBpdF
	vi4cOwoRWT5OF5yRcoEqP+M5Tuy83L6KMx9cPzA==
X-Google-Smtp-Source: AGHT+IH08bXPRnV+yehRf1zMzB/R9ecWLBxkkpijcZBbtJ3y4Ft6NTBNQPxQPK0XcPEg++3GjylRa441YT0Rj8Ga/Z0=
X-Received: by 2002:a05:6902:230d:b0:e1a:90f4:c1f6 with SMTP id
 3f1490d57ef6-e1d34899313mr11771638276.27.1725877146085; Mon, 09 Sep 2024
 03:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-lpm-v6-10-constraints-pmdomain-v4-0-4055557fafbc@baylibre.com>
 <20240906-lpm-v6-10-constraints-pmdomain-v4-3-4055557fafbc@baylibre.com>
In-Reply-To: <20240906-lpm-v6-10-constraints-pmdomain-v4-3-4055557fafbc@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Sep 2024 12:18:29 +0200
Message-ID: <CAPDyKFr9isnz66B+n5y3=QO-ndB05JKZN3kgXO+kXBn7ofcwMw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] pmdomain: ti_sci: handle wake IRQs for IO daisy
 chain wakeups
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 18:15, Kevin Hilman <khilman@baylibre.com> wrote:
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
> Tested-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 1ab1e46924ab..566af9f055b8 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -82,6 +82,15 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
>         int ret;
>
>         if (device_may_wakeup(dev)) {
> +               /*
> +                * If device can wakeup using IO daisy chain wakeups,
> +                * we do not want to set a constraint.
> +                */
> +               if (dev->power.wakeirq) {
> +                       dev_dbg(dev, "%s: has wake IRQ, not setting constraints\n", __func__);
> +                       return;
> +               }
> +
>                 ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
>                                                                TISCI_MSG_CONSTRAINT_SET);
>                 if (!ret)
>
> --
> 2.46.0
>


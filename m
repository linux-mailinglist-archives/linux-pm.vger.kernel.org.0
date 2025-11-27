Return-Path: <linux-pm+bounces-38805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA47CC8E5CD
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 14:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90F9B4E28E2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 13:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA032218592;
	Thu, 27 Nov 2025 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk06guqF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9F1A9F93
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764248472; cv=none; b=i8u1punxPcm5+Gt/9cNByu5nbdhM0EmfFSykzOpib/9RaSudWN3gnxvviT+p7kjWxx3i/HVP1yqmMVcn9U+FtAjCzWkZ25N5fsVSQ0zSyoEe3jyy4zUQPWbrGKng9jB2wW7XbaTxLvCrE5Z5rAtrhrLazOQxAZV5Bagz/dbVu84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764248472; c=relaxed/simple;
	bh=5B2DokJ2fwn8bPcv3UNxCwZ8pOuqCDTWirSvAWdFi8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahMjNgasrSOl43qLiX2lG4z4Pcbe04zK4ln0KPTfpk+4AeAaqpbZoCrsV7k/xg8l5V5Dj35kSlA5irRv5INVWOBce2YMLRHqeW/tuiTEKMOkVREegTAv4/cyPHGNG4YvBLLF55ZYXEnml+VCILl/GtReIj8C+bk7zL+a0DY+QWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk06guqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D348C2BCAF
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 13:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764248472;
	bh=5B2DokJ2fwn8bPcv3UNxCwZ8pOuqCDTWirSvAWdFi8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kk06guqFqCcWkVcvnXT3QiNiTd1UqKUA9ltFJZpbpclRiLvyKHBGJh+/+bLEssdJi
	 5J6+VsTLXf7a6cyEXrxPM7+4UkTu4sgCz2H5aynP36J9u80LJ/sEC+jSaj3A22klf3
	 jrNmUX9m+gWiwf8Bisd5WZH/Y1w2X3ZzGG0UZ5V/kU5iZm4DNKtUA9pGFsMG0UADXD
	 4PFTGhRq7REBCpMKiuZk5wK26jCERWZNwIFDEELq3JVHkeVPT2Zcm6/cxqeghhtuTW
	 gc6RjAiD0XGa8oNmQMtvlccsB0/aG9OKViV4JlKreIuibr7PM9zbnTUAbO52tXaUax
	 dmTGt4ucOe2ug==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c7613db390so408089a34.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 05:01:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJx9KV2XYQMsPYObWGCao4k23H36T2gkF8FB9tcK8+BdJJSStfMbwSSnTC3QaThcokeLd4g3aarg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZvY6/xPV+GaSmne8yZYMJQZHoQ0AFIxPAGe91X/Y97o76g1H3
	aIM88ZOhTmdSU1NE7TjW8aosHwI94Duc6nwRm3avtIRg2E6gnJKEj6bEfp+21rBnHPzSdecyAjv
	ajwKg6yJmz2nwfsk2g1f4MAbhpkNvzkM=
X-Google-Smtp-Source: AGHT+IEI3UJByOclSzi0q5OcMfo+5gKdSRgRo+ZJuNQ6XOQJ2u3sBjOn1cxX7NYRqeeEOXLYq1pN/B8A30yoHUgOwBo=
X-Received: by 2002:a05:6830:849e:b0:79e:9b7f:5666 with SMTP id
 46e09a7af769-7c798c996cbmr9990925a34.14.1764248471556; Thu, 27 Nov 2025
 05:01:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127-wakeirq_support-v6-0-60f581f94205@oss.qualcomm.com> <20251127-wakeirq_support-v6-1-60f581f94205@oss.qualcomm.com>
In-Reply-To: <20251127-wakeirq_support-v6-1-60f581f94205@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Nov 2025 14:01:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0irVZ8Y+NmkyP9Sde94BtJPsAO+yH8XXWLR5AU7ktN3aw@mail.gmail.com>
X-Gm-Features: AWmQ_bmdzykwui8a5bP4-ql4zdmmAvJ2RWMexP4sMu1sc0iRJqb559YK7P498_c
Message-ID: <CAJZ5v0irVZ8Y+NmkyP9Sde94BtJPsAO+yH8XXWLR5AU7ktN3aw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] PM: sleep: wakeirq: Add support for dedicated
 shared wake IRQ setup
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, 
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 1:46=E2=80=AFPM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
> Some devices require more flexibility when configuring their dedicated
> wake-up interrupts, such as support for IRQF_SHARED or other IRQ flags.
> This is particularly useful in PCIe systems where multiple endpoints
> (e.g., Wi-Fi and Bluetooth controllers) share a common WAKE# signal
> line which requests platform to re-establish power and reference clocks
> to the components. In such cases, drivers can use this new API
> dev_pm_set_dedicated_shared_wake_irq() to register a shared wake IRQ.
>
> Update the internal helper __dev_pm_set_dedicated_wake_irq() to accept an
> irq_flags argument. Modify the existing dev_pm_set_dedicated_wake_irq()
> and dev_pm_set_dedicated_wake_irq_reverse() to preserve current behavior.
>
> When IRQ regitsered with IRQF_SHARED we can't use IRQF_NO_AUTOEN flag,

registered

> so after registering for irq, disable it explicitly.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Overall

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

with a couple of minor nits (one above).

You could have said what changed between different versions of the patchset=
.

> ---
>  drivers/base/power/wakeirq.c | 39 ++++++++++++++++++++++++++++++++++----=
-
>  include/linux/pm_wakeirq.h   |  6 ++++++
>  2 files changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 8aa28c08b2891f3af490175362cc1a759069bd50..df34a891d54bec8737a3ef174=
bdfa469c19133c4 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -168,7 +168,8 @@ static irqreturn_t handle_threaded_wake_irq(int irq, =
void *_wirq)
>         return IRQ_HANDLED;
>  }
>
> -static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, =
unsigned int flag)
> +static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, =
unsigned int flag,
> +                                          unsigned int irq_flags)
>  {
>         struct wake_irq *wirq;
>         int err;
> @@ -197,8 +198,7 @@ static int __dev_pm_set_dedicated_wake_irq(struct dev=
ice *dev, int irq, unsigned
>          * so we use a threaded irq.
>          */
>         err =3D request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
> -                                  IRQF_ONESHOT | IRQF_NO_AUTOEN,
> -                                  wirq->name, wirq);
> +                                  IRQF_ONESHOT | irq_flags, wirq->name, =
wirq);
>         if (err)
>                 goto err_free_name;
>
> @@ -234,7 +234,7 @@ static int __dev_pm_set_dedicated_wake_irq(struct dev=
ice *dev, int irq, unsigned
>   */
>  int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
>  {
> -       return __dev_pm_set_dedicated_wake_irq(dev, irq, 0);
> +       return __dev_pm_set_dedicated_wake_irq(dev, irq, 0, IRQF_NO_AUTOE=
N);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
>
> @@ -255,10 +255,39 @@ EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
>   */
>  int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
>  {
> -       return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICAT=
ED_REVERSE);
> +       return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICAT=
ED_REVERSE,
> +                                              IRQF_NO_AUTOEN);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_reverse);
>
> +/**
> + * dev_pm_set_dedicated_shared_wake_irq - Request a dedicated shared wak=
e-up interrupt
> + *                                        with custom flags

I'd drop the "with custom flags" part from here.

> + * @dev: Device entry
> + * @irq: Device wake-up interrupt
> + * @flags: IRQ flags (e.g., IRQ_TYPE_EDGE_FALLING)

And I'd say "Custom IRQ flags (e.g., IRQ_TYPE_EDGE_FALLING)" here.

> + *
> + * This API sets up a threaded interrupt handler for a device that has
> + * a shared wake-up interrupt in addition to the device IO interrupt. It=
 also
> + * sets IRQ flags like IRQ_TYPE_EDGE_FALLING passed by the caller.
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +int dev_pm_set_dedicated_shared_wake_irq(struct device *dev, int irq, un=
signed long flags)
> +{
> +       struct wake_irq *wirq;
> +       int ret;
> +
> +       ret =3D  __dev_pm_set_dedicated_wake_irq(dev, irq, 0, IRQF_SHARED=
 | flags);
> +       if (!ret) {
> +               wirq =3D dev->power.wakeirq;
> +               disable_irq_nosync(wirq->irq);
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_shared_wake_irq);
> +
>  /**
>   * dev_pm_enable_wake_irq_check - Checks and enables wake-up interrupt
>   * @dev: Device
> diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
> index 25b63ed51b765c2c6919f259668a12675330835e..61f1e840745b56baa57db3756=
3e450cb2d757a85 100644
> --- a/include/linux/pm_wakeirq.h
> +++ b/include/linux/pm_wakeirq.h
> @@ -11,6 +11,7 @@ extern int dev_pm_set_dedicated_wake_irq(struct device =
*dev, int irq);
>  extern int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int=
 irq);
>  extern void dev_pm_clear_wake_irq(struct device *dev);
>  extern int devm_pm_set_wake_irq(struct device *dev, int irq);
> +extern int dev_pm_set_dedicated_shared_wake_irq(struct device *dev, int =
irq, unsigned long flags);
>
>  #else  /* !CONFIG_PM */
>
> @@ -38,5 +39,10 @@ static inline int devm_pm_set_wake_irq(struct device *=
dev, int irq)
>         return 0;
>  }
>
> +static inline int dev_pm_set_dedicated_shared_wake_irq(struct device *de=
v,
> +                                                      int irq, unsigned =
long flags)
> +{
> +       return 0;
> +}
>  #endif /* CONFIG_PM */
>  #endif /* _LINUX_PM_WAKEIRQ_H */
>
> --


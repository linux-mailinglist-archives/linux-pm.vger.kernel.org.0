Return-Path: <linux-pm+bounces-20442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423A7A111CD
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 21:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5BC3A1EA4
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 20:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4286320967A;
	Tue, 14 Jan 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD22uIFW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0919A1FBCA6;
	Tue, 14 Jan 2025 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886036; cv=none; b=o1X9t9eafnFyF79a8eZrrGqAm4b+yOaXnBwKCLp9zeumb0AspAfGg80/+p0lLIDkWH1NX+C94doJPjEt9H7pZx1oU25qa93itst6P09Y1U1S05s/ifFliCbKHjY7lpU64kx+X7PmYrzZICtzqujtViERx42rv1LrBOU7sFkgTxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886036; c=relaxed/simple;
	bh=I9Ekx6aq/CtvmHlK2JuDkCREj16AUwVV0szqwfvn2B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyiJYDTX4/dXl8zzAhasxnQrVBBo7uY/BI5tvyDPDtUBcmfYIoEO2mIBdG6UBgP+SrT0GCHOK+KIrkR6RhVNHnZ0aHw5UizlhhwfB5BKcxVa4A9j9/WoHBNcv1uEe6Gp3aCa0yZ8io/aGoAVJRjecCoGU1wPX7Mk3uV3xQ3p+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD22uIFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C88C4CEEC;
	Tue, 14 Jan 2025 20:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736886035;
	bh=I9Ekx6aq/CtvmHlK2JuDkCREj16AUwVV0szqwfvn2B8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JD22uIFW+fdCoYLcYeIsO2Txr02Nmv6PaD3vP9xJM7UUTueYcu0+ONzHQG06vXduq
	 lkoMo+Ps9CQCr69LMbVC2r9TQ2pbJeuo+AKkJiGA41O1f7iirwWhLVUxRW/AUz8kuH
	 jZpbpAJaemRr7wa9BNXuP5WR85oNMonECKjO4soOFO0HIZB1U6fpR0kVfbKf6g947P
	 Y0CUnLeoKueHwxpK6IgZ0MpvJ1xE8c/iapkJ0dgX+jM1tRAv2LScMM/ZaftTdnfnDI
	 dd1+xdcog1URclurHKunuZhxCOkXFYMDTm+uoXHKvSb/xOSY6nu/t6ezK5/fcoCUEJ
	 DvZGIPiGaAZsg==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3eb6b16f1a0so1745342b6e.3;
        Tue, 14 Jan 2025 12:20:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+hJgJttCSCeihAO2+vZgyWlrJWiCTKbLYmjpXoOOdPK2iXMoCkH8RLXc80NV7kmD2HRq9T2xUs5EkelFx@vger.kernel.org, AJvYcCUI9chl7JoRlANikNKO8UpTbWd4K0uyXJ2fZYQ0MZ6XZwsw+//N4Hfc+/7/wrDSaroD4FBwh4EJ7c3Upijm@vger.kernel.org, AJvYcCX8KEAO08VaDHLFVoI9yKwBCNJ4ZQ5unF0I1aYAfI5TTQnOJmtWEJD4GoZ256Galk61nZXAwETzagw=@vger.kernel.org, AJvYcCXbpV/LYFYtV1HuWqT2qBJGeQ+1TfNG1iOt9FhTiU2lGS8TUw2gzBlaZqPCOIAf3AaIomN7p8pClj3+PU8=@vger.kernel.org, AJvYcCXi8fvBj/DjbwZOD2M7b6ihGaxlR5f1NuAyVpm+rnHmdFh6ycTmYvf1/W9cpdMirkBE8sHr3AFmpASF@vger.kernel.org
X-Gm-Message-State: AOJu0YxEuqBJK8vi5PWkFnhSnJF9Js9wAPdzHqQrDkYabPVvBMPigQos
	0r3XTZP2iI8ykAcFONBWeHmBuCMMY3hJ7dwoWAJgTWVqwLzAAms/KJvYxgi7FT8ps31gqNHlssX
	PLV+BxmDQQqOaaURxUZANMINexNM=
X-Google-Smtp-Source: AGHT+IHBdFDv09GmJQAPh9/RI61yRA+OUJBTYVfB4ZAfwslXJG+AQnvyEewTo5F7++0A17YOZNGuMRHAq8Q+xsm4lZ0=
X-Received: by 2002:a05:6808:198d:b0:3eb:615a:ece5 with SMTP id
 5614622812f47-3ef2ec54eedmr15212295b6e.15.1736886034615; Tue, 14 Jan 2025
 12:20:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com> <20250103-wake_irq-v2-1-e3aeff5e9966@nxp.com>
In-Reply-To: <20250103-wake_irq-v2-1-e3aeff5e9966@nxp.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 21:20:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hj7wUU3f_j5QH3fNUFKokaXr0octaP2M1Ho_L_BspoUA@mail.gmail.com>
X-Gm-Features: AbW1kvZ2IsMpRpq9v9cu6FjARLwcHzjMVAJFZcTXGy5umUj9Q22VPlrSsSvyjVE
Message-ID: <CAJZ5v0hj7wUU3f_j5QH3fNUFKokaXr0octaP2M1Ho_L_BspoUA@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] PM: sleep: wakeirq: Introduce device-managed
 variant of dev_pm_set_wake_irq
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 9:42=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add device-managed variant of dev_pm_set_wake_irq which automatically
> clear the wake irq on device destruction to simplify error handling
> and resource management in drivers.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/base/power/wakeirq.c | 26 ++++++++++++++++++++++++++
>  include/linux/pm_wakeirq.h   |  6 ++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 5a5a9e978e85f3fc9d89cb7d43527dc1dd42a9b1..8aa28c08b2891f3af49017536=
2cc1a759069bd50 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -103,6 +103,32 @@ void dev_pm_clear_wake_irq(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_clear_wake_irq);
>
> +static void devm_pm_clear_wake_irq(void *dev)
> +{
> +       dev_pm_clear_wake_irq(dev);
> +}
> +
> +/**
> + * devm_pm_set_wake_irq - device-managed variant of dev_pm_set_wake_irq
> + * @dev: Device entry
> + * @irq: Device IO interrupt
> + *
> + *
> + * Attach a device IO interrupt as a wake IRQ, same with dev_pm_set_wake=
_irq,
> + * but the device will be auto clear wake capability on driver detach.
> + */
> +int devm_pm_set_wake_irq(struct device *dev, int irq)
> +{
> +       int ret;
> +
> +       ret =3D dev_pm_set_wake_irq(dev, irq);
> +       if (ret)
> +               return ret;
> +
> +       return devm_add_action_or_reset(dev, devm_pm_clear_wake_irq, dev)=
;
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_set_wake_irq);
> +
>  /**
>   * handle_threaded_wake_irq - Handler for dedicated wake-up interrupts
>   * @irq: Device specific dedicated wake-up interrupt
> diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
> index d9642c6cf85211af603ce39e280a5b4de6617ee5..25b63ed51b765c2c6919f2596=
68a12675330835e 100644
> --- a/include/linux/pm_wakeirq.h
> +++ b/include/linux/pm_wakeirq.h
> @@ -10,6 +10,7 @@ extern int dev_pm_set_wake_irq(struct device *dev, int =
irq);
>  extern int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq);
>  extern int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int=
 irq);
>  extern void dev_pm_clear_wake_irq(struct device *dev);
> +extern int devm_pm_set_wake_irq(struct device *dev, int irq);
>
>  #else  /* !CONFIG_PM */
>
> @@ -32,5 +33,10 @@ static inline void dev_pm_clear_wake_irq(struct device=
 *dev)
>  {
>  }
>
> +static inline int devm_pm_set_wake_irq(struct device *dev, int irq)
> +{
> +       return 0;
> +}
> +
>  #endif /* CONFIG_PM */
>  #endif /* _LINUX_PM_WAKEIRQ_H */
>
> --

I can apply this patch for 6.14, but the rest of the series will need
to be picked up by the respective driver maintainers.

I hope this works for you?


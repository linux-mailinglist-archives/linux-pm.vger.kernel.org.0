Return-Path: <linux-pm+bounces-40739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA65D19309
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 14:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFC4F302A44E
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 13:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8E63921EC;
	Tue, 13 Jan 2026 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6UqNK7a"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E2E3904E8
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312498; cv=none; b=KEMSvQxhB+yPVbt9VWYeBRN2xJK3eD6BMepv2tGeZ1spUbzui36d7HF3fMgpAwWOof3naAvAy2VLJvKY/mSb73jlb1EFVpyDLD2YIJ1onclNg5pNRGF1VyqDD7i+dZlaeg89BXPZHSF/8UYvD0GPFA+fqLgttne6xAPxKxet7zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312498; c=relaxed/simple;
	bh=qoD2yGygqaoN/33J25h6tmmzMz3XXXhCzzZUa7glhR0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lu2V6Qfn4s8KvlQmTvfu3QNSY/1cHYUYNarX3HwioicrPKHobczCCTPKOUR+2LiPy0wvnhlN0H/PzhTEfVD9cYCZwRkMQ8D+Z7J2T/lYFhS4jSwwmy+AyETrquE2Pjw+Z851lywbfMy6BZdGXa7wsHeSHA5rcScAkFmNEYEpemc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6UqNK7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBEEC19422
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 13:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768312497;
	bh=qoD2yGygqaoN/33J25h6tmmzMz3XXXhCzzZUa7glhR0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=X6UqNK7aswU+lA9kqtiwNbzfFTE7AXD8G34A3HFNcIq/B2EYROSgMDjZNtWsFli0W
	 k32LO9Z65v0r3jZltkRIp1Rm8R0ZgM0KWMrlmDuZadmroW53bp6eD5wY1H7W+6eBqc
	 1xbzZeAvLJ4QpJHtfj46YxPtvxOAZSbTP96oTJg0Ra27wTxRDWlBIdkIKza73Mfvn0
	 hswtNHgzRjXkMl1tVcVsHinE2qax2yxkeCIaeHcMDfahObLWOR6NyeGur7OunaG+G/
	 aEsLN//7A7rAR1JffPlgSN0Zzh3NWzqHKDqgbf5JTjBffeRCcpcS/NyxhgPZcI+jUY
	 fWWxmgfEHi69g==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b79451206so4786495e87.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 05:54:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjyByBY3QSiBajm2ZxJval+5Ah6LYdXzYL4sEnmZcqwvsNuzmEcXlP+qv/VOgD1StJHaekAK3XhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjIFAev9bkveJw+p+WOpnF7azv6kV1OKeJXMs31LrYMhOugeqq
	i/+IWmwhot/ef+/JIkZ1B7OStMocww/L2PFVkSYUMYyvDpEOBNKi+O7PeMjXT9d+QKsO9He5TF4
	TdgHx0sbHth2ww/0a9ty84RjGRmgqXXbvfPYZA4obww==
X-Google-Smtp-Source: AGHT+IHtxkUGwU9KE66IHi1cBKvrXikFiqjf5FnMhLoUqzd0zbPBghAy/6jPyeE4fjWfRvr/ZtuwVmPnk4eOTeZtRkw=
X-Received: by 2002:a2e:be13:0:b0:37f:a216:e455 with SMTP id
 38308e7fff4ca-382ff6a998emr60740471fa.18.1768312496407; Tue, 13 Jan 2026
 05:54:56 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Jan 2026 08:54:55 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Jan 2026 08:54:55 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260112-pci-m2-e-v4-2-eff84d2c6d26@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com> <20260112-pci-m2-e-v4-2-eff84d2c6d26@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 08:54:55 -0500
X-Gmail-Original-Message-ID: <CAMRc=McDvQoqfH0Gy-wzbcEGvNCZACSACCcviwpCc4YNSpKYrw@mail.gmail.com>
X-Gm-Features: AZwV_QiNfMpaasLV4YYAdk4pjC7egojRYHOX7MP76SYTH8HXlXx4MiSntJqB_WU
Message-ID: <CAMRc=McDvQoqfH0Gy-wzbcEGvNCZACSACCcviwpCc4YNSpKYrw@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] serdev: Add an API to find the serdev controller
 associated with the devicetree node
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 17:26:01 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Add of_find_serdev_controller_by_node() API to find the serdev controller
> device associated with the devicetree node.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/tty/serdev/core.c | 16 ++++++++++++++++
>  include/linux/serdev.h    |  9 +++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index b33e708cb245..25382c2d63e6 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -504,6 +504,22 @@ struct serdev_controller *serdev_controller_alloc(struct device *host,
>  }
>  EXPORT_SYMBOL_GPL(serdev_controller_alloc);
>
> +/**
> + * of_find_serdev_controller_by_node() - Find the serdev controller associated
> + *					 with the devicetree node
> + * @node:	Devicetree node
> + *
> + * Return: Pointer to the serdev controller associated with the node. NULL if
> + * the controller is not found.
> + */

Please also say that the caller is responsible for calling
serdev_controller_put() on the returned object.

Bart

> +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
> +{
> +	struct device *dev = bus_find_device_by_of_node(&serdev_bus_type, node);
> +
> +	return (dev && dev->type == &serdev_ctrl_type) ? to_serdev_controller(dev) : NULL;
> +}
> +EXPORT_SYMBOL_GPL(of_find_serdev_controller_by_node);
> +
>  static int of_serdev_register_devices(struct serdev_controller *ctrl)
>  {
>  	struct device_node *node;
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index ecde0ad3e248..db9bfaba0662 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -333,4 +333,13 @@ static inline bool serdev_acpi_get_uart_resource(struct acpi_resource *ares,
>  }
>  #endif /* CONFIG_ACPI */
>
> +#ifdef CONFIG_OF
> +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node);
> +#else
> +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_OF */
> +
>  #endif /*_LINUX_SERDEV_H */
>
> --
> 2.48.1
>
>
>


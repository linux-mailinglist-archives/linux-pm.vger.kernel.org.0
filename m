Return-Path: <linux-pm+bounces-29572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F59AE9A49
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 11:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC2D189C41F
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BA52C08C9;
	Thu, 26 Jun 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KsIaojvX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2AB2BEC3B
	for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750930729; cv=none; b=HkCntEM7D+7gQdI5xhu52FM751jdBkUlIOQeUiMnvjHW763L1K1EA/EQKm+dM5Q0OVUk1r4z6EneR4UnLxxjVBv+2ZqMBDGP6uxCPSMPwTH4WOW65bG6tihwDo7KDEfp1DL/LUviYHVHfVucPZbw2vrdiBBYHjjMHcnNE3I0k0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750930729; c=relaxed/simple;
	bh=e6BYYN0RrbPQauR2xmIcMIc/SKh6PKKv9oYpeF+Oqd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDRlrGWRUMGFOw2kEMpEdhBEgZNhTLhcYW/alNaUoOwBrsHwQAfMEj5e3e5OKtQK0x/xOfrITdqyphfaTQUoCGEMN8FBxFe4TdWI+EU1Jmv1C6qcp4b06AnIiyzeNbjDusWwKCr/+ZqXTaXu4pT8g6XIZiRF9cnNsH/4kA7RdCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KsIaojvX; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e740a09eb00so592926276.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 02:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750930725; x=1751535525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pMUIQ5YDyeNXFe3b105yTgr62Ww89LPKr15AiB8c878=;
        b=KsIaojvXzRsFuFW8AdaeLjDtWqbVsB9KOLmyXWBGqHa0Faylk2+kFq3hPdxjN6OvP/
         9JFJdCAQ61WNWESi3gn5SXG1ZUj9r3OBQufANaYCpeyzCxzu6yxINMvZ6q25Dlu5l3KW
         tHEFFw0PiH2ZT54usj2wEFK+hjmmYf2bkyQDO7ki1dELWwQaAykOqB6DZAhnEctW1KxF
         /rFw8uF7BJnjJqSxvNECm6hhGvEZXe+4y7tb5vzhtXHF/yHlKt9v1s67ZEqJONb4muXZ
         JzB5w6PQ960IdSmJzZqi62JxGctdGlpNrH0LdBZyuWRR5nOKhMSB5NhOkcgRjZp5gaen
         bf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750930725; x=1751535525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMUIQ5YDyeNXFe3b105yTgr62Ww89LPKr15AiB8c878=;
        b=rz+1OJd+HhE4Bqnq+WJmniU3c/vC81lL5AvzDJDNrtF0pmiDAZjfogMonXZPYJS/vM
         7VOaHvXBptH4swEFC778EJ/1pQbz9WXIvX1JQFlnEoXOqj3C7yem92yfwaC/W5cFpeOK
         bINq88lqEBXG8ZguIlJFFBs5H5i7qk30jc2CybD3p+T2kXJS7zW3ibDifipEUO6KoCEc
         gqXJAGXGNiBGN719pqjLL/8u5QkPXT4t1QDNijyIdY9eR/U1JvTspop5rcK4tRrRMInh
         8Z9hOG2LmWoSRBkm14/LcTvUyp2L9Y1oWo9ORruvbT5kqrWCT2ksJXI8UnBpm9ASJG1t
         k1ww==
X-Gm-Message-State: AOJu0Yx3bem5BWuVSET7yKiEbl+wWPYTHE+kG3ap6E6xRVaWn/8WDR6G
	UzkaQmD8V/6Jkk9jOAFqUAplG1eqTaK/c15oCjJ+PGfAeLxESY/bP2wuQjkPYNDHv4HTyWh8Bty
	CEinhnOTflroztMCTDQKhBigv8hxPyuAx5E0x6DSAx1BBJzOzJ9LS
X-Gm-Gg: ASbGncsItjI6/gjftDzip7I21w8D/LvJmjebh1ctHsnt0A92yI4caM+vykQIafh3ygj
	D+0YXL46S/k4jUrvJ6BLJUCHSXcJ+h0a/LzM2Jd213UrzB49S/tY3DrP/s9R4Lz5tgIGJgWQEOY
	BTeaRx4XhdIhvEAm8FEYj4MP358oqicur4dRFbNhDf0S/p
X-Google-Smtp-Source: AGHT+IGrpanO/3GvZtkdw+zW8xGsoUTA6H0Q9aX5hZ9J/rpREkBRKcp+Slx0dssooKyIYA59huReEPP3hAYYC9tyJtU=
X-Received: by 2002:a05:6902:168f:b0:e81:52ff:b40 with SMTP id
 3f1490d57ef6-e8601786020mr7981913276.20.1750930725237; Thu, 26 Jun 2025
 02:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net> <2045419.usQuhbGJ8B@rjwysocki.net>
In-Reply-To: <2045419.usQuhbGJ8B@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Jun 2025 11:38:08 +0200
X-Gm-Features: Ac12FXyLItyotFSiFfzbcS6RmKm69PO701oLuNAu0WjTraC_1HAu9CP21xq8fYM
Message-ID: <CAPDyKFq8ea+YogkAExUOBc2TEqi1z9WZswqgP29bLbursFUApg@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] PM: Move pm_runtime_force_suspend/resume() under CONFIG_PM_SLEEP
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since pm_runtime_force_suspend/resume() and pm_runtime_need_not_resume()
> are only used during system-wide PM transitions, there is no reason to
> compile them in if CONFIG_PM_SLEEP is unset.
>
> Accordingly, move them all under CONFIG_PM_SLEEP and make the static
> inline stubs for pm_runtime_force_suspend/resume() return an error
> to indicate that they should not be used outside CONFIG_PM_SLEEP.
>

Just realized that there seems to be some drivers that actually make
use of pm_runtime_force_suspend() from their ->remove() callbacks.

To not break them, we probably need to leave this code to stay under CONFIG_PM.

Kind regards
Uffe

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/runtime.c |    4 ++++
>  include/linux/pm_runtime.h   |   20 ++++++++++++++------
>  2 files changed, 18 insertions(+), 6 deletions(-)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1941,6 +1941,8 @@
>         pm_request_idle(link->supplier);
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +
>  bool pm_runtime_need_not_resume(struct device *dev)
>  {
>         return atomic_read(&dev->power.usage_count) <= 1 &&
> @@ -2063,3 +2065,5 @@
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_force_resume);
> +
> +#endif /* CONFIG_PM_SLEEP */
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -66,9 +66,6 @@
>
>  extern int pm_generic_runtime_suspend(struct device *dev);
>  extern int pm_generic_runtime_resume(struct device *dev);
> -extern bool pm_runtime_need_not_resume(struct device *dev);
> -extern int pm_runtime_force_suspend(struct device *dev);
> -extern int pm_runtime_force_resume(struct device *dev);
>
>  extern int __pm_runtime_idle(struct device *dev, int rpmflags);
>  extern int __pm_runtime_suspend(struct device *dev, int rpmflags);
> @@ -257,9 +254,6 @@
>
>  static inline int pm_generic_runtime_suspend(struct device *dev) { return 0; }
>  static inline int pm_generic_runtime_resume(struct device *dev) { return 0; }
> -static inline bool pm_runtime_need_not_resume(struct device *dev) {return true; }
> -static inline int pm_runtime_force_suspend(struct device *dev) { return 0; }
> -static inline int pm_runtime_force_resume(struct device *dev) { return 0; }
>
>  static inline int __pm_runtime_idle(struct device *dev, int rpmflags)
>  {
> @@ -330,6 +324,20 @@
>
>  #endif /* !CONFIG_PM */
>
> +#ifdef CONFIG_PM_SLEEP
> +
> +extern bool pm_runtime_need_not_resume(struct device *dev);
> +extern int pm_runtime_force_suspend(struct device *dev);
> +extern int pm_runtime_force_resume(struct device *dev);
> +
> +#else /* !CONFIG_PM_SLEEP */
> +
> +static inline bool pm_runtime_need_not_resume(struct device *dev) {return true; }
> +static inline int pm_runtime_force_suspend(struct device *dev) { return -ENXIO; }
> +static inline int pm_runtime_force_resume(struct device *dev) { return -ENXIO; }
> +
> +#endif /* CONFIG_PM_SLEEP */
> +
>  /**
>   * pm_runtime_idle - Conditionally set up autosuspend of a device or suspend it.
>   * @dev: Target device.
>
>
>


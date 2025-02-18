Return-Path: <linux-pm+bounces-22307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EC9A39C86
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 13:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D107B1895E76
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE912627ED;
	Tue, 18 Feb 2025 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LI1XOXi5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A69C25A643
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883012; cv=none; b=WZqd/mywZ9oH9QPYL2pkBCUZLGXSsqkuF0ntxFhi91cUqTnCemvZycQdgL1Uz6MkEnacv0NzylpGLTIwGOuPx8lz+TC/NgNY1spDBMi6CqYaXY9kb0xMiE8j9BPoswlvNM9Bqkb9jnMJsQxMd3DZS1t021lwnAqc9MHe46+C3jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883012; c=relaxed/simple;
	bh=DSSMR5/oEhrBBxMGuRsitGmxXCXATnKq0oSmeDXTbJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5G3Ee/6G2FmTd0sCyLDlijykuvotVWTusbSiYsrm9qRuRE424UXwIkiU/jFf0o5Dcrn6v650h5SJkAHd6C6qFOndArvY4oLqpFBc5fjfpX0afIA9U8woFa2xeir0bFtQNxgtLmOdw/O+A9y9dJfzwlBxPKG0wwjTvHmE3cE7t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LI1XOXi5; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso4015720276.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 04:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739883010; x=1740487810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QK+dyc1PR4OboE+3BwHPM5pfaMLTgXZ0OSHSzMoMBf4=;
        b=LI1XOXi5tf3zljDF0S2W8d4a0gEosS7HarkrSAemlYCh41CU7SWjumrljK7DB+dNqG
         ndkGY6MsMzto8nTXbqAtWtlJiIL2sIMhYjR/lJaZR18zJiJXRPGYi8k2byALdl0UGy3v
         Gk3EKDm8mISHW8w2A1vjknH0yO+F77m612hUEjGLLp50UPKtJq+tAYggbTgPmreKc6qI
         Cg04nUgYmvp/PwT7z3pOO1pv8bfSMdUg8YnYShMOvWpyDa+i2HvGe2Iavrx4SuBVWnfM
         H11DFYBxZV037n98jzY3/imgPiGfLYBHoQ+kVhL8LFhe9FXKkiHSrIBhpV6ZV83WzBL8
         iEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739883010; x=1740487810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QK+dyc1PR4OboE+3BwHPM5pfaMLTgXZ0OSHSzMoMBf4=;
        b=TW7KvWoGNiJu3+Ii00HsA9CpAoPJA0L1q8Zhocnv3GE9v/iUMnfSBvQpkiEQC6MXyh
         0+swAdCXThhCFLQ1FcGHlN94KjR8bLfLKJNkT1J0GeJgkMqWdhU5wQTSp3MGzMn3rdu1
         IDBUf0AgGkQHYmdhyJesm3eg7aW+TeSKWb4IFvns9GcJ+hZVxI6OzCJq2fzItRgiRZGK
         hxzNBK/8gbLf0xTvLRdn5F2/ec6Rnef4mMWSvkHt4uiOVwGL6TnEkm9iX1luZRNrF+t3
         gZPc3i9uirof4+s0hIVY9uAtX47xRHHFsvxaLHIoSB2fLKAET+HvDLBBDZ5EkIN4G4IE
         biDw==
X-Gm-Message-State: AOJu0Yz7eqByRia8qiQ0q7yeWOGvUdvhgVyv9VoULgB/vmDq/apm0jdx
	R7Bo9a/EIKTt6AzEJ/k6T0QD7ZpHOO7qhyLKsaGjXToo06r0nyL8/XBq0Gc7OMbjW6yxWqBzalW
	6mMd8mAtosFfpt0J6xmGMQgiX3kSpxrmV5KuWrA==
X-Gm-Gg: ASbGnctzyHnDuw3qIF/6QNIzDeDUfX6W6Jkb50Guv90llow+egkM74XEFCnOW6NtHh8
	xI08zDUTpv0tESB1YTkAjBZ5XwK4xOYYKYCqgXKIacoB760TPGW+bkiitPH+b0LtQspqSROagvw
	==
X-Google-Smtp-Source: AGHT+IGH6vLk+U+IpOyIROSa4vJIPltJqku8QV1ftbJYlBuc7ZpPko6DcHgsxYIF2mNCIF53PQLSxJLqorXWqZRliXg=
X-Received: by 2002:a05:6902:1086:b0:e5d:dcdb:18ed with SMTP id
 3f1490d57ef6-e5ddcdb1badmr6882930276.32.1739883010026; Tue, 18 Feb 2025
 04:50:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4966939.GXAFRqVoOG@rjwysocki.net> <8497121.T7Z3S40VBb@rjwysocki.net>
In-Reply-To: <8497121.T7Z3S40VBb@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Feb 2025 13:49:34 +0100
X-Gm-Features: AWEUYZmNBflOPEaSpUMJ4BLjpv29L0jW7mM1vQW96k8wGYHbNA9-sC34ojg02fg
Message-ID: <CAPDyKFpp1iuBXZB-T2=hhTND4Z63s7kJfaXWuiKTu1rrqMGc_Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] PM: runtime: Introduce pm_runtime_blocked()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 21:20, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Introduce a new helper function called pm_runtime_blocked() for
> checking the power.last_status value indicating whether or not the
> enabling of runtime PM for the given device has been blocked (which
> happens in the "prepare" phase of system-wide suspend if runtime
> PM is disabled for the given device at that point and has never
> been enabled so far).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/runtime.c |   17 +++++++++++++++++
>  include/linux/pm_runtime.h   |    2 ++
>  2 files changed, 19 insertions(+)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1555,6 +1555,23 @@
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_enable);
>
> +bool pm_runtime_blocked(struct device *dev)
> +{
> +       bool ret;
> +
> +       /*
> +        * dev->power.last_status is a bit field, so in case it is updated via
> +        * RMW, read it under the spin lock.
> +        */
> +       spin_lock_irq(&dev->power.lock);
> +
> +       ret = dev->power.last_status == RPM_BLOCKED;
> +
> +       spin_unlock_irq(&dev->power.lock);
> +
> +       return ret;
> +}
> +
>  static void pm_runtime_disable_action(void *data)
>  {
>         pm_runtime_dont_use_autosuspend(data);
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -81,6 +81,7 @@
>  extern void pm_runtime_unblock(struct device *dev);
>  extern void pm_runtime_enable(struct device *dev);
>  extern void __pm_runtime_disable(struct device *dev, bool regular);
> +extern bool pm_runtime_blocked(struct device *dev);
>  extern void pm_runtime_allow(struct device *dev);
>  extern void pm_runtime_forbid(struct device *dev);
>  extern void pm_runtime_no_callbacks(struct device *dev);
> @@ -277,6 +278,7 @@
>  static inline void pm_runtime_unblock(struct device *dev) {}
>  static inline void pm_runtime_enable(struct device *dev) {}
>  static inline void __pm_runtime_disable(struct device *dev, bool c) {}
> +static inline bool pm_runtime_blocked(struct device *dev) { return true; }
>  static inline void pm_runtime_allow(struct device *dev) {}
>  static inline void pm_runtime_forbid(struct device *dev) {}
>
>
>
>


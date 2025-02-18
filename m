Return-Path: <linux-pm+bounces-22306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA81A39C83
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 13:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE75218934EF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD52263893;
	Tue, 18 Feb 2025 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6heF/fB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F1125A620
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883000; cv=none; b=bXPs7WrLo3WeBEHfOZrRtqGX5QEZLFDBJg/MQUTu23e6IrFBWwKwi8j9DM1IrNflgW9OXY3DFHnMd5u39sCJDdNaHG4uyZh34EzO7ZTH9BLqxDQYkUmC1nMQz7G0W47m2U1jVMsDb048HR+aqpaffq4zaMEbXzGLHN1bD5BDlq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883000; c=relaxed/simple;
	bh=EYXiIhJKzDkf/Zed83KpoEMdqEqpk8RBZccRoSos+zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9bczmn0HDHSEaIt+IPP7aHchvql/0WdVN1FvTPN5RY7pVeSG8nzdrV0+3jLPFu1Pyux+sayLHnHSoPRzvParezSM27EcZyD43HyQyoBIMN3dJvGwG3Dec1Jgru8fOTaYCwznk5YLrutb+fM12pBeFiL4luhZ18UqvPTxcFYeHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g6heF/fB; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so3850534276.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 04:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739882996; x=1740487796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IiwBH1VwDjX3hwLw759NPJsM3Da1Zq4No+XqAt8EcVE=;
        b=g6heF/fBGLiDZw18AlyiUpOYB8fnjidsa+Wv6quUvseeLJkVzNR5tYB5x2QZHw6ewA
         fcJ+gaUX4kkZ31qVft3u96SH5pBBH3biLXHXR3Ao5IXWypn4mNFPxQJlOLjBvi5RHvve
         TKW49LwE/10VKypTQMxv5PDYa4j1VMhFiKfRz7zVs9SXbIxxDdZzhr7P8X96TJXwglUB
         KoEvznfytbIYa/mfGrpnzqDjMgQaJjhtu+MSaNxhvqBo2nTW3NQE0IM6IcbujdPemdv1
         KURwkp6TVeNNs9CAEKEdAs1ASma2lksSTEbn6fNym1zS+8gPdzysMNWZNWd2VRCKnkNT
         Zm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739882996; x=1740487796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiwBH1VwDjX3hwLw759NPJsM3Da1Zq4No+XqAt8EcVE=;
        b=fVKWNIlzJq89hwzesu5rKlDa269hnXLPZC0eMbgEywPSOyYJnb+YOe+8CGo/USh/RU
         mW6g1bdbhs1l/4yZdELw5W0KsOWOnhpFhQ1QHUYedacRBtN48OsAJ9Oly53DkBNSOkY5
         SJQ1jeO09FcmoK6ji9AKUjD4OQhv3+Pd8UAQzptKhVdHqgTGsP+QjJ8O0v1PfBglFwzC
         b5k9TwuPuf4vPGiuMn3biCsk8GXAonY3dZ1rF5vDFkayNTBJBh1zg8HszZe3yJENQxoo
         OIIsMTc9KNXuwAEbymnYTqHK0KKWoe/RdmVrljaPILqkj14zL4/w7E1yWKpVSayQIh4k
         KyhQ==
X-Gm-Message-State: AOJu0YwlO/iYzxvoGskXop5AG546ZteYhnZJuTY0c3/w0vBJyYhRAwYE
	MJMrJWgu6z7E3oW848Uiv0TW4xkz+Taf6qZhqHQqlN8srCbtE19grg7KLWWSbSengQyAp++cqUk
	Il6sWSIJw4XMlYYddQb6B6wnU7SnmtivRrtas6A==
X-Gm-Gg: ASbGncsxPrHWHmgIZqyaG/WOwX4hu010GXjr+oRpZlqTFtb/qhbEQWem5SlKCNR+Zmm
	9xCX4RO1sKmMNvsctCz1apHaFVVnJKJlAb/KSfOg6mHVJ6rSsDhw33hIcGKI9qivI/trAz9VLHQ
	==
X-Google-Smtp-Source: AGHT+IFV9+p4KGq953gb9Ygs5FJ/2Cq+/II4+fSXpQadcHenCDQI8dVl1agYXuFKW5/2VG+FDeTGo04AqfI0ojx2avw=
X-Received: by 2002:a05:6902:2684:b0:e5b:1c0a:6cb6 with SMTP id
 3f1490d57ef6-e5dc92f3a3dmr9935964276.36.1739882996443; Tue, 18 Feb 2025
 04:49:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4966939.GXAFRqVoOG@rjwysocki.net> <2984234.e9J7NaK4W3@rjwysocki.net>
In-Reply-To: <2984234.e9J7NaK4W3@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Feb 2025 13:49:20 +0100
X-Gm-Features: AWEUYZmAiMQQjoSXdJvdY6LlYTyK9cHRbbIMKwfyPB3OyZ8WmWz4Jn-c8CS83kE
Message-ID: <CAPDyKFonaX6gfHgj-OJaowUxhYZR4qQ8EZvvLHfF9AP1GvqrZw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] PM: Block enabling of runtime PM during system suspend
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
> If device_prepare() runs on a device that has never had runtime
> PM enabled so far, it may reasonably assume that runtime PM will
> not be enabled for that device during the system suspend-resume
> cycle currently in progress, but this has never been guaranteed.
>
> To verify this assumption, make device_prepare() arrange for
> triggering a device warning accompanied by a call trace dump if
> runtime PM is enabled for such a device after it has returned.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c    |    9 +++++++++
>  drivers/base/power/runtime.c |   24 ++++++++++++++++++++++++
>  include/linux/pm.h           |    1 +
>  include/linux/pm_runtime.h   |    6 +++++-
>  4 files changed, 39 insertions(+), 1 deletion(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1109,6 +1109,8 @@
>         device_unlock(dev);
>
>  out:
> +       /* If enabling runtime PM for the device is blocked, unblock it. */
> +       pm_runtime_unblock(dev);
>         pm_runtime_put(dev);
>  }
>
> @@ -1815,6 +1817,13 @@
>          * it again during the complete phase.
>          */
>         pm_runtime_get_noresume(dev);
> +       /*
> +        * If runtime PM is disabled for the device at this point and it has
> +        * never been enabled so far, it should not be enabled until this system
> +        * suspend-resume cycle is complete, so prepare to trigger a warning on
> +        * subsequent attempts to enable it.
> +        */
> +       pm_runtime_block_if_disabled(dev);
>
>         if (dev->power.syscore)
>                 return 0;
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1460,6 +1460,26 @@
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_barrier);
>
> +void pm_runtime_block_if_disabled(struct device *dev)
> +{
> +       spin_lock_irq(&dev->power.lock);
> +
> +       if (dev->power.disable_depth && dev->power.last_status == RPM_INVALID)
> +               dev->power.last_status = RPM_BLOCKED;
> +
> +       spin_unlock_irq(&dev->power.lock);
> +}
> +
> +void pm_runtime_unblock(struct device *dev)
> +{
> +       spin_lock_irq(&dev->power.lock);
> +
> +       if (dev->power.last_status == RPM_BLOCKED)
> +               dev->power.last_status = RPM_INVALID;
> +
> +       spin_unlock_irq(&dev->power.lock);
> +}
> +
>  void __pm_runtime_disable(struct device *dev, bool check_resume)
>  {
>         spin_lock_irq(&dev->power.lock);
> @@ -1518,6 +1538,10 @@
>         if (--dev->power.disable_depth > 0)
>                 goto out;
>
> +       if (dev->power.last_status == RPM_BLOCKED) {
> +               dev_warn(dev, "Attempt to enabled runtime PM when it is blocked\n");

/s/enabled/enable

> +               dump_stack();
> +       }
>         dev->power.last_status = RPM_INVALID;
>         dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
>
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -597,6 +597,7 @@
>         RPM_RESUMING,
>         RPM_SUSPENDED,
>         RPM_SUSPENDING,
> +       RPM_BLOCKED,
>  };
>
>  /*
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -77,8 +77,10 @@
>  extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
>  extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
>  extern int pm_runtime_barrier(struct device *dev);
> +extern void pm_runtime_block_if_disabled(struct device *dev);
> +extern void pm_runtime_unblock(struct device *dev);
>  extern void pm_runtime_enable(struct device *dev);
> -extern void __pm_runtime_disable(struct device *dev, bool check_resume);
> +extern void __pm_runtime_disable(struct device *dev, bool regular);

This looks unrelated to the $subject patch.

>  extern void pm_runtime_allow(struct device *dev);
>  extern void pm_runtime_forbid(struct device *dev);
>  extern void pm_runtime_no_callbacks(struct device *dev);
> @@ -271,6 +273,8 @@
>  static inline int __pm_runtime_set_status(struct device *dev,
>                                             unsigned int status) { return 0; }
>  static inline int pm_runtime_barrier(struct device *dev) { return 0; }
> +static inline void pm_runtime_block_if_disabled(struct device *dev) {}
> +static inline void pm_runtime_unblock(struct device *dev) {}
>  static inline void pm_runtime_enable(struct device *dev) {}
>  static inline void __pm_runtime_disable(struct device *dev, bool c) {}
>  static inline void pm_runtime_allow(struct device *dev) {}
>
>
>

With the minor things above fixed, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


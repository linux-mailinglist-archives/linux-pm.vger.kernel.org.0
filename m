Return-Path: <linux-pm+bounces-21094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13950A21C89
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 12:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9483A4E18
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C481DA0E0;
	Wed, 29 Jan 2025 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yqpfxZQh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155E1DA100
	for <linux-pm@vger.kernel.org>; Wed, 29 Jan 2025 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738151610; cv=none; b=UGRkOt4fe6+/ovCCNUP0zpUEkT2cNm13pTEn9YmpBLmp7zqKpdfPV31P5xstAyk6zqWfSPQB1uqX4/D1gnXBkyJLegXq2TRiD6g16ltVMW2wIjn4nyGflHj0aIPzxqOmh71Ea3jUXvH9CaLCCcOK0bK5LD2B06HqyQAML5h0oF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738151610; c=relaxed/simple;
	bh=XtDw2SqloVGWLdyoYXtBDSN/KgfOBaAkiZ9kK5rq1js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eE0yLsepa4N9RypUTlJHpsnTIcK1VXjtsdGwmwXPWNJ8XCMPXZEHYUD8r/a7flhTKCQ1ELGsK6lcDg1vFRyZgRd2soiOTx8GjkYUu3nSIAyyuyd9MQrVErH7i7zit1QylcblYqcQv5sVddRGaUrbZjQWumUlCOReZcdtZHLQB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yqpfxZQh; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso10243532276.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Jan 2025 03:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738151606; x=1738756406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zgXniuQQ9m2oAxcAeny2BUJWoO/7cSc1XmBp/yMJbeo=;
        b=yqpfxZQhIkPsZL2fee/TwSb8qoS1hGFofaQ0Kn2u7P/EiSCWDLJE/yElW3V82qv9sn
         GLonBHY5ZskyuV7N9ytJzlSvcYRucDjifN+rs9K4sX/zzUG9yLslBOxfGZrMA9z1cqZ+
         9urMoSXksoevQcLX4qnqkJQc4bPfHBg8R/sE3OsN0bQ6HKDDttKy/o/dSGZ3VZlmLi8Q
         6Cfa5IP7ITUjUefLGhSRQMf3uu2zgo4YQFvNh/2cM1AHsxPEjO2hPoJG8D3jeMPfqGnt
         nf5F1DRreQQUL0DVeg3ASO0KBGRjIVPslTYG7RhWkIs8rmSvh5VPUJyDAHPGhhKYIqWE
         vzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738151606; x=1738756406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgXniuQQ9m2oAxcAeny2BUJWoO/7cSc1XmBp/yMJbeo=;
        b=nrLdXjX9Tx4ltelivKcPKwy+ZbY64ZPQHy2n/WgmwTGpizjSJcMGZ6qZWDo508iReP
         XNqV95ZWSqXKIHqnwNw+hGbS4C4BbbSz2P9tu1NgcVIoo9t4LyiRt2R+yfp+E5opO2Ua
         NXIG25EDN3ZhtteGg9MORW6YpXC/GVvrXYITVz4Ew6BHSuelST5/6jho5sWd/vijvZ5a
         OJkSl6xUWuoynQ3NcGM5wG1hV4pRv/TP1XkdckMTLSjfvXrJtgd8VMlG+s0VhBqusCLH
         y52GdrrKiUh7+6YoZ4OodoE8OOEPlvQziIPaCBpqx6hjbW4WfL3f1/vxvlrr7o/Qvc4J
         sdNQ==
X-Gm-Message-State: AOJu0Yx+B/HXaWrLMMIftNe8EryHh6FUqtWCnn1hucPFYnNnq3NQ3bas
	TOVtYnwqlNJsUYf0H6qOWkYom3jYjXbLeg9lSbsa3SCempYRh3MCPu6SxONdzLl4k8B28LrlyAI
	VuZxpAn/xDJBx8/L+lbqJ/VJnBK59L4SSYorpLw==
X-Gm-Gg: ASbGncuGM0aN9R70UNhTY1qvQ4hM9KG/e/162iPSSnU8guNwKZrlPT+/NP/1x/UxMTv
	Vm9d5zDfI70JyBO+w1s4Q8k2W95PmeeRi6+Xt9T5fo3VQFfmgk2ZVfxyJWskYskX+g65Cy7FP1B
	lbnX/uj6ZW
X-Google-Smtp-Source: AGHT+IFOHmbvgvshGtMkNv+jvcXgtH6+9miganRxYSomVNknKphc2UXbh7Vq6ykg+Azcv4Te5xpKA4aFJH7j/0NsslM=
X-Received: by 2002:a05:6902:2009:b0:e58:ac80:348b with SMTP id
 3f1490d57ef6-e58ac8035c2mr739345276.36.1738151606586; Wed, 29 Jan 2025
 03:53:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12619233.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12619233.O9o76ZdvQC@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 29 Jan 2025 12:52:50 +0100
X-Gm-Features: AWEUYZmwExy8dn5Px9QpzPP3otEZVwMtQLjO2zzVYB2DYID2YIuVPj5RX0qo4M8
Message-ID: <CAPDyKFpc5p3sXZ6LfdVgt8jR5ZbsQExTgeyMNA-PzcWs5A9U0A@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Synchronize runtime PM status of
 parents and children
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Kevin Xie <kevin.xie@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jan 2025 at 20:24, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the
> resume phase") overlooked the case in which the parent of a device with
> DPM_FLAG_SMART_SUSPEND set did not use that flag and could be runtime-
> suspended before a transition into a system-wide sleep state.  In that
> case, if the child is resumed during the subsequent transition from
> that state into the working state, its runtime PM status will be set to
> RPM_ACTIVE, but the runtime PM status of the parent will not be updated
> accordingly, even though the parent will be resumed too, because of the
> dev_pm_skip_suspend() check in device_resume_noirq().
>
> Address this problem by tracking the need to set the runtime PM status
> to RPM_ACTIVE during system-wide resume transitions for devices with
> DPM_FLAG_SMART_SUSPEND set and all of the devices depended on by them.
>
> Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")
> Closes: https://lore.kernel.org/linux-pm/Z30p2Etwf3F2AUvD@hovoldconsulting.com/
> Reported-by: Johan Hovold <johan@kernel.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c |   29 ++++++++++++++++++++---------
>  include/linux/pm.h        |    1 +
>  2 files changed, 21 insertions(+), 9 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -656,13 +656,15 @@
>          * so change its status accordingly.
>          *
>          * Otherwise, the device is going to be resumed, so set its PM-runtime
> -        * status to "active", but do that only if DPM_FLAG_SMART_SUSPEND is set
> -        * to avoid confusing drivers that don't use it.
> +        * status to "active" unless its power.set_active flag is clear, in
> +        * which case it is not necessary to update its PM-runtime status.
>          */
> -       if (skip_resume)
> +       if (skip_resume) {
>                 pm_runtime_set_suspended(dev);
> -       else if (dev_pm_skip_suspend(dev))
> +       } else if (dev->power.set_active) {
>                 pm_runtime_set_active(dev);
> +               dev->power.set_active = false;
> +       }
>
>         if (dev->pm_domain) {
>                 info = "noirq power domain ";
> @@ -1189,18 +1191,24 @@
>         return PMSG_ON;
>  }
>
> -static void dpm_superior_set_must_resume(struct device *dev)
> +static void dpm_superior_set_must_resume(struct device *dev, bool set_active)
>  {
>         struct device_link *link;
>         int idx;
>
> -       if (dev->parent)
> +       if (dev->parent) {
>                 dev->parent->power.must_resume = true;
> +               if (set_active)
> +                       dev->parent->power.set_active = true;
> +       }
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
> +       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
>                 link->supplier->power.must_resume = true;
> +               if (set_active)
> +                       link->supplier->power.set_active = true;

If I understand correctly, the suppliers are already handled when the
pm_runtime_set_active() is called for consumers, so the above should
not be needed.

That said, maybe we instead allow parent/child to work in the similar
way as for consumer/suppliers, when pm_runtime_set_active() is called
for the child. In other words, when pm_runtime_set_active() is called
for a child and the parent is runtime PM enabled, let's runtime resume
it too, as we do for suppliers. Would that work, you think?

> +       }
>
>         device_links_read_unlock(idx);
>  }
> @@ -1278,8 +1286,11 @@
>               dev->power.may_skip_resume))
>                 dev->power.must_resume = true;
>
> -       if (dev->power.must_resume)
> -               dpm_superior_set_must_resume(dev);
> +       if (dev->power.must_resume) {
> +               dev->power.set_active = dev->power.set_active ||
> +                       dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
> +               dpm_superior_set_must_resume(dev, dev->power.set_active);
> +       }
>
>  Complete:
>         complete_all(&dev->power.completion);
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -683,6 +683,7 @@
>         bool                    no_pm_callbacks:1;      /* Owned by the PM core */
>         bool                    async_in_progress:1;    /* Owned by the PM core */
>         bool                    must_resume:1;          /* Owned by the PM core */
> +       bool                    set_active:1;           /* Owned by the PM core */
>         bool                    may_skip_resume:1;      /* Set by subsystems */
>  #else
>         bool                    should_wakeup:1;
>
>
>

Kind regards
Uffe


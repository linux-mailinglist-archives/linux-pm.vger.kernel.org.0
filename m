Return-Path: <linux-pm+bounces-36366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5920BBEB064
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 19:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 453804FC827
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 17:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BDE2FF176;
	Fri, 17 Oct 2025 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="crq1HVv8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B14A2FE570
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721068; cv=none; b=pbnJbijCkUwKOmc1wPKg52ryzThp5Y4OthgV1OL2bmkxzunXq6fL1urw1R/SYChBME8PWUr+dsJ0EThtPX6JMDY3vxY3IJJyQa4vBgX+sSzoyT8k8JooIy/csemQwWpf4TyYzb+wuDRqse0id8q/E3Ysu1h1S4+a4IEzc95zsfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721068; c=relaxed/simple;
	bh=aBjjIxnkY/FA3VjaRF/v5raEcuHOjy9Oe4kTong4tPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oo6yBbWTDMwb+BCNlUYaBH0r7iV3ZXtuvOY3F1y1DXtgbeiFjvbxh8+Kw4pwPRZZkn/hexDKfmixWxSJCHE7JTlHxHV4lDrOy2fmRhvOmvP/0cisLXkpq3DCmnVEiNdRVIm4/RYm4LlBr7e8P5cWMG80hcW/m4SjId8Rxli3spg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=crq1HVv8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33292adb180so2128070a91.3
        for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760721064; x=1761325864; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wBM/oeHMFZtatvJ+zW6/cnV/R+5GapNosgNZTWLHrZg=;
        b=crq1HVv8qH695bk3+v5Cz9kS/qrgPWdQ+zJLT3PY0JJ8YKP3aBkrnfiAeOjnylfV70
         a+MQaEhTO7ktQ710/nlibXmsxK9xO8J6PrMcSn6nefbYxkjIzUdwMKR9+6YTj/0hFfn1
         fxIM9WNbdM+YFxjwiu0xcEA9gfklIZ3MJm5MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760721064; x=1761325864;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBM/oeHMFZtatvJ+zW6/cnV/R+5GapNosgNZTWLHrZg=;
        b=ZWz+da0gkQF5bQ9tp7f0wRE2SIQrzWQDqG5tpB0hwE1pOCTqVu8ePVirsZVT9NkIr6
         U8qys6YSGHMiVNphkLYSEor5W5mxuaq7E5hc17Q15QxaqraYDBgIL8VN7qr7uK/5JdjA
         E5EzAVbglRMUd/cEmNdA4tyhuYyz1oFDExDWEnyRYFCh1VRxx1HmZDLc0DYeLer5JOSg
         SY28sYZRruvwHrL8dmYrfqEpl4ewar4SI72NZ/2FTCSQ/eLp620AOqvr9URWh5BaYE2+
         Os7LRsyU+hryjSOQjN1Mn8YLXp+r+T4mCdA6fobzsOqyzFjTpCIpJ1744IjKGYTMQexJ
         KYYA==
X-Forwarded-Encrypted: i=1; AJvYcCWcKUl7CwwXLxMS8FH391EBdXbIpspgGQgHnQzQzOKIs4TYLo+Da3qCzvWBgsmgDAcFGsv6kSV52w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVbMyYhsocLmZBakQj3qbxDHuFRWayieLuTEEfPHJ1GplfNMF8
	fg16FaQx9IiDyLpZepDNRHur2hI7w0MG7RJ5K0wnZq/5U3wecy/Igm6rOBi1vhz8qQ==
X-Gm-Gg: ASbGncvh7WZPjUa4kCXTcwJgK2JftG40TFvxz9n8R65qkho4HiuaiWJB+g8BEdTv0Ue
	111Q7+KUFXKTXcARYeEWpjvpFSdGMhU9rI5Im0BuhkOZc6iYRh5KvTXFmETmAsJWr1OqhZJ23WP
	BHdBXX0XmBu8PGcs/XjVmWdc2X7sz1zhc9/3+vxLSl5bOGMzPOtHZKvoEd4IaEedyhyrnRBSx9Y
	6C7YX9g6eY/Id41z2lAVYVrncDykFWxlOJ0USkMK5CwcgI56dIDAIlQ++MlYnW6pMyCSYPAW9ts
	MR0YPzXmRZDxfvjmR0frHCrxd6NX2PARslvQR5gyneHdp1+04P+YgARk2fyn0NqWES4Gpw1YHe/
	M1HCz9SUuXZtfijXLfN8x3x+MQ0sZPA92DCkPzqbao4umC7jL01mQVDdjuFP23gbC98Pbcf5uhJ
	A965CGl/lw8Rupa21nVvoFwgV6ShZofSZevJjsR2/y9yh6dsFUC/RqlHPaPds=
X-Google-Smtp-Source: AGHT+IHKYNW+lzSgEoR/ftLOyWk4dENf+z842xkhdFHWXcXQluEhrxtoUMASXE6ncX8JmfeiyZU3fg==
X-Received: by 2002:a17:90b:3dc4:b0:332:8133:b377 with SMTP id 98e67ed59e1d1-33bcf87f8c3mr4875586a91.15.1760721064328;
        Fri, 17 Oct 2025 10:11:04 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5ca9:a8d0:7547:32c6])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33bb65222a6sm6105739a91.4.2025.10.17.10.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 10:11:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:11:01 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
Message-ID: <aPJ4pZFENCTx9yhy@google.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <CAJZ5v0iFa3_UFkA920Ogn0YAYLq4CjnAD_VjLsmxQxrfm5HEBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iFa3_UFkA920Ogn0YAYLq4CjnAD_VjLsmxQxrfm5HEBw@mail.gmail.com>

Hi Rafael,

On Fri, Oct 17, 2025 at 11:45:14AM +0200, Rafael J. Wysocki wrote:
> On Fri, Oct 17, 2025 at 1:28 AM Brian Norris <briannorris@chromium.org> wrote:
> >
> > PCI devices are created via pci_scan_slot() and similar, and are
> > promptly configured for runtime PM (pci_pm_init()). They are initially
> > prevented from suspending by way of pm_runtime_forbid(); however, it's
> > expected that user space may override this via sysfs [1].
> >
> > Now, sometime after initial scan, a PCI device receives its BAR
> > configuration (pci_assign_unassigned_bus_resources(), etc.).
> >
> > If a PCI device is allowed to suspend between pci_scan_slot() and
> > pci_assign_unassigned_bus_resources(), then pci-driver.c will
> > save/restore incorrect BAR configuration for the device, and the device
> > may cease to function.
> >
> > This behavior races with user space, since user space may enable runtime
> > PM [1] as soon as it sees the device, which may be before BAR
> > configuration.
> >
> > Prevent suspending in this intermediate state by holding a runtime PM
> > reference until the device is fully initialized and ready for probe().
> >
> > [1] echo auto > /sys/bus/pci/devices/.../power/control
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >
> >  drivers/pci/bus.c | 7 +++++++
> >  drivers/pci/pci.c | 6 ++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index f26aec6ff588..227a8898acac 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/proc_fs.h>
> >  #include <linux/slab.h>
> >
> > @@ -375,6 +376,12 @@ void pci_bus_add_device(struct pci_dev *dev)
> >                 put_device(&pdev->dev);
> >         }
> >
> > +       /*
> > +        * Now that resources are assigned, drop the reference we grabbed in
> > +        * pci_pm_init().
> > +        */
> > +       pm_runtime_put_noidle(&dev->dev);
> > +
> >         if (!dn || of_device_is_available(dn))
> >                 pci_dev_allow_binding(dev);
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b14dd064006c..06a901214f2c 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3226,6 +3226,12 @@ void pci_pm_init(struct pci_dev *dev)
> >         pci_pm_power_up_and_verify_state(dev);
> >         pm_runtime_forbid(&dev->dev);
> >         pm_runtime_set_active(&dev->dev);
> > +       /*
> > +        * We cannot allow a device to suspend before its resources are
> > +        * configured. Otherwise, we may allow saving/restoring unexpected BAR
> > +        * configuration.
> > +        */
> > +       pm_runtime_get_noresume(&dev->dev);
> >         pm_runtime_enable(&dev->dev);
> 
> So runtime PM should not be enabled here, should it?

Hmm, I suppose not. Does that imply it would be a better solution to
simply defer pm_runtime_enable() to pci_bus_add_device() or some similar
point? I'll give that a shot, since that seems like a simpler and
cleaner solution.

Thanks,
Brian

> >  }
> >
> > --


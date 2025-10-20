Return-Path: <linux-pm+bounces-36515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEFFBF3537
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 22:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5823350D68
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 20:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB662DF70E;
	Mon, 20 Oct 2025 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AW4HtEiK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10782DBF69
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990838; cv=none; b=g+UciSNv4iz7FBOrjKuh1sBsSevMM5gbfipkSkmTwN1hAVLSaRiPAK5idjdCNp7o1Ed08e3Jui48vMHhVytxFTJmFYR4VJSBBU8k5qV8oojXO7OlSpgxzk+axtyq7U3aXvnd/NiHTWfolHlAyUGfkXnzLM3EcICKXjgwNmabqTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990838; c=relaxed/simple;
	bh=zLPH0lbgL0Ocuc9pxtO7DECZsxJkyTUfQWX/XLhPKa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEMEDdlaytXbMQVzUVSF7qr3q4ibU9sbw0H0gINOsjkWN3WX3GsBJ3X2Q/F3oLZCdULx8nUZbO8H74y9JqhIb3+UF/nrh7UdoV5q1fXYTF43q6J3fy5Vq+lw6+kkcG0O3BoryqY38Hi/YDAxgmtnbVy9+m06DzIAkMZZM9dcujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AW4HtEiK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-794e300e20dso4647959b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 13:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760990836; x=1761595636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9qvPrU2SVrQkwkVIFxvkw04Dj387TMVRI8Nd6I2AoLU=;
        b=AW4HtEiKbxOyuVnZknkgFbT3DlKJIqP2Mk3b7vBB3bsaD8iXzdQOziOT5pNtEtvbjK
         lLAINlH9VkNRn39Ps85e2rd1qCm+Lr6t0lyUSFBnUUI7mebX7d/5ZaeDUVPbUYqCoqMF
         +1M0EDTsvBIgCPK+r5fXthUZvzXx8eM8qcD+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760990836; x=1761595636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qvPrU2SVrQkwkVIFxvkw04Dj387TMVRI8Nd6I2AoLU=;
        b=UF1F28qgEmDqXrDHahwj9B/D6a8KEultxQTwdbN3s/ycHpeliMgG8bzdpeAN4z9fDi
         PlV6zV/AXwJ1xs4khMOAZVEOLK6L9UZJX3hJx5NLyT0fY1L3mmT5ZgdDP43eBt2fuVeG
         NCUK3A3+lNxp1HkMkpXsqvPKa/bs3EXeo0cwqeyxbKk/8I359XtUaYspNcqmzlNrpTmd
         FZUp7txB6hSMehKDQoXQZwyJMeVhzSGQUo16wVtgMXVYv/P0kT0/OmVvRzY0cco2AC4r
         exMvErUqpzwmmw0LOXBdDoCGSftXasjQRGwMF26N1jdAMWXbDwX7rwIp4WDXdU3gRR9r
         18Jg==
X-Forwarded-Encrypted: i=1; AJvYcCV2a+dIIy+BwerMtE65BubrTYYS43vNed9MzFtnFb8XQ5nVOfeWeXTa2u6Y2deUmhMLJLgr5rqGGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDy9m3HA2WVumVPJSr+rb62gQm3o3UYt3mEfE3k3XSCtcF5/I
	Y86uJWVMszds76xri1qLiKWD3yTeUfiWPycugRFSPXLYKOb8pgDaHxf2vfyAf9nXlA==
X-Gm-Gg: ASbGnctSaF0ov3XEM4q0xCF112r2wYinx5oB6l0X4o9h5TBbECF2+fSGHWdRVXnssgY
	faJzuauT7OI/8mfM2TENOGMVJlEa8Q3bZP0VtpqyTOFtsLHlsFSDJy/Q+AJ6RFWAiLa4rwoDYtV
	xmy3oY7LY0K1Q2ZzHloRpidiYzxBG+bihYOMoQc0z8Iyu9S9wy2yo0diR1JeQ280+7vaVRGgPGT
	K3dCNW506lws6GKm/iyiUuuEgWz1Mai5FV0bHrFV3+CSM4xk5cYSTpqYYGKhIalX4382ZlJRBGs
	guJAA2ERQPog1NFbV2p0v+5VgqFbKvRLiWCRGgbt0VIphzSxMVABJR428Nis3pW/SGtq8uUwo0s
	GJLR6kp4oFFD2QBDv1XvSHChEGSR102hUcjbz1obwdQHEO6fQcm7dnF85sEI6tn5/VVt0P+slZN
	B8v9avlZHnOaNO2+rYqrPAQDgxdZ1QEuwBQKZq
X-Google-Smtp-Source: AGHT+IEWFrn4E0X2qBfQRXblCheHMI4S1GU+HtF87Gs1Gvnbk9snqqv5CsvEVEz33PzoAgCgB2vVWQ==
X-Received: by 2002:a17:90b:2882:b0:33b:d8ad:b69c with SMTP id 98e67ed59e1d1-33bd8adc731mr16702735a91.3.1760990835754;
        Mon, 20 Oct 2025 13:07:15 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:f21:3ecc:2915:f4cb])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33dfb1d9390sm136234a91.0.2025.10.20.13.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:07:15 -0700 (PDT)
Date: Mon, 20 Oct 2025 13:07:13 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
Message-ID: <aPaWcYgduGIHno3x@google.com>
References: <20251017122123.v2.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <CAJZ5v0ie0Jz6AJdZJx2jNSRcqRQOqMCF+gYdgemTs=rKwXD1_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ie0Jz6AJdZJx2jNSRcqRQOqMCF+gYdgemTs=rKwXD1_g@mail.gmail.com>

Hi,

On Sat, Oct 18, 2025 at 01:27:13PM +0200, Rafael J. Wysocki wrote:
> On Fri, Oct 17, 2025 at 9:22 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > Today, it's possible for a PCI device to be created and
> > runtime-suspended before it is fully initialized. When that happens, the
> > device will remain in D0, but the suspend process may save an
> > intermediate version of that device's state -- for example, without
> > appropriate BAR configuration. When the device later resumes, we'll
> > restore invalid PCI state and the device may not function.
> >
> > Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
> > until we've fully initialized the device.
> >
> > More details on how exactly this may occur:
> >
> > 1. PCI device is created by pci_scan_slot() or similar
> > 2. As part of pci_scan_slot(), pci_pm_init() enables runtime PM; the
> >    device starts "active" and we initially prevent (pm_runtime_forbid())
> >    suspend -- but see [*] footnote
> > 3. Underlying 'struct device' is added to the system (device_add());
> >    runtime PM can now be configured by user space
> > 4. PCI device receives BAR configuration
> >    (pci_assign_unassigned_bus_resources(), etc.)
> > 5. PCI device is added to the system in pci_bus_add_device()
> >
> > The device may potentially suspend between #3 and #4.
> >
> > [*] By default, pm_runtime_forbid() prevents suspending a device; but by
> > design, this can be overridden by user space policy via
> >
> >   echo auto > /sys/bus/pci/devices/.../power/control
> >
> > Thus, the above #3/#4 sequence is racy with user space (udev or
> > similar).
> >
> > Notably, many PCI devices are enumerated at subsys_initcall time and so
> > will not race with user space. However, there are several scenarios
> > where PCI devices are created later on, such as with hotplug or when
> > drivers (pwrctrl or controller drivers) are built as modules.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > Cc: <stable@vger.kernel.org>
> 
> Can you please add a Link: pointer to the discussion on the previous
> version of the patch?

Ha, it sounds like you want me to get flamed by Linus :) I don't even
know how "Link:" is supposed to be used any more.

But in case Bjorn wants to apply this as-is, here's a reference to v1,
where that discussion happened:

Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/

If I send a v3, I'll include that.

<soap-box while we're at it:>
I really wish this proposal didn't also get flamed out:

Subject: [Ksummit-discuss] Allowing something Change-Id (or something like it) in kernel commits
https://lore.kernel.org/all/CAD=FV=UPjPpUyFTPjF-Ogzj_6LJLE4PTxMhCoCEDmH1LXSSmpQ@mail.gmail.com/

If we did that, then no one would have to ask for series-history links,
because changes would already include such IDs so anyone could follow
them automatically.

As a compromise, I've been doing this:
https://lore.kernel.org/all/CAD=FV=VLMFxFt55oB4ERTFw3xnH4czUY5tXiqfY14NKZ8gqojA@mail.gmail.com/

i.e., my patches tend to have Message-Ids that look like
<$timestamp.$revision.$changeid@changeid>, and so you can cleanly
track this patch, including past and future versions, with:

https://lore.kernel.org/all/?q=I60a53c170a8596661883bd2b4ef475155c7aa72b%40changeid
</soap-box>

> With that
> 
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

Thanks!

Brian


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2AC191FBF
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 04:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgCYD3I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 23:29:08 -0400
Received: from mail-qv1-f73.google.com ([209.85.219.73]:38228 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYD3H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 23:29:07 -0400
Received: by mail-qv1-f73.google.com with SMTP id cg7so635968qvb.5
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2020 20:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3sG/aYSJEaUzKJMRBRAlTTV0CAiJQVdbv2pY6xIkFCE=;
        b=moskcLMdmb9Qa/7ck29Ui1zfgaCFu7+KdQFfLwZYDr7XIt65Qg5w0l00KET3ZKZrzL
         88SdQL8ZJ7DldVOGvvy/h7cqKbMJVpWzmZ4d8d7iOTPDOamziVbRFXTOZFmkn0vz7+3M
         6GgqRPbTfSjicW0d27iOuGolNFfXZhnk5DUDjRuwpQfUDDSgGbPhhB3BuTsJ6TRfOnX/
         gpZxH7epiSA4xXzM3i3hMOmoaxbtxBNvdQkdxBcfaw3pdCXZV+tk34FNrAhKiMPh2aJK
         2/8jHU/rrhszgNwkRLGxdHYb9uz4VcJUvjDTYVhgkJzX+Xdh+N/p7Uy93cGE4kHGi3F9
         oBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3sG/aYSJEaUzKJMRBRAlTTV0CAiJQVdbv2pY6xIkFCE=;
        b=hfA39ZWgXhhjg8KDjnz+Ydh7YeoXtEY+3827UrqodABSGakH1UKf3mtH2V0cqre3aZ
         B+dNRruGzM46kdYjDUp/71xo9l9HXCYYGd/w6b7b7JthFV6PF4bfCeRL6i/6CfdKxh7m
         ud/f4NeNdrqrNCSUug8gsiHvbm45BVMj1p6eEGZ2xzek6O4kRyZubaU1GfPsnobHGOVr
         Q7i8ckN2hKHgbuUFX8BeP8UUumqR3bzWIBfMi3zk9p4z2sAGxpoAxKKJtGYDgz9IWeXw
         AKNJppX0TQ5XMOV4/3+CiqN11Mc6M2Kg7J41d4eRs4EfiAvzwBdXDi3Ihsdlnfu/Bz39
         DDQg==
X-Gm-Message-State: ANhLgQ27oxxZEDNAFW3sHsUslB3sN/sj/hcQvf4uJdLe9/qOO6rgh2Bz
        xdYcwYMph1WoOenf+g/VWHyE2nrQtC9SXRg=
X-Google-Smtp-Source: ADFU+vs09YtOBVWmInTZBXTuKE9xtcY0cCNQnTouUg1jPB/q+0DY8fAzNliY2DcuM6HVHvC05zT9BCUA2MUUbzI=
X-Received: by 2002:a05:6214:a87:: with SMTP id ev7mr1341422qvb.52.1585106945949;
 Tue, 24 Mar 2020 20:29:05 -0700 (PDT)
Date:   Tue, 24 Mar 2020 20:29:01 -0700
In-Reply-To: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
Message-Id: <20200325032901.29551-1-saravanak@google.com>
Mime-Version: 1.0
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
From:   Saravana Kannan <saravanak@google.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     a.hajda@samsung.com, artem.bityutskiy@linux.intel.com,
        balbi@kernel.org, broonie@kernel.org, fntoth@gmail.com,
        grant.likely@arm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peter.ujfalusi@ti.com, rafael@kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Tue, Mar 24, 2020 at 5:38 AM Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> Consider the following scenario.
> 
> The main driver of USB OTG controller (dwc3-pci), which has the following
> functional dependencies on certain platform:
> - ULPI (tusb1210)
> - extcon (tested with extcon-intel-mrfld)
> 
> Note, that first driver, tusb1210, is available at the moment of
> dwc3-pci probing, while extcon-intel-mrfld is built as a module and
> won't appear till user space does something about it.
> 
> This is depicted by kernel configuration excerpt:
> 
>	CONFIG_PHY_TUSB1210=y
>	CONFIG_USB_DWC3=y
>	CONFIG_USB_DWC3_ULPI=y
>	CONFIG_USB_DWC3_DUAL_ROLE=y
>	CONFIG_USB_DWC3_PCI=y
>	CONFIG_EXTCON_INTEL_MRFLD=m
> 
> In the Buildroot environment the modules are probed by alphabetical ordering
> of their modaliases. The latter comes to the case when USB OTG driver will be
> probed first followed by extcon one.
> 
> So, if the platform anticipates extcon device to be appeared, in the above case
> we will get deferred probe of USB OTG, because of ordering.
> 
> Since current implementation, done by the commit 58b116bce136 ("drivercore:
> deferral race condition fix") counts the amount of triggered deferred probe,
> we never advance the situation -- the change makes it to be an infinite loop.
>

Hi Andy,

I'm trying to understand this sequence of steps. Sorry if the questions
are stupid -- I'm not very familiar with USB/PCI stuff.

> ---8<---8<---
> 
> [   22.187127] driver_deferred_probe_trigger <<< 1
> 
> ...here is the late initcall triggers deferred probe...
> 
> [   22.191725] platform dwc3.0.auto: deferred_probe_work_func in deferred list
> 
> ...dwc3.0.auto is the only device in the deferred list...

Ok, dwc3.0.auto is the only unprobed device at this point?

> 
> [   22.198727] platform dwc3.0.auto: deferred_probe_work_func 1 <<< counter 1
> 
> ...the counter before mutex is unlocked is kept the same...
> 
> [   22.205663] platform dwc3.0.auto: Retrying from deferred list
> 
> ...mutes has been unlocked, we try to re-probe the driver...
> 
> [   22.211487] bus: 'platform': driver_probe_device: matched device dwc3.0.auto with driver dwc3
> [   22.220060] bus: 'platform': really_probe: probing driver dwc3 with device dwc3.0.auto
> [   22.238735] bus: 'ulpi': driver_probe_device: matched device dwc3.0.auto.ulpi with driver tusb1210
> [   22.247743] bus: 'ulpi': really_probe: probing driver tusb1210 with device dwc3.0.auto.ulpi
> [   22.256292] driver: 'tusb1210': driver_bound: bound to device 'dwc3.0.auto.ulpi'
> [   22.263723] driver_deferred_probe_trigger <<< 2
> 
> ...the dwc3.0.auto probes ULPI, we got successful bound and bumped counter...
> 
> [   22.268304] bus: 'ulpi': really_probe: bound device dwc3.0.auto.ulpi to driver tusb1210

So where did this dwc3.0.auto.ulpi come from?
Looks like the device is created by dwc3_probe() through this call flow:
dwc3_probe() -> dwc3_core_init() -> dwc3_core_ulpi_init() ->
dwc3_ulpi_init() -> ulpi_register_interface() -> ulpi_register() 

> [   22.276697] platform dwc3.0.auto: Driver dwc3 requests probe deferral

Can you please point me to which code patch actually caused the probe
deferral?

> ...but extcon driver is still missing...
> 
> [   22.283174] platform dwc3.0.auto: Added to deferred list
> [   22.288513] platform dwc3.0.auto: driver_deferred_probe_add_trigger local counter: 1 new counter 2

I'm not fully aware of all the USB implications, but if extcon is
needed, why can't that check be done before we add and probe the ulpi
device? That'll avoid this whole "fake" probing and avoid the counter
increase. And avoid the need for this patch that's touching the code
code that's already a bit delicate.

Also, with my limited experience with all the possible drivers in the
kernel, it's weird that the ulpi device is added and probed before we
make sure the parent device (dwc3.0.auto) can actually probe
successfully.

Most of the platform device code I've seen in systems with OF (device
tree) add the child devices towards the end of the parent's probe
function.

> ...and since we had a successful probe, we got counter mismatch...
> 
> [   22.297490] driver_deferred_probe_trigger <<< 3
> [   22.302074] platform dwc3.0.auto: deferred_probe_work_func 2 <<< counter 3
> 
> ...at the end we have a new counter and loop repeats again, see 22.198727...
> 
> ---8<---8<---
> 
> Revert of the commit helps, but it is probably not helpful for the initially
> found regression. Artem Bityutskiy suggested to use counter of the successful
> probes instead. This fixes above mentioned case and shouldn't prevent driver
> to reprobe deferred ones.
> 
> Under "successful probe" we understand the state when a driver of the certain
> device is being kept bound after deferred probe trigger cycle. For instance,
> in the above mentioned case probing of tusb1210 is not successful because dwc3
> driver unbinds device dwc3.0.auto.ulpi. The atomic_dec() call is used to keep
> track of this. The amount of bindings is always great than or equal to the
> amount of unbindings as guaranteed by design of the driver binding mechanism.

The unbindings count can increase for other unrelated drivers unbinding
too. Wouldn't it? Seems a bit fragile and racy in a fashion similar to
the issue the original patch was trying to fix.

-Saravana

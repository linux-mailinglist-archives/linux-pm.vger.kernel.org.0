Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F247218DD05
	for <lists+linux-pm@lfdr.de>; Sat, 21 Mar 2020 02:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgCUBDF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 21:03:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:42111 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727046AbgCUBDE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 21:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584752583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AjQuPaCjd7Ig4gpbwFISut+nUjzFUAzjw+os+HFJBP8=;
        b=gUKXJIQaM+2nvr74Y65YzDph9UpV/V/vcf1GbZpiP4TzwUxuBsVJv/Tu5zVbOmImeIY0O3
        JG9WfQzGZLelAVOAlNG0QpEo7/iAT6wR1Dmq2ZuVeDdYsTQks4PXOk4/aDNqoItPzrrt8O
        h8UR+QE2S2nlYmjy0gFO4eHrPLgSNk4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-_RrOlKnCMlqJteFFS5ZVUw-1; Fri, 20 Mar 2020 21:03:01 -0400
X-MC-Unique: _RrOlKnCMlqJteFFS5ZVUw-1
Received: by mail-qk1-f199.google.com with SMTP id c130so6942558qke.20
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2020 18:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjQuPaCjd7Ig4gpbwFISut+nUjzFUAzjw+os+HFJBP8=;
        b=RZ2nD/S1XQKnrLD5NrykqSWcZQJPgcfDvMmdZf4rV5l12WPbiOfEJ+Lz+9mOQHfKee
         o24Fx5hbDg+LNmptWjHjD6sb1/9w19Sx1hXfZdJPewa6cS/gs/aTFyEnpkwKNgpTPhzg
         hmFCuy21EEH7Y2S0xqD0LcVSPRdntHPEjG581dYSKSKyhzwKbQbxHwru1P0zr7cPQEFT
         73uRP+Vo30SVMmuuwrndgc/X20mJO9pna6P0/ZVbKoUjvfx6AJ6DqGjCmQo/BAj2Yn2P
         y5AG3OLBljrrTLnO0S+yQenVrUlvBSkSimhDA7hALGNf+3Wt9WifP4PlXckoDz2BTfvs
         8siA==
X-Gm-Message-State: ANhLgQ0rEwIJPHCVjBf0TuQo0rGuZuBdaxFv7QfEmfBhc64gSvXfYQae
        o9lmfzeOGqi+Rv9Natrkb9IaFTCcbviZ8mul1BiQmB48r5YgFSJEzXgrMF+J86a5LwE0MeW2Vl2
        BCp84c5vR7QLXsP6IpC65Yqz+qwsI8JGfTis=
X-Received: by 2002:a37:9f42:: with SMTP id i63mr11208516qke.192.1584752581300;
        Fri, 20 Mar 2020 18:03:01 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtCh2wJtD/g8xto3BH0cPBIK4C3l4y4LBkjZ5hI622fvjzhRRZrgbDgis1CB+9R05hCeHqJZDHrFD188Ry1ESA=
X-Received: by 2002:a37:9f42:: with SMTP id i63mr11208481qke.192.1584752580926;
 Fri, 20 Mar 2020 18:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200310192627.437947-1-kherbst@redhat.com> <20200320221931.GA23783@google.com>
In-Reply-To: <20200320221931.GA23783@google.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Sat, 21 Mar 2020 02:02:22 +0100
Message-ID: <CACO55tsamLG5WE16U=psJpRWfz=7Fy5K8haGKHnhic1h0WAmqA@mail.gmail.com>
Subject: Re: [PATCH v7] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 20, 2020 at 11:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Mar 10, 2020 at 08:26:27PM +0100, Karol Herbst wrote:
> > Fixes the infamous 'runtime PM' bug many users are facing on Laptops with
> > Nvidia Pascal GPUs by skipping said PCI power state changes on the GPU.
> >
> > Depending on the used kernel there might be messages like those in demsg:
> >
> > "nouveau 0000:01:00.0: Refused to change power state, currently in D3"
> > "nouveau 0000:01:00.0: can't change power state from D3cold to D0 (config
> > space inaccessible)"
> > followed by backtraces of kernel crashes or timeouts within nouveau.
> >
> > It's still unkown why this issue exists, but this is a reliable workaround
> > and solves a very annoying issue for user having to choose between a
> > crashing kernel or higher power consumption of their Laptops.
>
> Thanks for the bugzilla link.  The bugzilla mentions lots of mailing
> list discussion.  Can you include links to some of that?
>
> IIUC this basically just turns off PCI power management for the GPU.
> Can you do that with something like the following?  I don't know
> anything about DRM, so I don't know where you could save the pm_cap,
> but I'm sure the driver could keep it somewhere.
>

Sure this would work? From a quick look over the pci code, it looks
like a of code would be skipped we really need, like the platform code
to turn off the GPU via ACPI. But I could also remember incorrectly on
how all of that worked again. I can of course try and see what the
effect of this patch would be. And would the parent bus even go into
D3hot if it knows one of its children is still at D0? Because that's
what the result of that would be as well, no? And I know that if the
bus stays in D0, that it has a negative impact on power consumption.

Anyway, I will try that out, I am just not seeing how that would help.

>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index b65ae817eabf..2ad825e8891c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -618,6 +618,23 @@ nouveau_drm_device_fini(struct drm_device *dev)
>         kfree(drm);
>  }
>
> +static void quirk_broken_nv_runpm(struct drm_device *drm_dev)
> +{
> +       struct pci_dev *pdev = drm_dev->pdev;
> +       struct pci_dev *bridge = pci_upstream_bridge(pdev);
> +
> +       if (!bridge || bridge->vendor != PCI_VENDOR_ID_INTEL)
> +               return;
> +
> +       switch (bridge->device) {
> +       case 0x1901:
> +               STASH->pm_cap = pdev->pm_cap;
> +               pdev->pm_cap = 0;
> +               NV_INFO(drm_dev, "Disabling PCI power management to avoid bug\n");
> +               break;
> +       }
> +}
> +
>  static int nouveau_drm_probe(struct pci_dev *pdev,
>                              const struct pci_device_id *pent)
>  {
> @@ -699,6 +716,7 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
>         if (ret)
>                 goto fail_drm_dev_init;
>
> +       quirk_broken_nv_runpm(drm_dev);
>         return 0;
>
>  fail_drm_dev_init:
> @@ -735,6 +753,9 @@ nouveau_drm_remove(struct pci_dev *pdev)
>  {
>         struct drm_device *dev = pci_get_drvdata(pdev);
>
> +       /* If we disabled PCI power management, restore it */
> +       if (STASH->pm_cap)
> +               pdev->pm_cap = STASH->pm_cap;
>         nouveau_drm_device_remove(dev);
>         pci_disable_device(pdev);
>  }
>


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F371AAD98
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 18:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410318AbgDOQPn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Apr 2020 12:15:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24409 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1415205AbgDOQMW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2020 12:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586967140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mv9YA2m75EYzFmUAbMrQPFP314ZNb88wltZTyC27b4E=;
        b=CH28gb59RUdIvdjKIEAp7JpKMp5tT5nyo4gQjiQbEEsLjOUeYLC2usprcOQ4LO9/viHRBf
        p9JTJ/g9BoVbQ8vqMh0PoY3umucXW5DYkCanPcuMe0kj+BOogPrwza9GECD12uFDq0hmkS
        /4Z355NVk9za8iqvepkGdYpJIwK+txA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-34K21iutP_So-cH11Vzi5Q-1; Wed, 15 Apr 2020 12:12:13 -0400
X-MC-Unique: 34K21iutP_So-cH11Vzi5Q-1
Received: by mail-qt1-f197.google.com with SMTP id g14so13772701qts.7
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2020 09:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mv9YA2m75EYzFmUAbMrQPFP314ZNb88wltZTyC27b4E=;
        b=DuAMy+2KefoCsd96css3GjQPFF3Z924wGRuwbG0RRLKza9go+1jzwNq0ZCoKowodF5
         FcCHwACVVUgJ5Z68s/ODCtpOHOKHrFfDcv409gploSjSEMk5KCvQVr7qx7xAtkSIV3l5
         NOGxb86ZMgdhWQVE9TcBPmez/nVs++AM/GfJ8DBDNNkcPlmbt4P2I9PJKkbF7/kqzq0D
         6+TTy+WBmTJzBQbe5M1CLxE4JwT+565a6W/GJqWPBtbdX9k+9BRvZ1hhXYG2Db5ck7Bi
         MCOmvIQEkdU5VX7KqE3mtXJ3TDud1EuG8j9ATQfqzOzWAzwhcxUyli8SM4EaTF2uqSim
         5jEw==
X-Gm-Message-State: AGi0PuYZSSjrcHQVm8iFGtpc0AO1VPg+aE+0d8Mcn+KVWiceYtuJJtY+
        gnrUP+QpnEFaR9Y46HJcEtCo4wa6I4zOQQR/70n/zvHDGLSECVEdcyPyf3KNAixGlN92NFijWOW
        heQI2sqPf3AbpNobpJPZaU8kEDcnA/1U6C4k=
X-Received: by 2002:a37:9b0f:: with SMTP id d15mr15707298qke.62.1586967131515;
        Wed, 15 Apr 2020 09:12:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypLoETwcvu72/DFo++b6OpDCehy7qLAHOH0i0rvrjp7Z+YqxMfS+Eb/JmjOkhPMj+ZIQVxJAZa62zL5VHxYGGyU=
X-Received: by 2002:a37:9b0f:: with SMTP id d15mr15707269qke.62.1586967131214;
 Wed, 15 Apr 2020 09:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200415113445.11881-1-sashal@kernel.org> <20200415113445.11881-84-sashal@kernel.org>
In-Reply-To: <20200415113445.11881-84-sashal@kernel.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 15 Apr 2020 18:11:10 +0200
Message-ID: <CACO55ttpvfoyt1p_5Y-Q1=+5NruF5kMoug85jE9y+jG+FW=HGw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.6 084/129] drm/nouveau: workaround runpm fail by
 disabling PCI power management on certain intel bridges
To:     Sasha Levin <sashal@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

in addition to that 028a12f5aa829 "drm/nouveau/gr/gp107,gp108:
implement workaround for HW hanging during init" should probably get
picked as well as it's fixing some runtime pm related issue on a
handful of additional GPUs. I have a laptop myself which requires both
of those patches.

Applies to 5.5 and 5..4 as well.

And both commits should probably get applied to older trees as well.
but I didn't get to it yet to see if they apply and work as expected.


On Wed, Apr 15, 2020 at 1:36 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Karol Herbst <kherbst@redhat.com>
>
> [ Upstream commit 434fdb51513bf3057ac144d152e6f2f2b509e857 ]
>
> Fixes the infamous 'runtime PM' bug many users are facing on Laptops with
> Nvidia Pascal GPUs by skipping said PCI power state changes on the GPU.
>
> Depending on the used kernel there might be messages like those in demsg:
>
> "nouveau 0000:01:00.0: Refused to change power state, currently in D3"
> "nouveau 0000:01:00.0: can't change power state from D3cold to D0 (config
> space inaccessible)"
> followed by backtraces of kernel crashes or timeouts within nouveau.
>
> It's still unkown why this issue exists, but this is a reliable workaroun=
d
> and solves a very annoying issue for user having to choose between a
> crashing kernel or higher power consumption of their Laptops.
>
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Mika Westerberg <mika.westerberg@intel.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D205623
> Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 63 +++++++++++++++++++++++++++
>  drivers/gpu/drm/nouveau/nouveau_drv.h |  2 +
>  2 files changed, 65 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index b65ae817eabf5..2d4c899e1f8b9 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -618,6 +618,64 @@ nouveau_drm_device_fini(struct drm_device *dev)
>         kfree(drm);
>  }
>
> +/*
> + * On some Intel PCIe bridge controllers doing a
> + * D0 -> D3hot -> D3cold -> D0 sequence causes Nvidia GPUs to not reappe=
ar.
> + * Skipping the intermediate D3hot step seems to make it work again. Thi=
s is
> + * probably caused by not meeting the expectation the involved AML code =
has
> + * when the GPU is put into D3hot state before invoking it.
> + *
> + * This leads to various manifestations of this issue:
> + *  - AML code execution to power on the GPU hits an infinite loop (as t=
he
> + *    code waits on device memory to change).
> + *  - kernel crashes, as all PCI reads return -1, which most code isn't =
able
> + *    to handle well enough.
> + *
> + * In all cases dmesg will contain at least one line like this:
> + * 'nouveau 0000:01:00.0: Refused to change power state, currently in D3=
'
> + * followed by a lot of nouveau timeouts.
> + *
> + * In the \_SB.PCI0.PEG0.PG00._OFF code deeper down writes bit 0x80 to t=
he not
> + * documented PCI config space register 0x248 of the Intel PCIe bridge
> + * controller (0x1901) in order to change the state of the PCIe link bet=
ween
> + * the PCIe port and the GPU. There are alternative code paths using oth=
er
> + * registers, which seem to work fine (executed pre Windows 8):
> + *  - 0xbc bit 0x20 (publicly available documentation claims 'reserved')
> + *  - 0xb0 bit 0x10 (link disable)
> + * Changing the conditions inside the firmware by poking into the releva=
nt
> + * addresses does resolve the issue, but it seemed to be ACPI private me=
mory
> + * and not any device accessible memory at all, so there is no portable =
way of
> + * changing the conditions.
> + * On a XPS 9560 that means bits [0,3] on \CPEX need to be cleared.
> + *
> + * The only systems where this behavior can be seen are hybrid graphics =
laptops
> + * with a secondary Nvidia Maxwell, Pascal or Turing GPU. It's unclear w=
hether
> + * this issue only occurs in combination with listed Intel PCIe bridge
> + * controllers and the mentioned GPUs or other devices as well.
> + *
> + * documentation on the PCIe bridge controller can be found in the
> + * "7th Generation Intel=C2=AE Processor Families for H Platforms Datash=
eet Volume 2"
> + * Section "12 PCI Express* Controller (x16) Registers"
> + */
> +
> +static void quirk_broken_nv_runpm(struct pci_dev *pdev)
> +{
> +       struct drm_device *dev =3D pci_get_drvdata(pdev);
> +       struct nouveau_drm *drm =3D nouveau_drm(dev);
> +       struct pci_dev *bridge =3D pci_upstream_bridge(pdev);
> +
> +       if (!bridge || bridge->vendor !=3D PCI_VENDOR_ID_INTEL)
> +               return;
> +
> +       switch (bridge->device) {
> +       case 0x1901:
> +               drm->old_pm_cap =3D pdev->pm_cap;
> +               pdev->pm_cap =3D 0;
> +               NV_INFO(drm, "Disabling PCI power management to avoid bug=
\n");
> +               break;
> +       }
> +}
> +
>  static int nouveau_drm_probe(struct pci_dev *pdev,
>                              const struct pci_device_id *pent)
>  {
> @@ -699,6 +757,7 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
>         if (ret)
>                 goto fail_drm_dev_init;
>
> +       quirk_broken_nv_runpm(pdev);
>         return 0;
>
>  fail_drm_dev_init:
> @@ -734,7 +793,11 @@ static void
>  nouveau_drm_remove(struct pci_dev *pdev)
>  {
>         struct drm_device *dev =3D pci_get_drvdata(pdev);
> +       struct nouveau_drm *drm =3D nouveau_drm(dev);
>
> +       /* revert our workaround */
> +       if (drm->old_pm_cap)
> +               pdev->pm_cap =3D drm->old_pm_cap;
>         nouveau_drm_device_remove(dev);
>         pci_disable_device(pdev);
>  }
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouv=
eau/nouveau_drv.h
> index c2c332fbde979..2a6519737800c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drv.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
> @@ -140,6 +140,8 @@ struct nouveau_drm {
>
>         struct list_head clients;
>
> +       u8 old_pm_cap;
> +
>         struct {
>                 struct agp_bridge_data *bridge;
>                 u32 base;
> --
> 2.20.1
>


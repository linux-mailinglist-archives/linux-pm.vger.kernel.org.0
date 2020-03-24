Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08AE8191B09
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 21:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgCXUcN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 16:32:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36466 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726560AbgCXUcM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 16:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585081930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WeNW/1jSyQlBllnF4FGDmUg0vTkuPN1FuzgBDxVwU94=;
        b=KTQhsDI4/ZCwjMbRFijcStbMV0o3iTTE8OhSPeilNH4F2jiUIBbtdkZsJmIr+sbI4oqb0Z
        y2vA1pcgrvRynL/aNj32f+1EFaNxfwKkzJ9pHvg7usLgSS0+d4m+PnT99g0fpRils83nwN
        zooT0iIScFlTob+SVIqZHH6HblBzxvY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-YHVkNlR2MFuBnrXGduAK0A-1; Tue, 24 Mar 2020 16:32:09 -0400
X-MC-Unique: YHVkNlR2MFuBnrXGduAK0A-1
Received: by mail-qv1-f69.google.com with SMTP id m11so12461128qvf.20
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2020 13:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WeNW/1jSyQlBllnF4FGDmUg0vTkuPN1FuzgBDxVwU94=;
        b=Pqkv/1oIEegFbyP6f4DAOCf7Km58fpBtJkI8niAbXGYySvwKEyySbGujjBx7HwdoS7
         OJFqY2I3gSTd2UNT1WNpqHxJonCFkPgJ7PstkDf9rV3e8apKDJLZNx2YMJHgJqiJzTe2
         j4+Z0enJcz04NDK5XUn1ffNRgt4WpZjWZT3sPRZmpOMHe+h7v7RiTwDcoKc675hbJKWA
         cnyBkJVnAGbdTzOTPNoilaQ27He/K4MI1xIB2EKjS5cvmkvw4+uAxzF9VOEHL0W3A0jI
         2s68qjcv+DVXUiQmQac1lroPk3296Q/FRC91Hi1i9VCpbnlR1DmZUZvrcLBt6aFreiga
         w6AQ==
X-Gm-Message-State: ANhLgQ3Kt3B52sP7YlGoYTyAVcTZNFdJDwP9Ein+w8UopZraQlxALl35
        3e+5ihz6e+u3S7QzWND99mFUMRMB8WdmAgUZCvxvVVzhItH/B8/1XIjkidpZl6UuFhJ/fYlIScm
        tgkP/dHpr+A+7tVN/8l7qDF5Vhxu2/tbgf1I=
X-Received: by 2002:a37:9f42:: with SMTP id i63mr28125495qke.192.1585081928634;
        Tue, 24 Mar 2020 13:32:08 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsfdnL9UBQeVx8P2NSjlfFNNYfwM/jp3vDbHvD0YHTyJ3rBeAgVu3sGOzPg4y8KY/RDCjclIi8oZiQQ9npA07I=
X-Received: by 2002:a37:9f42:: with SMTP id i63mr28125465qke.192.1585081928372;
 Tue, 24 Mar 2020 13:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200324202923.64625-1-kherbst@redhat.com>
In-Reply-To: <20200324202923.64625-1-kherbst@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 24 Mar 2020 21:31:24 +0100
Message-ID: <CACO55tv0+T7oz9bLa02Wqh2xS3ZY=5CC-bzeT2YfWn7Fi=d1Ng@mail.gmail.com>
Subject: Re: [PATCH v8] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

just noticed that the patch title should be changed..

drm/nouveau: prevent putting nvidia GPUs into lower device states on
certain intel bridges

or

drm/nouveau: workaround runpm fail by disabling PCI power management
on certain intel bridges

On Tue, Mar 24, 2020 at 9:29 PM Karol Herbst <kherbst@redhat.com> wrote:
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
> ---
> v2: convert to pci_dev quirk
>     put a proper technical explanation of the issue as a in-code comment
> v3: disable it only for certain combinations of intel and nvidia hardware
> v4: simplify quirk by setting flag on the GPU itself
> v5: restructure quirk to make it easier to add new IDs
>     fix whitespace issues
>     fix potential NULL pointer access
>     update the quirk documentation
> v6: move quirk into nouveau
> v7: fix typos and commit message
> v8: reset the pm_cap field to get rid of changes in pci core (thanks to
>     Bjorn for this idea)
>
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 63 +++++++++++++++++++++++++++
>  drivers/gpu/drm/nouveau/nouveau_drv.h |  2 +
>  2 files changed, 65 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index 2cd83849600f..b1beed40e746 100644
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
> @@ -736,7 +795,11 @@ static void
>  nouveau_drm_remove(struct pci_dev *pdev)
>  {
>         struct drm_device *dev =3D pci_get_drvdata(pdev);
> +       struct nouveau_drm *drm =3D nouveau_drm(dev);
>
> +       /* revert our workaround */
> +       if (drm->old_pm_cap)
> +               pdev->pm_cap =3D drm->old_pm_cap;
>         nouveau_drm_device_remove(dev);
>  }
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouv=
eau/nouveau_drv.h
> index 70f34cacc552..8104e3806499 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drv.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
> @@ -138,6 +138,8 @@ struct nouveau_drm {
>
>         struct list_head clients;
>
> +       u8 old_pm_cap;
> +
>         struct {
>                 struct agp_bridge_data *bridge;
>                 u32 base;
> --
> 2.25.1
>


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6421103EE4
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 16:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfKTPh3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 10:37:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30001 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727928AbfKTPh3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 10:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574264247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/C9gUt9cyA76AzLuivaEWyzrhcrqWJ0lBzJ30P+LXYs=;
        b=TBNTpuVEmuJq/kUAbBYSiQ6n6PhwYDxo5nP14QARhS0eAO/+9SKodzBKkS3kkBxoMHFUMN
        DDmmMIQoqPnq1HCM7p9I9OLTP2G/mv5XfxHieJLprqFvG3Iv+nXm/Me/ffKiEVzkaxSpuz
        y3snMdQVpjqOprYx7nlOBUZtIYvBbI4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-Fs6RdCtlNCi-hvba37II0g-1; Wed, 20 Nov 2019 10:37:26 -0500
Received: by mail-qt1-f199.google.com with SMTP id f14so109004qto.2
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 07:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BksgvfivWT5oEKOsVtU2jjsSwTJ8rcltyxFUj+I5xNY=;
        b=sP6FgmnprjLJomGSWSEY7FmKP2S2r0Zzrmu+oVdXqIVHc8aydGfC4KE9s0k803y878
         5d/ztL+iNR+YTLjeoCOqmtFD3m2glhdjprTv8E1SQPHMCVAsbbU63B1qwt4h99hp7Lko
         q2KGFkfoG2UMTCeFDcUa06ZH/yWk9auWG3F1HH71vqVJxKxHGO7/Ch01Va1Du/3KsXgT
         XcJfDTSI8DAzpXgs5ZPaGWLg7V6V11iJfCmEWcwF7zLgg1RiJ1qwdub7ueC8Eek6vgYu
         MSEOG981lZbzCvLEXQ0MDGfEgOhWI5UvWZTse/XzYj+NgGH00ywhZbM44HD9fKOdW+Oh
         Hj9w==
X-Gm-Message-State: APjAAAW/BHDdguCmZYfwgIXkVdjqjJHZ9pQxWVwhgJ54q2N/SjOGcWWW
        xjIMAMLX5SmNSkSVTbcjsbuj894Xp1aBArIlkgTPtUJi7T2kQFTwfDatQfayaDb0dNMUIfC9OjG
        1UV/QTY87dXCMPnLxd7rVrvrVxxdkr5Ss6wY=
X-Received: by 2002:a37:6811:: with SMTP id d17mr3082059qkc.102.1574264245968;
        Wed, 20 Nov 2019 07:37:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzt0K/ijAMXYP756+k75llJT5zszZ47OfQZKFovlD4ZwaMaT169d/nRHiPSAwI9CqrdON3hSsUsT8pA85i0bCE=
X-Received: by 2002:a37:6811:: with SMTP id d17mr3082027qkc.102.1574264245623;
 Wed, 20 Nov 2019 07:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20191119214955.GA223696@google.com> <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <20191120115127.GD11621@lahna.fi.intel.com>
 <CACO55tsfNOdtu5SZ-4HzO4Ji6gQtafvZ7Rm19nkPcJAgwUBFMw@mail.gmail.com>
 <CACO55tscD_96jUVts+MTAUsCt-fZx4O5kyhRKoo4mKoC84io8A@mail.gmail.com>
 <20191120120913.GE11621@lahna.fi.intel.com> <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
 <20191120151542.GH11621@lahna.fi.intel.com>
In-Reply-To: <20191120151542.GH11621@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 20 Nov 2019 16:37:14 +0100
Message-ID: <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
X-MC-Unique: Fs6RdCtlNCi-hvba37II0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 20, 2019 at 4:15 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 01:11:52PM +0100, Karol Herbst wrote:
> > On Wed, Nov 20, 2019 at 1:09 PM Mika Westerberg
> > <mika.westerberg@intel.com> wrote:
> > >
> > > On Wed, Nov 20, 2019 at 12:58:00PM +0100, Karol Herbst wrote:
> > > > overall, what I really want to know is, _why_ does it work on windo=
ws?
> > >
> > > So do I ;-)
> > >
> > > > Or what are we doing differently on Linux so that it doesn't work? =
If
> > > > anybody has any idea on how we could dig into this and figure it ou=
t
> > > > on this level, this would probably allow us to get closer to the ro=
ot
> > > > cause? no?
> > >
> > > Have you tried to use the acpi_rev_override parameter in your system =
and
> > > does it have any effect?
> > >
> > > Also did you try to trace the ACPI _ON/_OFF() methods? I think that
> > > should hopefully reveal something.
> > >
> >
> > I think I did in the past and it seemed to have worked, there is just
> > one big issue with this: it's a Dell specific workaround afaik, and
> > this issue plagues not just Dell, but we've seen it on HP and Lenovo
> > laptops as well, and I've heard about users having the same issues on
> > Asus and MSI laptops as well.
>
> Maybe it is not a workaround at all but instead it simply determines
> whether the system supports RTD3 or something like that (IIRC Windows 8
> started supporting it). Maybe Dell added check for Linux because at that
> time Linux did not support it.
>

the point is, it's not checking it by default, so by default you still
run into the windows 8 codepath.

> In case RTD3 is supported it invokes LKDS() which probably does the L2
> or L3 entry and this is for some reason does not work the same way in
> Linux than it does with Windows 8+.
>
> I don't remember if this happens only with nouveau or with the
> proprietary driver as well but looking at the nouveau runtime PM suspend
> hook (assuming I'm looking at the correct code):
>
> static int
> nouveau_pmops_runtime_suspend(struct device *dev)
> {
>         struct pci_dev *pdev =3D to_pci_dev(dev);
>         struct drm_device *drm_dev =3D pci_get_drvdata(pdev);
>         int ret;
>
>         if (!nouveau_pmops_runtime()) {
>                 pm_runtime_forbid(dev);
>                 return -EBUSY;
>         }
>
>         nouveau_switcheroo_optimus_dsm();
>         ret =3D nouveau_do_suspend(drm_dev, true);
>         pci_save_state(pdev);
>         pci_disable_device(pdev);
>         pci_ignore_hotplug(pdev);
>         pci_set_power_state(pdev, PCI_D3cold);
>         drm_dev->switch_power_state =3D DRM_SWITCH_POWER_DYNAMIC_OFF;
>         return ret;
> }
>
> Normally PCI drivers leave the PCI bus PM things to PCI core but here
> the driver does these. So I wonder if it makes any difference if we let
> the core handle all that:
>
> static int
> nouveau_pmops_runtime_suspend(struct device *dev)
> {
>         struct pci_dev *pdev =3D to_pci_dev(dev);
>         struct drm_device *drm_dev =3D pci_get_drvdata(pdev);
>         int ret;
>
>         if (!nouveau_pmops_runtime()) {
>                 pm_runtime_forbid(dev);
>                 return -EBUSY;
>         }
>
>         nouveau_switcheroo_optimus_dsm();
>         ret =3D nouveau_do_suspend(drm_dev, true);
>         pci_ignore_hotplug(pdev);
>         drm_dev->switch_power_state =3D DRM_SWITCH_POWER_DYNAMIC_OFF;
>         return ret;
> }
>
> and similar for the nouveau_pmops_runtime_resume().
>

yeah, I tried that at some point and it didn't help either. The reason
we call those from inside Nouveau is to support systems pre _PR where
nouveau invokes custom _DSM calls on its own. We could potentially
check for that though.


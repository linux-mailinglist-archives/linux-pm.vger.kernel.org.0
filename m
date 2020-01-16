Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D714A13DE66
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 16:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgAPPPF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 10:15:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56177 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgAPPPF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 10:15:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so4127170wmj.5
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 07:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dcl4UWfwgHtLs/lgK4pT0D4Mt03++vm5tf12mbGu0xs=;
        b=vStNgSmrMLGS7lullHFZJ4mszFBlfG9oRk3sJBx4adfSwy4pLS1/ZH+eGZxRuZTC3u
         mOAHizA2D3yxxFamFt2q2AtZ0uYLsEjYYlmU0W7E6FyIIKHHeG6RJj+2rOLXggaZ2S/A
         fr/d0Xcy6H3352EwsFFCMXuXFw9PG5kPq/j+YAe5TKGDyc0NtQG/1l8ML0lL3vB5RSPR
         O6/HJ827LVcDvMAaRJc+KiP46QDqCr1s3JyIs17mEF07MLG71+3gT/9WZ09AEPFrQeEV
         pcG85pYqAzyfPBnJh6L5dea/h+Mv0eTSJxYf/aYb7mAoh8RQP+6O9HnO2tqs07HJCj87
         LxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dcl4UWfwgHtLs/lgK4pT0D4Mt03++vm5tf12mbGu0xs=;
        b=FxUWLcbJ2HWtULAcStrbocZT1/mJ0zm211Mn1+xl/BM+Vo7uP57gpzITpUK/q/dwWP
         WE7kZBKnVGok+xpPO5RnCFCPqGoKhCPk5V1P1EzXTUDD+Bm3qVp9WaBkb4WVR0DrLnEj
         fIqDwlhAhjJ5BTYxburAHvFRmfWAAmXOfyxxiMbogsRk6dH4L1qStdfflJAqEXRbL2Ev
         Mkm0Eypuv901QEJhNYKASb4SUzgzTUoKFrOC8ARGwMQxiFuf+0lIkgY6ax9tyqL6p4C9
         uOG/QMm98bjvMLk4eM3j5SUh8XQRsrT3x6zBw1B6n9k9HkZvRJKnONOQKYDutZ8k0j0z
         gZDw==
X-Gm-Message-State: APjAAAWH6IXJJVEUewwHX9BE77xcJyCCqTXwxA9+jc22uidqgUeAGSFl
        s7idLFkA2TeBUNPgG5ybHeSU+AWrFUYFjwZ/ftw=
X-Google-Smtp-Source: APXvYqydd32jTkNrJfMblX4hCLRewlE2tvVwHRRjYQWceAfkd/fp+hJmsjVJhSxR+0SPsMsEfv1v+dWTcLBDSuFvu1A=
X-Received: by 2002:a7b:ca4b:: with SMTP id m11mr6734923wml.164.1579187702280;
 Thu, 16 Jan 2020 07:15:02 -0800 (PST)
MIME-Version: 1.0
References: <20191015065002.18701-1-drake@endlessm.com> <CADnq5_M4Leu0raYS6M72MqTm1+PLg9BjHCHLAYuB2-dEVP56_A@mail.gmail.com>
 <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com>
 <CADnq5_OaATVESAY9E2mtd7PoV2VjG=WLS56LCHVpieSHDTas0A@mail.gmail.com>
 <CAD8Lp46f9LR_VJ26BGfOGvj8sTjKZowkbjLNv6R4CsVMfRZQ=Q@mail.gmail.com>
 <CAD8Lp46+Te+AUQKLkLEcGf34izw=JzkU5w=CsZRf_UKJQ_k7qg@mail.gmail.com>
 <CADnq5_OObnKTP7-tBmPz75R5qXs8ubRxgfX-qkBnzqcox0TZyQ@mail.gmail.com> <CAD8Lp44FKuEsmdK+zDX_-ZYQEnqjQM-z6nnfE-CJ62mutd+scA@mail.gmail.com>
In-Reply-To: <CAD8Lp44FKuEsmdK+zDX_-ZYQEnqjQM-z6nnfE-CJ62mutd+scA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 16 Jan 2020 10:14:49 -0500
Message-ID: <CADnq5_PNGr4=MqpBeKbhxJ-gpniSCj7L0wO5_V6mjuwpKoaCAg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always reset asic when going into suspend
To:     Daniel Drake <drake@endlessm.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 15, 2020 at 2:44 AM Daniel Drake <drake@endlessm.com> wrote:
>
> On Thu, Dec 19, 2019 at 10:08 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> > I think there may be some AMD specific handling needed in
> > drivers/acpi/sleep.c.  My understanding from reading the modern
> > standby documents from MS is that each vendor needs to provide a
> > platform specific PEP driver.  I'm not sure how much of that current
> > code is Intel specific or not.
>
> I don't think there is anything Intel-specific in drivers/acpi/sleep.c.
>
> Reading more about PEP, I see that Linux supports PEP devices with
> ACPI ID INT33A1 or PNP0D80. Indeed the Intel platforms we work with
> have INT33A1 devices in their ACPI tables.
>
> This product has a \_SB.PEP ACPI device with _HID AMD0004 and _CID
> PNP0D80. Full acpidump:
> https://gist.github.com/dsd/ff3dfc0f63cdd9eba4a0fbd9e776e8be (see
> ssdt7)
>
> This PEP device responds to a _DSM with UUID argument
> "e3f32452-febc-43ce-9039-932122d37721", which is not the one
> documented at https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
>
> Nevertheless, there is some data about the GPU:
>                     Package (0x04)
>                     {
>                         One,
>                         "\\_SB.PCI0.GP17.VGA",
>                         Zero,
>                         0x03
>                     },
>
> However since this data is identical to many other devices that
> suspend and resume just fine, I wonder if it is really important.
>
> The one supported method does offer two calls which may mirror the
> Display Off/On Notifications in the above spec:
>                         Case (0x02)
>                         {
>                             \_SB.PCI0.SBRG.EC0.CSEE (0xB7)
>                             Return (Zero)
>                         }
>                         Case (0x03)
>                         {
>                             \_SB.PCI0.SBRG.EC0.CSEE (0xB8)
>                             Notify (\_SB.PCI0.SBRG.EC0.LID, 0x80) //
> Status Change
>                             Return (Zero)
>                         }
>
> but I tried executing this code after suspending amdgpu, and the
> problem still stands, amdgpu cannot wakeup correctly.
>
> There's nothing else really interesting in the PEP device as far as I can see.
>
> PEP things aside, I am still quite suspicious about the fact that
> calling amdgpu_device_suspend() then amdgpu_device_resume() on
> multiple products (not just this one) fails. It seems that this code
> flow is relying on the BIOS doing something in the S3 suspend/resume
> path in order to make the device resumable by amdgpu_device_resume(),
> which is why we have only encountered this issue for the first time on
> our first AMD platform that does not support S3 suspend.
>

It makes sense.  This is an SOC, not a collection of individual
devices.  There are more devices than power rails so the sbios (via
ACPI) has to handle the power rail.  All of the devices using that
power rail have to suspend and tell the sbios before the platform
microcontroller can turn off the power rail.  Presumably there is
something missing that prevents the microcontroller for powering down
the rail.  If the power rail is kept on, the device is never powered
off and still retains its current state.

> With that in mind, and lacking any better info, wouldn't it make sense
> for amdgpu_device_resume() to always call reset? Maybe it's not
> necessary in the S3 case, but it shouldn't harm anything. Or perhaps
> it could check if the device is alive and reset it if it's not?

It's just papering over the problem.  It would be better from a power
perspective for the driver to just not suspend and keep running like
normal.  When the driver is not suspended runtime things like clock
and power gating are active which keep the GPU power at a minimum.

>
> Alternatively do you have any other contacts within AMD that could
> help us figure out the underlying question of how to correctly suspend
> and resume these devices? Happy to ship an affected product sample
> your way.
>

I talked to our sbios team and they seem to think our S0ix
implementation works pretty differently from Intel's.  I'm not really
an expert on this area however.  We have a new team ramping on up this
for Linux however.

Alex

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B113BA71
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 08:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgAOHow (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 02:44:52 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33327 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAOHow (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 02:44:52 -0500
Received: by mail-qk1-f196.google.com with SMTP id d71so14850278qkc.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 23:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LTVIYeQ6AAaOMzE6Dr4mFcbzclaVh9FA4XP4/GSMGwo=;
        b=TAhdPkwdP+lOPnPQhyn6iJBFNZ4wBz8+zXiyysfz1KEJoDMd8LosaF14Eqgwle9Wvh
         /tYpzFKHdXMc3D+g96wMtv5pAv832YmU3YDFTIACU8Dc4qVMpbnV0cYIKkbRkzqqhkYF
         QE5ItFnyXfS0OBMjn0ypeGfDpP9kgJKcgmCcUJCsSFBeWtoG3AlLI68AminHhFwysxiP
         gHywwAvbjJfgjCBUKjLa01odKz7fc5uZUkUGDJM5tGRcN9X48V05EH1WeiTLDDooCSWj
         Bj++DInpQqRbYvRZPT4y2rxul5CzpnKF2xuAP8prwCcbXaSlUPUwU4UrIZZ96WRASX2T
         qdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTVIYeQ6AAaOMzE6Dr4mFcbzclaVh9FA4XP4/GSMGwo=;
        b=azh2lJG/8L0yYDaPddHFjk1SatTxJ1LvcfKvA6i280rXScIhkQ8cioL7zinvFlAqzy
         ZAnOqU8lOvtcNEZAZPhg1i3ykZoQyV2bMD/M4a22OhNLO5h15rgdEtpNMin5asnWB+HR
         hu1tQ4ViSm20p8+JM8SJH1eAALLRgaixKJhF9iMF/T0TDiA/IcXFKmwk89vxsrOwqqC4
         gsyiWuadvnQ/l5RmkyjJvFHITOYqozFr05bX1gvxyjWZJg7owoKACCD50FvaDLVhnLgp
         PltWl6ph3Rls67OMdEtcX8DOHR3lffy6F/kdgyOmFvPZ9FZMUxPtWkToMueXdm4QvXrJ
         PZLg==
X-Gm-Message-State: APjAAAXtbwSgquXOg5KzZn7GUjg6dYB0/y2+s3T3l+ZKWEHCJI/s+/fy
        in48jQqXxXefr8p9XZE1uc4H1rOugM6eR8V2iwSk4g==
X-Google-Smtp-Source: APXvYqwrUfbScoyVZBBbQjT7My45ZO3JYPfT0OQJZ0tiAMVJJkFQNgCiI1RYTDY1ZGHFHLvLSkzKWpV9AvEJ96llcck=
X-Received: by 2002:a37:9ec2:: with SMTP id h185mr25663168qke.14.1579074290928;
 Tue, 14 Jan 2020 23:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20191015065002.18701-1-drake@endlessm.com> <CADnq5_M4Leu0raYS6M72MqTm1+PLg9BjHCHLAYuB2-dEVP56_A@mail.gmail.com>
 <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com>
 <CADnq5_OaATVESAY9E2mtd7PoV2VjG=WLS56LCHVpieSHDTas0A@mail.gmail.com>
 <CAD8Lp46f9LR_VJ26BGfOGvj8sTjKZowkbjLNv6R4CsVMfRZQ=Q@mail.gmail.com>
 <CAD8Lp46+Te+AUQKLkLEcGf34izw=JzkU5w=CsZRf_UKJQ_k7qg@mail.gmail.com> <CADnq5_OObnKTP7-tBmPz75R5qXs8ubRxgfX-qkBnzqcox0TZyQ@mail.gmail.com>
In-Reply-To: <CADnq5_OObnKTP7-tBmPz75R5qXs8ubRxgfX-qkBnzqcox0TZyQ@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 15 Jan 2020 15:44:39 +0800
Message-ID: <CAD8Lp44FKuEsmdK+zDX_-ZYQEnqjQM-z6nnfE-CJ62mutd+scA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always reset asic when going into suspend
To:     Alex Deucher <alexdeucher@gmail.com>
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

On Thu, Dec 19, 2019 at 10:08 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> I think there may be some AMD specific handling needed in
> drivers/acpi/sleep.c.  My understanding from reading the modern
> standby documents from MS is that each vendor needs to provide a
> platform specific PEP driver.  I'm not sure how much of that current
> code is Intel specific or not.

I don't think there is anything Intel-specific in drivers/acpi/sleep.c.

Reading more about PEP, I see that Linux supports PEP devices with
ACPI ID INT33A1 or PNP0D80. Indeed the Intel platforms we work with
have INT33A1 devices in their ACPI tables.

This product has a \_SB.PEP ACPI device with _HID AMD0004 and _CID
PNP0D80. Full acpidump:
https://gist.github.com/dsd/ff3dfc0f63cdd9eba4a0fbd9e776e8be (see
ssdt7)

This PEP device responds to a _DSM with UUID argument
"e3f32452-febc-43ce-9039-932122d37721", which is not the one
documented at https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf

Nevertheless, there is some data about the GPU:
                    Package (0x04)
                    {
                        One,
                        "\\_SB.PCI0.GP17.VGA",
                        Zero,
                        0x03
                    },

However since this data is identical to many other devices that
suspend and resume just fine, I wonder if it is really important.

The one supported method does offer two calls which may mirror the
Display Off/On Notifications in the above spec:
                        Case (0x02)
                        {
                            \_SB.PCI0.SBRG.EC0.CSEE (0xB7)
                            Return (Zero)
                        }
                        Case (0x03)
                        {
                            \_SB.PCI0.SBRG.EC0.CSEE (0xB8)
                            Notify (\_SB.PCI0.SBRG.EC0.LID, 0x80) //
Status Change
                            Return (Zero)
                        }

but I tried executing this code after suspending amdgpu, and the
problem still stands, amdgpu cannot wakeup correctly.

There's nothing else really interesting in the PEP device as far as I can see.

PEP things aside, I am still quite suspicious about the fact that
calling amdgpu_device_suspend() then amdgpu_device_resume() on
multiple products (not just this one) fails. It seems that this code
flow is relying on the BIOS doing something in the S3 suspend/resume
path in order to make the device resumable by amdgpu_device_resume(),
which is why we have only encountered this issue for the first time on
our first AMD platform that does not support S3 suspend.

With that in mind, and lacking any better info, wouldn't it make sense
for amdgpu_device_resume() to always call reset? Maybe it's not
necessary in the S3 case, but it shouldn't harm anything. Or perhaps
it could check if the device is alive and reset it if it's not?

Alternatively do you have any other contacts within AMD that could
help us figure out the underlying question of how to correctly suspend
and resume these devices? Happy to ship an affected product sample
your way.

Thanks
Daniel

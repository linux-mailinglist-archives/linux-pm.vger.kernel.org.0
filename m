Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7402E7033
	for <lists+linux-pm@lfdr.de>; Tue, 29 Dec 2020 12:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgL2L5O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Dec 2020 06:57:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37169 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgL2L5N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Dec 2020 06:57:13 -0500
Received: from mail-ot1-f70.google.com ([209.85.210.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kuDc6-0004kP-Ho
        for linux-pm@vger.kernel.org; Tue, 29 Dec 2020 11:56:30 +0000
Received: by mail-ot1-f70.google.com with SMTP id q8so9538852otk.6
        for <linux-pm@vger.kernel.org>; Tue, 29 Dec 2020 03:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q74LhyOMocTQWIe3Ylg6HmsCuTC4QalH4b9SeCz/Lmw=;
        b=ezjDLm/4AzYAJlonpM2/lNuiaeipXfENwfjEn5LY+7kac330lnATSQGnMoumiT3t8P
         Fz/8fZjKC003z9iiy1mYqAXz5zxEclP/M8kaEH+ePL054QQKbxNonevcHtv8MsNiTBep
         uWHarDu08D4WRE3HL9cFUfUNjafJyzVj270XMk7CxSDFhccjVrj/OO6NN9t+SEBzoTmt
         LHdkuL/+XLNuJ2q7+7FKIndwykhlQiT751e6AOY52J7XW+JRQ9MXe6lgs65NTqNH2zHK
         5H8xExxlK4AFlJRs6629iG+6MD980Ig9P4FzgkjZzdS8vdctUZ6Xq8AxFwSSmpNHmDtN
         2k6w==
X-Gm-Message-State: AOAM532yUcQ982tS05TS5ijiyf8Jrb4I+p3MXxo3D24eHUMiT+fNQ2Wl
        ORrNRv2nx/7Ie2DGknGoxAyQji1xL2lcwR6GnvR63Qg0zZHrjPuhKQVS8RpMoznPLebZs2cr7Pc
        lw+4TfswPzqEHmhrOoBsQZk0jQUwi578bKwRVlLdPhMv/gN/cYZDL
X-Received: by 2002:a9d:7411:: with SMTP id n17mr35055821otk.262.1609242989498;
        Tue, 29 Dec 2020 03:56:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwd87AmyCfADf4gnKzotbQ9sDAN7TepdjBNdv0JiQGNi7ekW7M752Dbwu1xJRXPDL61O/Uw1lOEG3U6xYjQtTU=
X-Received: by 2002:a9d:7411:: with SMTP id n17mr35055815otk.262.1609242989230;
 Tue, 29 Dec 2020 03:56:29 -0800 (PST)
MIME-Version: 1.0
References: <79940973-b631-90f9-dbc4-9579c6000816@gmail.com>
 <20201117163817.GA1397220@bjorn-Precision-5520> <CAJZ5v0ipMJ1gCB7okpROG_yAUi5Q8LknqeH+Jpdrjbb4D_vfuQ@mail.gmail.com>
 <b7bf02fd-c1aa-f430-524e-98922041ed81@gmail.com>
In-Reply-To: <b7bf02fd-c1aa-f430-524e-98922041ed81@gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 29 Dec 2020 19:56:17 +0800
Message-ID: <CAAd53p43tMEk3b-BUUW1_rxFPo9zr3ZYqpSrLYddxBk_U=aw2g@mail.gmail.com>
Subject: Re: Time to re-enable Runtime PM per default for PCI devcies?
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Dec 26, 2020 at 11:26 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 17.11.2020 17:57, Rafael J. Wysocki wrote:
> > On Tue, Nov 17, 2020 at 5:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>
> >> [+to Rafael, author of the commit you mentioned,
> >> +cc Mika, Kai Heng, Lukas, linux-pm, linux-kernel]
> >>
> >> On Tue, Nov 17, 2020 at 04:56:09PM +0100, Heiner Kallweit wrote:
> >>> More than 10 yrs ago Runtime PM was disabled per default by bb910a7040
> >>> ("PCI/PM Runtime: Make runtime PM of PCI devices inactive by default").
> >>>
> >>> Reason given: "avoid breakage on systems where ACPI-based wake-up is
> >>> known to fail for some devices"
> >>> Unfortunately the commit message doesn't mention any affected  devices
> >>> or systems.
> >
> > Even if it did that, it wouldn't have been a full list almost for sure.
> >
> > We had received multiple problem reports related to that, most likely
> > because the ACPI PM in BIOSes at that time was tailored for
> > system-wide PM transitions only.
> >
>
> To follow up on this discussion:
> We could call pm_runtime_forbid() conditionally, e.g. with the following
> condition. This would enable runtime pm per default for all non-ACPI
> systems, and it uses the BIOS date as an indicator for a hopefully
> not that broken ACPI implementation. However I could understand the
> argument that this looks a little hacky ..
>
> if (IS_ENABLED(CONFIG_ACPI) && dmi_get_bios_year() <= 2016)

dmi_get_bios_year() may not be a good indicator. Last time I used it
caused regression, because the value changed after BIOS update.
For example, my MacBook Pro is manufactured in 2011, but
dmi_get_bios_year() returns 2018 with latest BIOS.

Kai-Heng

>
>
>
> >>> With Runtime PM disabled e.g. the PHY on network devices may remain
> >>> powered up even with no cable plugged in, affecting battery lifetime
> >>> on mobile devices. Currently we have to rely on the respective distro
> >>> or user to enable Runtime PM via sysfs (echo auto > power/control).
> >>> Some devices work around this restriction by calling pm_runtime_allow
> >>> in their probe routine, even though that's not recommended by
> >>> https://www.kernel.org/doc/Documentation/power/pci.txt
> >>>
> >>> Disabling Runtime PM per default seems to be a big hammer, a quirk
> >>> for affected devices / systems may had been better. And we still
> >>> have the option to disable Runtime PM for selected devices via sysfs.
> >>>
> >>> So, to cut a long story short: Wouldn't it be time to remove this
> >>> restriction?
> >>
> >> I don't know the history of this, but maybe Rafael or the others can
> >> shed some light on it.
> >
> > The systems that had those problems 10 years ago would still have
> > them, but I expect there to be more systems where runtime PM can be
> > enabled by default for PCI devices without issues.
> >
>

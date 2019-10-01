Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA813C3A63
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 18:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389941AbfJAQVp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 12:21:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389953AbfJAQVl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Oct 2019 12:21:41 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E89A488302
        for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2019 16:21:40 +0000 (UTC)
Received: by mail-io1-f71.google.com with SMTP id u18so39392305ioc.4
        for <linux-pm@vger.kernel.org>; Tue, 01 Oct 2019 09:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9XepyaA218QJeUBfPQdn3QeV/2Cs13v78OcqROetO0=;
        b=mtAevxTKTjrLC01YmYOxmr+1qQ1blDgsnyI4taoE+c4hKBLNlBSPjkPwrHSinrhgKM
         /AV9TzMBcMDf+H/nU0s9blZc+QQkPsgwJTJiZ7OL4ZhJsuEBcpqkeNk+sJ+bJwipB1qV
         Y3E+/a5UwrqtJr1X83gJQmE1rL7pXrV05pzW1ebI6KgS1t+hKefFyr10bSKNp6BLbyUq
         UpwUwfwChPunkqejPOHcKQzOTOEM5HpzgF/S6Ib4eohRiJnYzwpcUXO6dGwHgyauT1on
         arvkCJKL+AqO7unM6HOykZa/8Qvfp/SBggIHMIwd6oJcIFUrY7BGBvjxRh0NZRUmasRk
         cFMw==
X-Gm-Message-State: APjAAAUoYqznc0qPfHweE67YmnS6ZL8yAzzqlsaasqy2x6KiWEQq0EMg
        V9tdast4YXx0n/Ffgip08ZPUjBpS9jSAgzOJhYTH6GFgfxokDO5m/Cc4FJc90+Aj+yT1fIaWJdx
        IDIiUOn3kdgAPgIvDVfPkOAvmoRHQdlGyZhg=
X-Received: by 2002:a92:ca84:: with SMTP id t4mr27014691ilo.171.1569946900251;
        Tue, 01 Oct 2019 09:21:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwtlqLpKQEmRbFAQajrYSquBKr2bsxZFd6EKkYBXsFWdm96/QShaGDSjfsdotkX0LJVFp9IEOIgc19NwrFhxQE=
X-Received: by 2002:a92:ca84:: with SMTP id t4mr27014658ilo.171.1569946899958;
 Tue, 01 Oct 2019 09:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <CACO55tuk4SA6-xUtJ-oRePy8MPXYAp2cfmSPxwW3J5nQuX3y2g@mail.gmail.com>
 <20191001132721.GA46491@google.com>
In-Reply-To: <20191001132721.GA46491@google.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 1 Oct 2019 18:21:28 +0200
Message-ID: <CACO55tvjFPAMgz6DMGmJQ3adtJBX6yYnFRO9gVBEpMVTEBu0og@mail.gmail.com>
Subject: Re: [RFC PATCH] pci: prevent putting pcie devices into lower device
 states on certain intel bridges
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 1, 2019 at 3:27 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Sep 30, 2019 at 06:36:12PM +0200, Karol Herbst wrote:
> > On Mon, Sep 30, 2019 at 6:30 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > On Mon, Sep 30, 2019 at 06:05:14PM +0200, Karol Herbst wrote:
> > > > still happens with your patch applied. The machine simply gets shut down.
> > > >
> > > > dmesg can be found here:
> > > > https://gist.githubusercontent.com/karolherbst/40eb091c7b7b33ef993525de660f1a3b/raw/2380e31f566e93e5ba7c87ef545420965d4c492c/gistfile1.txt
> > >
> > > Looking your dmesg:
> > >
> > > Sep 30 17:24:27 kernel: nouveau 0000:01:00.0: DRM: DCB version 4.1
> > > Sep 30 17:24:27 kernel: nouveau 0000:01:00.0: DRM: MM: using COPY for buffer copies
> > > Sep 30 17:24:27 kernel: [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 1
> > >
> > > I would assume it runtime suspends here. Then it wakes up because of PCI
> > > access from userspace:
> > >
> > > Sep 30 17:24:42 kernel: pci_raw_set_power_state: 56 callbacks suppressed
> > >
> > > and for some reason it does not get resumed properly. There are also few
> > > warnings from ACPI that might be relevant:
> > >
> > > Sep 30 17:24:27 kernel: ACPI Warning: \_SB.PCI0.GFX0._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20190509/nsarguments-59)
> > > Sep 30 17:24:27 kernel: ACPI Warning: \_SB.PCI0.PEG0.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20190509/nsarguments-59)
> >
> > afaik this is the case for essentially every laptop out there.
>
> I think we should look into this a little bit.
> acpi_ns_check_argument_types() checks the argument type and prints
> this message, but AFAICT it doesn't actually fix anything or prevent
> execution of the method, so I have no idea what happens when we
> actually execute the _DSM.
>

I can assure you that this warning happens on every single laptop out
there with dual Nvidia graphics and it's essentially just a firmware
bug. And it never caused any issues on any of the older laptops (or
newest one for that matter).

> If we execute this _DSM as part of power management, and the _DSM
> doesn't work right, it would be no surprise that we have problems.
>
> Maybe we could learn something by turning on ACPI_DB_PARSE output (see
> Documentation/firmware-guide/acpi/debug.rst).
>
> You must have an acpidump already from all your investigation.  Can
> you put it somewhere, e.g., bugzilla.kernel.org, and include a URL?

Will do so later, right now I am traveling to XDC and will have more
time for that then.

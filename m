Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58BC9C2F5E
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 10:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733136AbfJAI4w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 04:56:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729841AbfJAI4w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Oct 2019 04:56:52 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0AAB14ACA7
        for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2019 08:56:52 +0000 (UTC)
Received: by mail-io1-f71.google.com with SMTP id i2so36900364ioo.10
        for <linux-pm@vger.kernel.org>; Tue, 01 Oct 2019 01:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4MCB39tSojzPSG5F8motQYTFmJxxDn1nUNabNxkafU=;
        b=oiaxI+OpABDGXSNkgPu8U0hdNwAQkkZSf3vVUnuhMgM30xoHUVUZwQV5EGvP11uTIl
         0xGq4FKzYee7pTtPHW6z4AaZOeUyb/6tVeCybvMUu2DpAOysRhN5IBqmdKZSEwgHHezg
         CP0zL5QCbQZ+ClD3BAfkkV56Jcl4kHRpFSuCVC6tjLasdtXU/2mvtNQsLmDbpJioanmN
         ZZkjbHO3KVES4n7OchHMRMH3c6pzK+DA83ODwh7gfko6BRMQI1t8BFKK0vviXPpcy8bg
         nW18/eIJk7w9g8ZNEXqE2WAL/xhFsl99Y1Cc93AVPHqFdZZAgb5JMQzqMgyEQd+tiWJs
         3V5A==
X-Gm-Message-State: APjAAAX5b9aaD0rVvtnMElkYpiDnehiMjH++1l6TSyzQ1RBcIVnLPQ+H
        SUR3Ax1Cn1pO0WKi9AqRBZEYqF6lzn+LddtgXzy7Cxnix38n401x4aZRYlO8OgX8GKg7SSIxgBy
        vddm6vlD3sfP0wZK70AfqN0J6ge1+qWcn2W4=
X-Received: by 2002:a02:3785:: with SMTP id r127mr23230735jar.40.1569920211282;
        Tue, 01 Oct 2019 01:56:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwoNzktoaUof8b0H3sFnkM9bXtOd3VgXH5Bw47BtxohVXwwNwKIPvNn8hjvUfNCqV1BTAm2hn7ua8hYHfXP2xc=
X-Received: by 2002:a02:3785:: with SMTP id r127mr23230713jar.40.1569920210929;
 Tue, 01 Oct 2019 01:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190927144421.22608-1-kherbst@redhat.com> <20190927214252.GA65801@google.com>
 <CACO55tuaY1jFXpJPeC9M4PoWEDyy547_tE8MpLaTDb+C+ffsbg@mail.gmail.com>
 <20190930080534.GS2714@lahna.fi.intel.com> <CACO55tuMo1aAA7meGtEey6J6sOS-ZA0ebZeL52i2zfkWtPqe_g@mail.gmail.com>
 <20190930092934.GT2714@lahna.fi.intel.com> <CACO55tu9M8_TWu2MxNe_NROit+d+rHJP5_Tb+t73q5vr19sd1w@mail.gmail.com>
 <20190930163001.GX2714@lahna.fi.intel.com> <CACO55tuk4SA6-xUtJ-oRePy8MPXYAp2cfmSPxwW3J5nQuX3y2g@mail.gmail.com>
 <20191001084651.GC2714@lahna.fi.intel.com>
In-Reply-To: <20191001084651.GC2714@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 1 Oct 2019 10:56:39 +0200
Message-ID: <CACO55ts9ommYbA5g4=G+f0G=v90qGM7EsurU7AL7bU=PFzQMnw@mail.gmail.com>
Subject: Re: [RFC PATCH] pci: prevent putting pcie devices into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
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

On Tue, Oct 1, 2019 at 10:47 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
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
> > >
> >
> > afaik this is the case for essentially every laptop out there.
>
> OK, so they are harmless?
>

yes

> > > This seems to be Dell XPS 9560 which I think has been around some time
> > > already so I wonder why we only see issues now. Has it ever worked for
> > > you or maybe there is a regression that causes it to happen now?
> >
> > oh, it's broken since forever, we just tried to get more information
> > from Nvidia if they know what this is all about, but we got nothing
> > useful.
> >
> > We were also hoping to find a reliable fix or workaround we could have
> > inside nouveau to fix that as I think nouveau is the only driver
> > actually hit by this issue, but nothing turned out to be reliable
> > enough.
>
> Can't you just block runtime PM from the nouveau driver until this is
> understood better? That can be done by calling pm_runtime_forbid() (or
> not calling pm_runtime_allow() in the driver). Or in case of PCI driver
> you just don't decrease the reference count when probe() ends.
>

the thing is, it does work for a lot of laptops. We could only observe
this on kaby lake and skylake ones. Even on Cannon Lakes it seems to
work just fine.

> I think that would be much better than blocking any devices behind
> Kabylake PCIe root ports from entering D3 (I don't really think the
> problem is in the root ports itself but there is something we are
> missing when the NVIDIA GPU is put into D3cold or back from there).

I highly doubt there is anything wrong with the GPU alone as we have
too many indications which tell us otherwise.

Anyway, at this point I don't know where to look further for what's
actually wrong. And apparently it works on Windows, but I don't know
why and I have no idea what Windows does on such systems to make it
work reliably.

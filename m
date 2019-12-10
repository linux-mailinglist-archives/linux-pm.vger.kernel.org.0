Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98A0119273
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 21:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLJUuS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 15:50:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22030 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726682AbfLJUuQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 15:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576011014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKUGte0LJJOC+2J/QTsxMNBL/KSTWmiIxFV3NdoEcMk=;
        b=P5rS1dedEBxFPy5AnXGUz9ogs5rnL+G8tGqNeRh8ENhrU8wqM7+JEOWXSitLFPq2r2yrwF
        4UFS4AvbtqL+Rmd/62txWgYEjsm0kVpwVZb9NxsV/grwpqgq+cyoKwoC6ievxfKo2S/NmV
        1vR+S0rUYcz6LeFlakYxRRZKuD4CbXk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-dulLqRQSNHeSy_Bh92d2mg-1; Tue, 10 Dec 2019 15:50:11 -0500
Received: by mail-qt1-f200.google.com with SMTP id e37so2852799qtk.7
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 12:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2m4Tv+vpahKKFm5uAjvOrE573uy1RkQak8WAblX7g4=;
        b=ul7hSoUTfSpF9aiTTj82i7N37cM9EdeCIK+FLB+kgT/S/TY7gPr3Xu99UKVO2L8pFa
         qCx8qKADcPesE2rECO3WATX3DA5Dwq8qP7COJycnlrn8u18xMYwHK3wiMn09X3Sjzh5d
         T3eKNPuz1g00imQy4Y3vdBgfu7PT9Xfvyui4KGf4Nrcmf38cD0+DE6MmBcWeuD1xUqay
         AcwMa1RJVIJJLO6jkAvDmhTsclrdSqWjtDmEld2JU83QKQSEJd4oSTdaE8DaWBgAZ0s0
         M+EXmO33kEMh17P7Nc4lOkovdpjy0BFJ/CTRlgH1evbKVgXoASzU00ttcIgAKxcB2EuQ
         JXBg==
X-Gm-Message-State: APjAAAUde72u60DO0RrZyNCNMNNHDa99a3X3VPONmssx+cXIWjkoaymJ
        IYhcG2nKsKHpsBligOfu4gGjg+dVTA4d0ChbOMBsM9SZKeZH6jr6b/5TQkSCwtr9YUtAtpSrJq8
        YTHEW+wGiyKF56lHvr1AtuSVpH0mMoOelKoM=
X-Received: by 2002:a0c:baad:: with SMTP id x45mr29886304qvf.230.1576011010492;
        Tue, 10 Dec 2019 12:50:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyIAonngUfW9uC+kmuZAs4RSR2w6CHMt+zmLNoDWoivMcdar5w1+a+QgsrZGu/DH2I2RocsrHyDBA/p4a7IrDU=
X-Received: by 2002:a0c:baad:: with SMTP id x45mr29886279qvf.230.1576011010089;
 Tue, 10 Dec 2019 12:50:10 -0800 (PST)
MIME-Version: 1.0
References: <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <CACO55ttXJgXG32HzYP_uJDfQ6T-d8zQaGjXK_AZD3kF0Rmft4g@mail.gmail.com>
 <CAJZ5v0ibzcLEm44udUxW2uVgaF9NapdNBF8Ag+RE++u7gi2yNA@mail.gmail.com>
 <CACO55ttBkZD9dm0Y_jT931NnzHHtDFyLz28aoo+ZG0pnLzPgbA@mail.gmail.com>
 <CAJZ5v0jbh7jz+YQcw-gC5ztmMOc4E9+KFBCy4VGRsRFxBw-gnw@mail.gmail.com>
 <e0eeddf4214f54dfac08e428dfb30cbd39f20680.camel@redhat.com>
 <20191127114856.GZ11621@lahna.fi.intel.com> <CACO55tt5SAf24vk0XrKguhh2J=WuKirDsdY7T+u7PsGFCpnFxg@mail.gmail.com>
 <e7aec10d789b322ca98f4b250923b0f14f2b8226.camel@redhat.com>
 <CACO55tu+hT1WGbBn_nxLR=A-X6YWmeuz-UztJKw0QAFQDDV_xg@mail.gmail.com>
 <CAJZ5v0hcONxiWD+jpBe62H1SZ-84iNxT+QCn8mcesB1C7SVWjw@mail.gmail.com> <CAPM=9txefUg9_EO82an3b313mZz7J7-ydTuJtWD-hOQwE4QXkQ@mail.gmail.com>
In-Reply-To: <CAPM=9txefUg9_EO82an3b313mZz7J7-ydTuJtWD-hOQwE4QXkQ@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 10 Dec 2019 21:49:58 +0100
Message-ID: <CACO55tvhSM0aATBOK05-05aOc6LeN67=US2zO2jqXKWGTpUZFw@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Dave Airlie <airlied@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>
X-MC-Unique: dulLqRQSNHeSy_Bh92d2mg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 10, 2019 at 8:58 PM Dave Airlie <airlied@gmail.com> wrote:
>
> On Mon, 9 Dec 2019 at 21:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Dec 9, 2019 at 12:17 PM Karol Herbst <kherbst@redhat.com> wrote=
:
> > >
> > > anybody any other ideas?
> >
> > Not yet, but I'm trying to collect some more information.
> >
> > > It seems that both patches don't really fix
> > > the issue and I have no idea left on my side to try out. The only
> > > thing left I could do to further investigate would be to reverse
> > > engineer the Nvidia driver as they support runpm on Turing+ GPUs now,
> > > but I've heard users having similar issues to the one Lyude told us
> > > about... and I couldn't verify that the patches help there either in =
a
> > > reliable way.
> >
> > It looks like the newer (8+) versions of Windows expect the GPU driver
> > to prepare the GPU for power removal in some specific way and the
> > latter fails if the GPU has not been prepared as expected.
> >
> > Because testing indicates that the Windows 7 path in the platform
> > firmware works, it may be worth trying to do what it does to the PCIe
> > link before invoking the _OFF method for the power resource
> > controlling the GPU power.
> >
>
> Remember the pre Win8 path required calling a DSM method to actually
> power the card down, I think by the time we reach these methods in
> those cases the card is already gone.
>
> Dave.
>

The point was that the firmware seems to do more in the legacy paths
and maybe we just have to do those things inside the driver instead
when using the new method. Also the _DSM call just wraps around the
interfaces on newer firmware anyway. The OS check is usually what
makes the difference. I might be wrong about the _DSM call just
wrapping though, but I think I saw it at least in some firmware at
some point.


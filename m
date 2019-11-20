Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 341D61039F1
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 13:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfKTMTu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 07:19:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32954 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728611AbfKTMTu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 07:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574252389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6tQSiatJZXoqislkFRtZVMOCpA4DqNNH30wH7vD5XN4=;
        b=T1+eACA6MfvU9mZQt46vsvJeaudW4Qy2me+S47YALslT/LEUZMtng6rTzzSUNltCMz3X4F
        e1WFpiYCqhLgJQhhc7UZ5YUTGYASD3K9SB0AZ2gnKdiMkkDIK1VjWqAod+f8bdrln57MwU
        DGyIBg0XdhEdJn/DayxrsE/n2ndKcwU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-DXCoCYluMlunFfjsjcCTlA-1; Wed, 20 Nov 2019 07:19:42 -0500
Received: by mail-qt1-f197.google.com with SMTP id h15so16921917qtn.6
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 04:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWs1Gk0ow9/Ugo0hlEi2MnfVfxY0H34jjDGUnWVNnGE=;
        b=t+UCkN3Z2w78719AQJy7rWftKOhz40VE4poSy0dM15hQ4x89YxkUBuaIi5tmMZxYPh
         ug/IdL7m/qjWmE9GDaPUP+zSLOlkrEPvH/axTurRqYndtPcOKqIMyle1A5XJl4r/7NOP
         ySyVXiZOwXPj5m5LhSf8vjLxG9aomjyCcRKsN7Ozjd3/wlyKbPIXvvk+yCqTD87AJRjZ
         7xMzTdBWmEHT5s92NaGMQ0R/vHDHMq67pEdmrSxmOPYYXJSct9umaJ5IyXOq5FqqHhy0
         6M9cnD6uQ87iE5ePC7wtFpM7ivkqQ1YddZwo1Xmj14cdBX0D3o13lbiTDGwjqRN3s1Sj
         RzYw==
X-Gm-Message-State: APjAAAUR3cFmuE1IYaCy6Ubu9dAdZ8Yuzl31WC17CPk0QvgyxcqxV8Sn
        nS1fUPgmHG5mjtmn3c9DELuAeoVWnIhq8/+fDs7lzCo95b2V7shAAlQ2QtvVTSROO4rUKZi5v4K
        uw24/VlNH9ZXse7EpQOFgdu7HQ84rctg04wA=
X-Received: by 2002:ae9:f511:: with SMTP id o17mr2053124qkg.157.1574252382240;
        Wed, 20 Nov 2019 04:19:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYYwY32hdZJpgO9a9F96+AV3XWlzoWfPmJ3+IXJz1kjQ4tZP3raHWzLm6tC4nakFswJXw9vp47sPBOfFGfJkw=
X-Received: by 2002:ae9:f511:: with SMTP id o17mr2053086qkg.157.1574252381985;
 Wed, 20 Nov 2019 04:19:41 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <CAJZ5v0in4VSULsfLshHxhNLf+NZxVQM0xx=hzdNa2X3FW=V7DA@mail.gmail.com>
 <CACO55tsjj+xkDjubz1J=fsPecW4H_J8AaBTeaMm+NYjp8Kiq8g@mail.gmail.com>
 <CAJZ5v0ithxMPK2YxfTUx_Ygpze2FMDJ6LwKwJb2vx89dfgHX_A@mail.gmail.com>
 <CACO55tupFbq0T1DcR+C+YxtPR=csPBQhwVXz_SHWT5F8bRK8JA@mail.gmail.com> <CAJZ5v0h_ymqsoOVm9s2h5X0ejYdM4x03H7xPQ38uiO009OVgpQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h_ymqsoOVm9s2h5X0ejYdM4x03H7xPQ38uiO009OVgpQ@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 20 Nov 2019 13:19:30 +0100
Message-ID: <CACO55tu9PqhgjCEB0psaqnh+-FEOj7Y+sB_So56iHnE2kj9Z+A@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@intel.com>,
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
X-MC-Unique: DXCoCYluMlunFfjsjcCTlA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It depends on the kernel being built with ACPI_REV_OVERRIDE_POSSIBLE=3Dy
and acpi_rev_override=3D1 being set on the kernel command line

On Wed, Nov 20, 2019 at 1:15 PM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
> On Wed, Nov 20, 2019 at 1:10 PM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > On Wed, Nov 20, 2019 at 1:06 PM Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > >
> > > On Wed, Nov 20, 2019 at 12:51 PM Karol Herbst <kherbst@redhat.com> wr=
ote:
> > > >
> > > > On Wed, Nov 20, 2019 at 12:48 PM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> > > > >
> > > > > On Wed, Nov 20, 2019 at 12:22 PM Mika Westerberg
> > > > > <mika.westerberg@intel.com> wrote:
> > > > > >
> > > > > > On Wed, Nov 20, 2019 at 11:52:22AM +0100, Rafael J. Wysocki wro=
te:
> > > > > > > On Wed, Nov 20, 2019 at 11:18 AM Mika Westerberg
> > > > > > > <mika.westerberg@intel.com> wrote:
> > > > > > > >
> > >
> > > [cut]
> > >
> > > > > > >
> > > > > > > Oh, so does it look like we are trying to work around AML tha=
t tried
> > > > > > > to work around some problematic behavior in Linux at one poin=
t?
> > > > > >
> > > > > > Yes, it looks like so if I read the ASL right.
> > > > >
> > > > > OK, so that would call for a DMI-based quirk as the real cause fo=
r the
> > > > > issue seems to be the AML in question, which means a firmware pro=
blem.
> > > > >
> > > >
> > > > And I disagree as this is a linux specific workaround and windows g=
oes
> > > > that path and succeeds. This firmware based workaround was added,
> > > > because it broke on Linux.
> > >
> > > Apparently so at the time it was added, but would it still break afte=
r
> > > the kernel changes made since then?
> > >
> > > Moreover, has it not become harmful now?  IOW, wouldn't it work after
> > > removing the "Linux workaround" from the AML?
> > >
> > > The only way to verify that I can see would be to run the system with
> > > custom ACPI tables without the "Linux workaround" in the AML in
> > > question.
> > >
> >
> > the workaround is not enabled by default, because it has to be
> > explicitly enabled by the user.
>
> I'm not sure what you are talking about.
>
> I'm taking specifically about the ((OSYS =3D=3D 0x07DF) && (_REV =3D=3D 0=
x05))
> check mentioned by Mika which doesn't seem to depend on user input in
> any way.
>


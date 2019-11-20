Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E565110391E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 12:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfKTLvh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 06:51:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39842 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728753AbfKTLvd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 06:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574250692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPxRqpnj1VRvKWjlC4bBmohXIj2CvgKB/Q/qWInRYCM=;
        b=YdoqO46yxxjHK8hmfWIqvRgBlD2JDpNWwIJbb5YE48yfNKnQKeawg2cqOtSHrl21BNOFGy
        c7Bza8NDAtuMhvlCqBxahTfcCBLkBOB853YnWevmo76zO6gJohGfFcDinoug9WqO2xOnyh
        0sFH5iWP7Z0qOZ6CxuuTRRhDfBFLjek=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-0FaE6wk-MWe4j6n7sBGrUw-1; Wed, 20 Nov 2019 06:51:30 -0500
Received: by mail-qt1-f200.google.com with SMTP id v23so16876329qth.20
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 03:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CFyc/FUMDYyl2BocV0QKj5FHf/d/2FxPovJ0RWOX7+w=;
        b=iQijhgR9DbKhahjYkE1i8Av2Px1M0YEv9DOzM3GMZyozxbPAnPAuMriytuPW64UZQr
         Ip43Iz+U8yfiZ5USR2wX+LrxoszOpDpbYPYUivpRkf0ZhFUpjcOliVl3JDzCFLWBzBjE
         m/L1wzyTa9m8ZkN7fxERFq3pS90ZRToFP3AxREjUC8wxdYlLf8iw2rifpmQwcys1VRBi
         3T06mrXd0+FjorHt0R+3DDHSuZV7MR6nen3EAgq1TnxLOaaSdRfLxoofQcem0jnmQCzP
         O7kk6XcRoETGRqQSSwp+5o9oycMkn9j59rOcK8fXOV776GjQwBWoQb0i5DLOq74OM/Ri
         GIgA==
X-Gm-Message-State: APjAAAUqJ0lnA4vZDjJb/7c+uOgsTTmx23A+sMmRSxUv0Vu7Ij4oPQWt
        gBhY73pEs88zr08Lj81z8YCWMO7mXClG9zKLLFfCVKEjhSRdCmF+o8tv0KXVt03fj1WfQfcLeWj
        fbOd/Hh0aIjDvdalAjiAhb7rcte21OtjVXaE=
X-Received: by 2002:a05:6214:14f0:: with SMTP id k16mr2065693qvw.113.1574250689374;
        Wed, 20 Nov 2019 03:51:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqxmoVHi1aepvACHCY2OtChU4LEM17did3RPg+o9gU8lcAL0EutXabIB172KzXiQD117jaDtm40U40hXQku32kA=
X-Received: by 2002:a05:6214:14f0:: with SMTP id k16mr2065670qvw.113.1574250689023;
 Wed, 20 Nov 2019 03:51:29 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <CAJZ5v0in4VSULsfLshHxhNLf+NZxVQM0xx=hzdNa2X3FW=V7DA@mail.gmail.com>
In-Reply-To: <CAJZ5v0in4VSULsfLshHxhNLf+NZxVQM0xx=hzdNa2X3FW=V7DA@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 20 Nov 2019 12:51:17 +0100
Message-ID: <CACO55tsjj+xkDjubz1J=fsPecW4H_J8AaBTeaMm+NYjp8Kiq8g@mail.gmail.com>
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
X-MC-Unique: 0FaE6wk-MWe4j6n7sBGrUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 20, 2019 at 12:48 PM Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
>
> On Wed, Nov 20, 2019 at 12:22 PM Mika Westerberg
> <mika.westerberg@intel.com> wrote:
> >
> > On Wed, Nov 20, 2019 at 11:52:22AM +0100, Rafael J. Wysocki wrote:
> > > On Wed, Nov 20, 2019 at 11:18 AM Mika Westerberg
> > > <mika.westerberg@intel.com> wrote:
> > > >
> > > > Hi Karol,
> > > >
> > > > On Tue, Nov 19, 2019 at 11:26:45PM +0100, Karol Herbst wrote:
> > > > > On Tue, Nov 19, 2019 at 10:50 PM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > > > > >
> > > > > > [+cc Dave]
> > > > > >
> > > > > > On Thu, Oct 17, 2019 at 02:19:01PM +0200, Karol Herbst wrote:
> > > > > > > Fixes state transitions of Nvidia Pascal GPUs from D3cold int=
o higher device
> > > > > > > states.
> > > > > > >
> > > > > > > v2: convert to pci_dev quirk
> > > > > > >     put a proper technical explanation of the issue as a in-c=
ode comment
> > > > > > > v3: disable it only for certain combinations of intel and nvi=
dia hardware
> > > > > > > v4: simplify quirk by setting flag on the GPU itself
> > > > > >
> > > > > > I have zero confidence that we understand the real problem, but=
 we do
> > > > > > need to do something with this.  I'll merge it for v5.5 if we g=
et the
> > > > > > minor procedural stuff below straightened out.
> > > > > >
> > > > >
> > > > > Thanks, and I agree with your statement, but at this point I thin=
k
> > > > > only Intel can help out digging deeper as I see no way to debug t=
his
> > > > > further.
> > > >
> > > > I don't have anything against this patch, as long as the quirk stay=
s
> > > > limited to the particular root port leading to the NVIDIA GPU. The
> > > > reason why I think it should to be limited is that I'm pretty certa=
in
> > > > the problem is not in the root port itself. I have here a KBL based
> > > > Thinkpad X1 Carbon 6th gen that can put the TBT controller into D3c=
old
> > > > (it is connected to PCH root port) and it wakes up there just fine,=
 so
> > > > don't want to break that.
> > > >
> > > > Now, PCIe devices cannot go into D3cold all by themselves. They alw=
ays
> > > > need help from the platform side which is ACPI in this case. This i=
s
> > > > done by having the device to have _PR3 method that returns one or m=
ore
> > > > power resources that the OS is supposed to turn off when the device=
 is
> > > > put into D3cold. All of that is implemented as form of ACPI methods=
 that
> > > > pretty much do the hardware specific things that are outside of PCI=
e
> > > > spec to get the device into D3cold. At high level the _OFF() method
> > > > causes the root port to broadcast PME_Turn_Off message that results=
 the
> > > > link to enter L2/3 ready, it then asserts PERST, configures WAKE (b=
oth
> > > > can be GPIOs) and finally removes power (if the link goes into L3,
> > > > otherwise it goes into L2).
> > > >
> > > > I think this is where the problem actually lies - the ASL methods t=
hat
> > > > are used to put the device into D3cold and back. We know that in Wi=
ndows
> > > > this all works fine so unless Windows quirks the root port the same=
 way
> > > > there is another reason behind this.
> > > >
> > > > In case of Dell XPS 9560 (IIRC that's the machine you have) the
> > > > corresponding power resource is called \_SB.PCI0.PEG0.PG00 and its
> > > > _ON/_OFF methods end up calling PGON()/PGOF() accordingly. The meth=
ods
> > > > itself do lots of things and it is hard to follow the dissassembled
> > > > ASL which does not have any comments but there are couple of things=
 that
> > > > stand out where we may go into a different path. One of them is thi=
s in
> > > > the PGOF() method:
> > > >
> > > >    If (((OSYS <=3D 0x07D9) || ((OSYS =3D=3D 0x07DF) && (_REV =3D=3D=
 0x05))))
> > > >
> > > > The ((OSYS =3D=3D 0x07DF) && (_REV =3D=3D 0x05)) checks specificall=
y for Linux
> > > > (see [1] and 18d78b64fddc ("ACPI / init: Make it possible to overri=
de
> > > > _REV")) so it might be that Dell people tested this at some point i=
n
> > > > Linux as well. Added Mario in case he has any ideas.
> > > >
> > > > Previously I suggested you to try the ACPI method tracing to see wh=
at
> > > > happens inside PGOF(). Did you have time to try it? It may provide =
more
> > > > information about that is happening inside those methods and hopefu=
lly
> > > > point us to the root cause.
> > > >
> > > > Also if you haven't tried already passing acpi_rev_override in the
> > > > command line makes the _REV to return 5 so it should go into the "L=
inux"
> > > > path in PGOF().
> > >
> > > Oh, so does it look like we are trying to work around AML that tried
> > > to work around some problematic behavior in Linux at one point?
> >
> > Yes, it looks like so if I read the ASL right.
>
> OK, so that would call for a DMI-based quirk as the real cause for the
> issue seems to be the AML in question, which means a firmware problem.
>

And I disagree as this is a linux specific workaround and windows goes
that path and succeeds. This firmware based workaround was added,
because it broke on Linux.


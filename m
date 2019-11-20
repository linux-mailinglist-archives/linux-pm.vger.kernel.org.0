Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E781510399B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 13:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfKTMKG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 07:10:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52034 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727900AbfKTMKG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 07:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574251804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=knFBJ+jIledi9b7Ia4deKRuiHotpqtnvRJzVLFu8J74=;
        b=CecSWFJeDa2330RCBeYrqMKU5Qlb17mU2xfUcHP0NdImDrsZVUiJkMjT4gfmyd8i303HPe
        furWfkp9gNlZ/Ro/7LAFGxQNu2ZRJ58WhzHQ3LnFoBbwpPnt5yEKsUPHRxYzCsNEvEzi+p
        +fDD46WQEy6IzSNj2fFMA2cFkWE5BFM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-T1v1ADisOauAYS5F5upJVg-1; Wed, 20 Nov 2019 07:10:03 -0500
Received: by mail-qt1-f200.google.com with SMTP id 6so16914107qtu.7
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 04:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7p4rYZMTKBgx0gRU2Y/8e1TMHUDBS8YuAIk55PkbbCM=;
        b=LQURchMCfKMiAAPT9TohL7ksz5EaKkA5ogATGiLRAaD6CQWTGouLGtyjcizH0KQsSn
         a+cZuM8J/l0/j0Y4atOc5VRGteNom8ibJqkwCXsqhHAms7ZDYxG+4vqW9SDjxLOGqcv1
         ncYSc9hTn7DXYmwZ1zV27GuszRCwldWMxiZ/cDl7A/8EG8ZOVCQzftshQZ9us9qzjshw
         ManFnNQ9c+abY2aPI+/rVM6T4RISBtp/ZSVYC6IpMcpg0SLzl4J7Q4He1z9eWjjKndII
         kxrti2NnF6Qt9WUqDDCeEzJp124fF7BXm8d1nDIaMZldhd59rgzyGdnvWi6ebIbUyONN
         AZGQ==
X-Gm-Message-State: APjAAAU9mB0/cj3DOFcW3mfM/zrHdJdlM0rfAvkXU3bdiLuL8AHo+X1A
        SmVp8IoHpABoD8E2PztaK7V3o1znBHsFoWNZ7FTDp3r8+7FdMpq7PhAc/OpvL5q/lLv+F9qiaIF
        wFrcWCKr3W+IabpsvfwFVxGgWD+GE6ws55z8=
X-Received: by 2002:a37:9083:: with SMTP id s125mr2035556qkd.192.1574251802834;
        Wed, 20 Nov 2019 04:10:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4S4Yg7VICuKWth27RQHwQbnKmUWBvPlof4TRp3+1St7VECDM0n728MYoDSOHL10176AueXActPrjMWKfP+xo=
X-Received: by 2002:a37:9083:: with SMTP id s125mr2035532qkd.192.1574251802589;
 Wed, 20 Nov 2019 04:10:02 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <CAJZ5v0in4VSULsfLshHxhNLf+NZxVQM0xx=hzdNa2X3FW=V7DA@mail.gmail.com>
 <CACO55tsjj+xkDjubz1J=fsPecW4H_J8AaBTeaMm+NYjp8Kiq8g@mail.gmail.com> <CAJZ5v0ithxMPK2YxfTUx_Ygpze2FMDJ6LwKwJb2vx89dfgHX_A@mail.gmail.com>
In-Reply-To: <CAJZ5v0ithxMPK2YxfTUx_Ygpze2FMDJ6LwKwJb2vx89dfgHX_A@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 20 Nov 2019 13:09:51 +0100
Message-ID: <CACO55tupFbq0T1DcR+C+YxtPR=csPBQhwVXz_SHWT5F8bRK8JA@mail.gmail.com>
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
X-MC-Unique: T1v1ADisOauAYS5F5upJVg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 20, 2019 at 1:06 PM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
> On Wed, Nov 20, 2019 at 12:51 PM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > On Wed, Nov 20, 2019 at 12:48 PM Rafael J. Wysocki <rafael@kernel.org> =
wrote:
> > >
> > > On Wed, Nov 20, 2019 at 12:22 PM Mika Westerberg
> > > <mika.westerberg@intel.com> wrote:
> > > >
> > > > On Wed, Nov 20, 2019 at 11:52:22AM +0100, Rafael J. Wysocki wrote:
> > > > > On Wed, Nov 20, 2019 at 11:18 AM Mika Westerberg
> > > > > <mika.westerberg@intel.com> wrote:
> > > > > >
>
> [cut]
>
> > > > >
> > > > > Oh, so does it look like we are trying to work around AML that tr=
ied
> > > > > to work around some problematic behavior in Linux at one point?
> > > >
> > > > Yes, it looks like so if I read the ASL right.
> > >
> > > OK, so that would call for a DMI-based quirk as the real cause for th=
e
> > > issue seems to be the AML in question, which means a firmware problem=
.
> > >
> >
> > And I disagree as this is a linux specific workaround and windows goes
> > that path and succeeds. This firmware based workaround was added,
> > because it broke on Linux.
>
> Apparently so at the time it was added, but would it still break after
> the kernel changes made since then?
>
> Moreover, has it not become harmful now?  IOW, wouldn't it work after
> removing the "Linux workaround" from the AML?
>
> The only way to verify that I can see would be to run the system with
> custom ACPI tables without the "Linux workaround" in the AML in
> question.
>

the workaround is not enabled by default, because it has to be
explicitly enabled by the user.


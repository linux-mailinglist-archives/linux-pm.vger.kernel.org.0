Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 292D2103930
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 12:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfKTLzE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 06:55:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39740 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727545AbfKTLzE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 06:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574250902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQ/suR9lwab8Vmoit+8fApDfagM+XQzhiSMoLQs89Ks=;
        b=HXUg+vcm6rcH1ATOJNc4dMA4WGTaiiTfD/PAjfJAxCa/6WFJ1fW0fV3TxkflQ8x3jElNrl
        7SURhfaMWhform2HN6hKT2ciZ2+V7/R+c6di+RgqEBLiHOCqOyjksErrf51bQyAh0Kapxp
        r9EoKUSjFLA5Q4SBCppRIRbxCvBNBpA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-yWUSjIM0Mpeu7wtX0Rm2MA-1; Wed, 20 Nov 2019 06:54:59 -0500
Received: by mail-qv1-f69.google.com with SMTP id a4so16948085qvz.20
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 03:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXFyh8kBLvmSj4EaxcIf64KvYzB8eENY53AuUwLsMY8=;
        b=DZLlsr8hbmr0mZNaEbE+A6bnb4LgXOP5q6xlLUvKuXCYJj+twkUORHCpFX88AAmFj5
         sK96bFazM+nfg8C1VGZB0uLmR5oCUleCX0kSpTvDlyrDyYe2HerdQh/UcZxKSNSNvmZ+
         T7+qyBJiDCRkhf9QxyfvpAaPXLaQnPBU0uRRwf5bd22FjAHdapXp2QzztrLjf1XTJo5K
         SyRcGpwLwQL2U4e9uL47XskDu0qyIKk8U03AFWgORlxMPfR6PrNJ1xVdIUfkd1vgC5Zv
         nMeojUzqM1jqbnNyTPUeLrmasKEs8Eq3z1z55tuhnqLCgjd53a/Hx5i1NucGok0Cdgnu
         WYCQ==
X-Gm-Message-State: APjAAAXhragGnoxEzYpzHajoPIcJejnQpMIEinerOOkFWFqpq4tl2/2N
        GK/7m7g7qfx7mRb9EFtj5fAFb/nzBVUcyEbcVxC396YslWJKLMtflYyRBAXXaxGnFWDBqDCgbtH
        v9eglYKmHveYw0m/kJ2fER6n2szfDsjNuxuY=
X-Received: by 2002:ac8:38cf:: with SMTP id g15mr2147340qtc.254.1574250899268;
        Wed, 20 Nov 2019 03:54:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxgzPbhFAy1Wx/TLioNWRRw8v7Dky3juARvT+xkh08MnU9EQEHgjj6TnBsmHsTkQgM/Z6Vs1zzOXcqygfmJowM=
X-Received: by 2002:ac8:38cf:: with SMTP id g15mr2147324qtc.254.1574250899096;
 Wed, 20 Nov 2019 03:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <20191120115127.GD11621@lahna.fi.intel.com>
In-Reply-To: <20191120115127.GD11621@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 20 Nov 2019 12:54:48 +0100
Message-ID: <CACO55tsfNOdtu5SZ-4HzO4Ji6gQtafvZ7Rm19nkPcJAgwUBFMw@mail.gmail.com>
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
X-MC-Unique: yWUSjIM0Mpeu7wtX0Rm2MA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

for newer Windows the firmware uses bit  0x80 on 0x248 (Q0L2 being the
field name) on the bridge controller to turn of the device, on other
versions it uses the "older"? 0xb0 register and the P0LD field, which
is documented, where the former is not.

On Wed, Nov 20, 2019 at 12:51 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 01:22:16PM +0200, Mika Westerberg wrote:
> >             If (((OSYS <=3D 0x07D9) || ((OSYS =3D=3D 0x07DF) && (_REV =
=3D=3D
> >                 0x05))))
> >             {
>
> The OSYS comes from this (in DSDT):
>
>                 If (_OSI ("Windows 2009"))
>                 {
>                     OSYS =3D 0x07D9
>                 }
>
>                 If (_OSI ("Windows 2012"))
>                 {
>                     OSYS =3D 0x07DC
>                 }
>
>                 If (_OSI ("Windows 2013"))
>                 {
>                     OSYS =3D 0x07DD
>                 }
>
>                 If (_OSI ("Windows 2015"))
>                 {
>                     OSYS =3D 0x07DF
>                 }
>
> So I guess this particular check tries to identify Windows 7 and older,
> and Linux.
>
> >                 If ((PIOF =3D=3D Zero))
> >                 {
> >                     P0LD =3D One
> >                     TCNT =3D Zero
> >                     While ((TCNT < LDLY))
> >                     {
> >                         If ((P0LT =3D=3D 0x08))
> >                         {
> >                             Break
> >                         }
> >
> >                         Sleep (0x10)
> >                         TCNT +=3D 0x10
> >                     }
> >
> >                     P0RM =3D One
> >                     P0AP =3D 0x03
> >                 }
> >                 ElseIf ((PIOF =3D=3D One))
> >                 {
> >                     P1LD =3D One
> >                     TCNT =3D Zero
> >                     While ((TCNT < LDLY))
> >                     {
> >                         If ((P1LT =3D=3D 0x08))
> >                         {
> >                             Break
> >                         }
> >
> >                         Sleep (0x10)
> >                         TCNT +=3D 0x10
> >                     }
> >
> >                     P1RM =3D One
> >                     P1AP =3D 0x03
> >                 }
> >                 ElseIf ((PIOF =3D=3D 0x02))
> >                 {
> >                     P2LD =3D One
> >                     TCNT =3D Zero
> >                     While ((TCNT < LDLY))
> >                     {
> >                         If ((P2LT =3D=3D 0x08))
> >                         {
> >                             Break
> >                         }
> >
> >                         Sleep (0x10)
> >                         TCNT +=3D 0x10
> >                     }
> >
> >                     P2RM =3D One
> >                     P2AP =3D 0x03
> >                 }
> >
> >                 If ((PBGE !=3D Zero))
> >                 {
> >                     If (SBDL (PIOF))
> >                     {
> >                         MBDL =3D GMXB (PIOF)
> >                         PDUB (PIOF, MBDL)
> >                     }
> >                 }
> >             }
> >             Else
> >             {
> >                 LKDS (PIOF)
> >             }
> >
> >             If ((DerefOf (SCLK [Zero]) !=3D Zero))
> >             {
> >                 PCRO (0xDC, 0x100C, DerefOf (SCLK [One]))
> >                 Sleep (0x10)
> >             }
> >
> >             GPPR (PIOF, Zero)
> >             If ((OSYS !=3D 0x07D9))
> >             {
> >                 DIWK (PIOF)
> >             }
> >
> >             \_SB.SGOV (0x01010004, Zero)
> >             Sleep (0x14)
> >             Return (Zero)
> >         }
>


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EFB44CB85
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 23:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhKJWEi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 17:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbhKJWEh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 17:04:37 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35EFC0613F5
        for <linux-pm@vger.kernel.org>; Wed, 10 Nov 2021 14:01:49 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so6054351otj.5
        for <linux-pm@vger.kernel.org>; Wed, 10 Nov 2021 14:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YUdZCO/hNfprbwtfZTPl8gI7fzwGN/mef1SZePWhdGQ=;
        b=CMeKc3cCRv5cPku84sXDxWyZtOKUSgVHaF691D2GsGw/rfrBZEWmN/+P4oYKri5W0Q
         Hom1d8v/i/X19PS31UoM6OrEr69rT8g6+QAsH/6kw/fcG2SV9e9X9V2p15W29ImmMHrF
         jwG+4wdK+6D1+HSKQCvoSOC5BG+2J1E+RSTnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YUdZCO/hNfprbwtfZTPl8gI7fzwGN/mef1SZePWhdGQ=;
        b=Qt1ycw/wqUFTM84rPsWr2TCVL65WTvacCJubdAi9DzJ3pfYTmD/86cFk3hnRYWivN2
         QIHTFmOol5Xq69vSdUohKlG6nBTqXhtv6qNdJA5rT0yIC6mxFPCxExiospBjjMo//IR8
         E/j6ad/OXZn6+H5dqyKYjW5idf90dKlUaOOYFDEPZi+Mnw3nNKhVywZmJljcviQG7Xlm
         ceAtYY2S+5So545j3tejSauEN67Zeeou3G8uL4svMtf+UjwLajfGCK2kqsk7MLKM6Vjy
         cCiza93FbXweP65gG6p3EJZipW4vIUmkMtS/f6ppdsSyCYU/MKic/SMj6sgH0w9NgU9L
         YQzA==
X-Gm-Message-State: AOAM530Vybz85Tyz3uz9I9ceiIo4VV1z0EhHNk06+G36uGZvHegNECUz
        11VXnBI9Yb0hMJTDayCfSpC7DjhEvqrPjpX5g2nS7g==
X-Google-Smtp-Source: ABdhPJy/gqROCJ6wB4jz2whMB+ZkC2aUf8dXdseelcRFvHN7Y21FZ1S2dhIxLup+gHQ3lwU3mjjJfBH6MbJl12Wy1Ks=
X-Received: by 2002:a05:6830:1690:: with SMTP id k16mr2073994otr.148.1636581708952;
 Wed, 10 Nov 2021 14:01:48 -0800 (PST)
MIME-Version: 1.0
References: <CAP145pjO9zdGgutHP=of0H+L1=nSz097zf73i7ZYm2-NWuwHhQ@mail.gmail.com>
 <20211110212647.GA1262229@bhelgaas>
In-Reply-To: <20211110212647.GA1262229@bhelgaas>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Wed, 10 Nov 2021 23:01:38 +0100
Message-ID: <CAP145phdRheFzkvcBticrmhFKDFSyW6vpK-KMw+-QLxLJn3X4g@mail.gmail.com>
Subject: Re: [PATCH] pci: Don't call resume callback for nearly bound devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

=C5=9Br., 10 lis 2021 o 22:26 Bjorn Helgaas <helgaas@kernel.org> napisa=C5=
=82(a):
>
> On Tue, Nov 09, 2021 at 01:42:29PM +0100, Robert =C5=9Awi=C4=99cki wrote:
> > Also, this might be unrelated, but the following happened around this
> > patch (ie https://github.com/torvalds/linux/commit/0c5c62ddf88c34bc83b6=
6e4ac9beb2bb0e1887d4)
> >
> > I sometimes run Win11 under qemu/kvm/vfio (gfx card), and it stopped
> > booting (even with the latest patch for pci). Another Linux distro
> > boots fine under the same qemu/kvm/vfio, but Win11 stops at the boot
> > screen.
> >
> > It worked well with 5.15.0 and a few PRs later - with the git tip it's
> > not booting - and it works well with 5.15.0-rc7
> >
> > Maybe related to pci/vfio changes, maybe not, just leaving it here for
> > track record. I'll try to debug it a bit.
>
> Hmm.  I have no idea how to debug a Win11 boot issue.  Unless there
> are clues in the dmesg log or some qemu or kvm logs (if you find any
> such logs, please put the complete logs somewhere), the only thing I
> can think to do would be bisecting it.  "git bisect" between v5.15 and
> 0c5c62ddf88c looks like about 13 steps.

I think I wouldn't worry about it just yet. It's a problem with many
possible culprits (kvm, qemu, vfio, Win11 itself). Once the pci code
is stable, I'll take another look and do some, at least basic,
debugging. Though the problem is somewhat intermittent (mostly the
system doesn't boot, but sometimes it does).

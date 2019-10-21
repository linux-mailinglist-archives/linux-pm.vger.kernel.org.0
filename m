Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B730BDECFD
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 15:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfJUNCg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 09:02:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728696AbfJUNCg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Oct 2019 09:02:36 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FDFBC057F23
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 13:02:35 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id f15so13987150qth.6
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 06:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MATzqi2DYgY3f2a3E6niPS64+EAt9PrYf2/3XZiaaBU=;
        b=iCxPJJmBznpj95VZoW/zVgGsSBbdFMpgnS7OwscmdA4E3ciFnRnOInjGPL1TJuPsmZ
         XiFhyLUTRNYeJCd+kWfvmC3r39R1NbVWQ5Xx62zCIodZnpLqe1toPutT0aGIswlIl8sV
         i9ZwQU/x5ukNsh9QTgLS9IfVK5vXaDeCcsN41q3W3PkDQQffgTKJpe1qLSubjMFo08cw
         yryDMx7j5Q9MGCMnhCrZhVHms87Ejl0BvPybubjb1NYDc/v5Wy/HekCRo4ceYkInk60i
         lnBp40jSR9PRnYZms+lHv9V9xKbL/lNyYmZcFxitRS/xttfxYvfsETqcIfZqYlMm+H2v
         kf4g==
X-Gm-Message-State: APjAAAU0Iy1jT81AHKyChzQrKxUO7POO2+8QHeTDJQRi460hAmkpLfp1
        zTyfT48Sfgsvc7+bDVIwDoQvt+sllc5U2fpCBGiGL2PeoMoL/2Y8SXfX5CWFvAuc20Kt2AqFd1Y
        qvfSA6m/mqQKI0xBqCgLdwXaigUZ3JvjJ8os=
X-Received: by 2002:a05:620a:16b9:: with SMTP id s25mr22922007qkj.102.1571662954913;
        Mon, 21 Oct 2019 06:02:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyhj+jJSrLfQkuYBSA3fMA/d8Rx0RQ7EY47UhYO+DdxvK1frDIPrR+k9EvVDJ33OZEmDSuD4GzUm4UQE4AVqWs=
X-Received: by 2002:a05:620a:16b9:: with SMTP id s25mr22921978qkj.102.1571662954620;
 Mon, 21 Oct 2019 06:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191016144449.24646-1-kherbst@redhat.com> <20191021114017.GY2819@lahna.fi.intel.com>
 <CACO55tt2iGcySugTAb1khEYpiGoq6Os3upG5fGq+0PbE2gyyeQ@mail.gmail.com> <20191021120611.GB2819@lahna.fi.intel.com>
In-Reply-To: <20191021120611.GB2819@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 21 Oct 2019 15:02:23 +0200
Message-ID: <CACO55tvYEvPHwFLDmLOQ_BCiNw7ZRA7dun9P=KdLb4bvYTtrcg@mail.gmail.com>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 21, 2019 at 2:06 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Mon, Oct 21, 2019 at 02:00:46PM +0200, Karol Herbst wrote:
> > On Mon, Oct 21, 2019 at 1:40 PM Mika Westerberg
> > <mika.westerberg@intel.com> wrote:
> > >
> > > Hi Karol,
> > >
> > > Sorry for commenting late, I just came back from vacation.
> > >
> > > On Wed, Oct 16, 2019 at 04:44:49PM +0200, Karol Herbst wrote:
> > > > Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
> > > > states.
> > > >
> > > > v2: convert to pci_dev quirk
> > > >     put a proper technical explanation of the issue as a in-code comment
> > > > v3: disable it only for certain combinations of intel and nvidia hardware
> > > >
> > > > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: Lyude Paul <lyude@redhat.com>
> > > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > > Cc: Mika Westerberg <mika.westerberg@intel.com>
> > > > Cc: linux-pci@vger.kernel.org
> > > > Cc: linux-pm@vger.kernel.org
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: nouveau@lists.freedesktop.org
> > > > ---
> > > >  drivers/pci/pci.c    | 11 ++++++++++
> > > >  drivers/pci/quirks.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
> > >
> > > I may be missing something but why you can't do this in the nouveau
> > > driver itself?
> >
> > What do you mean precisely? Move the quirk into nouveau, but keep the
> > changes to pci core?
>
> No, just block runtime PM from the device in nouveau driver.

but that's not what the patch does. It only skips the PCI PM reg
write, but still let the ACPI method be invoked to put the device into
D3cold

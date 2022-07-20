Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A990E57AF67
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jul 2022 05:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiGTDQ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jul 2022 23:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiGTDQy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2022 23:16:54 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF8C23BC4
        for <linux-pm@vger.kernel.org>; Tue, 19 Jul 2022 20:16:53 -0700 (PDT)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 49E623F122
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 03:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658287012;
        bh=paFeXSxfZpR5vBlWjwzcL4YNuGTu1IAYqxB9CFBPvfU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=huPJB3sPgS0scHdr6dNcOWRaH02mqWQ1VwWm0p8aYPAKa0M1NhYmd/fXoWDJdm21z
         W+RyVEgshYAyY1KHANCaCDUD8IEtO9IluJ5VNjqQzXY71Ptaa+tddg4AjvnInO4Z03
         VeK5j72TAGU7p/Jh27W3BdChrd85qEHECWf1dCJRPyaEO/CyFThtEXyGt1DKZkAlEO
         Gig1IySa3QK4O/CZTJ7xXJBYGgj7THplbOP7XctRxcPZjhp5J9ZpJlR1CStXvuRb2V
         +fGXXorxGBUm6JNDZluEBx/JzQcMmhmlKDo7vaZBke/gXxPK9oHtz7p0uyi+J9jMdU
         XRFYB1OK6QORA==
Received: by mail-oi1-f198.google.com with SMTP id z13-20020a056808064d00b0033a9fcb6e1cso308634oih.9
        for <linux-pm@vger.kernel.org>; Tue, 19 Jul 2022 20:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=paFeXSxfZpR5vBlWjwzcL4YNuGTu1IAYqxB9CFBPvfU=;
        b=1AasNoErhEL44OiLwLxo+TYO71RI8WPr7npoDjLqdPPgSknMB+3NlewtwLQKu9cwKs
         GqTY5P7DInWH+1wWl1R0QMTE6pZ739h0ZxRZwHLX/n3re6IKcDKPXjUm4VbNF2FIpTg4
         RBR0d+DZtXs/JAmqQIQz/gLZfKp131ZdHxv7StMD+D3cDX+L6gSlXw0tFkqb95ocOUIe
         BojVlgU5ZmHSY0xkRwAOHi6fzjm6IIH1Z4MMB9VDHC74jWC7+RO2vuQ4ON9sr+LlMy8D
         md9nCP9veIGgeQlhSDAVQauHeeTotNoShh4qzZYPg3wrutmdWQImmYRqmZOlR306SBCK
         AOwQ==
X-Gm-Message-State: AJIora+FbS91KOnX3puuI2L+vbb5fW1wVGO7SvuQ6icpE3NPljCP8YK/
        d5Mw9ZlukS2XEmk5G+XWERXJn+oObkCefAoYN1tQY+us1KQH23ZZtlkIgF3tWP0hvpNN8cKDsMp
        M3Og0WV0zSTU0DD9FNIMxuhUEF9NyA7LXJKpJ/WoavT0WERl/2lt5
X-Received: by 2002:a05:6808:1a0b:b0:33a:72c6:c96e with SMTP id bk11-20020a0568081a0b00b0033a72c6c96emr1315785oib.176.1658287011244;
        Tue, 19 Jul 2022 20:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tMhSMUnL+8kjOwtkjzOrj/uKQHdrC8FqRwmgbU+d/xhypyG6ugaYK5QXlbu3NRB0hAxoKiJwSLfUkE195lvKM=
X-Received: by 2002:a05:6808:1a0b:b0:33a:72c6:c96e with SMTP id
 bk11-20020a0568081a0b00b0033a72c6c96emr1315778oib.176.1658287010926; Tue, 19
 Jul 2022 20:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAFv23QmH4ooXJzX9A0CBObrETZgb9sT4dfh03NZA--fKfZnHDA@mail.gmail.com>
 <87fsixz8cb.wl-maz@kernel.org> <CAFv23Q=O29J4K_bdTi_SuThsEZN_SFNNz+bBPQSA+RGCANm6=w@mail.gmail.com>
In-Reply-To: <CAFv23Q=O29J4K_bdTi_SuThsEZN_SFNNz+bBPQSA+RGCANm6=w@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 20 Jul 2022 11:16:39 +0800
Message-ID: <CAAd53p7GGjqpo97VP=uXnJQstKzxCf9Si+ZCD98UsbdJ7oS=SA@mail.gmail.com>
Subject: Re: There are not enough CPU0 APIC IRQs while doing IRQ migration
 during S3
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[+Cc Rafael, linux-pm]

On Wed, Jul 20, 2022 at 10:53 AM AceLan Kao <acelan.kao@canonical.com> wrot=
e:
>
> Marc Zyngier <maz@kernel.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=8819=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:48=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > [- Jason]
> >
> > On Tue, 19 Jul 2022 06:55:21 +0100,
> > AceLan Kao <acelan.kao@canonical.com> wrote:
> > >
> > > HI all,
> > >
> > > I encountered an issue while doing S3, it shows below message and the=
n
> > > failed to enter S3
> > > [  106.731140] CPU 31 has 116 vectors, 85 available. Cannot disable C=
PU
> > > [  106.731551] ACPI: \_PR_.C01F: Found 2 idle states
> > > [  106.732610] Error taking CPU31 down: -28
> > > [  106.732612] Non-boot CPUs are not disabled
> > >
> > > CPU: AMD Ryzen Threadripper PRO 3955WX 16-Cores
> > > Kernel: v5.19-rc7
> > > There are 5 PCI to 4 type-c ports USB cards on the machine, and It
> > > wouldn't lead to the issue if only 4 cards are plugged. So, it looks
> > > like it can't handle 5 cards, and failed on the IRQ migration.
> > >
> > > The workaround provided by kaiheng is to release the irq while
> > > suspending and request irq while resuming.
> > > I'm wondering do we have a better solution for this kind of issue?
> > > Thanks.
> > >
> > > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > > index edc6881c8a1b..91c79b21cb57 100644
> > > --- a/drivers/usb/host/xhci.c
> > > +++ b/drivers/usb/host/xhci.c
> > > @@ -17,6 +17,7 @@
> > > #include <linux/slab.h>
> > > #include <linux/dmi.h>
> > > #include <linux/dma-mapping.h>
> > > +#include <linux/suspend.h>
> > >
> > > #include "xhci.h"
> > > #include "xhci-trace.h"
> > > @@ -1079,6 +1080,9 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do=
_wakeup)
> > >                                __func__);
> > >        }
> > >
> > > +       if (pm_suspend_via_firmware())
> > > +               xhci_cleanup_msix(xhci);
> >
> > I'm a bit clueless when it comes to the combination of x86 and xhci,
> > but doesn't this prevent resuming on a xhci interrupt?
> The PCI cards provide 4 type-c USB ports, and in the beginning we
> found that removing one PCI card fixed the issue, so we were trying to
> fix the issue in xhci driver.
> The USB ports on the PCI cards can't resume the system from S3 even
> without the workaround,
> but the USB ports on the rear panel of the motherboard still work with
> the workaround.

The isn't xHCI specific. The issue here is that CPU0 APIC doesn't have
enough IRQ vector for ACPI S3 suspend.
Ideally we don't want to tear down IRQs during suspend, but for this
case minimizing IRQ numbers means successful S3.

So maybe we can have a suspend flow like this:
- At the beginning of suspend, check if there's enough free IRQ for
CPU0 migration.
- If there isn't enough free slots, hint drivers to tear down non-wake
IRQs. Maybe use a global variable if we don't want to add a new
parameter to current PM ops.
- If it's still not enough, abort suspend.

For suspend that doesn't unplug CPU like suspend-to-idle, no
modification is needed.
I wonder if that makes sense?

Kai-Heng

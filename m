Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA7657C281
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jul 2022 05:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiGUDCj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jul 2022 23:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiGUDCg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jul 2022 23:02:36 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C7C7696A
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 20:02:30 -0700 (PDT)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 546093F043
        for <linux-pm@vger.kernel.org>; Thu, 21 Jul 2022 03:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658372541;
        bh=0atytsOqBYsPZeIFCP+cOgvnl8LNyBoUzZ4fo1jZ6I4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=MXXLjOy4U+zlXFDwzS1NZ5qNAwMj074bW8fxSr/jJnIEkKc1/1i5KGKDPib80JLEU
         5/NoJW6V5ZDsTEFVGNPIty1yyqfadbF1jQIciV4rnNdPZ0SB8BjyLdUA3XuGP36W7V
         PzWfDUv+h1bHxfvyHXRfa/L3OrZ1PFcdJDMvXJRyGqOWiZlyLFDf2a0aAaOA545msT
         L8Giqc4yuEFaG3wsbCN+YNsppVaFv/yxhLlaJC3X8ShDdZVDMrkoKS197bI4bDpBH0
         ZhzNZRIwy3YZ3lj3JbgxPnziKhryDVK69EQ1KUNIRI+fkkRNDk1EjuTznTngiKYJoD
         UVFOzElI/LlyQ==
Received: by mail-ot1-f71.google.com with SMTP id a13-20020a05683012cd00b0061c9b55da16so176119otq.9
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 20:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0atytsOqBYsPZeIFCP+cOgvnl8LNyBoUzZ4fo1jZ6I4=;
        b=LG6XiLWd34hzlR8MnKtTbhF7Cy6tuo/brGgo+cpnrz+A2k5mNYHBPeSDj7GqlAHy/z
         lh60Srvr5AxiYACXnZ7UIntU/fg1wGVmbA6lQaB4VwhFvPvgopCYAHidNrAXfcaQvcJk
         2aJvP6gO+aNP7ewFxKIgPfWaFb4o1zIfghNlTFf9sa67eQyJDkLPEyN1DlCbODrQtZRy
         vqkmNRbCYIVBYOFx8/BQyoHRZ8QV/OYqmbNBZBfPwqAOHf8dAHgZ+aKW9jX6T3mpBDW3
         l3YHHMhKUGyC+Yn9f425j/p6KJT10viswrSGFRfTfpC3cZZmjpWW9S2hOMgWjkBb6Bpt
         OPZQ==
X-Gm-Message-State: AJIora+PSaQGZEEH10v4OyxZWXXyRgE6/NxhiAiTFSnH/nj+tr1CGLjA
        DTyCZi6bYxWzW0Xi0pC+zPxSx2HFxMIFm9/C+hFpCghrVNhGMCuXACi7gYqGc/AEL5iSJuQVMsb
        77mBaWAehI3thOx75UBeuyR7GL/tQNmgY5QIC6bels4OJaU7EU8vE
X-Received: by 2002:a05:6808:1643:b0:335:19ba:b696 with SMTP id az3-20020a056808164300b0033519bab696mr3639479oib.42.1658372540085;
        Wed, 20 Jul 2022 20:02:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ssAXO0JE30Sj1aAIg3WdaA1Ce9yOOeAx6t3AT9yO4I712e2qohy2QYU//pfnPnpo6etmvFFCoUtrsCzl9svRg=
X-Received: by 2002:a05:6808:1643:b0:335:19ba:b696 with SMTP id
 az3-20020a056808164300b0033519bab696mr3639461oib.42.1658372539773; Wed, 20
 Jul 2022 20:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAFv23QmH4ooXJzX9A0CBObrETZgb9sT4dfh03NZA--fKfZnHDA@mail.gmail.com>
 <87fsixz8cb.wl-maz@kernel.org> <CAFv23Q=O29J4K_bdTi_SuThsEZN_SFNNz+bBPQSA+RGCANm6=w@mail.gmail.com>
 <CAAd53p7GGjqpo97VP=uXnJQstKzxCf9Si+ZCD98UsbdJ7oS=SA@mail.gmail.com> <CAJZ5v0jYJxk1B1XORLQkGf=R9HDPbUzAjb3_2GUM0XtfmyXfZA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jYJxk1B1XORLQkGf=R9HDPbUzAjb3_2GUM0XtfmyXfZA@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 21 Jul 2022 11:02:07 +0800
Message-ID: <CAAd53p77SiW+uuZM9FAXiPooC-CN7BxVwj1LPJjEfbZZb_q14g@mail.gmail.com>
Subject: Re: There are not enough CPU0 APIC IRQs while doing IRQ migration
 during S3
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
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

On Wed, Jul 20, 2022 at 6:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
> On Wed, Jul 20, 2022 at 5:16 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > [+Cc Rafael, linux-pm]
> >
> > On Wed, Jul 20, 2022 at 10:53 AM AceLan Kao <acelan.kao@canonical.com> =
wrote:
> > >
> > > Marc Zyngier <maz@kernel.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:48=E5=AF=AB=E9=81=93=EF=BC=9A
> > > >
> > > > [- Jason]
> > > >
> > > > On Tue, 19 Jul 2022 06:55:21 +0100,
> > > > AceLan Kao <acelan.kao@canonical.com> wrote:
> > > > >
> > > > > HI all,
> > > > >
> > > > > I encountered an issue while doing S3, it shows below message and=
 then
> > > > > failed to enter S3
> > > > > [  106.731140] CPU 31 has 116 vectors, 85 available. Cannot disab=
le CPU
> > > > > [  106.731551] ACPI: \_PR_.C01F: Found 2 idle states
> > > > > [  106.732610] Error taking CPU31 down: -28
> > > > > [  106.732612] Non-boot CPUs are not disabled
> > > > >
> > > > > CPU: AMD Ryzen Threadripper PRO 3955WX 16-Cores
> > > > > Kernel: v5.19-rc7
> > > > > There are 5 PCI to 4 type-c ports USB cards on the machine, and I=
t
> > > > > wouldn't lead to the issue if only 4 cards are plugged. So, it lo=
oks
> > > > > like it can't handle 5 cards, and failed on the IRQ migration.
> > > > >
> > > > > The workaround provided by kaiheng is to release the irq while
> > > > > suspending and request irq while resuming.
> > > > > I'm wondering do we have a better solution for this kind of issue=
?
> > > > > Thanks.
> > > > >
> > > > > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > > > > index edc6881c8a1b..91c79b21cb57 100644
> > > > > --- a/drivers/usb/host/xhci.c
> > > > > +++ b/drivers/usb/host/xhci.c
> > > > > @@ -17,6 +17,7 @@
> > > > > #include <linux/slab.h>
> > > > > #include <linux/dmi.h>
> > > > > #include <linux/dma-mapping.h>
> > > > > +#include <linux/suspend.h>
> > > > >
> > > > > #include "xhci.h"
> > > > > #include "xhci-trace.h"
> > > > > @@ -1079,6 +1080,9 @@ int xhci_suspend(struct xhci_hcd *xhci, boo=
l do_wakeup)
> > > > >                                __func__);
> > > > >        }
> > > > >
> > > > > +       if (pm_suspend_via_firmware())
> > > > > +               xhci_cleanup_msix(xhci);
> > > >
> > > > I'm a bit clueless when it comes to the combination of x86 and xhci=
,
> > > > but doesn't this prevent resuming on a xhci interrupt?
> > > The PCI cards provide 4 type-c USB ports, and in the beginning we
> > > found that removing one PCI card fixed the issue, so we were trying t=
o
> > > fix the issue in xhci driver.
> > > The USB ports on the PCI cards can't resume the system from S3 even
> > > without the workaround,
> > > but the USB ports on the rear panel of the motherboard still work wit=
h
> > > the workaround.
> >
> > The isn't xHCI specific. The issue here is that CPU0 APIC doesn't have
> > enough IRQ vector for ACPI S3 suspend.
> > Ideally we don't want to tear down IRQs during suspend, but for this
> > case minimizing IRQ numbers means successful S3.
> >
> > So maybe we can have a suspend flow like this:
> > - At the beginning of suspend, check if there's enough free IRQ for
> > CPU0 migration.
> > - If there isn't enough free slots, hint drivers to tear down non-wake
> > IRQs. Maybe use a global variable if we don't want to add a new
> > parameter to current PM ops.
> > - If it's still not enough, abort suspend.
> >
> > For suspend that doesn't unplug CPU like suspend-to-idle, no
> > modification is needed.
> > I wonder if that makes sense?
>
> Quite probably, IRQs need not be migrated during system suspend, so it
> should be possible to avoid doing that entirely on "hot remove" if it
> is part of the suspend flow.

So is it required to disable all CPUs except CPU0 for ACPI S3?
ACPI spec rev 6.3, "7.4.2.4 System \_S3 State" says "The processors
are not executing instructions. The processor-complex context is not
maintained." it doesn't say the CPUs have to be disabled.
So as long as CPUs are quiesced, is pm_sleep_disable_secondary_cpus()
still needed for S3?

Kai-Heng

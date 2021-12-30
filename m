Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4374817FC
	for <lists+linux-pm@lfdr.de>; Thu, 30 Dec 2021 02:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhL3BAp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Dec 2021 20:00:45 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46046
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233647AbhL3BAo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Dec 2021 20:00:44 -0500
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B5FCE3F1AA
        for <linux-pm@vger.kernel.org>; Thu, 30 Dec 2021 01:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640826043;
        bh=uoZ4j3DJAFFGqNYQHJEg8ZOm+0DP9sQ76r9xPfmb/n8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Q5vXY2rnWzmN4UhpmM4EvxkVIOtSAoQ0dKUvuQMz9++z0TDlqA4NHm0nh05GlQgbN
         XXKwbYY/5H71KqCeVsSiOrVrZo5+3F38WAHTyp6tAV0uBSQTmZ+yaUAyH5H2idWauJ
         f1sW3+FfKYKv6PUbUE+grZjikHNj0iduAQOU9vxaKvz37jvfvbx4kKldDXkIJEIn1S
         q1tOCZdYxW1FnpI85IkL+AsPuy1DmCbcarHFy5bob2zEAYYlUvjfyF49hdhjdwh8+O
         LweK+j0wIOX9BCNOXzWeihRtISckoUEheJ977GU8wrH7wd8X7goqM04PcJjL7fvhxM
         5lxjngHiXLG8g==
Received: by mail-ot1-f70.google.com with SMTP id l13-20020a0568302b0d00b00570d0da96a5so7114601otv.16
        for <linux-pm@vger.kernel.org>; Wed, 29 Dec 2021 17:00:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uoZ4j3DJAFFGqNYQHJEg8ZOm+0DP9sQ76r9xPfmb/n8=;
        b=DIGAM3FhY36pjULU8WqE0P65oMi89D7pi9WjMwA+U9JbVX+JHCARJc+jZcWmh5PB9r
         xGsHNbXyr0/HhUK7QLZ4hg73hRmv+qrRfYuWPwa7JQBbObF1yOFBYMmR8Uh1Q/PCFeiC
         Chl7iWcz0GB+1Rj51yn9aZ0DDuDaVEZuKyCp4I509itu1sQdov6wieItsxLbzvlN1lLr
         5EV/8+H65xnAHeKM7kwxdm3qfd0eacJ2vGK/Eb0llKBZigGJRy7f9bIpS0KSI78IcJ5H
         Z15PjAMGO3WD48Zj3p+w2SESG9vOqV35o7xnVfMrQh3dW8Ez9215itMhBlKpY6IzbjWj
         WzPA==
X-Gm-Message-State: AOAM531vTphgSh/gOAcq7eA9tK8TQxHyk601gSpxstl91pS0jrkkLvUv
        TF7bLMTd9wStVztv0LIagpYe9akYS/Mnkmv7ARAGdVWKTkzPPYWRttKw9+iwJW7IUQTjQIB4tZO
        rtfpwfNOr60JjGe6En6N69r4DwXWD68/DGju6Oqx7QtIiKlIX3R4e
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr20131506ota.11.1640826042556;
        Wed, 29 Dec 2021 17:00:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAdp50c/5EObs0tj1fNIcnnRPPx3ss2Ad4obTPVF8kRFOvNAW6kNtQ60X8aCLALrxPfVtjUBNOOVyzgjPgjoE=
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr20131496ota.11.1640826042302;
 Wed, 29 Dec 2021 17:00:42 -0800 (PST)
MIME-Version: 1.0
References: <20211224081914.345292-2-kai.heng.feng@canonical.com> <20211229201814.GA1699315@bhelgaas>
In-Reply-To: <20211229201814.GA1699315@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 30 Dec 2021 09:00:30 +0800
Message-ID: <CAAd53p74bHYmQJzKuriDrRWpJwXivfYCfNCsUjC47d1WKUZ=gQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: wwan: iosm: Keep device at D0 for s2idle case
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     m.chetan.kumar@intel.com, linuxwwan@intel.com,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 30, 2021 at 4:18 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rafael, Vaibhav]
>
> On Fri, Dec 24, 2021 at 04:19:14PM +0800, Kai-Heng Feng wrote:
> > We are seeing spurious wakeup caused by Intel 7560 WWAN on AMD laptops.
> > This prevent those laptops to stay in s2idle state.
> >
> > From what I can understand, the intention of ipc_pcie_suspend() is to
> > put the device to D3cold, and ipc_pcie_suspend_s2idle() is to keep the
> > device at D0. However, the device can still be put to D3hot/D3cold by
> > PCI core.
> >
> > So explicitly let PCI core know this device should stay at D0, to solve
> > the spurious wakeup.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/net/wwan/iosm/iosm_ipc_pcie.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> > index d73894e2a84ed..af1d0e837fe99 100644
> > --- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> > +++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> > @@ -340,6 +340,9 @@ static int __maybe_unused ipc_pcie_suspend_s2idle(struct iosm_pcie *ipc_pcie)
> >
> >       ipc_imem_pm_s2idle_sleep(ipc_pcie->imem, true);
> >
> > +     /* Let PCI core know this device should stay at D0 */
> > +     pci_save_state(ipc_pcie->pci);
>
> This is a weird and non-obvious way to say "this device should stay at
> D0".  It's also fairly expensive since pci_save_state() does a lot of
> slow PCI config reads.

Yes, so I was waiting for feedback from IOSM devs what's the expected
PCI state for the s2idle case.

Dave, can you drop it from netdev until IOSM devs confirm this patch is correct?

Kai-Heng

>
> >       return 0;
> >  }
> >
> > --
> > 2.33.1
> >

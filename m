Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2819B220313
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 05:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgGODtg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 23:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgGODtg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 23:49:36 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76AFC061794
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 20:49:35 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y2so799634ioy.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 20:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f1CRBSIEJDuFB8dog5jdvBQmdtw3EAxf2Oj6BzpDQQw=;
        b=IAhNc2PEOhArE+GcYrmBe/3NxGeuZx3JCuvw8ORdWaNpd8YNvHPLjFq+HAH3MRMP5S
         oOxyBK2u/zYrAOOjd2SxmZlRdg52TimjplCGTE4uqPKuozcM1fiFENkeKCPQ9TnAqGmC
         qDzl2Wwr+U15OcOwRP1fOnEZpCsaQlWf0zLOAuwadhfEdNRJAzc51eKROOxgfx8Ojn9p
         T23rKIIJKsm16XdyBmajMpVc4HFjxz2XrsVtLUH+3NCWbaIRrG6ISCGQMbYo3oB6eg8Y
         VXr6eeEnaLcVnulcplV88lhEe/D2ixCJV4Udc5gLfEIJqGRTME27xPjf75uimLjop3CO
         simA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f1CRBSIEJDuFB8dog5jdvBQmdtw3EAxf2Oj6BzpDQQw=;
        b=lJP/QKqCHckJellEq1Nd7gyenK4Y2f0UetxxZK/tsBGk/gFgj7bAR3i/Yf+CljvIEk
         QuyYST6dFHAzBDZkvs8tpRiTChkK5m/Qs8ak198t30Ck0oX7fLHYNov/4vRbY3km97Ip
         Vap1u2n0H+FrL/3ZeRuWSNmx6BtQMwBu94nlsRfy4PeK++5Qxys24XAfZ801h3LAUdSC
         cPLtpfy+0dqhFplDj3s/uiCSspdsmoS3DriUwAoLmkAZ5bJsveS4dJK+70EnU06lA0EW
         L4LHN90AfjzVk6SaGwYWYwXUBKzFkl+WQ9gV6g6TGEKNT8nnAYl2Hx8a46/XPDMEd/9V
         +lVA==
X-Gm-Message-State: AOAM5306WWYWwybbj7rCAAZdQWgufhX8Qf7DAePIxLsmNOz7t4Xdr0uI
        IP1bUXZn2WhsYKqiBwucBdHxeWkeXHtLOjEWIrCOEgagTENE6w==
X-Google-Smtp-Source: ABdhPJxIX1Rz1uy6qYWtVhSNi58vBkltN0nc+Y74TsUfZKS2AQDMN6wsabdJmmRCmC3OuMNUYpqM8OhcnmPuarpFxhU=
X-Received: by 2002:a6b:8e56:: with SMTP id q83mr8239025iod.61.1594784975129;
 Tue, 14 Jul 2020 20:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-6-lee.jones@linaro.org> <20200715030706.prxya7fyylscoy25@vireshk-i7>
In-Reply-To: <20200715030706.prxya7fyylscoy25@vireshk-i7>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 14 Jul 2020 20:49:24 -0700
Message-ID: <CAOesGMi1dfqPbFJ8YoUoJ75NdU1=XiNoYx+6+JLu44a4LuuYGA@mail.gmail.com>
Subject: Re: [PATCH 05/13] cpufreq/arch: powerpc: pasemi: Move prototypes to
 shared header
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 8:07 PM Viresh Kumar <viresh.kumar@linaro.org> wrot=
e:
>
> On 14-07-20, 15:50, Lee Jones wrote:
> > If function callers and providers do not share the same prototypes the
> > compiler complains of missing prototypes.  Fix this by moving the
> > already existing prototypes out to a mutually convenient location.
> >
> > Fixes the following W=3D1 kernel build warning(s):
> >
> >  drivers/cpufreq/pasemi-cpufreq.c:109:5: warning: no previous prototype=
 for =E2=80=98check_astate=E2=80=99 [-Wmissing-prototypes]
> >  109 | int check_astate(void)
> >  | ^~~~~~~~~~~~
> >  drivers/cpufreq/pasemi-cpufreq.c:114:6: warning: no previous prototype=
 for =E2=80=98restore_astate=E2=80=99 [-Wmissing-prototypes]
> >  114 | void restore_astate(int cpu)
> >  | ^~~~~~~~~~~~~~
> >
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/powerpc/platforms/pasemi/pasemi.h    | 15 ------------
>
> Is there no sane way we can include this file directly to the cpufreq
> file ?

Yep. arch/powerpc seems to be in the search path for modules on powerpc, so=
:

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpuf=
req.c
index c66f566a854cb..815645170c4de 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -22,6 +22,8 @@
 #include <asm/time.h>
 #include <asm/smp.h>

+#include <platforms/pasemi/pasemi.h>
+
 #define SDCASR_REG             0x0100
 #define SDCASR_REG_STRIDE      0x1000
 #define SDCPWR_CFGA0_REG       0x0100


-Olof

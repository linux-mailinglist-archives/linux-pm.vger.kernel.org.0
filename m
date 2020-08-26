Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1C2253517
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 18:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgHZQl6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 12:41:58 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43431 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgHZQl4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 12:41:56 -0400
Received: by mail-oi1-f195.google.com with SMTP id j21so2056131oii.10;
        Wed, 26 Aug 2020 09:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wsy5zXuBQviVStdVeCGrMTAX227JSl/kynJ+bRrUqhw=;
        b=uL0EDsf6hJ5sYmTPNDda8Fn3aZoHQUNP/ul1Zg2uDqq8fYYbtzvot0ih3lIrn/Y9pB
         g82NPkvOgM3zldlh9M67dEQi3MaMJjxny7+jZYgmcuZmtPOwzoKqFdmbyiZoSkTBRdgJ
         ykan7vd4zD6+4pUMcAad6pefnvPiPMVNMChZC0WFZoPLukictI+qb8OIVNDQiNN7zc3K
         3JHxX2lW86AO8oXWpdVvsF4iGom1xgGZ1l4XedbGEQbfw7GFLnzkYuF6yjyZ5KWyMTO0
         lzB04jzWn0AcdB2+iixkegKEBzH/fysOj+H3WFszyvWxpthM+9wEz0gETrlZ5+5EBWpL
         gs3w==
X-Gm-Message-State: AOAM531YtMLODrgjU0sIfxFAWcXIwqop//BQHCZd16o1H1k/82iDZqH8
        JYjcsPTY3dhjMAn2R/vAUE6We+cGhbOSWinDqw8=
X-Google-Smtp-Source: ABdhPJy2nXYl0RJfHQH7KCX/v6XWxgIJw5+i8hypA0vKnYTy4GFLpfksuMvG0V355VFbpomGojLtzxqFcnWQisTKKjo=
X-Received: by 2002:aca:3e8b:: with SMTP id l133mr1553553oia.110.1598460115467;
 Wed, 26 Aug 2020 09:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120421.44356-1-guilhem@barpilot.io> <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
 <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com>
 <d0ca671465e6ce72c6c4d5178440ebc1e4814da8.camel@gmail.com>
 <e82c121057c4496238d3de7f7c919b7039d23b7c.camel@gmail.com>
 <CAGX5Wg0LrzPwf=2pGrQHAbFMVkOoYDxOoFa+ZmLBYshPvZQUXg@mail.gmail.com>
 <8fa7622dacc03f2fbd67e810f53389e3ede544e8.camel@intel.com>
 <CAGX5Wg0=K5AaTut5KH3R3+oasM5MM7PaJ9Z_L56xSNckMbWC9g@mail.gmail.com> <72fab2376722c6169549669016933217d3da34a0.camel@gmail.com>
In-Reply-To: <72fab2376722c6169549669016933217d3da34a0.camel@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Aug 2020 18:41:44 +0200
Message-ID: <CAJZ5v0jDY62HYWF-QKE8kH4kFx9Ympjwk1Dbhdm_VCFaP28RZg@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Guilhem Lettron <guilhem@barpilot.io>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 26, 2020 at 6:19 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> Indeed, when I compare them:
>
> acpi_idle (without the patch):

Does this come from the Guilhem's data?  It's intel_idle in both
cases, but in the "without the patch" case it uses ACPI.

> CPU%c1  CPU%c6  CPU%c7  CoreTmp PkgTmp  GFX%rc6 Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10 PkgWatt
> 29.48   0.00    60.71   58      58      97.96   16.96   0.00    0.00    0.00    0.00    0.00    0.00    6.08

and I get the same data here, but

> intel_idle (with the patch):
>
> CPU%c1  CPU%c6  CPU%c7  CoreTmp PkgTmp  GFX%rc6 Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10 PkgWatt
> 56      56      96.64   300     68.29   48.58   0.00    0.00    0.00    0.00    0.00    0.00    7.38    0.00

you seem to have columns wrong here.

I get something like this

CPU%c1     CPU%c6     CPU%c7     CoreTmp PkgTmp     GFX%rc6 GFXMHz
Totl%C0 Any%C0     GFX%C0     CPUGFX% Pkg%pc2    Pkg%pc3 Pkg%pc6
Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10
16.07     26.24     49.10     56     56     96.64     300     68.29
 48.58     3.08     2.10     30.36     0.04     0.00     0.00     0.00
    0.00     0.00

so still no PC10 residency (and it would be rather strange to get PC10
residency without any PC6 or higher residency).  The 7.38 is the
PkgWatt number AFAICS.

> With intel_idle we reach PC10, without it we only go as deep as PC2 - huge difference.

Not really.  We don't get any PC10 residency in both cases.

> I really wonder why the BIOS does not expose deeper C-states...

It does expose C10.

> And if it does not, is this for a reason? And how windows works then?

It can only expose 3 C-states and it chose to expose C1, C7s and C10.

> May be there is a BIOS update that fixes this problem? May be Windows
> user get it quickly because stuff like this is often well-integrated in
> Windows? Would you please check if there is newer BIOS?

I doubt it.

Cheers!

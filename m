Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56CE2D12AD
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 14:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgLGN4P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 08:56:15 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34929 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgLGN4P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 08:56:15 -0500
Received: by mail-oi1-f195.google.com with SMTP id s2so5961145oij.2;
        Mon, 07 Dec 2020 05:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZMQ3OsR3km5PFN/IF7IgQjAU7PMzxYh8IIKPlWtDXio=;
        b=j75/TKI1Jr0cnwVkNqvXoGV2mXETzNTXvhYk8x8507JyyculbY6wkcjAWas4V1PPSO
         5gXr2BnmRy30Prf6XatHzHbR2x8xdZh4zrBqQ2y1YgAB1T+oQyqgWXtu+bOxO1vkAlVR
         bB8raYdFa4kl7ZlzqexDDtWYckhWp0pXXuNkPEzfZBpMf/HDKuiIgpImDr9nqMzM7Uc7
         I7Ryiy1rt9hZeJLAz3bjchRu7Uz3pDcWvjk0c1iUfgtv1mDFXQ7MFnwB2jBpTyj/upkl
         WXLW+uJO37swHFABbyyQWUrtGVoIlinU9T0F7xc6NdwrxndAPmtKRibFrZRNKy4/3bCx
         AjfQ==
X-Gm-Message-State: AOAM531dAfmhJQ9+kpPa/W8TtTACjy1wEuHFUfP9AglhnMS8HqIknGyp
        vIULBvbL8gUYgCIfy4STAZnRWWKy2pMem/zcA0k=
X-Google-Smtp-Source: ABdhPJwf8zLvZsSTomM44ffhgjZZaR/oqmqhpLTU/bgqFbw6VfvsEpK3hD75Lg/yDH3ENh7/pFbS+XEfGRo9mXHIBwc=
X-Received: by 2002:aca:5197:: with SMTP id f145mr3814978oib.71.1607349334338;
 Mon, 07 Dec 2020 05:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20201125144847.3920-1-punitagrawal@gmail.com> <87zh2tp4x2.fsf@stealth>
In-Reply-To: <87zh2tp4x2.fsf@stealth>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Dec 2020 14:55:17 +0100
Message-ID: <CAJZ5v0gXSN+JcakF6jwnUYgej=LRyYc_jCff07Nx=nGO1a3mfw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Add processor to the ignore PSD override list
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Wei Huang <wei.huang2@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 4, 2020 at 11:45 PM Punit Agrawal <punitagrawal@gmail.com> wrote:
>
> Hi Rafael,
>
> Punit Agrawal <punitagrawal@gmail.com> writes:
>
> > Hi,
> >
> > While looking into Giovanni's patches to enable frequency invariance
> > on AMD systems[0], I noticed an issue with initialising frequency
> > domain information on a recent AMD APU.
> >
> > Patch 1 refactors the test to ignore firmware provided frequency
> > domain into a separate function.
> >
> > Patch 2 adds said APU (Family: 0x17, Model: 0x60, Stepping: 0x01) to
> > the list of CPUs for which the PSD override is ignored. I am not quite
> > happy with having to special case a particular CPU but also couldn't
> > find any documentation to help identify the CPUs that don't need the
> > override.
>
> Are you be OK to pick the first two patches if there are no issues?

Please send them as non-RFC and change the name of override_acpi_psd()
to indicate that it is AMD-specific.

Thanks!

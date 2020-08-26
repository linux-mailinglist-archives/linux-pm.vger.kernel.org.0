Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB8E2534B5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 18:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgHZQVd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 12:21:33 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37158 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgHZQVd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 12:21:33 -0400
Received: by mail-ot1-f67.google.com with SMTP id k2so1969378ots.4;
        Wed, 26 Aug 2020 09:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TbB4aAw95Mh9bTjzGZ253tT1XzFun2QcNkXJEK0ggWg=;
        b=TaMSxtDHu6+IMgGuxqja9s78djX3PfTEaXekszqf/cmbrIauFeYw7Z6vcnPpwFyNJE
         OuGsLMy3d4ESyy6lbLw+x3POs5vHVYExoyuE3ABsMbCg62K6VxPdPNkRpHhkn1j+g1wQ
         pfaCmTqfYqg9BK4gg749DZ8v5SFbXKeOoB0P66S7Df2wPDeOKi6UPSpNCiq8mC0wFjbT
         JUlihPO9lUeAa7IffbLk6ZELt+ZhqAEV6/z2nRiUy345ryuhEfjWg2HGUiO8QYVUlGd1
         R3CXLjB8sojRm0VHWW6C/sqpJyJl9CDgd9Mcpa8pnQP6EtGiMqH/FVu84LUSMQspXP6X
         soug==
X-Gm-Message-State: AOAM533MImgTt87U4qdfCF0hU2u6N6uTIYW9s7BReRSyOrGPsjmXWpyM
        1Gne/mf08meigrgv0iVWoAbbZGWhXZeviVOs2Vc=
X-Google-Smtp-Source: ABdhPJwE43X2zK+eq5dh7BAAc3PBhxtcts0J2cCUcuOavhPyEeuub5fqGAborirceeCJK+/EhO9LdA1Fq+GEOhci2IA=
X-Received: by 2002:a05:6830:1242:: with SMTP id s2mr9921888otp.167.1598458892069;
 Wed, 26 Aug 2020 09:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120421.44356-1-guilhem@barpilot.io> <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
 <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com>
 <d0ca671465e6ce72c6c4d5178440ebc1e4814da8.camel@gmail.com>
 <e82c121057c4496238d3de7f7c919b7039d23b7c.camel@gmail.com>
 <CAGX5Wg0LrzPwf=2pGrQHAbFMVkOoYDxOoFa+ZmLBYshPvZQUXg@mail.gmail.com>
 <8fa7622dacc03f2fbd67e810f53389e3ede544e8.camel@intel.com>
 <CAGX5Wg0=K5AaTut5KH3R3+oasM5MM7PaJ9Z_L56xSNckMbWC9g@mail.gmail.com> <CAJZ5v0j4FXH26rZCjM9Csd56skPVbRpM7iFcKYAFMmLFX54+bg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j4FXH26rZCjM9Csd56skPVbRpM7iFcKYAFMmLFX54+bg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Aug 2020 18:21:21 +0200
Message-ID: <CAJZ5v0jkgVn88H9K0n0SX_xLPCgMYXXSVHXLLYaWvynGOMLf=g@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
To:     Guilhem Lettron <guilhem@barpilot.io>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
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

On Wed, Aug 26, 2020 at 6:02 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Aug 26, 2020 at 4:04 PM Guilhem Lettron <guilhem@barpilot.io> wrote:
> >
> > On Wed, 26 Aug 2020 at 15:41, Zhang Rui <rui.zhang@intel.com> wrote:
> > >
> > >
> > > This is really hard to read.
> > > can you please attach the two turbostat output as attachments?
> >
> > of course :)
>
> Thanks!
>
> A couple of things happen here AFAICS.
>
> First, your processor seems to be unable to enter package C-states
> below PC3, so probably there is a device (most likely a PCI one)
> preventing it from doing that in the system.  If all goes well, it
> should be able to get to at least PC8 without suspending the whole
> system.  That needs to be dealt with in the first place before we can
> draw meaningful conclusions regarding which set of C-states to expose
> and whether or not the one exposed via ACPI is sufficient.
>
> To that end, I would try to upgrade the graphics firmware and see if
> you can get some nonzero PC8 residency then.
>
> Second, ACPI exposes C1, C7s and C10 only and so you don't get any
> CPU-C6 residency without the patch, but instead you get more CPU-C7
> residency and more CPU-C1 residency.  It is hard to say which is
> better in principle, but if you look at what is asked for by the
> governor, it turns out that deep C-states (C8-C10) are requested
> around 54% of the time with the patch, whereas without it the ACPI_C3
> state (corresponding to C10) is requested approximately 24% of the
> time, which is much less often.  That appears to translate to the
> difference in PC2 residency (~30% with the patch vs ~17% without it).
>
> Note, however, that (with the patch) C10 itself is asked for around
> 11% of the time which in turn is much less than the ~24% for the
> corresponding ACPI_C3 (without the patch).
>
> Overall, it looks like exposing C8 is beneficial from the energy usage
> perspective, because (in the future, when the "blocking" device is
> taken care of and the system can enter PC8 and deeper package
> C-states) it may allow PC8 to be entered more often in principle, even
> though it may reduce the amount of time spent in PC10 too (PC10 may be
> generally difficult to enter, though).  [Here I'm assuming that the
> processor enters PC3 or PC2 instead of PC8 or deeper which cannot be
> entered due to some resource dependency.]
>
> OTOH exposing C1E doesn't seem to make much of a difference and
> exposing C6 only causes it to be asked for instead of C7s, so exposing
> the latter alone should be sufficient in theory.

I need to correct myself here.

With the patch C7s is exposed with the target residency of C8 which is
why it is almost never selected by the governor and that's why C6 is
kind of "instead" of it.

So it looks like it might be beneficial to expose C8 (instead of C7s)
and C6 with the target residency significantly less than that of C8.

> So IMO the set of C-states exposed by ACPI looks almost enough, but
> the jury is out until you can make the system be able to enter at
> least PC8.

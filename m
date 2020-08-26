Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B60225343F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 18:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgHZQC1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 12:02:27 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34276 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgHZQCO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 12:02:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id z22so1966813oid.1;
        Wed, 26 Aug 2020 09:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4U9g9jf07dgLfcUFJqNvcoW1b70TKrvlWnyXzf8TcY=;
        b=DiouNkdCkWbxAQNfLzFhTn/D+TTwZBbTkeHy0vivkLwllwwv83p5hNSO2n1LrPrDWQ
         5IvYg/8ZEDBpvYjNuNproW/PePGZ1ztcPwjj3dJm7B9J5H2yFC0vqEVwc9QaZwjOoeYW
         /YiMN/tVMWI29IhYAYF9A4AB4zx1FdElBuiSSTN1szWLN5yhpQm9JR6d8ku4y3yqun9S
         Ojl+ctUOrthMh5o/gmpeFbTBhapNQEbPqRY4pQ+ECCY9kTx9fUdmWDoP5cIrSsxElMkE
         t63rXz+ORJafMSfNCdam3xu7PGEohek8sERQ7tJ3HPhRrkOK3qWLpblVz//ONcudDuz8
         7FFg==
X-Gm-Message-State: AOAM533vLM9E0adl3Om/1IaBhcPvMLLQVcz4L2jle5Wquq9FgrLsz6Qy
        ZYXpP2bfGAbbLQKThkYzgNnyLffqtbILlrBZCN8=
X-Google-Smtp-Source: ABdhPJym8nVQ2esE+9JbqCwt7qPyZZTboKxS/f2UKwBR6gzZin1etfhHn6ZOAwvRuYrIe52l+IQfv1042GoBqNXmgoQ=
X-Received: by 2002:aca:3e8b:: with SMTP id l133mr1445381oia.110.1598457733101;
 Wed, 26 Aug 2020 09:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120421.44356-1-guilhem@barpilot.io> <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
 <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com>
 <d0ca671465e6ce72c6c4d5178440ebc1e4814da8.camel@gmail.com>
 <e82c121057c4496238d3de7f7c919b7039d23b7c.camel@gmail.com>
 <CAGX5Wg0LrzPwf=2pGrQHAbFMVkOoYDxOoFa+ZmLBYshPvZQUXg@mail.gmail.com>
 <8fa7622dacc03f2fbd67e810f53389e3ede544e8.camel@intel.com> <CAGX5Wg0=K5AaTut5KH3R3+oasM5MM7PaJ9Z_L56xSNckMbWC9g@mail.gmail.com>
In-Reply-To: <CAGX5Wg0=K5AaTut5KH3R3+oasM5MM7PaJ9Z_L56xSNckMbWC9g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Aug 2020 18:02:02 +0200
Message-ID: <CAJZ5v0j4FXH26rZCjM9Csd56skPVbRpM7iFcKYAFMmLFX54+bg@mail.gmail.com>
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

On Wed, Aug 26, 2020 at 4:04 PM Guilhem Lettron <guilhem@barpilot.io> wrote:
>
> On Wed, 26 Aug 2020 at 15:41, Zhang Rui <rui.zhang@intel.com> wrote:
> >
> >
> > This is really hard to read.
> > can you please attach the two turbostat output as attachments?
>
> of course :)

Thanks!

A couple of things happen here AFAICS.

First, your processor seems to be unable to enter package C-states
below PC3, so probably there is a device (most likely a PCI one)
preventing it from doing that in the system.  If all goes well, it
should be able to get to at least PC8 without suspending the whole
system.  That needs to be dealt with in the first place before we can
draw meaningful conclusions regarding which set of C-states to expose
and whether or not the one exposed via ACPI is sufficient.

To that end, I would try to upgrade the graphics firmware and see if
you can get some nonzero PC8 residency then.

Second, ACPI exposes C1, C7s and C10 only and so you don't get any
CPU-C6 residency without the patch, but instead you get more CPU-C7
residency and more CPU-C1 residency.  It is hard to say which is
better in principle, but if you look at what is asked for by the
governor, it turns out that deep C-states (C8-C10) are requested
around 54% of the time with the patch, whereas without it the ACPI_C3
state (corresponding to C10) is requested approximately 24% of the
time, which is much less often.  That appears to translate to the
difference in PC2 residency (~30% with the patch vs ~17% without it).

Note, however, that (with the patch) C10 itself is asked for around
11% of the time which in turn is much less than the ~24% for the
corresponding ACPI_C3 (without the patch).

Overall, it looks like exposing C8 is beneficial from the energy usage
perspective, because (in the future, when the "blocking" device is
taken care of and the system can enter PC8 and deeper package
C-states) it may allow PC8 to be entered more often in principle, even
though it may reduce the amount of time spent in PC10 too (PC10 may be
generally difficult to enter, though).  [Here I'm assuming that the
processor enters PC3 or PC2 instead of PC8 or deeper which cannot be
entered due to some resource dependency.]

OTOH exposing C1E doesn't seem to make much of a difference and
exposing C6 only causes it to be asked for instead of C7s, so exposing
the latter alone should be sufficient in theory.

So IMO the set of C-states exposed by ACPI looks almost enough, but
the jury is out until you can make the system be able to enter at
least PC8.

Cheers!

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9963761
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 15:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfGIN7t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 9 Jul 2019 09:59:49 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35248 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfGIN7t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2019 09:59:49 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so15424475oii.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2019 06:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aEg872fDzbqoCXNkaRuXqsTnoAdpr8cbkA22Rfy4daM=;
        b=Zq5h4JuM8eld4O8F4O86PvCvPXs44Fej8G1uN5V2l6SiW/fRGY060L3CehRkiHrEf6
         wwc5nGlKGGsKCVwyQalFmoEW8Y3R6EiFGZOqLS+IO0PVkJHEaekG9OE6xZA1w+drORLR
         QU0RGpF2C11fzlbD8W03scnG9dutxXH7J4N9AFL148lu9Q48pJCcL7DrWixjA701ElDY
         FhNfQzKyqeZds9v/2L0UQ1fO43dYiaMnN+ND+4AL87kn4XGn4Cpu3BPVYT6uVKm/yj7J
         3aeRmK2A9FQi8Mntz6BlmBDwdjVBi16bDZGIr4KOwLKiyvqFqZjN9Y8ZAXo9atLNFtxC
         51qg==
X-Gm-Message-State: APjAAAV8owsALfJTUTVIEsb8H6qx0H+7rgd0l0Vh/v5t6RcxVCyeOyZf
        BwV9859rEZEgK45t+O7ZQdg/wNA5mo355z0fWdJqtw==
X-Google-Smtp-Source: APXvYqyeF8y5Xg1yGQzWgMjOAovp6SF9vOfOvZ4+7ZBauFquYkR80OwQwjQZj3YjJxxHUmEpNkEt/AVqibgaXBeIy34=
X-Received: by 2002:aca:4e89:: with SMTP id c131mr75674oib.57.1562680788663;
 Tue, 09 Jul 2019 06:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
 <CAJZ5v0jZEcSpGqeccZwOw6a_QMXKdcx4K2GBeC8P0Vn-9E6vyQ@mail.gmail.com>
 <97215b43ce11766f83847531b05def8d94f645f0.camel@intel.com>
 <CAJZ5v0ixFF-_5yYZhWBJLUaE6oreaGY1BELGTsYfqYw3M9sDcQ@mail.gmail.com>
 <1562568815.2810.18.camel@intel.com> <CAJZ5v0gC8iBjXFtawiRDJ0oCpQDrjXm9OjP-b6ZLnoG=_bwd8g@mail.gmail.com>
 <1562679696.2440.9.camel@intel.com>
In-Reply-To: <1562679696.2440.9.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Jul 2019 15:59:36 +0200
Message-ID: <CAJZ5v0jKFMp7h7UZPZ8UKCfjpONK70MpR4rjFfNW0CxskSB+hw@mail.gmail.com>
Subject: Re: [PATCH V2 00/13] intel_rapl: RAPL abstraction and MMIO RAPL support
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 9, 2019 at 3:41 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On 一, 2019-07-08 at 10:58 +0200, Rafael J. Wysocki wrote:
> > On Mon, Jul 8, 2019 at 8:53 AM Zhang Rui <rui.zhang@intel.com> wrote:
> > >
> > >
> > > On 六, 2019-07-06 at 10:19 +0200, Rafael J. Wysocki wrote:
> > > >
> > > > On Fri, Jul 5, 2019 at 4:59 PM Pandruvada, Srinivas
> > > > <srinivas.pandruvada@intel.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On Fri, 2019-07-05 at 10:57 +0200, Rafael J. Wysocki wrote:
> > > > > >
> > > > > >
> > > > > > On Thu, Jul 4, 2019 at 6:34 PM Zhang Rui <rui.zhang@intel.com
> > > > > > >
> > > > > > wrote:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Besideis MSR interface, RAPL can also be controlled via the
> > > > > > > MMIO
> > > > > > > interface,
> > > > > > > by accessing the MCHBar registers exposed by the processor
> > > > > > > thermal
> > > > > > > device.
> > > > > > >
> > > > > > > Currently, we only have RAPL MSR interface in Linux kernel,
> > > > > > > this
> > > > > > > brings
> > > > > > > problems on some platforms that BIOS performs a low power
> > > > > > > limits
> > > > > > > via the
> > > > > > > MMIO interface by default. This results in poor system
> > > > > > > performance,
> > > > > > > and there is no way for us to change the MMIO MSR setting
> > > > > > > in
> > > > > > > Linux.
> > > > > > >
> > > > > > > To fix this, RAPL MMIO interface support is introduced in
> > > > > > > this
> > > > > > > patch set.
> > > > > > >
> > > > > > > Patch 1/13 to patch 11/13 abstract the RAPL code, and move
> > > > > > > all
> > > > > > > the
> > > > > > > shared
> > > > > > > code into a separate file, intel_rapl_common.c, so that it
> > > > > > > can
> > > > > > > be
> > > > > > > used
> > > > > > > by both MSR and MMIO interfaces.
> > > > > > > Patch 12/13 introduced RAPL support via MMIO registers,
> > > > > > > exposed
> > > > > > > by
> > > > > > > the
> > > > > > > processor thermal devices.
> > > > > > > Patch 13/13 fixes a module autoloading issue found later.
> > > > > > >
> > > > > > > The patch series has been tested on Dell XPS 9360, a SKL
> > > > > > > platform.
> > > > > > >
> > > > > > > Note that this patch series are based on the -tip tree,
> > > > > > > which
> > > > > > > contains the
> > > > > > > latest RAPL changes for multi-die support.
> > > > > > >
> > > > > > > Changes in V2:
> > > > > > >    - add kerneldoc for struct rapl_if_priv.
> > > > > > >    - use intel_rapl_msr.c for RAPL MSR I/F driver, instead
> > > > > > > of
> > > > > > > intel_rapl.c.
> > > > > > >    - changelog and coding style update.
> > > > > > What tree is the series against?
> > > > > >
> > > > > > It doesn't apply either on top of my powercap branch or on
> > > > > > top of
> > > > > > 5.2-rc7 for me.
> > > > > This needs linux tip tree. There are some package/die changes
> > > > > in
> > > > > tip
> > > > > tree, which this patch depends on.
> > > > OK, so the changes in -tip need to go in first.
> > > >
> > > exactly.
> > > BTW, this patch set also conflicts with the RAPL support patches
> > > for
> > > icelake platforms.
> > Do you mean commits
> >
> > cc3ae777098b..88679b2587a0
> >
> > in linux-next?
> >
> yes.
> > >
> > > Thus IMO, having a separate rapl branch, and apply
> > > the icl rapl patches on top of this patch set will be much easier.
> > OK, I'll do that if that's preferred.
>
> thanks. I think you can apply the ICL RAPL patches by replacing
> intel_rapl.c with intel_rapl_common.c in the patch files. Or I can
> resend the ICL RAPL patches rebased on the this patch series.

It would help if you did that, thanks!

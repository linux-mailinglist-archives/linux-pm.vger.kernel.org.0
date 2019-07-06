Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B5960F70
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2019 10:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfGFITo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Jul 2019 04:19:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46099 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfGFITo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Jul 2019 04:19:44 -0400
Received: by mail-oi1-f196.google.com with SMTP id 65so8749815oid.13
        for <linux-pm@vger.kernel.org>; Sat, 06 Jul 2019 01:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOzWOlAD7N+TCby0rEh2L1c/ULAXkz+iyUutVoup1wQ=;
        b=j+CYfkCetw1GqRwwBcSrlU6tUTvxOgCY6+fo2qA2xdZxn6chZZIbPEnfvmw8nVjxDM
         loo5xKRb0dchksrynbWXpwVR7onOnwLb+XnsBn8wcbwhHrRa3Vzk4ltR/L/zRNA/6V5Y
         MResKWcSorQlqVHh74MsIE3SOyflbnY8sT/5TmR2NwfVh6JJvtE+R5dVeq5j9v8dTBuY
         EH+eLjIQQyuigKW+JJjerKwdVLK1q/H9xsa4sOyUWIdISxGa6QBBP7GwY5qtlyWgD+vy
         JH4Cc7kOMfEQWkF5jV3nAPNinps37Sen/urMSWaWXhYM0+pQXgE+h1SGX7lP0D5dKrm8
         3gPw==
X-Gm-Message-State: APjAAAX9gTNCqj5NZ6VQ7JAOvfOuuJzGE2aRac+EktoO75Boql8mK+dB
        mQEYFcCsNmVCrNe+P11UWocF17gHU3fgzlTOhPU=
X-Google-Smtp-Source: APXvYqwjY2UTwERA9JC28rG2RrgWnEu3RLbvtM6aNZ0pHW2gO68orSM1x/dmpDTyWNMeHJurxncPGdTjn6r6KDjq36k=
X-Received: by 2002:aca:d907:: with SMTP id q7mr4038686oig.68.1562401183515;
 Sat, 06 Jul 2019 01:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
 <CAJZ5v0jZEcSpGqeccZwOw6a_QMXKdcx4K2GBeC8P0Vn-9E6vyQ@mail.gmail.com> <97215b43ce11766f83847531b05def8d94f645f0.camel@intel.com>
In-Reply-To: <97215b43ce11766f83847531b05def8d94f645f0.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 6 Jul 2019 10:19:32 +0200
Message-ID: <CAJZ5v0ixFF-_5yYZhWBJLUaE6oreaGY1BELGTsYfqYw3M9sDcQ@mail.gmail.com>
Subject: Re: [PATCH V2 00/13] intel_rapl: RAPL abstraction and MMIO RAPL support
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 5, 2019 at 4:59 PM Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
>
> On Fri, 2019-07-05 at 10:57 +0200, Rafael J. Wysocki wrote:
> > On Thu, Jul 4, 2019 at 6:34 PM Zhang Rui <rui.zhang@intel.com> wrote:
> > >
> > > Besideis MSR interface, RAPL can also be controlled via the MMIO
> > > interface,
> > > by accessing the MCHBar registers exposed by the processor thermal
> > > device.
> > >
> > > Currently, we only have RAPL MSR interface in Linux kernel, this
> > > brings
> > > problems on some platforms that BIOS performs a low power limits
> > > via the
> > > MMIO interface by default. This results in poor system performance,
> > > and there is no way for us to change the MMIO MSR setting in Linux.
> > >
> > > To fix this, RAPL MMIO interface support is introduced in this
> > > patch set.
> > >
> > > Patch 1/13 to patch 11/13 abstract the RAPL code, and move all the
> > > shared
> > > code into a separate file, intel_rapl_common.c, so that it can be
> > > used
> > > by both MSR and MMIO interfaces.
> > > Patch 12/13 introduced RAPL support via MMIO registers, exposed by
> > > the
> > > processor thermal devices.
> > > Patch 13/13 fixes a module autoloading issue found later.
> > >
> > > The patch series has been tested on Dell XPS 9360, a SKL platform.
> > >
> > > Note that this patch series are based on the -tip tree, which
> > > contains the
> > > latest RAPL changes for multi-die support.
> > >
> > > Changes in V2:
> > >    - add kerneldoc for struct rapl_if_priv.
> > >    - use intel_rapl_msr.c for RAPL MSR I/F driver, instead of
> > > intel_rapl.c.
> > >    - changelog and coding style update.
> >
> > What tree is the series against?
> >
> > It doesn't apply either on top of my powercap branch or on top of
> > 5.2-rc7 for me.
> This needs linux tip tree. There are some package/die changes in tip
> tree, which this patch depends on.

OK, so the changes in -tip need to go in first.

Thanks!

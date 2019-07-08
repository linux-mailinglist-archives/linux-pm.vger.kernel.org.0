Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAA361C06
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 10:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfGHI7K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 8 Jul 2019 04:59:10 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41240 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfGHI7K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 04:59:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id g7so11996745oia.8
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2019 01:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GrF+QwjcyPyUZmmBusIaUAI/pIadWghvJ3lsOBQNHYc=;
        b=dG0hRFUDU9pFtFHRZwG4hRLag4bI/iEt8Th3jlcc4uZSh99zWLUkGAtC/DIz5eiE40
         VMR4fWHKk06qObScAse4jn0I4WyKvaEiDeYZb9qrMywBYOll1r4v+BbgQ8CovkbGok8m
         B/4nospGXpOnEvlmFT2BQVw/d6EstH/hRIzTwiXBOXthfeSDiBfJ7BmaJErNqq9sSeiK
         Who5QGT0yiVgar0RqE5OpaUZDnymNhGuHVfNczczvihAYuUTkynNPPyQlPgf/bDNxn19
         nAEVbjkRqdCfjIqNNNOsj6lptOhjwHpEQ7ZvFGPqVpfCVOuGAcgIcXGl+5xXg9oqrPoW
         xUcg==
X-Gm-Message-State: APjAAAWyYiS4eYamyh2nBsWJkbQvAMLCXRrCVhLq7EkwyUrdv5oc9XaG
        DjeGhgoxX/bKLlTrL1QGAkfALAxZu0br3tNRKqg=
X-Google-Smtp-Source: APXvYqzzfzGPE8jYW/Ozw4QopFIgR/qj1EwMBgTJz4h2H2iMJoNvRaqTiygC+tjltFn7NnoM58y0si7YbS5xP/wjXzI=
X-Received: by 2002:aca:edc8:: with SMTP id l191mr8806924oih.103.1562576349607;
 Mon, 08 Jul 2019 01:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
 <CAJZ5v0jZEcSpGqeccZwOw6a_QMXKdcx4K2GBeC8P0Vn-9E6vyQ@mail.gmail.com>
 <97215b43ce11766f83847531b05def8d94f645f0.camel@intel.com>
 <CAJZ5v0ixFF-_5yYZhWBJLUaE6oreaGY1BELGTsYfqYw3M9sDcQ@mail.gmail.com> <1562568815.2810.18.camel@intel.com>
In-Reply-To: <1562568815.2810.18.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Jul 2019 10:58:58 +0200
Message-ID: <CAJZ5v0gC8iBjXFtawiRDJ0oCpQDrjXm9OjP-b6ZLnoG=_bwd8g@mail.gmail.com>
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

On Mon, Jul 8, 2019 at 8:53 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On 六, 2019-07-06 at 10:19 +0200, Rafael J. Wysocki wrote:
> > On Fri, Jul 5, 2019 at 4:59 PM Pandruvada, Srinivas
> > <srinivas.pandruvada@intel.com> wrote:
> > >
> > >
> > > On Fri, 2019-07-05 at 10:57 +0200, Rafael J. Wysocki wrote:
> > > >
> > > > On Thu, Jul 4, 2019 at 6:34 PM Zhang Rui <rui.zhang@intel.com>
> > > > wrote:
> > > > >
> > > > >
> > > > > Besideis MSR interface, RAPL can also be controlled via the
> > > > > MMIO
> > > > > interface,
> > > > > by accessing the MCHBar registers exposed by the processor
> > > > > thermal
> > > > > device.
> > > > >
> > > > > Currently, we only have RAPL MSR interface in Linux kernel,
> > > > > this
> > > > > brings
> > > > > problems on some platforms that BIOS performs a low power
> > > > > limits
> > > > > via the
> > > > > MMIO interface by default. This results in poor system
> > > > > performance,
> > > > > and there is no way for us to change the MMIO MSR setting in
> > > > > Linux.
> > > > >
> > > > > To fix this, RAPL MMIO interface support is introduced in this
> > > > > patch set.
> > > > >
> > > > > Patch 1/13 to patch 11/13 abstract the RAPL code, and move all
> > > > > the
> > > > > shared
> > > > > code into a separate file, intel_rapl_common.c, so that it can
> > > > > be
> > > > > used
> > > > > by both MSR and MMIO interfaces.
> > > > > Patch 12/13 introduced RAPL support via MMIO registers, exposed
> > > > > by
> > > > > the
> > > > > processor thermal devices.
> > > > > Patch 13/13 fixes a module autoloading issue found later.
> > > > >
> > > > > The patch series has been tested on Dell XPS 9360, a SKL
> > > > > platform.
> > > > >
> > > > > Note that this patch series are based on the -tip tree, which
> > > > > contains the
> > > > > latest RAPL changes for multi-die support.
> > > > >
> > > > > Changes in V2:
> > > > >    - add kerneldoc for struct rapl_if_priv.
> > > > >    - use intel_rapl_msr.c for RAPL MSR I/F driver, instead of
> > > > > intel_rapl.c.
> > > > >    - changelog and coding style update.
> > > > What tree is the series against?
> > > >
> > > > It doesn't apply either on top of my powercap branch or on top of
> > > > 5.2-rc7 for me.
> > > This needs linux tip tree. There are some package/die changes in
> > > tip
> > > tree, which this patch depends on.
> > OK, so the changes in -tip need to go in first.
> >
> exactly.
> BTW, this patch set also conflicts with the RAPL support patches for
> icelake platforms.

Do you mean commits

cc3ae777098b..88679b2587a0

in linux-next?

> Thus IMO, having a separate rapl branch, and apply
> the icl rapl patches on top of this patch set will be much easier.

OK, I'll do that if that's preferred.

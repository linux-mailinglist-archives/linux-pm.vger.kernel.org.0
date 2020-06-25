Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27A1209CF5
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 12:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403908AbgFYKha (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 06:37:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45810 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403816AbgFYKha (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 06:37:30 -0400
Received: by mail-oi1-f194.google.com with SMTP id j11so1856859oiw.12;
        Thu, 25 Jun 2020 03:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8P2ZtpVWAu+nAxfSwQK0wizQDnDAGxulBEcw16WR1X8=;
        b=gz8pPk0+GiaN7j/BiZvU7cOf8dM8fxZzIp2G1UuZjTLaX3Wa2MFOZKwJSl6Ck64qkF
         z8ifTXVQkOfhaRpT9UDcswQhy8fO5x6W+sIWBICnYx/BQMwkhMn7juSHmhP1/lPiu1OV
         eAlMtHTZJWXjkfU1228kKhurn3JqlciExIvlgwIkAlYgWyKyls0BePSE5vDDrXgWvyb+
         Qa0e8cBNEfEluBRCUhY0Nnjl/AyYGDRoqSRjYhlTVbLxwyJAHsqC8ZQhcx83uFm4eb8z
         mIm+0Lz4bMcfOFrDFEVFRwtIZacmLFPgyXonUtj3RYz07/1/4raGYob+4XimvYX/0n28
         HPfA==
X-Gm-Message-State: AOAM530rqiLBgfVxj81tmvEMFjfKpQKhaKPZX51Fkpyb3NV4tG6TV3Zz
        zNaCfcb2VsPY7TIlEaviQUWSBtlaLHbNWS1N/TZ+FYgT1ho=
X-Google-Smtp-Source: ABdhPJxq9pfiahjneXji68p49YEXHsuatRRWYppp3D1TSooYy+hww3yQk1hM1qgA3lStonFHOV2SlGvu4OIJ7cMDzWw=
X-Received: by 2002:a05:6808:99b:: with SMTP id a27mr1561206oic.68.1593081449629;
 Thu, 25 Jun 2020 03:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200624131921.GB9972@mwanda> <CAJZ5v0hG2FL0VSeE+ind9MSMc_c7nA4KjKxFPdMhVOPrMdYJKQ@mail.gmail.com>
 <20200625090449.GA2549@kadam>
In-Reply-To: <20200625090449.GA2549@kadam>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Jun 2020 12:37:18 +0200
Message-ID: <CAJZ5v0h0RNt5+SCeXg7pGgGmu1T0Hyk9kYrgia+kWHsQeE8cPg@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Fix uninitialized variable bug
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 25, 2020 at 11:05 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Jun 24, 2020 at 03:41:05PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 24, 2020 at 3:19 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > The "tick" variable isn't initialized if "lapic_timer_always_reliable"
> > > is true.
> >
> > If lapic_timer_always_reliable is true, then
> > static_cpu_has(X86_FEATURE_ARAT) must also be true AFAICS.
> >
> > So the lapic_timer_always_reliable check in there looks redundant.
>
> Can the lapic_timer_always_reliable variable just be removed entirely
> and replaced with an static_cpu_has(X86_FEATURE_ARAT) check?

Yes, it can.

See https://patchwork.kernel.org/patch/11623309/

Thanks!

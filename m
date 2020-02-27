Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0B217156B
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 11:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgB0K5D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 05:57:03 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46241 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgB0K5D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 05:57:03 -0500
Received: by mail-oi1-f194.google.com with SMTP id a22so2794645oid.13;
        Thu, 27 Feb 2020 02:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMp2Uo23EsbUKjNiwGS0nq4uhe7UZ65ytVoOukqSBrg=;
        b=fSuqXlZh9wGb3SZIpgSCLAEHPz/kXhPRJ5MlP9k1xfoQAnfC9s/K0dHVBMCu78f2qf
         yyXTyQFOxFHVDFIVewJOS0nF17xaXl3jp23c0aC7KFv2E+UPfTFocCYEx6BmzCDXthLO
         ARcjZUgPNZWMLMLULAmESnwCwlO3TNyZvbtSm3+9KVmgipIKoQJsCJpq75di+2C8x/8P
         X1Ek/5ec8HEwxyhQP9+sYtuyH6ShnJ7w3qL4nH1GI30VwIKwoBahanh7yU7UIf7bERwF
         MVT5nAHQ8XgzXVMU04uy68r/uMwnh+7x39IsGMECCf+PAZ8Qz5nbBIjnu1jE8HCSr96C
         4+4A==
X-Gm-Message-State: APjAAAV1yiy0tiS/DLVT5OsHaNhP5eieE0e41rt3kIpDY+fnr5m41fKz
        xZ/fR3Jb4OnzV9KCazobuCc3beEwrPKZLdRogKE=
X-Google-Smtp-Source: APXvYqz9yLYkpiMr+Qpie6BSAskCXK6MRWHVOsdKOHohaGzsWHBFYIw+pNR94t+9+5X2FEbUGUc24eOvLWgg4ebfcVs=
X-Received: by 2002:a05:6808:8e1:: with SMTP id d1mr2753277oic.68.1582801022380;
 Thu, 27 Feb 2020 02:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20200227013411.1.Ica3bb9fa898499d94e0b0a2bfa08ec46c89d84fa@changeid>
 <CAJZ5v0hX-DVLPQmjVAZkQUJy8gCBPTneJvaFHmjqqbCe66F_6w@mail.gmail.com>
In-Reply-To: <CAJZ5v0hX-DVLPQmjVAZkQUJy8gCBPTneJvaFHmjqqbCe66F_6w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Feb 2020 11:56:51 +0100
Message-ID: <CAJZ5v0itu2ke-zfjMSyj=EPeqkzhnhOx=CiHnShAUCiPyOiiUw@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add Comet Lake support
To:     Harry Pan <harry.pan@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Harry Pan <gs0622@gmail.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 26, 2020 at 10:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Feb 26, 2020 at 6:34 PM Harry Pan <harry.pan@intel.com> wrote:
> >
> > Add Comet Lake ID to enable intel_idle driver support.
> > This is required for PC10 and S0ix.
>
> That shouldn't be the case for Linux 5.6-rc as long as the ACPI tables
> expose C10 in _CST, so have you checked that?

Regardless of that (which only is about the changelog), I wouldn't
just use idle_cpu_skl directly for CML like in the patch below.

Instead, I'd define something like

static const struct idle_cpu idle_cpu_cml __initconst = {
    .state_table = skl_cstates,
    .disable_promotion_to_c1e = true,
    .use_acpi = true,
};

and point  to it from the CML entries in intel_idle_ids[].

That would allow the driver to avoid enabling the C-states that are
not exposed in the ACPI tables by default which generally is safer
than exposing all of them for all CML platforms unconditionally.

> > Signed-off-by: Harry Pan <harry.pan@intel.com>
> >
> > ---
> >
> >  drivers/idle/intel_idle.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> > index 347b08b56042..3cf292b2b7f1 100644
> > --- a/drivers/idle/intel_idle.c
> > +++ b/drivers/idle/intel_idle.c
> > @@ -1086,6 +1086,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
> >         INTEL_CPU_FAM6(KABYLAKE_L,              idle_cpu_skl),
> >         INTEL_CPU_FAM6(KABYLAKE,                idle_cpu_skl),
> >         INTEL_CPU_FAM6(SKYLAKE_X,               idle_cpu_skx),
> > +       INTEL_CPU_FAM6(COMETLAKE_L,             idle_cpu_skl),
> > +       INTEL_CPU_FAM6(COMETLAKE,               idle_cpu_skl),

+       INTEL_CPU_FAM6(COMETLAKE_L,             idle_cpu_cml),
+       INTEL_CPU_FAM6(COMETLAKE,               idle_cpu_cml),

> >         INTEL_CPU_FAM6(XEON_PHI_KNL,            idle_cpu_knl),
> >         INTEL_CPU_FAM6(XEON_PHI_KNM,            idle_cpu_knl),
> >         INTEL_CPU_FAM6(ATOM_GOLDMONT,           idle_cpu_bxt),
> > --
> > 2.24.1
> >

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157AC179AB6
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 22:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgCDVOS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 4 Mar 2020 16:14:18 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34754 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDVOS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 16:14:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id j16so3544810otl.1;
        Wed, 04 Mar 2020 13:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JLQZ2G1Xjci6M9Tdj0KmF35kuRwhcReJ8Bh0Us9PzUc=;
        b=CqK/TyqU9m7Ex6bN8OKK8owMDs2BuSv8dUOy70L5GNcmZw3ecmbD7UuV2wFgfhschL
         QGQROMpIUj6SiJyKbqkeVuZGxzTtpDL2hpLR3RgL5rGLTMJGuQEk44/WEsm2D7dIUPAJ
         XppQs7UCoxqAmLvTD9rH5Oa8aPhJ4NgogvG7w+xdvLBsMoXrMTqM4XA4Iyk2RHjmgWoO
         PYv3BhLTFgKNeQFZ/IFutkY+DEZ+IWhYWVTmZoEsAOvyP7gWj9hzQUqWqh6EmlEoqiq3
         BmXlQy/dPzfETVj4pFGIdZvt4pBf9lMhyDNKp3qH09NH7BTGVfSgRX7stQHv1MTIEzL9
         LVXQ==
X-Gm-Message-State: ANhLgQ2SpszchG0psh5aksgTuAyWQRNPYKnq9XnkCCrwccXFGbE82c2D
        hqJLGd2rcKe9Ps1zKCeDISBHKL+TZoNgBoy6jtoEJz2P
X-Google-Smtp-Source: ADFU+vsO2OteMecxFWmOO5z9/LBDPBK1mmNYWFu+lKjiP3PM6glg8i8Fx9E51YzIPILiDF6bsax+ZdIN8NNKcaHFzAQ=
X-Received: by 2002:a9d:7653:: with SMTP id o19mr3801182otl.118.1583356457362;
 Wed, 04 Mar 2020 13:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20200227013411.1.Ica3bb9fa898499d94e0b0a2bfa08ec46c89d84fa@changeid>
 <20200303170948.1.I108734f38ade020c3e5da825839dca11d2a2ff87@changeid>
 <CAJZ5v0j+bx5fh1wv738MNoui_SaZ-c21rDnZkWOqi_GCVg5stQ@mail.gmail.com> <F8C6368A-1537-482B-8FE5-350A18D936A8@intel.com>
In-Reply-To: <F8C6368A-1537-482B-8FE5-350A18D936A8@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Mar 2020 22:14:06 +0100
Message-ID: <CAJZ5v0iBMiGKeFXRTLkR8oFQbdCJq0TnhpFZkMBK4gF0VNjumA@mail.gmail.com>
Subject: Re: [PATCH v3] intel_idle: Add Comet Lake support
To:     "Pan, Harry" <harry.pan@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Harry Pan <gs0622@gmail.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 4, 2020 at 12:57 PM Pan, Harry <harry.pan@intel.com> wrote:
>
> Hi Rafael,
>
> Yes, I skipped it considering to align CML-U V0 and A0 stepping w/ the same table; I sent v4 for your review.

Skipping that flag is risky, because it may cause some C-states to be
enabled on systems where they have not been validated (e.g. systems
shipping with other OSes which only use _CST C-states).  There were
problems related to that in the past which is one of the reasons for
adding _CST support to intel_idle.  use_acpi should be set for all new
platforms going forward as a rule.

> In the other hand, I am proposing using _CST as long term plan in CrOS dev teams.

That I obviously agree with. :-)


> > On Mar 4, 2020, at 17:53, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > ﻿On Tue, Mar 3, 2020 at 10:10 AM Harry Pan <harry.pan@intel.com> wrote:
> >>
> >> Add a general C-state table in order to support Comet Lake.
> >>
> >> Signed-off-by: Harry Pan <harry.pan@intel.com>
> >>
> >> ---
> >>
> >> drivers/idle/intel_idle.c | 7 +++++++
> >> 1 file changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> >> index d55606608ac8..05bce595fafe 100644
> >> --- a/drivers/idle/intel_idle.c
> >> +++ b/drivers/idle/intel_idle.c
> >> @@ -1067,6 +1067,11 @@ static const struct idle_cpu idle_cpu_dnv = {
> >>        .use_acpi = true,
> >> };
> >>
> >> +static const struct idle_cpu idle_cpu_cml = {
> >> +       .state_table = skl_cstates,
> >> +       .disable_promotion_to_c1e = true,
> >
> > .use_acpi = true,
> >
> > missing?  Otherwise you can just use idle_cpu_skl as is, can't you?
> >
> >> +};
> >> +
> >> static const struct x86_cpu_id intel_idle_ids[] __initconst = {
> >>        INTEL_CPU_FAM6(NEHALEM_EP,              idle_cpu_nhx),
> >>        INTEL_CPU_FAM6(NEHALEM,                 idle_cpu_nehalem),
> >> @@ -1105,6 +1110,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
> >>        INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS,      idle_cpu_bxt),
> >>        INTEL_CPU_FAM6(ATOM_GOLDMONT_D,         idle_cpu_dnv),
> >>        INTEL_CPU_FAM6(ATOM_TREMONT_D,          idle_cpu_dnv),
> >> +       INTEL_CPU_FAM6(COMETLAKE_L,             idle_cpu_cml),
> >> +       INTEL_CPU_FAM6(COMETLAKE,               idle_cpu_cml),
> >>        {}
> >> };
> >>
> >> --
> >> 2.24.1
> >>

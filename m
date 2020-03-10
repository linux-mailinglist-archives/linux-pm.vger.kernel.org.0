Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3127717F206
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 09:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgCJIh0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 10 Mar 2020 04:37:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36401 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgCJIh0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 04:37:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id j14so12376619otq.3;
        Tue, 10 Mar 2020 01:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DKzFIFLjLlsOT1OmyKxWh7fyVNk0UFpX9V9hd2JpLz4=;
        b=WBlIK/bCvECWvCwAjSGNxDscoq64evFLsKbyKqB5dJPRYy8liUDE+zfOMJTQS9Qj+F
         IbFG7Rs4kaL6AcsBxRof8k58RMyw2ySq5/8rVkuMML0X1c/Ro/F1NT3b/EyItgF7RzcX
         hqOB1xh3ZXsRiaBkPBMC7jj7sLlqiswYuleoA2m00keR1NXG3AzmJMG5XR67fzoyo2ES
         e66Ck4SG7lGbfgx5Yf3kfAzZobvecKTtMXR53/H5UfICPT1+nacJtnfUNTbvrskCTSnN
         nKn/S6sgBZhSICdvj3ORQ1tO3pdyugah4Lu54AQNEMp4Qva6LppQD/n4RSTiII1spxrE
         6MBQ==
X-Gm-Message-State: ANhLgQ3UQzqc5Uh3/Rm+oTTa/jfmCGKgiDYQIt98HFYX8JGzYCrQExXT
        EZCzqcXbH5wJ0hmXmBv8otnnNpXwN571WNiVafm9QF+z
X-Google-Smtp-Source: ADFU+vvNPIef0MecvLmJCFpMsoRoZypHjlU4iKA6axUtECduLpHHeWQxLr9C/RfVQG+s0ay6fqFKHVpBXbTkTmNP8u4=
X-Received: by 2002:a05:6830:110:: with SMTP id i16mr15503565otp.189.1583829445214;
 Tue, 10 Mar 2020 01:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200227013411.1.Ica3bb9fa898499d94e0b0a2bfa08ec46c89d84fa@changeid>
 <20200303170948.1.I108734f38ade020c3e5da825839dca11d2a2ff87@changeid>
 <CAJZ5v0j+bx5fh1wv738MNoui_SaZ-c21rDnZkWOqi_GCVg5stQ@mail.gmail.com>
 <F8C6368A-1537-482B-8FE5-350A18D936A8@intel.com> <CAJZ5v0iBMiGKeFXRTLkR8oFQbdCJq0TnhpFZkMBK4gF0VNjumA@mail.gmail.com>
 <6089B7674E6F464F847AB76B599E0EAA78AB6A98@PGSMSX102.gar.corp.intel.com>
In-Reply-To: <6089B7674E6F464F847AB76B599E0EAA78AB6A98@PGSMSX102.gar.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Mar 2020 09:37:14 +0100
Message-ID: <CAJZ5v0g6fAPZxX3MKGomjTWfWVMV-A+8yUC=ydOg5YwD-moDvQ@mail.gmail.com>
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

On Mon, Mar 9, 2020 at 10:07 AM Pan, Harry <harry.pan@intel.com> wrote:
>
> Hi Rafael,
>
> Thanks for the comments.
> I have some questions, I am wondering if you can share upstream thought w.r.t the future development of intel_idle.
>
>  - It looks to me since v5.6 intel_idle will prefer _CST of ACPI rather than the general table embedded in this driver.

Not exactly.

The rules are as follows:
 * If there is a built-in table for the given processor in the driver,
it will be used, but the C-states that are not exposed in _CST will be
disabled by default (the state parameters come from the built-in table
for all C-states).
 * Otherwise (i.e. the driver does not recognized the given
processor), C-state definitions will be based on the _CST data.

See https://www.kernel.org/doc/html/latest/admin-guide/pm/intel_idle.html
for details.

>  - Any pros and cons of using the tables of _CST in firmware and embedded one in the kernel?

Both can be used at the same time (see above).

The built-in table in the kernel must be suitable for all of the
platforms shipped with the given processor (SoC).

Obviously, the _CST table allows intel_idle to work if the processor
included in the platform is not recognized by it.

Generally, our planned strategy is to provide built-in C-state tables
for all new "mainstream" processors with the use_acpi flag set to
avoid enabling C-states that may have not been validated on a given
platform by default.

>  - Can the table in _CST archive more optimal idle states management?

Possibly, but not likely.

> If there is already any reference, documents I missed, kindly enlighten me then I would like to read it first before refining the questions.

See above. :-)

Thanks!


___________________________________
> 從: Rafael J. Wysocki [rafael@kernel.org]
> 寄件日期: 2020年3月5日 上午 05:14
> 至: Pan, Harry
> 副本: Rafael J. Wysocki; LKML; Harry Pan; Jacob Pan; Len Brown; Linux PM
> 主旨: Re: [PATCH v3] intel_idle: Add Comet Lake support
>
> On Wed, Mar 4, 2020 at 12:57 PM Pan, Harry <harry.pan@intel.com> wrote:
> >
> > Hi Rafael,
> >
> > Yes, I skipped it considering to align CML-U V0 and A0 stepping w/ the same table; I sent v4 for your review.
>
> Skipping that flag is risky, because it may cause some C-states to be
> enabled on systems where they have not been validated (e.g. systems
> shipping with other OSes which only use _CST C-states).  There were
> problems related to that in the past which is one of the reasons for
> adding _CST support to intel_idle.  use_acpi should be set for all new
> platforms going forward as a rule.
>
> > In the other hand, I am proposing using _CST as long term plan in CrOS dev teams.
>
> That I obviously agree with. :-)
>
>
> > > On Mar 4, 2020, at 17:53, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > ﻿On Tue, Mar 3, 2020 at 10:10 AM Harry Pan <harry.pan@intel.com> wrote:
> > >>
> > >> Add a general C-state table in order to support Comet Lake.
> > >>
> > >> Signed-off-by: Harry Pan <harry.pan@intel.com>
> > >>
> > >> ---
> > >>
> > >> drivers/idle/intel_idle.c | 7 +++++++
> > >> 1 file changed, 7 insertions(+)
> > >>
> > >> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> > >> index d55606608ac8..05bce595fafe 100644
> > >> --- a/drivers/idle/intel_idle.c
> > >> +++ b/drivers/idle/intel_idle.c
> > >> @@ -1067,6 +1067,11 @@ static const struct idle_cpu idle_cpu_dnv = {
> > >>        .use_acpi = true,
> > >> };
> > >>
> > >> +static const struct idle_cpu idle_cpu_cml = {
> > >> +       .state_table = skl_cstates,
> > >> +       .disable_promotion_to_c1e = true,
> > >
> > > .use_acpi = true,
> > >
> > > missing?  Otherwise you can just use idle_cpu_skl as is, can't you?
> > >
> > >> +};
> > >> +
> > >> static const struct x86_cpu_id intel_idle_ids[] __initconst = {
> > >>        INTEL_CPU_FAM6(NEHALEM_EP,              idle_cpu_nhx),
> > >>        INTEL_CPU_FAM6(NEHALEM,                 idle_cpu_nehalem),
> > >> @@ -1105,6 +1110,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
> > >>        INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS,      idle_cpu_bxt),
> > >>        INTEL_CPU_FAM6(ATOM_GOLDMONT_D,         idle_cpu_dnv),
> > >>        INTEL_CPU_FAM6(ATOM_TREMONT_D,          idle_cpu_dnv),
> > >> +       INTEL_CPU_FAM6(COMETLAKE_L,             idle_cpu_cml),
> > >> +       INTEL_CPU_FAM6(COMETLAKE,               idle_cpu_cml),
> > >>        {}
> > >> };
> > >>
> > >> --
> > >> 2.24.1
> > >>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03793220145
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 02:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGOANf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 20:13:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:47113 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgGOANe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jul 2020 20:13:34 -0400
IronPort-SDR: CtM1WORkacd972AGW0Obh+ilLGh5FpFSaMrYp/XaCxXmqbZyWbEdGzw3zGSddBmaqOuwnxzPqN
 enYvT6XRJcNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="210594433"
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; 
   d="scan'208";a="210594433"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 17:13:33 -0700
IronPort-SDR: PK7uvFFOTnYHCNwAm816+GkW7R98emeBsMeQ7hEr5zc8vpsrTpRdOnFz4YETKMDpX4Z4W5ksCN
 EVJ3G/ppb6kA==
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; 
   d="scan'208";a="485538272"
Received: from spandruv-mobl.amr.corp.intel.com ([10.255.228.223])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 17:13:32 -0700
Message-ID: <ec0336b09ccf932aef6bbe51fed1e79c864c55ea.camel@linux.intel.com>
Subject: Re: [PATCH v2] powercap: Add Power Limit4 support
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Date:   Tue, 14 Jul 2020 17:13:32 -0700
In-Reply-To: <CAJZ5v0hYv5TsAWduzaoErS2a2r6dn9vq2t_s4EJ47U7Dz-C50w@mail.gmail.com>
References: <1594715306-10411-1-git-send-email-sumeet.r.pawnikar@intel.com>
         <CAJZ5v0hYv5TsAWduzaoErS2a2r6dn9vq2t_s4EJ47U7Dz-C50w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-07-14 at 15:21 +0200, Rafael J. Wysocki wrote:
> > 

[...]

> On Tue, Jul 14, 2020 at 10:22 AM Sumeet Pawnikar
> <sumeet.r.pawnikar@intel.com> wrote:
> 
> Srinivas, does the patch look good to you?

Some minor comments then Summet can add my 

Reviewed-and-tested-by: Srinivas Pandruvada <
srinivas.pandruvada@linux.intel.com>

> > ---
> > Changes in v2:
> >  - Addressed review comments from Rafael.
> >  - Made the commit message more clearer.
> >  - Updated powercap documentation.
> > ---
> > 

[...]

> > 0,1).
> > +Depending on different power zones, the Intel RAPL technology
> > allows
> > +one or multiple constraints like short term, long term and peak
> > power,
> > +with different time windows to be applied to each power zone.
I think better to spell out that time window is not applicable to "peak
power". Otherwise someone will send a bug report.


[...]

> >  static int rapl_msr_probe(struct platform_device *pdev)
> >  {
> >         int ret;
> > +       const struct x86_cpu_id *id =
> > x86_match_cpu(pl4_support_ids);

To match coding style in this file:
	const struct x86_cpu_id *id = x86_match_cpu(pl4_support_ids);
        int ret;

> >         rapl_msr_priv.read_raw = rapl_msr_read_raw;

Thanks,
Srinivas


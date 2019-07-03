Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 265785DF7C
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 10:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfGCIOH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 04:14:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:64810 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbfGCIOH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 04:14:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 01:14:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="154679688"
Received: from zhongyan-mobl.ccr.corp.intel.com ([10.249.170.124])
  by orsmga007.jf.intel.com with ESMTP; 03 Jul 2019 01:14:04 -0700
Message-ID: <1562141642.3256.6.camel@intel.com>
Subject: Re: [PATCH 04/13] intel_rapl: introduce struct rapl_private
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Date:   Wed, 03 Jul 2019 16:14:02 +0800
In-Reply-To: <CAJZ5v0he3Qs_nZmTN9fcgVAnurwXOb+Dj+NnTvUqT8TCH3oNHQ@mail.gmail.com>
References: <1561701029-3415-1-git-send-email-rui.zhang@intel.com>
         <1561701029-3415-5-git-send-email-rui.zhang@intel.com>
         <CAJZ5v0he3Qs_nZmTN9fcgVAnurwXOb+Dj+NnTvUqT8TCH3oNHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 二, 2019-07-02 at 23:44 +0200, Rafael J. Wysocki wrote:
> On Fri, Jun 28, 2019 at 7:50 AM Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > 
> > Introduce a new structure, rapl_private, to save the private data
> > for different RAPL Interface.
> The new structure is called rapl_priv in the patch.
> 
> Besides, I would call it rapl_if_priv to indicate that this related
> to
> an interface.
> 
> Also, IMO there should be a kerneldoc comment for it.
> 
okay.
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/powercap/intel_rapl.c | 58 +++++++++++++++++++++--------
> > --------------
> >  include/linux/intel_rapl.h    |  7 ++++++
> >  2 files changed, 35 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/powercap/intel_rapl.c
> > b/drivers/powercap/intel_rapl.c
> > index adb35ec..a804370 100644
> > --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@ -75,6 +75,8 @@ enum unit_type {
> >         TIME_UNIT,
> >  };
> > 
> > +static struct rapl_priv rapl_msr_priv;
> Please add a comment describing this variable and its role.
> 
> BTW, I'd rather call it rapl_if_msr.
> 
> > 
> > +
> >  /* per domain data, some are optional */
> >  #define NR_RAW_PRIMITIVES (NR_RAPL_PRIMITIVES - 2)
> > 
> > @@ -155,17 +157,14 @@ static const char * const rapl_domain_names[]
> > = {
> >         "psys",
> >  };
> > 
> > -static struct powercap_control_type *control_type; /* PowerCap
> > Controller */
> > -static struct rapl_domain *platform_rapl_domain; /* Platform
> > (PSys) domain */
> Why do these things need to go into rapl_priv?
> 
different RAPL interface may have its own control_type,
"intel_rapl_msr" vs. "intel_rapl_mmio".

MMIO RAPL interface does not have platform rapl domain so far, but
given that the current platform rapl domain uses
MSR_PLATFORM_POWER_LIMIT and MSR_PLATFORM_ENERGY_STATUS.
I made it part of MSR RAPL interface driver.

thanks,
rui

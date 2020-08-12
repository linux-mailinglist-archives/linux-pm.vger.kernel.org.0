Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A928A24244A
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 05:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHLD3S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 23:29:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:7518 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgHLD3R (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Aug 2020 23:29:17 -0400
IronPort-SDR: /7J+l1MoZ5JBa6MEkb/MqhzHG2A0gAyXIqZkOIkFqXVVBhTt6SxmAsFMXzWCNnRs9MMrFd12FP
 3gFczto2laBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="171920306"
X-IronPort-AV: E=Sophos;i="5.76,302,1592895600"; 
   d="scan'208";a="171920306"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 20:29:12 -0700
IronPort-SDR: 1x5ar2IoxHPK6E5QFOa/BOF8uldjd4mlwpX0kDzWCj6/gzr0PW+53qIwkIO6J3+PgurAT2yu1R
 /hG16jfPhW0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,302,1592895600"; 
   d="scan'208";a="439261099"
Received: from wangbolu-mobl1.ccr.corp.intel.com ([10.255.29.211])
  by orsmga004.jf.intel.com with ESMTP; 11 Aug 2020 20:29:07 -0700
Message-ID: <d7a19f05497b4137bacd639e576b7166e4a19842.camel@intel.com>
Subject: Re: [PATCH v2 2/3] perf/x86/rapl: Support multiple rapl unit quirks
From:   Zhang Rui <rui.zhang@intel.com>
To:     Joe Perches <joe@perches.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org
Cc:     linux-pm@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, len.brown@intel.com, rafael@kernel.org
Date:   Wed, 12 Aug 2020 11:29:06 +0800
In-Reply-To: <445d4b9039daca40a4d937959a0bc48ffe347f7f.camel@perches.com>
References: <20200811153149.12242-1-rui.zhang@intel.com>
         <20200811153149.12242-3-rui.zhang@intel.com>
         <445d4b9039daca40a4d937959a0bc48ffe347f7f.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Thanks for reviewing.

On Tue, 2020-08-11 at 11:19 -0700, Joe Perches wrote:
> On Tue, 2020-08-11 at 23:31 +0800, Zhang Rui wrote:
> > There will be more platforms with different fixed energy units.
> > Enhance the code to support different rapl unit quirks for
> > different
> > platforms.
> 
> This seems like one quirk per platform.
> 
> Should multiple quirks on individual platforms be supported?
> 
enum rapl_unit_quirk is just used as a flag.
multiple quirks can be deployed with the same flag, just like what I
did in patch 3/3.
Also different platforms can either have different flags or share the
same flag.

thanks,
rui

> > diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> 
> []
> > @@ -130,11 +130,16 @@ struct rapl_pmus {
> >  	struct rapl_pmu		*pmus[];
> >  };
> >  
> > +enum rapl_unit_quirk {
> > +	RAPL_UNIT_QUIRK_NONE,
> > +	RAPL_UNIT_QUIRK_INTEL_HSW,
> > +};
> > +
> >  struct rapl_model {
> >  	struct perf_msr *rapl_msrs;
> >  	unsigned long	events;
> >  	unsigned int	msr_power_unit;
> > -	bool		apply_quirk;
> > +	enum rapl_unit_quirk	unit_quirk;
> >  };
> 
> 


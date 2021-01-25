Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7603028D8
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 18:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbhAYR1u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 12:27:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:21034 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730981AbhAYR1h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Jan 2021 12:27:37 -0500
IronPort-SDR: 9EcIq+Q7kuJrGLL0ghRuoEQxhc2rpzoNG0Rm4RwDUGtoz0zeEOlDwCSa4a/h3BAyAPn93BxjwO
 1YY13Bj9NJQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="158942365"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="158942365"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 09:25:49 -0800
IronPort-SDR: Q5OdDHAYMwgZ213hUE/9bgoy54CgaXSoWVO6cQ2eONVJNEDt2+qwEUX8ZkHFyYZVxSmMXyo4gF
 It1r3DmKVxHA==
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="406334762"
Received: from nhawacha-mobl1.amr.corp.intel.com ([10.209.73.20])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 09:25:49 -0800
Message-ID: <1c0aa438b89eef3681e782d4187422eaf3cd86cb.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] thermal: Move therm_throt there from x86/mce
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Zhang Rui <rui.zhang@intel.com>, X86 ML <x86@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Mon, 25 Jan 2021 09:25:48 -0800
In-Reply-To: <20210125171845.GJ23070@zn.tnic>
References: <20210125130533.19938-1-bp@alien8.de>
         <20210125130533.19938-3-bp@alien8.de>
         <b0e54fbb8c8b9fea38152bbf179135a6434340d7.camel@intel.com>
         <9ee4051f627dd91020139b1d077a1fb01565d670.camel@linux.intel.com>
         <20210125171845.GJ23070@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-01-25 at 18:18 +0100, Borislav Petkov wrote:
> On Mon, Jan 25, 2021 at 09:14:35AM -0800, Srinivas Pandruvada wrote:
> > Can the handler, processing architectural features via thermal
> > interrupt, reside in arch/x86 folder or need to be
> > drivers/thermal/intel?
> 
> Look at...
> 
> > > > @@ -718,7 +699,7 @@ void intel_init_thermal(struct cpuinfo_x86
> > > > *c)
> > > >  				|
> > > > PACKAGE_THERM_INT_HIGH_ENABLE), h);
> > > >  	}
> > > >  
> > > > -	smp_thermal_vector = intel_thermal_interrupt;
> > > > +	thermal_set_handler(intel_thermal_interrupt);
> 
> ... here. ^
> 
> This should answer your question.

Thanks for the answer.

-Srinivas


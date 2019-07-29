Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19E1F78AE2
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 13:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbfG2Lup (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 07:50:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:6396 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387482AbfG2Lup (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 07:50:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 04:50:45 -0700
X-IronPort-AV: E=Sophos;i="5.64,322,1559545200"; 
   d="scan'208";a="171544231"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.107.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 04:50:41 -0700
Message-ID: <6be021a31eb9a7976b2347dd3ac3cd7f10c8d71f.camel@linux.intel.com>
Subject: Re: [PATCH][next] drivers: thermal: processor_thermal_device: fix
 missing bitwise-or operator
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Colin Ian King <colin.king@canonical.com>, wharms@bfs.de
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 29 Jul 2019 04:50:40 -0700
In-Reply-To: <0cfe48bb-d97f-86d3-db4b-fdd864197b69@canonical.com>
References: <20190729102930.2956-1-colin.king@canonical.com>
         <5D3ED780.7010407@bfs.de>
         <0cfe48bb-d97f-86d3-db4b-fdd864197b69@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2019-07-29 at 12:29 +0100, Colin Ian King wrote:
> On 29/07/2019 12:24, walter harms wrote:
> > 
> > 
> > Am 29.07.2019 12:29, schrieb Colin King:
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > The variable val is having the top 8 bits cleared and then the
> > > variable
> > > is being re-assinged and setting just the top 8 bits.  I believe
> > > the
> > > intention was bitwise-or in the top 8 bits.  Fix this by
> > > replacing
> > > the = operator with |= instead.
> > > 
> > > Addresses-Coverity: ("Unused value")
> > > Fixes: b0c74b08517e ("drivers: thermal: processor_thermal_device:
> > > Export sysfs inteface for TCC offset")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  .../thermal/intel/int340x_thermal/processor_thermal_device.c    
> > > | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git
> > > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.
> > > c
> > > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.
> > > c
> > > index 6f6ac6a8e82d..cb22317911ef 100644
> > > ---
> > > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.
> > > c
> > > +++
> > > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.
> > > c
> > > @@ -164,7 +164,7 @@ static int tcc_offset_update(int tcc)
> > >  		return err;
> > >  
> > >  	val = ~GENMASK_ULL(31, 24);
> > > -	val = (tcc & 0xff) << 24;
> > > +	val |= (tcc & 0xff) << 24;
> > >  
> > 
> > I do not think that GENMASK makes sence here.
> 
> Yeah, val &= ~GENMASK_ULL(31, 24)
> 
> I'll send a V2
> 
Thanks Colin for the fix.

-Srinivas
> 
> > 
> > re,
> >  wh
> > 
> > >  	err = wrmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, val);
> > >  	if (err)
> 
> 


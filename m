Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFEBE91D26
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 08:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHSGcw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 02:32:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:51118 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfHSGcw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Aug 2019 02:32:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Aug 2019 23:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="202150762"
Received: from rzhang-dell-9360.sh.intel.com ([10.239.198.73])
  by fmsmga004.fm.intel.com with ESMTP; 18 Aug 2019 23:32:50 -0700
Message-ID: <95dce698e7790dac7178e950a6a9dde71d231cae.camel@intel.com>
Subject: Re: [PATCH][V2] drivers: thermal: processor_thermal_device: fix
 missing bitwise-or operators
From:   Zhang Rui <rui.zhang@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Colin King <colin.king@canonical.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 19 Aug 2019 14:32:43 +0800
In-Reply-To: <42db46c33466a12221e0968e82c4c4ee17b0341d.camel@linux.intel.com>
References: <20190729120323.15838-1-colin.king@canonical.com>
         <42db46c33466a12221e0968e82c4c4ee17b0341d.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2019-07-29 at 14:09 -0700, Srinivas Pandruvada wrote:
> On Mon, 2019-07-29 at 13:03 +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The variable val is having the top 8 bits cleared and then the
> > variable is being
> > re-assinged and setting just the top 8 bits.  I believe the
> > intention
> > was bitwise-or
> > in the top 8 bits.  Fix this by replacing the = operators with &=
> > and
> > > = instead.
> > 
> > Addresses-Coverity: ("Unused value")
> > Fixes: b0c74b08517e ("drivers: thermal: processor_thermal_device:
> > Export sysfs inteface for TCC offset")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com
> >

Hi, Colin,

thanks for the fix, as b0c74b08517e ("drivers: thermal:
processor_thermal_device: Export sysfs inteface for TCC offset") has
not been shipped in upstream yet, I will fold this fix into the
original patch directly.

thanks,
rui
> 
> > ---
> > 
> > V2: Add in &= operator missing from V1. Doh.
> > 
> > ---
> >  .../thermal/intel/int340x_thermal/processor_thermal_device.c  | 4
> > ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > index 6f6ac6a8e82d..97333fc4be42 100644
> > ---
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > +++
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > @@ -163,8 +163,8 @@ static int tcc_offset_update(int tcc)
> >  	if (err)
> >  		return err;
> >  
> > -	val = ~GENMASK_ULL(31, 24);
> > -	val = (tcc & 0xff) << 24;
> > +	val &= ~GENMASK_ULL(31, 24);
> > +	val |= (tcc & 0xff) << 24;
> >  
> >  	err = wrmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, val);
> >  	if (err)
> 
> 


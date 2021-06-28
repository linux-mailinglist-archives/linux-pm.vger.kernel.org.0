Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C735E3B6AA2
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 23:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhF1WBh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Jun 2021 18:01:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:6006 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233976AbhF1WBb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Jun 2021 18:01:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="208080273"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="208080273"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 14:59:04 -0700
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="407904243"
Received: from brianjoh-mobl.amr.corp.intel.com ([10.209.104.245])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 14:59:04 -0700
Message-ID: <2a87ca4a56b85c291c4ec5948ae4176f5a69c623.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: int340x: processor_thermal: Fix tcc setting
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 28 Jun 2021 14:59:03 -0700
In-Reply-To: <649bc24b-331d-9ffd-e374-18eed5555816@linaro.org>
References: <20210628201012.68642-1-srinivas.pandruvada@linux.intel.com>
         <649bc24b-331d-9ffd-e374-18eed5555816@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-06-28 at 22:42 +0200, Daniel Lezcano wrote:
> On 28/06/2021 22:10, Srinivas Pandruvada wrote:
> > The following fixes are done for tcc sysfs interface:
> > - TCC is 6 bits only from bit 29-24
> > - TCC of 0 is valid
> > - When BIT(31) is set, this register is read only
> > - Check for invalid tcc value
> > - Error for negative values
> > 
> 
> Fixes: fdf4f2fb8e899 ("Export sysfs interface for TCC")
> 
> ?
Sent again with Fixes tag and cc stable.

Thanks,
Srinivas

> 
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com>
> > ---
> >  .../processor_thermal_device.c                | 20 +++++++++++----
> > ----
> >  1 file changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > index de4fc640deb0..0f0038af2ad4 100644
> > ---
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > +++
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > @@ -78,24 +78,27 @@ static ssize_t
> > tcc_offset_degree_celsius_show(struct device *dev,
> >         if (err)
> >                 return err;
> >  
> > -       val = (val >> 24) & 0xff;
> > +       val = (val >> 24) & 0x3f;
> >         return sprintf(buf, "%d\n", (int)val);
> >  }
> >  
> > -static int tcc_offset_update(int tcc)
> > +static int tcc_offset_update(unsigned int tcc)
> >  {
> >         u64 val;
> >         int err;
> >  
> > -       if (!tcc)
> > +       if (tcc > 63)
> >                 return -EINVAL;
> >  
> >         err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
> >         if (err)
> >                 return err;
> >  
> > -       val &= ~GENMASK_ULL(31, 24);
> > -       val |= (tcc & 0xff) << 24;
> > +       if (val & BIT(31))
> > +               return -EPERM;
> > +
> > +       val &= ~GENMASK_ULL(29, 24);
> > +       val |= (tcc & 0x3f) << 24;
> >  
> >         err = wrmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, val);
> >         if (err)
> > @@ -104,14 +107,15 @@ static int tcc_offset_update(int tcc)
> >         return 0;
> >  }
> >  
> > -static int tcc_offset_save;
> > +static unsigned int tcc_offset_save;
> >  
> >  static ssize_t tcc_offset_degree_celsius_store(struct device *dev,
> >                                 struct device_attribute *attr,
> > const char *buf,
> >                                 size_t count)
> >  {
> > +       unsigned int tcc;
> >         u64 val;
> > -       int tcc, err;
> > +       int err;
> >  
> >         err = rdmsrl_safe(MSR_PLATFORM_INFO, &val);
> >         if (err)
> > @@ -120,7 +124,7 @@ static ssize_t
> > tcc_offset_degree_celsius_store(struct device *dev,
> >         if (!(val & BIT(30)))
> >                 return -EACCES;
> >  
> > -       if (kstrtoint(buf, 0, &tcc))
> > +       if (kstrtouint(buf, 0, &tcc))
> >                 return -EINVAL;
> >  
> >         err = tcc_offset_update(tcc);
> > 
> 
> 



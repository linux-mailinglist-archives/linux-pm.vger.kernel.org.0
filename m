Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0AE2964D8
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 20:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369604AbgJVSvA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 14:51:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:4042 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900104AbgJVSvA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Oct 2020 14:51:00 -0400
IronPort-SDR: DxJGAI4pPgtfL92gkoEkNTj9FEMrk2A+LUrrOd85pVmMH5qg6B/WtIfldq8rCGQcS1iva0TXH+
 5R9ngU/RuCGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="166794624"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="166794624"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 11:50:59 -0700
IronPort-SDR: SsIR/EaZs7+GXJcbJhLWhCvU/2vnQODdSIAq5PLynYjpFI+R/HD7pjtT4S55ceI7LJewXCrmY1
 hM25LrCqvqZg==
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="302426113"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 11:50:58 -0700
Date:   Fri, 23 Oct 2020 02:53:20 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][v2] PM / sysfs: Expose suspend resume driver flags in
 sysfs
Message-ID: <20201022185320.GA8811@chenyu-office.sh.intel.com>
References: <20201022085244.1860-1-yu.c.chen@intel.com>
 <CAHp75Vf52m78FNKgTQ8c_y6UNaR91ANZh296tg6nz+reEv0DEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf52m78FNKgTQ8c_y6UNaR91ANZh296tg6nz+reEv0DEg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Andy,
On Thu, Oct 22, 2020 at 04:36:25PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 22, 2020 at 12:24 PM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > Currently there are 4 driver flags to control system suspend/resume
> > behavior: DPM_FLAG_NO_DIRECT_COMPLETE, DPM_FLAG_SMART_PREPARE,
> > DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME. Make these flags
> > visible in sysfs as read-only to get a brief understanding of the
> > expected behavior of each device during suspend/resume, so as to
> > facilitate suspend/resume debugging/tuning.
> >
> > For example:
> > /sys/devices/pci0000:00/0000:00:15.1/power/driver_flags:4
> > (DPM_FLAG_SMART_SUSPEND)
> >
> > /sys/devices/pci0000:00/0000:00:07.3/power/driver_flags:5
> > (DPM_FLAG_NO_DIRECT_COMPLETE | DPM_FLAG_SMART_SUSPEND)
> 
> ...
> 
> > +What:          /sys/devices/.../power/driver_flags
> > +Date:          October 2020
> > +Contact:       Chen Yu <yu.c.chen@intel.com>
> > +Description:
> > +               The /sys/devices/.../driver_flags attribute contains the driver
> > +               flags to control system suspend/resume. The flag is a combination
> > +               of DPM_FLAG_NO_DIRECT_COMPLETE, DPM_FLAG_SMART_PREPARE,
> > +               DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME, or 0 if the
> > +               driver has not set any flag.
> 
> > This attribute is read-only. If
> > +               CONFIG_PM_ADVANCED_DEBUG is not set this attribute is empty.
> 
> Which makes me wonder why we even expose this if the above is not set.
> 
> ...
> 
It will not be exposed if the config is disabled. 'empty' means
'not present' I think.
> > +static struct attribute *pm_driver_flags_attrs[] = {
> > +#ifdef CONFIG_PM_ADVANCED_DEBUG
> > +#ifdef CONFIG_PM_SLEEP
> > +       &dev_attr_driver_flags.attr,
> > +#endif
> > +#endif
> 
> > +       NULL,
> 
> No comma here, please. I think I commented on this internally.
> 
Sorry I misunderstood your point previously, I can change in next
version. But might need to wait for Greg to decide if this item
should be exposed or not first.

Thanks,
Chenyu
> > +};
> 
> -- 
> With Best Regards,
> Andy Shevchenko

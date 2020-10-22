Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2AA29581A
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 07:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508058AbgJVFtR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 01:49:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:11633 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508056AbgJVFtR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Oct 2020 01:49:17 -0400
IronPort-SDR: awULbn5bN84PHblpUU1bT4InUmMPRpuOKHNETT38cHZ36kr5bOngsjeGn85yao9feeZfdDEtoO
 LYBkIoX9cE5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="164883297"
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; 
   d="scan'208";a="164883297"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 22:49:17 -0700
IronPort-SDR: QaQM5PLoJt5HoYm0mvpsC1Nn+HcHHSLkEXRwVVy5YOAl+a1ibjroc5hFHX1vZuGjzguUapQYOY
 D5QYRezgvHQg==
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; 
   d="scan'208";a="533814761"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 22:49:15 -0700
Date:   Thu, 22 Oct 2020 13:51:37 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / sysfs: Expose suspend resume driver flags in sysfs
Message-ID: <20201022055137.GA29165@chenyu-office.sh.intel.com>
References: <20201022032324.25308-1-yu.c.chen@intel.com>
 <20201022053143.GB6523@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022053143.GB6523@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,
thanks for taking a look at this.
On Thu, Oct 22, 2020 at 07:31:43AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 22, 2020 at 11:23:24AM +0800, Chen Yu wrote:
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
> > 
> > Acked-by: Len Brown <len.brown@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  drivers/base/power/sysfs.c | 29 ++++++++++++++++++++++++++++-
> >  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> There is no Documentataion/ABI/ entry for your new file, which makes
> this patch impossible to properly review by anyone, and prevents it from
> being able to be accepted.
> 
> Please fix.
> 
Okay, will add the entry in the document.

thanks,
Chenyu
> thanks,
> 
> greg k-h

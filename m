Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6624C1A2DC7
	for <lists+linux-pm@lfdr.de>; Thu,  9 Apr 2020 04:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgDIC5F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 22:57:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:29832 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgDIC5F (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Apr 2020 22:57:05 -0400
IronPort-SDR: tL3dWqINCh3n1DZK/VG3UIb5vbMFy/pUm/c9iV5re8KwcU56Rkos4j48g3pJiwApgVr30btJnm
 oYKrxhG0zkRg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 19:57:05 -0700
IronPort-SDR: k7AbT3M+cMSTRr6afs4LdO0sFjIeeILTRxjaptE7pLEK8e6TpZsPyfkYosnMiiHHGyff2W5Fzj
 01aXvApJIkbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,361,1580803200"; 
   d="scan'208";a="453021776"
Received: from yanbingj-mobl1.ccr.corp.intel.com ([10.249.174.232])
  by fmsmga006.fm.intel.com with ESMTP; 08 Apr 2020 19:57:04 -0700
Message-ID: <29e7030aad09473b67e32bc6c5e0a5ba8aa55213.camel@intel.com>
Subject: Re: [RFC PATCH 3/5] thermal: support statistics table resizing at
 runtime
From:   Zhang Rui <rui.zhang@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Date:   Thu, 09 Apr 2020 10:57:03 +0800
In-Reply-To: <s5himias43z.wl-tiwai@suse.de>
References: <20200408041917.2329-1-rui.zhang@intel.com>
         <20200408041917.2329-3-rui.zhang@intel.com> <s5himias43z.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-04-08 at 11:45 +0200, Takashi Iwai wrote:
> On Wed, 08 Apr 2020 06:19:15 +0200,
> Zhang Rui wrote:
> > 
> > Introduce thermal_cdev_stats_update_max() which can be used to
> > update
> > the cooling device statistics table when maximum cooling state of a
> > cooling device is changed.
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> Just a couple of small nitpicking:
> 
> > @@ -787,6 +791,23 @@ void thermal_cdev_stats_update_cur(struct
> > thermal_cooling_device *cdev,
> >  	spin_unlock(&stats->lock);
> >  }
> >  
> > +void thermal_cdev_stats_update_max(struct thermal_cooling_device
> > *cdev)
> > +{
> > +	struct cooling_dev_stats *stats = cdev->stats;
> > +	unsigned long cur_state, max_state;
> > +
> > +	if (!stats)
> > +		return;
> > +
> > +	if (cdev->ops->get_max_state(cdev, &max_state))
> > +		return;
> > +
> > +	if (cdev->ops->get_cur_state(cdev, &cur_state))
> > +		return;
> > +
> > +	cooling_device_stats_resize(cdev, cur_state, max_state);
> > +}
> 
> Don't we need to export this?

Oh, right, will fix this.
> 
> > @@ -946,7 +975,15 @@ static void cooling_device_stats_setup(struct
> > thermal_cooling_device *cdev)
> >  	cdev->stats = stats;
> >  	spin_lock_init(&stats->lock);
> >  
> > -	ret = cooling_device_stats_resize(cdev);
> > +	ret = cdev->ops->get_max_state(cdev, &max_state);
> > +	if (ret)
> > +		return;
> > +
> > +	/**
> > +	 *  cooling device current state will be updated soon
> > +	 *  during registration
> > +	 **/
> 
> This comment style is confusing as if a kernel-doc.
> 
will fix it in next version.

thanks,
rui
> 
> thanks,
> 
> Takashi


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58412B5E3B
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 12:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgKQL1x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 06:27:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:1082 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgKQL1x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Nov 2020 06:27:53 -0500
IronPort-SDR: 5cLWV8aVxJr1wx73M7yifHYrpfjBzwjJ0efANfihBlp4uG8uRr3Kwz4J4rLGPHwjvl2PuTl6ne
 P6SXBCAzxjww==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="188961214"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="188961214"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 03:27:52 -0800
IronPort-SDR: dG1ny2XRRY/+PJJPjr68EMmoLNYp7HC3dGGtUVrmxGNxJadnv2NJr5ZmpnPZ5JCtnw3qcgPK+G
 4sglLFud5/AA==
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="544009964"
Received: from lil6-mobl1.ccr.corp.intel.com ([10.255.30.220])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 03:27:50 -0800
Message-ID: <fd11744b16a91428303fe848ef8f72fd8f5c9a5e.camel@intel.com>
Subject: Re: [PATCH] thermal: Fix NULL pointer dereference issue
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mukesh Ojha <mojha@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     amitk@kernel.org
Date:   Tue, 17 Nov 2020 19:27:47 +0800
In-Reply-To: <f8c436ae-0f4c-5d2e-51a8-0e856fbf8f44@linaro.org>
References: <1605544181-5348-1-git-send-email-mojha@codeaurora.org>
         <4e28affd89ba8a852e0fb7ace076458b3d43839a.camel@intel.com>
         <f8c436ae-0f4c-5d2e-51a8-0e856fbf8f44@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-11-17 at 09:57 +0100, Daniel Lezcano wrote:
> On 17/11/2020 08:18, Zhang Rui wrote:
> > On Mon, 2020-11-16 at 21:59 +0530, Mukesh Ojha wrote:
> > > Cooling stats variable inside
> > > thermal_cooling_device_stats_update()
> > > can get NULL. We should add a NULL check on stat inside for
> > > sanity.
> > > 
> > > Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> > > ---
> > >  drivers/thermal/thermal_sysfs.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/thermal/thermal_sysfs.c
> > > b/drivers/thermal/thermal_sysfs.c
> > > index a6f371f..f52708f 100644
> > > --- a/drivers/thermal/thermal_sysfs.c
> > > +++ b/drivers/thermal/thermal_sysfs.c
> > > @@ -754,6 +754,9 @@ void
> > > thermal_cooling_device_stats_update(struct
> > > thermal_cooling_device *cdev,
> > >  {
> > >  	struct cooling_dev_stats *stats = cdev->stats;
> > >  
> > > +	if (!stats)
> > > +		return;
> > > +
> > 
> > May I know in which case stats can be NULL?
> > The only possibility I can see is that cdev->ops->get_max_state()
> > fails
> > in cooling_device_stats_setup(), right?
> 
> A few lines below, the allocation could fail.
> 
>         stats = kzalloc(var, GFP_KERNEL);
>         if (!stats)
>                 return;
> 
> Some drivers define themselves as a cooling device state to let the
> userspace to act on their power. The screen brightness is one example
> with a cdev with 1024 states, the resulting stats table to be
> allocated
> is very big and the kzalloc is prone to fail.
> 
Oh, right.
As we're not going to fix the cdev, so I think we do need this patch,
right?

thanks,
rui
> > thanks,
> > rui
> > 
> > >  	spin_lock(&stats->lock);
> > >  
> > >  	if (stats->state == new_state)
> 
> 


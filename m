Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD9A2CBBE9
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 12:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgLBLt5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 06:49:57 -0500
Received: from foss.arm.com ([217.140.110.172]:37166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgLBLt5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Dec 2020 06:49:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3C03101E;
        Wed,  2 Dec 2020 03:49:11 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64CC13F718;
        Wed,  2 Dec 2020 03:49:11 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:49:10 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, daniel.lezcano@linaro.org,
        orjan.eide@arm.com, robh@kernel.org,
        alyssa.rosenzweig@collabora.com, steven.price@arm.com,
        airlied@linux.ie, daniel@ffwll.ch
Subject: Re: [PATCH v2 3/5] thermal: devfreq_cooling: add new registration
 functions with Energy Model
Message-ID: <20201202114909.GA1198@arm.com>
References: <20201118120358.17150-1-lukasz.luba@arm.com>
 <20201118120358.17150-4-lukasz.luba@arm.com>
 <20201202102439.GA1639@arm.com>
 <ef641466-cf86-85aa-925a-3de9e1eed501@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef641466-cf86-85aa-925a-3de9e1eed501@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 02 Dec 2020 at 11:14:02 (+0000), Lukasz Luba wrote:
> Hi Ionela,
> 
> On 12/2/20 10:24 AM, Ionela Voinescu wrote:
> > Hi Lukasz,
> > 
> > On Wednesday 18 Nov 2020 at 12:03:56 (+0000), Lukasz Luba wrote:
> 
> [snip]
> 
> > > +	struct device_node *np = NULL;
> 
> [snip]
> 
> > > +
> > > +	if (dev->of_node)
> > > +		np = of_node_get(dev->of_node);
> > > +
> > 
> > Should np be checked before use? I'm not sure if it's better to do the
> > assign first and then the check on np before use. It depends on the
> > consequences of passing a NULL node pointer later on.
> 
> The np is actually dev->of_node (or left NULL, as set at the begging).
> The only meaning of the line above is to increment the counter and then
> decrement if CONFIG_OF_DYNAMIC was used.
> The devfreq_cooling_register() has np = NULL and the registration can
> handle it, so we should be OK here as well.
> 

Yes, I just wanted to make sure later registration can handle np = NULL,
or whether we need to bail out.

In this case, you can drop both ifs - for (dev->of_node) before get and
for np before put below, as of_node_get/of_node_put can handle NULL
pointers themselves.

Thanks,
Ionela.

> > 
> > > +	cdev = of_devfreq_cooling_register_power(np, df, dfc_power);
> > > +
> > > +	if (np)
> > > +		of_node_put(np);
> > > +
> 
> [snip]
> 
> > > 
> > 
> > Otherwise it looks good to me:
> > 
> > Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> 
> Thank you for the review.
> 
> Regards,
> Lukasz
> 
> > 
> > Ionela.
> > 

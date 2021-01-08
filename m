Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C092EEDCA
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 08:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbhAHHTw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 02:19:52 -0500
Received: from muru.com ([72.249.23.125]:41154 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbhAHHTw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Jan 2021 02:19:52 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 200AE80B4;
        Fri,  8 Jan 2021 07:19:31 +0000 (UTC)
Date:   Fri, 8 Jan 2021 09:19:02 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Adam Ford <aford173@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/3] thermal: ti-soc-thermal: Fix stuck sensor with
 continuous mode for 4430
Message-ID: <X/gHZp9BtXF1N0mT@atomide.com>
References: <20201230084338.19410-1-tony@atomide.com>
 <f108ac41-b38f-2d19-97ee-aaa5a7fdd1cc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f108ac41-b38f-2d19-97ee-aaa5a7fdd1cc@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Péter Ujfalusi <peter.ujfalusi@gmail.com> [201231 12:55]:
> On 12/30/20 10:43 AM, Tony Lindgren wrote:
> > @@ -58,7 +58,8 @@ omap4430_adc_to_temp[OMAP4430_ADC_END_VALUE - OMAP4430_ADC_START_VALUE + 1] = {
> >  const struct ti_bandgap_data omap4430_data = {
> >  	.features = TI_BANDGAP_FEATURE_MODE_CONFIG |
> >  			TI_BANDGAP_FEATURE_CLK_CTRL |
> > -			TI_BANDGAP_FEATURE_POWER_SWITCH,
> > +			TI_BANDGAP_FEATURE_POWER_SWITCH |
> > +			TI_BANDGAP_FEATURE_CONT_MODE_ONLY,
> 
> Can we add a comment with the observations?

Sure, and I also noticed that the timeout triggers also on dra7
too. I need to recheck what all are affected.. At least we now
see warnings on the SoCs affected.

> > @@ -605,8 +606,10 @@ ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
> >  	u32 counter = 1000;
> >  	struct temp_sensor_registers *tsr;
> >  
> > -	/* Select single conversion mode */
> > -	if (TI_BANDGAP_HAS(bgp, MODE_CONFIG))
> > +	/* Select continuous or single conversion mode */
> > +	if (TI_BANDGAP_HAS(bgp, CONT_MODE_ONLY))
> > +		RMW_BITS(bgp, id, bgap_mode_ctrl, mode_ctrl_mask, 1);
> > +	else if (TI_BANDGAP_HAS(bgp, MODE_CONFIG))
> >  		RMW_BITS(bgp, id, bgap_mode_ctrl, mode_ctrl_mask, 0);
> 
> Would not be better to:
> if (TI_BANDGAP_HAS(bgp, MODE_CONFIG)) {
> 	if (TI_BANDGAP_HAS(bgp, CONT_MODE_ONLY))
> 		RMW_BITS(bgp, id, bgap_mode_ctrl, mode_ctrl_mask, 1);
> 	else
> 		RMW_BITS(bgp, id, bgap_mode_ctrl, mode_ctrl_mask, 0);
> }
> 
> One can only switch to cont/single mode if the mode config is possible.

Yup makes sense thanks for spotting that.

Regards,

Tony

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F662D1A30
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 22:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJIU5E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 16:57:04 -0400
Received: from muru.com ([72.249.23.125]:36442 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731158AbfJIU5E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Oct 2019 16:57:04 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9D2518140;
        Wed,  9 Oct 2019 20:57:36 +0000 (UTC)
Date:   Wed, 9 Oct 2019 13:56:59 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH] power: supply: cpcap-charger: Limit voltage to 4.2V for
 battery
Message-ID: <20191009205659.GR5610@atomide.com>
References: <20191009203355.5622-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009203355.5622-1-tony@atomide.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [191009 13:34]:
> This is against v5.3 so it can be easily picked for earlier kernels as
> needed. If no changes needed, this is best applied on v5.3 and then merged
> into v5.4-rc based branch as this will cause a minor merge conflict with
> v5.4-rc because of 7f7378618b41 ("power: supply: cpcap-charger: Enable vbus
> boost voltage").

And below is the merge resolution I used for reference.

Regards,

Tony

8< ---------------------
diff --cc drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@@ -447,9 -515,48 +531,49 @@@ static void cpcap_usb_detect(struct wor
  	if (error)
  		return;
  
+ 	/* Just init the state if a charger is connected with no chrg_det set */
+ 	if (!s.chrg_det && s.chrgcurr1 && s.vbusvld) {
+ 		cpcap_charger_update_state(ddata, CPCAP_CHARGER_DETECTING);
+ 
+ 		return;
+ 	}
+ 
+ 	/*
+ 	 * If battery voltage is higher than charge voltage, it may have been
+ 	 * charged to 3.51V by Android. Try again in 10 minutes.
+ 	 */
+ 	if (cpcap_charger_get_charge_voltage(ddata) > ddata->voltage) {
+ 		cpcap_charger_disconnect(ddata, CPCAP_CHARGER_DETECTING,
+ 					 HZ * 60 * 10);
+ 
+ 		return;
+ 	}
+ 
+ 	/* Throttle chrgcurr2 interrupt for charger done and retry */
+ 	switch (ddata->state) {
+ 	case CPCAP_CHARGER_CHARGING:
+ 		if (s.chrgcurr2)
+ 			break;
+ 		if (s.chrgcurr1 && s.vbusvld) {
+ 			cpcap_charger_disconnect(ddata, CPCAP_CHARGER_DONE,
+ 						 HZ * 5);
+ 			return;
+ 		}
+ 		break;
+ 	case CPCAP_CHARGER_DONE:
+ 		if (!s.chrgcurr2)
+ 			break;
+ 		cpcap_charger_disconnect(ddata, CPCAP_CHARGER_DETECTING,
+ 					 HZ * 5);
+ 		return;
+ 	default:
+ 		break;
+ 	}
+ 
 -	if (cpcap_charger_vbus_valid(ddata) && s.chrgcurr1) {
 +	if (!ddata->feeding_vbus && cpcap_charger_vbus_valid(ddata) &&
 +	    s.chrgcurr1) {
  		int max_current;
+ 		int vchrg;
  
  		if (cpcap_charger_battery_found(ddata))
  			max_current = CPCAP_REG_CRM_ICHRG_1A596;

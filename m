Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F991B9171
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 16:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbfITONw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 10:13:52 -0400
Received: from muru.com ([72.249.23.125]:33952 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387716AbfITONw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Sep 2019 10:13:52 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3931780AA;
        Fri, 20 Sep 2019 14:14:23 +0000 (UTC)
Date:   Fri, 20 Sep 2019 07:13:48 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 2/3] power: supply: cpcap-charger: Allow changing
 constant charge voltage
Message-ID: <20190920141348.GL5610@atomide.com>
References: <20190917215253.17880-1-tony@atomide.com>
 <20190917215253.17880-3-tony@atomide.com>
 <20190919092658.GD9644@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919092658.GD9644@amd>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [190919 09:27]:
> Hi!
> 
> > Let's allow reconfiguring the cpcap-charger max charge voltage and
> > default to 4.2V that should be safe for the known users.
> > 
> > This allows the users to use 4.35V for the extra capacity if really
> > needed at a cost of probably shorter battery life. We check the
> > constant charge voltage limit set by the battery.
> > 
> > Some pieces of the property setting code is based on an earlier patch
> > from Pavel Machek <pavel@ucw.cz> but limited to configuring the charge
> > voltage for now.
> 
> I'm sorry I'm a tiny bit busy at the moment.
> 
> > +const int cpcap_charge_voltage[] = {
> > +	[CPCAP_REG_CRM_VCHRG_3V80] = 3800000,
> > +	[CPCAP_REG_CRM_VCHRG_4V10] = 4100000,
> > +	[CPCAP_REG_CRM_VCHRG_4V12] = 4120000,
> > +	[CPCAP_REG_CRM_VCHRG_4V15] = 4150000,
> > +	[CPCAP_REG_CRM_VCHRG_4V17] = 4170000,
> > +	[CPCAP_REG_CRM_VCHRG_4V20] = 4200000,
> > +	[CPCAP_REG_CRM_VCHRG_4V23] = 4230000,
> > +	[CPCAP_REG_CRM_VCHRG_4V25] = 4250000,
> > +	[CPCAP_REG_CRM_VCHRG_4V27] = 4270000,
> > +	[CPCAP_REG_CRM_VCHRG_4V30] = 4300000,
> > +	[CPCAP_REG_CRM_VCHRG_4V33] = 4330000,
> > +	[CPCAP_REG_CRM_VCHRG_4V35] = 4350000,
> > +	[CPCAP_REG_CRM_VCHRG_4V38] = 4380000,
> > +	[CPCAP_REG_CRM_VCHRG_4V40] = 4400000,
> > +	[CPCAP_REG_CRM_VCHRG_4V42] = 4420000,
> > +	[CPCAP_REG_CRM_VCHRG_4V44] = 4440000,
> > +};
> 
> We really don't need this kind of explicit table, as the values can be
> simply computed. Can I offer this?
> 
> Best regards,
> 								Pavel
> 
> static int voltage_to_register(int microvolt)
> {
> 	int milivolt = microvolt/1000;
> 	int res;
> 
> 	if (milivolt < 4100)
> 		return CPCAP_REG_CRM_VCHRG_3V80;
> 	if (milivolt > 4350)
> 		return -EINVAL;
> 
> 	milivolt = milivolt - (4100 - 250);
> 	res = milivolt / 250;
> 	BUG_ON(res < 1);
> 	BUG_ON(res > 0xb);
> 	return CPCAP_REG_CRM_VCHRG(res);
> }

Well that does not help as we have four different ranges there.
I got something figured out for the new suggested fix I posted.

Regards,

TOny


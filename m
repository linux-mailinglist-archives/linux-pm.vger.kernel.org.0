Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857F4211069
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 18:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbgGAQRQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 12:17:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgGAQRQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Jul 2020 12:17:16 -0400
Received: from earth.universe (dyndsl-091-096-062-146.ewe-ip-backbone.de [91.96.62.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF4E20760;
        Wed,  1 Jul 2020 16:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593620235;
        bh=5yCWPuDKKPBG+3wyVyrG68dBy5zQQVEAkJjSRZMx/r0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ko726iabypBH1VsVQwgsmGJP1Ucbw89m/xZTCOmYVcvQwMKF/tREOKGpu/6j0wiVb
         eUx7KeszqMCWFz0w2EowceW+z9AMfFGjj+gGenLgPgNawDtrrKODlI5xt+tMJh3Hpn
         VcHRO03+RxqZzomhATa9Rux5VMBXFAhIAoQ80q4o=
Received: by earth.universe (Postfix, from userid 1000)
        id A99323C08CE; Wed,  1 Jul 2020 18:17:13 +0200 (CEST)
Date:   Wed, 1 Jul 2020 18:17:13 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     pali@kernel.org, robh@kernel.org, afd@ti.com, dmurphy@ti.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sspatil@android.com
Subject: Re: [EXTERNAL] Re: [PATCH v14 4/4] power: supply: bq25150 introduce
 the bq25150
Message-ID: <20200701161713.f67htedosevy4oyp@earth.universe>
References: <20200630215426.26450-1-r-rivera-matos@ti.com>
 <20200630215426.26450-5-r-rivera-matos@ti.com>
 <20200630233341.d5ztfv5rcbhjxi4r@earth.universe>
 <b22f4eed-6baf-604e-0953-d427407c904e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b22f4eed-6baf-604e-0953-d427407c904e@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, Jun 30, 2020 at 11:17:30PM -0500, Ricardo Rivera-Matos wrote:
> [...]
> > > +static int bq2515x_battery_set_property(struct power_supply *psy,
> > > +		enum power_supply_property prop,
> > > +		const union power_supply_propval *val)
> > > +{
> > > +	struct bq2515x_device *bq2515x = power_supply_get_drvdata(psy);
> > > +	int ret;
> > > +
> > > +	switch (prop) {
> > > +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> > > +		ret = bq2515x_set_batt_reg(bq2515x, val->intval);
> > > +		break;
> > > +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> > > +		ret = bq2515x_set_const_charge_current(bq2515x, val->intval);
> > > +		break;
> > > +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> > > +		ret = bq2515x_set_precharge_current(bq2515x, val->intval);
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > Expose those through the charger device. The battery device
> > can expose maximum data (e.g. POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX),
> > but should not control the charging itself.
> ACK. Just to confirm this would eliminate the need for the
> bq2515x_battery_set_property altogether as these three properties should be
> set in the charger device. There will only be a bq2515x_battery_get_property
> to report the CONSTANT_CHARGE_VOLTAGE_MAX and CONSTANT_CHARGE_CURRENT_MAX
> values captured from the devicetree.

Right.

-- Sebastian

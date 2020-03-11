Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF42E182604
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 00:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgCKXu2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 19:50:28 -0400
Received: from mail.manjaro.org ([176.9.38.148]:32976 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731399AbgCKXu2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 19:50:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 2A34437024CE;
        Thu, 12 Mar 2020 00:50:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BuEVeWZmGOFA; Thu, 12 Mar 2020 00:50:23 +0100 (CET)
Subject: Re: [PATCH v3 3/3] power: supply: add CellWise cw2015 fuel gauge
 driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200311093043.3636807-1-t.schramm@manjaro.org>
 <20200311093043.3636807-4-t.schramm@manjaro.org>
 <20200311101830.GE1922688@smile.fi.intel.com>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <c93db959-1e8d-9823-8a4f-71bfea12afaf@manjaro.org>
Date:   Thu, 12 Mar 2020 00:51:28 +0100
MIME-Version: 1.0
In-Reply-To: <20200311101830.GE1922688@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Andy,

thanks for reviewing again.

>> +	/* wait for gauge to become ready */
>> +	for (i = 0; i < CW2015_READ_TRIES; i++) {
>> +		ret = regmap_read(cw_bat->regmap, CW2015_REG_SOC, &reg_val);
>> +		if (ret)
>> +			return ret;
>> +		/* SoC must not be more than 100% */
>> +		else if (reg_val <= 100)
>> +			break;
>> +
>> +		msleep(100);
>> +	}
> 
> Have you considered to use regmap_read_poll_timeout()?

Neat! That is a much cleaner solution. Will use that in v4.

> 
>> +
>> +	if (i >= CW2015_READ_TRIES) {
>> +		reg_val = CW2015_MODE_SLEEP;
>> +		regmap_write(cw_bat->regmap, CW2015_REG_MODE, reg_val);
>> +		dev_err(cw_bat->dev,
>> +			"Gauge did not become ready after profile upload");
>> +		return -ETIMEDOUT;
>> +	}
> 
> ...
> 
>> +		if (memcmp(bat_info, cw_bat->bat_profile,
>> +				CW2015_SIZE_BATINFO)) {
> 
> I think it's pretty much okay to have this on one line, disregard 80 limit
> (it's only 1 extra).

Ok, will probably do that in a few places.


Best Regards,

Tobias

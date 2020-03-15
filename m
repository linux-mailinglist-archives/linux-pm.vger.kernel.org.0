Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86928185C1D
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 12:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgCOLAl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 07:00:41 -0400
Received: from mail.manjaro.org ([176.9.38.148]:41978 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgCOLAk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Mar 2020 07:00:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 98C0837827DA;
        Sun, 15 Mar 2020 12:00:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vEPWKCNnrgeS; Sun, 15 Mar 2020 12:00:36 +0100 (CET)
Subject: Re: [PATCH v4 3/3] power: supply: add CellWise cw2015 fuel gauge
 driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
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
References: <20200312222448.25097-1-t.schramm@manjaro.org>
 <20200312222448.25097-4-t.schramm@manjaro.org>
 <20200313091124.GP1922688@smile.fi.intel.com>
From:   Tobias Schramm <t.schramm@manjaro.org>
Autocrypt: addr=tobias@t-sys.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fd75f94b-8e08-97da-a396-6df61c6fd89f@manjaro.org>
Date:   Sun, 15 Mar 2020 12:00:35 +0100
MIME-Version: 1.0
In-Reply-To: <20200313091124.GP1922688@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Andy,

thanks for your feedback. Please find my comments inline.

> 
>> +				dev_err(cw_bat->dev,
>> +					 "Failed to upload battery info\n");
> 
> Indentation of the second line.
> 
I've seen quite a few different indentation styles used in kernel
source. Personally I'd indent like this:

		dev_warn(cw_bat->dev,
			 "some long error message");

However coding-style.rst specifies that spaces are never to be used for
indentation. May I assume they are ok for alignment though?


> And I'm thinking that we may refactor this function. So,
> 
> 	length = ..._count_u8(...);
> 	if (length < 0) {
> 		dev_warn(...);
> 	} else if (length != ...) {
> 		dev_err(...);
> 		...
> 	} else {
> 		...
> 	}
> 
> 
> 
>> +		if (length != CW2015_SIZE_BATINFO) {
>> +			dev_err(cw_bat->dev, "battery-profile must be %d bytes",
>> +				CW2015_SIZE_BATINFO);
>> +			return -EINVAL;
>> +		}
>> +
>> +		cw_bat->bat_profile = devm_kzalloc(dev, length, GFP_KERNEL);
>> +		if (!cw_bat->bat_profile) {
>> +			dev_err(cw_bat->dev,
>> +				"Failed to allocate memory for battery config info");
>> +			return -ENOMEM;
>> +		}
>> +
>> +		ret = device_property_read_u8_array(dev,
>> +						"cellwise,battery-profile",
>> +						cw_bat->bat_profile,
>> +						length);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		dev_warn(cw_bat->dev,
>> +			"No battery-profile found, rolling with current flash contents");
>> +	}
>> +
> 
> ...and here...
> 
>> +	cw_bat->poll_interval_ms = CW2015_DEFAULT_POLL_INTERVAL_MS;
>> +	ret = device_property_read_u32(dev, "cellwise,monitor-interval-ms", &value);
>> +	if (ret >= 0) {
>> +		dev_dbg(cw_bat->dev, "Overriding default monitor-interval with %u ms",
>> +			value);
>> +		cw_bat->poll_interval_ms = value;
>> +	}
> 
> 	ret = device_property_read_u32(dev, "cellwise,monitor-interval-ms", &cw_bat->poll_interval_ms);
> 	if (ret) {
> 		dev_dbg(cw_bat->dev, "Use default\n");
> 		cw_bat->poll_interval_ms = CW2015_DEFAULT_POLL_INTERVAL_MS;
> 	}
> 
> What do you think?
> 
Looks good to me. I'll use it just like that.

> 
>> +	int ret;
>> +	struct cw_battery *cw_bat;
> 
>> +	struct power_supply_config psy_cfg = { };
> 
> Don't you need 0 here?
> 
Yeah, that would be better. Think empty initializers are a GNU extension.


Best Regards,

Tobias

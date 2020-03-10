Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6A018077B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 19:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgCJSyk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 14:54:40 -0400
Received: from mail.manjaro.org ([176.9.38.148]:49396 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgCJSyk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Mar 2020 14:54:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id DC9CC38C78F8;
        Tue, 10 Mar 2020 19:54:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wnU8nTtUDQIQ; Tue, 10 Mar 2020 19:54:36 +0100 (CET)
Subject: Re: [PATCH v2 2/2] power: supply: add CellWise cw2015 fuel gauge
 driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200309160346.2203680-1-t.schramm@manjaro.org>
 <20200309160346.2203680-3-t.schramm@manjaro.org>
 <20200310101050.GG1922688@smile.fi.intel.com>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <eb732216-dd19-f18d-9ace-e14c7e8de991@manjaro.org>
Date:   Tue, 10 Mar 2020 19:55:42 +0100
MIME-Version: 1.0
In-Reply-To: <20200310101050.GG1922688@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Andy,

thanks for your review. Please find my comments inline.

>> +#define CW2015_DEFAULT_MONITOR_MS		8000
> 
> 8 seconds? Any comments about this?
>
Default suggested by CellWise Android example code. I'll add a comment
explaining that.

>> +static int cw_read(struct cw_battery *cw_bat, u8 reg, u8 *val)
>> +{
>> +	u32 tmp;
>> +	int ret;
>> +
>> +	ret = regmap_read(cw_bat->regmap, reg, &tmp);
>> +	*val = tmp;
>> +	return ret;
>> +}
>> +
[ ... ]
>
> This two has no value. Why?
>
This helper translates the memory write size. An u8 * is passed in while
regmap_read takes an unsigned int *. I'll drop it and just use an
unsigned int in the first place though.

>> +static int cw_read_word(struct cw_battery *cw_bat, u8 reg, u16 *val)
>> +{
>> +	u8 reg_val[2];
>> +	int ret;
>> +
>> +	ret = regmap_raw_read(cw_bat->regmap, reg, reg_val, 2);
>> +	*val = (reg_val[0] << 8) + reg_val[1];
>> +	return ret;
>> +}
> 
> NIH BE type of readings? Can REGMAP_ENDIAN_BIG help?

Not really, or can it? Registers on the cw2015 are a wild mix of single
bytes and words. There does not seem to be a per register override for
reg_/val_bits.

> 
> I didn't review some parts because of style issues. Please, fix all of them and
> send v2.
> 
I'll fix all style issues I find.

>> +	cancel_delayed_work(&cw_bat->battery_delay_work);
> 
> Are you sure you have no scheduled work after that?
> 

Will replace that with cancel_delayed_work_sync.


Best Regards,

Tobias

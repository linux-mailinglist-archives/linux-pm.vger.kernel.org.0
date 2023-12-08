Return-Path: <linux-pm+bounces-833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7384F80A100
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 11:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EC01F216C1
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 10:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB62E18E1C;
	Fri,  8 Dec 2023 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="RajIO39J"
X-Original-To: linux-pm@vger.kernel.org
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE331BD8;
	Fri,  8 Dec 2023 02:31:32 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 68CCB40553;
	Fri,  8 Dec 2023 15:31:28 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1702031488; bh=4y6IzqXuYCaOZRj832BYim9z7oqNFMfqjRtC49eFuJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RajIO39JCopnXz/UHAH8GGunqq6K8NXh+7Gh0Dt2D6EgmpAC+4kKE5u/kc+Y9iixy
	 3T5ijAlEqz4za3cgDx7IBwfTV5qtghTKX4ohClLUiDAb1v7P+yXl5B7Q7p626uIS5x
	 dyqDln9a+E4mUV/2S3ydRIS9OvlPoqbd1kRnGhyT0BO0XFhytw48ew8PqkMA4I1rqY
	 uekI9IP8XCIvPcQE/Eb8ve0s0NvR8o37C0Ne9Gp/QyecP/QFiXC6ZBtTDuq4+idi1k
	 AHqTv+rh4NLCJVZ3GV74fac680lt9V3tSWBVACxKWf/RFNU4rHbYeye+O1e1v+c7YF
	 nUjuTgBa2Zo9Q==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 08 Dec 2023 15:31:27 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] power: supply: Add Acer Aspire 1 embedded controller
 driver
In-Reply-To: <71459bab-05b9-41f6-bb32-2b744736487d@linaro.org>
References: <20231207-aspire1-ec-v1-0-ba9e1c227007@trvn.ru>
 <20231207-aspire1-ec-v1-2-ba9e1c227007@trvn.ru>
 <71459bab-05b9-41f6-bb32-2b744736487d@linaro.org>
Message-ID: <8fe5cb8cecf92d98f2768b811deb3ea0@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Konrad Dybcio писал(а) 08.12.2023 00:24:
> On 12/7/23 12:20, Nikita Travkin wrote:
>> Acer Aspire 1 is a Snapdragon 7c based laptop. It uses an embedded
>> controller to control the charging and battery management, as well as to
>> perform a set of misc functions.
>>
>> Unfortunately, while all this functionality is implemented in ACPI, it's
>> currently not possible to use ACPI to boot Linux on such Qualcomm
>> devices. To allow Linux to still support the features provided by EC,
>> this driver reimplments the relevant ACPI parts. This allows us to boot
>> the laptop with Device Tree and retain all the features.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
> [...]
> 
>> +	case POWER_SUPPLY_PROP_CAPACITY:
>> +		val->intval = le16_to_cpu(ddat.capacity_now) * 100
>> +			      / le16_to_cpu(sdat.capacity_full);
> It may be just my OCD and im not the maintainer here, but I'd do
> /= here

Hm you're right, this did look a bit ugly to me when I split the line
(it was 101/100), Will probably use /= to make it nicer in v2.

> 
> [...]
> 
>> +	case POWER_SUPPLY_PROP_MODEL_NAME:
>> +		if (sdat.model_id - 1 < ARRAY_SIZE(aspire_ec_psy_battery_model))
>> +			val->strval = aspire_ec_psy_battery_model[sdat.model_id - 1];
>> +		else
>> +			val->strval = "Unknown";
> Would it make sense to print the model_id that's absent from the LUT
> here and similarly below?
> 

The original ACPI code returns "Unknown" like this when the value
is not in the table. I suppose I could warn here but not sure how
useful it would be... And since this is a rather "hot" path, would
need to warn only once, so extra complexity for a very unlikely
situation IMO.

>> +		break;
>> +
>> +	case POWER_SUPPLY_PROP_MANUFACTURER:
>> +		if (sdat.vendor_id - 3 < ARRAY_SIZE(aspire_ec_psy_battery_vendor))
>> +			val->strval = aspire_ec_psy_battery_vendor[sdat.vendor_id - 3];
>> +		else
>> +			val->strval = "Unknown";
>> +		break;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
> Another ocd trip, i'd add a newline before return
>

Yeah I agree here, missed this. Will add in v2.

>> +	return 0;
>> +}
> [...]
> 
>> +	/*
>> +	 * The original ACPI firmware actually has a small sleep in the handler.
>> +	 *
>> +	 * It seems like in most cases it's not needed but when the device
>> +	 * just exits suspend, our i2c driver has a brief time where data
>> +	 * transfer is not possible yet. So this delay allows us to suppress
>> +	 * quite a bunch of spurious error messages in dmesg. Thus it's kept.
> Ouch.. do you think i2c-geni needs fixing on this part?

Not sure, it seems like when we exit suspend, this handler
gets triggered before geni (or it's dependencies?) is considered
"awake" (my guess is when the clocks are still off):

[  119.246867] PM: suspend entry (s2idle)
(...)
[  119.438052] printk: Suspending console(s) (use no_console_suspend to debug)
[  119.942498] geni_i2c 888000.i2c: error turning SE resources:-13
[  119.942550] aspire-ec 2-0076: Failed to read event id: -EACCES
(...)
[  119.942657] geni_i2c 888000.i2c: error turning SE resources:-13
[  119.942666] aspire-ec 2-0076: Failed to read event id: -EACCES
(...)
[  120.881452] PM: suspend exit

FWIW it doesn't seem to be a big problem since this is
a level interrupt, so it will be retried until the event
can be cleared, but since ACPI also has the sleep, I'm
happy to inherit in and suppress a couple of red lines :)

> 
> [...]
> 
>> +	switch (id) {
>> +	case 0x0: /* No event */
>> +		break;
> Is this a NOP/watchdog sort of thing?
> 

This is a NOP, yes. I think I was hitting spurious interrupts
once or twice so I suppressed this.

> [...]
> 
>> +
>> +static struct i2c_driver aspire_ec_driver = {
>> +	.driver = {
>> +		.name = "aspire-ec",
>> +		.of_match_table = aspire_ec_of_match,
>> +		.pm = pm_sleep_ptr(&aspire_ec_pm_ops),
>> +	},
>> +	.probe = aspire_ec_probe,
>> +	.id_table = aspire_ec_id,
> Since it's tristate, I'd expect an entry for .remove_new here
> 

All the resources I allocate are devm_ so I believe I shouldn't need
to clean anything up on remove...

Thanks for the review!
Nikita

> Konrad


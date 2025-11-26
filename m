Return-Path: <linux-pm+bounces-38671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A41C87D45
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 03:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FB614E1804
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 02:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F394305E2F;
	Wed, 26 Nov 2025 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="txpuY2ZM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9088418C2C
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 02:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764124368; cv=none; b=STNryVI+n1ouwiwbklD7fZ1Jl4DQ3Zb5cdNxsCJkijkD0lSZNzdc2msNoG5i4ged7jyTa2BuPSzTYvPH/uXLZqhJlQn/s/dkNNaZjfa9sxOQWBqBjmkgra6MGWsHZDGmY/qC/vpVsots+IQxMBY1nh1cImb9kMa7Q9HLepdyQQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764124368; c=relaxed/simple;
	bh=pQngsHEG4NnfhIZkLQVe7DkTOMOLWnWJE7Wzcaz5SsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEV9/+7wSQ+8iVIdlo7c56KMsY2VNsM/racNaPO3wpfzu1e5M/tQXaDrJqllTZe3rIXWUJ3ebv0E9BuhdjitjsYFPdwqBlmZal2BT41uw+sIqff2S9GbO7gBw7kW+uJH0LLKTBL5SVyR1sJQ6ST/JeMMQJ3UXT2kuAypkwemVMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=txpuY2ZM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-340e525487eso4258999a91.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 18:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764124366; x=1764729166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=viQFfejLa2fvgnA/CMY2Ia3y/w3OWlv3mFzKSwgxerg=;
        b=txpuY2ZMijKoio/0XlYRGtLMXO8CeXuhH71iJmqTT8hVorqT/OQbenHQX4Mv0YNVwW
         5yCrpb5hJB5fHau3Iba1QdZa6EKnvNLE6nmT0EkX9zTRLBuSKEPMQWcbkntkR7WNlY9v
         UGf7scEjRGqsFCiIqYEkE7bVReEOEhwQVlZM0sfrpJ3p7RiUg0SE7QVmEMkfPuJQmt1w
         T8nKCyNlCPJwP+vh9LR7LNHT4a9wgbHuNWWRDKa9TzqOaxQe29ds0zSlGhdXXEvYNRMH
         I+K6CcDAYvVjTNu2RBIdyOLjcuNDk0AHoO76ZHVnV7vTDw1kOXCrAzWcHYffdEMZXXsQ
         qvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764124366; x=1764729166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=viQFfejLa2fvgnA/CMY2Ia3y/w3OWlv3mFzKSwgxerg=;
        b=tUgtVL6WKESEYAzPnsA274/q/f/2p1XCQWpFhaIFzH2uRSHY7oPqDSF1v0kVIWdZ2Q
         cN44LtAzqi68BIElbywOyd/Brr0YGxGmB3bmMjCkrVW/UV1CQSuTw037sefR/TBXWd9z
         njYgG5f5QgiPSvKv0bUjfSI4h9DWi5mO44Vd1zuYcckooFfNDQYb9jDGYx2nZ5wyuBzn
         3si8+AIYSkah7hgCVul4TusVb7h98YC3YYAMnRDpIAAC4FQnTSyq6FVpkfNW33CBqm4R
         JMavOOf1CWrR/P+m0JSXP88/e/jkcqxbbybQvdq4yhoZkALFXpR+nl8icWy5XpJZ+Ebx
         1mng==
X-Forwarded-Encrypted: i=1; AJvYcCWWOuNSFHU/0c/zuAw0uzSG5//slQSYiumNGOTojvQdqevAA+6vfqGzc3jnPmFHg/oheVm009Xf9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkPN9gz/IGp5B/WIWSyg3xDqk9hR1g0j1wPVj5xbkewYPdFCGr
	fnCSR9uCp+oqcC4koG5UMTxS6Q5idpdtnPEfOtuSAyaaJS6MGqQiZlVXFSblbTjQLw==
X-Gm-Gg: ASbGnctDhx4vvoQ/zkWNW53KUcPQ1e5yQcq6wVndY5p5j6F12yMcEvOQ6hccTexhJp8
	yGOy6OCuAlUqiZDhvRfs2skvgVfIwGhEHzAb9tMKP05T1+d2KGrpKsxgg8f/Or78CfKwWsnR5IY
	SKbJbHVoTdd4GZrzsqGCGgxj3Hpnu2zvDZAL1H+LhAWB+1F2Ww9/rkiNqmm1GqvH32lSDsEvIi5
	Q+foBT9DljYFiIavPuNm+ITjh915/w5u1S/wUpDXU4mT5M9/fHWrkcV7y111jg2OttfDO1YsHY7
	E8ZKaqhcK6EIFiObixXu/gcg6JP32uOjyUhqJk31A35FS2ld259oXGllxqVsbFMZEnXFaQCedBO
	68OgyxcQH0GBD/8vssRuF2MuniUaeXguoIJmEymwOJQ1G0eAQ2bsNS+OohmVB3bDT/r8zjuPmlw
	27mR0HXPybZjgrvBD2cIxhFuMOC1RLTi3baAp/ZpI3u5VCN25tHtCtXlzG1LrJdw+C/wRSFsCxz
	FGByUXOKM4eew==
X-Google-Smtp-Source: AGHT+IGD1s0jwsigC9CKjP4TkneuimTCZulkIKuNhVDm4i5DPzY9T5r6E8+KK5g9yvP0crM19wwRsw==
X-Received: by 2002:a05:7300:230e:b0:2a4:3593:645c with SMTP id 5a478bee46e88-2a71910598amr11369897eec.12.1764124365326;
        Tue, 25 Nov 2025 18:32:45 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:c98d:9e96:d0be:bc30? ([2a00:79e0:2e7c:8:c98d:9e96:d0be:bc30])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e6dbc8sm91444566c88.10.2025.11.25.18.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 18:32:44 -0800 (PST)
Message-ID: <0a43b5a2-dc2f-402a-8ec7-1d5c88602ffc@google.com>
Date: Tue, 25 Nov 2025 18:32:43 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] usb: typec: tcpm/tcpci_maxim: deprecate WAR for
 setting charger mode
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
 <20251123-max77759-charger-v1-6-6b2e4b8f7f54@google.com>
 <9cad7b42dbfea351fb3b708736bf6f6715bcf694.camel@linaro.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <9cad7b42dbfea351fb3b708736bf6f6715bcf694.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/24/25 1:09 AM, André Draszik wrote:
> Hi Amit,
>
> On Sun, 2025-11-23 at 08:35 +0000, Amit Sunil Dhamne via B4 Relay wrote:
>> From: Amit Sunil Dhamne <amitsd@google.com>
>>
>> TCPCI maxim driver directly writes to the charger's register space to
>> set charger mode depending on the power role. As MAX77759 chg driver
>> exists, this WAR is not required.
>>
>> Instead, use a regulator interface to set OTG Boost mode.
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> ---
>>   drivers/usb/typec/tcpm/tcpci_maxim.h      |  1 +
>>   drivers/usb/typec/tcpm/tcpci_maxim_core.c | 48 +++++++++++++++++++++----------
>>   2 files changed, 34 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
>> index b33540a42a95..6c82a61efe46 100644
>> --- a/drivers/usb/typec/tcpm/tcpci_maxim.h
>> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
>> @@ -60,6 +60,7 @@ struct max_tcpci_chip {
>>   	struct tcpm_port *port;
>>   	enum contamiant_state contaminant_state;
>>   	bool veto_vconn_swap;
>> +	struct regulator *otg_reg;
>>   };
>>   
>>   static inline int max_tcpci_read16(struct max_tcpci_chip *chip, unsigned int reg, u16 *val)
>> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
>> index 19f638650796..6d819a762fa1 100644
>> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
>> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>>   #include <linux/usb/pd.h>
>>   #include <linux/usb/tcpci.h>
>>   #include <linux/usb/tcpm.h>
>> @@ -202,32 +203,49 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
>>   	tcpm_pd_receive(chip->port, &msg, rx_type);
>>   }
>>   
>> +static int get_otg_regulator_handle(struct max_tcpci_chip *chip)
>> +{
>> +	if (IS_ERR_OR_NULL(chip->otg_reg)) {
>> +		chip->otg_reg = devm_regulator_get_exclusive(chip->dev,
>> +							     "otg-vbus");
>> +		if (IS_ERR_OR_NULL(chip->otg_reg)) {
>> +			dev_err(chip->dev,
>> +				"Failed to get otg regulator handle");
>> +			return -ENODEV;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int max_tcpci_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata, bool source, bool sink)
>>   {
>>   	struct max_tcpci_chip *chip = tdata_to_max_tcpci(tdata);
>> -	u8 buffer_source[2] = {MAX_BUCK_BOOST_OP, MAX_BUCK_BOOST_SOURCE};
>> -	u8 buffer_sink[2] = {MAX_BUCK_BOOST_OP, MAX_BUCK_BOOST_SINK};
>> -	u8 buffer_none[2] = {MAX_BUCK_BOOST_OP, MAX_BUCK_BOOST_OFF};
> You should also remove the corresponding #defines at the top of this file.

Ack!


>
>> -	struct i2c_client *i2c = chip->client;
>>   	int ret;
>>   
>> -	struct i2c_msg msgs[] = {
>> -		{
>> -			.addr = MAX_BUCK_BOOST_SID,
>> -			.flags = i2c->flags & I2C_M_TEN,
>> -			.len = 2,
>> -			.buf = source ? buffer_source : sink ? buffer_sink : buffer_none,
>> -		},
>> -	};
>> -
>>   	if (source && sink) {
>>   		dev_err(chip->dev, "Both source and sink set\n");
>>   		return -EINVAL;
>>   	}
>>   
>> -	ret = i2c_transfer(i2c->adapter, msgs, 1);
>> +	ret = get_otg_regulator_handle(chip);
>> +	if (ret) {
>> +		/*
>> +		 * Regulator is not necessary for sink only applications. Return
>> +		 * success in cases where sink mode is being modified.
>> +		 */
>> +		return source ? ret : 1;
>> +	}
>> +
>> +	if (source) {
>> +		if (!regulator_is_enabled(chip->otg_reg))
>> +			ret = regulator_enable(chip->otg_reg);
>> +	} else {
>> +		if (regulator_is_enabled(chip->otg_reg))
>> +			ret = regulator_disable(chip->otg_reg);
>> +	}
> Given otg_reg is the fake regulator created by a previous patch in this
> series, this means that the regulator API is really used to configure two
> out of 16 possible charger modes here. That doesn't look right.


I understand the concern, but I believe the regulator framework is the 
correct interface here for three reasons:

1.  The TCPCI driver's responsibility is only to signal the intent to 
source VBUS (OTG) or not. It should not be aware of the specific 
register values or mode bits of the companion charger chip. The charger 
driver (via the regulator enable op) is responsible for translating that 
intent into the correct hardware-specific register value (e.g., 
selecting the correct OTG mode).

2. While the charger supports multiple modes, sourcing VBUS via OTG and 
sinking VBUS (charging) are mutually exclusive states on Type-C and 
there are no modes to support both. If complex scenarios arise (like 
wireless charging + USB OTG), the logic to select the specific register 
mode belongs in the charger driver (the regulator provider), not the 
TCPCI consumer. Now say theoretically, we support wireless charging and 
want to turn it on (sink) while USB OTG mode (source) is on. The charger 
driver would set an appropriate mode based on this info (wireless 
power-supply on, USB otg regulator on, so select XX mode). We can game 
this for any 10 of the *valid* modes (refer [1]) supported by the chip 
and this would work. Using a regulator framework here will not pose a 
restriction on the number of charger modes now or in the future.

3. This design pattern is standard in the kernel from my study. Drivers 
such as bq24190_charger and rt9471 expose USB OTG functionality via the 
regulator framework.

[1] 
https://android.googlesource.com/kernel/google-modules/bms/+/refs/heads/android-gs-raviole-mainline/max77759_regs.h#52

BR,

Amit

>
> Cheers,
> Andre'


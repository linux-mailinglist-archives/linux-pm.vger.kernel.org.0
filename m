Return-Path: <linux-pm+bounces-19831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1269FE09B
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 22:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD641881E6D
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 21:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0B51991B2;
	Sun, 29 Dec 2024 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHNovJdn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB4224B29;
	Sun, 29 Dec 2024 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735508749; cv=none; b=e2pPLJNcsiiwyX1im45tm158896MCFwmlGC3T9iozhtZvNP4jkVxpLHXUF32I01JSBgMoeMBlmsGoWxIKTXPza026Z1LCW0U/FgoHHqOpFYNlQ/OiZF6YkgfskalE44hLGUBCC6sHo8wuPMyHyAXWRL/7FNTkv0AxhP5CORQh8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735508749; c=relaxed/simple;
	bh=OhaM45/UnEuN93p3xjcig3Qaed12iiBSZB2zo93PI8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1b0KDCquuqO4m4LFVeaWr2ets0bV+wB1atIwM1J4J8in1N/gAsf1sHgeOZ3nmsLWrlj17YnR4EtfKamup5MtHQpwCy1xYBpT8xkguoC/0IHaIXKZqqgS5m7dIHxIzNJy25vqiUQ+fXcfPPjhzJduYbQ6Xfr7jdoU9KKHxOGlnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHNovJdn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3330FC4CED1;
	Sun, 29 Dec 2024 21:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735508748;
	bh=OhaM45/UnEuN93p3xjcig3Qaed12iiBSZB2zo93PI8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NHNovJdnu3vRqIYcLwEo84ylodYsh/MEttdpW3fHETae0Hy+XSKl5t+LYTSywrJLI
	 L+mkbqKdRrqtoB9tLi9l0IQX8Rk4G6YOr608/2Gb5Bdx9NYsOzLk+9iMVjdcR+JJYm
	 pA7eDADvFXu8v6hJmYcmZS1TLSUatcLw7FYReApZuoXORIVnOuq7lIOzJ3/lFzrrFS
	 YP8Fd2PuYh/jH0f7Zc3z6WULnIGFVzyGVrjrYbevRBjfZhd2iWsJLi5U9fMO2VrEgE
	 Ei6po5zuvQ6b17llhgEd/vw8MBatCeOJHJkILD7IkIq6ZT9zu2vUDtMUIvqjYX/pWs
	 kVQE0yNBjdPrA==
Message-ID: <2f63d577-43a8-47d7-8ccb-b5ad2b82e705@kernel.org>
Date: Sun, 29 Dec 2024 22:45:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: platform: Add Huawei Matebook E Go EC
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: andersson@kernel.org, bryan.odonoghue@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
 gregkh@linuxfoundation.org, hdegoede@redhat.com,
 heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 konradybcio@kernel.org, krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-usb@vger.kernel.org, nikita@trvn.ru,
 platform-driver-x86@vger.kernel.org, robh@kernel.org, sre@kernel.org
References: <0fc279b2-fa58-404a-af8e-ed18d4e2f514@kernel.org>
 <20241229102832.61841-1-mitltlatltl@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241229102832.61841-1-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/12/2024 11:28, Pengyu Luo wrote:
> On Sun, Dec 29, 2024 at 5:43 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 28/12/2024 12:34, Pengyu Luo wrote:
>>>> On Sat, Dec 28, 2024 at 5:58 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>> On 27/12/2024 18:13, Pengyu Luo wrote:
>>>>> +
>>>>> +#include <linux/platform_data/huawei-gaokun-ec.h>
>>>>> +
>>>>> +#define EC_EVENT             0x06
>>>>> +
>>>>> +/* Also can be found in ACPI specification 12.3 */
>>>>> +#define EC_READ                      0x80
>>>>> +#define EC_WRITE             0x81
>>>>> +#define EC_BURST             0x82
>>>>> +#define EC_QUERY             0x84
>>>>> +
>>>>> +
>>>>> +#define EC_EVENT_LID         0x81
>>>>> +
>>>>> +#define EC_LID_STATE         0x80
>>>>> +#define EC_LID_OPEN          BIT(1)
>>>>> +
>>>>> +#define UCSI_REG_SIZE                7
>>>>> +
>>>>> +/* for tx, command sequences are arranged as
>>>>
>>>> Use Linux style comments, see coding style.
>>>>
>>>
>>> Agree
>>>
>>>>> + * {master_cmd, slave_cmd, data_len, data_seq}
>>>>> + */
>>>>> +#define REQ_HDR_SIZE         3
>>>>> +#define INPUT_SIZE_OFFSET    2
>>>>> +#define INPUT_DATA_OFFSET    3
>>>>> +
>>>>> +/* for rx, data sequences are arranged as
>>>>> + * {status, data_len(unreliable), data_seq}
>>>>> + */
>>>>> +#define RESP_HDR_SIZE                2
>>>>> +#define DATA_OFFSET          2
>>>>> +
>>>>> +
>>>>> +struct gaokun_ec {
>>>>> +     struct i2c_client *client;
>>>>> +     struct mutex lock;
>>>>
>>>> Missing doc. Run Checkpatch --strict, so you will know what is missing here.
>>>>
>>>
>>> I see. A comment for mutex lock.
>>>
>>>>> +     struct blocking_notifier_head notifier_list;
>>>>> +     struct input_dev *idev;
>>>>> +     bool suspended;
>>>>> +};
>>>>> +
>>>>
>>>>
>>>>
>>>> ...
>>>>
>>>>> +
>>>>> +static DEVICE_ATTR_RO(temperature);
>>>>> +
>>>>> +static struct attribute *gaokun_wmi_features_attrs[] = {
>>>>> +     &dev_attr_charge_control_thresholds.attr,
>>>>> +     &dev_attr_smart_charge_param.attr,
>>>>> +     &dev_attr_smart_charge.attr,
>>>>> +     &dev_attr_fn_lock_state.attr,
>>>>> +     &dev_attr_temperature.attr,
>>>>> +     NULL,
>>>>> +};
>>>>
>>>>
>>>> No, don't expose your own interface. Charging is already exposed by
>>>> power supply framework. Temperature by hwmon sensors. Drop all these and
>>>> never re-implement existing kernel user-space interfaces.
>>>>
>>>
>>> I don't quite understand what you mean. You mean I should use hwmon
>>> interface like hwmon_device_register_with_groups to register it, right?
>>
>> You added sysfs interface, I think. My comment is: do not. We have
>> existing interfaces.
>>
> 
> I agree with you, but device_add_groups is used to add sysfs interface
> everywhere, device_add_groups are wrapped in acpi_battery_hook, they
> handle charge_control_thresholds like this, since qcom arm64 do not
> support acpi on linux, we do not use acpi_battery_hook to implement it,
> so it is reasonable to implement it in PSY drivers.


OK, then do not make it a platform driver sysfs ABI but power supply one
and document the ABI (see Documentation/ABI/)

> 
> some examples:
> 



Best regards,
Krzysztof


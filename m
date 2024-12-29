Return-Path: <linux-pm+bounces-19819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475889FDE46
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 10:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B547A124C
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5F27DA6C;
	Sun, 29 Dec 2024 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkTumfq+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7592AE86;
	Sun, 29 Dec 2024 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735465421; cv=none; b=rPqhrjmnmBgd9cmrBh2V2cA81+v5bZgh4LgdpBnk34NCu86kzz4XENgApbwzh/nO/czovu7zmkPKURQP0De2651w/uCLd9z8V1HvG1xHbDI4wOTTrGKE2d/hh0lvYfY7yBRtmuWeBM5/JJFtoI1gggjBfSpNoZKhiYY1jB6SqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735465421; c=relaxed/simple;
	bh=99AOtJIrXiKzw5zkMdJrr1l3jmHrlm4DQapWU0eZAag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZzfFtqjWJ84uFjanJFlffDPAwVDzd0y93a4iS0wETVXjluzJ+ZGfUJyA+6rj7zhmKyRQHUvLYDQt5LOMcg+1tSKsh2B6Qi23uKfXV/jk0sMHfiE4jZfP3x1wsI56QIFsuDtYWQaeGn3Mo/Nbj0T+vlDwC/r5HesVF0irYrn14I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkTumfq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A92CC4CED1;
	Sun, 29 Dec 2024 09:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735465420;
	bh=99AOtJIrXiKzw5zkMdJrr1l3jmHrlm4DQapWU0eZAag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HkTumfq+QuEjd2uDQkt053QkfzNnc/W3NwIh16bkbnerpRyNn9SwLOtclcXWZYDne
	 8ss2Vjq5Uzxff3q4DgXTkjOlxo+pAWbdhHDA2nKax94nTappE7gC09g+8gULAd7W0a
	 pnMAANmwGpw/OARfY8rqRoNgbfL2v4aFB1judeSllG/WTneIUIf5Cc1mH3qkJdybjt
	 ieRn9KdqEZSIEKfCJEPStuPVIOW4YT0SHELcP5iph4uPpD2vIht97HKAaSe46JhhJt
	 il8f14mB5SI4TDODfRBECV1GNNjuZMihWNkgI7VdsmLUWUnqByqtPkF5sEMEchO7hJ
	 HWAkADW8OpsFA==
Message-ID: <0fc279b2-fa58-404a-af8e-ed18d4e2f514@kernel.org>
Date: Sun, 29 Dec 2024 10:43:32 +0100
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
References: <53da6468-501c-4c0f-a73b-4eac99c72b8c@kernel.org>
 <20241228113438.591254-1-mitltlatltl@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <20241228113438.591254-1-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/12/2024 12:34, Pengyu Luo wrote:
>> On Sat, Dec 28, 2024 at 5:58 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 27/12/2024 18:13, Pengyu Luo wrote:
>>> +
>>> +#include <linux/platform_data/huawei-gaokun-ec.h>
>>> +
>>> +#define EC_EVENT             0x06
>>> +
>>> +/* Also can be found in ACPI specification 12.3 */
>>> +#define EC_READ                      0x80
>>> +#define EC_WRITE             0x81
>>> +#define EC_BURST             0x82
>>> +#define EC_QUERY             0x84
>>> +
>>> +
>>> +#define EC_EVENT_LID         0x81
>>> +
>>> +#define EC_LID_STATE         0x80
>>> +#define EC_LID_OPEN          BIT(1)
>>> +
>>> +#define UCSI_REG_SIZE                7
>>> +
>>> +/* for tx, command sequences are arranged as
>>
>> Use Linux style comments, see coding style.
>>
> 
> Agree
> 
>>> + * {master_cmd, slave_cmd, data_len, data_seq}
>>> + */
>>> +#define REQ_HDR_SIZE         3
>>> +#define INPUT_SIZE_OFFSET    2
>>> +#define INPUT_DATA_OFFSET    3
>>> +
>>> +/* for rx, data sequences are arranged as
>>> + * {status, data_len(unreliable), data_seq}
>>> + */
>>> +#define RESP_HDR_SIZE                2
>>> +#define DATA_OFFSET          2
>>> +
>>> +
>>> +struct gaokun_ec {
>>> +     struct i2c_client *client;
>>> +     struct mutex lock;
>>
>> Missing doc. Run Checkpatch --strict, so you will know what is missing here.
>>
> 
> I see. A comment for mutex lock.
> 
>>> +     struct blocking_notifier_head notifier_list;
>>> +     struct input_dev *idev;
>>> +     bool suspended;
>>> +};
>>> +
>>
>>
>>
>> ...
>>
>>> +
>>> +static DEVICE_ATTR_RO(temperature);
>>> +
>>> +static struct attribute *gaokun_wmi_features_attrs[] = {
>>> +     &dev_attr_charge_control_thresholds.attr,
>>> +     &dev_attr_smart_charge_param.attr,
>>> +     &dev_attr_smart_charge.attr,
>>> +     &dev_attr_fn_lock_state.attr,
>>> +     &dev_attr_temperature.attr,
>>> +     NULL,
>>> +};
>>
>>
>> No, don't expose your own interface. Charging is already exposed by
>> power supply framework. Temperature by hwmon sensors. Drop all these and
>> never re-implement existing kernel user-space interfaces.
>>
> 
> I don't quite understand what you mean. You mean I should use hwmon
> interface like hwmon_device_register_with_groups to register it, right?

You added sysfs interface, I think. My comment is: do not. We have
existing interfaces.

> As for battery, get/set_propery allow us to handle charging thresholds
> things, but there are smart_charge_param, smart_charge and fn_lock to handle.

So where is the ABI documentation? Where is any explanation why existing
interfaces are not enough?



Best regards,
Krzysztof


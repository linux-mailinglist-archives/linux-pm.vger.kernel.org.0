Return-Path: <linux-pm+bounces-33907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECB0B44EB9
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 09:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558733AC3E1
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 07:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8E62D3A96;
	Fri,  5 Sep 2025 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7ZE3xJW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294552D3732
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056176; cv=none; b=oXhd4QyFxx+i1aYRgtRc9g6Uf9L1fktKhuRVo3bRm81jFk6j17hJK8ghAByBrqlA1fjjV3i02QDobk+r7cd38StC2lFfBCvxoEaYpbeKdN15frxB864B5uXtyk7R5ea3wyvSF0WsEyvBofURhYNdI+1qxOVbOZdqK3SSod48BEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056176; c=relaxed/simple;
	bh=guh71gia0r4Havl90xYEm9FHPV2X3Ina5OoDADl3lek=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=I5MrsD2BDMhHCBQlmM8vDhBKP/7ykmf7+HaQzDQdbXydLH7oqCFuqXHccTQgyZRIhAmrL81XAKe2PmWcdW+zR23FDI3fsqWjmWMkksK+jVjHjpLJNQJsEp5sMOe6UxgK5derwI9a9rbIe/S2zgwB57q2y6lmJjRl8BuLJ3l/Gcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G7ZE3xJW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afec5651966so363976066b.2
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2025 00:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757056171; x=1757660971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9QKVc+nKCFa2lUIO4Rrq4SKqTv7ZnawQMkLOI5coK8=;
        b=G7ZE3xJW93c8HKCnBM0OFDJcAjE4JOli4TCW+iM1VkbP8VqESbLF9IZN0Dsr7ZIzZi
         0ypNK+HRqiTG9duvUmMr0SgpL1oXlBteo8qkbbpwCPXAv29outYTkKDT2N6hKGv6bEmg
         53V6pKF45y51G68V8WGRctbfOmUT9gZu5vg7JDweBDPwY0HYmPJ4nLMmS/RTXpmxVYHp
         pu0Cg2l4IPzI9CJSXq88sS91ZD6+9vzULlmMmzPbSjJsG/CK9uv5TPrrCNjhajk9cIoH
         B3OFt5B9oA0JhwxKnI14YJS2Z3NZBk17NMXm1auPsUIK+Y7OUfjV2rb7W3AihEgmK2a+
         MyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757056171; x=1757660971;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w9QKVc+nKCFa2lUIO4Rrq4SKqTv7ZnawQMkLOI5coK8=;
        b=Jbb4xVcST9XQjD6ALPlA1rqCdomgf68IH1IKC5hOBtnUq5XZMaOaTNslnn0NLR4iDr
         J7LYHbgzb9HvIIjyKlNvVCKQYo/Utais+atqvAsjd4LNRLvMDh66wECM0IUCEPP1e8kZ
         LLoW1rSu+e+NcwcZjbBxVJxavNilCtYKgiGwji5UhXHGuoda4GqJTpCXLJha6TmM7VUX
         SHfCH3weqaYMc161YfZs7y1XcCwmUKQ1oKfAIrsnt4nLumqw/NVQ4rWwd2GlzD6F5lQs
         qbYKZ8jxeird7mx4da1aQVZARiLI/+xjSQwKKdEQ9OB9yDajvy2kSfXB3vNBFUzoZ0Eu
         YiUA==
X-Forwarded-Encrypted: i=1; AJvYcCWKJ3roWL6MiMEhnM/YKV0SsReX+l7SHAFeVdsEiqXT3Sh9jZUBSNELd5ZwFcbbw7FnPE/kysS6Yg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmf94vtbMFHCIyqqCiHzOdtOVStak/gXFf2KdrTQU/KmarJwAa
	RnAldTTSiuVU75AGCRVFyu1pppq/Z7ynfY25XwgJLPwkhJkwEn0n60jQFlbkR1qd3qw=
X-Gm-Gg: ASbGnct2q6+EnW2QrcHNepghJIYFa3HDavg2LtIHleL3qGKJ/gSPecdHxbHkzoT1FeK
	Z5r23YC3syVUT/8rRH0RdurUIjOoYu5OdFVns9jWja1PNsesADsxQO4vPpgIauj+6aG78PY4ruY
	SeqGckzTPOI+lLfavboCy1jJtbBM5qJUIbDRqB2D7uB16Nsrl7RFl6kop3JJ9WJUS2dvsp6RSXb
	pN5b8/AuQ3vLdJV4HfKOnSmWdnr7no8zwzvDtwIEJdTTzUyXTfuOA72v5V4YpL6JXOmPTmxCD7g
	IlwT5VpVCCCghmC/axbH50vNJ8JbGsjd64R8vlVWpr0aGIPgPNxfCNB/LDmM4rzvJN9nTIasVY+
	DLm7EWB6yLHWPY2BK/b08/BLYcg62SQLfiw==
X-Google-Smtp-Source: AGHT+IHq6jK1abcIGWZ9lFmBlU8nNCpQKhB4LAkndBx44fVoZz3+Zdw5vpcLio+Ty19wIa4RFW/6Ug==
X-Received: by 2002:a17:907:3fa8:b0:b04:54dc:3030 with SMTP id a640c23a62f3a-b0454dc336fmr1320714366b.18.1757056171314;
        Fri, 05 Sep 2025 00:09:31 -0700 (PDT)
Received: from [192.168.7.190] ([212.114.21.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04252103f2sm1218447166b.50.2025.09.05.00.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 00:09:30 -0700 (PDT)
Message-ID: <3f394977-51b2-4309-ae6b-75cd1980a9c5@linaro.org>
Date: Fri, 5 Sep 2025 09:09:28 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 7/8] power: supply: qcom_battmgr: Add charge control
 support
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
 David Collins <david.collins@oss.qualcomm.com>,
 =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20250826-qcom_battmgr_update-v3-0-74ea410ef146@oss.qualcomm.com>
 <20250826-qcom_battmgr_update-v3-7-74ea410ef146@oss.qualcomm.com>
 <f6372ebb-c237-4409-b3a9-8f458be85034@linaro.org>
 <76d12f47-bdb0-404a-9371-788e116c3474@oss.qualcomm.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <76d12f47-bdb0-404a-9371-788e116c3474@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/09/2025 03:19, Fenglin Wu wrote:
> 
> On 9/3/2025 4:29 PM, Neil Armstrong wrote:
>> On 26/08/2025 09:18, Fenglin Wu via B4 Relay wrote:
>>> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>>
>>> Add charge control support for SM8550 and X1E80100. It's supported
>>> with below two power supply properties:
>>>
>>> charge_control_end_threshold: The battery SoC (State of Charge)
>>> threshold at which the charging should be terminated.
>>>
>>> charge_control_start_threshold: The battery SoC threshold at
>>> which the charging should be resumed.
>>>
>>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>> ---
>>>   drivers/power/supply/qcom_battmgr.c | 290 +++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 283 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
>>> index 174d3f83ac2b070bb90c21a498686e91cc629ebe..23c68eb942f1b213f634e31a45420b3e113e2764 100644
>>> --- a/drivers/power/supply/qcom_battmgr.c
>>> +++ b/drivers/power/supply/qcom_battmgr.c
>>> @@ -7,6 +7,7 @@
>>>   #include <linux/auxiliary_bus.h>
>>>   #include <linux/module.h>
>>>   #include <linux/mutex.h>
>>> +#include <linux/nvmem-consumer.h>
>>>   #include <linux/of_device.h>
>>>   #include <linux/power_supply.h>
>>>   #include <linux/property.h>
>>> @@ -68,6 +69,9 @@ enum qcom_battmgr_variant {
>>>   #define BATT_RESISTANCE            21
>>>   #define BATT_POWER_NOW            22
>>>   #define BATT_POWER_AVG            23
>>> +#define BATT_CHG_CTRL_EN        24
>>> +#define BATT_CHG_CTRL_START_THR        25
>>> +#define BATT_CHG_CTRL_END_THR        26
>>>     #define BATTMGR_USB_PROPERTY_GET    0x32
>>>   #define BATTMGR_USB_PROPERTY_SET    0x33
>>> @@ -92,6 +96,13 @@ enum qcom_battmgr_variant {
>>>   #define WLS_TYPE            5
>>>   #define WLS_BOOST_EN            6
>>>   +#define BATTMGR_CHG_CTRL_LIMIT_EN    0x48
>>> +#define CHARGE_CTRL_START_THR_MIN    50
>>> +#define CHARGE_CTRL_START_THR_MAX    95
>>> +#define CHARGE_CTRL_END_THR_MIN        55
>>> +#define CHARGE_CTRL_END_THR_MAX        100
>>> +#define CHARGE_CTRL_DELTA_SOC        5
>>> +
>>>   struct qcom_battmgr_enable_request {
>>>       struct pmic_glink_hdr hdr;
>>>       __le32 battery_id;
>>> @@ -126,6 +137,13 @@ struct qcom_battmgr_discharge_time_request {
>>>       __le32 reserved;
>>>   };
>>>   +struct qcom_battmgr_charge_ctrl_request {
>>> +    struct pmic_glink_hdr hdr;
>>> +    __le32 enable;
>>> +    __le32 target_soc;
>>> +    __le32 delta_soc;
>>> +};
>>> +
>>>   struct qcom_battmgr_message {
>>>       struct pmic_glink_hdr hdr;
>>>       union {
>>> @@ -238,6 +256,8 @@ struct qcom_battmgr_info {
>>>       unsigned int capacity_warning;
>>>       unsigned int cycle_count;
>>>       unsigned int charge_count;
>>> +    unsigned int charge_ctrl_start;
>>> +    unsigned int charge_ctrl_end;
>>>       char model_number[BATTMGR_STRING_LEN];
>>>       char serial_number[BATTMGR_STRING_LEN];
>>>       char oem_info[BATTMGR_STRING_LEN];
>>> @@ -426,6 +446,8 @@ static const u8 sm8350_bat_prop_map[] = {
>>>       [POWER_SUPPLY_PROP_INTERNAL_RESISTANCE] = BATT_RESISTANCE,
>>>       [POWER_SUPPLY_PROP_STATE_OF_HEALTH] = BATT_SOH,
>>>       [POWER_SUPPLY_PROP_POWER_NOW] = BATT_POWER_NOW,
>>> +    [POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD] = BATT_CHG_CTRL_START_THR,
>>> +    [POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD] = BATT_CHG_CTRL_END_THR,
>>>   };
>>>     static int qcom_battmgr_bat_sm8350_update(struct qcom_battmgr *battmgr,
>>> @@ -496,7 +518,8 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
>>>       if (!battmgr->service_up)
>>>           return -EAGAIN;
>>>   -    if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
>>> +    if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
>>> +        battmgr->variant == QCOM_BATTMGR_X1E80100)
>>>           ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
>>>       else
>>>           ret = qcom_battmgr_bat_sm8350_update(battmgr, psp);
>>> @@ -601,6 +624,12 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
>>>       case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
>>>           val->intval = battmgr->status.charge_time;
>>>           break;
>>> +    case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
>>> +        val->intval = battmgr->info.charge_ctrl_start;
>>> +        break;
>>> +    case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
>>> +        val->intval = battmgr->info.charge_ctrl_end;
>>> +        break;
>>>       case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
>>>           val->intval = battmgr->info.year;
>>>           break;
>>> @@ -626,6 +655,149 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
>>>       return 0;
>>>   }
>>>   +static int qcom_battmgr_set_charge_control(struct qcom_battmgr *battmgr,
>>> +                       u32 target_soc, u32 delta_soc)
>>> +{
>>> +    struct qcom_battmgr_charge_ctrl_request request = {
>>> +        .hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
>>> +        .hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
>>> +        .hdr.opcode = cpu_to_le32(BATTMGR_CHG_CTRL_LIMIT_EN),
>>> +        .enable = cpu_to_le32(1),
>>> +        .target_soc = cpu_to_le32(target_soc),
>>> +        .delta_soc = cpu_to_le32(delta_soc),
>>> +    };
>>> +
>>> +    return qcom_battmgr_request(battmgr, &request, sizeof(request));
>>> +}
>>> +
>>> +static int qcom_battmgr_set_charge_start_threshold(struct qcom_battmgr *battmgr, int start_soc)
>>> +{
>>> +    u32 target_soc, delta_soc;
>>> +    int ret;
>>> +
>>> +    if (start_soc < CHARGE_CTRL_START_THR_MIN ||
>>> +        start_soc > CHARGE_CTRL_START_THR_MAX) {
>>> +        dev_err(battmgr->dev, "charge control start threshold exceed range: [%u - %u]\n",
>>> +            CHARGE_CTRL_START_THR_MIN, CHARGE_CTRL_START_THR_MAX);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    /*
>>> +     * If the new start threshold is larger than the old end threshold,
>>> +     * move the end threshold one step (DELTA_SOC) after the new start
>>> +     * threshold.
>>> +     */
>>> +    if (start_soc > battmgr->info.charge_ctrl_end) {
>>> +        target_soc = start_soc + CHARGE_CTRL_DELTA_SOC;
>>> +        target_soc = min_t(u32, target_soc, CHARGE_CTRL_END_THR_MAX);
>>> +        delta_soc = target_soc - start_soc;
>>> +        delta_soc = min_t(u32, delta_soc, CHARGE_CTRL_DELTA_SOC);
>>> +    } else {
>>> +        target_soc =  battmgr->info.charge_ctrl_end;
>>> +        delta_soc = battmgr->info.charge_ctrl_end - start_soc;
>>> +    }
>>> +
>>> +    mutex_lock(&battmgr->lock);
>>> +    ret = qcom_battmgr_set_charge_control(battmgr, target_soc, delta_soc);
>>> +    mutex_unlock(&battmgr->lock);
>>> +    if (!ret) {
>>> +        battmgr->info.charge_ctrl_start = start_soc;
>>> +        battmgr->info.charge_ctrl_end = target_soc;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr *battmgr, int end_soc)
>>> +{
>>> +    u32 delta_soc = CHARGE_CTRL_DELTA_SOC;
>>> +    int ret;
>>> +
>>> +    if (end_soc < CHARGE_CTRL_END_THR_MIN ||
>>> +        end_soc > CHARGE_CTRL_END_THR_MAX) {
>>> +        dev_err(battmgr->dev, "charge control end threshold exceed range: [%u - %u]\n",
>>> +            CHARGE_CTRL_END_THR_MIN, CHARGE_CTRL_END_THR_MAX);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (battmgr->info.charge_ctrl_start && end_soc > battmgr->info.charge_ctrl_start)
>>> +        delta_soc = end_soc - battmgr->info.charge_ctrl_start;
>>> +
>>> +    mutex_lock(&battmgr->lock);
>>> +    ret = qcom_battmgr_set_charge_control(battmgr, end_soc, delta_soc);
>>> +    mutex_unlock(&battmgr->lock);
>>> +    if (!ret) {
>>> +        battmgr->info.charge_ctrl_start = end_soc - delta_soc;
>>> +        battmgr->info.charge_ctrl_end = end_soc;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int qcom_battmgr_charge_control_thresholds_init(struct qcom_battmgr *battmgr)
>>> +{
>>> +    int ret;
>>> +    u8 en, end_soc, start_soc, delta_soc;
>>> +
>>> +    ret = nvmem_cell_read_u8(battmgr->dev->parent, "charge_limit_en", &en);
>>> +    if (!ret && en != 0) {
>>> +        ret = nvmem_cell_read_u8(battmgr->dev->parent, "charge_limit_end", &end_soc);
>>> +        if (ret < 0)
>>> +            return ret;
>>> +
>>> +        ret = nvmem_cell_read_u8(battmgr->dev->parent, "charge_limit_delta", &delta_soc);
>>> +        if (ret < 0)
>>> +            return ret;
>>> +
>>> +        if (delta_soc >= end_soc)
>>> +            return -EINVAL;
>>> +
>>> +        start_soc = end_soc - delta_soc;
>>> +        end_soc = clamp(end_soc, CHARGE_CTRL_END_THR_MIN, CHARGE_CTRL_END_THR_MAX);
>>> +        start_soc = clamp(start_soc, CHARGE_CTRL_START_THR_MIN, CHARGE_CTRL_START_THR_MAX);
>>> +
>>> +        battmgr->info.charge_ctrl_start = start_soc;
>>> +        battmgr->info.charge_ctrl_end = end_soc;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int qcom_battmgr_bat_is_writeable(struct power_supply *psy,
>>> +                     enum power_supply_property psp)
>>> +{
>>> +    switch (psp) {
>>> +    case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
>>> +    case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
>>> +        return 1;
>>> +    default:
>>> +        return 0;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int qcom_battmgr_bat_set_property(struct power_supply *psy,
>>> +                     enum power_supply_property psp,
>>> +                     const union power_supply_propval *pval)
>>> +{
>>> +    struct qcom_battmgr *battmgr = power_supply_get_drvdata(psy);
>>> +
>>> +    if (!battmgr->service_up)
>>> +        return -EAGAIN;
>>> +
>>> +    switch (psp) {
>>> +    case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
>>> +        return qcom_battmgr_set_charge_start_threshold(battmgr, pval->intval);
>>> +    case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
>>> +        return qcom_battmgr_set_charge_end_threshold(battmgr, pval->intval);
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static const enum power_supply_property sc8280xp_bat_props[] = {
>>>       POWER_SUPPLY_PROP_STATUS,
>>>       POWER_SUPPLY_PROP_PRESENT,
>>> @@ -659,6 +831,43 @@ static const struct power_supply_desc sc8280xp_bat_psy_desc = {
>>>       .get_property = qcom_battmgr_bat_get_property,
>>>   };
>>>   +static const enum power_supply_property x1e80100_bat_props[] = {
>>> +    POWER_SUPPLY_PROP_STATUS,
>>> +    POWER_SUPPLY_PROP_PRESENT,
>>> +    POWER_SUPPLY_PROP_TECHNOLOGY,
>>> +    POWER_SUPPLY_PROP_CYCLE_COUNT,
>>> +    POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
>>> +    POWER_SUPPLY_PROP_VOLTAGE_NOW,
>>> +    POWER_SUPPLY_PROP_POWER_NOW,
>>> +    POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>>> +    POWER_SUPPLY_PROP_CHARGE_FULL,
>>> +    POWER_SUPPLY_PROP_CHARGE_EMPTY,
>>> +    POWER_SUPPLY_PROP_CHARGE_NOW,
>>> +    POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>>> +    POWER_SUPPLY_PROP_ENERGY_FULL,
>>> +    POWER_SUPPLY_PROP_ENERGY_EMPTY,
>>> +    POWER_SUPPLY_PROP_ENERGY_NOW,
>>> +    POWER_SUPPLY_PROP_TEMP,
>>> +    POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
>>> +    POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
>>> +    POWER_SUPPLY_PROP_MANUFACTURE_DAY,
>>> +    POWER_SUPPLY_PROP_MODEL_NAME,
>>> +    POWER_SUPPLY_PROP_MANUFACTURER,
>>> +    POWER_SUPPLY_PROP_SERIAL_NUMBER,
>>> +    POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
>>> +    POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
>>
>> Is it expected to _not_ have POWER_SUPPLY_PROP_STATE_OF_HEALTH & POWER_SUPPLY_PROP_INTERNAL_RESISTANCE here ?
>>
>> Neil
> 
> No, X1E80100 platform doesn't have battery resistance/SOH information exported in battery management firmware
> 
> 
>>
>>> +};
>>> +
>>> +static const struct power_supply_desc x1e80100_bat_psy_desc = {
>>> +    .name = "qcom-battmgr-bat",
>>> +    .type = POWER_SUPPLY_TYPE_BATTERY,
>>> +    .properties = x1e80100_bat_props,
>>> +    .num_properties = ARRAY_SIZE(x1e80100_bat_props),
>>> +    .get_property = qcom_battmgr_bat_get_property,
>>> +    .set_property = qcom_battmgr_bat_set_property,
>>> +    .property_is_writeable = qcom_battmgr_bat_is_writeable,
>>> +};
>>> +
>>>   static const enum power_supply_property sm8350_bat_props[] = {
>>>       POWER_SUPPLY_PROP_STATUS,
>>>       POWER_SUPPLY_PROP_HEALTH,
>>> @@ -691,6 +900,42 @@ static const struct power_supply_desc sm8350_bat_psy_desc = {
>>>       .get_property = qcom_battmgr_bat_get_property,
>>>   };
>>>   +static const enum power_supply_property sm8550_bat_props[] = {
>>> +    POWER_SUPPLY_PROP_STATUS,
>>> +    POWER_SUPPLY_PROP_HEALTH,
>>> +    POWER_SUPPLY_PROP_PRESENT,
>>> +    POWER_SUPPLY_PROP_CHARGE_TYPE,
>>> +    POWER_SUPPLY_PROP_CAPACITY,
>>> +    POWER_SUPPLY_PROP_VOLTAGE_OCV,
>>> +    POWER_SUPPLY_PROP_VOLTAGE_NOW,
>>> +    POWER_SUPPLY_PROP_VOLTAGE_MAX,
>>> +    POWER_SUPPLY_PROP_CURRENT_NOW,
>>> +    POWER_SUPPLY_PROP_TEMP,
>>> +    POWER_SUPPLY_PROP_TECHNOLOGY,
>>> +    POWER_SUPPLY_PROP_CHARGE_COUNTER,
>>> +    POWER_SUPPLY_PROP_CYCLE_COUNT,
>>> +    POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>>> +    POWER_SUPPLY_PROP_CHARGE_FULL,
>>> +    POWER_SUPPLY_PROP_MODEL_NAME,
>>> +    POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
>>> +    POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
>>> +    POWER_SUPPLY_PROP_INTERNAL_RESISTANCE,
>>> +    POWER_SUPPLY_PROP_STATE_OF_HEALTH,
>>> +    POWER_SUPPLY_PROP_POWER_NOW,
>>> +    POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
>>> +    POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
>>> +};
>>> +
>>> +static const struct power_supply_desc sm8550_bat_psy_desc = {
>>> +    .name = "qcom-battmgr-bat",
>>> +    .type = POWER_SUPPLY_TYPE_BATTERY,
>>> +    .properties = sm8550_bat_props,
>>> +    .num_properties = ARRAY_SIZE(sm8550_bat_props),
>>> +    .get_property = qcom_battmgr_bat_get_property,
>>> +    .set_property = qcom_battmgr_bat_set_property,
>>> +    .property_is_writeable = qcom_battmgr_bat_is_writeable,
>>> +};
>>> +
>>>   static int qcom_battmgr_ac_get_property(struct power_supply *psy,
>>>                       enum power_supply_property psp,
>>>                       union power_supply_propval *val)
>>> @@ -766,7 +1011,8 @@ static int qcom_battmgr_usb_get_property(struct power_supply *psy,
>>>       if (!battmgr->service_up)
>>>           return -EAGAIN;
>>>   -    if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
>>> +    if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
>>> +        battmgr->variant == QCOM_BATTMGR_X1E80100)
>>>           ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
>>>       else
>>>           ret = qcom_battmgr_usb_sm8350_update(battmgr, psp);
>>> @@ -888,7 +1134,8 @@ static int qcom_battmgr_wls_get_property(struct power_supply *psy,
>>>       if (!battmgr->service_up)
>>>           return -EAGAIN;
>>>   -    if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
>>> +    if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
>>> +        battmgr->variant == QCOM_BATTMGR_X1E80100)
>>>           ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
>>>       else
>>>           ret = qcom_battmgr_wls_sm8350_update(battmgr, psp);
>>> @@ -1085,6 +1332,9 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
>>>       case BATTMGR_BAT_CHARGE_TIME:
>>>           battmgr->status.charge_time = le32_to_cpu(resp->time);
>>>           break;
>>> +    case BATTMGR_CHG_CTRL_LIMIT_EN:
>>> +        battmgr->error = 0;
>>> +        break;
>>>       default:
>>>           dev_warn(battmgr->dev, "unknown message %#x\n", opcode);
>>>           break;
>>> @@ -1198,6 +1448,12 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
>>>           case BATT_POWER_NOW:
>>>               battmgr->status.power_now = le32_to_cpu(resp->intval.value);
>>>               break;
>>> +        case BATT_CHG_CTRL_START_THR:
>>> +            battmgr->info.charge_ctrl_start = le32_to_cpu(resp->intval.value);
>>> +            break;
>>> +        case BATT_CHG_CTRL_END_THR:
>>> +            battmgr->info.charge_ctrl_end = le32_to_cpu(resp->intval.value);
>>> +            break;
>>>           default:
>>>               dev_warn(battmgr->dev, "unknown property %#x\n", property);
>>>               break;
>>> @@ -1280,6 +1536,7 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
>>>           }
>>>           break;
>>>       case BATTMGR_REQUEST_NOTIFICATION:
>>> +    case BATTMGR_CHG_CTRL_LIMIT_EN:
>>>           battmgr->error = 0;
>>>           break;
>>>       default:
>>> @@ -1299,7 +1556,8 @@ static void qcom_battmgr_callback(const void *data, size_t len, void *priv)
>>>         if (opcode == BATTMGR_NOTIFICATION)
>>>           qcom_battmgr_notification(battmgr, data, len);
>>> -    else if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
>>> +    else if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
>>> +         battmgr->variant == QCOM_BATTMGR_X1E80100)
>>>           qcom_battmgr_sc8280xp_callback(battmgr, data, len);
>>>       else
>>>           qcom_battmgr_sm8350_callback(battmgr, data, len);
>>> @@ -1346,11 +1604,13 @@ static char *qcom_battmgr_battery[] = { "battery" };
>>>   static int qcom_battmgr_probe(struct auxiliary_device *adev,
>>>                     const struct auxiliary_device_id *id)
>>>   {
>>> +    const struct power_supply_desc *psy_desc;
>>>       struct power_supply_config psy_cfg_supply = {};
>>>       struct power_supply_config psy_cfg = {};
>>>       const struct of_device_id *match;
>>>       struct qcom_battmgr *battmgr;
>>>       struct device *dev = &adev->dev;
>>> +    int ret;
>>>         battmgr = devm_kzalloc(dev, sizeof(*battmgr), GFP_KERNEL);
>>>       if (!battmgr)
>>> @@ -1376,8 +1636,19 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
>>>       else
>>>           battmgr->variant = QCOM_BATTMGR_SM8350;
>>>   -    if (battmgr->variant == QCOM_BATTMGR_SC8280XP) {
>>> -        battmgr->bat_psy = devm_power_supply_register(dev, &sc8280xp_bat_psy_desc, &psy_cfg);
>>> +    ret = qcom_battmgr_charge_control_thresholds_init(battmgr);
>>> +    if (ret < 0)
>>> +        return dev_err_probe(dev, ret,
>>> +                     "failed to init battery charge control thresholds\n");
>>> +
>>> +    if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
>>> +        battmgr->variant == QCOM_BATTMGR_X1E80100) {
>>> +        if (battmgr->variant == QCOM_BATTMGR_X1E80100)
>>> +            psy_desc = &x1e80100_bat_psy_desc;
>>> +        else
>>> +            psy_desc = &sc8280xp_bat_psy_desc;
>>> +
>>> +        battmgr->bat_psy = devm_power_supply_register(dev, psy_desc, &psy_cfg);
>>>           if (IS_ERR(battmgr->bat_psy))
>>>               return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
>>>                            "failed to register battery power supply\n");
>>> @@ -1397,7 +1668,12 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
>>>               return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
>>>                            "failed to register wireless charing power supply\n");
>>>       } else {
>>> -        battmgr->bat_psy = devm_power_supply_register(dev, &sm8350_bat_psy_desc, &psy_cfg);
>>> +        if (battmgr->variant == QCOM_BATTMGR_SM8550)
>>> +            psy_desc = &sm8550_bat_psy_desc;
>>> +        else
>>> +            psy_desc = &sm8350_bat_psy_desc;
>>> +
>>> +        battmgr->bat_psy = devm_power_supply_register(dev, psy_desc, &psy_cfg);
>>>           if (IS_ERR(battmgr->bat_psy))
>>>               return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
>>>                            "failed to register battery power supply\n");
>>>
>>

Ok, thanks !

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


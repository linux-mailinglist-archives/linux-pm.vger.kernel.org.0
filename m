Return-Path: <linux-pm+bounces-33896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B16AB44B31
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 03:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBDB585496
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 01:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364D91E51E1;
	Fri,  5 Sep 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aI1gbfVm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85E81B5EC8
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757035195; cv=none; b=AREQHmw0lyCtpbtNBML7teKzNaXX4KW/tQ3heWSmfX7EeO4Qf50/J3idS0+lhtksBXpO3R7qAN4S9T6EPnahwBlGAg483/udbOsN3fWHbqNcgdVJj67tWGxz9Bf4QMKAUfXrQpaRFbYX3VlSO/e3fqjniyWvt7H0DAj8lfTn9nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757035195; c=relaxed/simple;
	bh=SPMEcY2kDMDcOkU3YM32ifT6JYq/BizXHmHM52QkltI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/6BxR0efqGCz4GlKX1IniCPBiZZQypEasqQxr6J3fe0StA3PbrGGuVxSnYY6y1LOzkt17KCbGOy61Njlm7W/Kb3KmttsNTztzlfzrcivwDd8HecTtsrsSt4dJi08I3sY0xL0DguyEfXE1R7f7Hj84lQ56CjT+JMi+Kn+uv1fhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aI1gbfVm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IJsE9023074
	for <linux-pm@vger.kernel.org>; Fri, 5 Sep 2025 01:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VNEYBWEWlXLwjtgy49W5gP23TQRvq9e3lj0aC3IZqHQ=; b=aI1gbfVmoKc/Gylu
	RIrUED54WIOkqqsp3wRXgPTSh5bS00HFjd5gr6qDogrJIUb8pI28vJYcnDdFgPEY
	NbJP3pGgtIQmzTS9NsvvWr3kMrEH3Zk4peFufXv26/hFULXBSUUqYZBBQUm0obP3
	WvLGyQ5d1O5SIKnOOVbc8sj+eDxyXY4UhzPIbtS3mHwqARKyZvZVB7SxJXbyUajP
	h/D9WLzVlIDRHe61Ac6eFCjRLbDpHntPv6qlYWRrdyedvmcWvu3IZip048bNO0rG
	ABH42ZYaPkGtF2EMhEgvZZqAmmPiKl3FyhcyhSo1qexS4kuZO9F+R4a5zQdyCVWv
	M7Jqfg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0esgtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2025 01:19:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3234811cab3so1900489a91.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2025 18:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757035191; x=1757639991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNEYBWEWlXLwjtgy49W5gP23TQRvq9e3lj0aC3IZqHQ=;
        b=V8HHGaxjjQh+NwDQU4sX/2DWrIWAP3D6d3zQsdRwGgzegkTZbLQH3GtmSUhlZgrkI1
         4S5rOaoQc6VSQE6CXYAMjrohI1y+mkYaAkJveDk0C829i8qr306q8OtbGG4Mut3H+gWp
         o4VxShbIeB02b7V3Vhlf+8BjwqxBTwo+42vYIIdM7tcSAFNjpOTodmYQ/6qfKn9a5ZiZ
         1oNkNT+vxWTTQtmHYnudZGHks0Xux8rVIGh76qD+EMJUuJ2LG9/CVYLklaDwgIps8Yp4
         12vL2i+vBvub8txOdqSkmOg6JIMeoYGiWYoA0mx9Og0OUemEmYq39exSbfRqo6LKtTdo
         ESug==
X-Forwarded-Encrypted: i=1; AJvYcCVFPOCPjSAJKg/hlySVZJZPe9hKLxZQjwFsLKfiXGZSgpR3mChbfZrozppX4CCIJSdRyzl0zjqq1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXwfU7XB5uM9QjDB2Mn6AIQoXQSq7Wwkfxil8JHXJSEKYzxnRp
	ycjiVqg1ZPn2RacJpkuTbdAFBK79YdHoNF+nnzoRL5GcwpFjo+4WgDs5UiHG64ajujcpAfQsWAE
	mk+jZtDNjBLdNCCyPBluypHoa0xoqxRPgn8ZSF5mOkUJ2l9o9Q2EQN11bGFkXvg==
X-Gm-Gg: ASbGnctvFILUi4bAhQsrqQqn9cJxHzz5NlDasKzpEYcqeHGz5YKpVocEZdhciYMvbxz
	d6uFi7KAMLpEcO7H4HEFJmOlGzfAdOnf0mQKvbJCJkYUySCCYDxy62U3shq8J2rQqw0RG7la0v2
	4LUshTWBxPtO0UMo+7jLuJNx3kjU2vl0x0OJM4U2Mj+BatpPwR607tnM5zsPPZZboq9pAnw/4rm
	QBAFPNJpjJ4kDXcHEBC5l1A6DDBpd0Q+jCQoz4W6WY+ZOJ9v4EQYoqrU+oVVslOgMEqGZ+DBW/1
	UXFsHd4wfWOZaqMA8ZCIPlVjkE6vJVOku6YPC0orw0K4BWQ628mur2sjspWvi7gIoI/L7UIrz1k
	s1l1h0mXDvpp2wsarWDe0xLXL1z3QTTmM
X-Received: by 2002:a17:90b:2782:b0:32b:bac7:5a41 with SMTP id 98e67ed59e1d1-32bbac75a84mr2838354a91.37.1757035191076;
        Thu, 04 Sep 2025 18:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXd5Cjdl3Ro9wdntvWhxID9yfxphXvSndLq4UDHA71bD9sJubBRxncTTikTpAe34VSTnPMUQ==
X-Received: by 2002:a17:90b:2782:b0:32b:bac7:5a41 with SMTP id 98e67ed59e1d1-32bbac75a84mr2838297a91.37.1757035190465;
        Thu, 04 Sep 2025 18:19:50 -0700 (PDT)
Received: from [10.133.33.84] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcd6232sm26971003a91.16.2025.09.04.18.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 18:19:49 -0700 (PDT)
Message-ID: <76d12f47-bdb0-404a-9371-788e116c3474@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 09:19:44 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] power: supply: qcom_battmgr: Add charge control
 support
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250826-qcom_battmgr_update-v3-0-74ea410ef146@oss.qualcomm.com>
 <20250826-qcom_battmgr_update-v3-7-74ea410ef146@oss.qualcomm.com>
 <f6372ebb-c237-4409-b3a9-8f458be85034@linaro.org>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <f6372ebb-c237-4409-b3a9-8f458be85034@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uV-AP5_X5bgTM-M3W1jn8WeV8OeyNmqj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfXwYlBnI0lVmYp
 riWZ4pRBAUUGgcmxrZpv7j7xaBxwCT0SULNDw+gvLEWqcgrDV7y7M2dEQM6kRZr2Ww0FukRSZPD
 b89+YoEO6WURpwa0kFVNi7O0VH4MksSi3vMoR8FgHq9rDsYg9YbpKJoWplml9RVm33A8nn1Q0U9
 jmoDthfp8LvkAhuxXcZT90ua+qJaJV46+6k64Thaqc3US6muF5QxMH+DXipXQVAjxCYPg8/+GA3
 KkDd6y++Uh8Gyze6iEbJZs2fSGWDs+K84PoMPOHXUJgVPnSKRR0TVXN8nxNMN2hqHu/wDfBGqlb
 toAkefLa+0wsvj6+kR09GkFUwGkjQX5VlFhTFAQlJ3TFn5rc9P5O9OpvXkVvR9Z+RWOGwiuQUqw
 13H1c97k
X-Proofpoint-ORIG-GUID: uV-AP5_X5bgTM-M3W1jn8WeV8OeyNmqj
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68ba3ab8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=enrrldOF_p-Js0IFzaQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004


On 9/3/2025 4:29 PM, Neil Armstrong wrote:
> On 26/08/2025 09:18, Fenglin Wu via B4 Relay wrote:
>> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>
>> Add charge control support for SM8550 and X1E80100. It's supported
>> with below two power supply properties:
>>
>> charge_control_end_threshold: The battery SoC (State of Charge)
>> threshold at which the charging should be terminated.
>>
>> charge_control_start_threshold: The battery SoC threshold at
>> which the charging should be resumed.
>>
>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>> ---
>>   drivers/power/supply/qcom_battmgr.c | 290 
>> +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 283 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/power/supply/qcom_battmgr.c 
>> b/drivers/power/supply/qcom_battmgr.c
>> index 
>> 174d3f83ac2b070bb90c21a498686e91cc629ebe..23c68eb942f1b213f634e31a45420b3e113e2764 
>> 100644
>> --- a/drivers/power/supply/qcom_battmgr.c
>> +++ b/drivers/power/supply/qcom_battmgr.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/auxiliary_bus.h>
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>> +#include <linux/nvmem-consumer.h>
>>   #include <linux/of_device.h>
>>   #include <linux/power_supply.h>
>>   #include <linux/property.h>
>> @@ -68,6 +69,9 @@ enum qcom_battmgr_variant {
>>   #define BATT_RESISTANCE            21
>>   #define BATT_POWER_NOW            22
>>   #define BATT_POWER_AVG            23
>> +#define BATT_CHG_CTRL_EN        24
>> +#define BATT_CHG_CTRL_START_THR        25
>> +#define BATT_CHG_CTRL_END_THR        26
>>     #define BATTMGR_USB_PROPERTY_GET    0x32
>>   #define BATTMGR_USB_PROPERTY_SET    0x33
>> @@ -92,6 +96,13 @@ enum qcom_battmgr_variant {
>>   #define WLS_TYPE            5
>>   #define WLS_BOOST_EN            6
>>   +#define BATTMGR_CHG_CTRL_LIMIT_EN    0x48
>> +#define CHARGE_CTRL_START_THR_MIN    50
>> +#define CHARGE_CTRL_START_THR_MAX    95
>> +#define CHARGE_CTRL_END_THR_MIN        55
>> +#define CHARGE_CTRL_END_THR_MAX        100
>> +#define CHARGE_CTRL_DELTA_SOC        5
>> +
>>   struct qcom_battmgr_enable_request {
>>       struct pmic_glink_hdr hdr;
>>       __le32 battery_id;
>> @@ -126,6 +137,13 @@ struct qcom_battmgr_discharge_time_request {
>>       __le32 reserved;
>>   };
>>   +struct qcom_battmgr_charge_ctrl_request {
>> +    struct pmic_glink_hdr hdr;
>> +    __le32 enable;
>> +    __le32 target_soc;
>> +    __le32 delta_soc;
>> +};
>> +
>>   struct qcom_battmgr_message {
>>       struct pmic_glink_hdr hdr;
>>       union {
>> @@ -238,6 +256,8 @@ struct qcom_battmgr_info {
>>       unsigned int capacity_warning;
>>       unsigned int cycle_count;
>>       unsigned int charge_count;
>> +    unsigned int charge_ctrl_start;
>> +    unsigned int charge_ctrl_end;
>>       char model_number[BATTMGR_STRING_LEN];
>>       char serial_number[BATTMGR_STRING_LEN];
>>       char oem_info[BATTMGR_STRING_LEN];
>> @@ -426,6 +446,8 @@ static const u8 sm8350_bat_prop_map[] = {
>>       [POWER_SUPPLY_PROP_INTERNAL_RESISTANCE] = BATT_RESISTANCE,
>>       [POWER_SUPPLY_PROP_STATE_OF_HEALTH] = BATT_SOH,
>>       [POWER_SUPPLY_PROP_POWER_NOW] = BATT_POWER_NOW,
>> +    [POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD] = 
>> BATT_CHG_CTRL_START_THR,
>> +    [POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD] = 
>> BATT_CHG_CTRL_END_THR,
>>   };
>>     static int qcom_battmgr_bat_sm8350_update(struct qcom_battmgr 
>> *battmgr,
>> @@ -496,7 +518,8 @@ static int qcom_battmgr_bat_get_property(struct 
>> power_supply *psy,
>>       if (!battmgr->service_up)
>>           return -EAGAIN;
>>   -    if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
>> +    if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
>> +        battmgr->variant == QCOM_BATTMGR_X1E80100)
>>           ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
>>       else
>>           ret = qcom_battmgr_bat_sm8350_update(battmgr, psp);
>> @@ -601,6 +624,12 @@ static int qcom_battmgr_bat_get_property(struct 
>> power_supply *psy,
>>       case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
>>           val->intval = battmgr->status.charge_time;
>>           break;
>> +    case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
>> +        val->intval = battmgr->info.charge_ctrl_start;
>> +        break;
>> +    case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
>> +        val->intval = battmgr->info.charge_ctrl_end;
>> +        break;
>>       case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
>>           val->intval = battmgr->info.year;
>>           break;
>> @@ -626,6 +655,149 @@ static int qcom_battmgr_bat_get_property(struct 
>> power_supply *psy,
>>       return 0;
>>   }
>>   +static int qcom_battmgr_set_charge_control(struct qcom_battmgr 
>> *battmgr,
>> +                       u32 target_soc, u32 delta_soc)
>> +{
>> +    struct qcom_battmgr_charge_ctrl_request request = {
>> +        .hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
>> +        .hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
>> +        .hdr.opcode = cpu_to_le32(BATTMGR_CHG_CTRL_LIMIT_EN),
>> +        .enable = cpu_to_le32(1),
>> +        .target_soc = cpu_to_le32(target_soc),
>> +        .delta_soc = cpu_to_le32(delta_soc),
>> +    };
>> +
>> +    return qcom_battmgr_request(battmgr, &request, sizeof(request));
>> +}
>> +
>> +static int qcom_battmgr_set_charge_start_threshold(struct 
>> qcom_battmgr *battmgr, int start_soc)
>> +{
>> +    u32 target_soc, delta_soc;
>> +    int ret;
>> +
>> +    if (start_soc < CHARGE_CTRL_START_THR_MIN ||
>> +        start_soc > CHARGE_CTRL_START_THR_MAX) {
>> +        dev_err(battmgr->dev, "charge control start threshold exceed 
>> range: [%u - %u]\n",
>> +            CHARGE_CTRL_START_THR_MIN, CHARGE_CTRL_START_THR_MAX);
>> +        return -EINVAL;
>> +    }
>> +
>> +    /*
>> +     * If the new start threshold is larger than the old end threshold,
>> +     * move the end threshold one step (DELTA_SOC) after the new start
>> +     * threshold.
>> +     */
>> +    if (start_soc > battmgr->info.charge_ctrl_end) {
>> +        target_soc = start_soc + CHARGE_CTRL_DELTA_SOC;
>> +        target_soc = min_t(u32, target_soc, CHARGE_CTRL_END_THR_MAX);
>> +        delta_soc = target_soc - start_soc;
>> +        delta_soc = min_t(u32, delta_soc, CHARGE_CTRL_DELTA_SOC);
>> +    } else {
>> +        target_soc =  battmgr->info.charge_ctrl_end;
>> +        delta_soc = battmgr->info.charge_ctrl_end - start_soc;
>> +    }
>> +
>> +    mutex_lock(&battmgr->lock);
>> +    ret = qcom_battmgr_set_charge_control(battmgr, target_soc, 
>> delta_soc);
>> +    mutex_unlock(&battmgr->lock);
>> +    if (!ret) {
>> +        battmgr->info.charge_ctrl_start = start_soc;
>> +        battmgr->info.charge_ctrl_end = target_soc;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr 
>> *battmgr, int end_soc)
>> +{
>> +    u32 delta_soc = CHARGE_CTRL_DELTA_SOC;
>> +    int ret;
>> +
>> +    if (end_soc < CHARGE_CTRL_END_THR_MIN ||
>> +        end_soc > CHARGE_CTRL_END_THR_MAX) {
>> +        dev_err(battmgr->dev, "charge control end threshold exceed 
>> range: [%u - %u]\n",
>> +            CHARGE_CTRL_END_THR_MIN, CHARGE_CTRL_END_THR_MAX);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (battmgr->info.charge_ctrl_start && end_soc > 
>> battmgr->info.charge_ctrl_start)
>> +        delta_soc = end_soc - battmgr->info.charge_ctrl_start;
>> +
>> +    mutex_lock(&battmgr->lock);
>> +    ret = qcom_battmgr_set_charge_control(battmgr, end_soc, delta_soc);
>> +    mutex_unlock(&battmgr->lock);
>> +    if (!ret) {
>> +        battmgr->info.charge_ctrl_start = end_soc - delta_soc;
>> +        battmgr->info.charge_ctrl_end = end_soc;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int qcom_battmgr_charge_control_thresholds_init(struct 
>> qcom_battmgr *battmgr)
>> +{
>> +    int ret;
>> +    u8 en, end_soc, start_soc, delta_soc;
>> +
>> +    ret = nvmem_cell_read_u8(battmgr->dev->parent, 
>> "charge_limit_en", &en);
>> +    if (!ret && en != 0) {
>> +        ret = nvmem_cell_read_u8(battmgr->dev->parent, 
>> "charge_limit_end", &end_soc);
>> +        if (ret < 0)
>> +            return ret;
>> +
>> +        ret = nvmem_cell_read_u8(battmgr->dev->parent, 
>> "charge_limit_delta", &delta_soc);
>> +        if (ret < 0)
>> +            return ret;
>> +
>> +        if (delta_soc >= end_soc)
>> +            return -EINVAL;
>> +
>> +        start_soc = end_soc - delta_soc;
>> +        end_soc = clamp(end_soc, CHARGE_CTRL_END_THR_MIN, 
>> CHARGE_CTRL_END_THR_MAX);
>> +        start_soc = clamp(start_soc, CHARGE_CTRL_START_THR_MIN, 
>> CHARGE_CTRL_START_THR_MAX);
>> +
>> +        battmgr->info.charge_ctrl_start = start_soc;
>> +        battmgr->info.charge_ctrl_end = end_soc;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int qcom_battmgr_bat_is_writeable(struct power_supply *psy,
>> +                     enum power_supply_property psp)
>> +{
>> +    switch (psp) {
>> +    case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
>> +    case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
>> +        return 1;
>> +    default:
>> +        return 0;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int qcom_battmgr_bat_set_property(struct power_supply *psy,
>> +                     enum power_supply_property psp,
>> +                     const union power_supply_propval *pval)
>> +{
>> +    struct qcom_battmgr *battmgr = power_supply_get_drvdata(psy);
>> +
>> +    if (!battmgr->service_up)
>> +        return -EAGAIN;
>> +
>> +    switch (psp) {
>> +    case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
>> +        return qcom_battmgr_set_charge_start_threshold(battmgr, 
>> pval->intval);
>> +    case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
>> +        return qcom_battmgr_set_charge_end_threshold(battmgr, 
>> pval->intval);
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static const enum power_supply_property sc8280xp_bat_props[] = {
>>       POWER_SUPPLY_PROP_STATUS,
>>       POWER_SUPPLY_PROP_PRESENT,
>> @@ -659,6 +831,43 @@ static const struct power_supply_desc 
>> sc8280xp_bat_psy_desc = {
>>       .get_property = qcom_battmgr_bat_get_property,
>>   };
>>   +static const enum power_supply_property x1e80100_bat_props[] = {
>> +    POWER_SUPPLY_PROP_STATUS,
>> +    POWER_SUPPLY_PROP_PRESENT,
>> +    POWER_SUPPLY_PROP_TECHNOLOGY,
>> +    POWER_SUPPLY_PROP_CYCLE_COUNT,
>> +    POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
>> +    POWER_SUPPLY_PROP_VOLTAGE_NOW,
>> +    POWER_SUPPLY_PROP_POWER_NOW,
>> +    POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>> +    POWER_SUPPLY_PROP_CHARGE_FULL,
>> +    POWER_SUPPLY_PROP_CHARGE_EMPTY,
>> +    POWER_SUPPLY_PROP_CHARGE_NOW,
>> +    POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>> +    POWER_SUPPLY_PROP_ENERGY_FULL,
>> +    POWER_SUPPLY_PROP_ENERGY_EMPTY,
>> +    POWER_SUPPLY_PROP_ENERGY_NOW,
>> +    POWER_SUPPLY_PROP_TEMP,
>> +    POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
>> +    POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
>> +    POWER_SUPPLY_PROP_MANUFACTURE_DAY,
>> +    POWER_SUPPLY_PROP_MODEL_NAME,
>> +    POWER_SUPPLY_PROP_MANUFACTURER,
>> +    POWER_SUPPLY_PROP_SERIAL_NUMBER,
>> +    POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
>> +    POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
>
> Is it expected to _not_ have POWER_SUPPLY_PROP_STATE_OF_HEALTH & 
> POWER_SUPPLY_PROP_INTERNAL_RESISTANCE here ?
>
> Neil

No, X1E80100 platform doesn't have battery resistance/SOH information 
exported in battery management firmware


>
>> +};
>> +
>> +static const struct power_supply_desc x1e80100_bat_psy_desc = {
>> +    .name = "qcom-battmgr-bat",
>> +    .type = POWER_SUPPLY_TYPE_BATTERY,
>> +    .properties = x1e80100_bat_props,
>> +    .num_properties = ARRAY_SIZE(x1e80100_bat_props),
>> +    .get_property = qcom_battmgr_bat_get_property,
>> +    .set_property = qcom_battmgr_bat_set_property,
>> +    .property_is_writeable = qcom_battmgr_bat_is_writeable,
>> +};
>> +
>>   static const enum power_supply_property sm8350_bat_props[] = {
>>       POWER_SUPPLY_PROP_STATUS,
>>       POWER_SUPPLY_PROP_HEALTH,
>> @@ -691,6 +900,42 @@ static const struct power_supply_desc 
>> sm8350_bat_psy_desc = {
>>       .get_property = qcom_battmgr_bat_get_property,
>>   };
>>   +static const enum power_supply_property sm8550_bat_props[] = {
>> +    POWER_SUPPLY_PROP_STATUS,
>> +    POWER_SUPPLY_PROP_HEALTH,
>> +    POWER_SUPPLY_PROP_PRESENT,
>> +    POWER_SUPPLY_PROP_CHARGE_TYPE,
>> +    POWER_SUPPLY_PROP_CAPACITY,
>> +    POWER_SUPPLY_PROP_VOLTAGE_OCV,
>> +    POWER_SUPPLY_PROP_VOLTAGE_NOW,
>> +    POWER_SUPPLY_PROP_VOLTAGE_MAX,
>> +    POWER_SUPPLY_PROP_CURRENT_NOW,
>> +    POWER_SUPPLY_PROP_TEMP,
>> +    POWER_SUPPLY_PROP_TECHNOLOGY,
>> +    POWER_SUPPLY_PROP_CHARGE_COUNTER,
>> +    POWER_SUPPLY_PROP_CYCLE_COUNT,
>> +    POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>> +    POWER_SUPPLY_PROP_CHARGE_FULL,
>> +    POWER_SUPPLY_PROP_MODEL_NAME,
>> +    POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
>> +    POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
>> +    POWER_SUPPLY_PROP_INTERNAL_RESISTANCE,
>> +    POWER_SUPPLY_PROP_STATE_OF_HEALTH,
>> +    POWER_SUPPLY_PROP_POWER_NOW,
>> +    POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
>> +    POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
>> +};
>> +
>> +static const struct power_supply_desc sm8550_bat_psy_desc = {
>> +    .name = "qcom-battmgr-bat",
>> +    .type = POWER_SUPPLY_TYPE_BATTERY,
>> +    .properties = sm8550_bat_props,
>> +    .num_properties = ARRAY_SIZE(sm8550_bat_props),
>> +    .get_property = qcom_battmgr_bat_get_property,
>> +    .set_property = qcom_battmgr_bat_set_property,
>> +    .property_is_writeable = qcom_battmgr_bat_is_writeable,
>> +};
>> +
>>   static int qcom_battmgr_ac_get_property(struct power_supply *psy,
>>                       enum power_supply_property psp,
>>                       union power_supply_propval *val)
>> @@ -766,7 +1011,8 @@ static int qcom_battmgr_usb_get_property(struct 
>> power_supply *psy,
>>       if (!battmgr->service_up)
>>           return -EAGAIN;
>>   -    if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
>> +    if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
>> +        battmgr->variant == QCOM_BATTMGR_X1E80100)
>>           ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
>>       else
>>           ret = qcom_battmgr_usb_sm8350_update(battmgr, psp);
>> @@ -888,7 +1134,8 @@ static int qcom_battmgr_wls_get_property(struct 
>> power_supply *psy,
>>       if (!battmgr->service_up)
>>           return -EAGAIN;
>>   -    if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
>> +    if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
>> +        battmgr->variant == QCOM_BATTMGR_X1E80100)
>>           ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
>>       else
>>           ret = qcom_battmgr_wls_sm8350_update(battmgr, psp);
>> @@ -1085,6 +1332,9 @@ static void 
>> qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
>>       case BATTMGR_BAT_CHARGE_TIME:
>>           battmgr->status.charge_time = le32_to_cpu(resp->time);
>>           break;
>> +    case BATTMGR_CHG_CTRL_LIMIT_EN:
>> +        battmgr->error = 0;
>> +        break;
>>       default:
>>           dev_warn(battmgr->dev, "unknown message %#x\n", opcode);
>>           break;
>> @@ -1198,6 +1448,12 @@ static void 
>> qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
>>           case BATT_POWER_NOW:
>>               battmgr->status.power_now = 
>> le32_to_cpu(resp->intval.value);
>>               break;
>> +        case BATT_CHG_CTRL_START_THR:
>> +            battmgr->info.charge_ctrl_start = 
>> le32_to_cpu(resp->intval.value);
>> +            break;
>> +        case BATT_CHG_CTRL_END_THR:
>> +            battmgr->info.charge_ctrl_end = 
>> le32_to_cpu(resp->intval.value);
>> +            break;
>>           default:
>>               dev_warn(battmgr->dev, "unknown property %#x\n", 
>> property);
>>               break;
>> @@ -1280,6 +1536,7 @@ static void qcom_battmgr_sm8350_callback(struct 
>> qcom_battmgr *battmgr,
>>           }
>>           break;
>>       case BATTMGR_REQUEST_NOTIFICATION:
>> +    case BATTMGR_CHG_CTRL_LIMIT_EN:
>>           battmgr->error = 0;
>>           break;
>>       default:
>> @@ -1299,7 +1556,8 @@ static void qcom_battmgr_callback(const void 
>> *data, size_t len, void *priv)
>>         if (opcode == BATTMGR_NOTIFICATION)
>>           qcom_battmgr_notification(battmgr, data, len);
>> -    else if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
>> +    else if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
>> +         battmgr->variant == QCOM_BATTMGR_X1E80100)
>>           qcom_battmgr_sc8280xp_callback(battmgr, data, len);
>>       else
>>           qcom_battmgr_sm8350_callback(battmgr, data, len);
>> @@ -1346,11 +1604,13 @@ static char *qcom_battmgr_battery[] = { 
>> "battery" };
>>   static int qcom_battmgr_probe(struct auxiliary_device *adev,
>>                     const struct auxiliary_device_id *id)
>>   {
>> +    const struct power_supply_desc *psy_desc;
>>       struct power_supply_config psy_cfg_supply = {};
>>       struct power_supply_config psy_cfg = {};
>>       const struct of_device_id *match;
>>       struct qcom_battmgr *battmgr;
>>       struct device *dev = &adev->dev;
>> +    int ret;
>>         battmgr = devm_kzalloc(dev, sizeof(*battmgr), GFP_KERNEL);
>>       if (!battmgr)
>> @@ -1376,8 +1636,19 @@ static int qcom_battmgr_probe(struct 
>> auxiliary_device *adev,
>>       else
>>           battmgr->variant = QCOM_BATTMGR_SM8350;
>>   -    if (battmgr->variant == QCOM_BATTMGR_SC8280XP) {
>> -        battmgr->bat_psy = devm_power_supply_register(dev, 
>> &sc8280xp_bat_psy_desc, &psy_cfg);
>> +    ret = qcom_battmgr_charge_control_thresholds_init(battmgr);
>> +    if (ret < 0)
>> +        return dev_err_probe(dev, ret,
>> +                     "failed to init battery charge control 
>> thresholds\n");
>> +
>> +    if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
>> +        battmgr->variant == QCOM_BATTMGR_X1E80100) {
>> +        if (battmgr->variant == QCOM_BATTMGR_X1E80100)
>> +            psy_desc = &x1e80100_bat_psy_desc;
>> +        else
>> +            psy_desc = &sc8280xp_bat_psy_desc;
>> +
>> +        battmgr->bat_psy = devm_power_supply_register(dev, psy_desc, 
>> &psy_cfg);
>>           if (IS_ERR(battmgr->bat_psy))
>>               return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
>>                            "failed to register battery power supply\n");
>> @@ -1397,7 +1668,12 @@ static int qcom_battmgr_probe(struct 
>> auxiliary_device *adev,
>>               return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
>>                            "failed to register wireless charing power 
>> supply\n");
>>       } else {
>> -        battmgr->bat_psy = devm_power_supply_register(dev, 
>> &sm8350_bat_psy_desc, &psy_cfg);
>> +        if (battmgr->variant == QCOM_BATTMGR_SM8550)
>> +            psy_desc = &sm8550_bat_psy_desc;
>> +        else
>> +            psy_desc = &sm8350_bat_psy_desc;
>> +
>> +        battmgr->bat_psy = devm_power_supply_register(dev, psy_desc, 
>> &psy_cfg);
>>           if (IS_ERR(battmgr->bat_psy))
>>               return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
>>                            "failed to register battery power supply\n");
>>
>


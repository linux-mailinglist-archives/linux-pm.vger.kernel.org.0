Return-Path: <linux-pm+bounces-27985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E76ACBFAB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 07:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A33B3A30AB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 05:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFF21EF38E;
	Tue,  3 Jun 2025 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JgKMG7p0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57E12CD88
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 05:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748929428; cv=none; b=DweYNgjiRMVfY2Xp3Wxi0q67IYHDJ9Z40y3WgkA23nVTYwZUSYEWx5HYQpP8acmJ1mPFCIRVWPNv0rmDOLqka/nvzR+NNvOz8a9HDydXbpSPXObglUwE1YPv6uTDoIHMKGlbC8ldiN86XZiDm+P0fQSgbwguLDzJ2PYWN7r9bdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748929428; c=relaxed/simple;
	bh=I0L1ordB0NyTYxUFKSr84HMgfAD0Tj2Sb0s/30fdfsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSXZSfe9l4LVFlpN7wsfNgLkLKaUC666pwUaejq6/nBPD2dfNuP7fw/xrD7rEtGKv3XWfYwrrIKXqGieNPFPWtmgKsElY+DU5K/DpVjJIIIKnwwk+AUJbO+L2PFQ4rZx0AdHJz66qRezRHLsMvyBw4WkcmAgjImyMnsh1UMmzjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JgKMG7p0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HJm9K007566
	for <linux-pm@vger.kernel.org>; Tue, 3 Jun 2025 05:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GMkQCc6kd/Z8GvZdB6DQV4yES+KskITqFMg1CNz2J6s=; b=JgKMG7p0JtJHYxFM
	LN5Xxvf//frtQy4BpufwPk1kRnlVwmfkmWdZuy79VyTtXNdUSRQllqChCNZeSWHL
	V66VY51ycgC+6+qp87jodr7djTPT7jZt4yaI2doXOo4QY6/yoplt+VsrTYXzEure
	YfPhJaAqwUDwgIlDFGzBTbpaGWFwbUrQat2C0kbG4UP0uYO/3H/P/u0Cr+0C6EUI
	+A0Sw/hVkM1rkXoTNMCkQUX6QLxQpVv7vwjZC/i3cQjQFDFfqstjmrheOFAcB3L7
	B7UqLEd8PcDXhIeLgy/LMqY/p2JzNtEGYYQcYX/ae39SKeOqtRxHiB2J0oSY9tF1
	McDIZw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t9f67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Jun 2025 05:43:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-312f0d0161eso109562a91.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Jun 2025 22:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748929424; x=1749534224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMkQCc6kd/Z8GvZdB6DQV4yES+KskITqFMg1CNz2J6s=;
        b=Iu+9raAo1J7MKN47vSzau2yJpwPssQTRM0UQ9CGa1dVSho7lkxZ9nI9l33fHQMpb2W
         MLDW7TpbLaWFlYw/+yhhvUj2Od6cgmPLxOK1vr0hZC2kFZ7xooD/1NEnvT0J/XF+UuLU
         CM8tbtvLDqbHuD3DfJ5swwRJ7N7zB8WXeD+WE0lEduvyd3oCzVwo4B0oket3cCekJ6bh
         eUeA2oIB+7sdvGgxjHVMxBA1qvJqgLmNxiW+wgUVasSSuwss/Z7g4vjcsqUFv9RTCEMs
         3mKj/DhaoRw44a8pnlgDIZNiXrrS5m8iQbvV/E5TgjEjEd1VCPEjGeQCPTPkYGz93lbi
         GFMw==
X-Forwarded-Encrypted: i=1; AJvYcCUQJGBVrTE+pyebiJP7pSSUIG/QZPiwmcNpQpgtdtX3vc8x9089do+xRT/yydMc1BlyFqDVnMEnow==@vger.kernel.org
X-Gm-Message-State: AOJu0YydJ54Z09FxpuuUg03r3/aQ4xio1jo5cH32hesRBMh302NIGYMP
	3kEZHsF/Pz1vs9BTDXPJxESq7JU2JZiqgTJKnbB1huNsp7lX4zcuU5Yfksr/FQmqv0YEVwzI/Kh
	zepxDIZvn+Edrp2FPw699CQUik78apEQsZpjdmdsfZ3RjTu3WlEFI5JWmuuUXiA==
X-Gm-Gg: ASbGncs3hLZlfH+Ui5NFVwWeXzwdfoJXWT54BJuoJRxB8BHsN+zjjBIklKB2jRx86QW
	6jqDqR+23pJur2X8f2JSa0ml4bhddWDhun0jt2oxch2uP3XYTIkjzlu8jxWe86kZNIRt3SdFGiD
	vVtM/+h6gd9O4hjdOJjkPC6xi9RkAwmE1StTtt7gkA8PDCSxvGlxnvwva6RwylvNoQ/BfXGxHta
	1yHBHKuuCn2DZeaZ9XPekSxbyUf4J/qsdf3cViR4j9GRvkz6xhjy0oQcnea16sbZAsbyEsqFc8g
	1kTR3jVXEC7tEW29YBTUB0T7j12YWBf3lQkSjd4zzmIJJPLY/bN+gX06pUga+6HBB2wscnfMunv
	0
X-Received: by 2002:a17:90b:2243:b0:30e:712e:5739 with SMTP id 98e67ed59e1d1-3124153299amr28110447a91.14.1748929423832;
        Mon, 02 Jun 2025 22:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqrUK36nWAa0tXd5rZY9CM8Gq+srPpqCQF/N7nyUSwu6N0NuNi1OGDl2lBXN27RT9K5Hmzpw==
X-Received: by 2002:a17:90b:2243:b0:30e:712e:5739 with SMTP id 98e67ed59e1d1-3124153299amr28110414a91.14.1748929423354;
        Mon, 02 Jun 2025 22:43:43 -0700 (PDT)
Received: from [10.133.33.127] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-312db4a4de5sm1208445a91.38.2025.06.02.22.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 22:43:42 -0700 (PDT)
Message-ID: <c967c22a-b891-4722-9180-75431137a263@oss.qualcomm.com>
Date: Tue, 3 Jun 2025 13:43:38 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] power: supply: qcom_battmgr: Add charge control
 support
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <497BF3hThnrmYe-YHKmdOyZwdjP3ivm1hFYDDy3-HkSOvkCOMVSkokyhb859mcTarGb55Go5nJLfgsc553u7ZA==@protonmail.internalid>
 <20250530-qcom_battmgr_update-v2-5-9e377193a656@oss.qualcomm.com>
 <8b396edf-e344-47e9-b497-3f7fb35783ed@linaro.org>
 <spfJeVsefz_dTMqOG1lKaUye4O8Jz-RSdLCGtvPIrDMwKC9rxNNY_zKkBFVhdrPMheNf2WMkPsv7ElI4uhBfxg==@protonmail.internalid>
 <3df56548-49ea-498c-9ee3-b7e1d2d85d2e@oss.qualcomm.com>
 <7f001134-e099-492d-8ce5-4122d83a3de3@linaro.org>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <7f001134-e099-492d-8ce5-4122d83a3de3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA0NiBTYWx0ZWRfX5iirlSl7vU8g
 PYTzF24MNNU1LRisY714JVArdMOt2J2XJFhEMs/2Vo9Qk71PxnWKZfTneFFoM/rFPF+27AR0egG
 lxRskw96LKbxHkfA93mjQG7qOz8+0xvjcrpnKqnSMnoFoIINThDniMBFOWUTnZ5q6YPQDBhVYqY
 XpfLZNODN6ziEO9d/sdwgfV89sWNqcYI3Pi+J/GPCacbZNZdwuIEt6NTZDZatcVr3y1Gi+w8NAE
 gVS8S9RU26QADtlXe87KeeU9q2CatJ6MwCP1Yjx0+sleI3u3+LCclGqpY4jEL80Uz63A5mL8/tN
 QdbGcjNAvr/PzCtAr1g9OmzbNp4hnVodQwdm9EvSD/2HgqCiAXvSThIhIkxJDvDtuIQEW8dazTT
 xu//BTTDYFhDZg2r2+OeCACTA3urVStIINxaSp+Rv6fJPCbpjY6iCQ0WROi+SC75Ndke5DeN
X-Proofpoint-ORIG-GUID: prVQ4hIl8gT9ts3d6EhYe8el7fnr_lhr
X-Authority-Analysis: v=2.4 cv=OuxPyz/t c=1 sm=1 tr=0 ts=683e8b91 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=qdlZ5SUtxolC3sdHW0AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: prVQ4hIl8gT9ts3d6EhYe8el7fnr_lhr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030046


On 5/30/2025 6:11 PM, Bryan O'Donoghue wrote:
> On 30/05/2025 10:37, Fenglin Wu wrote:
>> Thanks for reviewing the change!
>>
>> On 5/30/2025 4:48 PM, Bryan O'Donoghue wrote:
>>> On 30/05/2025 08:35, Fenglin Wu via B4 Relay wrote:
>>>> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>>>
>>>> Add charge control support for SM8550 and X1E80100. It's supported
>>>> with below two power supply properties:
>>>>
>>>> charge_control_end_threshold: SOC threshold at which the charging
>>>> should be terminated.
>>>>
>>>> charge_control_start_threshold: SOC threshold at which the charging
>>>> should be resumed.
>>>
>>> Maybe this is very obvious to battery charger experts but what does
>>> SOC mean here ?
>>>
>>> Reading your patch you pass a "int soc" and compare it to a threshold
>>> value, without 'soc' having an obvious meaning.
>>>
>>> Its a threshold right ? Why not just call it threshold ?
>>>
>> "SOC" stands for battery State of Charge, I will rephrase the commit
>> text for better explanation.
>>>>
>>>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>>> ---
>>>>    drivers/power/supply/qcom_battmgr.c | 256
>>>> ++++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 248 insertions(+), 8 deletions(-)
>>>>
>>>> -    if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
>>>> +    if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
>>>> +            battmgr->variant == QCOM_BATTMGR_X1E80100)
>>>
>>> Please run your series through checkpatch
>>>
>> I actually did that before sending the patches out. I run checkpatch
>> with below two commands and I saw no issues:
>>
>> git format -1 xxxx --stdtout | ./script/checkpatch.pl -
>>
>> b4 prep --check
>>
>> Can you let me know what specific command that you ran with it?
>
> do $KERNELPATH/scripts/checkpatch.pl --strict $file;
> codespell $file;
>
Thanks, I will run the commands to check before sending next patch


>>
>>> 0004-power-supply-qcom_battmgr-Add-state_of_health-proper.patch has no
>>> obvious style problems and is ready for submission.
>>> CHECK: Alignment should match open parenthesis
>>> #95: FILE: drivers/power/supply/qcom_battmgr.c:521:
>>> +    if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
>>> +            battmgr->variant == QCOM_BATTMGR_X1E80100)
>>>
>>>>
>>>> +static int qcom_battmgr_set_charge_start_threshold(struct
>>>> qcom_battmgr *battmgr, int soc)
>>>> +{
>>>> +    u32 target_soc, delta_soc;
>>>> +    int ret;
>>>> +
>>>> +    if (soc < CHARGE_CTRL_START_THR_MIN ||
>>>> +            soc > CHARGE_CTRL_START_THR_MAX) {
>>>> +        dev_err(battmgr->dev, "charge control start threshold exceed
>>>> range: [%u - %u]\n",
>>>> +                CHARGE_CTRL_START_THR_MIN, 
>>>> CHARGE_CTRL_START_THR_MAX);
>>>> +        return -EINVAL;
>>>> +    }
>>>
>>> 'soc' is what - a threshold as far as I can tell.
>>
>> I will update it with a more meaningful name
>>
>>>>
>>>>        if (opcode == BATTMGR_NOTIFICATION)
>>>>            qcom_battmgr_notification(battmgr, data, len);
>>>> -    else if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
>>>> +    else if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
>>>> +            battmgr->variant == QCOM_BATTMGR_X1E80100)
>>>>            qcom_battmgr_sc8280xp_callback(battmgr, data, len);
>>>>        else
>>>>            qcom_battmgr_sm8350_callback(battmgr, data, len);
>>>> @@ -1333,7 +1560,8 @@ static void qcom_battmgr_pdr_notify(void *priv,
>>>> int state)
>>>>    static const struct of_device_id qcom_battmgr_of_variants[] = {
>>>>        { .compatible = "qcom,sc8180x-pmic-glink", .data = (void
>>>> *)QCOM_BATTMGR_SC8280XP },
>>>>        { .compatible = "qcom,sc8280xp-pmic-glink", .data = (void
>>>> *)QCOM_BATTMGR_SC8280XP },
>>>> -    { .compatible = "qcom,x1e80100-pmic-glink", .data = (void
>>>> *)QCOM_BATTMGR_SC8280XP },
>>>> +    { .compatible = "qcom,x1e80100-pmic-glink", .data = (void
>>>> *)QCOM_BATTMGR_X1E80100 },
>>>> +    { .compatible = "qcom,sm8550-pmic-glink", .data = (void
>>>> *)QCOM_BATTMGR_SM8550 },
>>>
>>> Please separate compat string addition from functional changes.
>>>
>> The compatible string "qcom,sm8550-pmic-glink" has been present in the
>> binding for a while and it was added as a fallback of "qcom,pmic-glink".
>> The battmgr function has been also supported well on SM8550 for a while.
>> The change here is only specifying a different match data for SM8550 so
>> the driver can handle some new features differently. Does it also need
>> to add it in a separate change? If so,  this change would be split into
>> following 3 patches I think:
>>
>> 1) add QCOM_BATTMGR_SM8550/X1E80100 variants definition in
>> qcom_battmgr_variant.
>>
>> 2) add compatible string with corresponding match data for SM8550.
>>
>> 3) add the charge control function support.
>
> For preference compats and functional change should be disjoined IMO.

I understand that adding a new compatible will have to be done in a 
separate change. However, when updating match data of an existing 
compatible due to a new feature, isn't it better to include it within 
the new feature?

let me know if you think that having 3 separate changes above is more 
appropriate.

Thanks

>
> ---
> bod


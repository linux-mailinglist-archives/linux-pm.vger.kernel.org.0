Return-Path: <linux-pm+bounces-27852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAE1AC8B42
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 11:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13CEA279EE
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 09:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E0722B5AC;
	Fri, 30 May 2025 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m+mie/MQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76A6221D82
	for <linux-pm@vger.kernel.org>; Fri, 30 May 2025 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597889; cv=none; b=gvD9IQVeTiotMI1AwN8BdD6NUEDPsD2NArYLRdRF0rdQYBHYXn9TCb3X3mrXXJudAyNInuFD0XKOJhYqAGUYtzsz9n0GLH714w+n5AWZJlvtjp7C3xB7yMMIZzfADmzN/1pOxbKzIeqIxS7meS0IP0jUyJaq7wobf0teEkDNxGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597889; c=relaxed/simple;
	bh=FiXibMwqe7Bzxv2bD86eTxQ7GxvzILN7JJ8MXnunTTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lB4P1P+3Hw8K6uUgHBV3WjbjPi4FjLl/QVwCbjR8NMdr9jNQg0quEOOp6DdxLoQiNzSsp39O0YKk0L9dt+dG0k4duJp48sQ8xhCRhYv7hfxfeaN53Y+P522GvMjHm+4Ofqtdt6+WCUgKkhkVo1okjXCLmV/Cbi4jTlNDrHH+xNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m+mie/MQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U205ne023990
	for <linux-pm@vger.kernel.org>; Fri, 30 May 2025 09:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zfYXyl7VrRhi9hOpPAB1dRuMBvVrvMKjYSFM2OAmP3g=; b=m+mie/MQgL01XB4R
	H0b1nhJl21Axh657OCSabkJDPAY37Ky5czOBYYlHWVWZQLNfHH2ctOW0l8mO76gY
	zpxEVBxa9YmA0En+bv7wHx4iiD+zrs3o4H7e//46uXASpHEsPzpA+5/gkMX5DcA5
	omhQ9Gmjhh7pl741ah6g1O3wWjwZwbWRzv8exE1IhLeUqKOc75lWff2VrK9VACgI
	0bdeMGWUMlYxxOusCwU69NkFWeaSRF3bMnVdbm5j0TJExJlZlRDHja5PsHVuLBHX
	WcVnLMi2LfQLBjEuYC98un7KXlJuHoY234MsqoB3ZPC7pHf1dyGpHs2ABSrW9vRl
	qPkyIg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46x8d7d791-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 30 May 2025 09:38:06 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74620e98ec8so1707453b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 30 May 2025 02:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597885; x=1749202685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfYXyl7VrRhi9hOpPAB1dRuMBvVrvMKjYSFM2OAmP3g=;
        b=Oh+b42s9UUpcCPsPOnn/rL9ouRFkusCjnZNeANINTL/4wxsgGz7ZFF2festbPwITrw
         I1dv6hMMm9qN05B9T3aTwwdeKagcgLSLa7zk2mm57vkyLgcWH5tFUofbE96TMnYZ+g5b
         7fk8318/7FYFLSe4FCggNeF9aSp8ENDJlNQHeVLr7HEt9AAivVtt/42inZ3JQUNSR2A0
         FuzNJ4Oiy6veOeboouGa6vLUjQVE6Yv+/wXPzIIzcyr4b7rCQciOuatKzhCPtxebqTF/
         ecU+/7sX1MRc/e2n77kSiITADsirh3LhP0b0IKYWfipx20iqLYGkznWjdZtefEMa5TL5
         7ZVA==
X-Forwarded-Encrypted: i=1; AJvYcCVdLz4bEcTqmjcvBgUlm1fS9DxjqEFKnpkPGWt17qP51xy8jeFcMbqaVYFSZOmTPTjY4Ko4NuywlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7xc+qtFKR18f9029VUYAPD9q9RO7kfkByCwUMg1ovUwgh67Nh
	cbn8Cr9Ch5+nEgOKyxWokY5HkaRskOhVTDKZRUEV31rapJnECTiCZDCGuyvmaa6/vmq5ASVu1RL
	yF1r52AYf4kAKEGSY7nBUfXfxO85nn+l5qJKiEFo+cF2NmTY/t2/Kz8rjsxWUsA==
X-Gm-Gg: ASbGncuYbfAPp6i2eRCDbpa/va7XxNEA/6e0V0MmMx/Ey2RbPc+NOtbqereGfwIjBMi
	SwAfFXd0lQ+gLoTz7faPSlJ6TsLrulaVii+a+vxE46hwsmZvweQ+Kbt78QOIfXnGSL/wpOHHNaP
	uCnwbETy+oP/SRzunmgdHXQXpUIHI6cDoM8y+uNnj2GH837R+s4FWKhI+9rO1G1flRWtdwe0Y/P
	Agrdl9bSfMlKRvtzsFXhG7MVCCfCBadcTZDkyolk3q7jxXN6GS7zzPh4cMXLQJrn92c5Ujv4jsl
	PVWo1riA3B9g1e1tqPre2B4VHswXGMW4fwxieJ4aaBhlSQZ7vjCRDAZ6hwT964Ro+gzKiTPQrjw
	Z
X-Received: by 2002:a05:6a00:a87:b0:742:ae7e:7da1 with SMTP id d2e1a72fcca58-747bdbe8035mr3778274b3a.0.1748597885055;
        Fri, 30 May 2025 02:38:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7NO4N0v3Y1dOO+Iz5dJNKpo+fSGcvNyKt4RkjS35cwzJzfWOV/qn3qrS95ChBrq+phaPJRQ==
X-Received: by 2002:a05:6a00:a87:b0:742:ae7e:7da1 with SMTP id d2e1a72fcca58-747bdbe8035mr3778244b3a.0.1748597884623;
        Fri, 30 May 2025 02:38:04 -0700 (PDT)
Received: from [10.133.33.104] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affd437asm2661533b3a.150.2025.05.30.02.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 02:38:03 -0700 (PDT)
Message-ID: <3df56548-49ea-498c-9ee3-b7e1d2d85d2e@oss.qualcomm.com>
Date: Fri, 30 May 2025 17:37:58 +0800
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
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <8b396edf-e344-47e9-b497-3f7fb35783ed@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hKJQgLimlqkfC4B9lIEggTNoLv3_1314
X-Proofpoint-ORIG-GUID: hKJQgLimlqkfC4B9lIEggTNoLv3_1314
X-Authority-Analysis: v=2.4 cv=X8pSKHTe c=1 sm=1 tr=0 ts=68397c7e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=fnrE3p8kPbNp4-9vzRIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDA4MSBTYWx0ZWRfX447ARV3aH7qp
 bTn0T+gllU218zKHWcUvfymmefDlxR6ynybAZn8ESiQHuRGmxhvnc5Rk2LdtdelaHhz3p49ql83
 US+JCSmeTU3pgu78I10X1JGcAPllO4+Z2UsVW+75771aA7fTlof2l04M1inTjUvJ9iuYvaTOfWu
 hLrqrFGeb/spbok3KbwbspW45SLk8J/a6ZjOmuc2MAgfOlysq6F+yjlgYBkUpt0wDlzQUQ/3Y78
 ZPk+NHWVAvslqiuixi3HALXxSCOvOqLTx3KBWmXKFFh04t+LY4wJw7uUOVV+ztfAoz3usxNmASV
 Abi4w7ybLWX470Tx07lhm5neQLbbAicfiPbImfTKDokXcQe0iPG3j19wGOUMp2STQo5yHmxr0qp
 TczIuuBEorYpe7vT7PNkxSl1Q04eE3POpPQiB8MzMFUuNBrKjIL3C+nzrl+TcnWqKiX4A/kS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_04,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300081

Thanks for reviewing the change!

On 5/30/2025 4:48 PM, Bryan O'Donoghue wrote:
> On 30/05/2025 08:35, Fenglin Wu via B4 Relay wrote:
>> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>
>> Add charge control support for SM8550 and X1E80100. It's supported
>> with below two power supply properties:
>>
>> charge_control_end_threshold: SOC threshold at which the charging
>> should be terminated.
>>
>> charge_control_start_threshold: SOC threshold at which the charging
>> should be resumed.
>
> Maybe this is very obvious to battery charger experts but what does 
> SOC mean here ?
>
> Reading your patch you pass a "int soc" and compare it to a threshold 
> value, without 'soc' having an obvious meaning.
>
> Its a threshold right ? Why not just call it threshold ?
>
"SOC" stands for battery State of Charge, I will rephrase the commit 
text for better explanation.
>>
>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>> ---
>>   drivers/power/supply/qcom_battmgr.c | 256 
>> ++++++++++++++++++++++++++++++++++--
>>   1 file changed, 248 insertions(+), 8 deletions(-)
>>
>> -    if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
>> +    if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
>> +            battmgr->variant == QCOM_BATTMGR_X1E80100)
>
> Please run your series through checkpatch
>
I actually did that before sending the patches out. I run checkpatch 
with below two commands and I saw no issues:

git format -1 xxxx --stdtout | ./script/checkpatch.pl -

b4 prep --check

Can you let me know what specific command that you ran with it?

> 0004-power-supply-qcom_battmgr-Add-state_of_health-proper.patch has no 
> obvious style problems and is ready for submission.
> CHECK: Alignment should match open parenthesis
> #95: FILE: drivers/power/supply/qcom_battmgr.c:521:
> +    if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
> +            battmgr->variant == QCOM_BATTMGR_X1E80100)
>
>>
>> +static int qcom_battmgr_set_charge_start_threshold(struct 
>> qcom_battmgr *battmgr, int soc)
>> +{
>> +    u32 target_soc, delta_soc;
>> +    int ret;
>> +
>> +    if (soc < CHARGE_CTRL_START_THR_MIN ||
>> +            soc > CHARGE_CTRL_START_THR_MAX) {
>> +        dev_err(battmgr->dev, "charge control start threshold exceed 
>> range: [%u - %u]\n",
>> +                CHARGE_CTRL_START_THR_MIN, CHARGE_CTRL_START_THR_MAX);
>> +        return -EINVAL;
>> +    }
>
> 'soc' is what - a threshold as far as I can tell.

I will update it with a more meaningful name

>>
>>       if (opcode == BATTMGR_NOTIFICATION)
>>           qcom_battmgr_notification(battmgr, data, len);
>> -    else if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
>> +    else if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
>> +            battmgr->variant == QCOM_BATTMGR_X1E80100)
>>           qcom_battmgr_sc8280xp_callback(battmgr, data, len);
>>       else
>>           qcom_battmgr_sm8350_callback(battmgr, data, len);
>> @@ -1333,7 +1560,8 @@ static void qcom_battmgr_pdr_notify(void *priv, 
>> int state)
>>   static const struct of_device_id qcom_battmgr_of_variants[] = {
>>       { .compatible = "qcom,sc8180x-pmic-glink", .data = (void 
>> *)QCOM_BATTMGR_SC8280XP },
>>       { .compatible = "qcom,sc8280xp-pmic-glink", .data = (void 
>> *)QCOM_BATTMGR_SC8280XP },
>> -    { .compatible = "qcom,x1e80100-pmic-glink", .data = (void 
>> *)QCOM_BATTMGR_SC8280XP },
>> +    { .compatible = "qcom,x1e80100-pmic-glink", .data = (void 
>> *)QCOM_BATTMGR_X1E80100 },
>> +    { .compatible = "qcom,sm8550-pmic-glink", .data = (void 
>> *)QCOM_BATTMGR_SM8550 },
>
> Please separate compat string addition from functional changes.
>
The compatible string "qcom,sm8550-pmic-glink" has been present in the 
binding for a while and it was added as a fallback of "qcom,pmic-glink". 
The battmgr function has been also supported well on SM8550 for a while. 
The change here is only specifying a different match data for SM8550 so 
the driver can handle some new features differently. Does it also need 
to add it in a separate change? If so,  this change would be split into 
following 3 patches I think:

1) add QCOM_BATTMGR_SM8550/X1E80100 variants definition in 
qcom_battmgr_variant.

2) add compatible string with corresponding match data for SM8550.

3) add the charge control function support.

>>       /* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
>>       {}
>>   };
>>
>>
>> -- 
>> 2.34.1
>>
>>
>>
>


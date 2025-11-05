Return-Path: <linux-pm+bounces-37426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CC6C34B6F
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 10:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E00F188677F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 09:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EF52FB0A4;
	Wed,  5 Nov 2025 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YltbPON3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IejCqM7+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604362FB0B4
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333935; cv=none; b=QdApYOAFQ3ZLbTzx47QwwrqhQf+ojFT7/2ocSWWZIi9JR3KTJ5+ElV1KXoEOSl1KU6ykwfPS2fNlVOKHGXw2MzqsMSVyLHf+vezGjfraqiTq3wEUaLhCl316f7qhurjLACjUlKVLdOMnq/7EGf8Prqy5S5TIl5PPhAIzAMMIlJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333935; c=relaxed/simple;
	bh=rhJnISfruwgCtMzDAp2gVfMmqk8wOwH4w/JXlP7TUAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmX3jUkgA0PMEPZG+a2LUa70FX6PLQkgOo2M2AOjSBjQ+uXJUJbvJA8Wos3zjT+sAG3sG2GVzVlbcIdrd9qEQo7zn9l7FfJOo0Q8jBgV9mvVJu0T1AyBCW5p+1qz6sElz02oCpsSvIz5HQpWAqG4yXsdj2ES1IyXJlOID020YdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YltbPON3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IejCqM7+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A58FSc03049559
	for <linux-pm@vger.kernel.org>; Wed, 5 Nov 2025 09:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z+6KNSa/c84U6Pn9MoZGbo7B95YVHxLE9mFgR/bY4NE=; b=YltbPON3Kb5XGvfB
	AGfZh7VVPxBzKSx9NquvfafRy7kuzVRXWu0MAHYXLNazg7kAnE8MHJzpj7Wjv0yt
	lgJ0diI5FVyzvJch2XxqtzCJftkY2tQDBjnctzNLepvQZVWnivMcDx7nUdeFvb70
	bedjeeHi65EhOBE3Ek/hQru+qrpe95TcXQeN9LN9x2DDPDfYe++Kd4hBK9AFZnuP
	5qPsJUG++c4KtGgTE2Hc04blCojlNUHGEkN+85LzOLB5O5sc6vN01QumcYgcP9uq
	V9pgYmNYg720QDg58Ogd2S+Emy4c8X/RFKgmyejkpb/ENWqLUJZFT4MDOrPH8Qn0
	gojqHQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ex7urh7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 09:12:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8adc67e5340so101303485a.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 01:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762333931; x=1762938731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+6KNSa/c84U6Pn9MoZGbo7B95YVHxLE9mFgR/bY4NE=;
        b=IejCqM7+oxC3TO/ySi0+13z26VXc9WOdhvM2KVrdpbIezQxl2wxwuXDlBaMQJCtoMt
         2BnOKFAgGKSkdlqRUWCBmFF1l4KSZjJX4+6x5SZWnyUVHqPptXf2NlZVdzKQSNIm9ARy
         pqpAUrul8QYX8z+m4LGp+5p/MuFLhhk6MLE6GDk+Vz5br1FpKeK0XbTp3A5U+19s+PZA
         jrhRaQpCUay+TssRzZBetn322fGZjltgsp6UZ2ns5NEQSIbPy2E7n6PF1hHvK1HapLy7
         MeJL/Lj5A8KHZGJU5WOPZM6M0qWRGVgCxLJvLygaXWKa6XJHhuzoSf+m9b6z8wU3NG9k
         /hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762333931; x=1762938731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+6KNSa/c84U6Pn9MoZGbo7B95YVHxLE9mFgR/bY4NE=;
        b=keiDt83KJ6UcaftB0FrTjdAehy9UiGsN5UwIOu+xay+E5Vr6/NgnFkbOlWIlLUGk38
         7d3EG/omVVj+yUHB9FcgZdQHA0vXm8uN4LtcIrc7Iwmhdn9cte/fj3R04YNdXlpwiKd8
         oDfVnVyWNcmDHoAeQs9pSftykl0Sd4JUuHd15DuwX8sWSJ7qMNFXHrvb3wBIFXgKPC25
         1t85To+diskeZFD+vN/jw2kQqHFsx8YUluKSwLQ2RbpRNUUCAjLEiLhxDYWvdenC7qXJ
         I25Oubs+uZ0ujaTr9gI2pKLk5FVPO9dCjc/L0bhhdHnYwqrtrXuaWIXPCoDei0mbwt62
         LpMw==
X-Forwarded-Encrypted: i=1; AJvYcCXFDh5gt3VoYcd4IGrHcmQjvFCdNfrSKIP91uyzT3y6duDh/tAokw0Ua0DafH7v3z0jwLE0IxVhoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhIYflszM+3cP+yJwtU4CCmtLdUtGv8+jrrT96LPV/GbXz1Hjc
	G1/uzjLflzXAOXJL8RVfLA5qhYcf2MVm/PJqZQ73D4RL6Hh0BoHT7igOpcMLma9LAkAEctfdd5D
	VgH7Pttbfc5zEeVT9SP8rPr5KezNWNofvfDFC91YrXId/Scwi3Qq+rrhUzKW+XA==
X-Gm-Gg: ASbGncuaNAxjiVy5PZkVPun86Z2YG2HPiasjwYM+Gh8IcvVf+vXAPEgJhDfuIAjA48P
	jpiXRm9YKLG/5fzQrMabHC67pWTiTFlX0Tk0dzVnmKDgCmUfEx3BjCIzvInAv6nGDps+njKPEjQ
	IRkIc5s7sGuUmD+kMDzKx4lMNTd2X8Yo+ED+P/wLJQ2TfqUEDdttyz6R9h3MzfIDbigWbFZ5VSk
	K7Ka8TMXFhfidpSKiIaxqX9IrgX2D+LHwgNSx71RKkH3hm4V9kVzElbVoz5RxCpqvmAVbn5PrBt
	rDd91pHA6GWSrihQbeD5Yib+9a+12pM3EMUEwi8+QqWEH1h5hqLTfJfHa7JARPAQjSpjaiKuiF4
	zf8IKZHO3RN6bGAooK5NAZmcicanygBpGkr9ThjGVa+PGDCbICpM2Lcsy
X-Received: by 2002:a05:620a:4416:b0:8a1:a5c5:ef18 with SMTP id af79cd13be357-8b220b1d713mr213872885a.7.1762333931462;
        Wed, 05 Nov 2025 01:12:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGJ9wkyXw8sJ2xb7871IJGD1FzGWrKC1uMfjebX8VCApHvBSwyXgL4BOJndaBNFQvahb8afg==
X-Received: by 2002:a05:620a:4416:b0:8a1:a5c5:ef18 with SMTP id af79cd13be357-8b220b1d713mr213871085a.7.1762333930898;
        Wed, 05 Nov 2025 01:12:10 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72406568a2sm430577166b.73.2025.11.05.01.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 01:12:10 -0800 (PST)
Message-ID: <cb1ced66-8190-4462-99cf-72ec51da6536@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 10:12:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251104140635.25965-1-ansuelsmth@gmail.com>
 <20251104140635.25965-2-ansuelsmth@gmail.com>
 <d3f2810f-7361-4a23-adb3-32a73ad50519@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d3f2810f-7361-4a23-adb3-32a73ad50519@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA2OCBTYWx0ZWRfX7sM9oTH1cN2w
 p6HOQdeKSTHJvZKnF02FE1wTY7KAkzUxoHWzTPcXLtvOAi61+Y0/Yp3KUEGInZNQ83bG6cRFBw9
 wRvZapSwN4xTWAw45y6Gt91/wzWjQTifYJ0EWPpLM/IvbT/VRO+TM0JUgSdGOyWp19ArRB/oM8F
 2kQ3Ov+3VZndVbs17aKTvy9axWv42EVqgEnT1ojyA+ughmjYSryz8osiSp7MSwoq5PXPuZjeNVF
 Q8vZ90BDyel6THT1VJgHpXq+I5O25SUozFitfu/1VGaTT5KeIZ/PQ2neRDbCJcIUkAT96y4hJZ+
 z8dKZ+H92jCE1nZcgtRVaCIQtN0jv47+ANGFMmsdYm5ozoXIfmyuyFZITaNHcp51Ky9Uv3ZnCKQ
 kPwCjGU9EGZpW+o+W4CVXZK4ZLw87g==
X-Proofpoint-ORIG-GUID: 68Dgr7E1kfgbDQVsZ8wXj3b0tizp6lZC
X-Proofpoint-GUID: 68Dgr7E1kfgbDQVsZ8wXj3b0tizp6lZC
X-Authority-Analysis: v=2.4 cv=auy/yCZV c=1 sm=1 tr=0 ts=690b14ec cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=6tCzVfzfn33JckLbtDwA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050068

On 11/5/25 9:05 AM, Krzysztof Kozlowski wrote:
> On 04/11/2025 15:06, Christian Marangi wrote:
>> On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
>> case for some Google devices (the OnHub family) that can't make use of
>> SMEM to detect the SoC ID.
>>
>> To handle these specific case, check if the SMEM is not initialized (by
>> checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
>> OF machine compatible checking to identify the SoC variant.
>>
>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>> ---
>>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 35 ++++++++++++++++++++++++++--
>>  1 file changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>> index 3a8ed723a23e..17c79955ff2f 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>> @@ -252,13 +252,22 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>>  	return ret;
>>  }
>>  
>> +static const struct of_device_id qcom_cpufreq_ipq806x_match_list[] = {
>> +	{ .compatible = "qcom,ipq8062", .data = (const void *)QCOM_ID_IPQ8062 },
>> +	{ .compatible = "qcom,ipq8064", .data = (const void *)QCOM_ID_IPQ8064 },
>> +	{ .compatible = "qcom,ipq8065", .data = (const void *)QCOM_ID_IPQ8065 },
>> +	{ .compatible = "qcom,ipq8066", .data = (const void *)QCOM_ID_IPQ8066 },
>> +	{ .compatible = "qcom,ipq8068", .data = (const void *)QCOM_ID_IPQ8068 },
>> +	{ .compatible = "qcom,ipq8069", .data = (const void *)QCOM_ID_IPQ8069 },
>> +};
>> +
>>  static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
>>  					     struct nvmem_cell *speedbin_nvmem,
>>  					     char **pvs_name,
>>  					     struct qcom_cpufreq_drv *drv)
>>  {
>> +	int msm_id = -1, ret = 0;
>>  	int speed = 0, pvs = 0;
>> -	int msm_id, ret = 0;
>>  	u8 *speedbin;
>>  	size_t len;
>>  
>> @@ -275,8 +284,30 @@ static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
>>  	get_krait_bin_format_a(cpu_dev, &speed, &pvs, speedbin);
>>  
>>  	ret = qcom_smem_get_soc_id(&msm_id);
>> -	if (ret)
>> +	if (ret == -ENODEV) {
>> +		const struct of_device_id *match;
>> +		struct device_node *root;
>> +
>> +		root = of_find_node_by_path("/");
>> +		if (!root) {
>> +			ret = -ENODEV;
>> +			goto exit;
>> +		}
>> +
>> +		/* Fallback to compatible match with no SMEM initialized */
>> +		match = of_match_node(qcom_cpufreq_ipq806x_match_list, root);
> 
> Aren't you re-implementing matching machine? Or actually - the socinfo
> driver? You are doing the matching of compatible into SOC ID second
> time. Just do it once - via socinfo driver.

The issue here is that if SMEM is absent, the socinfo driver can
not function and this is a contained workaround

Konrad


Return-Path: <linux-pm+bounces-34736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0323B59A6E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 16:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFFD41771FE
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 14:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E156341655;
	Tue, 16 Sep 2025 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TR9rpoOw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6ED276045
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032913; cv=none; b=QjDk/Zz74rhw4jlvBxuvGV9kbqRaWRrD+cvZqPl1k6N4WROQbMrxEY1TlcbS2+n5rstM6+3pu8cHyNxB9ajJW2KOC+l997IuEm8N+NrOwfLshFt3gVHYZHl2AFYqaPdkgGcXQs04rFXDRsaFzDKmJidrHf+jc5ShEi30itdgSC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032913; c=relaxed/simple;
	bh=TGwn+qZGfOX+MW0qfzMQE+Xk3Fp2SmWLOYAprwwIKmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D48oyvFlow8EZHxXBRXaK3ttrZ04InZYHM88Y9evTEJp1Tiio7yF0mqFyQiTpJaZfshLB9Twd7v5Uv/UkjALDXrFHQD5j89F7O4xuugc3fVDwn7kdXco6R5uNZhHgejLqh9PNfzyP2PX2/pLkyyJMO4Rzfm27NK55GlvbFZWEvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TR9rpoOw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9d8br014280
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 14:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ccCP+yCNIjixDrCZqrWb8pSS4BdGxszDeBOi4Pe3O4k=; b=TR9rpoOwhJV4dkrm
	7RWVU8L5SQmMyr2iyOZXyEsR8+q5IsPuR7jzSWiUnd67vJeWIrtR3/u48Vg2nj6Q
	9V8CZ4oGxThhtvMhZOeoSBajb0aGu59/dcOEU/jZcvWrs6W9MmTHGsbWAop+utvR
	KeNUaBResHNykpXG7wSSt9coLFTNYKOJy0EzMSTGJzmsynTxFi0ZOQXxjwlF84T/
	5qxuiWFjSz0HpJWwBQ+qAH9e7E0qSl5blRnQgp8qL6cqu+l86ynwEOPvO9mKJGsd
	rlmIQyIeUfytnPrT0GMOg87tcRAIzrQa8XazEuKY8goqz0n93DIFBUoSLmA536vS
	UpIy5g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496x5at9q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 14:28:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24ca417fb41so54066325ad.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 07:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032908; x=1758637708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccCP+yCNIjixDrCZqrWb8pSS4BdGxszDeBOi4Pe3O4k=;
        b=MAw93tSQFHYqJe2/Kuq44UMVohaEkqanPBgpCqnxDnwT7B9YfLft0h8MgSMhsGJnfZ
         2XWwIegS3hfZxGAEKGbD0kugucbohviOPEcDl+2ABOE2RxIUrz84yXsLsH7VpYYfTC5p
         IO4uVhioupaxtRiPUa1VS2OpKOI4K9+7divO307LjUyh/1qfH7T/DrYPkdl7Gn/EXMw6
         rsH55wAg98TwHWSTymSsnw5FTDL0VAIL3dUp+NVc7uz7uVMjbBs6KtmiabHN/qY9ayLG
         TjekrzxDz0WkdSFEqaeyZkXICN4OEf3I0C5Xgq+ij+jAhyo4tCNMNtdWllJzdvO4vlmc
         OJRg==
X-Forwarded-Encrypted: i=1; AJvYcCWpNdk/YeX36wGF77Wa6SF2TSZIcov4MmtSIDSYRYwdBtBa75rrqayfkKav0BE/je+hLy5wI0fozw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8n9WVTl+c6ueCR1rVHw7PKm29oNejUUT0X8eSe83Y7BzJTk+i
	zAYSbHeLYEPTwOIIx9lna4YedqDWmIfZpwLSBppOQYGL5pkupsglM2bLu4jOHsx5hsuLwrWh1Qu
	b2kPX8jxteyztUscuXAmjs0nMD7OybyqyOKVO18hoT0b1Kju3Wbk12JtIQ2uuCA==
X-Gm-Gg: ASbGncuz75m+uqjQkq4wLzKiyc+9zyRx775U+lJ8b/ouTqriGK8k+NcX6EWDaZam1T/
	eol6xYNvcJ6KKGeAnJGSUIE0LYq/+KHlOM5f0unIJC2p5prcmO1AyTM15iMtcuobyFBDmvaatYl
	BmeBY2O0xbwOM0NYh3h/WV5ETuN9FQ6D/aHp1rLNQ7/uSrcFrdhNiFeMz7qMy9DtUYLFnly2Lff
	8h0Ht+iCSseT+CwdP7ihPPuv2DYsxJSwjN7+uYzvBnYTJvVcH+7GSoBRt9MdLXxKKwqivKkMYxF
	bOYQFx/tmfGDBt+pNK2Ll+zG3zufAL2jsryGI/Dqo176bMycQPZx1tTpXuzlXgmzjt7NdCPJ
X-Received: by 2002:a17:903:230a:b0:267:e8a9:7e72 with SMTP id d9443c01a7336-267e8a98193mr20321755ad.12.1758032908017;
        Tue, 16 Sep 2025 07:28:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXZ/OLgiEOc7ZsA33aPYfpDR5hJxcewlrm4+2ZHd+0WezSt0QCPDrGqDniIYPdLk4UlZzVgg==
X-Received: by 2002:a17:903:230a:b0:267:e8a9:7e72 with SMTP id d9443c01a7336-267e8a98193mr20321365ad.12.1758032907504;
        Tue, 16 Sep 2025 07:28:27 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm73585485ad.45.2025.09.16.07.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 07:28:27 -0700 (PDT)
Message-ID: <5d662148-408f-49e1-a769-2a5d61371cae@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 19:58:18 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-4-jishnu.prakash@oss.qualcomm.com>
 <20250829-classic-dynamic-clam-addbd8@kuoka>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250829-classic-dynamic-clam-addbd8@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zqohaoXKch5ny-0DGPdTGAi8uEJbuUYK
X-Proofpoint-ORIG-GUID: zqohaoXKch5ny-0DGPdTGAi8uEJbuUYK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDAxMCBTYWx0ZWRfX6ZdoAdSBgkZ9
 1EvyENScQFU4YTCbHnswsAzfMyTRGPIhdwWljlw+VX96CZlYC7hOVxSUK/xYbhXGZD7PPuZc89v
 V8Hud//ECqm4LgrDm0+6ry0SA9dM9BJwYiVh8h5CmEmuFTGtyIJLVqC+OYECcoxe+V5NmLUMfWx
 /i9ZmsuVLT1LuwSaBqSCpZIS5KCho0c7uB5m1K3V58bFVs5bgWTt5wSNahrxv/TNVaXdgXelPFO
 skzT2TFBZ0vCSDwV2ekTPTF1je4a8a68DmzVvP5GjMXEBXiV07iAa5iZ2bULNEic2ojL5453Rl2
 ykBZLDCm9p+5B/qwjw65HyT+7UFXY5T/CiCxVwjeJVkfh+3ddS/YxGs2OPLjb8yoMpIvVP78fPz
 YbAFbjXq
X-Authority-Analysis: v=2.4 cv=WpQrMcfv c=1 sm=1 tr=0 ts=68c9740d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8
 a=NBYwllkvtaGzK6LsQGIA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160010

Hi Krzysztof,

On 8/29/2025 12:49 PM, Krzysztof Kozlowski wrote:
> On Tue, Aug 26, 2025 at 02:06:55PM +0530, Jishnu Prakash wrote:
>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
>> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>>
>> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
>> going through PBS(Programmable Boot Sequence) firmware through a single
>> register interface. This interface is implemented on SDAM (Shared
>> Direct Access Memory) peripherals on the master PMIC PMK8550 rather
>> than a dedicated ADC peripheral.
>>
>> Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
>> channels and virtual channels (combination of ADC channel number and
>> PMIC SID number) per PMIC, to be used by clients of this device. Also
>> update SPMI PMIC bindings to allow ADC5 Gen3 as adc@ subnode.
>>
>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> ---
>> Changes since v6:
>> - Updated SPMI PMIC bindings to allow ADC5 Gen3 as adc@ subnode and
>>   copyright license in newly added files.
> 
> So you did not implement my requests/comments from v5? I did not request
> above, I had many, many other comments.
> 
> 

In my v6 patch, I had implemented all the changes you requested in
my v5 patch, that is what I had meant by the last part ('addressed other reviewer comments').
I will update the below section when pushing my next patch series
to list out all the changes explicitly.

> 
>>
>> Changes since v5:
>> - Added more details in binding description explaining how number
>>   of SDAM peripherals used for ADC is allocated per SoC.
>> - Renamed per-PMIC binding files listing ADC channel macro names 
>>   and addressed other reviewer comments.
>>
>> Changes since v4:
>> - Added ADC5 Gen3 documentation in a separate new file to avoid complicating
>>   existing VADC documentation file further to accomodate this device, as
>>   suggested by reviewer.
>>
>> Changes since v3:
>> - Added ADC5 Gen3 documentation changes in existing qcom,spmi-vadc.yaml file
>>   instead of adding separate file and updated top-level constraints in documentation
>>   file based on discussion with reviewers.
>> - Dropped default SID definitions.
>> - Addressed other reviewer comments.
>>
>> Changes since v2:
>> - Moved ADC5 Gen3 documentation into a separate new file.
>>

...

>> +
>> +  The interface is implemented on SDAM (Shared Direct Access Memory) peripherals
>> +  on the master PMIC rather than a dedicated ADC peripheral. The number of PMIC
>> +  SDAM peripherals allocated for ADC is not correlated with the PMIC used, it is
>> +  programmed in FW (PBS) and is fixed per SOC, based on the SOC requirements.
>> +  All boards using a particular (SOC + master PMIC) combination will have the
>> +  same number of ADC SDAMs supported on that PMIC.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,spmi-adc5-gen3
>> +
>> +  reg:
>> +    items:
>> +      - description: SDAM0 base address in the SPMI PMIC register map
>> +      - description: SDAM1 base address
>> +    minItems: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +  '#io-channel-cells':
>> +    const: 1
>> +
>> +  "#thermal-sensor-cells":
> 
> Nothing improved here, still mess with quotes.

I will fix this and check for any other things to fix
before pushing the next patch.

> 
> I am not going to check the rest of comments, because:
> 1. Your changelog is vague and claims you did not implement them,
> 2. b4 diff does not work, base-commit is unknown.
> 3. Main changelog is even more vague.
> 
> You make it difficult for us to review your patches, fine. You will get:
> 
> NAK (plus one more comment below)
> 
>> diff --git a/include/dt-bindings/iio/adc/qcom,spmi-vadc.h b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
>> index ef07ecd4d585..b1b89e874316 100644
>> --- a/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
>> +++ b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
>> @@ -300,4 +300,83 @@
>>  #define ADC7_SBUx				0x94
>>  #define ADC7_VBAT_2S_MID			0x96
>>  
>> +/* ADC channels for PMIC5 Gen3 */
>> +
>> +#define ADC5_GEN3_REF_GND			0x00
>> +#define ADC5_GEN3_1P25VREF			0x01
>> +#define ADC5_GEN3_VREF_VADC			0x02
>> +#define ADC5_GEN3_DIE_TEMP			0x03
>> +
>> +#define ADC5_GEN3_AMUX1_THM			0x04
>> +#define ADC5_GEN3_AMUX2_THM			0x05
>> +#define ADC5_GEN3_AMUX3_THM			0x06
>> +#define ADC5_GEN3_AMUX4_THM			0x07
>> +#define ADC5_GEN3_AMUX5_THM			0x08
>> +#define ADC5_GEN3_AMUX6_THM			0x09
>> +#define ADC5_GEN3_AMUX1_GPIO			0x0a
>> +#define ADC5_GEN3_AMUX2_GPIO			0x0b
>> +#define ADC5_GEN3_AMUX3_GPIO			0x0c
>> +#define ADC5_GEN3_AMUX4_GPIO			0x0d
>> +
>> +#define ADC5_GEN3_CHG_TEMP			0x10
>> +#define ADC5_GEN3_USB_SNS_V_16			0x11
>> +#define ADC5_GEN3_VIN_DIV16_MUX			0x12
>> +#define ADC5_GEN3_VREF_BAT_THERM		0x15
> 
> You cannot have empty spaces in ID constants. These are abstract
> numbers.
> 
> Otherwise please point me to driver using this constant.

These constants are for ADC channel numbers, which are fixed in HW.

They are used in this driver: drivers/iio/adc/qcom-spmi-adc5-gen3.c,
which is added in patch 4 of this series.

They can be found in the array named adc5_gen3_chans_pmic[].

Thanks,
Jishnu

> 
> Best regards,
> Krzysztof
> 



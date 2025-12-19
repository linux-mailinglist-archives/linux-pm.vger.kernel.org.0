Return-Path: <linux-pm+bounces-39706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE283CD0036
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 14:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D33913094B7C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 13:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF824319855;
	Fri, 19 Dec 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WUnwpwtH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R7X1ihre"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB131A254E
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766150037; cv=none; b=gLR4Vg4sDwEfGYsiTguH/JE4zwfxI79TilrXriNl3RbOhxmmJU2DnwCgNp8kQ6CNjs2XmtG+g719nPCFZcsZ427aHIJ1GtFaVVdfp30hHpacnj4N4Enxewl0hCgGnhmEFJbpmqHjFdH+hasR4VeLxn+l0XVtyyEFsB+pPZpLHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766150037; c=relaxed/simple;
	bh=LsZk8BtGewNpCcVNoqX/+ftW+U7rkPSJzxmPQuu1JWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtwtZDVsvpQwmQq29H/Y1gYaYCGinsvAopcXVeK2C5FFL4ej2EOOM0XorUVrocwG+twMlGiR15uy9N6W6llijxVqcrtEyhzlD8v67ibhf4HDxeJ43WB1rrXW9OmPCwjs+RoMjCQuMveB42tA/p9nL1knRDGm9xQewMC/T589usg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WUnwpwtH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R7X1ihre; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJB968m4101371
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 13:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DZ4cWgr492jZ4A0tRfEHTUVnW4j07Cs3++LAWhIPvXI=; b=WUnwpwtH7P1M6alv
	uVW54/UjP/42vHmI3DKVGc3RW6I5bzghBAxM4VbLjCStETJjqsSmitCoQV6u30WJ
	MtjatfsHj/t+/qO6xQ7Mkdj1Hps/wVFu6pte3Tkqp2If7EUrfxjWk4tV178mKGQu
	LCbTPV7FDD3Cc654EbPqzp1M5RKeA3XzIpMwe82KkAvpWmYIfP5p7GVXE0eNHddF
	dYg3QSpdJd3WZ7PexAAJs+ShTXUV43FjzEJNZycQfj3NHJy5mZBVZdENIXoXJTz+
	HiYxVgcp1Uu6NbHkPOegxY6tHZOg+6jgw7AwJxkd4qC1tIVf71dmEWm8jWcmcJWu
	ToVbkw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2c2r3j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 13:13:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b630753cc38so3107482a12.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 05:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766150035; x=1766754835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZ4cWgr492jZ4A0tRfEHTUVnW4j07Cs3++LAWhIPvXI=;
        b=R7X1ihreUGm5eULZtELWYJcGL14MqDGuj6/dnlmFPyPo7oxlnYAKbMC0RnR+NLumfY
         hv75GUGDISZ9Hdcywi+79lULamoMjxXDltSlBOeap7qq80l31PF+QkMcCdjKHF8DQvh0
         XZdsCbDScKhjvAwpAZrr+EtpsgPxcJVXd8XxcUUx1p7bouuS5oINHISyjLkttboVsu0O
         E11llQ7gQnXX4QrgEJa7lU6Y2le4MROfz3QXXFfmgODd0ivbyUJSvYJfohEo6GxZMOcC
         iM7OFYlncf5yKNdLLGA1CVtzlcvs3wZIqd5oFMoG/vbJKqo5dwX6jcJboO5K/xq+qpbr
         71lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766150035; x=1766754835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZ4cWgr492jZ4A0tRfEHTUVnW4j07Cs3++LAWhIPvXI=;
        b=RdK6TJGbgYMiyzmgru1eHAyNEPSCHwcgEPf4PkVit8YatZxihvAtI3TR38MGoUNGlO
         D7Zxrg70PM6nxdFaHLQHTWfLHHl0ngzP8y7fE3u+oGP8kIjewKA2xUdXWRixF65PUX9o
         RJ6TWm3xVsTj/+IlvjU9PybmNpGoBddKVJtrWG9w9JrbMg32pa5gkg5xZP90OU0+1U7/
         dIbKelGo5PDPBM9vKks1TiEqspBdsmxadFhqX1M+FIvuzmd61pTjGH/9wp+zHGTPqSPi
         0z6F5745d18TZU+Q/3Xj4rYOWCHtBGMAKBT1Y7mINIijQOaYN1aH4ETNK2TwHNbsYiik
         mvqw==
X-Forwarded-Encrypted: i=1; AJvYcCVefrRIt+xpY7Ox8ajsGtrCdx+wfnA0ELRkiDYBxC85oRO/VHCCmEKt3rgKGQIhOcuqh/eU2fjLtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgVMOrl8cYZmM6S5K3meuGBX/IzS2365ZAVxPPTcOZMJzzw0MF
	ibIzmxhe1xnM6LsubZrICjUtW8O5sZaG+G5acs57v2HXKACNW4qwwk9qRx7NeGBGmMt8I4ytFlO
	lZoLlQVcaM7IXPEtRxKaG0mM+wGie02S3vjR5wncoxyxgTWaUjqUHxQHHcRkIFA==
X-Gm-Gg: AY/fxX6swuEIH8aKdXHxBeXoJGKJ7k6rXJ09B1WG7lqJ2UIDTwCftS84PvIG/fKs3Nn
	zbedWx7G5jkZycOb84aophZ9c4XEzCD/ABDLg7m+EUPOjGumt8A3wJoM0g5ciPxad3PH1K7SPJR
	WrItTOw2Rp+JOV6E26SbALB7lw5jgSYObuH3PDz3FlspWi09crVoS4XDf4hpNiwneiFWEMKjN5V
	bgBshvnAQPAXUIw7b4yevSvmAYJbP/T/mE04TEc0rgYFR1SKkJWAO1SWSFYdJnECyChk5voNSvR
	mqfnwHiWLg4C1a0Pjfc8psfWBdi5Gr9EsjciZdkU1umIs8uh419gNoVl5YVh6uq6VeKYiWjLYoR
	CJLKJj/252c5+nvun021q5ZJRT6+LynhdQOr1EAaMMQ==
X-Received: by 2002:a05:6a20:4325:b0:34f:afaa:125b with SMTP id adf61e73a8af0-376a94cb491mr2907442637.50.1766150034585;
        Fri, 19 Dec 2025 05:13:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYCPPY9VYTPF6C/Lkfrn8noIWAo3NlMi+7Jam2/Qm6HLPcczfWWp2MFNi11cChB7Wb8OSBCg==
X-Received: by 2002:a05:6a20:4325:b0:34f:afaa:125b with SMTP id adf61e73a8af0-376a94cb491mr2907407637.50.1766150034097;
        Fri, 19 Dec 2025 05:13:54 -0800 (PST)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4d2bbsm23264525ad.55.2025.12.19.05.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 05:13:53 -0800 (PST)
Message-ID: <b6e715c3-24c7-4d44-ae86-22809cd3fc13@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 18:43:44 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski@linaro.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, agross@kernel.org,
        andersson@kernel.org, lumag@kernel.org, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org
References: <20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com>
 <20251127134036.209905-4-jishnu.prakash@oss.qualcomm.com>
 <vzoyeyhzrmvkhjeif6yuyxjc4moq6yzc5zuz7izeipz27f6cd4@csaqkjur3r3r>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <vzoyeyhzrmvkhjeif6yuyxjc4moq6yzc5zuz7izeipz27f6cd4@csaqkjur3r3r>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDExMCBTYWx0ZWRfX4WzGwivHRmD9
 6mQIDXo3Ub07rHric8xcGdSWtJgRi2p5ciz+4DFXLvTsRBe/mr8b0dF18yvZP2JjFgiab2BKz7f
 YAi9PlLQ76F+gxL85VRo8JDl17bl/x4CI4ifCtwjLXPwTN0QPQlf2SVSTsLjaigVxa7xYSanLHK
 B7WrLPFQLnEgGltYlvrf5Fg1FIA9vaTfrEJcshGP6MF6NYmzfwPzoX/Ir/umFB0EysRuPghnFIL
 bO6QP59YGHyz/kSUheF+8/uuhouPcL5lpuYm3WZ3Iu23P+gOyxWD+86lmPQuCCQIdlvG9vaWf2u
 h+azht90rCcDuwsLGfxObaxOjeO0CycydUecKmDcJl1lttarzWCstNGAY65Q+0jcIcK2HR0Sa9H
 9K5lzVYkRs97Lm0hAgJzlgkM48gPbD0O9faU1Uw9kMwZzYVroktfoxgVZsHElki6aSXis0nyq+I
 EY9Rvt7wbCzwI638Q3Q==
X-Authority-Analysis: v=2.4 cv=dOmrWeZb c=1 sm=1 tr=0 ts=69454f93 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=H6YMLcam0HurB3DtvNQA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: UWOphI2UYM2vYaQHwSFYQmiXjYBEV97R
X-Proofpoint-GUID: UWOphI2UYM2vYaQHwSFYQmiXjYBEV97R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_04,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512190110

Hi Dmitry,

On 12/6/2025 7:52 AM, Dmitry Baryshkov wrote:
> On Thu, Nov 27, 2025 at 07:10:35PM +0530, Jishnu Prakash wrote:
>> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
>> with all SW communication to ADC going through PMK8550 which
>> communicates with other PMICs through PBS.
>>

...

>>  drivers/iio/adc/Kconfig                       |  30 +
>>  drivers/iio/adc/Makefile                      |   2 +
>>  drivers/iio/adc/qcom-adc5-gen3-common.c       | 107 +++
>>  drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 767 ++++++++++++++++++
>>  include/linux/iio/adc/qcom-adc5-gen3-common.h | 216 +++++
>>  5 files changed, 1122 insertions(+)
>>  create mode 100644 drivers/iio/adc/qcom-adc5-gen3-common.c
>>  create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
>>  create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 58a14e6833f6..da201a9a6950 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -1319,6 +1319,36 @@ config QCOM_SPMI_ADC5
>>  	  To compile this driver as a module, choose M here: the module will
>>  	  be called qcom-spmi-adc5.
>>  
>> +config QCOM_ADC5_GEN3_COMMON
>> +	tristate
> 
> This Kconfig (and the module) are used only by QCOM_SPMI_ADC5_GEN3. Why
> do you need to separate them? Your thermal module doesn't depend on the
> common functions.
> 

The module added with the above config has five exported functions which are
all used in the thermal module. But now it looks like I have exported functions
both in the common module (drivers/iio/adc/qcom-adc5-gen3-common.c) as well as
in the main ADC driver file (drivers/iio/adc/qcom-spmi-adc5-gen3.c), which
seems like unnecessary separation. So I can drop the separate file as you
mentioned, and keep all the exported functions in the main driver file alone,
in the next patch series.

Thanks,
Jishnu

>> +
>> +config QCOM_SPMI_ADC5_GEN3
>> +	tristate "Qualcomm Technologies Inc. SPMI PMIC5 GEN3 ADC"
>> +	depends on SPMI && THERMAL
>> +	select REGMAP_SPMI
>> +	select QCOM_VADC_COMMON
>> +	select QCOM_ADC5_GEN3_COMMON
>> +	select AUXILIARY_BUS
>> +	help
>>
> 



Return-Path: <linux-pm+bounces-39708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC20ECD00A8
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 14:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F4ED309B5D8
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B573271EB;
	Fri, 19 Dec 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VwPgOcAa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d6wbTPhx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00DC21D3CA
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766150148; cv=none; b=KtlXsdW1lyyK5N6M+yCnsEPcYePQXdJLNovL5qEXqaTWQ2s/Ze/X+ziiMUbSdkLIkbL+KfV66CPgXJPdmvD8kZOmg9Zc6LTITXw3LLXMH3ZOyVJA9Wny7QbUjKYXLTWWYVXU/zWJ5UeAgu8U8Nn1ujYJylHHv2UygGPb157CpK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766150148; c=relaxed/simple;
	bh=mtVvIUS/JaJUCoLQVXSOzz/8MiesNRzguGmPjaF5OIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvB95tHIi0j/NPtxBMxcdbfXeW9Ns4n7hspvSkd0o6z+EiKbX2kVRHMBa+NubXUZPJ18hDqoo7bF8kpVRwiWfQIhmMGrQA8VtHvvUQtO9e1Emdt/kdqPpuox91cRXduXNf7DE4QE4gebjLs06ZLWctM2ZfeDi/Q3wk97IbfY6zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VwPgOcAa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d6wbTPhx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJB41PM3939222
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 13:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UpN1l31PtsvvDzVVzcUO81N4UuEt2F++NIEqhVqZxkU=; b=VwPgOcAaZFwHecay
	WVwKGTlViyarYjlj0bZgxWoqkOsBLYJ6mdP17LrBMetlkdSGNhIfv+0x0E06zfMl
	uHuePSmbky9nqHkcEGMBqV+SKZCtNluD/9bF43U3/sAX+44AKSO6drHhJuYNKxyL
	ikkeJJU8Tt8/g4mR0hj7cjqgz8UTSN3sRa/c3uBkBwdlg27otK0TaaacJL4bZKsb
	19UdktJ/BXsCsZt+mjN3HHoapKQgXEbPhKo1uT7undUZ01EYr5+yAt9ARXYHjET7
	Wy40XlvPT4cCKXyFPL6VIXzPrvKFvCWXz3lphEzLjSvL/k8dvBPrDBJYrDr/7nLZ
	sahnHQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2c2re3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 13:15:43 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b9ef46df43so2200212b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 05:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766150143; x=1766754943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpN1l31PtsvvDzVVzcUO81N4UuEt2F++NIEqhVqZxkU=;
        b=d6wbTPhxeimSNmfo/zqQTnpJtmnE6Qs0g1lydF2FRvD2eLzDoLPtt4MNOOt58ZRcL0
         pKZGbQzuroVSk1AxLPefuGZHrrYJ8ZIAHlEChFhariRVpG4PRIifkJIS6TQuIviSyvHU
         M1mpST/cPEDnP3Q3GDNEyp4WJ3pNTjLLdZOpf0spkYMWJzfKN8xcK47w+qIJeO58EMlS
         MMRQawOi2N28UkCeosLqqPbmgbf3BWpFpTBSnaMqSoaHQAwzCENALnQo9V5FlXAGvGgh
         XnBS+cmQQHQtSsdrdSvcgPJJMAh+DEyV/8E8caxee7Nq7GxKVw01SseZtF+fhNYuBScc
         s2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766150143; x=1766754943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpN1l31PtsvvDzVVzcUO81N4UuEt2F++NIEqhVqZxkU=;
        b=BKVeh/Imvawq8q0vlCXodhchwmBnDDNouast6YSCKOavWMi8sjqO2u+09tGZoxecFX
         ywPG9qOK1yimRWCm5DJZoFhe4xC64Y3eIa/QCSayqHZjnOvPdSOkGf9CLnqA7wEk/y3c
         xINABXSbdX3AtAhnpd8qw6pitEYmDuy2lKC72O0IjcHH76kXK3Yxnd6XlQb299CSUjBo
         j/2nWeYc9eeDQDPPfQjicyhCnPzZayVI3AxnU0Ssr+UKhaRx1s9AXygoquxe5jDjT5gK
         cU+iAdunflNelZsrDLowMqzUE0DYwpVs9Za0h5MdVTW97N/nC+4tBhzaxqxyJ4sBy/JT
         kbbw==
X-Forwarded-Encrypted: i=1; AJvYcCUR7nGNDAdob1dIDzhMIIKP8YPHffJ9nq4V7ebwr+us53Mt6hxPRELQQBZwuAeZvao5IK7Bu7qU5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS/G7Cya7qL1EF5Aj61n62j4pctQWP2TRmV3pFOQFV9G3FZMDz
	Yxz4EWZLtC2rcZL56NH3+bFT9c+zGsgvWScjI/3C2gy7DxQESjaOb1fzU3Xo4fGefcr7JhkH3lj
	oYk8ozY1lG5bFPq2I2PSYAclhey8L6OL5/29RMU0UCa/Ft9nOe3DVHZQSUougaA==
X-Gm-Gg: AY/fxX78lhntKGxOMDzPxp157LcK8Mu6B1dBI057wrEThoX993ujVRlz7md+cPZKMCo
	RgPlHHBFlJkhrViQRE5Ls1uIiWc97Hai5cio7gWZijm1n9mLDtDmSrWm49BLIgI5FDyNp6KNN4v
	pnLsRczqqVpAVe94GdKnWtr+8LT1SZCKOnhjbpQ8au6B8DGnTspJgq2/TqznEnSVrSk8hYDO/d3
	xoSe+nFfHvws64cfCLCBJ/5coUKUJyLw9B09JeYyG5PUa+6rc7NpqgfNJvQLbLZZFAq9FivgFvF
	Iq3btnc8f8v9Oa43ku0E6fbBkt5gNdqHw3EbKnapIkBZE8R3nV/8pl5EZo49lUjm40dsNZHqFFz
	0yz6v6us2IicN8BY9GBgnGt0CkoNaJ8TaSTrCrsHwKQ==
X-Received: by 2002:a05:6a21:6d98:b0:364:86a:46b2 with SMTP id adf61e73a8af0-376a9ccbb0bmr3024501637.57.1766150142700;
        Fri, 19 Dec 2025 05:15:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsxyK5lHLg3u33gOcm5o66CK8suco88/56FRjoiS6lVtwAhOZVk1W29HbjNE5Gu3ZcAxPv+w==
X-Received: by 2002:a05:6a21:6d98:b0:364:86a:46b2 with SMTP id adf61e73a8af0-376a9ccbb0bmr3024453637.57.1766150142120;
        Fri, 19 Dec 2025 05:15:42 -0800 (PST)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac06fsm2002400a91.11.2025.12.19.05.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 05:15:41 -0800 (PST)
Message-ID: <6afcb26f-6f6a-41ef-ac45-976e5e2f17ae@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 18:45:32 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
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
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org
References: <20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com>
 <20251127134036.209905-4-jishnu.prakash@oss.qualcomm.com>
 <20251207165349.72f80659@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20251207165349.72f80659@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: k3sTLfy_hqS3Nmp7KwmOGr_Yn-tKq6UE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDExMCBTYWx0ZWRfX5QhzdYAMO79Q
 ds9igTjOLCplPsAAGCcvP9BTSGzVVQWlLD1tMRHV1dVOA3mdr+jyt0AgWjJCbdx5sknsAknitPf
 9g9DdDA5jcYT/qDYSmTzk5WL/g4nyiGAyqRaAlw2Jbhkr5mTsHZrJTGdos9/j14gMibhWQOgM+R
 jxdlMWJE+yK6MOptsFzY59ELMXwxsswBLj+8sfcl7rtfCFPUFlhVP1zEP/zC4xz1f6VcST2wY7M
 PxQ39qBoMk8fN2xfTkhj+sDBXg5Z/5/YOl38aj7ZiYJdrX4Rw7DbxwhiokRQEFFRZmp1pCQRTpf
 JgFbkX8z8q/7FozJXoE1TRcBzoJTeNRvxzPPL6ra+cNIuA3GNmweSh1+hoRgm1dAJRdqR0WsFzH
 NXWLTGlX7OCT9gFt7Go85OgPXD/byD/Z4jBjC0b9yoFHO2QbqKY+vMNnnn3n07X3G6IySrlYSH8
 jyZm8qI66dKdoO19B/Q==
X-Authority-Analysis: v=2.4 cv=feSgCkQF c=1 sm=1 tr=0 ts=69454fff cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fLtpXVqzqxV2lCxwsoQA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: k3sTLfy_hqS3Nmp7KwmOGr_Yn-tKq6UE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_04,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190110

Hi Jonathan,

On 12/7/2025 10:23 PM, Jonathan Cameron wrote:
> On Thu, 27 Nov 2025 19:10:35 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
>> with all SW communication to ADC going through PMK8550 which
>> communicates with other PMICs through PBS.
>>
>> One major difference is that the register interface used here is that
>> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
>> There may be more than one SDAM used for ADC5 Gen3 and each has eight
>> channels, which may be used for either immediate reads (same functionality
>> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
>> (same as ADC_TM functionality).
>>
>> By convention, we reserve the first channel of the first SDAM for all
>> immediate reads and use the remaining channels across all SDAMs for
>> ADC_TM monitoring functionality.
>>
>> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
>> ADC_TM is implemented as an auxiliary thermal driver under this ADC
>> driver.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Hi Jishnu
> 
> Biggest thing I noticed on a fresh review is that you include
> very few headers.  This only compiles (I think) because of lots
> of deeply nested includes.  General principle in kernel code is
> to follow IWYU approach with a few exceptions.  That makes code
> much less prone to changes deep in the header hierarchy.
> 
> You can even use the tooling that exists for clang to give you suggestions
> though search around for config files (I posted one a long time back)
> that reduce the noise somewhat.
> 
> Jonathan
> 
> 
>> diff --git a/drivers/iio/adc/qcom-adc5-gen3-common.c b/drivers/iio/adc/qcom-adc5-gen3-common.c
>> new file mode 100644
>> index 000000000000..46bb09424f22
>> --- /dev/null
>> +++ b/drivers/iio/adc/qcom-adc5-gen3-common.c
>> @@ -0,0 +1,107 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + * Code shared between the main and auxiliary Qualcomm PMIC voltage ADCs
>> + * of type ADC5 Gen3.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/delay.h>
>> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
>> +#include <linux/regmap.h>
> This seems like very light set of includes.
> If nothing else should be seeing linux/types.h I think
> 
> In general try to follow include what you use principles (loosely as some
> conventions exit for not including particular headers). 
> 

I have a question about this - I'm including some header files in my
newly added common header file too (include/linux/iio/adc/qcom-adc5-gen3-common.h).
Do I need to repeat those in the driver files where this header is already
included?

> Sorry I didn't notice this in earlier reviews!
> 
> 
>> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>> new file mode 100644
>> index 000000000000..effd4bd49989
>> --- /dev/null
>> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> 
>> +/**
>> + * struct adc5_chip - ADC private structure.
>> + * @dev: SPMI ADC5 Gen3 device.
>> + * @dev_data: Top-level ADC device data.
>> + * @nchannels: number of ADC channels.
>> + * @chan_props: array of ADC channel properties.
>> + * @iio_chans: array of IIO channels specification.
>> + * @complete: ADC result notification after interrupt is received.
>> + * @lock: ADC lock for access to the peripheral, to prevent concurrent
>> + * requests from multiple clients.
>> + * @data: software configuration data.
>> + * @n_tm_channels: number of ADC channels used for TM measurements.
>> + * @tm_aux: pointer to auxiliary TM device.
>> + */
>> +struct adc5_chip {
>> +	struct device *dev;
>> +	struct adc5_device_data dev_data;
>> +	unsigned int nchannels;
>> +	struct adc5_channel_prop *chan_props;
>> +	struct iio_chan_spec *iio_chans;
>> +	struct completion complete;
>> +	/*
>> +	 * lock for access to the peripheral, to prevent concurrent requests
>> +	 * from multiple clients.
>> +	 */
> 
> Whilst checkpatch is dumb on this and complains if you don't have a comment
> here feel free to drop it as the one in the kernel-doc is enough.
> 

I'll make this change in the next patch series.

Thanks,
Jishnu


>> +	struct mutex lock;
>> +	const struct adc5_data *data;
>> +	unsigned int n_tm_channels;
>> +	struct auxiliary_device *tm_aux;
>> +};
> 
> 
>>



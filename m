Return-Path: <linux-pm+bounces-34733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AF3B598F6
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 16:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B97516DA1C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 14:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6867F3431E5;
	Tue, 16 Sep 2025 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X03ZJERA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5062129E6E;
	Tue, 16 Sep 2025 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031428; cv=none; b=JwUDG0TneVLuOt0Gx2+luPIhKJ2JI1gSwfPEnrezTp5ZPdTZO7f3YfD8vn0OebxRxcUHus/yqaBiGmgvGwPLN5pk87FCsigooIRRCiUsp8qRTQoduZ74XucOcHq2sx8CTasr5dXLa7KzE4kELD6GdooIO0QxOYgqnO9i0lNMvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031428; c=relaxed/simple;
	bh=jDkzduPIFAj6tQpA9LK703PSOe4qFHKJ6yj+8XUz7U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q8ZTogQhAU9wRDQai+xOH5Vvctj/L1NCsSlUy97Q81u79jJ5goKIOzL/THfaAw9L7nsMO0WRLTS4kKNVLnoS1JjMa8wrLY1OMHtGANO19ey5p+uP7n70A+dLfvJ9lapo7YZ/v048ijnbGitqQnKt2yntTDvKB4/o2Roknxu8oRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X03ZJERA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAmwKL021429;
	Tue, 16 Sep 2025 14:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6X4Oo9dw265PURxeYMUaHsX4sLsJPuBPvb+0hPhB0tw=; b=X03ZJERAb6N+nykO
	fRhY76URm/EZRth1agRZGE+rmcUE0A8iieizzc7LMY61aORwVFv4jx5sPQiqn8PM
	LB3F3scF2PRfbAxdef75VtJFXwB9TUByWNjGmUdT9HDx3J/PPMSZQa17gJNT7w9O
	ztT31JoyjV/2tAQ24qj3EwzKu8cWXpenI/qJSGPtMfXnS2YZsMBw4Ztm1jsQ6Wdm
	UEMAanrQ4ZjdrwPXf17KUbxwLXBo9BVremMaIRqhOYxpwMh4kt8llEVyGD6YEdDg
	Fp6Ehbjyrk7JBL1YqIFhuINTmzto00p3+U05za7REZLW+kP//hoDurAu/3cgrJ8K
	VKyS1g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma92qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 14:03:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58GE3Ppj030456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 14:03:25 GMT
Received: from [10.253.73.4] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Tue, 16 Sep
 2025 07:03:18 -0700
Message-ID: <1e7d7066-fa0b-4ebc-8f66-e3208bb6f948@quicinc.com>
Date: Tue, 16 Sep 2025 22:03:14 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] dt-bindings: clock: Add required
 "interconnect-cells" property
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Varadarajan
 Narayanan" <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        "Manikanta Mylavarapu" <quic_mmanikan@quicinc.com>,
        Devi Priya
	<quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_suruchia@quicinc.com>
References: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
 <20250909-qcom_ipq5424_nsscc-v5-2-332c49a8512b@quicinc.com>
 <20250912-nocturnal-horse-of-acumen-5b2cbd@kuoka>
 <b7487ab1-1abd-40ca-8392-fdf63fddaafc@oss.qualcomm.com>
 <0aa8bf54-50e4-456d-9f07-a297a34b86c5@linaro.org>
Content-Language: en-US
From: Luo Jie <quic_luoj@quicinc.com>
In-Reply-To: <0aa8bf54-50e4-456d-9f07-a297a34b86c5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX+9fniE3pPWHB
 OK1mPcvWK39tjQpXeg8MT+BqotrnwWTpPXA47FselkKhjNIKTmvcDr6saYw99d/BVXIJhsDfVHF
 etU73HHUoARWi+cuEUe8kEn/BU/2eceCg7Dbb0SjbIcoVuKZE1W1IK8KPMGTthcJmUCAYXaTF1g
 CmoetI2YNTVgs5IaaRvgpKChIoq4svHTMffGrXGdZIM0MujvmF6vY7J7V3QxNTTGFqDPzFmCGEI
 FHPXtmj2Ll8giOhyYfxfJVLYTozy2RMuteHsZySMVg/01HkUkCTYqjMQEWhrDxlCKGaIePm2pnm
 H8rVrDGCmQCoIF0paiVaQAAOxAw2TzK20GcvInI19G3+HEPn0mvLaecbopPySZGzt01qjn9umyu
 9KiSVr3P
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c96e2e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=gKVqG3yGxRJGUVRL1-wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LvqLRf81n_ETBpixAjO1G1xzpO7c-pka
X-Proofpoint-GUID: LvqLRf81n_ETBpixAjO1G1xzpO7c-pka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019



On 9/12/2025 5:16 PM, Krzysztof Kozlowski wrote:
> On 12/09/2025 11:13, Konrad Dybcio wrote:
>> On 9/12/25 9:04 AM, Krzysztof Kozlowski wrote:
>>> On Tue, Sep 09, 2025 at 09:39:11PM +0800, Luo Jie wrote:
>>>> The Networking Subsystem (NSS) clock controller acts as both a clock
>>>> provider and an interconnect provider. The #interconnect-cells property
>>>> is mandatory in the Device Tree Source (DTS) to ensure that client
>>>> drivers, such as the PPE driver, can correctly acquire ICC clocks from
>>>> the NSS ICC provider.
>>>>
>>>> Although this property is already present in the NSS CC node of the DTS
>>>> for CMN PLL for IPQ9574 SoC which is currently supported, it was previously
>>>> omitted from the list of required properties in the bindings documentation.
>>>> Adding this as a required property is not expected to break the ABI for
>>>> currently supported SoC.
>>>>
>>>> Marking #interconnect-cells as required to comply with Device Tree (DT)
>>>> binding requirements for interconnect providers.
>>>
>>> DT bindings do not require interconnect-cells, so that's not a correct
>>> reason. Drop them from required properties.
>>
>> "Mark #interconnect-cells as required to allow consuming the provided
>> interconnect endpoints"?
> 
> 
> The point is they do not have to be required.

The reason for adding this property as required is to enforce
the DTS to define this important resource correctly. If this property
is missed from the DTS, the client driver such as PPE driver will not
be able to initialize correctly. This is necessary irrespective of
whether these clocks are enabled by bootloader or not. The IPQ9574 SoC
DTS defines this property even though the property was not marked as
mandatory in the bindings, and hence the PPE driver is working.

By now marking it as required, we can enforce that DTS files going
forward for newer SoC (IPQ5424 and later) are properly defining this
resource. This prevents any DTS misconfiguration and improves bindings
validation as new SoCs are introduced.

> 
> Best regards,
> Krzysztof



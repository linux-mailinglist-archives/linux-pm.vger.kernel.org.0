Return-Path: <linux-pm+bounces-31724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E55B17CAC
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 07:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C2D3BE9D2
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 05:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43F81F3B96;
	Fri,  1 Aug 2025 05:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ghIKg6xW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1614A60F;
	Fri,  1 Aug 2025 05:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754027923; cv=none; b=V1J5/uI9ZqIDMbWhfjU9uDS6eSiJl5CqLKncv5oSGXLhDt5z1uSj00Skq4p+N7XGnLOWQpfFsY8S8RRYu8qcDNgaggf+m7fTyp1TkvE54GKwXrm3HzLcKGe54F6s1ch5TrN1/SBvFBmsAZPN8CLxTiZbiTrAK1aQNCKhaqPJqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754027923; c=relaxed/simple;
	bh=mgxA7W4mQwpr1uH2slOXdJ0GU38EgMRZhZgmeDvLU0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OyMUVpJOSvk9OQT2e/UJAf/RzG6BJXtQzRilQH51STySujYN/qOdj+J92BB6JHQnZmx/Ho9iXl65lOMhT7b99mj2FLD6sM/csTUs925jqsmdO1VWsMTQNiJBF+McNQUfvGBMs71HHfPayQ4UH1XY7eS3OB+aLVmoHu3njuGWVNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ghIKg6xW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5710RolX021732;
	Fri, 1 Aug 2025 05:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dnPjA4Xn0J5yS+DY1Rak8L377wvl7FGLi5Y+z6aX6NM=; b=ghIKg6xW/HIfr/Ga
	Gl/a7qo8y8WL7L0uB7SAD3wP8WhbZIqZOKjiiCyEztP8elzXP4w+r+yMIXt+XNDu
	PiOV07LuB+SZJjs66Il9Kve1Yl9DEuHarVucC1EPTApwZw+BawjPatE8Os/ohtqv
	5A98aOFJQJT9D1IomGG9Apl9Xcqoik51pNm+xKM4C9fjWGlOHvTaJCcQWO9CO7Ww
	5EVhcRDVUVHLkbo5rU5dqpe/wZYoXLnJlKjdqAjOlnLiDjVzuICNymgFyX1eGlSS
	+DD0wI/ltlJBmWQ9Cv4AfBNxx4nPItULnrdeKVQBnRWV1rl0QPCSdbWBtSTVs1do
	PfFi7Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcrjt4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 05:58:36 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5715wZDt029594
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Aug 2025 05:58:35 GMT
Received: from [10.151.36.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 31 Jul
 2025 22:58:29 -0700
Message-ID: <33c17569-7015-8a96-5952-3fad95883163@quicinc.com>
Date: Fri, 1 Aug 2025 11:28:17 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/4] dt-bindings: clock: ipq5424-apss-clk: Add ipq5424
 apss clock controller
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Varadarajan Narayanan
	<quic_varada@quicinc.com>,
        <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_srichara@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20250730081316.547796-1-quic_varada@quicinc.com>
 <20250730081316.547796-2-quic_varada@quicinc.com>
 <1705cfd6-95fe-4668-ae3b-f8fc7321d32a@kernel.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <1705cfd6-95fe-4668-ae3b-f8fc7321d32a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDAzOSBTYWx0ZWRfX8PeVWtAHMZ/8
 55qk+CuKBZjE68a+e4qp0o8kcZnXLBjgMBh0SZIUfS2KwQAjck7WyCXWqBG6lGB4XYLy7+lMiva
 NYyGjaL7iEwXHE+46JdbANkpyKCCg+q2XFGGkuwItt5/UslyZHSxjdif2zvAEGOl2fckaQ1QsR+
 8O2gpTEqNZag2My0OedFz181Gb4VOM8lXV+X0TnY5UOoyYOnBvS52Sv5K4BbIfznbsWDitPhEsv
 Ux1R4kYh4CqRDSMFudG3NHWuAJmK4w4Tfw/rHAu6abKPJGU4otkAav3ZihH5WJBMv8kKfyMaTl7
 OcBxjdQOFL8NIRx5DsV9cVSL2CmcGUoN7bhivmsfBURT/S2ctPlYAGg5VM5A20vmLIAz38QUo6O
 qAMtGZrnzlc9+d1TN3KmshVG/feEzI1T0sT0hMcCXVJtQU+5xdEuyXsxFnmewXDIs4w6S/vR
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=688c578c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8
 a=COk6AnOGAAAA:8 a=WXmMl29sQjXzjk-Zzf0A:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: XHKN3hM8DMt07bQUJcVywH3tPeQREeZG
X-Proofpoint-ORIG-GUID: XHKN3hM8DMt07bQUJcVywH3tPeQREeZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_01,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=886 clxscore=1011
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010039



On 7/30/2025 2:32 PM, Krzysztof Kozlowski wrote:
> On 30/07/2025 10:13, Varadarajan Narayanan wrote:
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,ipq5424-apss-clk.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm APSS IPQ5424 Clock Controller
>> +
>> +maintainers:
>> +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> +  - Md Sadre Alam <quic_mdalam@quicinc.com>
> 
> My v2 comments seems still valid. Your explanation suggests they moved
> on, so it is confusing to see them here.
> 
> Sricharan and Md Sadre, can you provide Acks for this?
> 
Ack. please drop my name.

Thanks,
Alam.


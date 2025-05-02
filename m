Return-Path: <linux-pm+bounces-26540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26999AA6984
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 05:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1441C7A6336
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 03:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C835932C85;
	Fri,  2 May 2025 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OsH2mkD/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389782581;
	Fri,  2 May 2025 03:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746157777; cv=none; b=RQM+uaAwl/jJ41I19BzVcIqQwW/fSplm080nuQNSrPGSWdpYC8037qSmc85TAMzzk18H8TLuL/FFXenIxw9hxgz/IoGsOvNGyRXbdtBo7N/hfVpjVmzOS3t+IENnT+zKcb3LH9jCMAPy8zBWMDtNxPU0ykDL/VTegr45O8l4BjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746157777; c=relaxed/simple;
	bh=HmwdI6IyKYpNwIFKAPaiA7CHu4AE81mqpGJ44XcWmYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gaQD7Y1PKlK8SzsNoz6AtnYeVWL6vTJulFG9E2YPi+48ximKRheaLbDxyrGrn6AtsJYQ5lumpPsbP3hWBUW54BFzEUYsJSiLJ5WLhgx/XMa8NfKlCYy4fnF03RkmfVj5zJk536yWwjo7k/RemWrKNhuL2RRn8nvOA14XjZvNzV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OsH2mkD/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5421NRQZ017611;
	Fri, 2 May 2025 03:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qm5XXA1MeMUCuJDcei9lPv+XfMAD6iBIicBbOMmJqdc=; b=OsH2mkD/tMrViZ7u
	DuYSnCuAYPHbx6AeU0GpjpLdMP5Grj81jxu1crnOV3MDIGb+oLgp+Iz4l0iHY64P
	bqw5lUNwlCpd7QQBcliCjBO+BiPzv++dLDCXYkSo57zuelYNueCuDoqQSopdZBUQ
	lMAGTslxoIV5OrVR790jBRylV1XdzNCltjRn8MJ4zxvIIBctfEnZa0jbyIDeHGJ1
	/u3Xx+UsToi+xJR2BrgHNr/dAnaZTMDFnUHovomauQsAPfB7X2DUY0vcOt/Ec9oS
	KP5bgfK7qPnfnKIXXQTc87jnbahtPukOlY7istNqAEw6f9qQcacRWyGVzfOiOkV2
	6Z6K8g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u7756d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 03:49:31 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5423nUYA028904
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 03:49:30 GMT
Received: from [10.110.24.115] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 1 May 2025
 20:49:29 -0700
Message-ID: <2b6dede6-c9af-4618-aa43-f3e728018d79@quicinc.com>
Date: Thu, 1 May 2025 20:49:28 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] opp: add new helper API dev_pm_opp_set_level()
To: Praveen Talari <quic_ptalari@quicinc.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon
	<nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <psodagud@quicinc.com>, <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
 <20250502031018.1292-2-quic_ptalari@quicinc.com>
Content-Language: en-US
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20250502031018.1292-2-quic_ptalari@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAyNiBTYWx0ZWRfX5rQkYW9ip21B 8+mVpZY0W47NFExoixqqqrw1eJpDEnbVnXvkKWpTXCxPFJq+EnJv1mlyeWjGFveCs9DsAfp4p7c 85PUtXZRX07E3dJerFUxouEyBEky/YmExq+jVDzN2VGlUA8Wbu+wPAWmvSpCadZoSuelMc1h6es
 y+I4VPBK5zj0ZKbyQLrvEHyjUDZFpuUi1OLvPp2A3ymociKkyzudD5z715yyNdh3GVS8NTVpaMO +WJn+fxfeW3BpmdCGxuitUQ/alwP2TTqZ+2B5YF4jv9vDCSlwH4vDy1xt0oLqzWINDxSbcVpRh3 0XaGYd1L+qnMlBnoysJdMmiAgNrlz1nSKfIE8ben0OAw0S9SwPwFDedbeXwo7+C7gpLphlPbDSI
 +T+tr7x6KhKK1+DTbklCR+pP10Th3ldo2RpJhkrF9AIdTkxqdN7Eav6tsxR3R8msMO4xSzRD
X-Proofpoint-GUID: SevhcMzzx2qRif4XrJBUGOA2h7rWxZ3o
X-Proofpoint-ORIG-GUID: SevhcMzzx2qRif4XrJBUGOA2h7rWxZ3o
X-Authority-Analysis: v=2.4 cv=b6Wy4sGx c=1 sm=1 tr=0 ts=681440cb cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=0p3dzYWINUJxWs-hzPUA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020026

On 5/1/2025 8:10 PM, Praveen Talari wrote:
> To configure a device to a specific performance level, consumer drivers
> currently need to determine the OPP based on the exact level and then
> set it, resulting in code duplication across drivers.
> 
> The new helper API, dev_pm_opp_set_level(), addresses this issue by
> providing a streamlined method for consumer drivers to find and set the
> OPP based on the desired performance level, thereby eliminating
> redundancy.
> 
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> 
> v2 -> v3
> - moved function defination to pm_opp.h from core.c with inline
> - updated return value with IS_ERR(opp)
> 
> v1 -> v2
> - reorder sequence of tags in commit text

The version log above will go into the commit text. Please keep it after
---. 

> ---
>  include/linux/pm_opp.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index e7b5c602c92f..31ed8a7b554e 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -197,6 +197,28 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
>  void dev_pm_opp_remove_table(struct device *dev);
>  void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
>  int dev_pm_opp_sync_regulators(struct device *dev);
> +
> +/*
> + * dev_pm_opp_set_level() - Configure device for a level
> + * @dev: device for which we do this operation
> + * @level: level to set to
> + *
> + * Return: 0 on success, a non-zero value if there is an error otherwise.
> + */
> +static inline int dev_pm_opp_set_level(struct device *dev, unsigned int level)
> +{
> +	struct dev_pm_opp *opp = dev_pm_opp_find_level_exact(dev, level);
> +	int ret;
> +
> +	if (IS_ERR(opp))
> +		return IS_ERR(opp);
> +
> +	ret = dev_pm_opp_set_opp(dev, opp);
> +	dev_pm_opp_put(opp);
> +
> +	return ret;
> +}
> +
>  #else
>  static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
>  {
> @@ -461,6 +483,11 @@ static inline int dev_pm_opp_sync_regulators(struct device *dev)
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int dev_pm_opp_set_level(struct device *dev, unsigned int level)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif		/* CONFIG_PM_OPP */
>  
>  #if defined(CONFIG_CPU_FREQ) && defined(CONFIG_PM_OPP)


-- 
---Trilok Soni


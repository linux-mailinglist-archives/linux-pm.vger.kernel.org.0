Return-Path: <linux-pm+bounces-13650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB5C96CE05
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 06:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21631C21ACF
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 04:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C8D153838;
	Thu,  5 Sep 2024 04:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Axk8tp75"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3B20E6;
	Thu,  5 Sep 2024 04:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725510817; cv=none; b=WJIjairDg5ehA8jEsZ6zWVeugymqSN2xC1sReeHSLVAW/o2hcYDDR01ws+hs7sdxi5RPixBT1TiXw0Shs4nEEEB3xkBQCLUCNKkKWWCL5htlrgCgGkHOTAB86AzzZKhOQEUHrdvAqa4z1oqfhJ9pnovxeMOykeUvc1tpdQVDUzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725510817; c=relaxed/simple;
	bh=sXth0/9Visvcwa3lF5yUnGOvGXwXeNmxC/M1ZYQAwdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ar84fFGLpSVH4sAqLvQDyZcVTJEWeGG7K4YvoTMCZAoy3MJpMwUOWdabztVPSXA7dGDl4L+4ys+vjCenOdt633i7EM77+8CZCIVpO3kyNMJsXSHMNOXR3sJ3Tn95vyxqi9IqIbCZymqfD9jz7H+i3xPAa1arkHvC9NeDRCcFRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Axk8tp75; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484KegDZ032229;
	Thu, 5 Sep 2024 04:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T6q7WyqElP0KNzQVsLf0OX2SpTUlaXJ011rH7TGUlOQ=; b=Axk8tp75ih6InrJ0
	QE/N9jVVua476NMhW2xGZyLhdrSNgE6aXxlfX6151o6DGmhc3ULCZTyrfs5kQO70
	YJZBM/5qk4q3uvBiw6uc/NoKLXEorBIDe8318JXiEEaE7J83UgMJwGEpu/WKCQA8
	2lA/xHy9EhJ1hqvU7NLw05c21ibK6FfzcLeJgs/vfeyaN4uYVHT9SPAABID0HEuA
	IsxyakyDjoo9YiIuwDmluAxQJEQEwp80QjsB9uwp4zT/L80PCRNp//GTINA/xB+s
	BOjnT7cBjx3n17wq3A+Ohl/0plp5kuMdaPOkchPTSP6eygsYLyCgHXY8JAdCYp+M
	7bTKWg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41drqe71vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 04:33:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4854XRwT031015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 04:33:27 GMT
Received: from [10.233.21.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 21:33:24 -0700
Message-ID: <a84dd249-661b-43e5-9281-07847c4cb91d@quicinc.com>
Date: Thu, 5 Sep 2024 12:33:21 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/19] phy: qcom-qmp-ufs: Add support for QCS8300
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Xin Liu
	<quic_liuxin@quicinc.com>
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
 <20240904-qcs8300_initial_dtsi-v1-5-d0ea9afdc007@quicinc.com>
 <8e5e611c-bce6-478f-b63c-e532b95cbe5c@kernel.org>
Content-Language: en-US
From: Jingyi Wang <quic_jingyw@quicinc.com>
In-Reply-To: <8e5e611c-bce6-478f-b63c-e532b95cbe5c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rlciB8nkMSOo8y46wtQR4KjHmSL6-4PS
X-Proofpoint-ORIG-GUID: rlciB8nkMSOo8y46wtQR4KjHmSL6-4PS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_03,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409050030



On 9/4/2024 5:36 PM, Krzysztof Kozlowski wrote:
> On 04/09/2024 10:33, Jingyi Wang wrote:
>> From: Xin Liu <quic_liuxin@quicinc.com>
>>
>> Add QMP PHY support for QCS8300 which is compatible with SA8775P.
>>
>> Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> index d964bdfe8700..8bad68400736 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> @@ -2010,6 +2010,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
>>  	}, {
>>  		.compatible = "qcom,msm8998-qmp-ufs-phy",
>>  		.data = &sdm845_ufsphy_cfg,
>> +	}, {
>> +		.compatible = "qcom,qcs8300-qmp-ufs-phy",
>> +		.data = &sa8775p_ufsphy_cfg,
> 
> Is compatible? Then this is redundant. Drop.
> 
> Best regards,
> Krzysztof
> 
Will drop that.

Thanks,
Jingyi


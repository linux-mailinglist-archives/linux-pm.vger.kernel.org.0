Return-Path: <linux-pm+bounces-30011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C5EAF6CD9
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 10:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8453A5C68
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395012D0C88;
	Thu,  3 Jul 2025 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SQXVNwNb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C382D027E;
	Thu,  3 Jul 2025 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531300; cv=none; b=TZh/gwOsydlVklTmaSPZUtlf73Rkz92vNMjTYs4dj2uA+52tTvdbbMJjAZ/v5fBoss5U578f24tYrT39kcMIbBlPXTqL1wHzk7FfLOneldod1ple5fxphtnRt4F9F1jDNO9GZ9ZBWqn7IvWadfqqwws+bYREsTNYSKo3C80MPJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531300; c=relaxed/simple;
	bh=yb81PNW1zfO/vjynzdQ62q/C83Nohs6nskeOzeWWT8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ImsGpnQIbBjM9xxUetM91t3nE4KK5ndCtS5BmZqoK/n/X+e3UZg/oHP060A3CfARnfApL05fRz8CB61a6OVQd8ubyhdqGUX87IlWptZBCTSodeTJml22XdFD0QFm5miKCFn15mnU4xguBqBiWwqhGWhRQiVzAkIvUYPTZntkehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SQXVNwNb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5632fI6O029572;
	Thu, 3 Jul 2025 08:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U/JnFgucYQ85wAqCRzJc+aMmTMK5JOCjjo7oAWd75J4=; b=SQXVNwNbPitelZda
	g1n67U2ltKb72NvT32+juulokiX6IeZE+1ZQnQkeKC1TcO78z1SfXnu7gTr0xEHx
	4oqH+daz0Dk8PZNzhT76cG9aNV5gFiz6r2CdIIQ6wsQlkfuyb9OcEzx73hD2EPHQ
	KnFyKG87+oZK53KGYZC9LfcYILOoWrBmlc0c73wRSIiRIYGE+k7UTNEFPQDQXjoK
	DJimx/gt6N8jl1SsFZ2ciPgx5yMqtmwmm2ySBKqUS7sjhW93J2LnadF/AqIjAWID
	bM4ya53kTSOHiEKwo285m1bq4T5J5RZiohjUSW5NI8zZdljgGhza3TLhNdjjMUGu
	5PoaBg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47nh9s0vj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 08:28:15 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5638SEg6018719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 3 Jul 2025 08:28:14 GMT
Received: from [10.217.217.109] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 3 Jul
 2025 01:28:09 -0700
Message-ID: <b6cabc11-a4f0-4d8a-97b1-140be394feca@quicinc.com>
Date: Thu, 3 Jul 2025 13:58:03 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add support for clock controllers and CPU scaling
 for QCS615
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Manivannan
 Sadhasivam" <mani@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        "Imran
 Shaik" <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250703-daft-asparagus-gaur-e77861@krzk-bin>
Content-Language: en-US
From: Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <20250703-daft-asparagus-gaur-e77861@krzk-bin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=frrcZE4f c=1 sm=1 tr=0 ts=68663f1f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=jT-71--mUYc8SmevL_gA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA2NyBTYWx0ZWRfX1akKyyoQpnzr
 QMEZX/j1hyjURK/bfR3/OSNfHOujSxRvTjLqxclK3y+fZeJ2Vr+u2tirG48B/OXJ+YEQrC8DBMy
 W3jwDjb4wvw+da76/RP0ynJlGIeIWXeqQ+QUZY/0u11Czcff6k5NdRj1z7w523PULY22cFAmPOn
 Soq7kkcd3sgbAU5lxwVkM9f0Kswp6fZlUdSkXR1SAf32LjqpbuRDM+TsTWVOxXBwo1JxGYwxIcC
 heNNpxONbzU0N8KqDrxSeseEEwKRX0PbPDtA2POw5/FeOZG4GJ7nkW5fT0tCpT1LEQTBjckqXrh
 j0ZiUfC5/ObMICBpGzBGnPVC+If/3LSeJYuxUqoVKD3NU0ZowMjQ4Y25vVIGGY7zk9niT5L2Adl
 tSwpxN4v4JybLQJox/Amq8yS+ivru+cHzJdyO2Q90A7GnlSYDxNbqp5XRCTTbvGMgQYNL6BB
X-Proofpoint-GUID: Myys_frpzzbPQilASv4vmYbfN9FwMURL
X-Proofpoint-ORIG-GUID: Myys_frpzzbPQilASv4vmYbfN9FwMURL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_02,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=783 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507030067



On 7/3/2025 12:51 PM, Krzysztof Kozlowski wrote:
> On Wed, Jul 02, 2025 at 02:43:08PM +0530, Taniya Das wrote:
>> Add the video, camera, display and gpu clock controller nodes and the
>> cpufreq-hw node to support cpu scaling.
>>
>> Clock Dependency:
>> https://lore.kernel.org/all/20250702-qcs615-mm-v10-clock-controllers-v11-0-9c216e1615ab@quicinc.com
>>
>> Changes in v5:
>> - Update the documentation for CPUFREQ-HW for QCS615.
> 
> What did you update? This has to be specific, not vague.

Sorry, this is the update: "compatible for cpufreq hardware on Qualcomm
QCS615 platform."

-- Taniya



Return-Path: <linux-pm+bounces-16703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C49C59B5C14
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 07:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50241B21DDA
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 06:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D7D1D89EF;
	Wed, 30 Oct 2024 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SxpkTfvz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3631D12E1;
	Wed, 30 Oct 2024 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730271345; cv=none; b=uXNND1Czft4YztbcmEPRXcp0w0SYo9bvPQCvlonw92BFC5fENPuuYyILZpG/dnfOoXAf2jVOgjT0SyR6IZQp/5bvJFnvMdcdtlPpq0q2qDe61Y+4a5qHMLuSIQrY/BpDrz+Am/jZ0JifYPTZ+PObtWAFeT1CLXo9tYRjnf1iWOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730271345; c=relaxed/simple;
	bh=7S8TPBzTY5FDsY1UePUmnz8EhhSoOAUEfWt0PP/9U4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=upQF+cAsMCmSUuR+ap6xhU4ZQlsNzaw9ewRchacOj03ahBXqIkRZvby7jzAkh3+Wlb6Aabx1JVbMQZecFTVmZ+puQ7s1Y0XRnEsH3VBCOSI7b1Bs8htrztd9bXLKWm+ok2CSuKUWtVtI/hY9ccXFHTDuX4raseLHcuYvMaxYHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SxpkTfvz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TNZGMP028094;
	Wed, 30 Oct 2024 06:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HtScq1HpW8xIJiKwDGs61vmLypGB+vbNoMU/4GJDXXE=; b=SxpkTfvzo+7kzvyj
	frsqvIiRv+k9VlWwQ45D092SonMzHKJ2frY07791yMwz1eY7jPCRO3Xn4HbamI19
	igeCMMX8/Uzaai95qp7vrqg1ukgF9Mz5GhQIRHqyP7wfot/1HlF3sxQe1AHHRuJI
	ecYWlJcYWbEg8QJHPZTFPddG0hJ1otWdJWUWIRj4lqp/cmaMQOStCnq/vSdvWDC2
	Bv8MKbFn2OIkiKqtRjjdxgkZ9UDLt+NrXi3L4cIv46KsjMVPW7Ifr7NVF9Oym9lQ
	b3xOt1u05HAGb4I7IWZq1AIIgHLmhFDzbowdpEchT61ufccIs3vo1hJyDonFlthk
	33Bkzw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grt72vab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 06:55:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49U6tcRY030609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 06:55:38 GMT
Received: from [10.216.56.67] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Oct
 2024 23:55:33 -0700
Message-ID: <61302a71-45d3-4314-b22a-ba51e4c2c49d@quicinc.com>
Date: Wed, 30 Oct 2024 12:25:30 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] interconnect: qcom: Add EPSS L3 support on SA8775P
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Odelu Kukatla
	<quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
References: <20241026123058.28258-1-quic_rlaggysh@quicinc.com>
 <20241026123058.28258-4-quic_rlaggysh@quicinc.com>
 <bhnh2xcptccepv2sdyowmre6tm26klnfk5gunmy4lvc76pcfr6@lt7myqju77d6>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <bhnh2xcptccepv2sdyowmre6tm26klnfk5gunmy4lvc76pcfr6@lt7myqju77d6>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Exqrpw15QYwBEas1gl6-ctbdOjgSAWy7
X-Proofpoint-GUID: Exqrpw15QYwBEas1gl6-ctbdOjgSAWy7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=968
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300053



On 10/26/2024 9:05 PM, Dmitry Baryshkov wrote:
> On Sat, Oct 26, 2024 at 12:30:58PM +0000, Raviteja Laggyshetty wrote:
>> Add Epoch Subsystem (EPSS) L3 interconnect provider support on
>> SA8775P SoCs.
> 
> Please describe the reason for your changes. In its current form the
> patch doesn't provide enough details.
> 
I will update the commit text in next revision of patch.
> Moreover I don't think it's a correct solution. Using a single ID space
> for an interconnects doesn't really scale. In the longer term we should
> follow CCF approach and switch to using the icc_node pointers when they
> are known.
> 
That's correct, We will take it as separate patch series.
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  drivers/interconnect/qcom/osm-l3.c | 86 ++++++++++++++++++++++--------
>>  1 file changed, 64 insertions(+), 22 deletions(-)
>>
> 



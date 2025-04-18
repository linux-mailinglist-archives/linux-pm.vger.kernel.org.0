Return-Path: <linux-pm+bounces-25689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4934BA9341D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 10:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A04A467987
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 08:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C96D2571B2;
	Fri, 18 Apr 2025 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ocRzwwG/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97A1FBE87;
	Fri, 18 Apr 2025 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744963404; cv=none; b=ZGuLVLZXXf/3dFyx1tnqFtEIPrZtW9YTe5VBb8eTPh0deAIrLLsNuNe3yn4HDi2pww1CF6z7peWuwUKozvkcyhrBaMCv+17HumCkzRa1RdFI7Wgg/4xka6jRgMNMmfEb0VRrQHG8sykHwky9csjYEYOcvamNVZZ5J6j6WkZ8hPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744963404; c=relaxed/simple;
	bh=hCxLP6pAKI6eDGGxtpKpGub/jE4Qyfy+zA4Yl778bcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SrFsxAeZCHrOPKwi/kngdLzydjTvhYEUf2swjUlAX//b26wsQM+rnx9q1DJk1Y3bf3bLbWk8cWSX+nsJXh+fpQA9lk3azQrRzEzevwwdq1alSVYV+yFhBd3c13jAIAdxsa1mCqjdN5IPWN7ZjW9C/dZwn3x0mJQV8wbO9NXxzvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ocRzwwG/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I1opiN005236;
	Fri, 18 Apr 2025 08:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	78ccXFvK9Y0O7XUVofkzAERao+NSbMs5wA1a7oC7E6A=; b=ocRzwwG/IhSY3uxc
	twEldfb3p2ExikDPAyrJbmJUGEvOCjwRs7sQRVlDtFo/SrutC3bNlobSymxWNlsi
	aJ5wI8AlVgJc0mygcMNtaULYdfn/17Whz3kIPXj8L6LmBfZ9p+4syoSc+XI5IlBr
	fwpXvnHdBjpB68hUCdJc8jcKBrjAymnx5tYYKDVLoYIgp+0iWAInxe629eRSbgjX
	s2QPTnHOSe2j+Jr89hAmSRKY1TEyVfAotJmLqa8MfOBRkPY9KQgL/4iSOQkxWekM
	v9xEA+VcltVkpf40ut08u9v/tq+1JMgayr9LYJ4l1HcRNrk1/QioMJLuhfvkQ2Tj
	t66mGw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf6a1dfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 08:03:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53I83Hwg016349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 08:03:17 GMT
Received: from [10.218.49.159] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 18 Apr
 2025 01:03:13 -0700
Message-ID: <dc995723-3bde-4d41-ba2d-41bdf8afbcde@quicinc.com>
Date: Fri, 18 Apr 2025 13:32:54 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] pmdomain: qcom: rpmhpd: Add SM4450 power domains
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: Imran Shaik <quic_imrashai@quicinc.com>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20250417-sm4450_rpmhpd-v1-0-361846750d3a@quicinc.com>
 <20250417-sm4450_rpmhpd-v1-2-361846750d3a@quicinc.com>
 <5fa5cade-fefd-486d-b1a7-622f3677c74f@oss.qualcomm.com>
Content-Language: en-US
From: Ajit Pandey <quic_ajipan@quicinc.com>
In-Reply-To: <5fa5cade-fefd-486d-b1a7-622f3677c74f@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5HShLUDlMaGHF3eTTXwiCgMU2_7PqOBN
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=68020746 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=mtS1bnK1w_F7lp12xysA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5HShLUDlMaGHF3eTTXwiCgMU2_7PqOBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180057



On 4/18/2025 2:40 AM, Konrad Dybcio wrote:
> On 4/17/25 7:07 PM, Ajit Pandey wrote:
>> Add power domains exposed by RPMh in the Qualcomm SM4450 platform.
>>
>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>> ---
>>   drivers/pmdomain/qcom/rpmhpd.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
>> index dfd0f80154e49d882a59dd23a8e2d755610c896b..078323b85b5648e33dd89e08cf31bdc5ab76d553 100644
>> --- a/drivers/pmdomain/qcom/rpmhpd.c
>> +++ b/drivers/pmdomain/qcom/rpmhpd.c
>> @@ -360,6 +360,21 @@ static const struct rpmhpd_desc sdx75_desc = {
>>   	.num_pds = ARRAY_SIZE(sdx75_rpmhpds),
>>   };
>>   
>> +/* SM4450 RPMH powerdomains */
>> +static struct rpmhpd *sm4450_rpmhpds[] = {
>> +	[RPMHPD_CX] = &cx,
>> +	[RPMHPD_CX_AO] = &cx_ao,
>> +	[RPMHPD_EBI] = &ebi,
>> +	[RPMHPD_LMX] = &lmx,
>> +	[RPMHPD_MSS] = &mss,
>> +	[RPMHPD_MX] = &mx,
>> +};
> 
> /me wipes glasses
> 
> Is there no VDD_GFX?
> 
> Konrad

Yes, there is no VDD_GFX pd in sm4450
-- 
Thanks, and Regards
Ajit


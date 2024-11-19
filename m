Return-Path: <linux-pm+bounces-17748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D25A9D22A9
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 10:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A727B23AF1
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 09:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54311C07D2;
	Tue, 19 Nov 2024 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NyyWrcBQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271991AA1F1;
	Tue, 19 Nov 2024 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009525; cv=none; b=IelscBOTt5qU5TejtU3NvZYJLxe/vxVUtQ+nVqZKHORSIQPEUD0dXSHWKfvnQ7MJ87k4MBnTqfBTlahXAHm+g8Dm3vP/21Jj40IZvQykA5XYcMnS/P6VzheG3oGxNr28lmXpwrYBq1T+EANRQ7yOdcF764pVu8ixfZI40ScUVuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009525; c=relaxed/simple;
	bh=mqRSo9ZYtz2Pe4lS7zNebUzrbnUS4ToI/wxFCrMO72U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=esnw0kKh1+N/ozIK+CeK2ct/v114IX6Wc4YwjWSvTspgYCJF66ckM/j/LaFCRDA5Fzxx31GYL019Rde/K1bEa7XtOJhtaRngf9MFgvsR4OwF5LciFpTws7XqpUjHqGCzw/3VltIcnTp2k4wGYAj6qX6tx+TDPrIaBSUCxBxj55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NyyWrcBQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7sRr7005820;
	Tue, 19 Nov 2024 09:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XDThhEf0IvxVtaogdH7h9rVMuYKUTVOqZs5YIXqM7gc=; b=NyyWrcBQa3q6RIts
	bFRXJWthwmbjxhDF9uF86upie60iJYNi2C0VaHcCBfwWYHCn4nOUuA/1DQd6jgil
	jR2XDwc48oqzuU1dudLRx9HGmvIN5H+Xz/FOvcvQamysCGaCucBve9cGa2gce8v5
	o5L54eooaSJ4+/+zYfkEyXH3ZaSwBSWp52Y2wZHaXtHrhqI56F0mIJBJ5eLhNY/M
	d/6zU2zxwQYqXcWGULw+p5RC5gBKLNmEKJTR6s/dwk/gcl/8N7//ucRApdUXil3c
	5T1kURw7kVOF6jVcuGHU9KFslHPJa51zd3FaHLZfBYdWYQjpZ5Z6BC3jXw2dkaJx
	oHgc2g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y9242b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 09:45:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ9jJso004704
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 09:45:19 GMT
Received: from [10.218.15.248] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 19 Nov
 2024 01:45:15 -0800
Message-ID: <1bc7627a-f1d7-4fee-b016-5b9cc407f170@quicinc.com>
Date: Tue, 19 Nov 2024 15:15:07 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/3] dt-bindings: interconnect: Add EPSS L3 compatible
 for SA8775P
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
References: <20241112075826.28296-1-quic_rlaggysh@quicinc.com>
 <20241112075826.28296-2-quic_rlaggysh@quicinc.com>
 <tv7gsceomtdjcymma5ximownsxleg2ujuxcwjgkzj5zhmlscr7@wnyx3bfi2cpo>
 <386f0f4a-b17e-4f0b-90ef-0a960f23b1e4@quicinc.com>
 <CAA8EJprotUaKk+H6C+QK8VN4uNWhUrTaoTq7sj+X0x+oJr2qZw@mail.gmail.com>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <CAA8EJprotUaKk+H6C+QK8VN4uNWhUrTaoTq7sj+X0x+oJr2qZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -0ERlGcY3A4o1tnN77RllrjvJR_hqZB6
X-Proofpoint-ORIG-GUID: -0ERlGcY3A4o1tnN77RllrjvJR_hqZB6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411190069



On 11/18/2024 4:42 PM, Dmitry Baryshkov wrote:
> On Mon, 18 Nov 2024 at 13:07, Raviteja Laggyshetty
> <quic_rlaggysh@quicinc.com> wrote:
>>
>>
>>
>> On 11/12/2024 7:20 PM, Dmitry Baryshkov wrote:
>>> On Tue, Nov 12, 2024 at 07:58:24AM +0000, Raviteja Laggyshetty wrote:
>>>> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
>>>> SA8775P SoCs.
>>>>
>>>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>> index 21dae0b92819..94f7f283787a 100644
>>>> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>> @@ -33,6 +33,7 @@ properties:
>>>>                - qcom,sm6375-cpucp-l3
>>>>                - qcom,sm8250-epss-l3
>>>>                - qcom,sm8350-epss-l3
>>>> +              - qcom,sa8775p-epss-l3
>>>>            - const: qcom,epss-l3
>>>
>>> No, sa8775p isn't compatible with qcom,epss-l3. I asked you to split the
>>> driver patch, not to change the compatibles.
>>>
>>>
>> Got it, I will split the driver code changes into two patches.
>> First patch will contain the SoC-specific compatible change and multi device support.
> 
> no ands, just multidev.

ok, Will split multidev support as one patch. Generic and SoC-specific compatibles addition as second patch.
> 
>> Second patch will contain the generic compatible addition to of_match table.
>>
> 
> 



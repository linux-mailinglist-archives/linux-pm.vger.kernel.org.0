Return-Path: <linux-pm+bounces-26554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AFFAA6C3F
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 10:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576C51BA1FDE
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 08:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7002690D4;
	Fri,  2 May 2025 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h8RgWL41"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ABD267F59;
	Fri,  2 May 2025 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746173254; cv=none; b=Iau2H6GOVbmcmDP6y4FXs0q7RFwm62hZCrxjFt+Q7B6CgyuHeamiZXT1ucKoF/7c0izw49FHpDvBOVDGy+Qx/Af1qZpl1QWYxZUbkrkS/P7qLuWR4TF29Jf86T9fLdcCJrV8iB2adg+OJJvL/RpMF/N3HJUz4DeEY1vCpaGD9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746173254; c=relaxed/simple;
	bh=RHBtlN76qhQ1cJMVuOCHQA/ajktLGzdxL4P4OVaAcI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G0Gtsuj9AKglYkCbZnAvabk9UFYtUBQvu4N4DLxVBOsApdizanYopIz8Cz1XkqTNxkMY+q2b9B2V64yVZ8O2jiSSrOHmy34PfkaPY1OWBGs6IrCJxBW6imiIgBGUY5vxOlKNkeK+9bPcU+fO/STtaBq+H/eFd9siVjL8vpA0cKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h8RgWL41; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5421NGRV017587;
	Fri, 2 May 2025 08:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RHBtlN76qhQ1cJMVuOCHQA/ajktLGzdxL4P4OVaAcI4=; b=h8RgWL417yrxSQf5
	Blai1uPAwBR5/XoneOc4QNw9Jk/mjQRBoIbQBc6faqpOpowNwBPkIj3GRgC0KFF/
	k/WjCC92DxOwNGm+RDCKHysxt7K+b0SSqZYjYhEwspIpUq85gKovrWpOd9kXynhT
	QDLBQZQuiITt2mwHNW87cihbSou1dKMFkfleZlWBcjnStMzUTdbuUalHl3xpm46X
	2bDoE+1CkgsSEi/sZX84Hebn7hXCFqPBEYKE/9Q85K389Is5VzbnOdoYvhHRdVDg
	rmDwtPVXjj44Z6No/e8iO+x2RmgP6vMhoCAq8bmIC9PUuXrvKJBaHG5nCM8kkA6t
	VEbXwg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u77kgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 08:07:27 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54287Rot015749
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 08:07:27 GMT
Received: from [10.216.18.87] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 2 May 2025
 01:07:19 -0700
Message-ID: <2e94f13c-3d43-441c-8532-f6149cb33cd3@quicinc.com>
Date: Fri, 2 May 2025 13:37:16 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] dt-bindings: qcom: geni-se: describe SA8255p
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd
	<sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <psodagud@quicinc.com>,
        <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>,
        Nikunj Kela <quic_nkela@quicinc.com>
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
 <20250502031018.1292-4-quic_ptalari@quicinc.com>
 <20250502-quirky-prudent-beaver-dcebd0@kuoka>
Content-Language: en-US
From: Praveen Talari <quic_ptalari@quicinc.com>
In-Reply-To: <20250502-quirky-prudent-beaver-dcebd0@kuoka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2MiBTYWx0ZWRfX8U37cO2phlp+ fbyo5GJfCbdeg1fgbvuEO/xaFBNBbGIzHuPI94xcKH4nETWscB+cEjvtFiPA6kQ3Rw6SLW1xxcU 9FaGaIiKGkvGtPztKl01zTWS4jGuQnsh2jZQjcGxOf4WeQHdQ5e9qe36w4rfV+EBY1lp5Tx10CP
 x3Osf21DqLi3THzTVne0lBWJQ+MKGAWLw+uErEewzZ0W2KcLhlMTfoFfnVstmo8FRu3XvLS9x7s J+L2h8+k+r+S+UoPf4TnG/9i+DWfFUBSHylnHfe49/IcfgSzL5aHysC5kyH0KyF+JUFqdl+eNFQ AB19yMJHjhQY7Er4thJHKKRVobYyftfeOQ+Uz6oKhLPZUuHuwlVLiCZvzn2FCJoDXTaX0ndtDeX
 0Q+LlzjxCXZLPsTVo9OymAcgMw9HSiunXGxhhZu+bMwKySNWlNXBSjGEYlwsyWeoblV0Np2O
X-Proofpoint-GUID: E_Oz6l5T2okETWPs5r6-6ZW746iwpzUX
X-Proofpoint-ORIG-GUID: E_Oz6l5T2okETWPs5r6-6ZW746iwpzUX
X-Authority-Analysis: v=2.4 cv=b6Wy4sGx c=1 sm=1 tr=0 ts=68147d3f cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=D04I9yGVSkTAbIRRv5YA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020062

HI Krzysztof

Thank you for review

On 5/2/2025 12:07 PM, Krzysztof Kozlowski wrote:
> On Fri, May 02, 2025 at 08:40:12AM GMT, Praveen Talari wrote:
>> From: Nikunj Kela <quic_nkela@quicinc.com>
>>
>> SA8255p platform abstracts resources such as clocks, interconnect
>> configuration in Firmware.
>>
>> Add DT bindings for the QUP Wrapper on sa8255p platform.
>>
>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
>> Co-developed-by: Praveen Talari <quic_ptalari@quicinc.com>
>> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
>>
>> v2 -> v3
>> - reordered required option
>
> ...
>
>
>> +additionalProperties: false
>> +
>> +required:
> Which part of "required: block goes after properties and
> patternproperties." is unclear?

Yup I understood. it is like

properties:

-

patternproperties:

-

required:


Thanks,

Praveen Talari

>
> Look at example schema.
>
> Best regards,
> Krzysztof
>


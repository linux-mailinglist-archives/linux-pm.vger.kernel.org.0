Return-Path: <linux-pm+bounces-26188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD08A9C678
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E012817A7B7
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 11:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A995823DEB6;
	Fri, 25 Apr 2025 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FpTzZ+fk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3317A2FD;
	Fri, 25 Apr 2025 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745578861; cv=none; b=UlJANrctFM88ffOC7DzW0IOICN6EbWH+fkIZX8vcVbKO1feM2Ik7DmoojiA5JVzJ9fgYh4baQLT/aIbWDsm6q+5XDHOwXj6rJLZN2Covsp2JOwPcwn0cxjFq7svPA37AQUSYjDN/vo0JyPhWGLd8HTS+5sKh4ifHUgv+u/HY3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745578861; c=relaxed/simple;
	bh=LmT4q4cwDV8dqZ1OVA1AkX67exgzoLa7vYuRF6U/m60=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gFIwELWe1xv+MofyEDDsewtkfOFkUclEy+rGAG2syvvArXUiniN72Dj5AmTn7V3GLHuGpUx2NEQ7emTpG/lYNOWykldcG31tFfbceSF0pvaBPMUnQR65qCdYw/H5GDWKb6xYaJhUTLnHHl3rJSUyvhm8WOVL6bcikOVh7mWvJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FpTzZ+fk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8TBPQ007414;
	Fri, 25 Apr 2025 11:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nQJY9KYdG5qh5BZa8CmmZUhQl5LCgH6lXJHDaFC6Oyc=; b=FpTzZ+fki45hfJwI
	ytOX//LUllzYLh5ehmqLobp7D9T4DCqPHrpyyTGswEFcb3Ro9E+Npr03lWIJDSPY
	qJD4QJ8l976cQY3KaRkrpZhkm5x+nxDmCGdZdMovDPkp5oTTDlRjCbeU44L3pgB9
	Y1f9LNwF3qeOVV85FPe48lmp8oVMcBWmodMC1br//Mj/WamZ5VMQQ4txpILrfRyj
	601hIU25SrP4K7tPVK9qiZOW1gxpzorlLHvwMhdSaj037c/dwK/XcVuigd/IaofZ
	GC0vhI2RxAcaI0F2IBYXCial7KJ8cMzI5RYscvMzJbp8T85i87An15t3BfCGcDHh
	34zprg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh0rn2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 11:00:48 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53PB0kn6031671
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 11:00:47 GMT
Received: from [10.216.10.223] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Apr
 2025 04:00:39 -0700
Message-ID: <34fa001f-4667-4e6d-89e5-263f6151b783@quicinc.com>
Date: Fri, 25 Apr 2025 16:30:36 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] dt-bindings: qcom: geni-se: describe SA8255p
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
References: <20250418151235.27787-1-quic_ptalari@quicinc.com>
 <20250418151235.27787-4-quic_ptalari@quicinc.com>
 <20250425-grumpy-dainty-pillbug-be2145@kuoka>
Content-Language: en-US
From: Praveen Talari <quic_ptalari@quicinc.com>
In-Reply-To: <20250425-grumpy-dainty-pillbug-be2145@kuoka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vkz5ygL9-ZZ7YqrVDoCPryuqHr493GTy
X-Authority-Analysis: v=2.4 cv=ftfcZE4f c=1 sm=1 tr=0 ts=680b6b60 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=t6IQHlIZoQGcUKZoLJwA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: vkz5ygL9-ZZ7YqrVDoCPryuqHr493GTy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MCBTYWx0ZWRfX4cRPjnjFtdsA F2uINQahiOgoktXHokbyDUlVnpp23LPH2sJfJ3vHBBbC3sIOTMDnChDU3pLkhZFUX3rmv4wB70y ATFqq60qGZ2K1MZko15GInw1R8cnKYnRtgB7HP+MDCb1Azo8szt0Zqp7AU1YbwI3vYptQXhLdAv
 ux97hSmd1K1QhK6fcVQHIxj2JZxyM5+GfCa4zdeocSRMIOtfVfhM6OPTIBinqTETU/CzLIs8HVO 4LAfnmw7Dn14UHtLWGl8XmX5H7HI8APAmMWl7KQWapxEdr91mdsXWMxRev2GAozEZ9I3gznLONU vvOgYZCgTL8W97frMUDHrQmUIz59niiDKHEdRMocY5L3Xt13JyJzGfcnXv0bao3VNYYkq//NW5a
 afK1qEi9yt+kv21CAGYyEbYe+PNbQcQN5nzhB8/Z6CZ+n4m+j5CK7fRg/JTznyMeJXV9V/19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250080

Hi

On 4/25/2025 3:46 PM, Krzysztof Kozlowski wrote:
> On Fri, Apr 18, 2025 at 08:42:29PM GMT, Praveen Talari wrote:
>> +  "#size-cells":
>> +    const: 2
>> +
>> +  ranges: true
>> +
>> +  iommus:
>> +    maxItems: 1
>> +
>> +  dma-coherent: true
>> +
>> +required:
> required: block goes after properties and patternproperties. I guess you
> copied it from the existing geni binding, but new bindings can improve.
Sure, will update in next version.
>
>> +  - compatible
>> +  - reg
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - ranges
>> +
>> +patternProperties:
> Rest looks good so with this reordering:
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>


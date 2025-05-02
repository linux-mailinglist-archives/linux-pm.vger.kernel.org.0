Return-Path: <linux-pm+bounces-26571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6D9AA7458
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 16:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034F11C0066F
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 14:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944C7255F32;
	Fri,  2 May 2025 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fj4Cqql7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149BC82D98;
	Fri,  2 May 2025 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746194528; cv=none; b=HqqGTv+C8Mgo6QnXdRKYTLtDIDClz5ufQZWdOpuiQkih+yh6Q1qzJpxEkpzOcou2IdhPeID362WLWPuNNIXHBkIE/5Fy3TWkON8xiemQeb4xCxOB5dx/LImPwOefT1ruQPjd/gfY+msVyBC3ixY7TwXpE8HyUOGh7pBkiHYp9do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746194528; c=relaxed/simple;
	bh=grOM45npovMq4poufilpVNpeYgGq5makAUaqB0FVEkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EEKysUdphL0OjGy7PetT3J+nyDeHMw89Gkhw1tgilwNs8NtrXU1mo+avGTVpyyWflAOd7g3D+0UoLLJeLgYYNeLloz/gmmqabMJkDGlKzQDkmln7TAWut1qaUvNGAGcRApXOgtgNOKk8UzvD5e3CyzISz9A5WoCz2L9t0NpZbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fj4Cqql7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542DkCkK009017;
	Fri, 2 May 2025 14:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cpSw/BCKKfUOiK0e2lEfi+/V9bSozootwS0N2z7tERM=; b=Fj4Cqql7W0/Ut78o
	mUks0Q+mC4iU/7GsvI2xSp2Zm0jcYuAWUCqBi9Pz9IlM84o7oFNW+s2YI+WdeBJC
	n7mUtSZLWsRIKeUMk61tlZqGBvsKYJNz/lrs5br1EdTEZnWSItF7g/cBY/wOJIPy
	196KfB5Z6qUjiRL7i/1Gr2/liMSNtywkCT4btTZm4c7T0k8oEghdlzo3huR6FAwW
	mrA1RZcHy6J3jf5v/6LTIhJ2u347GZTjhP8240L6H/tc90YIQ5RD+oEkHcDuS9fU
	f3auQIZUS86oKJENftqaANi1HzIc4qS2CQS7EhJDrLBJhYxPTB8ULpng84AozIiG
	9YlUog==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6ubrj4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 14:02:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 542E20UQ025639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 14:02:00 GMT
Received: from [10.216.18.87] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 2 May 2025
 07:01:53 -0700
Message-ID: <e1b2029b-2461-4cfc-a6b3-acdf5e01c289@quicinc.com>
Date: Fri, 2 May 2025 19:31:50 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] opp: add new helper API dev_pm_opp_set_level()
To: Viresh Kumar <viresh.kumar@linaro.org>
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
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
 <20250502031018.1292-2-quic_ptalari@quicinc.com>
 <20250502053758.utawzhq6famwenc2@vireshk-i7>
 <8ba02745-378b-4264-883a-b99764701d0b@quicinc.com>
 <20250502081402.yjagnnjrfva7u4cb@vireshk-i7>
Content-Language: en-US
From: Praveen Talari <quic_ptalari@quicinc.com>
In-Reply-To: <20250502081402.yjagnnjrfva7u4cb@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZB74ue-52bsz2Kh-vaA667cgtCjQSJlf
X-Authority-Analysis: v=2.4 cv=bsxMBFai c=1 sm=1 tr=0 ts=6814d059 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=6I9h5v2Uro45NzvC834A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDExMCBTYWx0ZWRfX3cCWW6G1+ejf /afaQX/UcoruQjgvPpgOQ0G+3kpBXqenHO2kf7MJXCRxDxswctJtUy/DVKwGgaTd7ZAtQQ7OARa wWi0JJCx0V8WzwYySN5L9jNIbRNwNxkLV0NuteVRCUCPhppjUfcADnpqnRiRNEu3hntVnQJ3XUQ
 Z7bTiYRn2Ql5WyCcFdy0GrI4am0Ls99iXAWz+sT8lkFZsObx1LSxCVq0il2Ihk06ADXK3uGSM+I gCtgbUAYAzJQ6aLdZ37E95uL+xZt3ym1lJUnHrgFEQOm6jk7PCRWKD0H2Ag7/WgVTqKM8v4wcZQ Q96thezQto/tbieNQZLiN8UqH9lfB7knUvxPRNCnAilvR8AuTRKj2s6zt8IigD9g7xRn8P6C5C7
 PwHTvzQ3O+7Nwr0RIUZFrUO60wz7oE95vVslQhQxG0jjs7RavQ2T2rxekhw9G0He3//MsUVi
X-Proofpoint-ORIG-GUID: ZB74ue-52bsz2Kh-vaA667cgtCjQSJlf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_02,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020110

Hi Viresh

On 5/2/2025 1:44 PM, Viresh Kumar wrote:
> On 02-05-25, 13:31, Praveen Talari wrote:
>> Shall i keep commit as you suggested with your SIB.
> I already applied it to my tree. You can drop it from your series now.

now i can push V4 right and will not face errors on my series w.r.t this 
API.


Thanks,

Praveen

>


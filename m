Return-Path: <linux-pm+bounces-31372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8864BB107D4
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 12:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A5B189A8B9
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 10:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15331265614;
	Thu, 24 Jul 2025 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TYC8IUXc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D3619343B;
	Thu, 24 Jul 2025 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353234; cv=none; b=V7/pqc3XQR4MswK/PrxOBV530lj39HNXpCgsDFeZaEExr5fAOf4FWRwKO20mSluKTtnWMAw9SVzza/aHb56QPAEC8n4EJyTkePOf03fWuecCxqi2pCmlc39kW2bWev8lyzP4N+E9EFrbdrygtmWMsf6w51dZb78XMKhmCAdwWJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353234; c=relaxed/simple;
	bh=y/uu0aYzrMdiv8TgRJvZW5gaZjEdUg5E1PbYZgM2PUQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pB6mtMXt26MiQIXCZa6Lk6adsXn/A+DqGD0eUAhLgsK4EDrILiEZfEVrgTgJy0jp8sZoobACTfMDxK6B+81JhcNsO0AtwwpApFeYy5wbfbqXnV0yTf81TKHtch4DdP9acmxGPGuZbQtzP/qmQJmtafsxcDxVdj5i3BlBkjw3Nmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TYC8IUXc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9gKcm012566;
	Thu, 24 Jul 2025 10:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=y/uu0aYzrMdiv8TgRJvZW5ga
	ZjEdUg5E1PbYZgM2PUQ=; b=TYC8IUXc8GezEH1UJ9yUd1aP7emMn+ETo8qc3lCJ
	c7lCJ1dpLsrsPWx4IzKTccgL62qvMcCvNr4Qi9MG4VXKKOW5u2biqPDYWfvAUUnR
	n797lEeMebluqwI7evxcGlI2rS+08hjgSZmvEWdN/lFClpijNiN8Va6bLU5Ezv9u
	WU7LP6UZtFYZJ6XDz7eyUgkfLmZ2YFJq+UsujZ1KiY9cTceUzDmLKXfHQeBV2RRs
	5IZH7YGLfVBp8/8DDM23iLIEe9LjxAoXpgcoIEalFrOiwzUCnP7LMnz6CCc/unsy
	L+XNAUefWKpO5fEUqKUNX9q/e4UDztt+mmp39pIbqnk+sg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3hxd2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 10:33:46 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56OAXjAT005388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 10:33:45 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 24 Jul 2025 03:33:40 -0700
Date: Thu, 24 Jul 2025 16:03:37 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_srichara@quicinc.com>, <quic_mdalam@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] Enable cpufreq for IPQ5424
Message-ID: <aIIMAZ9tkTiU6QR2@hu-varada-blr.qualcomm.com>
References: <20250724102540.3762358-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250724102540.3762358-1-quic_varada@quicinc.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=68820c0a cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=EsjwHSjgO5qIK9K-dSAA:9 a=CjuIK1q_8ugA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3OCBTYWx0ZWRfX8yRi87NCOKG0
 D1y7nfET0qAUeeIh6ke4II7S4IKmEIuLe7A5/Xgxuim+bp5u4u4iC8MQ+aa+0M4Jtt44LHM9OMm
 9b6Tl9CSqq1Xx61zqk2CEXCahWac1xlwO3uSKk0ZsVddClisyhkS5pL2DBH9sdYwWobS4BML5aX
 YXfHLpYLaG9WVpl9hKL2sq2W6Tgex4uu/KA5X7i5EsNLvvWnoldMKcQdTqQn9vjqcGso7/vJH/t
 P4VWIg/whSVy0Q4ESYmtPC763VcQ59yyiyyMBMpcvcFuWPa1cowm1uvEhLK+LIJRiqe/DMapKA0
 SnitJW3r2lYxzrQ0WmTwpE0RSeL8WhUpAulZQIVr/kq/bQycN1yTt6fZX3C1J5eFPqSDRWZ+MJb
 zxf1VqFdW7v6dxpGj53vKn8mhjFPTctXKbSWslhbMgi0qzFo1dJzjcyfE96AOXKynQzmG711
X-Proofpoint-GUID: 3mcmkAv4zAa_nTwQ6GWOhXHV_4UkBp1x
X-Proofpoint-ORIG-GUID: 3mcmkAv4zAa_nTwQ6GWOhXHV_4UkBp1x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=611 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240078

On Thu, Jul 24, 2025 at 03:55:36PM +0530, Varadarajan Narayanan wrote:
> CPU on Qualcomm ipq5424 is clocked by huayra PLL with RCG support.
> Add support for the APSS PLL, RCG and clock enable for ipq5424.
> The PLL, RCG register space are clubbed. Hence adding new APSS driver
> for both PLL and RCG/CBC control. Also the L3 cache has a separate pll
> modeled as ICC clock. The L3 pll needs to be scaled along with the CPU.
>
> v2: https://lore.kernel.org/linux-arm-msm/20250723110815.2865403-1-quic_varada@quicinc.com/
>
> v1: https://lore.kernel.org/linux-arm-msm/20250127093128.2611247-1-quic_srichara@quicinc.com/

Ignore this, missed Kryzstof's comments. Will post a new version
after addressing those comments.

Thanks
Varada


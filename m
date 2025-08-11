Return-Path: <linux-pm+bounces-32152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2E4B203F2
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 11:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19430188CDCB
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 09:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA92224B04;
	Mon, 11 Aug 2025 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PUbyZh2B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B46221572;
	Mon, 11 Aug 2025 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905244; cv=none; b=WNgrf0/kykZlNyK31Re7ew0N9HNBgoOJT+8iBM7t+qYLKBgOLA63BcVfLDG8tgGcqIVeHtFLgPiL/g5lC1DUyO+6jlK3rO5KEVWuZltM+blNTGCdIn8dff5iaCMMIfCtxf50ot40fI5IgTHook1grJHHZ5shIg4QYqYU2dL4U+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905244; c=relaxed/simple;
	bh=+hOAPtbaTnFQ2/PvS8u0w3Y8mEBnKScZUNxwKg8O2kU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/0/m3g9oF5CTNeF3+vHCysSdDmT2oCHHdfyUfypR9kL68wO7woUcFfK9QsCTOsY4HGDTn+5mFG1FZk88KdobOt+OSrzluUf+dNc21VjBuaNiDQzwVE6cTDCjLFnasgReY3j0zqRHl/7ZJOCSSt1cDg4DKQTudovb3gyd3xiCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PUbyZh2B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dL0l013542;
	Mon, 11 Aug 2025 09:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0+RVykyrDaRQS0uHm8EY+PEI
	8EMBqo0ZjvNkV/gJZBk=; b=PUbyZh2BjZR6WdDNnJdRbkwnoApp/GNZoAvuY847
	E0GEVzsVsHB8E4wNLz9ukreG/0Gm9tux/ZZhaNtDKhDx8p3o3PIBK+Ctf+AxEVhb
	/cR3oqniqnHTrIBvQhY29k1kb34C/dPSKK7xxqal5YcxRRjeoJgRbQkTQ3vEtnkw
	C1UGjIPq6CK8B9MgkojhkCF2TEEmSA014+0+bTm0QxSaS4mIJ6zsgfiV2lrw2Y5e
	XssBTRwrCgm0Y+Z19vXPTK/oZaqfEBtc2snqXNDgqvJvH7CsLJxLCBlUFc2n3YBc
	IZHRi5Foo3Vky560r8j8DM4vuQpqdTu8Up6RvtgN1p1jpg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dupmm0b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:40:37 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57B9ealX006276
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:40:36 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 11 Aug 2025 02:40:31 -0700
Date: Mon, 11 Aug 2025 15:10:27 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>, <ilia.lin@kernel.org>,
        <djakov@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Md Sadre Alam
	<quic_mdalam@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v7 3/4] cpufreq: qcom-nvmem: Enable cpufreq for ipq5424
Message-ID: <aJm6ixlMamgX/+bV@hu-varada-blr.qualcomm.com>
References: <20250811090954.2854440-1-quic_varada@quicinc.com>
 <20250811090954.2854440-4-quic_varada@quicinc.com>
 <20250811092202.auarwnyoagebcw3o@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250811092202.auarwnyoagebcw3o@vireshk-i7>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=bY5rUPPB c=1 sm=1 tr=0 ts=6899ba95 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=48sKwPEyJ6cuvbcKtzIA:9 a=CjuIK1q_8ugA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: pdYdxVHQrS_cL44QHNremeJb1f5eIkQt
X-Proofpoint-ORIG-GUID: pdYdxVHQrS_cL44QHNremeJb1f5eIkQt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMCBTYWx0ZWRfXya6ZjmzopblY
 1IgjY2Sa1FF4m9InlwMKMTYql2fCPb5uTpxfN9qWNOCP9ZlPAumHAA837La1DcwA/rQr9fSFKMy
 H1oSi+MHuagM4qm7fHi/dUmnQ05AKIcACSdr3fIWkj/eGd+mcU7vVpts/pReKNi3ShmJQEcAVcH
 d7lqpjv/O/nyVIN0mw1CoTsXW/AXI7kZi8K6SBxKh9xcKrlLp7wPNbD4qgdAEOK+mQ8ry9WyxNu
 p7IzW9325Tvm2BYMaoJTNw22O1lO3Druvsu8Bco5Pey1az1IRB9G8+G+u0ZXa7fA2Q3fF/VPjUp
 MTSNOBxsop11kGS1roKeBENoQR4QnAhbp08z1dkqojx5hdtab0qIJylAMj0E+cM0h9okxyXJEIy
 sH3FtXJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090000

On Mon, Aug 11, 2025 at 02:52:02PM +0530, Viresh Kumar wrote:
> On 11-08-25, 14:39, Varadarajan Narayanan wrote:
> > From: Md Sadre Alam <quic_mdalam@quicinc.com>
> >
> > IPQ5424 have different OPPs available for the CPU based on
> > SoC variant. This can be determined through use of an eFuse
> > register present in the silicon.
> >
> > Added support for ipq5424 on nvmem driver which helps to
> > determine OPPs at runtime based on the eFuse register which
> > has the CPU frequency limits. opp-supported-hw dt binding
> > can be used to indicate the available OPPs for each limit.
> >
> > nvmem driver also creates the "cpufreq-dt" platform_device after
> > passing the version matching data to the OPP framework so that the
> > cpufreq-dt handles the actual cpufreq implementation.
> >
> > Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> > Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > [ Changed '!=' based check to '==' based check ]
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v5: Add 'Acked-by: Viresh Kumar'
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> >  drivers/cpufreq/qcom-cpufreq-nvmem.c | 5 +++++
> >  2 files changed, 6 insertions(+)
>
> You should have dropped this one now, as I already applied the
> previous version.

Sorry. Should I send a v8 with this dropped or is it okay?

Thanks
Varada


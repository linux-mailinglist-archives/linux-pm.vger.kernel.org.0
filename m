Return-Path: <linux-pm+bounces-10919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E7E92CFB6
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 12:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A781C2379C
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702FB190665;
	Wed, 10 Jul 2024 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aqStqJcK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D329217FD;
	Wed, 10 Jul 2024 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720608156; cv=none; b=G1BB13QfNR+DJfWLKoTyT1+7sB/OGe0cWfvn0hUxeLjmKA3xBuDw4T/Hf9SyzT1ssM0aeN9UYbgW4kEAegkUvDGl68WkwBAlS5QG6zOWQAGjkNj30fmDbIy0kdEndBBuqk2ALT7CHHpPjywGV/MtliXSO92iHu1+EA0rmEuACp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720608156; c=relaxed/simple;
	bh=ayD8gBlKt0AM6K9DCWhxBeDD+DoHF7KhDZstIfhcxLk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2rjf9BKUUeO3MrLuib2SwLAb5c27Ys4Zsg1a0DBepOXE39LoPM4ibCb+7g4beTGp8+fJLxlpHMsShweT5rWPQkxgMYKUYVImz4gPaTS6F4tNvNsNz8DTqQ1iPr/DS83Ki4n7tKBA0TBm5EyDpy5BnskSr6osWu8Vv/2t3Hhru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aqStqJcK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A9ntvA016998;
	Wed, 10 Jul 2024 10:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ayD8gBlKt0AM6K9DCWhxBeDD
	+DoHF7KhDZstIfhcxLk=; b=aqStqJcKqv1P7FccCVgOd2BTDmuaMS6G3JuPKpb1
	x7vPR8z0Sbp65IbRd17FRCWx3FT1IRK7Vh/VC/ZVica6p9IGQ2KO/D5VSwWGjsBF
	/WBzFvfBmcuMJolsJX/cxah2LVS6oIr3tsYTMc8SQZn6RgZ2q84KUlhTvZyjV2C6
	D+zB3MV/ipxkOiPVYOxUij/BczsVGOOJSYX9oJ2l6swYiG7Dl4b4zpIplSRzmBwV
	MiZ1VO8rGdBwBHdjz20jkQeFi2L/TqVBXsJui/o2i8m8GKyCMNcagSkMvRnNCSP+
	WzTEKgs9dYCFckJq8lUUSoMwYMjhYLCiyWo86oAmn0qdaA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406xa68yk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 10:42:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46AAgSwS011286
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 10:42:28 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 03:42:07 -0700
Date: Wed, 10 Jul 2024 16:12:04 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: ipq5332: Add icc provider
 ability to gcc
Message-ID: <Zo5lfDVVdgZ/iwi3@hu-varada-blr.qualcomm.com>
References: <20240709063949.4127310-1-quic_varada@quicinc.com>
 <20240709063949.4127310-4-quic_varada@quicinc.com>
 <cef54c07-4ecb-44bd-ad7c-aea475b89ffb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cef54c07-4ecb-44bd-ad7c-aea475b89ffb@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rkWirG9LXCcRGq27wtfX0eij9naWv6dL
X-Proofpoint-ORIG-GUID: rkWirG9LXCcRGq27wtfX0eij9naWv6dL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=724
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100073

On Tue, Jul 09, 2024 at 11:53:41AM +0200, Konrad Dybcio wrote:
> On 9.07.2024 8:39 AM, Varadarajan Narayanan wrote:
> > IPQ SoCs dont involve RPM in managing NoC related clocks and
> > there is no NoC scaling. Linux itself handles these clocks.
> > However, these should not be exposed as just clocks and align
> > with other Qualcomm SoCs that handle these clocks from a
> > interconnect provider.
> >
> > Hence include icc provider capability to the gcc node so that
> > peripherals can use the interconnect facility to enable these
> > clocks.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
>
> Doesn't the USB host need to have its path described to keep working?

Presently, USB host enables GCC_SNOC_USB_CLK directly using
the clocks/clock-name entries. So it is not dependent on ICC.

Shall I update the USB DT node to use interconnects now itself,
or wait until this IPQ5332 ICC enablement series is approved?
Please let me know.

Thanks
Varada


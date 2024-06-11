Return-Path: <linux-pm+bounces-8932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74019903820
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 11:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83AE81C213EE
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 09:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2688617624A;
	Tue, 11 Jun 2024 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cRqm7mEk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A4479C8;
	Tue, 11 Jun 2024 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718099209; cv=none; b=IVbnXMLPEd8jP6j8xg/9PMt0XHSfjp2Vokc7DyBDFZ+xOa6xVyOy3Im47OoH3vPemfAd0uohsYBg2ag64Y+YlFwxkeTvTTGOncVl7QRBagyC6Ugukm3PDlAsb0UwLxpBkBEwp7fDnHrTQEeO7MpaRJVnGVNqx56wQpfvmFFen94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718099209; c=relaxed/simple;
	bh=jZi4dsKlfycFcnryaS/p5kUPJ76Fz/iW/hzqA8Fhh2k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYb1HuZK3Z/Kit7WBu/yWV4mUn095m64m6AJsLmFZUQ2o7uQQE+Rux7NCoMr4nGNiFNV2seTa298ECeJ3C+WAXusP0sLZ5QYLsB0AnmjusguImPHU2fzQBXfbeZWoQxIMz60q/2FN3mMdgFalLxCCuxU7DVQ4u7BqTWf0L9zmUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cRqm7mEk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B2W4XU030546;
	Tue, 11 Jun 2024 09:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gKAt6v8xKqMwBhUj90dH94kZ
	VZnzjKMdZVwd/TK0lSY=; b=cRqm7mEkylYKNqPYNUR3EZ6TR2tef5b2nrjfIkay
	uIBvEIU/lyTUHI+L4nM8Mh7Simuhnlad+A0/wkf6qorg/0gOptzvmnZ2UWgJPCAY
	rcJRZpjOQY4Zs8QLK5eFe9O7bNRj9NuK7AICldN6FlowsUqzVXgR6FBOJg5peI40
	9fzcNjilsQoWkHxEYYUN4LVCA42TwhypgdRzeXY9fIe7Uc6wyRtPwfNgLHC3keEC
	HJJFWENdOBGeov8uVI9356bkOhF9kSNXJotRoI8oKKX61/+dCdPJn1aMAMj/6sZ2
	QEAKVN2jp8fLCJHSXn4Of3a9fBTX4DzWFJvNJfvPk6nV6w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfh36rpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 09:46:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45B9kgoO030396
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 09:46:42 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 11 Jun 2024 02:46:37 -0700
Date: Tue, 11 Jun 2024 15:16:33 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v11 0/6] Add interconnect driver for IPQ9574 SoC
Message-ID: <Zmgc+Qzwt6Zbg/w+@hu-varada-blr.qualcomm.com>
References: <20240430064214.2030013-1-quic_varada@quicinc.com>
 <ZjXrTywO6+iRaEYk@hu-varada-blr.qualcomm.com>
 <90bb9256-d54d-4e01-aa06-4184e2b95d48@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <90bb9256-d54d-4e01-aa06-4184e2b95d48@linaro.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IYhudBaKzLt4h69wLwyKuUeK6-lcqNe9
X-Proofpoint-GUID: IYhudBaKzLt4h69wLwyKuUeK6-lcqNe9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_05,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110073

On Thu, Jun 06, 2024 at 04:07:23PM +0200, Konrad Dybcio wrote:
> On 4.05.2024 10:01 AM, Varadarajan Narayanan wrote:
> > Bjorn,
> >
> >> On Tue, Apr 30, 2024 at 12:12:08PM +0530, Varadarajan Narayanan wrote:
> >> MSM platforms manage NoC related clocks and scaling from RPM.
> >> However, in IPQ SoCs, RPM is not involved in managing NoC
> >> related clocks and there is no NoC scaling.
> >>
> >> However, there is a requirement to enable some NoC interface
> >> clocks for the accessing the peripherals present in the
> >> system. Hence add a minimalistic interconnect driver that
> >> establishes a path from the processor/memory to those peripherals
> >> and vice versa.
> >>
> >> Change icc-clk driver to take master and slave ids instead
> >> of auto generating.
> >>
> >> Currently, drivers/clk/qcom/clk-cbf-8996.c is the only user of
> >> icc-clk. And, it had exactly one master and one slave node.
> >> For this the auto generated master (= 1) and slave (= 0) was
> >> enough.
> >>
> >> However, when drivers/clk/qcom/gcc-ipq9574.c wanted to make use
> >> of the icc-clk framework, it had more number of master and slave
> >> nodes and the auto generated ids did not suit the usage.
> >>
> >> ---
> >> v11:	No code changes
> >> 	Commit log changed for the first patch
> >> 	Added Acked-By: to 3 patches
> >
> > Can this be included in your driver changes for 6.10?
>
Konrad,

> FWIW there is still an open discussion at v9
> <CAA8EJpqENsojPQmCbma_nQLEZq8nK1fz1K0JdtvLd=kPrH_DBw@mail.gmail.com>

Thanks for reminding. Have responded to it.
https://lore.kernel.org/linux-arm-msm/Zmgb+OjdBNw71sC1@hu-varada-blr.qualcomm.com/

-Varada


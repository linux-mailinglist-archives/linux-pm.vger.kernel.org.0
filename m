Return-Path: <linux-pm+bounces-10015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB14D917813
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 07:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17EE61C21A84
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA871428F4;
	Wed, 26 Jun 2024 05:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eAYW8kpP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFFA28DDF;
	Wed, 26 Jun 2024 05:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379646; cv=none; b=bQrk6ALJy3t7/olySEdkXgSyn8A+z6st5hlsQvYqNlwGVgtqVRDxjns/nCtaG2KRLOchBNdpV+z3elpZyn2toXibF/i+3o8q2WNBmIsZv9F8xa3LRYpUZh9m8EPAXxuXXSExdL5t/iYAdfTZQMRXBOpvxXtDI6KRoFICbVoniVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379646; c=relaxed/simple;
	bh=tr6b7YzaNDp+6chz6an4To4uD1paZT/4oVgc4Ozi5zI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyyUtUN/rI5NpgGMc4H9I/hRgaagLPXo8ijybT0cttR/JAvHYHoqxas7TaURmk6sKnXyhI7WO6h4z8jGdpp4eSSFPvo67NRwL38eLZ2TDp21hZWyVQvliVD7QKHoz+pRFQ4wF4s3hbn17fy7X2buGg6Ixp8u3WlSez0sdQorCZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eAYW8kpP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIxMdE018107;
	Wed, 26 Jun 2024 05:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=H1ebhpLl+WMhVtgvEy9phQd1
	h+dpJM8YkGd3n9aCPWA=; b=eAYW8kpP+LYcT8KjW7aE8PIr9FMtcMSaxD0n2Fer
	7nsAUzZz6aV4xqo6mV6DKbXzLBwxSRS1ASLsOBPVU1nOV+mEMdIM6axa448lj17d
	FsR04ocxn2C+0qGguZRzvzeiurzUuhxxZrRlZaPfUcbmsSUOW+Xi7Yl5ebRoS10l
	DDiZha5FFhb8V1p1jg/Q63/xQMXVfU9HBaCtdZBnJOv6FkDwfRa93urgUOPaMLeQ
	ZeBW5jLlsai/Me83QDA75VPsVum3NkOknaSZw2l9VQscXYZvFqZi6kYKILMRf8Yz
	XQI74PKdIclZ2SxmplIInyqAbWtCVIX4XhXY5JamY2qz8g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6r993-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 05:27:13 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45Q5RBqi022196
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 05:27:11 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Jun 2024 22:27:06 -0700
Date: Wed, 26 Jun 2024 10:57:02 +0530
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
Message-ID: <ZnumpkYR2ILpbOwF@hu-varada-blr.qualcomm.com>
References: <20240430064214.2030013-1-quic_varada@quicinc.com>
 <ZjXrTywO6+iRaEYk@hu-varada-blr.qualcomm.com>
 <90bb9256-d54d-4e01-aa06-4184e2b95d48@linaro.org>
 <Zmgc+Qzwt6Zbg/w+@hu-varada-blr.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zmgc+Qzwt6Zbg/w+@hu-varada-blr.qualcomm.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dWqOxM9yRy2tFHsSWLqgpDrfMRDaAXu3
X-Proofpoint-ORIG-GUID: dWqOxM9yRy2tFHsSWLqgpDrfMRDaAXu3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_03,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260040

On Tue, Jun 11, 2024 at 03:16:33PM +0530, Varadarajan Narayanan wrote:
> On Thu, Jun 06, 2024 at 04:07:23PM +0200, Konrad Dybcio wrote:
> > On 4.05.2024 10:01 AM, Varadarajan Narayanan wrote:
> > > Bjorn,
> > >
> > >> On Tue, Apr 30, 2024 at 12:12:08PM +0530, Varadarajan Narayanan wrote:
> > >> MSM platforms manage NoC related clocks and scaling from RPM.
> > >> However, in IPQ SoCs, RPM is not involved in managing NoC
> > >> related clocks and there is no NoC scaling.
> > >>
> > >> However, there is a requirement to enable some NoC interface
> > >> clocks for the accessing the peripherals present in the
> > >> system. Hence add a minimalistic interconnect driver that
> > >> establishes a path from the processor/memory to those peripherals
> > >> and vice versa.
> > >>
> > >> Change icc-clk driver to take master and slave ids instead
> > >> of auto generating.
> > >>
> > >> Currently, drivers/clk/qcom/clk-cbf-8996.c is the only user of
> > >> icc-clk. And, it had exactly one master and one slave node.
> > >> For this the auto generated master (= 1) and slave (= 0) was
> > >> enough.
> > >>
> > >> However, when drivers/clk/qcom/gcc-ipq9574.c wanted to make use
> > >> of the icc-clk framework, it had more number of master and slave
> > >> nodes and the auto generated ids did not suit the usage.
> > >>
> > >> ---
> > >> v11:	No code changes
> > >> 	Commit log changed for the first patch
> > >> 	Added Acked-By: to 3 patches
> > >
> > > Can this be included in your driver changes for 6.10?
> >
> Konrad,
>
> > FWIW there is still an open discussion at v9
> > <CAA8EJpqENsojPQmCbma_nQLEZq8nK1fz1K0JdtvLd=kPrH_DBw@mail.gmail.com>
>
> Thanks for reminding. Have responded to it.
> https://lore.kernel.org/linux-arm-msm/Zmgb+OjdBNw71sC1@hu-varada-blr.qualcomm.com/

Bjorn/Konrad,

Can this be merged for 6.11. I believe the discussion open at v9
has been addressed. Please let me know if anything is still pending.

Below patches depend on this series:

	PCI: https://lore.kernel.org/linux-arm-msm/20240512082858.1806694-1-quic_devipriy@quicinc.com/
	NSSCC: https://lore.kernel.org/linux-arm-msm/20240625070536.3043630-1-quic_devipriy@quicinc.com/

Thanks
Varada


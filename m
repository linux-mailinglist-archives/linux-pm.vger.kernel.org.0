Return-Path: <linux-pm+bounces-11391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 213F493BD6C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 09:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEEEC1F21AB3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 07:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEB2172784;
	Thu, 25 Jul 2024 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AD/6i5C9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B10339A0;
	Thu, 25 Jul 2024 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894153; cv=none; b=cUh+ZaPME5ozN8DEDrQHw+hBMI2rFVl3aMVa4Y6ZJZ9yXd38eIBNqGM94x91awEYdLfC8PoJUW6IzjbTKw5N+dvTxRKMlswJF0jK686zbZ7K46uUKF02NyCve+WNjWDhCNCvRtxp+Qju1UB47oPwxsspaACKWI4mO370NT4eYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894153; c=relaxed/simple;
	bh=chCmIQYabtrZYvk26GkBBhDtyVx5a8TzmOZ1Q+e7BmU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGLlINXB5mcunuCSHmrnqdllyRjRAMNKav1xaFPPjd4aJWgN4G9AAiLzwvP3aonRYyaf4fSzapYGuAlG+zwYNfmiBn0xqs41sz38OLrC4eiAfBKOWsTqFfxkqaPTfA7TidCaOCGOUq+rBC56c5jndVTOopdv5BxZYq+hwND1mCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AD/6i5C9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OIA6ax005413;
	Thu, 25 Jul 2024 07:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=chCmIQYabtrZYvk26GkBBhDt
	yVx5a8TzmOZ1Q+e7BmU=; b=AD/6i5C9RIPqIrJ0aAtD8ggUUQVP3YcWNS5bfq6S
	eR4uxzsyswDDbmgEpjOzBFi/IeoB/1RFLYJ1ZQAP+4krsCc0+Mw4fKHXLO1q+W6j
	2txmaEPyuiG/DbBN3FmFaRZP0weOJS1APa1VTjSTakaqYEQ+7cRiFLktd1CfRiq1
	DmWERtAIqJx7kGu+wBLb+0H1gHhlOtVcqmI3OC2l9fhPkREaFwYfk5/tynHVED2W
	yZv1azHX+uW6PeN4JETqbPSHp8hD67+Fms5kZqZ8jSaw6UKM+NufRnGkz03GD7J7
	SUfFcm+25e13Xn8zM8fUL/wsE8Va75e77XqNzTfgQcvv/A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g487mbxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 07:55:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46P7tjbb031582
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 07:55:45 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Jul 2024 00:55:40 -0700
Date: Thu, 25 Jul 2024 13:25:36 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <quic_kathirav@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: usb: qcom,dwc3: Update ipq5332 clock
 details
Message-ID: <ZqIE+JuzLldybKBE@hu-varada-blr.qualcomm.com>
References: <20240723090304.336428-1-quic_varada@quicinc.com>
 <20240723090304.336428-3-quic_varada@quicinc.com>
 <ac34c454-4800-4057-9a50-e0c5db1d3806@kernel.org>
 <ZqDoXu9+Y4+O8M7W@hu-varada-blr.qualcomm.com>
 <bc2da461-fd21-44d1-85a7-f89c60e2b207@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bc2da461-fd21-44d1-85a7-f89c60e2b207@kernel.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vOHc3t_mfv5P5DKBlbdKpKqjay9Gdq_3
X-Proofpoint-GUID: vOHc3t_mfv5P5DKBlbdKpKqjay9Gdq_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_07,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=863
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407250050

On Wed, Jul 24, 2024 at 01:55:41PM +0200, Krzysztof Kozlowski wrote:
> On 24/07/2024 13:41, Varadarajan Narayanan wrote:
> > On Wed, Jul 24, 2024 at 08:27:03AM +0200, Krzysztof Kozlowski wrote:
> >> On 23/07/2024 11:03, Varadarajan Narayanan wrote:
> >>> USB uses icc-clk framework to enable the NoC interface clock.
> >>> Hence the 'iface' clock is removed from the list of clocks.
> >>> Update the clock-names list accordingly.
> >>
> >> But the clock is still there and is still used by this block. This looks
> >> like adjusting hardware per Linux implementation.
> >>
> >> Why suddenly this clock was removed from this hardware?
> >
> > This clock per se is not used by the USB block. It is needed to
> > enable the path for CPU to reach the USB block (and vice versa).
> > Hence, we were adviced to use the ICC framework to enable this
> > clock and not the clocks/clock-names DT entries.
> >
> > Please refer to [1] where similar clocks for IPQ9574 were NAK'ed.
>
> So the original submission was not correct?

Unlike MSM SoC, IPQ SoC doesn't use RPM to aggregate bandwidth
requests and scale the NoC frequency. The NoCs are turned on and
set to a specific frequency at boot time and that is used for the
lifetime of the system. Hence interconnect was not considered and
this submission was accepted.

The same approach was used for PCIe and at that point the
consensus was to move to interconnect. Hence implemented the ICC
driver and updating the existing USB driver to use the ICC
driver.

> You really need to stop sending DTS based on current driver support and
> focus on proper hardware description.
>
> Such things pop up from time to time for Qualcomm and I don't see much
> of improvement. And we do not talk about some ancient code, predating
> guidelines, but IPQ5332 upstreamed ~1 year ago.

We are trying, but falling short. Hopefully we meet the
expectations soon.

Thanks
Varada


Return-Path: <linux-pm+bounces-10929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E975492D04E
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 13:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D0228303F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 11:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79AB19007C;
	Wed, 10 Jul 2024 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="efI8BhGx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847618FA32;
	Wed, 10 Jul 2024 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609956; cv=none; b=qTw+vDZ0gEt/pFHRPTizgdoMGeU8y5aPbWV4+bupoQfauJ2IYCD1RfoxBEDtpblmigtm+xFlxVcW1ESEjdPPfB5wwe6dLDh+bHmO8AJmEZOg6Bw/N6N/7m4crmGqUzUgJVLhN7tUOZDBrIIZxlBKgko1P80fstEbRlz1oaHxgEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609956; c=relaxed/simple;
	bh=8/E++mpm7F+QbXoRovuuKDBrziItWPNk9KVoa1fbdRc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVK0+ngYhPcZxy7t9y/S5Wp+Wvkmzl3AGz3PvLWqcCBJeKB0nidPEvQQbMCQjOSrfFSgCmU4r5vnG5ztjWbLILLL8YVqnHTlfNa3sDnOXlS10jVW2kBNOIPm/dHPRkJGx8+sOWGftyJGj4kV+CHT+ZnGFPFYZFRJ6bqsDTIHLgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=efI8BhGx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A2tnpX022205;
	Wed, 10 Jul 2024 11:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8/E++mpm7F+QbXoRovuuKDBr
	ziItWPNk9KVoa1fbdRc=; b=efI8BhGxNkAbHyzHmpnyTw1EelEur5Tvg79/4QqU
	Wez58TzXtyEe5ngWqTb2c/8UpAg/FjsFEIU3e2SwHtIR7nJ4q0ucNMAmLS2zMFxG
	4gr6tJhYvCGOwFbpKiyeLFbWnqzc3A76ltjwQVsFMfcPsWmkqxzU6Uq9tiTCgG2r
	tLmKWoUUsmZiLiukm8ZjEBUyxH+xbhTdqOk0G4VpXbfxRrxLWLqHIIbQlUHipX6R
	Zl6qL4rbf0SSg+R8qlBlsUu5iFMt5ff9FaC+qf439spM3ygDnruLe0ktH6KIfXy+
	HDuaioJztYiMpsSMOiqf1eh60C0ETE9dEtU4zoQ1weeTSg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406y3hgr9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:12:31 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46ABCUTe001228
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:12:30 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 04:12:26 -0700
Date: Wed, 10 Jul 2024 16:42:22 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: ipq5332: Add icc provider
 ability to gcc
Message-ID: <Zo5slnIPa1Q8dmDZ@hu-varada-blr.qualcomm.com>
References: <20240709063949.4127310-1-quic_varada@quicinc.com>
 <20240709063949.4127310-4-quic_varada@quicinc.com>
 <cef54c07-4ecb-44bd-ad7c-aea475b89ffb@linaro.org>
 <Zo5lfDVVdgZ/iwi3@hu-varada-blr.qualcomm.com>
 <a4deabfa-1366-47ef-993f-2fae3e206a44@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a4deabfa-1366-47ef-993f-2fae3e206a44@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZLxX44WT-z1MeXaE1fAoLzZwUjIzC_zD
X-Proofpoint-GUID: ZLxX44WT-z1MeXaE1fAoLzZwUjIzC_zD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=581 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100077

On Wed, Jul 10, 2024 at 12:49:13PM +0200, Konrad Dybcio wrote:
> On 10.07.2024 12:42 PM, Varadarajan Narayanan wrote:
> > On Tue, Jul 09, 2024 at 11:53:41AM +0200, Konrad Dybcio wrote:
> >> On 9.07.2024 8:39 AM, Varadarajan Narayanan wrote:
> >>> IPQ SoCs dont involve RPM in managing NoC related clocks and
> >>> there is no NoC scaling. Linux itself handles these clocks.
> >>> However, these should not be exposed as just clocks and align
> >>> with other Qualcomm SoCs that handle these clocks from a
> >>> interconnect provider.
> >>>
> >>> Hence include icc provider capability to the gcc node so that
> >>> peripherals can use the interconnect facility to enable these
> >>> clocks.
> >>>
> >>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >>> ---
> >>
> >> Doesn't the USB host need to have its path described to keep working?
> >
> > Presently, USB host enables GCC_SNOC_USB_CLK directly using
> > the clocks/clock-name entries. So it is not dependent on ICC.
> >
> > Shall I update the USB DT node to use interconnects now itself,
> > or wait until this IPQ5332 ICC enablement series is approved?
> > Please let me know.
>
> Definitely so. Now that you registered that clock with the
> interconnect framework, the current usage is essentially
> circumventing it..
>
> Say some consumers casted an ICC vote on that node, and then
> the USB driver called set_rate on the clock.. The data from
> icc-clk would be discarded

Will update, test and post a new version.

Thanks
Varada


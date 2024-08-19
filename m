Return-Path: <linux-pm+bounces-12488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CF4957142
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 855B7B27F3E
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD1F18B484;
	Mon, 19 Aug 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lf95m1a0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1B18B490;
	Mon, 19 Aug 2024 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086400; cv=none; b=IejKwuiMngm3Xd6M5loCoeCaQsE3baLbUo7wNRJRUSx4zJ027iuiH6ImCTTvEzodxhofcGVpT+lcc1eT2Fe8hkjWFIH/0DL+YmjgzADhdUp0E2MjwnmoVC1kqPmUo2nWZrEa26fmW1FikYVolivDE4p8yw8tUA43safnpd1ut/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086400; c=relaxed/simple;
	bh=T31sr9ecJ09ZTCDAK5AA+RVsAYDONM0fjWQhCDR+28k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq/Xo7ugnI9UMfW57uXjeTNs+A6Iv8HJ/6/flFaZuubl55RZv4bC69HRg5cc7ilf8ygceX/gNZvvuVSTWQ387a8BJaV6U4pSQr9tL2TrdcRQGeloLAr+9gpmphILvCYwEjh1qRs8//kv+JO91ItegQp9oLk24hHlVI/2jcOllN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lf95m1a0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JAOABV009008;
	Mon, 19 Aug 2024 16:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gJki5caVv9znXTvJlIlxMBk7
	Wh1r46Xd9zmvk0DrXO8=; b=Lf95m1a0bRB0vdWaHvPHMIrZ6kVe3fFHoaeuIZa+
	TgX5xV31npYyU5+Mzp35W+Lizt95qZVESZ/eVZHZNFnGM7LxMtqLO0FI5OHHMM7F
	cmxbOqKovcYk3/hG11lETgEzT5Sdva8Yd6DMW6Qegj5OaKprC2A7qEBJ4qzowenF
	46nhWLTcvyn2q/wPc8LMQ1aq48p6jh/RCz9c8vM/LIDGyuJaR5BOG1UypPUQ1R20
	g0ezsg2Y17cZtTg9mg9wAx6xfPMeKdqdyAvrmbLZDcUu+Tp2XHTnAKwc978Y14Er
	XfBZGcXqt/QefTOh/VmdKFsjpeqEyj998pLBtCQqt/eYug==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412m8751fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 16:53:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47JGrBCg024852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 16:53:11 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 19 Aug 2024 09:53:10 -0700
Date: Mon, 19 Aug 2024 09:53:09 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Johan Hovold <johan@kernel.org>
CC: Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Heikki
 Krogerus" <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Chris Lew <quic_clew@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd
	<swboyd@chromium.org>,
        Amit Pundir <amit.pundir@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 0/3] soc: qcom: pmic_glink: v6.11-rc bug fixes
Message-ID: <ZsN4dcErSt3nioWn@hu-bjorande-lv.qualcomm.com>
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
 <ZsNpSt3BtdFIT6ml@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsNpSt3BtdFIT6ml@hovoldconsulting.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fpl3DnDx9f5RKON6XvSckXyZx93_LW79
X-Proofpoint-ORIG-GUID: fpl3DnDx9f5RKON6XvSckXyZx93_LW79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=909 priorityscore=1501 adultscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190112

On Mon, Aug 19, 2024 at 05:48:26PM +0200, Johan Hovold wrote:
> On Sun, Aug 18, 2024 at 04:17:36PM -0700, Bjorn Andersson wrote:
> > Amit and Johan both reported a NULL pointer dereference in the
> > pmic_glink client code during initialization, and Stephen Boyd pointed
> > out the problem (race condition).
> 
> > In addition to the NULL pointer dereference, there is the -ECANCELED
> > issue reported here:
> > https://lore.kernel.org/all/Zqet8iInnDhnxkT9@hovoldconsulting.com/
> > I have not yet been able to either reproduce this or convince myself
> > that this is the same issue.
> 
> I can confirm that I still see the -ECANCELED issue with this series
> applied:
> 
> [    8.979329] pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to send altmode request: 0x10 (-125)
> [    9.004735] pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to request altmode notifications: -125
> 

Could you confirm that you're seeing a call to
qcom_glink_handle_intent_req_ack() with granted == 0, leading to the
transfer failing.

It would also be nice, just for completeness sake to rule out that you
do not get a call to qcom_glink_intent_req_abort() here.

Regards,
Bjorn

> Johan
> 


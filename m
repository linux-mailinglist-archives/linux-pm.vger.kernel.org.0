Return-Path: <linux-pm+bounces-12440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B7F956DFE
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB8028844B
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 14:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E705717D341;
	Mon, 19 Aug 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VgLslQpO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2917AE00;
	Mon, 19 Aug 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079401; cv=none; b=kbkMDkAgwnQDLo1tFFTRomwDhcpyemUMVs/0LDTjSN6D1n47ZHvmB987oJ+cTM4WjLFKvZNwziuPXpIitaKVHu/7o4oEdiBGBW+YqqPGTx4N3miKbPP5nsyTyrgLRIu4KMMh6RyH/N3m5UEQUQdvB9G41Et/y3CnUw9AqpJd5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079401; c=relaxed/simple;
	bh=lCOxCv40WXDgFR9GjwMDEyPONnrRyqFSij6rZxydBI0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKuRTiAUlYAfwANV7GgFkO8NFaqzfpFvRFJw6x+b2WjoXcD9bvuJ8idc0KBRR++yPstX1qLxOpCq4QP9Ufn3OMMTzQvB2YjtADFMFnImo/yw0vGs212LJufiw9KNq4KEGGO/3RFsGUljDc5T/kKRipCxza+o2jr7PRqMibUVnvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VgLslQpO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JCLRPB002309;
	Mon, 19 Aug 2024 14:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QTSFQYZoEceIs8w8FgHAXTc6
	nwskDsv2GruJCmAcXk8=; b=VgLslQpONX2bKJJ7WP4fdvPACGgQPA3FAmCzy9+B
	vIzacuV9A1zZUU8zWwoXbkyG1+KJrrfOwpTDSqeKQaXEbitzK90roHmlrccIBmOz
	rFyhoSKmO6Hi5KxXmna1C8V2ieqGcGC1VHn1Ck/J+fFUZEYe9FFQsoBGnGbfV6TH
	/03A+GZwIvLSz8XbTDsjik6xzXhocAOYe+uDnVFRIOd3TvYzA/AvFqWpfOhK1HAE
	qkpaDyxke4x77A0vduuqBH6w/Pn3yJeKjcyz9srMcDb0rMor2p7fucUNwrpIk9wQ
	eeXCuaqOn4OAocyHtTUJHVN47q1pfmsYR9+R2Yz0XvX+Tw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4145yw8dam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:56:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47JEuWm2029307
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:56:32 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 19 Aug 2024 07:56:32 -0700
Date: Mon, 19 Aug 2024 07:56:31 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Heikki
 Krogerus" <heikki.krogerus@linux.intel.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        "Chris
 Lew" <quic_clew@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Amit Pundir <amit.pundir@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Johan Hovold
	<johan@kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 0/3] soc: qcom: pmic_glink: v6.11-rc bug fixes
Message-ID: <ZsNdHzlBi0hqwevY@hu-bjorande-lv.qualcomm.com>
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
 <2024081914-exploit-yonder-4d51@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024081914-exploit-yonder-4d51@gregkh>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AzpB0OJMjjSrS4Zpa63Q8oZgoSs6-HRz
X-Proofpoint-GUID: AzpB0OJMjjSrS4Zpa63Q8oZgoSs6-HRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=889
 bulkscore=0 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408190100

On Mon, Aug 19, 2024 at 04:07:41PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Aug 18, 2024 at 04:17:36PM -0700, Bjorn Andersson wrote:
> > Amit and Johan both reported a NULL pointer dereference in the
> > pmic_glink client code during initialization, and Stephen Boyd pointed
> > out the problem (race condition).
> > 
> > While investigating, and writing the fix, I noticed that
> > ucsi_unregister() is called in atomic context but tries to sleep, and I
> > also noticed that the condition for when to inform the pmic_glink client
> > drivers when the remote has gone down is just wrong.
> > 
> > So, let's fix all three.
> > 
> > As mentioned in the commit message for the UCSI fix, I have a series in
> > the works that makes the GLINK callback happen in a sleepable context,
> > which would remove the need for the clients list to be protected by a
> > spinlock, and removing the work scheduling. This is however not -rc
> > material...
> > 
> > In addition to the NULL pointer dereference, there is the -ECANCELED
> > issue reported here:
> > https://lore.kernel.org/all/Zqet8iInnDhnxkT9@hovoldconsulting.com/
> > I have not yet been able to either reproduce this or convince myself
> > that this is the same issue.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> What tree are these to go through?  I can take them through mine, but if
> someone else wants to, feel free to route them some other way.
> 

It's primarily soc/qcom content, so I can pick them through the qcom soc
tree.

Regards,
Bjorn

> thanks,
> 
> greg k-h
> 


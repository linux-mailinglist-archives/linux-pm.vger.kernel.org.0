Return-Path: <linux-pm+bounces-12471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E329570A6
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56CCB216D9
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCB813D8B4;
	Mon, 19 Aug 2024 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JivF0Qld"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF03E1A270;
	Mon, 19 Aug 2024 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085942; cv=none; b=gYQBn7aalfPxoJklaFHTuOHz87pxnwlqjkdIMur+SFzu6dPFLuHxsOU3AWWe0a/6UZ+i2bjsGGqq57PKzw3QzEVoWS4Q/qnyomj6kPsfo7MqzwWlyhjJWSgHcq/PDs75+sQdmVHu5okAX80n0afGdCNYGQtbFsfKSykhj98TW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085942; c=relaxed/simple;
	bh=mLXVcAlBQxesC5mYwH0mrm1yZ0PmpuWB9hCkSUTiLac=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxpijhpKnDzjHPXNaAN/IHz15L0H9DBW1ao11neHdLwMPgKD3LH0cmqfVlo0rGw5Rb9RB6k+OxFepdwxDEpUG5azYW2JpGhyqr6/npAPisOt5D0B6Npy7BPuGIiN62te3MjnKEejyYs1ab+RY+AGVazt3X6CXnkMW6FC1PAyj4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JivF0Qld; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JARZs3032383;
	Mon, 19 Aug 2024 16:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=h0CZ3FbHFgwTCAQ0tC+3gec0
	WEhxchas++se84DTU1s=; b=JivF0QldgA7iH1mOT4Q1GCy0Lan8Qo2syqJ414FA
	YAPMlK3G7fL57WVwmwhwt60Xa4uPc7qnWunUcFuZP9Ef3GWC4bmXkNGea1YwXSc7
	F1CwABuYfhsflAs2bZtC40486lNbXY+t5yhLfQzwUk7PEU2eJIj3H5aLdPQ3JurK
	SCBPSNTe0WsttMYyfxnQYtqdIATJ3IGOak9mHXTtB6X8DsuoGkZgV/wwpe9Z2ee4
	FlbYz0+zXdZwoGy80fJDzitduhQNbItqPrPDQ9y7ZiEgEAHCuF+it+5HLOmPi639
	Rakm0Auwwh/dkGg3At7jkLdLo/hqlo0T+JPAEdajNVTJ4w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412m8750xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 16:45:32 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47JGjVeR002759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 16:45:31 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 19 Aug 2024 09:45:30 -0700
Date: Mon, 19 Aug 2024 09:45:29 -0700
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
Subject: Re: [PATCH 2/3] usb: typec: ucsi: Move unregister out of atomic
 section
Message-ID: <ZsN2qR3tuXylb2qK@hu-bjorande-lv.qualcomm.com>
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
 <20240818-pmic-glink-v6-11-races-v1-2-f87c577e0bc9@quicinc.com>
 <ZsNfkuiRK9VqBSLT@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsNfkuiRK9VqBSLT@hovoldconsulting.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8YusWF3djvAyXmCoqzz8j6Q2-ZiAFgNF
X-Proofpoint-ORIG-GUID: 8YusWF3djvAyXmCoqzz8j6Q2-ZiAFgNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190112

On Mon, Aug 19, 2024 at 05:06:58PM +0200, Johan Hovold wrote:
> On Sun, Aug 18, 2024 at 04:17:38PM -0700, Bjorn Andersson wrote:
> > Commit 'caa855189104 ("soc: qcom: pmic_glink: Fix race during
> > initialization")' 
> 
> This commit does not exist, but I think you really meant to refer to
> 
> 	9329933699b3 ("soc: qcom: pmic_glink: Make client-lock non-sleeping")
> 
> and possibly also
> 
> 	635ce0db8956 ("soc: qcom: pmic_glink: don't traverse clients list without a lock")
> 
> here.
> 

Yeah, I copy-pasted the wrong SHA1. Prior to commit 9329933699b3 ("soc:
qcom: pmic_glink: Make client-lock non-sleeping") the PDR notification
happened from a worker with only mutexes held.

> > moved the pmic_glink client list under a spinlock, as
> > it is accessed by the rpmsg/glink callback, which in turn is invoked
> > from IRQ context.
> > 
> > This means that ucsi_unregister() is now called from IRQ context, which
> > isn't feasible as it's expecting a sleepable context.
> 
> But this is not correct as you say above that the callback has always
> been made in IRQ context. Then this bug has been there since the
> introduction of the UCSI driver by commit
> 

No, I'm stating that commit 9329933699b3 ("soc: qcom: pmic_glink: Make
client-lock non-sleeping") was needed because the client list is
traversed under the separate glink callback, which has always been made
in IRQ context.

> 	62b5412b1f4a ("usb: typec: ucsi: add PMIC Glink UCSI driver")
> 
> > An effort is under
> > way to get GLINK to invoke its callbacks in a sleepable context, but
> > until then lets schedule the unregistration.
> > 
> > A side effect of this is that ucsi_unregister() can now happen
> > after the remote processor, and thereby the communication link with it, is
> > gone. pmic_glink_send() is amended with a check to avoid the resulting
> > NULL pointer dereference, but it becomes expecting to see a failing send
> 
> Perhaps you can rephrase this bit ("becomes expecting to see").
> 

Sure.

> > upon shutting down the remote processor (e.g. during a restart following
> > a firmware crash):
> > 
> >   ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: failed to send UCSI write request: -5
> > 
> > Fixes: caa855189104 ("soc: qcom: pmic_glink: Fix race during initialization")
> 
> So this should be
> 
> Fixes: 62b5412b1f4a ("usb: typec: ucsi: add PMIC Glink UCSI driver")
> 

I think it should be:

9329933699b3 ("soc: qcom: pmic_glink: Make client-lock non-sleeping")

> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>  
> > diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> > index ac53a81c2a81..a33056eec83d 100644
> > --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> > +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> > @@ -68,6 +68,9 @@ struct pmic_glink_ucsi {
> >  
> >  	struct work_struct notify_work;
> >  	struct work_struct register_work;
> > +	spinlock_t state_lock;
> > +	unsigned int pdr_state;
> > +	unsigned int new_pdr_state;
> 
> Should these be int to match the notify callback (and enum
> servreg_service_state)?
> 

Ohh my. I made it unsigned because I made it unsigned in pmic_glink,
when I wrote that. But as you point out, the type passed around is an
enum servreg_service_state and it's mostly handled as a signed int.

That said, pmic_glink actually filters the value space down to UP/DOWN,
so making this "bool pdr_up" (pd_running?) and "bool ucsi_registered"
would make this cleaner...

> >  	u8 read_buf[UCSI_BUF_SIZE];
> >  };
> > @@ -244,8 +247,22 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
> >  static void pmic_glink_ucsi_register(struct work_struct *work)
> >  {
> >  	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
> > +	unsigned long flags;
> > +	unsigned int new_state;
> 
> Then int here too.
> 

Yes.

> > +
> > +	spin_lock_irqsave(&ucsi->state_lock, flags);
> > +	new_state = ucsi->new_pdr_state;
> > +	spin_unlock_irqrestore(&ucsi->state_lock, flags);
> > +
> > +	if (ucsi->pdr_state != SERVREG_SERVICE_STATE_UP) {
> > +		if (new_state == SERVREG_SERVICE_STATE_UP)
> > +			ucsi_register(ucsi->ucsi);
> > +	} else {
> > +		if (new_state == SERVREG_SERVICE_STATE_DOWN)
> > +			ucsi_unregister(ucsi->ucsi);
> 
> Do you risk a double deregistration (and UAF/double free) here?
> 

I believe we're good.

Thank you,
Bjorn

> > +	}
> >  
> > -	ucsi_register(ucsi->ucsi);
> > +	ucsi->pdr_state = new_state;
> >  }
> 
> Johan


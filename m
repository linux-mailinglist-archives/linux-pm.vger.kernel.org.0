Return-Path: <linux-pm+bounces-12398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DC9956155
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 05:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD8F1C21502
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 03:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4839113D283;
	Mon, 19 Aug 2024 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J1Kr5lt4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5761E13B79F;
	Mon, 19 Aug 2024 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724036761; cv=none; b=KSFO/pZc1TCr0h7kdYHKF57FczKu+sabZO0Koai/F8wHCtFhxXEhrnsFlnLS7+VaQCxmZOozNpHhnSmlhs0KPIE6TlY3sR97ji3bcHkPd+4iRX5X/3Rj/Na3c63txjhtCNjH7f8BUacSbR4LbbEGrJwxPwz/B3NoyooebibvaLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724036761; c=relaxed/simple;
	bh=qvxTRMwIAztD0QmYd7Rog3CTgLZUh2raZlkxc8+ozd8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4+bKxKwNtAVt6x/VW6RdlxTg69oELY/NuDaCCKK3MJqHSkhe6O5moUZExj70ZHNE0z4W/W2vUoQ4HM4vUxgnRsgUtErwdyuAa5F/4wAV/lU0DtPmEGzgYne9+gPsWJ15B/A5vCRa7AwdOq/8+29fVbMlS1xVPQ+PojvA0yDeQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J1Kr5lt4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47INOqKn032383;
	Mon, 19 Aug 2024 03:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xrIy6iY7ahIFNbwZ2iD2K8RQ
	YdSUK6c4i2+BLomgv9U=; b=J1Kr5lt4sY8Oc7yGyPERiCoiLWUx3dOgdbZBm2kD
	UZgZaY9gmiqmPS7AUcRlZr90w+zhhO8QpAUBVyo5OBLeAw2xqJIBPo3SmsH3zuF0
	6gX9UN8mi6YDAIcWWt/nALdminw5lXYaZyUXtbTUKOhD14TpZHlzi9WGZvCXV3MR
	CA7jult+CNiabEJFp2/uqYsOUElM5Ag7gPcErvmCNzK3H3FkAG9UoWXuLxGL+kW6
	jCbfo1X443P0qx9g6DXYHQJDmXzPMRBzbhWNDVKdU+8p78IqmQCVj2vrF8POMju1
	eLnY2puluo58QOG+yTz+9/0T5aBa9MPzY4XLVx4tMVb8CA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412m872sf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 03:05:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47J35prp006070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 03:05:51 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 18 Aug 2024 20:05:50 -0700
Date: Sun, 18 Aug 2024 20:05:49 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
        Chris Lew <quic_clew@quicinc.com>, Stephen Boyd <swboyd@chromium.org>,
        Amit Pundir <amit.pundir@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/3] usb: typec: ucsi: Move unregister out of atomic
 section
Message-ID: <ZsK2jSheqBlCW7OC@hu-bjorande-lv.qualcomm.com>
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
 <20240818-pmic-glink-v6-11-races-v1-2-f87c577e0bc9@quicinc.com>
 <4F313FA4-C2C7-4BD8-8E42-64F98EACCBA2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4F313FA4-C2C7-4BD8-8E42-64F98EACCBA2@linaro.org>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: InxtmKFNEQoZIL585ippG8ULABY3O7g-
X-Proofpoint-ORIG-GUID: InxtmKFNEQoZIL585ippG8ULABY3O7g-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-18_24,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190022

On Mon, Aug 19, 2024 at 08:16:25AM +0700, Dmitry Baryshkov wrote:
> On 19 August 2024 06:17:38 GMT+07:00, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
> >Commit 'caa855189104 ("soc: qcom: pmic_glink: Fix race during
> >initialization")' moved the pmic_glink client list under a spinlock, as
> >it is accessed by the rpmsg/glink callback, which in turn is invoked
> >from IRQ context.
> >
> >This means that ucsi_unregister() is now called from IRQ context, which
> >isn't feasible as it's expecting a sleepable context. An effort is under
> >way to get GLINK to invoke its callbacks in a sleepable context, but
> >until then lets schedule the unregistration.
> >
> >A side effect of this is that ucsi_unregister() can now happen
> >after the remote processor, and thereby the communication link with it, is
> >gone. pmic_glink_send() is amended with a check to avoid the resulting
> >NULL pointer dereference, but it becomes expecting to see a failing send
> >upon shutting down the remote processor (e.g. during a restart following
> >a firmware crash):
> >
> >  ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: failed to send UCSI write request: -5
> >
> >Fixes: caa855189104 ("soc: qcom: pmic_glink: Fix race during initialization")
> >Cc: stable@vger.kernel.org
> >Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> >---
> > drivers/soc/qcom/pmic_glink.c       | 10 +++++++++-
> > drivers/usb/typec/ucsi/ucsi_glink.c | 28 +++++++++++++++++++++++-----
> > 2 files changed, 32 insertions(+), 6 deletions(-)
> >
> >diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> >index 58ec91767d79..e4747f1d3da5 100644
> >--- a/drivers/soc/qcom/pmic_glink.c
> >+++ b/drivers/soc/qcom/pmic_glink.c
> >@@ -112,8 +112,16 @@ EXPORT_SYMBOL_GPL(pmic_glink_register_client);
> > int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
> > {
> > 	struct pmic_glink *pg = client->pg;
> >+	int ret;
> > 
> >-	return rpmsg_send(pg->ept, data, len);
> >+	mutex_lock(&pg->state_lock);
> >+	if (!pg->ept)
> >+		ret = -ECONNRESET;
> >+	else
> >+		ret = rpmsg_send(pg->ept, data, len);
> >+	mutex_unlock(&pg->state_lock);
> >+
> >+	return ret;
> > }
> > EXPORT_SYMBOL_GPL(pmic_glink_send);
> > 
> >diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> >index ac53a81c2a81..a33056eec83d 100644
> >--- a/drivers/usb/typec/ucsi/ucsi_glink.c
> >+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> >@@ -68,6 +68,9 @@ struct pmic_glink_ucsi {
> > 
> > 	struct work_struct notify_work;
> > 	struct work_struct register_work;
> >+	spinlock_t state_lock;
> >+	unsigned int pdr_state;
> >+	unsigned int new_pdr_state;
> > 
> > 	u8 read_buf[UCSI_BUF_SIZE];
> > };
> >@@ -244,8 +247,22 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
> > static void pmic_glink_ucsi_register(struct work_struct *work)
> > {
> > 	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
> >+	unsigned long flags;
> >+	unsigned int new_state;
> >+
> >+	spin_lock_irqsave(&ucsi->state_lock, flags);
> >+	new_state = ucsi->new_pdr_state;
> >+	spin_unlock_irqrestore(&ucsi->state_lock, flags);
> >+
> >+	if (ucsi->pdr_state != SERVREG_SERVICE_STATE_UP) {
> >+		if (new_state == SERVREG_SERVICE_STATE_UP)
> >+			ucsi_register(ucsi->ucsi);
> >+	} else {
> >+		if (new_state == SERVREG_SERVICE_STATE_DOWN)
> >+			ucsi_unregister(ucsi->ucsi);
> >+	}
> > 
> >-	ucsi_register(ucsi->ucsi);
> >+	ucsi->pdr_state = new_state;
> > }
> 
> Is there a chance if a race condition if the firmware is restarted quickly, but the system is under heavy mist: 
> - the driver gets DOWN event, updates the state and schedules the work,
> - the work starts to execute, reads the state,
> - the driver gets UP event, updates the state, but the work is not rescheduled as it is still executing 
> - the worker finishes unregistering the UCSI.
> 

I was under the impression that if we reach the point where we start
executing the worker, then a second schedule_work() would cause the
worker to run again. But I might be mistaken here.

What I do expect though is that if we for some reason don't start
executing the work before the state becomes UP again, the UCSI core
wouldn't know that the firmware has been reset.


My proposal is to accept this risk for v6.11 (and get the benefit of
things actually working) and then take a new swing at getting rid of all
these workers for v6.12/13. Does that sound reasonable?

Regards,
Bjorn

> 
> 
> > 
> > static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
> >@@ -269,11 +286,12 @@ static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
> > static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
> > {
> > 	struct pmic_glink_ucsi *ucsi = priv;
> >+	unsigned long flags;
> > 
> >-	if (state == SERVREG_SERVICE_STATE_UP)
> >-		schedule_work(&ucsi->register_work);
> >-	else if (state == SERVREG_SERVICE_STATE_DOWN)
> >-		ucsi_unregister(ucsi->ucsi);
> >+	spin_lock_irqsave(&ucsi->state_lock, flags);
> >+	ucsi->new_pdr_state = state;
> >+	spin_unlock_irqrestore(&ucsi->state_lock, flags);
> >+	schedule_work(&ucsi->register_work);
> > }
> > 
> > static void pmic_glink_ucsi_destroy(void *data)
> >
> 


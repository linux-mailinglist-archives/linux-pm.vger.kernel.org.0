Return-Path: <linux-pm+bounces-12405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99FE9564BB
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 09:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917BB2810F5
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 07:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3356158531;
	Mon, 19 Aug 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RY5C4ZbR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3913BC1E
	for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052782; cv=none; b=KgPpOhy0bo+SqO+BQq1FJsuDSECcdPGyMVLphg2Y1KVtLQQ9NEM5iywRGCTS5SokEguxIzQVwvEK0AfQ0qFpka5f40Ju6VEevPtJmfMyVgN5BDC5DMo7c77hO2Pl38K8DrFjbRCVQ4lQG6qqB7MkmZr+FZrU+1TSpNaLi6Tn7so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052782; c=relaxed/simple;
	bh=lqG59gpccqoJniQbhLyFTrxHLnQRRH2XLMNU6pCm0bc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JEgka1qJrUTDxQAUcISR5Ne4+Kb6ZLQadnlsgo7OxwLwCefYDdhAikJltLFFvuRQIUtgyCr2PqCYka7AzthYg3gzbz0ZxSw3VnpQY0yv2RKRbFv6Q4tCtx4JtBiMg7mN1A7V8p9gWn1oQ6z2SeOLbIjX/8faOBWzLdUfCXqGnRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RY5C4ZbR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-710dc3015bfso2661782b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 00:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724052779; x=1724657579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bVF+vaplgIfDeqn8Jo/FGo4c3zDJgnAYKY22inJTgUE=;
        b=RY5C4ZbRSr/qdLgu8HKFVmN4ewPDru+AGNit5VwvKAv2yzJ5q/1Cn2JD4O0PoDzNrg
         n4Y17grSMdalKiNcQRoGY1BotaeUwRikPBKihx1dg8/kOI8cFFQ7cOINwIcQcwPz6OUe
         JNHcgWqnG+vI0WGZTfC1te5jTgr/+qvUVyEATPyvbOQGd2Y8MIy076rdQCJELXEDZaEl
         AhvDkVIut86r7ZILIBCWT9YqXW6hPQkuDOqNNRV8BCl6ppyolhV+DCukv+7kG1dJzlx1
         ClnUL3F4dioS4qYew83d7I4Hns6b9mVujnudIg2oIyPPq0kpxc2NDFIapVoLxFCmEsRb
         E10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724052779; x=1724657579;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVF+vaplgIfDeqn8Jo/FGo4c3zDJgnAYKY22inJTgUE=;
        b=M5L77LVet0HBhKZB+FyDQJlzEXC8aSNzyec/d90EjCNVfSGXe+IwJhe5/BHLwrfMP+
         Vhdfa/hPRlYSmYyUgQlP941XB3fG09+vWSksngfdy3QuOV3e9gYp8xZMBrTbg7XnRck4
         UVASlDutxKDKuxau1yDBvrz/F9lD36e5qq7RzRC2iusfqK9v1TkrmzTYGDShZshRvZQX
         kapw1XYqA6uEhnB4b+lRG7VggLZIYsuyJKt6qisNkhPH5CclPdkTV5YhncCeROQCG3pU
         0dWbT90bG4EEmXQVaClQetP4nG/LpMKzLHnmb5z6W+ejRnHIS4pVLnLJdrb2Cv7l7oVU
         M0lA==
X-Forwarded-Encrypted: i=1; AJvYcCUMEoTokhW/VkAJm3PcaNQlyLzgRxrtXCN26EiBitvybHpWHvTvonDG/BPBOzsuHbgfMMYIFZol3yzSE0/cV1+vVZmN0rDKgJY=
X-Gm-Message-State: AOJu0YxY5sZedV4/SnvzusdGjD2L+Zak+mr0ZTp0D5v+fF48h9v5FzWL
	/jCw5Ah8EExU16Os2j2QVIpWWY5L+PiTHkF+Ug/+QsjAravW+Uc++aaO4rhozMQ=
X-Google-Smtp-Source: AGHT+IFfm2w3BSOecH3ZgllW9SAhYMQsRd/FMRvM7RHDXRP2ro3rXfQFvLQQyRy2k8EZr/AD4ObC6g==
X-Received: by 2002:a05:6a00:17a7:b0:70e:98e2:c76e with SMTP id d2e1a72fcca58-713c66515f1mr15127310b3a.6.1724052779034;
        Mon, 19 Aug 2024 00:32:59 -0700 (PDT)
Received: from ?IPv6:::1? ([2405:9800:b900:a564:77f2:b46a:c9f8:ca95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef5787sm6111501b3a.120.2024.08.19.00.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 00:32:58 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:32:53 +0700
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
CC: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Hovold <johan+linaro@kernel.org>, Chris Lew <quic_clew@quicinc.com>,
 Stephen Boyd <swboyd@chromium.org>, Amit Pundir <amit.pundir@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/3=5D_usb=3A_typec=3A_ucsi=3A_M?=
 =?US-ASCII?Q?ove_unregister_out_of_atomic_section?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZsK2jSheqBlCW7OC@hu-bjorande-lv.qualcomm.com>
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com> <20240818-pmic-glink-v6-11-races-v1-2-f87c577e0bc9@quicinc.com> <4F313FA4-C2C7-4BD8-8E42-64F98EACCBA2@linaro.org> <ZsK2jSheqBlCW7OC@hu-bjorande-lv.qualcomm.com>
Message-ID: <A366AFBC-1775-421A-BEAC-274741DF3192@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19 August 2024 10:05:49 GMT+07:00, Bjorn Andersson <quic_bjorande@quicin=
c=2Ecom> wrote:
>On Mon, Aug 19, 2024 at 08:16:25AM +0700, Dmitry Baryshkov wrote:
>> On 19 August 2024 06:17:38 GMT+07:00, Bjorn Andersson <quic_bjorande@qu=
icinc=2Ecom> wrote:
>> >Commit 'caa855189104 ("soc: qcom: pmic_glink: Fix race during
>> >initialization")' moved the pmic_glink client list under a spinlock, a=
s
>> >it is accessed by the rpmsg/glink callback, which in turn is invoked
>> >from IRQ context=2E
>> >
>> >This means that ucsi_unregister() is now called from IRQ context, whic=
h
>> >isn't feasible as it's expecting a sleepable context=2E An effort is u=
nder
>> >way to get GLINK to invoke its callbacks in a sleepable context, but
>> >until then lets schedule the unregistration=2E
>> >
>> >A side effect of this is that ucsi_unregister() can now happen
>> >after the remote processor, and thereby the communication link with it=
, is
>> >gone=2E pmic_glink_send() is amended with a check to avoid the resulti=
ng
>> >NULL pointer dereference, but it becomes expecting to see a failing se=
nd
>> >upon shutting down the remote processor (e=2Eg=2E during a restart fol=
lowing
>> >a firmware crash):
>> >
>> >  ucsi_glink=2Epmic_glink_ucsi pmic_glink=2Eucsi=2E0: failed to send U=
CSI write request: -5
>> >
>> >Fixes: caa855189104 ("soc: qcom: pmic_glink: Fix race during initializ=
ation")
>> >Cc: stable@vger=2Ekernel=2Eorg
>> >Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc=2Ecom>
>> >---
>> > drivers/soc/qcom/pmic_glink=2Ec       | 10 +++++++++-
>> > drivers/usb/typec/ucsi/ucsi_glink=2Ec | 28 +++++++++++++++++++++++---=
--
>> > 2 files changed, 32 insertions(+), 6 deletions(-)
>> >
>> >diff --git a/drivers/soc/qcom/pmic_glink=2Ec b/drivers/soc/qcom/pmic_g=
link=2Ec
>> >index 58ec91767d79=2E=2Ee4747f1d3da5 100644
>> >--- a/drivers/soc/qcom/pmic_glink=2Ec
>> >+++ b/drivers/soc/qcom/pmic_glink=2Ec
>> >@@ -112,8 +112,16 @@ EXPORT_SYMBOL_GPL(pmic_glink_register_client);
>> > int pmic_glink_send(struct pmic_glink_client *client, void *data, siz=
e_t len)
>> > {
>> > 	struct pmic_glink *pg =3D client->pg;
>> >+	int ret;
>> >=20
>> >-	return rpmsg_send(pg->ept, data, len);
>> >+	mutex_lock(&pg->state_lock);
>> >+	if (!pg->ept)
>> >+		ret =3D -ECONNRESET;
>> >+	else
>> >+		ret =3D rpmsg_send(pg->ept, data, len);
>> >+	mutex_unlock(&pg->state_lock);
>> >+
>> >+	return ret;
>> > }
>> > EXPORT_SYMBOL_GPL(pmic_glink_send);
>> >=20
>> >diff --git a/drivers/usb/typec/ucsi/ucsi_glink=2Ec b/drivers/usb/typec=
/ucsi/ucsi_glink=2Ec
>> >index ac53a81c2a81=2E=2Ea33056eec83d 100644
>> >--- a/drivers/usb/typec/ucsi/ucsi_glink=2Ec
>> >+++ b/drivers/usb/typec/ucsi/ucsi_glink=2Ec
>> >@@ -68,6 +68,9 @@ struct pmic_glink_ucsi {
>> >=20
>> > 	struct work_struct notify_work;
>> > 	struct work_struct register_work;
>> >+	spinlock_t state_lock;
>> >+	unsigned int pdr_state;
>> >+	unsigned int new_pdr_state;
>> >=20
>> > 	u8 read_buf[UCSI_BUF_SIZE];
>> > };
>> >@@ -244,8 +247,22 @@ static void pmic_glink_ucsi_notify(struct work_st=
ruct *work)
>> > static void pmic_glink_ucsi_register(struct work_struct *work)
>> > {
>> > 	struct pmic_glink_ucsi *ucsi =3D container_of(work, struct pmic_glin=
k_ucsi, register_work);
>> >+	unsigned long flags;
>> >+	unsigned int new_state;
>> >+
>> >+	spin_lock_irqsave(&ucsi->state_lock, flags);
>> >+	new_state =3D ucsi->new_pdr_state;
>> >+	spin_unlock_irqrestore(&ucsi->state_lock, flags);
>> >+
>> >+	if (ucsi->pdr_state !=3D SERVREG_SERVICE_STATE_UP) {
>> >+		if (new_state =3D=3D SERVREG_SERVICE_STATE_UP)
>> >+			ucsi_register(ucsi->ucsi);
>> >+	} else {
>> >+		if (new_state =3D=3D SERVREG_SERVICE_STATE_DOWN)
>> >+			ucsi_unregister(ucsi->ucsi);
>> >+	}
>> >=20
>> >-	ucsi_register(ucsi->ucsi);
>> >+	ucsi->pdr_state =3D new_state;
>> > }
>>=20
>> Is there a chance if a race condition if the firmware is restarted quic=
kly, but the system is under heavy mist:=20
>> - the driver gets DOWN event, updates the state and schedules the work,
>> - the work starts to execute, reads the state,
>> - the driver gets UP event, updates the state, but the work is not resc=
heduled as it is still executing=20
>> - the worker finishes unregistering the UCSI=2E
>>=20
>
>I was under the impression that if we reach the point where we start
>executing the worker, then a second schedule_work() would cause the
>worker to run again=2E But I might be mistaken here=2E

I don't have full source code at hand and the docs only speak about being =
queued, so it is perfectly possible that I am mistaken here=2E

>
>What I do expect though is that if we for some reason don't start
>executing the work before the state becomes UP again, the UCSI core
>wouldn't know that the firmware has been reset=2E
>
>
>My proposal is to accept this risk for v6=2E11 (and get the benefit of
>things actually working) and then take a new swing at getting rid of all
>these workers for v6=2E12/13=2E Does that sound reasonable?


Yes, makes sense to me=2E=20

Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>


>
>Regards,
>Bjorn
>
>>=20
>>=20
>> >=20
>> > static void pmic_glink_ucsi_callback(const void *data, size_t len, vo=
id *priv)
>> >@@ -269,11 +286,12 @@ static void pmic_glink_ucsi_callback(const void =
*data, size_t len, void *priv)
>> > static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
>> > {
>> > 	struct pmic_glink_ucsi *ucsi =3D priv;
>> >+	unsigned long flags;
>> >=20
>> >-	if (state =3D=3D SERVREG_SERVICE_STATE_UP)
>> >-		schedule_work(&ucsi->register_work);
>> >-	else if (state =3D=3D SERVREG_SERVICE_STATE_DOWN)
>> >-		ucsi_unregister(ucsi->ucsi);
>> >+	spin_lock_irqsave(&ucsi->state_lock, flags);
>> >+	ucsi->new_pdr_state =3D state;
>> >+	spin_unlock_irqrestore(&ucsi->state_lock, flags);
>> >+	schedule_work(&ucsi->register_work);
>> > }
>> >=20
>> > static void pmic_glink_ucsi_destroy(void *data)
>> >
>>=20



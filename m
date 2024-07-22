Return-Path: <linux-pm+bounces-11286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE6A9388BF
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 08:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46EABB20DA8
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 06:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368E5179A8;
	Mon, 22 Jul 2024 06:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YS1zItC/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1462F26;
	Mon, 22 Jul 2024 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721628329; cv=none; b=s/LImKSjuHcZBWeKFQHyH4tflM0gVjjh0tHbNTqRf+P5eyYJN4UdiNq0Uj9m9puwF7lqSxUWu+qNtj31s5ldAeisyJzI3ySQ+zlCp3BRhE4ZKF4HnTXvq/SDdS9Zc06pULS37d14dkV4+m6a/ROXZGcvnnV2aIfzAoQfkAHw/As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721628329; c=relaxed/simple;
	bh=ot0ga8bRdPH4v9X9BxrgDdbzThdk5I4c40OAQw2KIYg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTxvrrVDAqcAyQ5oDLwpqXCk/NIStqgbUYYO1wDrv0ygaJv0wIS7EnOdjvdN7Wv5mZcaisSKByluYQZDTRWq45iFEH6f3nGUcqFP6IQ5BP6xh+PTAISMVApTj5zv5FwYGaKfv5SmCcmoLv+Gmlf8sWNF6Y5MFZXo1HnSpfdLBIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YS1zItC/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M0pFxw009618;
	Mon, 22 Jul 2024 06:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kPOCMe6t/U0WJp2e32dF6ru1
	NveNnHm9mbaos1MAeBQ=; b=YS1zItC/bHQLG43cgDgVcv4SSwb2UPvwFALrq/Vi
	MsOxncgDEcHxBmEjxxPhhnu4FOu3ovJRFFTGW9JOvtNDsf32Z4TXvXOOMXYFcfVF
	aNYfxQK7JLJfzYboWa9T1sduA18BNQRY/Upp8ACdLXVsNk3WyhdVsm9QEpBr9f6I
	fU1Hc/ENtGcwXe1zrzScuHJppOGwDj610RQe9ZWaZGzP/OJlNJSlbTApQiAv3Ntf
	EWxBoO4Sr4WomMjt0oP/IBHaQ0tKYFiZGakceZdPygHQjJ6tytFP/hd+t2SaP/fi
	qKCd0V3D8pDHvpIuUYhUycg7Nx3JjioRSMHG7fc9rIm1Xg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g2xeaw4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 06:05:21 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46M65KTS002699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 06:05:21 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 21 Jul 2024 23:05:15 -0700
Date: Mon, 22 Jul 2024 11:35:12 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] clk: qcom: ipq5332: Use icc-clk for enabling NoC
 related clocks
Message-ID: <Zp32mJZdEH1MLrLd@hu-varada-blr.qualcomm.com>
References: <20240711113239.3063546-1-quic_varada@quicinc.com>
 <20240711113239.3063546-4-quic_varada@quicinc.com>
 <iwdennlw4njxefulw5e2wofu4pylep65el4hiiso6xqmoaq5fb@i4hrltrn2o6z>
 <ZpjxobF6LZMMN8A9@hu-varada-blr.qualcomm.com>
 <CAA8EJpqHrgi-AvfxGxwph0MEs0=ALV_7XWoUcSgGTG3vVj62FA@mail.gmail.com>
 <Zpt9Jb0aIg96yKN3@hu-varada-blr.qualcomm.com>
 <CAA8EJppqoDR=q_6Dh4dF-rh5f-2B1=JZZPe83EbrCRGu-NmB2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJppqoDR=q_6Dh4dF-rh5f-2B1=JZZPe83EbrCRGu-NmB2Q@mail.gmail.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FUHGficn9ltdcs08p76-c6UFcKr68SmQ
X-Proofpoint-ORIG-GUID: FUHGficn9ltdcs08p76-c6UFcKr68SmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_02,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220046

On Sat, Jul 20, 2024 at 12:05:59PM +0300, Dmitry Baryshkov wrote:
> On Sat, 20 Jul 2024 at 12:02, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > On Thu, Jul 18, 2024 at 01:47:32PM +0300, Dmitry Baryshkov wrote:
> > > On Thu, 18 Jul 2024 at 13:42, Varadarajan Narayanan
> > > <quic_varada@quicinc.com> wrote:
> > > >
> > > > On Sat, Jul 13, 2024 at 07:21:29PM +0300, Dmitry Baryshkov wrote:
> > > > > On Thu, Jul 11, 2024 at 05:02:38PM GMT, Varadarajan Narayanan wrote:
> > > > > > Use the icc-clk framework to enable few clocks to be able to
> > > > > > create paths and use the peripherals connected on those NoCs.
> > > > > >
> > > > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > > > ---
> > > > > >  drivers/clk/qcom/gcc-ipq5332.c | 36 +++++++++++++++++++++++++++++-----
> > > > > >  1 file changed, 31 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
> > > > > > index f98591148a97..6d7672cae0f7 100644
> > > > > > --- a/drivers/clk/qcom/gcc-ipq5332.c
> > > > > > +++ b/drivers/clk/qcom/gcc-ipq5332.c
> > > > > > @@ -4,12 +4,14 @@
> > > > > >   */
> > > > > >
> > > > > >  #include <linux/clk-provider.h>
> > > > > > +#include <linux/interconnect-provider.h>
> > > > > >  #include <linux/mod_devicetable.h>
> > > > > >  #include <linux/module.h>
> > > > > >  #include <linux/platform_device.h>
> > > > > >  #include <linux/regmap.h>
> > > > > >
> > > > > >  #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> > > > > > +#include <dt-bindings/interconnect/qcom,ipq5332.h>
> > > > > >
> > > > > >  #include "clk-alpha-pll.h"
> > > > > >  #include "clk-branch.h"
> > > > > > @@ -131,12 +133,14 @@ static struct clk_alpha_pll gpll4_main = {
> > > > > >                      * (will be added soon), so the clock framework
> > > > > >                      * disables this source. But some of the clocks
> > > > > >                      * initialized by boot loaders uses this source. So we
> > > > > > -                    * need to keep this clock ON. Add the
> > > > > > -                    * CLK_IGNORE_UNUSED flag so the clock will not be
> > > > > > -                    * disabled. Once the consumer in kernel is added, we
> > > > > > -                    * can get rid of this flag.
> > > > > > +                    * need to keep this clock ON.
> > > > > > +                    *
> > > > > > +                    * After initial bootup, when the ICC framework turns
> > > > > > +                    * off unused paths, as part of the icc-clk dependencies
> > > > > > +                    * this clock gets disabled resulting in a hang. Marking
> > > > > > +                    * it as critical to ensure it is not turned off.
> > > > >
> > > > > Previous comment was pretty clear: there are missing consumers, the flag
> > > > > will be removed once they are added. Current comment doesn't make sense.
> > > > > What is the reason for the device hang if we have all the consumers in
> > > > > place?
> > > >
> > > > Earlier, since there were no consumers for this clock, it got
> > > > disabled via clk_disable_unused() and CLK_IGNORE_UNUSED helped
> > > > prevent that.
> > > >
> > > > Now, since this clk is getting used indirectly via icc-clk
> > > > framework, it doesn't qualify for being disabled by
> > > > clk_disable_unused(). However, when icc_sync_state is called, if
> > > > it sees there are no consumers for a path and that path gets
> > > > disabled, the relevant clocks get disabled and eventually this
> > > > clock also gets disabled. To avoid this have changed 'flags' from
> > > > CLK_IGNORE_UNUSED -> CLK_IS_CRITICAL.
> > >
> > > You don't seem to be answering my question: "What is the reason for
> > > the device hang if we have all the consumers in place?"
> > > Could you please answer it rather than describing the CCF / icc-clk behaviour?
> >
> > Sorry if I hadn't expressed myself clearly. All the consumers are
> > not there in place yet.
> >
> > > Are there any actual consumers for GPLL4 at this point? If not, why do
> > > you want to keep it running? Usually all PLLs are shut down when there
> > > are no consumers and then restarted when required. This is the
> > > expected and correct behaviour.
> >
> > There are consumers for GPLL4, but they are getting disabled by
> > clk_disable_unused (this is expected). There seems to be some
> > consumer that got enabled in boot loader itself but not accounted
> > in Linux because of which we are relying on CLK_IGNORE_UNUSED.
> >
> > If missing consumer(s) is identified, we can do away with this
> > flag. Till that is done, was hoping CLK_IS_CRITICAL could help.
>
> NAK, please identify missing consumers instead of landing workarounds.

Please review v3, have identified the missing consumer.

Thanks
Varada


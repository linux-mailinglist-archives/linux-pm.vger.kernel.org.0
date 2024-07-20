Return-Path: <linux-pm+bounces-11265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 456FF938013
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jul 2024 11:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5241F21D01
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jul 2024 09:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706973A260;
	Sat, 20 Jul 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pswl2GI4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8158E8830;
	Sat, 20 Jul 2024 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721466172; cv=none; b=U/ShDG+H51tNxuZ/kXbwBHT7+C3D+EHSnO6QVDCJekCNgY0zyZcrTcJMWhYfeQBTS7SFAyFMEVEuxquvyu1tcbKTThLVO8lsXmgVF+PE3W2WNk1+JWbVCzn05smwQ1w+hAD36pDYJiVEqjuanAHd3LnWczwLYRpq9nDEn9UedR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721466172; c=relaxed/simple;
	bh=nEYZaYwiAAQBLiIIm/uuWESTEfm20+ytFKWXjQA0y9Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WndEZ/gVGcRIengjGtlfHOqCAc1jtLZOGCg9jCxcgfXeJyvBCmzyrexJwOsQzji8OxU64SZ3j80MKxGD6VnG5N+eH3lbmtbG31bpLWXQz6nw+nIdcFiP3dIs7qrY0AOXbKn2WXuRMpG0W4juWrXb44kjm7MdI7ys5N28jWX9yNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pswl2GI4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46K8eqt6003233;
	Sat, 20 Jul 2024 09:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JgbLO+BrfezU7OI5SgmnXSg/
	fDyYu091fFqsRcz5Nzg=; b=pswl2GI4CzF3IqW6WarEW9V+xmeY28Nwnk85s68r
	CGib3G7C+iGBRUZF1dgW49fPx6+hYRap/DgmjDFoHo4oc8tdDGDvBDx7awWv3ne9
	Y8NkEuI3SSuy0eldFnl0MH6o2gTsa26LycfeBYCUWn2BQ3pYUv0UTh5t+LRkeeHL
	Mip0eMYXRGNiDfAnsmop31HmOERgkHwjQtNBhWl6CHWVwn3sRoXknu2OigqQLSXT
	9bXnwuJEcPF4L4uAb22489D64apSwrdcYdLNmiKRB02Dq47FlduUIygJMeS7b7QS
	Ik+z9QNPtR0vBgvP4J+YHHUnANH3mr26JaEqgp8s7vMXnw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g6djr7gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jul 2024 09:02:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46K92cI4026188
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jul 2024 09:02:38 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 20 Jul 2024 02:02:33 -0700
Date: Sat, 20 Jul 2024 14:32:29 +0530
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
Message-ID: <Zpt9Jb0aIg96yKN3@hu-varada-blr.qualcomm.com>
References: <20240711113239.3063546-1-quic_varada@quicinc.com>
 <20240711113239.3063546-4-quic_varada@quicinc.com>
 <iwdennlw4njxefulw5e2wofu4pylep65el4hiiso6xqmoaq5fb@i4hrltrn2o6z>
 <ZpjxobF6LZMMN8A9@hu-varada-blr.qualcomm.com>
 <CAA8EJpqHrgi-AvfxGxwph0MEs0=ALV_7XWoUcSgGTG3vVj62FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpqHrgi-AvfxGxwph0MEs0=ALV_7XWoUcSgGTG3vVj62FA@mail.gmail.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ndjB3nHq9whzaOwYBUYPtg0OXYz9j96a
X-Proofpoint-ORIG-GUID: ndjB3nHq9whzaOwYBUYPtg0OXYz9j96a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407200065

On Thu, Jul 18, 2024 at 01:47:32PM +0300, Dmitry Baryshkov wrote:
> On Thu, 18 Jul 2024 at 13:42, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > On Sat, Jul 13, 2024 at 07:21:29PM +0300, Dmitry Baryshkov wrote:
> > > On Thu, Jul 11, 2024 at 05:02:38PM GMT, Varadarajan Narayanan wrote:
> > > > Use the icc-clk framework to enable few clocks to be able to
> > > > create paths and use the peripherals connected on those NoCs.
> > > >
> > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > ---
> > > >  drivers/clk/qcom/gcc-ipq5332.c | 36 +++++++++++++++++++++++++++++-----
> > > >  1 file changed, 31 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
> > > > index f98591148a97..6d7672cae0f7 100644
> > > > --- a/drivers/clk/qcom/gcc-ipq5332.c
> > > > +++ b/drivers/clk/qcom/gcc-ipq5332.c
> > > > @@ -4,12 +4,14 @@
> > > >   */
> > > >
> > > >  #include <linux/clk-provider.h>
> > > > +#include <linux/interconnect-provider.h>
> > > >  #include <linux/mod_devicetable.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/regmap.h>
> > > >
> > > >  #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> > > > +#include <dt-bindings/interconnect/qcom,ipq5332.h>
> > > >
> > > >  #include "clk-alpha-pll.h"
> > > >  #include "clk-branch.h"
> > > > @@ -131,12 +133,14 @@ static struct clk_alpha_pll gpll4_main = {
> > > >                      * (will be added soon), so the clock framework
> > > >                      * disables this source. But some of the clocks
> > > >                      * initialized by boot loaders uses this source. So we
> > > > -                    * need to keep this clock ON. Add the
> > > > -                    * CLK_IGNORE_UNUSED flag so the clock will not be
> > > > -                    * disabled. Once the consumer in kernel is added, we
> > > > -                    * can get rid of this flag.
> > > > +                    * need to keep this clock ON.
> > > > +                    *
> > > > +                    * After initial bootup, when the ICC framework turns
> > > > +                    * off unused paths, as part of the icc-clk dependencies
> > > > +                    * this clock gets disabled resulting in a hang. Marking
> > > > +                    * it as critical to ensure it is not turned off.
> > >
> > > Previous comment was pretty clear: there are missing consumers, the flag
> > > will be removed once they are added. Current comment doesn't make sense.
> > > What is the reason for the device hang if we have all the consumers in
> > > place?
> >
> > Earlier, since there were no consumers for this clock, it got
> > disabled via clk_disable_unused() and CLK_IGNORE_UNUSED helped
> > prevent that.
> >
> > Now, since this clk is getting used indirectly via icc-clk
> > framework, it doesn't qualify for being disabled by
> > clk_disable_unused(). However, when icc_sync_state is called, if
> > it sees there are no consumers for a path and that path gets
> > disabled, the relevant clocks get disabled and eventually this
> > clock also gets disabled. To avoid this have changed 'flags' from
> > CLK_IGNORE_UNUSED -> CLK_IS_CRITICAL.
>
> You don't seem to be answering my question: "What is the reason for
> the device hang if we have all the consumers in place?"
> Could you please answer it rather than describing the CCF / icc-clk behaviour?

Sorry if I hadn't expressed myself clearly. All the consumers are
not there in place yet.

> Are there any actual consumers for GPLL4 at this point? If not, why do
> you want to keep it running? Usually all PLLs are shut down when there
> are no consumers and then restarted when required. This is the
> expected and correct behaviour.

There are consumers for GPLL4, but they are getting disabled by
clk_disable_unused (this is expected). There seems to be some
consumer that got enabled in boot loader itself but not accounted
in Linux because of which we are relying on CLK_IGNORE_UNUSED.

If missing consumer(s) is identified, we can do away with this
flag. Till that is done, was hoping CLK_IS_CRITICAL could help.

Thanks
Varada



Return-Path: <linux-pm+bounces-9715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8297C9116E8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 01:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B01A283B4A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 23:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0050A14387F;
	Thu, 20 Jun 2024 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dQBRcETp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220E7482ED;
	Thu, 20 Jun 2024 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718926649; cv=none; b=OCIrMvdrebK5+OI1LLyNVuQqs+iQ3VmySdUtvFoqPoXICXZ2iz6H6Opg/OVWJdCEmoT9/c2vMt8ko2bpM6AuhuMsOXW2ETYPZORaV2Mz9dlgajnPorCavFBZ0ijoHH4Rw7jGd7M4OYZipJT7WEzQTNeLbduHp9/pkOkGLdaYVPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718926649; c=relaxed/simple;
	bh=ahjfBUeLfeo1fxhXjHk6wp/gQtPJzH+k5Vz/WaHQqDI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBBm5/RtQnn67muElPHrKBEVusESyG61WxrG0xZkIJwdvtScgj7iRYz7tiFnDz4hVK36aYUJSEq6O5cf2CSaZ8HFVUhy13wrt4uYcrA/6JqETNXaBcrCC+ycx425yuGAW1Uk6K83hNzyHfCy6Q55keUZ5ZO5sFABDZxHaS4zQv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dQBRcETp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHC6IK011849;
	Thu, 20 Jun 2024 23:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3TZij88SGIKu2ouzX+gUyKRo
	FlEWEYwTyShDW092wco=; b=dQBRcETpCCEqrmLHQgvaggunSSZtkCtm1P6GWcTJ
	JnomayxfAacDeLm/qhaBnhUwbWpSR5IDG7hOQouwS/oxrXNYiM7GT/Rku1xlUfRq
	v5SGp6S6N34Aqu5pO7lm/B1m4KdRC90BgKvpVhteyO2p+ltc8H54yANmEdOnlp4Y
	ZecWkKvDh8Fq/BT9xpx6qGPJOOolHHf44ZeKfkUtgHJYTmUu02p4vUsvdDbCyrcC
	/1QjrAKPPf6C3+vC8RcIiLnoXefNIrQu1joz0oqJQGF/PCfuyWLxbc9hIRp9w5oc
	FFMjJly+Ob+VHQivRn9axYxWYxBjTJKr2NuJsSK/+KjQJw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrkvgw5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 23:37:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KNbAx3016285
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 23:37:11 GMT
Received: from hu-eberman-lv.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Jun 2024 16:37:10 -0700
Date: Thu, 20 Jun 2024 16:37:09 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Sebastian Reichel <sre@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] firmware: psci: Read and use vendor reset types
Message-ID: <20240620162547309-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-3-086950f650c8@quicinc.com>
 <20240619135143.kr2tx4ynxayc5v3a@bogus>
 <20240619080933071-0700.eberman@hu-eberman-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240619080933071-0700.eberman@hu-eberman-lv.qualcomm.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FPdfh-nyfdNH2V3YNMdyeKVIT0F722rp
X-Proofpoint-ORIG-GUID: FPdfh-nyfdNH2V3YNMdyeKVIT0F722rp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_10,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406200172

Hi Sudeep and Sebastian,

On Wed, Jun 19, 2024 at 08:28:06AM -0700, Elliot Berman wrote:
> On Wed, Jun 19, 2024 at 02:51:43PM +0100, Sudeep Holla wrote:
> > On Mon, Jun 17, 2024 at 10:18:09AM -0700, Elliot Berman wrote:
> > > SoC vendors have different types of resets and are controlled through
> > > various registers. For instance, Qualcomm chipsets can reboot to a
> > > "download mode" that allows a RAM dump to be collected. Another example
> > > is they also support writing a cookie that can be read by bootloader
> > > during next boot. PSCI offers a mechanism, SYSTEM_RESET2, for these
> > > vendor reset types to be implemented without requiring drivers for every
> > > register/cookie.
> > > 
> > > Add support in PSCI to statically map reboot mode commands from
> > > userspace to a vendor reset and cookie value using the device tree.
> > > 
> > > A separate initcall is needed to parse the devicetree, instead of using
> > > psci_dt_init because mm isn't sufficiently set up to allocate memory.
> > > 
> > > Reboot mode framework is close but doesn't quite fit with the
> > > design and requirements for PSCI SYSTEM_RESET2. Some of these issues can
> > > be solved but doesn't seem reasonable in sum:
> > >  1. reboot mode registers against the reboot_notifier_list, which is too
> > >     early to call SYSTEM_RESET2. PSCI would need to remember the reset
> > >     type from the reboot-mode framework callback and use it
> > >     psci_sys_reset.
> > >  2. reboot mode assumes only one cookie/parameter is described in the
> > >     device tree. SYSTEM_RESET2 uses 2: one for the type and one for
> > >     cookie.
> > >  3. psci cpuidle driver already registers a driver against the
> > >     arm,psci-1.0 compatible. Refactoring would be needed to have both a
> > >     cpuidle and reboot-mode driver.
> > >
> > 
> > I need to think through it but when you first introduced the generic
> > Documentation/devicetree/bindings/power/reset/reboot-mode.yaml bindings
> > I also looked at drivers/power/reset/reboot-mode.c
> > 
> > I assumed this extension to that binding would reuse the same and
> > PSCI would just do reboot_mode_register(). I didn't expect to see these
> > changes. I might have missing something but since the bindings is still
> > quite generic with additional cells that act as additional cookie for
> > reboot call, I still think that should be possible.
> > 
> > What am I missing here then ?
> > 
> 
> Right, if that was only thing to "solve" to make it easy to use
> reboot-mode framework, I agree we should update reboot mode framework to
> work with the additional cells. There are a few other issues I mention
> above which, when combined, make me feel that PSCI is different enough
> from how reboot mode framework works that we shouldn't try to make PSCI
> work with the framework. Issues #1 and #2 are pretty easy to solve
> (whether they should be solved is different); I'm not sure a good
> approach to issue #3.
> 

Does the reasoning I mention in the commit text make sense why PSCI should
avoid using the reboot-mode.c framework?

Thanks,
Elliot



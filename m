Return-Path: <linux-pm+bounces-12051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9D694D521
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 18:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A01B22280
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DA63219F;
	Fri,  9 Aug 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dxAT5BAN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E082110E;
	Fri,  9 Aug 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222732; cv=none; b=KPla5HdXNBRjomMMEYDWAy/3IJ1gfKiQLerhiYgAFQY0KtJwWCd4ZgMy8vCBtBctvEr/q612WKuIgKrfhqJKvJHlDc0JydchfMme6RvH7SkmqmRlBjPDRnsOhuNnbvDqrACKfeLiipfcAGsqWWgzxAcIW0FSXU09EF+D5FMROv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222732; c=relaxed/simple;
	bh=uVoM+Z03V9OE/jbP+7tzb2gna/edfwvWyI5ASOFeUrQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAZX3F4UTXcj4HFYYmDCzaADvW2Il1rpGAIc/36HLgEjzQ07V4CWZwO+yp78c0zcrqZz3u3SbJlBWXQEBMWYPidS3P7m6irVHSxCxoHuwrY1z3nbR7gwRRK0JzUln3Wjhwqv+S4LGRlRyspNorFiEzhY1LtUq6sfhESiiQCU9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dxAT5BAN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4799VXUC022485;
	Fri, 9 Aug 2024 16:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=h9DRBCCxu+e57buH42hiurbX
	S7WfhL8DeR+9AHOx9JE=; b=dxAT5BANsZpHl90PVQIh5C3WtTdrUL65Tyw7Uiwi
	IpYNwsceqv0TQvozbpTWXDrAEzhgx6vEEp+zXlFd59QHHOzisyQuMsdFbgeqz5zz
	5u8VNpZeWUj4aPMZPmfnROqaEziaYj3H8hVJOqGYCMvBF+vT9Mw3+Qvlsp90Ght9
	RuYwdmx7OAA3m9vROSMLgDrYNSoKARUJ5wF+V3PhlYC8yXyYeTZGOw5Zn7evQut1
	/uDPJTB4bdeNrpezGkbIChKigUntun5S5RpQYBUYe7vyX1893ZQ5kHe8NskwTF41
	ID9BXke3o0mtCu0WbL15iMgBiiNT3DxJiSQQAofn3nYASA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40vtbcvj64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 16:58:33 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 479GwWVc004409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Aug 2024 16:58:32 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 9 Aug 2024 09:58:31 -0700
Date: Fri, 9 Aug 2024 09:58:31 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] firmware: psci: Read and use vendor reset types
Message-ID: <20240809090339647-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-3-086950f650c8@quicinc.com>
 <ZrOMjomTTWZ91Uzf@lpieralisi>
 <20240807103245593-0700.eberman@hu-eberman-lv.qualcomm.com>
 <ZrYZ/i1QFhfmv0zi@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZrYZ/i1QFhfmv0zi@lpieralisi>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: llwYJ0vMFu-vntO1KVctchycT4UnaPa_
X-Proofpoint-ORIG-GUID: llwYJ0vMFu-vntO1KVctchycT4UnaPa_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_13,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408090121

On Fri, Aug 09, 2024 at 03:30:38PM +0200, Lorenzo Pieralisi wrote:
> On Wed, Aug 07, 2024 at 11:10:50AM -0700, Elliot Berman wrote:
> 
> [...]
> 
> > > > +static void psci_vendor_sys_reset2(unsigned long action, void *data)
> > > 
> > > 'action' is unused and therefore it is not really needed.
> > > 
> > > > +{
> > > > +	const char *cmd = data;
> > > > +	unsigned long ret;
> > > > +	size_t i;
> > > > +
> > > > +	for (i = 0; i < num_psci_reset_params; i++) {
> > > > +		if (!strcmp(psci_reset_params[i].mode, cmd)) {
> > > > +			ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> > > > +					     psci_reset_params[i].reset_type,
> > > > +					     psci_reset_params[i].cookie, 0);
> > > > +			pr_err("failed to perform reset \"%s\": %ld\n",
> > > > +				cmd, (long)ret);
> > > > +		}
> > > > +	}
> > > > +}
> > > > +
> > > >  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
> > > >  			  void *data)
> > > >  {
> > > > +	if (data && num_psci_reset_params)
> > > 
> > > So, reboot_mode here is basically ignored; if there is a vendor defined
> > > reset, we fire it off.
> > > 
> > > I think Mark mentioned his concerns earlier related to REBOOT_* mode and
> > > reset type (granted, the context was different):
> > > 
> > > https://lore.kernel.org/all/20200320120105.GA36658@C02TD0UTHF1T.local/
> > > 
> > > I would like to understand if this is the right thing to do before
> > > accepting this patchset.
> > > 
> > 
> > I don't have any concerns to move this part below checking reboot_mode.
> > Or, I could add reboot_mode == REBOOT_COLD check.
> 
> The question is how can we map vendor specific reboot magic to Linux
> reboot modes sensibly in generic PSCI code - that's by definition
> vendor specific.
> 

I don't think it's a reasonable thing to do. "reboot bootloader" or
"reboot edl" don't make sense to the Linux reboot modes.

I believe the Linux reboot modes enum is oriented to perspective of
Linux itself and the vendor resets are oriented towards behavior of the
SoC.

Thanks,
Elliot



Return-Path: <linux-pm+bounces-12273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9729539A8
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 20:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8FD1C22E33
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 18:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63DA40862;
	Thu, 15 Aug 2024 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CEIExsDW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C664F883;
	Thu, 15 Aug 2024 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745381; cv=none; b=IHz1wVukqx8Hggpgqaa1zmLyL+tmuPzvM0ixfSaDeDi8Ak7rQnRtazrw5LpJ/tg2e42Les5Ja12Ssn6mf/4Bf84W7NoZvrZn2eZSoV5WxAkAbl2ng49kINiJh4mYmjij9U0lPEgJQ1bvEK8t8zy0eApyOxG1+lsGbkfFlk+is/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745381; c=relaxed/simple;
	bh=zglKdndCNX+MlFnz6gwVUSEMqCTNWp0aN/5cwh0rOLU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb4EU4eaRaf/oYO4ApMwh36h72epW0b4GkKnywDzRNl6ZfqSdj0p6VNvK04rTi5bmFGWygDUabuMuljHzqEN9r1UdPneZ+u5jp4y5qnmsNZCebUZoJK31TpreTCP+fZnYl8tV53ggvUCfkvx7TWl6NEEymGgpZlk6hYIjgd8/vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CEIExsDW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FBUdIQ003215;
	Thu, 15 Aug 2024 18:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WENr3V4vobLugtWowJUz3Mba8xWq19sN1OAuXiPnD7U=; b=CEIExsDWOQnG+X0J
	vKju152R1HCjw36gHgCjveleSkF5GCwKk4b///PwVQLQoEQIWT7XAcIcpl4hDoeA
	/iBc3yYYrI0f/dqcRbhjFpXXTs7LzCS4n4rspPOPsvtAU1enYe0buHsb4ZcOmLac
	8zk+uknpqSa3Jkb8bFlCbH7sMLhFgmOMmJ5ufzGPNizK3BfwG0eNM9oxkvmZ92NC
	dTrFlXRpxQnBSWBJxRHjVms6JuI4Fhaw+H30QjGXA5iivIuvNVVhLCLkViJqIcUW
	+qz4iCyvWqKXNnGaep7tQeOQGH1v7k6wzS+sSiviHdBV7E9VJIddwHnyvNtdFn9Y
	SRUv9g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4112r3tp4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 18:05:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47FI5AY2029132
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 18:05:10 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 15 Aug 2024 11:05:10 -0700
Date: Thu, 15 Aug 2024 11:05:09 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Shivendra Pratap <quic_spratap@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Sebastian
 Reichel" <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_spratap@qucinc.com>
Subject: Re: [PATCH v5 3/4] firmware: psci: Read and use vendor reset types
Message-ID: <20240815100749641-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-3-086950f650c8@quicinc.com>
 <ZrOMjomTTWZ91Uzf@lpieralisi>
 <20240807103245593-0700.eberman@hu-eberman-lv.qualcomm.com>
 <ZrYZ/i1QFhfmv0zi@lpieralisi>
 <20240809090339647-0700.eberman@hu-eberman-lv.qualcomm.com>
 <28c8bc92-4a55-8a07-1ece-333316d78410@quicinc.com>
 <Zr4Td7PiKhKl3Et3@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zr4Td7PiKhKl3Et3@lpieralisi>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5HHyFxqZYLv2HCmOjGDJMhQNAowmflLK
X-Proofpoint-ORIG-GUID: 5HHyFxqZYLv2HCmOjGDJMhQNAowmflLK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_10,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408150131

On Thu, Aug 15, 2024 at 04:40:55PM +0200, Lorenzo Pieralisi wrote:
> On Mon, Aug 12, 2024 at 11:46:08PM +0530, Shivendra Pratap wrote:
> > 
> > 
> > On 8/9/2024 10:28 PM, Elliot Berman wrote:
> > > On Fri, Aug 09, 2024 at 03:30:38PM +0200, Lorenzo Pieralisi wrote:
> > >> On Wed, Aug 07, 2024 at 11:10:50AM -0700, Elliot Berman wrote:
> > >>
> > >> [...]
> > >>
> > >>>>> +static void psci_vendor_sys_reset2(unsigned long action, void *data)
> > >>>>
> > >>>> 'action' is unused and therefore it is not really needed.
> > >>>>
> > >>>>> +{
> > >>>>> +	const char *cmd = data;
> > >>>>> +	unsigned long ret;
> > >>>>> +	size_t i;
> > >>>>> +
> > >>>>> +	for (i = 0; i < num_psci_reset_params; i++) {
> > >>>>> +		if (!strcmp(psci_reset_params[i].mode, cmd)) {
> > >>>>> +			ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> > >>>>> +					     psci_reset_params[i].reset_type,
> > >>>>> +					     psci_reset_params[i].cookie, 0);
> > >>>>> +			pr_err("failed to perform reset \"%s\": %ld\n",
> > >>>>> +				cmd, (long)ret);
> > >>>>> +		}
> > >>>>> +	}
> > >>>>> +}
> > >>>>> +
> > >>>>>  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
> > >>>>>  			  void *data)
> > >>>>>  {
> > >>>>> +	if (data && num_psci_reset_params)
> > >>>>
> > >>>> So, reboot_mode here is basically ignored; if there is a vendor defined
> > >>>> reset, we fire it off.
> > >>>>
> > >>>> I think Mark mentioned his concerns earlier related to REBOOT_* mode and
> > >>>> reset type (granted, the context was different):
> > >>>>
> > >>>> https://lore.kernel.org/all/20200320120105.GA36658@C02TD0UTHF1T.local/
> > >>>>
> > >>>> I would like to understand if this is the right thing to do before
> > >>>> accepting this patchset.
> > >>>>
> > >>>
> > >>> I don't have any concerns to move this part below checking reboot_mode.
> > >>> Or, I could add reboot_mode == REBOOT_COLD check.
> > >>
> > >> The question is how can we map vendor specific reboot magic to Linux
> > >> reboot modes sensibly in generic PSCI code - that's by definition
> > >> vendor specific.
> > >>
> > > 
> > > I don't think it's a reasonable thing to do. "reboot bootloader" or
> > > "reboot edl" don't make sense to the Linux reboot modes.
> > > 
> > > I believe the Linux reboot modes enum is oriented to perspective of
> > > Linux itself and the vendor resets are oriented towards behavior of the
> > > SoC.
> > > 
> > > Thanks,
> > > Elliot
> > > 
> > 
> > Agree.
> > 
> > from perspective of linux reboot modes, kernel's current
> > implementation in reset path is like:
> >
> > __
> > #1 If reboot_mode is WARM/SOFT and PSCI_SYSRESET2 is supported 
> >     Call PSCI - SYSTEM_RESET2 - ARCH RESET
> > #2 ELSE
> >     Call PSCI - SYSTEM_RESET COLD RESET
> > ___
> > 
> > ARM SPECS for PSCI SYSTEM_RESET2
> > This function extends SYSTEM_RESET. It provides:
> > • ARCH RESET: set Bit[31] to 0               = > This is already in place in condition #1.
> > • vendor-specific resets: set Bit[31] to 1.  = > current patchset adds this part before kernel's reboot_mode reset at #0.
> > 
> > 
> > In current patchset, we see a condition added at
> > #0-psci_vendor_reset2 being called before kernel’s current
> > reboot_mode condition and it can take any action only if all below
> > conditions are satisfied.
> > - PSCI SYSTEM_RESET2 is supported.
> > - psci dt node defines an entry "bootloader" as a reboot-modes.
> > - User issues reboot with a command say - (reboot bootloader).
> > - If vendor reset fails, default reboot mode will execute as is.
> > 
> > Don't see if we will skip or break the kernel reboot_mode flow with
> > this patch.  Also if user issues reboot <cmd> and <cmd> is supported
> > on SOC vendor reset psci node, should cmd take precedence over
> > kernel reboot mode enum? may be yes? 
> > 
> 
> Please wrap lines when replying.
> 
> I don't think it is a matter of precedence. reboot_mode and the reboot
> command passed to the reboot() syscall are there for different (?)
> reasons.
> 
> What I am asking is whether it is always safe to execute a PSCI vendor
> reset irrispective of the reboot_mode value.

The only way I see it to be unsafe is we need some other driver using
the reboot_mode to configure something and then the PSCI vendor reset
being incompatible with whatever that other driver did. I don't see that
happens today, so it is up to us to decide what the policy ought to be.
The PSCI spec doesn't help us here because the reboot_mode enum is
totally a Linux construct. In my opinion, firmware should be able to
deal with whatever the driver did or (less ideal) the driver need to be
aware of the PSCI vendor resets. Thus, it would be always safe to
execute a PSCI vendor reset regardless of the reboot_mode value.

Thanks,
Elliot



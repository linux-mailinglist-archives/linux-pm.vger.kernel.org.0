Return-Path: <linux-pm+bounces-11976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7944094AF66
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 20:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4381C2111F
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 18:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6E113E021;
	Wed,  7 Aug 2024 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="flOZGR9z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2530E13D61A;
	Wed,  7 Aug 2024 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054275; cv=none; b=ABE66LR+9CUF97KBbiN5+Mh07mo8EC/HVZdp/UKQSC1Znb3Y7+repJmysckCiS0kz7XqacccdLWi0dbHnolIjYCrx3j2wv+PJDUni5fjrcJ+4YzQU+F/GpaRJkH5Tca55r13gYAJ/Z1JUwZxM/4krw5hEHVuvTteIFXsIjDehmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054275; c=relaxed/simple;
	bh=KYr7SjVKSl4/MeJJK0ZGX2YnEyuYn4qGoHyAyeQRdko=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPrDIdlaJj698UvGfGMmXH/HtrFMq/bSoBZY8MtVj9b5TkhMk8dWMosO/R8ELPZjA9frTtMFEnwiswOPChF6CTZ/IpMlfMb6Tc2eYkRVwxC2rv7RwI+rAGHafULfKdFIlvKo8gC4wRD4VaKC/W7Lp4DFsnIzFHidDXWzMDVlA9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=flOZGR9z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477HonA5021129;
	Wed, 7 Aug 2024 18:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=o7crE7FuoQHQraF/eIU82boZ
	8tZMgiPjrJF06R+h6BM=; b=flOZGR9zbpWC2Fi+yhulwZ+0YylbC3YFAu+L1h1V
	/0MPSdQnuiMk+5hjoAr0ae3K87R1OxMh5FnYye1GCmMO3zio5ZcIMIz65zWKs7r4
	JIirqsJI8/huBYyLkzVhEnnKOZIc9XV+GhpliXuuO3fE/rG3/gSIlEn4S4JNAS99
	1ueGSGumX2o/TaqGgz5aCyYIvvY0rx5ZvfqDiV+R3dkgGn3lZ00V6SNOTsD3rF6o
	3zOF4S/t8EuM/vQxeVmhHkyTtQ23TaogB58XQQZot7JBu4J6RHr/R/6DwChVxSlh
	DBHVKopi1bijPZ6VZ5iPSHfMXLdzLSrh75O1uvBrW6Pv2w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40v4t9hncy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 18:10:52 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 477IApSI005363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Aug 2024 18:10:51 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 Aug 2024 11:10:50 -0700
Date: Wed, 7 Aug 2024 11:10:50 -0700
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
Message-ID: <20240807103245593-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-3-086950f650c8@quicinc.com>
 <ZrOMjomTTWZ91Uzf@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZrOMjomTTWZ91Uzf@lpieralisi>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KwUmHs85Y7OH-y9DtgNTNI1YT3es8sNf
X-Proofpoint-ORIG-GUID: KwUmHs85Y7OH-y9DtgNTNI1YT3es8sNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1011
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070126

On Wed, Aug 07, 2024 at 05:02:38PM +0200, Lorenzo Pieralisi wrote:
> On Mon, Jun 17, 2024 at 10:18:09AM -0700, Elliot Berman wrote:
> > SoC vendors have different types of resets and are controlled through
> > various registers. For instance, Qualcomm chipsets can reboot to a
> > "download mode" that allows a RAM dump to be collected. Another example
> > is they also support writing a cookie that can be read by bootloader
> > during next boot. PSCI offers a mechanism, SYSTEM_RESET2, for these
> > vendor reset types to be implemented without requiring drivers for every
> > register/cookie.
> > 
> > Add support in PSCI to statically map reboot mode commands from
> > userspace to a vendor reset and cookie value using the device tree.
> > 
> > A separate initcall is needed to parse the devicetree, instead of using
> > psci_dt_init because mm isn't sufficiently set up to allocate memory.
> > 
> > Reboot mode framework is close but doesn't quite fit with the
> > design and requirements for PSCI SYSTEM_RESET2. Some of these issues can
> > be solved but doesn't seem reasonable in sum:
> >  1. reboot mode registers against the reboot_notifier_list, which is too
> >     early to call SYSTEM_RESET2.
> 
> Please define "too early" (apologies if it has been explained before).
> 

My understanding is that reboot_notifier_list handlers shouldn't
actually be rebooting the system. I see it's generally used for one last
operation to put system into safer state. A few examples that are quick
to write based on what I see today: watchdogs disable themselves, PMUs
get torn down, xenbus tries to abort any requests. There are a couple
examples of drivers that *do* immediately reboot, but those seem to be
outlier. None of the reboot mode framework clients currently trigger
restart itself: they all set some cookies to give hint to firmware or
hardware what to do.

The restart_handler_list is documented to be a list of handlers that
should try to really restart the system. PSCI driver currently registers
against this.

> >     PSCI would need to remember the reset type from the reboot-mode
> >     framework callback and use it psci_sys_reset.
> >  2. reboot mode assumes only one cookie/parameter is described in the
> >     device tree. SYSTEM_RESET2 uses 2: one for the type and one for
> >     cookie.
> 
> That's surmountable I suppose.
> 
> >  3. psci cpuidle driver already registers a driver against the
> >     arm,psci-1.0 compatible. Refactoring would be needed to have both a
> >     cpuidle and reboot-mode driver.
> 
> We could put together a PSCI "parent" driver that creates child platform
> devices for idle and reboot drivers to match (which actually is not
> really pretty but it would make more sense than matching the idle
> driver only to the psci compatible string, which is what current code
> does).
> 
> > Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > ---
> >  drivers/firmware/psci/psci.c | 92 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> > 
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index d9629ff87861..e672b33b71d1 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -29,6 +29,8 @@
> >  #include <asm/smp_plat.h>
> >  #include <asm/suspend.h>
> >  
> > +#define REBOOT_PREFIX "mode-"
> > +
> >  /*
> >   * While a 64-bit OS can make calls with SMC32 calling conventions, for some
> >   * calls it is necessary to use SMC64 to pass or return 64-bit values.
> > @@ -79,6 +81,14 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void)
> >  static u32 psci_cpu_suspend_feature;
> >  static bool psci_system_reset2_supported;
> >  
> > +struct psci_reset_param {
> > +	const char *mode;
> > +	u32 reset_type;
> > +	u32 cookie;
> > +};
> > +static struct psci_reset_param *psci_reset_params;
> > +static size_t num_psci_reset_params;
> > +
> >  static inline bool psci_has_ext_power_state(void)
> >  {
> >  	return psci_cpu_suspend_feature &
> > @@ -305,9 +315,29 @@ static int get_set_conduit_method(const struct device_node *np)
> >  	return 0;
> >  }
> >  
> > +static void psci_vendor_sys_reset2(unsigned long action, void *data)
> 
> 'action' is unused and therefore it is not really needed.
> 
> > +{
> > +	const char *cmd = data;
> > +	unsigned long ret;
> > +	size_t i;
> > +
> > +	for (i = 0; i < num_psci_reset_params; i++) {
> > +		if (!strcmp(psci_reset_params[i].mode, cmd)) {
> > +			ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> > +					     psci_reset_params[i].reset_type,
> > +					     psci_reset_params[i].cookie, 0);
> > +			pr_err("failed to perform reset \"%s\": %ld\n",
> > +				cmd, (long)ret);
> > +		}
> > +	}
> > +}
> > +
> >  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
> >  			  void *data)
> >  {
> > +	if (data && num_psci_reset_params)
> 
> So, reboot_mode here is basically ignored; if there is a vendor defined
> reset, we fire it off.
> 
> I think Mark mentioned his concerns earlier related to REBOOT_* mode and
> reset type (granted, the context was different):
> 
> https://lore.kernel.org/all/20200320120105.GA36658@C02TD0UTHF1T.local/
> 
> I would like to understand if this is the right thing to do before
> accepting this patchset.
> 

I don't have any concerns to move this part below checking reboot_mode.
Or, I could add reboot_mode == REBOOT_COLD check.

I'm not sure how best to define the behavior if user sets
reboot_mode = REBOOT_WARM and then user does "reboot bootloader". IMO,
"REBOOT_WARM" is at odds with the "bootloader" command. We can have one
take precedence over the other. I chose for the vendor resets to take
priority, since if userspace is providing specific command at reboot
time, that's probably what they want.

Let me know your thoughts and I'm happy to change the behavior around.


Thanks,
Elliot


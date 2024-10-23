Return-Path: <linux-pm+bounces-16309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E09C9AD102
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 18:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F4128182B
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 16:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79991B4F10;
	Wed, 23 Oct 2024 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VByJhhXc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A341CB536;
	Wed, 23 Oct 2024 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701051; cv=none; b=dtmb6faxfS7vs07qoI+7TfdYcQr5Cqek/Xrrb5pgPXHSMIuITLFjMl2bWfIkCZ4GyHsrGcEYZvxQ7EOV1yB2NpO2VMjDZUHPUiscA7enTl9X0piH14ukwPZQe8EiCORVvZKBMyLI/RytdoHuOYq26N9YjTB+rycVlnXyWUtN4+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701051; c=relaxed/simple;
	bh=7Qz6f8NzFdutI7Icr0e57OHrZ5+XkkpJ1/tyME4Z5Ao=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bifJY4sR+4WyhkWiaDCArFDf4kUUi23bO+F+HITlJBLNumE5SLUNKxUqBF+L+giNpkz6I3VJBHtSJpxxxuXS4vl/70vdRw3TBPKa09gz9GNs09f6r+plEHcl4MBPQWTk1liUXNcaiLISpXKc1lrX0TkCkizZD1WIDARJ6GfeDYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VByJhhXc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9HSdU026325;
	Wed, 23 Oct 2024 16:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FclauO0bzswyc+MAq1B6mcZj
	gSqLwXz40OeffNV4QSo=; b=VByJhhXcpOkf9T39w00mf0miuEAKw/JHHqer7c1L
	2N5Jk/WOpsUODU618CYflAq4w00gsqbykXoaRga1sXnGsvbmWCeqT1HUcsNXiDfX
	QI55AM539K+sDmGX62BCXEUjyndoAh7SkD0wqQyiXZYMQXNZsvs182pt7Tn0SwN2
	F/7S90tXqtyIab5aY7gsj38fCl/GjUjJGtIgcNzXwAbQEdR415YuI3UPcjR5Et+I
	way3sS2qxUOUTFz0hO2dj+O5MSI4GF2hqiT2p/dsW+3DB1YPZPvA9zv1z9Rd8U+w
	U8crKjgM7pjv+75xNAPwwsLM7xw7VVdwlX+yEcIMp0SLeg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em40aut2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 16:30:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NGUNw8012804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 16:30:23 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 23 Oct 2024 09:30:22 -0700
Date: Wed, 23 Oct 2024 09:30:21 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Stephen Boyd <swboyd@chromium.org>
CC: Andy Yan <andy.yan@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Olof Johansson
	<olof@lixom.net>,
        Rob Herring <robh@kernel.org>, Sebastian Reichel
	<sre@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon
	<will@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Satya Durga
 Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v6 3/5] firmware: psci: Read and use vendor reset types
Message-ID: <20241023092251529-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com>
 <20241018-arm-psci-system_reset2-vendor-reboots-v6-3-50cbe88b0a24@quicinc.com>
 <CAE-0n515sUkmTWptgY8pOaMDBPfDp5pZBy9Nby+4cMdMAnAZfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAE-0n515sUkmTWptgY8pOaMDBPfDp5pZBy9Nby+4cMdMAnAZfA@mail.gmail.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RVMuLpnaxcrO0emm38nvEuLCDeeWvOiG
X-Proofpoint-GUID: RVMuLpnaxcrO0emm38nvEuLCDeeWvOiG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230102

On Fri, Oct 18, 2024 at 10:42:46PM -0700, Stephen Boyd wrote:
> Quoting Elliot Berman (2024-10-18 12:39:48)
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index 2328ca58bba6..60bc285622ce 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -29,6 +29,8 @@
> >  #include <asm/smp_plat.h>
> >  #include <asm/suspend.h>
> >
> > +#define REBOOT_PREFIX "mode-"
> 
> Maybe move this near the function that uses it.
> 
> > +
> >  /*
> >   * While a 64-bit OS can make calls with SMC32 calling conventions, for some
> >   * calls it is necessary to use SMC64 to pass or return 64-bit values.
> > @@ -305,9 +315,29 @@ static int get_set_conduit_method(const struct device_node *np)
> >         return 0;
> >  }
> >
> > +static void psci_vendor_sys_reset2(unsigned long action, void *data)
> > +{
> > +       const char *cmd = data;
> > +       unsigned long ret;
> > +       size_t i;
> > +
> > +       for (i = 0; i < num_psci_reset_params; i++) {
> > +               if (!strcmp(psci_reset_params[i].mode, cmd)) {
> > +                       ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> > +                                            psci_reset_params[i].reset_type,
> > +                                            psci_reset_params[i].cookie, 0);
> > +                       pr_err("failed to perform reset \"%s\": %ld\n",
> > +                               cmd, (long)ret);
> 
> Do this intentionally return? Should it be some other function that's
> __noreturn instead and a while (1) if the firmware returns back to the
> kernel?
> 

Yes, I think it's best to make sure we fall back to the architectural
reset (whether it's the SYSTEM_RESET or architectural SYSTEM_RESET2)
since device would reboot then.

> > +               }
> > +       }
> > +}
> > +
> >  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
> >                           void *data)
> >  {
> > +       if (data && num_psci_reset_params)
> > +               psci_vendor_sys_reset2(action, data);
> > +
> >         if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
> >             psci_system_reset2_supported) {
> >                 /*
> > @@ -750,6 +780,68 @@ static const struct of_device_id psci_of_match[] __initconst = {
> >         {},
> >  };
> >
> > +static int __init psci_init_system_reset2_modes(void)
> > +{
> > +       const size_t len = strlen(REBOOT_PREFIX);
> > +       struct psci_reset_param *param;
> > +       struct device_node *psci_np __free(device_node) = NULL;
> > +       struct device_node *np __free(device_node) = NULL;
> > +       struct property *prop;
> > +       size_t count = 0;
> > +       u32 magic[2];
> > +       int num;
> > +
> > +       if (!psci_system_reset2_supported)
> > +               return 0;
> > +
> > +       psci_np = of_find_matching_node(NULL, psci_of_match);
> > +       if (!psci_np)
> > +               return 0;
> > +
> > +       np = of_find_node_by_name(psci_np, "reset-types");
> > +       if (!np)
> > +               return 0;
> > +
> > +       for_each_property_of_node(np, prop) {
> > +               if (strncmp(prop->name, REBOOT_PREFIX, len))
> > +                       continue;
> > +               num = of_property_count_elems_of_size(np, prop->name, sizeof(magic[0]));
> 
> Use of_property_count_u32_elems()?
> 
> > +               if (num != 1 && num != 2)
> > +                       continue;
> > +
> > +               count++;
> > +       }
> > +
> > +       param = psci_reset_params = kcalloc(count, sizeof(*psci_reset_params), GFP_KERNEL);
> > +       if (!psci_reset_params)
> > +               return -ENOMEM;
> > +
> > +       for_each_property_of_node(np, prop) {
> > +               if (strncmp(prop->name, REBOOT_PREFIX, len))
> > +                       continue;
> > +
> > +               param->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
> > +               if (!param->mode)
> > +                       continue;
> > +
> > +               num = of_property_read_variable_u32_array(np, prop->name, magic, 1, 2);
> 
> ARRAY_SIZE(magic)?
> 
> > +               if (num < 0) {
> 
> Should this be less than 1?
> 

of_property_read_variable_u32_array should return -EOVERFLOW (or maybe
-ENODATA) if the array is empty. I don't see it's possible for
of_property_read_variable_u32_array() to return a non-negative value
that's not 1 or 2.

> > +                       pr_warn("Failed to parse vendor reboot mode %s\n", param->mode);
> > +                       kfree_const(param->mode);
> > +                       continue;
> > +               }
> > +
> > +               /* Force reset type to be in vendor space */
> > +               param->reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic[0];
> > +               param->cookie = num == 2 ? magic[1] : 0;
> 
> ARRAY_SIZE(magic)?
> 
> > +               param++;
> > +               num_psci_reset_params++;
> > +       }
> > +
> > +       return 0;


Return-Path: <linux-pm+bounces-23615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9600A56492
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 11:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526D8188D3F0
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 10:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5EC20CCCD;
	Fri,  7 Mar 2025 10:04:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B2E1C84B5;
	Fri,  7 Mar 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341850; cv=none; b=Ii0IgSnac1uyNyf8UkiXONOADUkj76S4wJS3mVpQ//NBr9690i0bX8JzixdwrQiqN7cv//f4d8s2gyFP/ExEWolQR/VptCzwK0GsC/s3MfW5+2mzjS7FTx9OFnjlliGYQ0RPuQxVDYwS6glLTgdvt+7B11wnITWRnZ0JBP3re54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341850; c=relaxed/simple;
	bh=MixtkC6Vdu2RyKm+p1WrB24RizzWnzxsKFc9VRWYl1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqyGQSX59ZUuPJVMRLs6/z1BaaYeD/4MvXAzN0lZBVIrMvyphq4i4sfCpyXlJkguBJg0/ugdEmjUJgqr6dz0ubGEMJKQis+6mD9Yh8mW9m8jWnFywpedLAE6cj8ezFAcvZR4Ue8q6QhGZ4vBG8Ri9jfJuJsTwLgjyKPHd8P5iQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C04F2150C;
	Fri,  7 Mar 2025 02:04:20 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 123553F66E;
	Fri,  7 Mar 2025 02:04:04 -0800 (PST)
Date: Fri, 7 Mar 2025 10:04:02 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jacky Bai <ping.bai@nxp.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"d-gole@ti.com" <d-gole@ti.com>,
	"anup@brainfault.org" <anup@brainfault.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"khilman@baylibre.com" <khilman@baylibre.com>,
	"quic_tingweiz@quicinc.com" <quic_tingweiz@quicinc.com>,
	"quic_yuanjiey@quicinc.com" <quic_yuanjiey@quicinc.com>
Subject: Re: [PATCH v4] cpuidle: Init cpuidle only for present CPUs
Message-ID: <Z8rEkgYoThJAJdPV@bogus>
References: <20250307080303.2660506-1-ping.bai@nxp.com>
 <Z8rBYuDiIyo8y6HT@bogus>
 <AS8PR04MB86425B7CEE7443F822A2DBCA87D52@AS8PR04MB8642.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB86425B7CEE7443F822A2DBCA87D52@AS8PR04MB8642.eurprd04.prod.outlook.com>

On Fri, Mar 07, 2025 at 10:02:14AM +0000, Jacky Bai wrote:
> Hi Sudeep,
> 
> > Subject: Re: [PATCH v4] cpuidle: Init cpuidle only for present CPUs
> > 
> > On Fri, Mar 07, 2025 at 04:03:03PM +0800, Jacky Bai wrote:
> > > for_each_possible_cpu() is currently used to initialize cpuidle in
> > > below cpuidle drivers:
> > >   drivers/cpuidle/cpuidle-arm.c
> > >   drivers/cpuidle/cpuidle-big_little.c
> > >   drivers/cpuidle/cpuidle-psci.c
> > >   drivers/cpuidle/cpuidle-riscv-sbi.c
> > >
> > > However, in cpu_dev_register_generic(), for_each_present_cpu() is used
> > > to register CPU devices which means the CPU devices are only
> > > registered for present CPUs and not all possible CPUs.
> > >
> > > With nosmp or maxcpus=0, only the boot CPU is present, lead to the
> > > failure:
> > >
> > >   |  Failed to register cpuidle device for cpu1
> > >
> > > Then rollback to cancel all CPUs' cpuidle registration.
> > >
> > > Change for_each_possible_cpu() to for_each_present_cpu() in the above
> > > cpuidle drivers to ensure it only registers cpuidle devices for CPUs
> > > that are actually present.
> > >
> > > Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in
> > > GENERIC_CPU_DEVICES")
> > > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > Tested-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> > > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > > ---
> > >  - v4 changes:
> > >   - add changes for other cpuidle driver that has the similar issue
> > >     as cpuidle-pcsi driver.
> > >
> > >  - v3 changes:
> > >   - improve the changelog as suggested by Sudeep
> > > ---
> > >  drivers/cpuidle/cpuidle-arm.c        | 8 ++++----
> > >  drivers/cpuidle/cpuidle-big_little.c | 2 +-
> > >  drivers/cpuidle/cpuidle-psci.c       | 4 ++--
> > >  drivers/cpuidle/cpuidle-riscv-sbi.c  | 4 ++--
> > 
> > 
> > Why have you spared drivers/cpuidle/cpuidle-qcom-spm.c ? IIUC the issue
> > exists there as well.
> > 
> 
> For qcom-spm driver, it has below code logic to handle no cpu device case, and
> no rollback to cancel the whole cpuidle registration. So I just leave it as it is.
> Do we need to update it?
> 
> for_each_possible_cpu(cpu) {
>         ret = spm_cpuidle_register(&pdev->dev, cpu);

Did you look into this function ?

-- 
Regards,
Sudeep


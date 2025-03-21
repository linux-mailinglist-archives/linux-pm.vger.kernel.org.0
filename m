Return-Path: <linux-pm+bounces-24375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7497DA6BC84
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 15:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6815F48473D
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B868139CE3;
	Fri, 21 Mar 2025 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQFjviUz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F8778F51;
	Fri, 21 Mar 2025 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565690; cv=none; b=uO2mqdm2L8Flyw003VeND3f84VUSC/bnJ4C4wdVrfkxfuS8B8OzJ8VCTJlT1DHK1uHZgmfcfhB4fCr8xhASG2lR1MpvvkLoztJduiz0ocgUv+eARbOUjGqTeAoIS9ONtgR8QRCo0fFOzBeylZDyoF+I5r1daYNMl1oZplz4blWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565690; c=relaxed/simple;
	bh=r3YmTjNyrBOpZMbrxMuxwdILI1K2UHLZ+zzgbRIv8QM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XEI03O+kdRaQ6vsneBcYDMWgqNSghhCBC1xdCEjE+f0cBI9PIehD280/6lZ8NR1osX59b8oQyH2sWuQcp7DNQBqMxXK2cA9fFKO4L5DRiJje40aE9d4suX2X3lJJzEa8c+dZJTeu4S3rmwxDra7Zqh6CPoWR0oXHgbr7nO/fM9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQFjviUz; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742565689; x=1774101689;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=r3YmTjNyrBOpZMbrxMuxwdILI1K2UHLZ+zzgbRIv8QM=;
  b=NQFjviUz26IbPAdiRMAHDEQT5HMHhHzVObJs04V1+DLEfrBbeBI5vuTg
   IVi/uhjqN5O/puAHtfRHYhSP6jYwWFwVjZF2Ajq3RaQSKhM9kVBKHN0wQ
   V7VHSGi2elb047zzYD45skcTT4RjWEQGjfevvrXUChO87Z8NvgVGABWW+
   xvWPe7ffJY5Uuaa4BzeYMYQso7Tnyy3V8eBkZ0wv7IIvKnuDJhMpRMS+4
   2XJLRD6aJfPBgW/kjOG1rmFiEo0i1xJRLIHaC1M3+whTkbw2CdPeecd6y
   27fIi9589LPuRsLW47krA2OYNeLekjQHdR02myIs2fT97JioyG3EN0hNa
   Q==;
X-CSE-ConnectionGUID: cuU2ykpzScqASV505D745A==
X-CSE-MsgGUID: JdtzzFNQS5WCkNMTKQeVTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43951596"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="43951596"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:01:28 -0700
X-CSE-ConnectionGUID: GL7PdLUfSIG2FC2c/ZhEEw==
X-CSE-MsgGUID: t7lnO86JRA+TrgVx8D79Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="128458992"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:01:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 21 Mar 2025 16:01:17 +0200 (EET)
To: Mario Limonciello <superm1@kernel.org>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Perry Yuan <perry.yuan@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
    Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, 
    "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, 
    Huang Rui <ray.huang@amd.com>, 
    "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Viresh Kumar <viresh.kumar@linaro.org>, 
    "open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER" <platform-driver-x86@vger.kernel.org>, 
    "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, 
    "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
    "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v8 04/13] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
In-Reply-To: <1b54afae-cb86-4022-b9f5-e5c1fc075be8@kernel.org>
Message-ID: <b97df985-8545-9f8b-719b-3f8b6a19f2f5@linux.intel.com>
References: <20250218190822.1039982-1-superm1@kernel.org> <20250218190822.1039982-5-superm1@kernel.org> <f90d49d6-e031-4722-b63f-26931eae1aa5@linux.intel.com> <1b54afae-cb86-4022-b9f5-e5c1fc075be8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-806251378-1742565677=:931"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-806251378-1742565677=:931
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 20 Mar 2025, Mario Limonciello wrote:

> On 3/19/2025 09:03, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 18 Feb 2025, Mario Limonciello wrote:
> >=20
> > > From: Perry Yuan <Perry.Yuan@amd.com>
> > >=20
> > > The AMD Heterogeneous core design and Hardware Feedback Interface (HF=
I)
> > > provide behavioral classification and a dynamically updated ranking t=
able
> > > for the scheduler to use when choosing cores for tasks.
> > >=20
> > > There are two CPU core types defined: `Classic Core` and `Dense Core`=
=2E
> > > "Classic" cores are the standard performance cores, while "Dense" cor=
es
> > > are optimized for area and efficiency.
> > >=20
> > > Heterogeneous compute refers to CPU implementations that are comprise=
d
> > > of more than one architectural class, each with two capabilities. Thi=
s
> > > means each CPU reports two separate capabilities: "perf" and "eff".
> > >=20
> > > Each capability lists all core ranking numbers between 0 and 255, whe=
re
> > > a higher number represents a higher capability.
> > >=20
> > > Heterogeneous systems can also extend to more than two architectural
> > > classes.
> > >=20
> > > The purpose of the scheduling feedback mechanism is to provide inform=
ation
> > > to the operating system scheduler in real time, allowing the schedule=
r to
> > > direct threads to the optimal core during task scheduling.
> > >=20
> > > All core ranking data are provided by the PMFW via a shared memory ra=
nking
> > > table, which the driver reads and uses to update core capabilities to=
 the
> > > scheduler. When the hardware updates the table, it generates a platfo=
rm
> > > interrupt to notify the OS to read the new ranking table.
> > >=20
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
> > > Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > > Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> > > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > > Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > > v8:
> > >   * s,devm_kzalloc,devm_kcalloc,
> > >   * fold newlines from patch 5 into this patch
> > >   * Drop ->cpu member, push to later patch
> > >   * s,for_each_present_cpu,for_each_possible_cpu,
> > > v7:
> > >   * Adjust Kconfig to 80 characters
> > > ---
> > >   drivers/platform/x86/amd/Kconfig      |   1 +
> > >   drivers/platform/x86/amd/Makefile     |   1 +
> > >   drivers/platform/x86/amd/hfi/Kconfig  |  20 ++++
> > >   drivers/platform/x86/amd/hfi/Makefile |   7 ++
> > >   drivers/platform/x86/amd/hfi/hfi.c    | 162 +++++++++++++++++++++++=
+++
> > >   5 files changed, 191 insertions(+)
> > >   create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
> > >   create mode 100644 drivers/platform/x86/amd/hfi/Makefile
> > >   create mode 100644 drivers/platform/x86/amd/hfi/hfi.c
> > >=20
> > > diff --git a/drivers/platform/x86/amd/Kconfig
> > > b/drivers/platform/x86/amd/Kconfig
> > > index c3e086ea64fc6..589d61ebf726b 100644
> > > --- a/drivers/platform/x86/amd/Kconfig
> > > +++ b/drivers/platform/x86/amd/Kconfig
> > > @@ -6,6 +6,7 @@
> > >   source "drivers/platform/x86/amd/hsmp/Kconfig"
> > >   source "drivers/platform/x86/amd/pmf/Kconfig"
> > >   source "drivers/platform/x86/amd/pmc/Kconfig"
> > > +source "drivers/platform/x86/amd/hfi/Kconfig"
> > >     config AMD_3D_VCACHE
> > >   =09tristate "AMD 3D V-Cache Performance Optimizer Driver"
> > > diff --git a/drivers/platform/x86/amd/Makefile
> > > b/drivers/platform/x86/amd/Makefile
> > > index 56f62fc9c97b4..c50e93c3334cf 100644
> > > --- a/drivers/platform/x86/amd/Makefile
> > > +++ b/drivers/platform/x86/amd/Makefile
> > > @@ -10,3 +10,4 @@ obj-$(CONFIG_AMD_PMC)=09=09+=3D pmc/
> > >   obj-$(CONFIG_AMD_HSMP)=09=09+=3D hsmp/
> > >   obj-$(CONFIG_AMD_PMF)=09=09+=3D pmf/
> > >   obj-$(CONFIG_AMD_WBRF)=09=09+=3D wbrf.o
> > > +obj-$(CONFIG_AMD_HFI)=09=09+=3D hfi/
> > > diff --git a/drivers/platform/x86/amd/hfi/Kconfig
> > > b/drivers/platform/x86/amd/hfi/Kconfig
> > > new file mode 100644
> > > index 0000000000000..532939eb08a6a
> > > --- /dev/null
> > > +++ b/drivers/platform/x86/amd/hfi/Kconfig
> > > @@ -0,0 +1,20 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +#
> > > +# AMD Hardware Feedback Interface Driver
> > > +#
> > > +
> > > +config AMD_HFI
> > > +=09bool "AMD Hetero Core Hardware Feedback Driver"
> > > +=09depends on ACPI
> > > +=09depends on CPU_SUP_AMD
> > > +=09help
> > > +=09 Select this option to enable the AMD Heterogeneous Core Hardware
> > > +=09 Feedback Interface. If selected, hardware provides runtime threa=
d
> > > +=09 classification guidance to the operating system on the performan=
ce
> > > and
> > > +=09 energy efficiency capabilities of each heterogeneous CPU core. T=
hese
> > > +=09 capabilities may vary due to the inherent differences in the cor=
e
> > > types
> > > +=09 and can also change as a result of variations in the operating
> > > +=09 conditions of the system such as power and thermal limits. If
> > > selected,
> >=20
> > This says the capabilities can change but metadata is only read and sco=
res
> > updated during probe?
> >=20
> > > +=09 the kernel relays updates in heterogeneous CPUs' capabilities to
> > > +=09 userspace, allowing for more optimal task scheduling and resourc=
e
> > > +=09 allocation, leveraging the diverse set of cores available.
> >=20
> > How are the capabilities communicated to userspace as mentioned here? I=
'm
> > asking this because I only noted debugfs interface, and that commit
> > claimed the debug fs interface was to troubleshoot scheduler issues.
>=20
> This is one of those cases that the split into multiple parts shows. Thin=
king
> through I feel it makes more sense to adjust for now and then we can chan=
ge it
> again on the next part.
>=20
> >=20
> > > diff --git a/drivers/platform/x86/amd/hfi/Makefile
> > > b/drivers/platform/x86/amd/hfi/Makefile
> > > new file mode 100644
> > > index 0000000000000..672c6ac106e95
> > > --- /dev/null
> > > +++ b/drivers/platform/x86/amd/hfi/Makefile
> > > @@ -0,0 +1,7 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# AMD Hardware Feedback Interface Driver
> > > +#
> > > +
> > > +obj-$(CONFIG_AMD_HFI) +=3D amd_hfi.o
> > > +amd_hfi-objs :=3D hfi.o
> > > diff --git a/drivers/platform/x86/amd/hfi/hfi.c
> > > b/drivers/platform/x86/amd/hfi/hfi.c
> > > new file mode 100644
> > > index 0000000000000..426f7e520b76c
> > > --- /dev/null
> > > +++ b/drivers/platform/x86/amd/hfi/hfi.c
> > > @@ -0,0 +1,162 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * AMD Hardware Feedback Interface Driver
> > > + *
> > > + * Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserv=
ed.
> >=20
> > 2025 ?
>=20
> Ack.
>=20
> Heh, earlier versions started in 2024!
>
> > > + *
> > > + * Authors: Perry Yuan <Perry.Yuan@amd.com>
> > > + *          Mario Limonciello <mario.limonciello@amd.com>
> > > + */
> > > +
> > > +#define pr_fmt(fmt)  "amd-hfi: " fmt
> > > +
> > > +#include <linux/acpi.h>
> > > +#include <linux/cpu.h>
> > > +#include <linux/cpumask.h>
> > > +#include <linux/gfp.h>
> > > +#include <linux/init.h>
> > > +#include <linux/io.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/smp.h>
> > > +
> > > +#define AMD_HFI_DRIVER=09=09"amd_hfi"
> > > +
> > > +#define AMD_HETERO_CPUID_27=090x80000027
> > > +
> > > +static struct platform_device *device;
> > > +
> > > +struct amd_hfi_data {
> > > +=09const char=09*name;
> > > +=09struct device=09*dev;
> > > +=09struct mutex=09lock;
> >=20
> > Please mention what this protects.
>=20
> As a comment at the end like this, right?
>
> struct mutex lock; /* lock the foo */

Yes.

--=20
 i.



>=20
> >=20
> > > +};
> > > +
> > > +struct amd_hfi_classes {
> > > +=09u32=09perf;
> > > +=09u32=09eff;
> > > +};
> > > +
> > > +/**
> > > + * struct amd_hfi_cpuinfo - HFI workload class info per CPU
> > > + * @cpu:=09=09cpu index
> > > + * @class_index:=09workload class ID index
> > > + * @nr_class:=09=09max number of workload class supported
> > > + * @amd_hfi_classes:=09current cpu workload class ranking data
> > > + *
> > > + * Parameters of a logical processor linked with hardware feedback c=
lass
> >=20
> > missing .
>=20
> Ack
>=20
> >=20
> > > + */
> > > +struct amd_hfi_cpuinfo {
> > > +=09int=09=09cpu;
> > > +=09s16=09=09class_index;
> > > +=09u8=09=09nr_class;
> > > +=09struct amd_hfi_classes=09*amd_hfi_classes;
> > > +};
> > > +
> > > +static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) =3D
> > > {.class_index =3D -1};
> > > +
> > > +static int amd_hfi_alloc_class_data(struct platform_device *pdev)
> > > +{
> > > +=09struct amd_hfi_cpuinfo *hfi_cpuinfo;
> > > +=09struct device *dev =3D &pdev->dev;
> > > +=09int idx;
> > > +=09int nr_class_id;
> > > +
> > > +=09nr_class_id =3D cpuid_eax(AMD_HETERO_CPUID_27);
> > > +=09if (nr_class_id < 0 || nr_class_id > 255) {
> >=20
> > Is the signed type correct for this?
> >=20
> > > +=09=09dev_err(dev, "failed to get number of supported classes:
> > > %d\n",
> > > +=09=09=09nr_class_id);
> >=20
> > I'd reword the error message as the number of classes was just too
> > large / outside the allowed range.
>=20
> OK.
>=20
> >=20
> > > +=09=09return -EINVAL;
> > > +=09}
> > > +
> > > +=09for_each_possible_cpu(idx) {
> > > +=09=09struct amd_hfi_classes *classes;
> > > +
> > > +=09=09classes =3D devm_kcalloc(dev,
> > > +=09=09=09=09       nr_class_id,
> > > +=09=09=09=09       sizeof(struct amd_hfi_classes),
> > > +=09=09=09=09       GFP_KERNEL);
> > > +=09=09if (!classes)
> > > +=09=09=09return -ENOMEM;
> > > +=09=09hfi_cpuinfo =3D per_cpu_ptr(&amd_hfi_cpuinfo, idx);
> > > +=09=09hfi_cpuinfo->amd_hfi_classes =3D classes;
> > > +=09=09hfi_cpuinfo->nr_class =3D nr_class_id;
> > > +=09}
> > > +
> > > +=09return 0;
> > > +}
> > > +
> > > +static const struct acpi_device_id amd_hfi_platform_match[] =3D {
> > > +=09{"AMDI0104", 0},
> > > +=09{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(acpi, amd_hfi_platform_match);
> > > +
> > > +static int amd_hfi_probe(struct platform_device *pdev)
> > > +{
> > > +=09struct amd_hfi_data *amd_hfi_data;
> > > +=09int ret;
> > > +
> > > +=09if (!acpi_match_device(amd_hfi_platform_match, &pdev->dev))
> > > +=09=09return -ENODEV;
> > > +
> > > +=09amd_hfi_data =3D devm_kzalloc(&pdev->dev, sizeof(*amd_hfi_data),
> > > GFP_KERNEL);
> > > +=09if (!amd_hfi_data)
> > > +=09=09return -ENOMEM;
> > > +
> > > +=09amd_hfi_data->dev =3D &pdev->dev;
> > > +=09ret =3D devm_mutex_init(&pdev->dev, &amd_hfi_data->lock);
> > > +=09if (ret)
> > > +=09=09return ret;
> > > +=09platform_set_drvdata(pdev, amd_hfi_data);
> > > +
> > > +=09ret =3D amd_hfi_alloc_class_data(pdev);
> > > +=09if (ret)
> > > +=09=09return ret;
> > > +
> > > +=09return 0;
> > > +}
> > > +
> > > +static struct platform_driver amd_hfi_driver =3D {
> > > +=09.driver =3D {
> > > +=09=09.name =3D AMD_HFI_DRIVER,
> > > +=09=09.owner =3D THIS_MODULE,
> > > +=09=09.acpi_match_table =3D ACPI_PTR(amd_hfi_platform_match),
> > > +=09},
> > > +=09.probe =3D amd_hfi_probe,
> > > +};
> > > +
> > > +static int __init amd_hfi_init(void)
> > > +{
> > > +=09int ret;
> > > +
> > > +=09if (acpi_disabled ||
> > > +=09    !cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES) ||
> > > +=09    !cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
> > > +=09=09return -ENODEV;
> > > +
> > > +=09device =3D platform_device_register_simple(AMD_HFI_DRIVER, -1, NU=
LL, 0);
> > > +=09if (IS_ERR(device)) {
> > > +=09=09pr_err("unable to register HFI platform device\n");
> > > +=09=09return PTR_ERR(device);
> > > +=09}
> > > +
> > > +=09ret =3D platform_driver_register(&amd_hfi_driver);
> > > +=09if (ret)
> > > +=09=09pr_err("failed to register HFI driver\n");
> > > +
> > > +=09return ret;
> > > +}
> > > +
> > > +static __exit void amd_hfi_exit(void)
> > > +{
> > > +=09platform_device_unregister(device);
> > > +=09platform_driver_unregister(&amd_hfi_driver);
> >=20
> > Why are these not in the opposite order than in init?
>=20
> Oversight.  Will fix it.
>=20
> >=20
> > > +}
> > > +module_init(amd_hfi_init);
> > > +module_exit(amd_hfi_exit);
> > > +
> > > +MODULE_LICENSE("GPL");
> > > +MODULE_DESCRIPTION("AMD Hardware Feedback Interface Driver");
> > >=20
> >=20
>=20
--8323328-806251378-1742565677=:931--


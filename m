Return-Path: <linux-pm+bounces-24284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1FFA68F1B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 15:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B55119C44C9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 14:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9A21957FF;
	Wed, 19 Mar 2025 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WALkGqdZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5727192D70;
	Wed, 19 Mar 2025 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393060; cv=none; b=p01SQkJgpyWc1dER/5cXMq6ifdCjX2hPsL/AHAEnXQuZgq70IWhT6NbQzw9WZ9/DQLrosfqP/8qU4A3cze3+S9KAh1kvQevc3Jk5wVp/vER+M8Iq3WZNr+nda5zj1upS8Df/hEgwAfOkID3/WIffFOgSkeUGpAVcz9RSbLTLfPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393060; c=relaxed/simple;
	bh=yNhIuTQT3zGiXEdB6/mmhb/2R9aYMDsjHWvjnm36/zg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=n1NRPjycMHykS0T2kY9ZlrRvzqNqvsHmYHRS5qnsN4ocaunmwsxH5CmRtuEiToy/cGMuidtrVeNP2dsA1xfPU5oQH71+NoPhLLlU1n+VFXyOH3LjJRQ2Qidk+WOz1YuqgekVOTZauR0KM134QFWs4WlRfOQYurWJpYGqfYJNDIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WALkGqdZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742393059; x=1773929059;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=yNhIuTQT3zGiXEdB6/mmhb/2R9aYMDsjHWvjnm36/zg=;
  b=WALkGqdZT9ztnpnbxfZj8Jy75ng4Q0n/nLqkisCYhNzX1K17RN3sWJAc
   Nd9WCsydWW563+VMLUBOMGnV0v6GedEkZxzI9QeT5TH+/PaQgo6f3ECDf
   PAqQjNhyeBtEd1S1P5VyJQIMXyOf5+ifKFnyajza3Tu6LeJ5bNvq7rNSZ
   cFKvgF5rgUzdt28cBz6jW00ATnTkf42+XaXhT1I/fKaG2i5MHkp1eKSO4
   KyT2lu8r0TezU+uI9y0Fq2z4iue9FqBP2hg/XT/N1r5BmSaHSZjPUhTKR
   1vnCWCshfj59yni2QLI7MRIH71Ilpu80MYq1+W7VIscYq2dPl3FXW6+81
   g==;
X-CSE-ConnectionGUID: 7dpgSW+XTj2jZffE8yhZoQ==
X-CSE-MsgGUID: U/gmOheaQAa1iXWwSE0/YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="47232890"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="47232890"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 07:04:18 -0700
X-CSE-ConnectionGUID: XTpZtMN2TgaM/N8iE8gasQ==
X-CSE-MsgGUID: aG1afJdCRXW3BdwLM5Db+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="123567401"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 07:04:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 19 Mar 2025 16:04:07 +0200 (EET)
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
    Perry Yuan <Perry.Yuan@amd.com>
Subject: Re: [PATCH v8 05/13] platform/x86: hfi: parse CPU core ranking data
 from shared memory
In-Reply-To: <20250218190822.1039982-6-superm1@kernel.org>
Message-ID: <ce01e34c-f0c4-e97f-70ee-ddd3e8714285@linux.intel.com>
References: <20250218190822.1039982-1-superm1@kernel.org> <20250218190822.1039982-6-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-968895965-1742388947=:10063"
Content-ID: <fa88ff83-6072-fdfd-cdf6-0a17ccea4813@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-968895965-1742388947=:10063
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <0dff5233-9270-e1ad-16f8-ae976a417165@linux.intel.com>

On Tue, 18 Feb 2025, Mario Limonciello wrote:

> From: Perry Yuan <Perry.Yuan@amd.com>
>=20
> When `amd_hfi` driver is loaded, it will use PCCT subspace type 4 table
> to retrieve the shared memory address which contains the CPU core ranking
> table. This table includes a header that specifies the number of ranking
> data entries to be parsed and rank each CPU core with the Performance and
> Energy Efficiency capability as implemented by the CPU power management
> firmware.
>=20
> Once the table has been parsed, each CPU is assigned a ranking score
> within its class. Subsequently, when the scheduler selects cores, it
> chooses from the ranking list based on the assigned scores in each class,
> thereby ensuring the optimal selection of CPU cores according to their
> predefined classifications and priorities.
>=20
> Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3:
>  * Reverse xmas tree order in amd_hfi_fill_metadata()
>  * s,for_each_present_cpu,for_each_possible_cpu,
> v2:
>  * Drop __packed
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 194 +++++++++++++++++++++++++++++
>  1 file changed, 194 insertions(+)
>=20
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/am=
d/hfi/hfi.c
> index 426f7e520b76c..7ab7ae0ec72ca 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -18,22 +18,72 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mailbox_client.h>
>  #include <linux/mutex.h>
> +#include <linux/percpu-defs.h>
>  #include <linux/platform_device.h>
>  #include <linux/smp.h>
> +#include <linux/topology.h>
> +#include <linux/workqueue.h>
> +
> +#include <asm/cpu_device_id.h>
> +
> +#include <acpi/pcc.h>
> +#include <acpi/cppc_acpi.h>
> =20
>  #define AMD_HFI_DRIVER=09=09"amd_hfi"
> +#define AMD_HFI_MAILBOX_COUNT=09=091
> +#define AMD_HETERO_RANKING_TABLE_VER=092
> =20
>  #define AMD_HETERO_CPUID_27=090x80000027
> =20
>  static struct platform_device *device;
> =20
> +/**
> + * struct amd_shmem_info - Shared memory table for AMD HFI
> + *
> + * @header:=09The PCCT table header including signature, length flags an=
d command.
> + * @version_number:=09=09Version number of the table
> + * @n_logical_processors:=09Number of logical processors
> + * @n_capabilities:=09=09Number of ranking dimensions (performance, effi=
ciency, etc)
> + * @table_update_context:=09Command being sent over the subspace
> + * @n_bitmaps:=09=09=09Number of 32-bit bitmaps to enumerate all the API=
C IDs
> + *=09=09=09=09This is based on the maximum APIC ID enumerated in the sys=
tem
> + * @reserved:=09=09=0924 bit spare
> + * @table_data:=09=09=09Bit Map(s) of enabled logical processors
> + *=09=09=09=09Followed by the ranking data for each logical processor
> + */
> +struct amd_shmem_info {
> +=09struct acpi_pcct_ext_pcc_shared_memory header;
> +=09u32=09version_number=09=09:8,
> +=09=09n_logical_processors=09:8,
> +=09=09n_capabilities=09=09:8,
> +=09=09table_update_context=09:8;
> +=09u32=09n_bitmaps=09=09:8,
> +=09=09reserved=09=09:24;
> +=09u32=09table_data[];
> +};
> +
>  struct amd_hfi_data {
>  =09const char=09*name;
>  =09struct device=09*dev;
>  =09struct mutex=09lock;
> +
> +=09/* PCCT table related*/

Missing space.

> +=09struct pcc_mbox_chan=09*pcc_chan;
> +=09void __iomem=09=09*pcc_comm_addr;
> +=09struct acpi_subtable_header=09*pcct_entry;
> +=09struct amd_shmem_info=09*shmem;
>  };
> =20
> +/**
> + * struct amd_hfi_classes - HFI class capabilities per CPU
> + * @perf:=09Performance capability
> + * @eff:=09Power efficiency capability
> + *
> + * Capabilities of a logical processor in the ranking table. These capab=
ilities
> + * are unitless and specific to each HFI class.
> + */
>  struct amd_hfi_classes {
>  =09u32=09perf;
>  =09u32=09eff;
> @@ -42,21 +92,103 @@ struct amd_hfi_classes {
>  /**
>   * struct amd_hfi_cpuinfo - HFI workload class info per CPU
>   * @cpu:=09=09cpu index
> + * @apic_id:=09=09apic id of the current cpu
>   * @class_index:=09workload class ID index
>   * @nr_class:=09=09max number of workload class supported
> + * @ipcc_scores:=09ipcc scores for each class
>   * @amd_hfi_classes:=09current cpu workload class ranking data
>   *
>   * Parameters of a logical processor linked with hardware feedback class
>   */
>  struct amd_hfi_cpuinfo {
>  =09int=09=09cpu;
> +=09u32=09=09apic_id;
>  =09s16=09=09class_index;
>  =09u8=09=09nr_class;
> +=09int=09=09*ipcc_scores;
>  =09struct amd_hfi_classes=09*amd_hfi_classes;
>  };
> =20
>  static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) =3D {.cla=
ss_index =3D -1};
> =20
> +static int find_cpu_index_by_apicid(unsigned int target_apicid)
> +{
> +=09int cpu_index;
> +
> +=09for_each_possible_cpu(cpu_index) {
> +=09=09struct cpuinfo_x86 *info =3D &cpu_data(cpu_index);
> +
> +=09=09if (info->topo.apicid =3D=3D target_apicid) {
> +=09=09=09pr_debug("match APIC id %d for CPU index: %d\n",
> +=09=09=09=09 info->topo.apicid, cpu_index);

apicid is unsigned.

> +=09=09=09return cpu_index;
> +=09=09}
> +=09}
> +
> +=09return -ENODEV;
> +}
> +
> +static int amd_hfi_fill_metadata(struct amd_hfi_data *amd_hfi_data)
> +{
> +=09struct acpi_pcct_ext_pcc_slave *pcct_ext =3D
> +=09=09(struct acpi_pcct_ext_pcc_slave *)amd_hfi_data->pcct_entry;
> +=09void __iomem *pcc_comm_addr;
> +
> +=09pcc_comm_addr =3D acpi_os_ioremap(amd_hfi_data->pcc_chan->shmem_base_=
addr,
> +=09=09=09=09=09amd_hfi_data->pcc_chan->shmem_size);
> +=09if (!pcc_comm_addr) {
> +=09=09pr_err("failed to ioremap PCC common region mem\n");

Don't you have ->dev available in amd_hfi_data so you could use dev_*()=20
for all prints?

> +=09=09return -ENOMEM;
> +=09}
> +
> +=09memcpy_fromio(amd_hfi_data->shmem, pcc_comm_addr, pcct_ext->length);
> +=09iounmap(pcc_comm_addr);
> +
> +=09if (amd_hfi_data->shmem->header.signature !=3D PCC_SIGNATURE) {
> +=09=09pr_err("invalid signature in shared memory\n");
> +=09=09return -EINVAL;
> +=09}
> +=09if (amd_hfi_data->shmem->version_number !=3D AMD_HETERO_RANKING_TABLE=
_VER) {
> +=09=09pr_err("invalid version %d\n", amd_hfi_data->shmem->version_number=
);
> +=09=09return -EINVAL;
> +=09}
> +
> +=09for (unsigned int i =3D 0; i < amd_hfi_data->shmem->n_bitmaps; i++) {
> +=09=09u32 bitmap =3D amd_hfi_data->shmem->table_data[i];
> +
> +=09=09for (unsigned int j =3D 0; j < BITS_PER_TYPE(u32); j++) {
> +=09=09=09int apic_id =3D i * BITS_PER_TYPE(u32) + j;

Why is this signed?

If you change to unsigned int, remember to adjust the print line too.

> +=09=09=09struct amd_hfi_cpuinfo *info;
> +=09=09=09int cpu_index;
> +
> +=09=09=09if (!(bitmap & BIT(j)))
> +=09=09=09=09continue;
> +
> +=09=09=09cpu_index =3D find_cpu_index_by_apicid(apic_id);
> +=09=09=09if (cpu_index < 0) {
> +=09=09=09=09pr_warn("APIC ID %d not found\n", apic_id);
> +=09=09=09=09continue;
> +=09=09=09}
> +
> +=09=09=09info =3D per_cpu_ptr(&amd_hfi_cpuinfo, cpu_index);
> +=09=09=09info->apic_id =3D apic_id;
> +
> +=09=09=09/* Fill the ranking data for each logical processor */
> +=09=09=09info =3D per_cpu_ptr(&amd_hfi_cpuinfo, cpu_index);
> +=09=09=09for (unsigned int k =3D 0; k < info->nr_class; k++) {
> +=09=09=09=09u32 *table =3D amd_hfi_data->shmem->table_data +
> +=09=09=09=09=09     amd_hfi_data->shmem->n_bitmaps +
> +=09=09=09=09=09     i * info->nr_class;
> +
> +=09=09=09=09info->amd_hfi_classes[k].eff =3D table[apic_id + 2 * k];
> +=09=09=09=09info->amd_hfi_classes[k].perf =3D table[apic_id + 2 * k + 1]=
;
> +=09=09=09}
> +=09=09}
> +=09}
> +
> +=09return 0;
> +}
> +
>  static int amd_hfi_alloc_class_data(struct platform_device *pdev)
>  {
>  =09struct amd_hfi_cpuinfo *hfi_cpuinfo;
> @@ -73,6 +205,7 @@ static int amd_hfi_alloc_class_data(struct platform_de=
vice *pdev)
> =20
>  =09for_each_possible_cpu(idx) {
>  =09=09struct amd_hfi_classes *classes;
> +=09=09int *ipcc_scores;
> =20
>  =09=09classes =3D devm_kcalloc(dev,
>  =09=09=09=09       nr_class_id,
> @@ -80,14 +213,71 @@ static int amd_hfi_alloc_class_data(struct platform_=
device *pdev)
>  =09=09=09=09       GFP_KERNEL);
>  =09=09if (!classes)
>  =09=09=09return -ENOMEM;
> +=09=09ipcc_scores =3D devm_kcalloc(dev, nr_class_id, sizeof(int), GFP_KE=
RNEL);
> +=09=09if (!ipcc_scores)
> +=09=09=09return -ENOMEM;
>  =09=09hfi_cpuinfo =3D per_cpu_ptr(&amd_hfi_cpuinfo, idx);
>  =09=09hfi_cpuinfo->amd_hfi_classes =3D classes;
> +=09=09hfi_cpuinfo->ipcc_scores =3D ipcc_scores;
>  =09=09hfi_cpuinfo->nr_class =3D nr_class_id;
>  =09}
> =20
>  =09return 0;
>  }
> =20
> +static int amd_hfi_metadata_parser(struct platform_device *pdev,
> +=09=09=09=09   struct amd_hfi_data *amd_hfi_data)
> +{
> +=09struct acpi_pcct_ext_pcc_slave *pcct_ext;
> +=09struct acpi_subtable_header *pcct_entry;
> +=09struct mbox_chan *pcc_mbox_channels;
> +=09struct acpi_table_header *pcct_tbl;
> +=09struct pcc_mbox_chan *pcc_chan;
> +=09acpi_status status;
> +=09int ret;
> +
> +=09pcc_mbox_channels =3D devm_kcalloc(&pdev->dev, AMD_HFI_MAILBOX_COUNT,
> +=09=09=09=09=09 sizeof(*pcc_mbox_channels), GFP_KERNEL);
> +=09if (!pcc_mbox_channels)
> +=09=09return -ENOMEM;
> +
> +=09pcc_chan =3D devm_kcalloc(&pdev->dev, AMD_HFI_MAILBOX_COUNT,
> +=09=09=09=09sizeof(*pcc_chan), GFP_KERNEL);
> +=09if (!pcc_chan)
> +=09=09return -ENOMEM;
> +
> +=09status =3D acpi_get_table(ACPI_SIG_PCCT, 0, &pcct_tbl);
> +=09if (ACPI_FAILURE(status) || !pcct_tbl)
> +=09=09return -ENODEV;
> +
> +=09/* get pointer to the first PCC subspace entry */
> +=09pcct_entry =3D (struct acpi_subtable_header *) (
> +=09=09=09(unsigned long)pcct_tbl + sizeof(struct acpi_table_pcct));
> +
> +=09pcc_chan->mchan =3D &pcc_mbox_channels[0];
> +
> +=09amd_hfi_data->pcc_chan =3D pcc_chan;
> +=09amd_hfi_data->pcct_entry =3D pcct_entry;
> +=09pcct_ext =3D (struct acpi_pcct_ext_pcc_slave *)pcct_entry;
> +
> +=09if (pcct_ext->length <=3D 0)
> +=09=09return -EINVAL;
> +
> +=09amd_hfi_data->shmem =3D devm_kzalloc(amd_hfi_data->dev, pcct_ext->len=
gth, GFP_KERNEL);
> +=09if (!amd_hfi_data->shmem)
> +=09=09return -ENOMEM;
> +
> +=09pcc_chan->shmem_base_addr =3D pcct_ext->base_address;
> +=09pcc_chan->shmem_size =3D pcct_ext->length;
> +
> +=09/* parse the shared memory info from the pcct table */

PCCT

> +=09ret =3D amd_hfi_fill_metadata(amd_hfi_data);
> +
> +=09acpi_put_table(pcct_tbl);
> +
> +=09return ret;
> +}
> +
>  static const struct acpi_device_id amd_hfi_platform_match[] =3D {
>  =09{"AMDI0104", 0},
>  =09{ }
> @@ -116,6 +306,10 @@ static int amd_hfi_probe(struct platform_device *pde=
v)
>  =09if (ret)
>  =09=09return ret;
> =20
> +=09ret =3D amd_hfi_metadata_parser(pdev, amd_hfi_data);
> +=09if (ret)
> +=09=09return ret;
> +
>  =09return 0;
>  }
> =20
>=20

--=20
 i.
--8323328-968895965-1742388947=:10063--


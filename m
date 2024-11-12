Return-Path: <linux-pm+bounces-17404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9C79C5771
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 13:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA912845F2
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 12:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49901CD217;
	Tue, 12 Nov 2024 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/aWMQhs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D723099A;
	Tue, 12 Nov 2024 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731413719; cv=none; b=ng3QY54GkoOhCN4Gbv4ObCgqh7CLyBKt1W9h5HUzE5V8QmBO6lqmX9Al3O+2Wq3Q+Jap/qkN1IZsqU7YQN0KaKjef3E/LGm9jMn8ZO3u254KwkVqQDtkZr+wkloLCXNu5ZygGaXMVso6XZLOoqKZuydytca+J9ePfjoB+wOscVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731413719; c=relaxed/simple;
	bh=Jqvk+2JIys7FneqU37gZzMVAjUrVda+nHXaP40mDhXg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UuTqezJQY16kbXgzgzTYCAoQ/HXSWZ6outIT36G873AELNs+kO5Vv/qJ6j0zic06QNHdeVdFVCS4lS1DGHchoQ62UcppUQUnH9QoZC3bu36GAH4C+5TeUI/QJwUTodCOdZONzE2FVruNxrGChwH6K8yWZ+qu0VImgEavO0lkXhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/aWMQhs; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731413718; x=1762949718;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Jqvk+2JIys7FneqU37gZzMVAjUrVda+nHXaP40mDhXg=;
  b=D/aWMQhsaxCyG+hPiX7sMTj5aKIEqyxOvBy7x/O2vpQGttSPtpvMCcMN
   xijue5+4AOmcGhOl6DTkFsV/f4wbh8bC6qhhhrs7xP8lp0vCoWxTxFX8J
   0K9laonoKGT8h66MdPPmsbnVjpkj/67VfaasSsWlEBFtmDrO3h9jULl4p
   Fx6C+pozHRtVIT6HnEuSAGwORxwfLakndhlQtB1Pua8jIR4zE4gpv1ncc
   8FZrhLT7iwOL0fQw+fCiHBDy+3G1fbFoVDULujj6Q6p/UQIg0mABtVghD
   v6ZWb8G33C87OujhtHEUPLMYQ4CSWmag6xeDoRYF9O6R7hFf2HYJRvGlt
   Q==;
X-CSE-ConnectionGUID: ZVO3F/R8S4CbfRF+hPNnqA==
X-CSE-MsgGUID: fWa8fad3TGuW5L9M03WL8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48699568"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48699568"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 04:15:17 -0800
X-CSE-ConnectionGUID: 04a7HOqnQ5ubzk1cvmdcbw==
X-CSE-MsgGUID: nEBB6JovTM+XqQJy3Foi5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="118370516"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 04:15:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Nov 2024 14:15:09 +0200 (EET)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>, 
    x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
    Perry Yuan <perry.yuan@amd.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Perry Yuan <Perry.Yuan@amd.com>
Subject: Re: [PATCH v6 05/12] platform/x86: hfi: parse CPU core ranking data
 from shared memory
In-Reply-To: <20241104175407.19546-6-mario.limonciello@amd.com>
Message-ID: <372796b6-0276-bd75-8aa2-75ea7934dfec@linux.intel.com>
References: <20241104175407.19546-1-mario.limonciello@amd.com> <20241104175407.19546-6-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1562858813-1731413709=:961"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1562858813-1731413709=:961
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 4 Nov 2024, Mario Limonciello wrote:

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
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 196 +++++++++++++++++++++++++++++
>  1 file changed, 196 insertions(+)
>=20
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/am=
d/hfi/hfi.c
> index 2cd71d79a22c9..708d7d18fe2f2 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -18,20 +18,72 @@
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
> +#define AMD_HFI_MAILBOX_COUNT=091
> +#define AMD_HETERO_RANKING_TABLE_VER=092
> +
>  #define AMD_HETERO_CPUID_27=090x80000027
> +
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
> +} __packed;

This looks naturally aligned so __packed shouldn't be necessary.

Looks fine otherwise to me,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

>  struct amd_hfi_data {
>  =09const char=09*name;
>  =09struct device=09*dev;
>  =09struct mutex=09lock;
> +
> +=09/* PCCT table related*/
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
> @@ -40,23 +92,105 @@ struct amd_hfi_classes {
>  /**
>   * struct amd_hfi_cpuinfo - HFI workload class info per CPU
>   * @cpu:=09=09cpu index
> + * @apic_id:=09=09apic id of the current cpu
>   * @cpus:=09=09mask of cpus associated with amd_hfi_cpuinfo
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
>  =09cpumask_var_t=09cpus;
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
> +=09for_each_present_cpu(cpu_index) {
> +=09=09struct cpuinfo_x86 *info =3D &cpu_data(cpu_index);
> +
> +=09=09if (info->topo.apicid =3D=3D target_apicid) {
> +=09=09=09pr_debug("match APIC id %d for CPU index: %d\n",
> +=09=09=09=09 info->topo.apicid, cpu_index);
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
> +=09=09=09struct amd_hfi_cpuinfo *info;
> +=09=09=09int apic_id =3D i * BITS_PER_TYPE(u32) + j;
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
> @@ -73,20 +207,78 @@ static int amd_hfi_alloc_class_data(struct platform_=
device *pdev)
> =20
>  =09for_each_present_cpu(idx) {
>  =09=09struct amd_hfi_classes *classes;
> +=09=09int *ipcc_scores;
> =20
>  =09=09classes =3D devm_kzalloc(dev,
>  =09=09=09=09       nr_class_id * sizeof(struct amd_hfi_classes),
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
> @@ -115,6 +307,10 @@ static int amd_hfi_probe(struct platform_device *pde=
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
--8323328-1562858813-1731413709=:961--


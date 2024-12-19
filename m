Return-Path: <linux-pm+bounces-19525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC659F7D61
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 15:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525E218823FD
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D98224B1B;
	Thu, 19 Dec 2024 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxPECP4x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DD478F54;
	Thu, 19 Dec 2024 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620023; cv=none; b=Q7w0lfKA32m3OtiQOuwo0UeSJsuEl8t31A7yblcYv+WdFH6d92CTZcKYupWjxgMED8vmPE94vzDPH9xxXq4R3OuzjpgIP+bjE2jeW/skO3MbF3aIjrTZC+TKG9BT8T7AN5Kdc/XjP6YMIWZJL2KBdju1vmqCYwFaNtXxWRfc65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620023; c=relaxed/simple;
	bh=/kcw3YPwWPCsUd6P2IuDB3IOkdnGo8zDSmr/l4fD45Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fcZPada5RfkQjuULtcUS66+vUIhxmyMT86IBTEJD4wRv/Mb8yLImzIMw+lfC3Zpu8YGuGXwI8gKrCRDXJ3RdiCzZqlgj9YozkuOJaN5Yii8Rja5YXBJMSdvnmBODm+GTf81K1H1tNvGwJe458RxpOaP9W763EDWEm+JVWNUpuaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QxPECP4x; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734620022; x=1766156022;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=/kcw3YPwWPCsUd6P2IuDB3IOkdnGo8zDSmr/l4fD45Q=;
  b=QxPECP4xIQOL2zNuCnii+2nvznyX8ZOLLhJk/33HNNkyo7d4EPcX4ry+
   0NeaZJPwcwUKtCZrQhGeQwFGuJNe5LzNFtPN+tj366dym7jtd+O2zabVk
   YY7nrOIivwLqnbO5V50NtBkQNZjSd743W5cmdvPN7F9svnLxYwi20QQb4
   J9F4HbwEm1xgVPJLsuCp6Umi9RKVtFvuuG/DYYZQQutlgkgw9Jg75W0/Q
   vbES3fIIIGMcxeLtnDXpiqPwAtkxFpwAIFWE9ENskYB2YWh8jlpizW4lW
   E6V1NsRkDQX0tln+iCo1AtzKc5PM9utqrTLxQCVT5wKA5rXAZGqOdkLLM
   Q==;
X-CSE-ConnectionGUID: uA60o2wYQa6LC9E4SX0mVA==
X-CSE-MsgGUID: iiet5BrwSXSvsu9yjC4fPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35260274"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="35260274"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 06:53:41 -0800
X-CSE-ConnectionGUID: kPEbUKkCRxqS4aQZ3YrcHw==
X-CSE-MsgGUID: 2mAWPB3GTTqlSZOQwXNMKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="129181500"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.7])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 06:53:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 19 Dec 2024 16:53:34 +0200 (EET)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>, 
    x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
    Perry Yuan <perry.yuan@amd.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Perry Yuan <Perry.Yuan@amd.com>
Subject: Re: [PATCH v7 05/12] platform/x86: hfi: parse CPU core ranking data
 from shared memory
In-Reply-To: <20241130152023.684-6-mario.limonciello@amd.com>
Message-ID: <4f3c0938-7ca4-c1b5-06e4-a03bba47b408@linux.intel.com>
References: <20241130152023.684-1-mario.limonciello@amd.com> <20241130152023.684-6-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-164415166-1734619252=:932"
Content-ID: <74654046-6989-d4b8-c5dd-f04182b2f788@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-164415166-1734619252=:932
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <9697c350-de78-59a9-7d17-32631f73fe93@linux.intel.com>

On Sat, 30 Nov 2024, Mario Limonciello wrote:

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
> Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  * Drop __packed
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 196 +++++++++++++++++++++++++++++
>  1 file changed, 196 insertions(+)
>=20
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/am=
d/hfi/hfi.c
> index 2cd71d79a22c9..3c90e93fd192c 100644
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

Please add the empty lines already in the patch introducing=20
AMD_HETERO_CPUID_27 define.

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

Reverse xmas order.

--=20
 i.

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
--8323328-164415166-1734619252=:932--


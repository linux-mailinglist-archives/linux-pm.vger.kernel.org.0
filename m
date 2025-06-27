Return-Path: <linux-pm+bounces-29644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A30AEB0F6
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 10:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608EA170534
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 08:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147DA23507B;
	Fri, 27 Jun 2025 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNFpYu9m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A05234994;
	Fri, 27 Jun 2025 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011734; cv=none; b=UEGOAs4GHa+oof2FiVcB2CJgPj6vtEd6KrPwwUMXFabYTQX4lBQdeNpk+AXpyRH7qBORE46JjD28E/NWZypAYFsoig823/fjBfItu5Wo1nanMcVhtoiKkaAGDPPjDYWStwZOQVtFeWdXfmlrs+J8kCpRWRKNarlQ/FQChnCLtKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011734; c=relaxed/simple;
	bh=E5dCJgCXz5LGAgBMWwqXeeSh3tGKI1xYAyu0hCa7oEg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KLcmdQJvtgqJ8rpbzeBp/d2zA/GS5x17WV/rK5bQCI8lxJHwGhyzdFBbzil6/lBTfr8XvZtMKfNd3wGy0F1eEHU4dZGYvwzv23lc8J0XCOgedJ39DkbL+F3GhJnCBso8I2lqXePCV675IBt1xc4S3zP5weW711Q9rmA3H+FHBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNFpYu9m; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751011732; x=1782547732;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=E5dCJgCXz5LGAgBMWwqXeeSh3tGKI1xYAyu0hCa7oEg=;
  b=VNFpYu9m/aAl3KBq03XdN6dRg1dfSBS9S4opmcYixzsaD0HRNLPTET4X
   lsXiOSaBuMwXdDgZEilkHap/vu1KqFStgFY/KGjU6aemoMmIZOqKunQxz
   1UiiHJ5cR8HAKeuz11IA/2Zux4w2+JMwK4Z5wiB2Clig9LJMKiEiqq9ZJ
   RkzJ21UKe4H0d2bckUwHMv2jPPX9sAkfS/IFVdfHlRkXmIa+YmSxX0nsi
   WBFpbY0/mcha46PzZ5KdbGTztpEuZ8Lw0ah7Pg/sdHAGAgdp0DD8Acw5V
   VBBrgJzZvgQKBxvd72iWKROSLsrhYQMnppYSFWwVl4bdpUlLDRsKA3K64
   A==;
X-CSE-ConnectionGUID: 39tywPZQTKOp9WDL/nbMHQ==
X-CSE-MsgGUID: BpWqy1zkQ4WGCKcIAv3FtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53184196"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="53184196"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 01:08:51 -0700
X-CSE-ConnectionGUID: QfgHaVPrT7iUECpbrdfFrw==
X-CSE-MsgGUID: AwJNA7G8Q8OAHtKWnb9njw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="152832352"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 01:08:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 27 Jun 2025 11:08:44 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 4/5] platform/x86:intel/pmc: Show substate requirement
 for S0ix blockers
In-Reply-To: <4d9c848f-ea87-4b94-b9d3-94362e59a4af@linux.intel.com>
Message-ID: <67fb2263-003e-71b3-ef6f-9276bded995b@linux.intel.com>
References: <20250625063145.624585-1-xi.pardee@linux.intel.com> <20250625063145.624585-5-xi.pardee@linux.intel.com> <6f43709c-dfcb-059e-758a-be6a56538724@linux.intel.com> <4d9c848f-ea87-4b94-b9d3-94362e59a4af@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1517171256-1751011724=:1730"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1517171256-1751011724=:1730
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 26 Jun 2025, Xi Pardee wrote:

> Hi Ilpo,
>=20
> Thanks for reviewing the patch. My response is inline.
>=20
> On 6/26/2025 9:38 AM, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 24 Jun 2025, Xi Pardee wrote:
> >=20
> > > Add support to read and show S0ix blocker substate requirements.
> > > Starting from Panther Lake, substate requirement data is provided
> > > based on S0ix blockers instead of all low power mode requirements.
> > > For platforms that support this new feature, add support to display
> > > substate requirements based on S0ix blockers.
> > Empty line.
> Will fix in next version.
> >=20
> > > Change the "substate_requirements" attribute of Intel PMC Core
> > > driver to show the substate requirements for each S0ix blocker
> > > and the corresponding S0ix blocker value.
> > >=20
> > > Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> > > ---
> > >   drivers/platform/x86/intel/pmc/arl.c  |   2 +
> > >   drivers/platform/x86/intel/pmc/core.c | 111 +++++++++++++++++++++++=
+--
> > >   drivers/platform/x86/intel/pmc/core.h |  12 +++
> > >   drivers/platform/x86/intel/pmc/lnl.c  |   1 +
> > >   drivers/platform/x86/intel/pmc/mtl.c  |   1 +
> > >   5 files changed, 121 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/intel/pmc/arl.c
> > > b/drivers/platform/x86/intel/pmc/arl.c
> > > index 9d66d65e75779..1852876be234f 100644
> > > --- a/drivers/platform/x86/intel/pmc/arl.c
> > > +++ b/drivers/platform/x86/intel/pmc/arl.c
> > > @@ -722,6 +722,7 @@ static int arl_h_core_init(struct pmc_dev *pmcdev=
,
> > > struct pmc_dev_info *pmc_dev_
> > >     struct pmc_dev_info arl_pmc_dev =3D {
> > >   =09.pci_func =3D 0,
> > > +=09.telem_info =3D SUB_REQ_LPM,
> > >   =09.dmu_guid =3D ARL_PMT_DMU_GUID,
> > >   =09.regmap_list =3D arl_pmc_info_list,
> > >   =09.map =3D &arl_socs_reg_map,
> > > @@ -732,6 +733,7 @@ struct pmc_dev_info arl_pmc_dev =3D {
> > >     struct pmc_dev_info arl_h_pmc_dev =3D {
> > >   =09.pci_func =3D 2,
> > > +=09.telem_info =3D SUB_REQ_LPM,
> > >   =09.dmu_guid =3D ARL_PMT_DMU_GUID,
> > >   =09.regmap_list =3D arl_pmc_info_list,
> > >   =09.map =3D &mtl_socm_reg_map,
> > > diff --git a/drivers/platform/x86/intel/pmc/core.c
> > > b/drivers/platform/x86/intel/pmc/core.c
> > > index 47cc5120e7dd6..e9d281b064462 100644
> > > --- a/drivers/platform/x86/intel/pmc/core.c
> > > +++ b/drivers/platform/x86/intel/pmc/core.c
> > > @@ -844,6 +844,56 @@ static void pmc_core_substate_req_header_show(st=
ruct
> > > seq_file *s, int pmc_index,
> > >   =09=09seq_printf(s, " %9s |\n", name);
> > >   }
> > >   +static int pmc_core_substate_blk_req_show(struct seq_file *s, void
> > > *unused)
> > > +{
> > > +=09struct pmc_dev *pmcdev =3D s->private;
> > > +=09unsigned int pmc_index;
> > > +=09u32 *blk_sub_req_regs;
> > Why is this here and the other variable in the inner block?
> Will move the blk_sub_req_regs declaration to the inner block.
> >=20
> > > +
> > > +=09for (pmc_index =3D 0; pmc_index < ARRAY_SIZE(pmcdev->pmcs); pmc_i=
ndex++)
> > > {
> > > +=09=09const struct pmc_bit_map **maps;
> > > +=09=09unsigned int arr_size, r_idx;
> > > +=09=09u32 offset, counter;
> > > +=09=09struct pmc *pmc;
> > > +
> > > +=09=09pmc =3D pmcdev->pmcs[pmc_index];
> > > +=09=09if (!pmc || !pmc->blk_sub_req_regs)
> > > +=09=09=09continue;
> > > +
> > > +=09=09blk_sub_req_regs =3D pmc->blk_sub_req_regs;
> > > +=09=09maps =3D pmc->map->s0ix_blocker_maps;
> > > +=09=09offset =3D pmc->map->s0ix_blocker_offset;
> > > +=09=09arr_size =3D pmc_core_lpm_get_arr_size(maps);
> > > +
> > > +=09=09/* Display the header */
> > > +=09=09pmc_core_substate_req_header_show(s, pmc_index, "Value");
> > > +
> > > +=09=09for (r_idx =3D 0; r_idx < arr_size; r_idx++) {
> > > +=09=09=09const struct pmc_bit_map *map;
> > > +
> > > +=09=09=09for (map =3D maps[r_idx]; map->name; map++) {
> > > +=09=09=09=09int mode;
> > > +
> > > +=09=09=09=09if (!map->blk)
> > > +=09=09=09=09=09continue;
> > > +
> > > +=09=09=09=09counter =3D pmc_core_reg_read(pmc, offset);
> > > +=09=09=09=09seq_printf(s, "pmc%d: %34s |", pmc_index,
> > > map->name);
> > > +=09=09=09=09pmc_for_each_mode(mode, pmcdev) {
> > > +=09=09=09=09=09bool required =3D *blk_sub_req_regs &
> > > BIT(mode);
> > > +
> > > +=09=09=09=09=09seq_printf(s, " %9s |", required ?
> > > "Required" : " ");
> > > +=09=09=09=09}
> > > +=09=09=09=09seq_printf(s, " %9d |\n", counter);
> > > +=09=09=09=09offset +=3D map->blk * S0IX_BLK_SIZE;
> > > +=09=09=09=09blk_sub_req_regs++;
> > > +=09=09=09}
> > > +=09=09}
> > > +=09}
> > > +=09return 0;
> > > +}
> > > +DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_blk_req);
> > > +
> > >   static int pmc_core_substate_req_regs_show(struct seq_file *s, void
> > > *unused)
> > >   {
> > >   =09struct pmc_dev *pmcdev =3D s->private;
> > > @@ -1335,7 +1385,10 @@ static void pmc_core_dbgfs_register(struct pmc=
_dev
> > > *pmcdev)
> > >   =09=09debugfs_create_file("substate_requirements", 0444,
> > >   =09=09=09=09    pmcdev->dbgfs_dir, pmcdev,
> > >   =09=09=09=09    &pmc_core_substate_req_regs_fops);
> > > -=09}
> > > +=09} else if (primary_pmc->blk_sub_req_regs)
> > > +=09=09debugfs_create_file("substate_requirements", 0444,
> > > +=09=09=09=09    pmcdev->dbgfs_dir, pmcdev,
> > > +=09=09=09=09    &pmc_core_substate_blk_req_fops);
> > >=20
> > >   =09if (primary_pmc->map->pson_residency_offset &&
> > > pmc_core_is_pson_residency_enabled(pmcdev)) {
> > >   =09=09debugfs_create_file("pson_residency_usec", 0444,
> > > @@ -1441,7 +1494,38 @@ static int pmc_core_pmt_get_lpm_req(struct pmc=
_dev
> > > *pmcdev, struct pmc *pmc,
> > >   =09return ret;
> > >   }
> > >   -static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int fun=
c)
> > > +static int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev, stru=
ct
> > > pmc *pmc,
> > > +=09=09=09=09=09struct telem_endpoint *ep)
> > > +{
> > > +=09u32 num_blocker, sample_id;
> > > +=09unsigned int index;
> > > +=09u32 *req_offset;
> > > +=09int ret;
> > > +
> > > +=09num_blocker =3D pmc->map->num_s0ix_blocker;
> > > +=09sample_id =3D pmc->map->blocker_req_offset;
> > > +
> > > +=09pmc->blk_sub_req_regs =3D devm_kcalloc(&pmcdev->pdev->dev,
> > > +=09=09=09=09=09 num_blocker, sizeof(u32),
> > > +=09=09=09=09=09 GFP_KERNEL);
> > Correct alignment.
> >=20
> > I guess you want to keep those two args on the same line as this would =
fit
> > on 2 lines.
> Will change the alignment and move two args to be on one line.
> >=20
> > > +=09if (!pmc->blk_sub_req_regs)
> > > +=09=09return -ENOMEM;
> > > +
> > > +=09req_offset =3D pmc->blk_sub_req_regs;
> > > +=09for (index =3D 0; index < num_blocker; index++) {
> > > +=09=09ret =3D pmt_telem_read32(ep, sample_id, req_offset, 1);
> > > +=09=09if (ret) {
> > > +=09=09=09dev_err(&pmcdev->pdev->dev,
> > > +=09=09=09=09"couldn't read Low Power Mode requirements:
> > > %d\n", ret);
> > > +=09=09=09return ret;
> > > +=09=09}
> > > +=09=09sample_id++;
> > > +=09=09req_offset++;
> > > +=09}
> > > +=09return 0;
> > > +}
> > > +
> > > +static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func,
> > > unsigned int telem_info)
> > >   {
> > >   =09struct pci_dev *pcidev __free(pci_dev_put) =3D NULL;
> > >   =09struct telem_endpoint *ep;
> > > @@ -1470,13 +1554,26 @@ static int pmc_core_get_telem_info(struct pmc=
_dev
> > > *pmcdev, int func)
> > >   =09=09=09return -EPROBE_DEFER;
> > >   =09=09}
> > >   -=09=09ret =3D pmc_core_pmt_get_lpm_req(pmcdev, pmc, ep);
> > > +=09=09if (telem_info & SUB_REQ_LPM) {
> > > +=09=09=09ret =3D pmc_core_pmt_get_lpm_req(pmcdev, pmc, ep);
> > > +=09=09=09if (ret)
> > > +=09=09=09=09goto unregister_ep;
> > > +=09=09}
> > > +
> > > +=09=09if (telem_info & SUB_REQ_BLK) {
> > These two are mutually exclusive? I'm really wondering cuold pointers b=
e
> > used instead to avoid these ifs here and in debugfs fops selection.
> The SUB_REQ_BLK and SUB_REQ_LPM are mutually exclusive. We will also intr=
oduce
> more
> types of data from the telemetry endpoint but not mutually exclusive in t=
he
> next series, therefore
> using bit to identify the type of data sounds appropriate to me. I am not=
 sure
> how to use pointer to
> select data type in this scenario, Could you please give an example?

Perhaps there isn't, I didn't have a crystal ball what's coming after this=
=20
series at hand. :-)

I just noted there are these mutually exclusive pointers:

debugfs_create_file("substate_requirements", ..., &pmc_core_substate_req_re=
gs_fops);
vs
debugfs_create_file("substate_requirements", ..., &pmc_core_substate_blk_re=
q_fops);

and

ret =3D pmc_core_pmt_get_lpm_req(pmcdev, pmc, ep);
vs
ret =3D pmc_core_pmt_get_blk_sub_req(pmcdev, pmc, ep);

As both look like they're decided based on what platform we're running on,=
=20
it looks similar to what pmc_dev_info already contains, having these as=20
pointers in pmc_dev_info would avoid having to create those two branches=20
just to use a different pointer.

(BTW, those two places also use a different way to decide which one to=20
use, which feels slightly inconsistent).


Whether using pointers in pmc_dev_info makes sense given the extra info=20
you provided now, I'm not any more entirely sure.

> > > +=09=09=09ret =3D pmc_core_pmt_get_blk_sub_req(pmcdev, pmc, ep);
> > > +=09=09=09if (ret)
> > > +=09=09=09=09goto unregister_ep;
> > > +=09=09}
> > > +
> > >   =09=09pmt_telem_unregister_endpoint(ep);
> > > -=09=09if (ret)
> > > -=09=09=09return ret;
> > >   =09}
> > >     =09return 0;
> > > +
> > > +unregister_ep:
> > > +=09pmt_telem_unregister_endpoint(ep);
> > > +=09return ret;
> > >   }
> > >     static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_=
info
> > > *list, u16 devid)
> > > @@ -1585,7 +1682,9 @@ int generic_core_init(struct pmc_dev *pmcdev, s=
truct
> > > pmc_dev_info *pmc_dev_info)
> > >   =09=09pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
> > >     =09if (ssram) {
> > > -=09=09ret =3D pmc_core_get_telem_info(pmcdev, pmc_dev_info->pci_func=
);
> > > +=09=09ret =3D pmc_core_get_telem_info(pmcdev,
> > > +=09=09=09=09=09      pmc_dev_info->pci_func,
> > > +=09=09=09=09=09      pmc_dev_info->telem_info);
> > >   =09=09if (ret)
> > >   =09=09=09goto unmap_regbase;
> > >   =09}
> > > diff --git a/drivers/platform/x86/intel/pmc/core.h
> > > b/drivers/platform/x86/intel/pmc/core.h
> > > index 4a94a4ee031e6..d8c7b28493055 100644
> > > --- a/drivers/platform/x86/intel/pmc/core.h
> > > +++ b/drivers/platform/x86/intel/pmc/core.h
> > > @@ -29,6 +29,10 @@ struct telem_endpoint;
> > >   #define LPM_REG_COUNT=09=0928
> > >   #define LPM_MODE_OFFSET=09=091
> > >   +/* Telemetry Endpoint Info bits */
> > > +#define SUB_REQ_LPM=09=090x01=09/* Substate requirement for
> > > low power mode requirements */
> > > +#define SUB_REQ_BLK=09=090x02=09/* Substate requirement for
> > > S0ix blockers */
> > > +
> > >   /* Sunrise Point Power Management Controller PCI Device ID */
> > >   #define SPT_PMC_PCI_DEVICE_ID=09=09=090x9d21
> > >   #define SPT_PMC_BASE_ADDR_OFFSET=09=090x48
> > > @@ -344,6 +348,8 @@ struct pmc_bit_map {
> > >    * @pm_read_disable_bit: Bit index to read PMC_READ_DISABLE
> > >    * @slps0_dbg_offset:=09PWRMBASE offset to SLP_S0_DEBUG_REG*
> > >    * @s0ix_blocker_offset PWRMBASE offset to S0ix blocker counter
> > > + * @num_s0ix_blocker:=09Number of S0ix blockers
> > > + * @blocker_req_offset:=09Telemetry offset to S0ix blocker low power
> > > mode substate requirement table
> > >    *
> > >    * Each PCH has unique set of register offsets and bit indexes. Thi=
s
> > > structure
> > >    * captures them to have a common implementation.
> > > @@ -369,6 +375,8 @@ struct pmc_reg_map {
> > >   =09const u32 ltr_ignore_max;
> > >   =09const u32 pm_vric1_offset;
> > >   =09const u32 s0ix_blocker_offset;
> > > +=09const u32 num_s0ix_blocker;
> > > +=09const u32 blocker_req_offset;
> > >   =09/* Low Power Mode registers */
> > >   =09const int lpm_num_maps;
> > >   =09const int lpm_num_modes;
> > > @@ -404,6 +412,7 @@ struct pmc_info {
> > >    * @map:=09=09pointer to pmc_reg_map struct that contains platform
> > >    *=09=09=09specific attributes
> > >    * @lpm_req_regs:=09List of substate requirements
> > > + * @blk_sub_req_reqs:=09List of registers showing substate
> > > requirements for S0ix blockers
> > >    * @ltr_ign:=09=09Holds LTR ignore data while suspended
> > >    *
> > >    * pmc contains info about one power management controller device.
> > > @@ -413,6 +422,7 @@ struct pmc {
> > >   =09void __iomem *regbase;
> > >   =09const struct pmc_reg_map *map;
> > >   =09u32 *lpm_req_regs;
> > > +=09u32 *blk_sub_req_regs;
> > >   =09u32 ltr_ign;
> > >   };
> > >   @@ -468,6 +478,7 @@ enum pmc_index {
> > >   /**
> > >    * struct pmc_dev_info - Structure to keep PMC device info
> > >    * @pci_func:=09=09Function number of the primary PMC
> > > + * @telem_info:=09=09Bitmask to indicate which telemetry info is
> > > available
> > >    * @dmu_guid:=09=09Die Management Unit GUID
> > >    * @regmap_list:=09Pointer to a list of pmc_info structure that cou=
ld be
> > >    *=09=09=09available for the platform. When set, this
> > > field implies
> > > @@ -480,6 +491,7 @@ enum pmc_index {
> > >    */
> > >   struct pmc_dev_info {
> > >   =09u8 pci_func;
> > > +=09u8 telem_info;
> > >   =09u32 dmu_guid;
> > >   =09struct pmc_info *regmap_list;
> > >   =09const struct pmc_reg_map *map;
> > > diff --git a/drivers/platform/x86/intel/pmc/lnl.c
> > > b/drivers/platform/x86/intel/pmc/lnl.c
> > > index e08a77c778c2c..ec9e79f6cd913 100644
> > > --- a/drivers/platform/x86/intel/pmc/lnl.c
> > > +++ b/drivers/platform/x86/intel/pmc/lnl.c
> > > @@ -572,6 +572,7 @@ static int lnl_core_init(struct pmc_dev *pmcdev,
> > > struct pmc_dev_info *pmc_dev_in
> > >     struct pmc_dev_info lnl_pmc_dev =3D {
> > >   =09.pci_func =3D 2,
> > > +=09.telem_info =3D SUB_REQ_LPM,
> > >   =09.regmap_list =3D lnl_pmc_info_list,
> > >   =09.map =3D &lnl_socm_reg_map,
> > >   =09.suspend =3D cnl_suspend,
> > > diff --git a/drivers/platform/x86/intel/pmc/mtl.c
> > > b/drivers/platform/x86/intel/pmc/mtl.c
> > > index faa13a7ee688f..c58a871e2e0df 100644
> > > --- a/drivers/platform/x86/intel/pmc/mtl.c
> > > +++ b/drivers/platform/x86/intel/pmc/mtl.c
> > > @@ -994,6 +994,7 @@ static int mtl_core_init(struct pmc_dev *pmcdev,
> > > struct pmc_dev_info *pmc_dev_in
> > >     struct pmc_dev_info mtl_pmc_dev =3D {
> > >   =09.pci_func =3D 2,
> > > +=09.telem_info =3D SUB_REQ_LPM,
> > >   =09.dmu_guid =3D MTL_PMT_DMU_GUID,
> > >   =09.regmap_list =3D mtl_pmc_info_list,
> > >   =09.map =3D &mtl_socm_reg_map,
> > >=20
>=20

--=20
 i.

--8323328-1517171256-1751011724=:1730--


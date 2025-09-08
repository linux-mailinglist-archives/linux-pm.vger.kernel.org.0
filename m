Return-Path: <linux-pm+bounces-34148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B251EB48B10
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 13:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2181897698
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 11:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887432FB0B7;
	Mon,  8 Sep 2025 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tq/BLgxF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6734E2FABE0;
	Mon,  8 Sep 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329434; cv=none; b=aYmVHY9LX5R6BIUa2zoeXpxL6SdtuS/03MCpWnOlaxCG0BnCrPZFvECi7yDo+w6MqpcYnWtAn3d0wa4E0XnUunljpdcCtUzUUNT4GYXEtz+ADMD/iK6ScxoHpOihKufG5rdP5ozJUC8yBqm0PqLq4SZe2yxiyOfh3mtHCEpt7gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329434; c=relaxed/simple;
	bh=nnDO52lb3fZnH4BbFRvfPh9V5QmWlluTdmnAisy1PlU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h2FztI7BXmmVG4QcPXOFoKybkC20NRW0Fd46foUaqc1Cm8u1tApVLv5goO8Gnw2JikojNI7DDotqd4G5/jYyyg6u6o/diAVDwnBVVk8MA8DOy9HxYR8Gi3AEyVfVEigmJfJWvm00n85LgFuDbOD61+Kl3o68wwrEBSDzXaukAtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tq/BLgxF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757329433; x=1788865433;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=nnDO52lb3fZnH4BbFRvfPh9V5QmWlluTdmnAisy1PlU=;
  b=Tq/BLgxFh+c157SbAwTlpxUyD/0iGHCgSbBOrjDLdiMCDInXv4ubpbep
   DeTKdw7kUM5cmxJ7nkfVDCvUP6eNI/QYOQhEGl26fMYbBIUYEnBLYWMWL
   smDg3vylbPc6YqKpVaHh7SQJNKZlDSaSwq6wLNfmEnYUgsHUcbkAmOWPa
   K/SXxKDrv+srITq6SZE95hK4XoaDsr+SD3AFFaVsZB0OIRuhVI2eL46WJ
   J1yEyU2r44bIRbNhlORS76lzfb1uICYr64inZlOAdkN/N7rVwvWAGEVYE
   XkDc4925hTDyggavCvtx/OR4gDigr1CmLAKs9XHosVZXFlVgPvzCE2pxW
   w==;
X-CSE-ConnectionGUID: tfOclQoTQr+wf/cxMtm+lg==
X-CSE-MsgGUID: f+N67MXvSfuZc/z2zKeR9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="63222574"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="63222574"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:03:52 -0700
X-CSE-ConnectionGUID: vS4iXOewTwKYh/36n4l1Tw==
X-CSE-MsgGUID: mT7o05c6SvC10/MUHnrVdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="176817028"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.11])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:03:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Sep 2025 14:03:45 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 5/6] platform/x86:intel/pmc: Show device and function
 number
In-Reply-To: <7fae6fc8-6df5-4d1f-90ec-b6bf159e62da@linux.intel.com>
Message-ID: <ed041865-c5aa-1312-e401-8cf333ac0820@linux.intel.com>
References: <20250815224611.2460255-1-xi.pardee@linux.intel.com> <20250815224611.2460255-6-xi.pardee@linux.intel.com> <c9aa04ae-f942-cf73-d046-78d0f90f373d@linux.intel.com> <7fae6fc8-6df5-4d1f-90ec-b6bf159e62da@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1559071104-1757328370=:938"
Content-ID: <45d0b3af-16cb-d41d-b9d8-351e9de031af@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1559071104-1757328370=:938
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <c4323cb8-65e8-c085-f405-05909754bedc@linux.intel.com>

On Sun, 7 Sep 2025, Xi Pardee wrote:

> Hi Ilpo,
>=20
> Thanks for the review.
>=20
> On 8/28/2025 6:56 AM, Ilpo J=E4rvinen wrote:
> > On Fri, 15 Aug 2025, Xi Pardee wrote:
> >=20
> > > Add support to show device and function number for S0ix blockers. Thi=
s
> > > feature depends on S0ix blocker substate requirement table and BDF
> > > association table. This feature is available for platforms starting f=
rom
> > > Pather Lake.
> > >=20
> > > Only a subset of S0ix blockers has device and function number associa=
ted
> > > to it. Get the availability information from the substate requirement
> > > table. Get the device and function number mapping information for eac=
h
> > > S0ix blocker from the BDF association table.
> > >=20
> > > Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> > > ---
> > >   drivers/platform/x86/intel/pmc/core.c | 182 +++++++++++++++++++++++=
++-
> > >   drivers/platform/x86/intel/pmc/core.h |  23 +++-
> > >   2 files changed, 203 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/intel/pmc/core.c
> > > b/drivers/platform/x86/intel/pmc/core.c
> > > index a0b948a875a5a..69ee40cbb8b8a 100644
> > > --- a/drivers/platform/x86/intel/pmc/core.c
> > > +++ b/drivers/platform/x86/intel/pmc/core.c


> > > +=09=09const char *name =3D NULL;
> > > +=09=09struct list_head *cur;
> > > +=09=09struct bdf_entry *bdf;
> > > +=09=09struct pmc *pmc;
> > > +
> > > +=09=09pmc =3D pmcdev->pmcs[pmcidx];
> > > +=09=09if (!pmc)
> > > +=09=09=09continue;
> > > +
> > > +=09=09list_for_each(cur, pmc->bdf_list) {
> > > +=09=09=09bdf =3D list_entry(cur, struct bdf_entry, node);
> > > +=09=09=09if (bdf->name !=3D name) {
> > > +=09=09=09=09seq_printf(s, "pmc%d: %30s | %15x | %15x |\n",
> > > pmcidx,
> > %u
> Will change it in next version.

I don't remember if I mentioned it earlier but if you're going to address=
=20
the review comment fully. There's no need to "ack" them like this. I=20
trust you make the changes you don't contest.

By doing so, we can both save time by only focusing on the points which=20
are contested or need further discussion. :-)


> > > +=09if (!maps[*r_idx][*i_idx].name)
> > > +=09=09(*r_idx)++;
> > > +
> > > +=09// Iteration reaches the end of the maps
> > > +=09if (*r_idx >=3D arr_size)
> > > +=09=09return NULL;
> > > +
> > > +=09for (; *r_idx < arr_size; (*r_idx)++) {
> > > +=09=09const char *ip_name;
> > Can't you put this to the innermost block?
> Will move it in next version.
> >=20
> > > +=09=09if (reset)
> > Why you need this?
>=20
> The purpose of this function is to return the name of the NEXT s0ix block=
er
> with BDF information.
>=20
> r_idx and i_idx are used to keep track of the current position of the
> iteration, therefore i_idx could not be reset to 0 at the first run of th=
e
> inner for loop. After the first run of inner for loop reset should be set=
 to
> true so in next run of the outer for loop i_idx could be reset to 0 (whic=
h
> mean the iteration reaches the next s0ix blocker map).

But why you cannot reset i_idx after the inner for () loop and drop=20
this reset variable entirely?

> > > +=09=09=09*i_idx =3D 0;
> > > +
> > > +=09=09for (; maps[*r_idx][*i_idx].name; reset =3D TRUE, (*i_idx)++) =
{
> > true
> >=20
> > This is hard enough to understand even without that "for (;". Would
> > probably be better to use while () instead.
> Will change to while loop in next version.
> > > +=09=09=09if (!maps[*r_idx][*i_idx].blk)
> > > +=09=09=09=09continue;
> > > +
> > > +=09=09=09bool exist =3D **lpm_req_regs & BIT(BDF_EXIST_BIT);
> > > +=09=09=09(*lpm_req_regs)++;
> > > +=09=09=09if (exist) {
> > > +=09=09=09=09ip_name =3D maps[*r_idx][*i_idx].name;
> > > +=09=09=09=09(*i_idx)++;
> > > +=09=09=09=09return ip_name;
> > > +=09=09=09}
> > > +=09=09}
> > > +=09}
> > > +=09return NULL;
> > > +}
> > TBH, this entire function is horrible mess, two nested iterators as
> > pointers, etc.
> >=20
> > I'm very far from following all what going on here.
> >=20
> > I suppose I've not seen this patch previously?
>=20
> To achieve the NEXT name of the s0ix blocker with BDF information we need=
 to
> iterate through two (set of) maps in parallel. The s0ix_blocker_maps prov=
ide
> names of all s0ix blockers and the lpm_req_regs map shows that which s0ix
> blocker has associated BDF information.
>=20
> if maps[*r_idx][*i_idx].blk is set, that means it is a s0ix blocker. For =
each
> s0ix blocker, if **lpm_req_regs & BIT(BDF_EXIST_BIT) is set, that means t=
his
> blocker has associated BDF information. Pointers are used to keep track o=
f the
> current position of the two (set of) maps so the function provides the NE=
XT
> name of the s0ix blocker with associated BDF info.
>=20
> I will probably switch to use a temporary data structure, such as list, t=
o
> store all s0ix blockers with BDF info and then iterate through this list =
in
> pmc_core_process_bdf() call instead. That will make the logic easier to f=
ollow
> and maintain. I will also add more comments to next version of this patch=
=2E

My out-of-band suggestion was to convert i_idx into a correctly typed=20
pointer  as it's the last-level array, you only need to do two things for=
=20
the pointer:

- set it to start of the next array when r_idx increases.
- increment the pointer with ++.

> > > +static int pmc_core_process_bdf(struct pmc_dev *pmcdev,  struct pmc =
*pmc,
> > > u32 data,
> > > +=09=09=09=09unsigned int *r_idx, unsigned int *i_idx, u32
> > > **lpm_req_regs,
> > > +=09=09=09=09const char **name)
> > > +{
> > > +=09unsigned int i;
> > > +
> > > +=09if (!data)
> > > +=09=09return 0;
> > > +
> > > +=09if (!*name)
> > > +=09=09return -EINVAL;
> > > +
> > > +=09for (i =3D BDF_FUN_LOW_BIT; i <=3D BDF_FUN_HIGH_BIT; i++) {
> > I think you can iterate 0 ... __fls(FIELD_MAX()).
>=20
> Each 16 bit represents one device and the associated function numbers for=
 one
> s0ix blocker.
>=20
> Bit 4-0 indicates the device number.
>=20
> Bit 12-5 indicates function numbers.
>=20
> Bit 15 indicates if the next 16 bit is associated to the same s0ix blocke=
r as
> the current word.
>
> Between bit 12 and bit 5, each bit position represents one function numbe=
r.
> Bit 5 represents function 0 and bit 12 represents function 7. I will add =
more
> comments in the next version.
>=20
> Will change to use __fls(FIELD_MAX()) in next version.

Yes, these are fields which are to be defined with GENMASK()/BIT(). Then=20
this code just has to figure out how to deal with that change and my=20
suggestion was to use fls construct. If you find better approach, those=20
can be used as well but my point is that this iteration should be sourced=
=20
from the GENMASK_U16(12, 5).

> > > +=09name =3D pmc_core_get_next_bdf_ip_name(pmc, &r_idx, &i_idx,
> > > &lpm_reg_regs);
> > > +=09if (!name)
> > > +=09=09return -EINVAL;
> > > +
> > > +=09pmc->bdf_list =3D devm_kzalloc(&pmcdev->pdev->dev, sizeof(struct
> > > list_head), GFP_KERNEL);
> > Should use sizeof(*xx).
> >=20
> > But why you need to allocate the list head and not have it in place
> > within the pmc's struct?
>=20
> The memory for bdf_list is only allocated when the bdf information is
> available to achieve.
>
> intel_pmc_core driver can check if the memory is allocated to decide whet=
her
> to create a file in debugfs for bdf in pmc_core_dbgfs_register().

But can't you use empty list check for that?

> > > +=09if (!pmc->bdf_list)
> > > +=09=09return -ENOMEM;
> > > +
> > > +=09INIT_LIST_HEAD(pmc->bdf_list);

> > > +
> > > +=09for (; sample_id < max_sample_id; sample_id++) {
> > > +=09=09u32 data;
> > > +
> > > +=09=09ret =3D pmt_telem_read32(ep, sample_id, &data, 1);
> > > +=09=09if (ret) {
> > > +=09=09=09dev_err(&pmcdev->pdev->dev,
> > > +=09=09=09=09"couldn't read bdf: %d\n", ret);
> > One line.
> Will change it in next version.
> >=20
> > > +=09=09=09return ret;
> > > +=09=09}
> > > +
> > > +=09=09if (sample_id =3D=3D header_id) {
> > > +=09=09=09size =3D (data & GENMASK(BDF_SIZE_HIGH_BIT,
> > > BDF_SIZE_LOW_BIT))
> > > +=09=09=09       >> BDF_SIZE_LOW_BIT;
> > Define the field and use FIELD_GET().
> Will change it in next version.
> >=20
> > > +=09=09=09header_id +=3D size + 1;
> > No, I just cannot understand what's going on here, it's hopeless. Alway=
s
> > when I think I've finally understood what its all about you throw a cur=
ve
> > ball like this.
>=20
> There is one header line (32 bit) between each type of s0ix blocker in th=
e bdf
> association table. The bit 23-26 in header line indicates the size of eac=
h
> section of one specific type of s0ix blocker in this table.
>=20
> header_id is used=A0 to keep track of the id of each header so we will pr=
ocess
> the header line differently from the other lines.
>=20
> I will add more detailed comment in next version.

I suspect naming the fields with defines and using FIELD_GET() will=20
already get you far.

Perhaps BDF_SIZE (=3Dwhat remains when you take those custom coded bit fiel=
d=20
postfix out of the current naming) should be renamed into something like=20
BDF_SECTION_SIZE for better clarity.

--=20
 i.
--8323328-1559071104-1757328370=:938--


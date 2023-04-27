Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D976F0444
	for <lists+linux-pm@lfdr.de>; Thu, 27 Apr 2023 12:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbjD0Khe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Apr 2023 06:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242817AbjD0Khd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Apr 2023 06:37:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63100E7B
        for <linux-pm@vger.kernel.org>; Thu, 27 Apr 2023 03:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682591852; x=1714127852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q22iismVzrorof4SSh18jebbXjbzWKSjUqul9A49BgI=;
  b=y0qJxp0RkncGTBLKo3tooKASYgLfFWJJMJOe7yjlD4Yo11DtfFsJLyiP
   Iv+tOa+Sd5NiNNv7YCmS8Si5rrXviC+6Tkz12OdApAnd1l8mN1lDcKm0Z
   TMBXQXPa/jF/y5e0ud2nVf97p1PpOPhRlTCrwNFmy55SbJZPZC6LS1SIj
   zZHnexr7cEadc6jnxyT2o16qGQfCQ8tJPdl8roLp6aed+u6HYiWwSbS2x
   eMd0TP1i9wAn1Tr7JYKiUtHWh/MurEXdLuQ1UwhSnC/iVXY2hsgC2K/vQ
   IbiRfvxsUM1Jti3lrnDIT05cxtKCgB6dzIZGCtL0KFeh/MJkG08NbszlV
   w==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677567600"; 
   d="asc'?scan'208";a="212561833"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Apr 2023 03:37:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 27 Apr 2023 03:37:29 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 27 Apr 2023 03:37:27 -0700
Date:   Thu, 27 Apr 2023 11:37:10 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     <linux-pm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kvm-riscv@lists.infradead.org>,
        "'Rafael J . Wysocki '" <rafael@kernel.org>,
        'Will Deacon ' <will@kernel.org>,
        'Daniel Lezcano ' <daniel.lezcano@linaro.org>,
        'Mark Rutland ' <mark.rutland@arm.com>,
        'Atish Patra ' <atishp@atishpatra.org>,
        'Palmer Dabbelt ' <palmer@dabbelt.com>,
        'Anup Patel ' <anup@brainfault.org>,
        'Albert Ou ' <aou@eecs.berkeley.edu>,
        'Paul Walmsley ' <paul.walmsley@sifive.com>
Subject: Re: [PATCH] RISC-V: Align SBI probe implementation with spec
Message-ID: <20230427-aflutter-emboss-6892d7097915@wendy>
References: <20230426172254.70342-1-ajones@ventanamicro.com>
 <20230427-property-barracuda-631a14371df0@wendy>
 <ryknbllu75eliur7v6tzei6jvqgwayuhej5icobxxrqwabymhz@lnnqmlrqxvex>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qg7yZ7Ul34x+puxW"
Content-Disposition: inline
In-Reply-To: <ryknbllu75eliur7v6tzei6jvqgwayuhej5icobxxrqwabymhz@lnnqmlrqxvex>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--qg7yZ7Ul34x+puxW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2023 at 12:17:02PM +0200, Andrew Jones wrote:
> On Thu, Apr 27, 2023 at 10:42:11AM +0100, Conor Dooley wrote:
> > On Wed, Apr 26, 2023 at 07:22:54PM +0200, Andrew Jones wrote:
> > > sbi_probe_extension() is specified with "Returns 0 if the given SBI
> > > extension ID (EID) is not available, or 1 if it is available unless
> > > defined as any other non-zero value by the implementation."
> > > Additionally, sbiret.value is a long. Fix the implementation to
> > > ensure any nonzero long value is considered a success, rather
> > > than only positive int values.
> >=20
> > Does this need a fixes tag (or tags) then, since we could easily return
> > a negative value as things stand if the SBI implementation decides to
> > return 0b1...1 for success?
>=20
> Nothing is getting fixed when only considering the current generic opensbi
> platform, but there could be other SBI implementations Linux isn't
> handling correctly by only considering success to be greater than zero
> or by truncating the return value from long to int. I suppose that
> possibility does warrant a fix tag, which would be

Yah, I figured that something like opensbi would do the "sane" thing
here, but there's no accounting for taste and all that.

> Fixes: b9dcd9e41587 ("RISC-V: Add basic support for SBI v0.2")
>=20
> >=20
> > > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > > ---
> > >  arch/riscv/include/asm/sbi.h        |  2 +-
> > >  arch/riscv/kernel/cpu_ops.c         |  2 +-
> > >  arch/riscv/kernel/sbi.c             | 17 ++++++++---------
> > >  arch/riscv/kvm/main.c               |  2 +-
> > >  drivers/cpuidle/cpuidle-riscv-sbi.c |  2 +-
> > >  drivers/perf/riscv_pmu_sbi.c        |  2 +-
> > >  6 files changed, 13 insertions(+), 14 deletions(-)
> > >=20
> > > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sb=
i.h
> > > index 945b7be249c1..119355485703 100644
> > > --- a/arch/riscv/include/asm/sbi.h
> > > +++ b/arch/riscv/include/asm/sbi.h
> > > @@ -296,7 +296,7 @@ int sbi_remote_hfence_vvma_asid(const struct cpum=
ask *cpu_mask,
> > >  				unsigned long start,
> > >  				unsigned long size,
> > >  				unsigned long asid);
> > > -int sbi_probe_extension(int ext);
> > > +long sbi_probe_extension(int ext);
> > > =20
> > >  /* Check if current SBI specification version is 0.1 or not */
> > >  static inline int sbi_spec_is_0_1(void)
> > > diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
> > > index 8275f237a59d..eb479a88a954 100644
> > > --- a/arch/riscv/kernel/cpu_ops.c
> > > +++ b/arch/riscv/kernel/cpu_ops.c
> > > @@ -27,7 +27,7 @@ const struct cpu_operations cpu_ops_spinwait =3D {
> > >  void __init cpu_set_ops(int cpuid)
> > >  {
> > >  #if IS_ENABLED(CONFIG_RISCV_SBI)
> > > -	if (sbi_probe_extension(SBI_EXT_HSM) > 0) {
> > > +	if (sbi_probe_extension(SBI_EXT_HSM)) {
> > >  		if (!cpuid)
> > >  			pr_info("SBI HSM extension detected\n");
> > >  		cpu_ops[cpuid] =3D &cpu_ops_sbi;
> > > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > > index 5c87db8fdff2..015ce8eef2de 100644
> > > --- a/arch/riscv/kernel/sbi.c
> > > +++ b/arch/riscv/kernel/sbi.c
> > > @@ -581,19 +581,18 @@ static void sbi_srst_power_off(void)
> > >   * sbi_probe_extension() - Check if an SBI extension ID is supported=
 or not.
> > >   * @extid: The extension ID to be probed.
> > >   *
> > > - * Return: Extension specific nonzero value f yes, -ENOTSUPP otherwi=
se.
> > > + * Return: 1 or an extension specific nonzero value if yes, 0 otherw=
ise.
> > >   */
> > > -int sbi_probe_extension(int extid)
> > > +long sbi_probe_extension(int extid)
> > >  {
> > >  	struct sbiret ret;
> > > =20
> > >  	ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_PROBE_EXT, extid,
> > >  			0, 0, 0, 0, 0);
> > >  	if (!ret.error)
> > > -		if (ret.value)
> > > -			return ret.value;
> > > +		return ret.value;
> > > =20
> > > -	return -ENOTSUPP;
> > > +	return 0;
> >=20
> > Why not make it return -ENOTSUPP for failures and 0 for success instead,
> > as it does not appear that any users actually care what the return value
> > is, once it is not an error?
>=20
> Just to prepare for theoretical new uses.
>=20
> > Concerned that it'll look weird to have
> > 	if(!sbi_probe_extension(foo))
> > 		print(foo is available!)
> > since it looks a bit weird that the !case is success?
>=20
> No, that's pretty par for the course in the kernel. I'd just prefer
> that sbi_probe_extension() be a simple wrapper around the SBI call,
> one that doesn't change the SBI call's return value semantics.
>=20
> >=20
> > If so, perhaps it could just return a bool instead, unless of course I
> > am missing some pending user that make some decision on the actual value
> > returned here is.
>=20
> No pending user that I'm aware of, but it's not too awkward, IMO, to
> implement this as the spec says, so any pending user that comes along
> will be happy from the start. If a boolean function seems better for
> everyone,

I don't really mind which way you do it to be honest.
I see reasons for both wanting alignment with what the SBI spec has &
for returning the simplest type that fits the usage.
Both are better than the current, potentially buggy, implementation.

Can put a
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
on it either way.

--qg7yZ7Ul34x+puxW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEpQVgAKCRB4tDGHoIJi
0iW5AQDA6w/HwQfBlJ8IYgZ6pRa8AtyEEGnChoPyFmJIuxy/vgD+PACW8U70qITR
biI8X+NAOZhU1cXwFj+2ckS05sIJhgY=
=QJlL
-----END PGP SIGNATURE-----

--qg7yZ7Ul34x+puxW--

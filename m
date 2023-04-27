Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA5B6F038A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Apr 2023 11:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243186AbjD0Jmg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Apr 2023 05:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243100AbjD0Jmf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Apr 2023 05:42:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D013A19AE
        for <linux-pm@vger.kernel.org>; Thu, 27 Apr 2023 02:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682588553; x=1714124553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E2hIVyCBUEtSk5gih4iFA5MhLw3/fhNppdRQgn90I1g=;
  b=lD0dCWWSjhYwuu6gEz8ZwgRPwENlrE6XfGJ2SklJ1L8vX/csOYx+G4Bx
   bUh9VqtRXfAKfQc37NQKehb7UMEU2GbIqR/fLKzDAwJC/YZTeKrfvwPAa
   0rzRmcCQ5eUgZacFydSdkYs5TAv6iwWFlINs27YSd//SqDzxlU+ziNB45
   7WiQpg1zAWSAUoVkIGcruKBk193Nz/JlDvRVtRY9Oj4BfYpjy9XB6TRdm
   GiEcWFTXwh10ih1728XbmdE+fn1tr5kRpU+V5gCq5x7kUmxS4X65yYSB/
   K+cpnVoVRNbZzhdI0KGgbPCh2+2wjS3Lj21lB7hlOaBcsTLs7jrU3kFJr
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677567600"; 
   d="asc'?scan'208";a="212555959"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Apr 2023 02:42:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 27 Apr 2023 02:42:31 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 27 Apr 2023 02:42:28 -0700
Date:   Thu, 27 Apr 2023 10:42:11 +0100
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
Message-ID: <20230427-property-barracuda-631a14371df0@wendy>
References: <20230426172254.70342-1-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L6BUTM0l87ia1896"
Content-Disposition: inline
In-Reply-To: <20230426172254.70342-1-ajones@ventanamicro.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--L6BUTM0l87ia1896
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2023 at 07:22:54PM +0200, Andrew Jones wrote:
> sbi_probe_extension() is specified with "Returns 0 if the given SBI
> extension ID (EID) is not available, or 1 if it is available unless
> defined as any other non-zero value by the implementation."
> Additionally, sbiret.value is a long. Fix the implementation to
> ensure any nonzero long value is considered a success, rather
> than only positive int values.

Does this need a fixes tag (or tags) then, since we could easily return
a negative value as things stand if the SBI implementation decides to
return 0b1...1 for success?

> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/sbi.h        |  2 +-
>  arch/riscv/kernel/cpu_ops.c         |  2 +-
>  arch/riscv/kernel/sbi.c             | 17 ++++++++---------
>  arch/riscv/kvm/main.c               |  2 +-
>  drivers/cpuidle/cpuidle-riscv-sbi.c |  2 +-
>  drivers/perf/riscv_pmu_sbi.c        |  2 +-
>  6 files changed, 13 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 945b7be249c1..119355485703 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -296,7 +296,7 @@ int sbi_remote_hfence_vvma_asid(const struct cpumask =
*cpu_mask,
>  				unsigned long start,
>  				unsigned long size,
>  				unsigned long asid);
> -int sbi_probe_extension(int ext);
> +long sbi_probe_extension(int ext);
> =20
>  /* Check if current SBI specification version is 0.1 or not */
>  static inline int sbi_spec_is_0_1(void)
> diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
> index 8275f237a59d..eb479a88a954 100644
> --- a/arch/riscv/kernel/cpu_ops.c
> +++ b/arch/riscv/kernel/cpu_ops.c
> @@ -27,7 +27,7 @@ const struct cpu_operations cpu_ops_spinwait =3D {
>  void __init cpu_set_ops(int cpuid)
>  {
>  #if IS_ENABLED(CONFIG_RISCV_SBI)
> -	if (sbi_probe_extension(SBI_EXT_HSM) > 0) {
> +	if (sbi_probe_extension(SBI_EXT_HSM)) {
>  		if (!cpuid)
>  			pr_info("SBI HSM extension detected\n");
>  		cpu_ops[cpuid] =3D &cpu_ops_sbi;
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 5c87db8fdff2..015ce8eef2de 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -581,19 +581,18 @@ static void sbi_srst_power_off(void)
>   * sbi_probe_extension() - Check if an SBI extension ID is supported or =
not.
>   * @extid: The extension ID to be probed.
>   *
> - * Return: Extension specific nonzero value f yes, -ENOTSUPP otherwise.
> + * Return: 1 or an extension specific nonzero value if yes, 0 otherwise.
>   */
> -int sbi_probe_extension(int extid)
> +long sbi_probe_extension(int extid)
>  {
>  	struct sbiret ret;
> =20
>  	ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_PROBE_EXT, extid,
>  			0, 0, 0, 0, 0);
>  	if (!ret.error)
> -		if (ret.value)
> -			return ret.value;
> +		return ret.value;
> =20
> -	return -ENOTSUPP;
> +	return 0;

Why not make it return -ENOTSUPP for failures and 0 for success instead,
as it does not appear that any users actually care what the return value
is, once it is not an error?
Concerned that it'll look weird to have
	if(!sbi_probe_extension(foo))
		print(foo is available!)
since it looks a bit weird that the !case is success?

If so, perhaps it could just return a bool instead, unless of course I
am missing some pending user that make some decision on the actual value
returned here is.

Cheers,
Conor.

>  }
>  EXPORT_SYMBOL(sbi_probe_extension);
> =20
> @@ -665,26 +664,26 @@ void __init sbi_init(void)
>  	if (!sbi_spec_is_0_1()) {
>  		pr_info("SBI implementation ID=3D0x%lx Version=3D0x%lx\n",
>  			sbi_get_firmware_id(), sbi_get_firmware_version());
> -		if (sbi_probe_extension(SBI_EXT_TIME) > 0) {
> +		if (sbi_probe_extension(SBI_EXT_TIME)) {
>  			__sbi_set_timer =3D __sbi_set_timer_v02;
>  			pr_info("SBI TIME extension detected\n");
>  		} else {
>  			__sbi_set_timer =3D __sbi_set_timer_v01;
>  		}
> -		if (sbi_probe_extension(SBI_EXT_IPI) > 0) {
> +		if (sbi_probe_extension(SBI_EXT_IPI)) {
>  			__sbi_send_ipi	=3D __sbi_send_ipi_v02;
>  			pr_info("SBI IPI extension detected\n");
>  		} else {
>  			__sbi_send_ipi	=3D __sbi_send_ipi_v01;
>  		}
> -		if (sbi_probe_extension(SBI_EXT_RFENCE) > 0) {
> +		if (sbi_probe_extension(SBI_EXT_RFENCE)) {
>  			__sbi_rfence	=3D __sbi_rfence_v02;
>  			pr_info("SBI RFENCE extension detected\n");
>  		} else {
>  			__sbi_rfence	=3D __sbi_rfence_v01;
>  		}
>  		if ((sbi_spec_version >=3D sbi_mk_version(0, 3)) &&
> -		    (sbi_probe_extension(SBI_EXT_SRST) > 0)) {
> +		    sbi_probe_extension(SBI_EXT_SRST)) {
>  			pr_info("SBI SRST extension detected\n");
>  			pm_power_off =3D sbi_srst_power_off;
>  			sbi_srst_reboot_nb.notifier_call =3D sbi_srst_reboot;
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 41ad7639a17b..c923c113a129 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -75,7 +75,7 @@ static int __init riscv_kvm_init(void)
>  		return -ENODEV;
>  	}
> =20
> -	if (sbi_probe_extension(SBI_EXT_RFENCE) <=3D 0) {
> +	if (!sbi_probe_extension(SBI_EXT_RFENCE)) {
>  		kvm_info("require SBI RFENCE extension\n");
>  		return -ENODEV;
>  	}
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidl=
e-riscv-sbi.c
> index be383f4b6855..c6b599167036 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -613,7 +613,7 @@ static int __init sbi_cpuidle_init(void)
>  	 * 2) SBI HSM extension is available
>  	 */
>  	if ((sbi_spec_version < sbi_mk_version(0, 3)) ||
> -	    sbi_probe_extension(SBI_EXT_HSM) <=3D 0) {
> +	    !sbi_probe_extension(SBI_EXT_HSM)) {
>  		pr_info("HSM suspend not available\n");
>  		return 0;
>  	}
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 70cb50fd41c2..4f3ac296b3e2 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -924,7 +924,7 @@ static int __init pmu_sbi_devinit(void)
>  	struct platform_device *pdev;
> =20
>  	if (sbi_spec_version < sbi_mk_version(0, 3) ||
> -	    sbi_probe_extension(SBI_EXT_PMU) <=3D 0) {
> +	    !sbi_probe_extension(SBI_EXT_PMU)) {
>  		return 0;
>  	}
> =20
> --=20
> 2.39.2
>=20

--L6BUTM0l87ia1896
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEpDcwAKCRB4tDGHoIJi
0lEnAQDH3q3yJRcR+C8lJtpaCBf+MmgJqSN8MUY36KEr7iRlCgD8DHVUJiGqd0AI
yBSKx4XSV9m3HgLpL4XKEXdwDfrXyAY=
=/8C2
-----END PGP SIGNATURE-----

--L6BUTM0l87ia1896--

Return-Path: <linux-pm+bounces-35184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE78B92996
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 20:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CF7445D34
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 18:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAE029BDB5;
	Mon, 22 Sep 2025 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWxOaJDt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2556221F26;
	Mon, 22 Sep 2025 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758565921; cv=none; b=iDs+GwR32IlVqoGu2h9g0sZtzDr9h4lbGCV5wd4x8delLEYj4FdE8E78YcmjyvBHfQapapHdK3RJn8nXs5IlDACeFXAJCRUik0Kwv7YRKtqn4w3fPO4K9NmKJZQ7dyYQl89MU9kEhcC/N2/HItI4D/AfjNR3KV38WagwfIFbQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758565921; c=relaxed/simple;
	bh=0JdHryXr2Gx1DLZ+TqKRbUPejnsbAeS9k+y7csMSMcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNcmf6lcmLv/cIhpjZ7xgV2ShK517CSOo0hNwOSaeVp/1IcYdSi5IC+l07x5jFgux68LtPhRa4MPcLwaQGyO+a7X1YcaAgvnNljC71sAEd2/gc2S4TJru9mNjftyXRmLAFfcWZ0HaF+v8Lg04kP3DZt8/AElKKg/ihycb1Lyi0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWxOaJDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8BAC4CEF0;
	Mon, 22 Sep 2025 18:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758565921;
	bh=0JdHryXr2Gx1DLZ+TqKRbUPejnsbAeS9k+y7csMSMcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aWxOaJDtyU+f9+DUoiomqa+MN/gwmqWxbpKZyswkjYQZa82LD4GSQrzBtpqart4Wc
	 gzxs1+HrnZL9M17oPOlDphlRA6S+GL4DzG6jDdqX8l32wsFGPGSpPhSbdbj1zUTGwc
	 r87EN2KLeHEV9hOl1ajot9naEtg2OJ58UDz29mwknXRgyZssrjRrvd5MeW4PYTWU2Q
	 4+9Cm+/JeSegeLYVi5cticoMQbqhblKNJoMucMABAHuRapHlaU/TTykxH5JRUaoja8
	 1e4kFCSAs9hdx3AvWjwp6oYPeoquqCruxJiASqUz5OrKqzHAgUBz+CBhjXHT8glz2j
	 c/ien7AVvcnxQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH v2] cpufreq: Handle CPUFREQ_ETERNAL with a default transition
 latency
Date: Mon, 22 Sep 2025 20:31:56 +0200
Message-ID: <12764935.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <20250922125929.453444-1-shawnguo2@yeah.net>
References: <20250922125929.453444-1-shawnguo2@yeah.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Monday, September 22, 2025 2:59:21 PM CEST Shawn Guo wrote:
> From: Shawn Guo <shawnguo@kernel.org>
>=20
> A regression is seen with 6.6 -> 6.12 kernel upgrade on platforms where
> cpufreq-dt driver sets cpuinfo.transition_latency as CPUFREQ_ETERNAL (-1),
> due to that platform's DT doesn't provide the optional property
> 'clock-latency-ns'.  The dbs sampling_rate was 10000 us on 6.6 and
> suddently becomes 6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these
> platforms, because the default transition delay was dropped by the commits
> below.
>=20
>   commit 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER")
>   commit a755d0e2d41b ("cpufreq: Honour transition_latency over transitio=
n_delay_us")
>   commit e13aa799c2a6 ("cpufreq: Change default transition delay to 2ms")
>=20
> It slows down dbs governor's reacting to CPU loading change
> dramatically.  Also, as transition_delay_us is used by schedutil governor
> as rate_limit_us, it shows a negative impact on device idle power
> consumption, because the device gets slightly less time in the lowest OPP.
>=20
> Fix the regressions by defining a default transition latency for
> handling the case of CPUFREQ_ETERNAL.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER")
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
> Changes for v2:
> - Follow Rafael's suggestion to define a default transition latency for
>   handling CPUFREQ_ETERNAL, and pave the way to get rid of
>   CPUFREQ_ETERNAL completely later.
>=20
> v1: https://lkml.org/lkml/2025/9/10/294
>=20
>  drivers/cpufreq/cpufreq.c | 3 +++
>  include/linux/cpufreq.h   | 2 ++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index fc7eace8b65b..c69d10f0e8ec 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -549,6 +549,9 @@ unsigned int cpufreq_policy_transition_delay_us(struc=
t cpufreq_policy *policy)
>  	if (policy->transition_delay_us)
>  		return policy->transition_delay_us;
> =20
> +	if (policy->cpuinfo.transition_latency =3D=3D CPUFREQ_ETERNAL)
> +		policy->cpuinfo.transition_latency =3D CPUFREQ_DEFAULT_TANSITION_LATEN=
CY_NS;
> +
>  	latency =3D policy->cpuinfo.transition_latency / NSEC_PER_USEC;
>  	if (latency)
>  		/* Give a 50% breathing room between updates */
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 95f3807c8c55..935e9a660039 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -36,6 +36,8 @@
>  /* Print length for names. Extra 1 space for accommodating '\n' in print=
s */
>  #define CPUFREQ_NAME_PLEN		(CPUFREQ_NAME_LEN + 1)
> =20
> +#define CPUFREQ_DEFAULT_TANSITION_LATENCY_NS	NSEC_PER_MSEC
> +
>  struct cpufreq_governor;
> =20
>  enum cpufreq_table_sorting {
>=20

What about the appended (untested) change instead?

With a follow-up one to replace CPUFREQ_ETERNAL with something internal
to CPPC.

=2D--
 Documentation/admin-guide/pm/cpufreq.rst                  |    4 ----
 Documentation/cpu-freq/cpu-drivers.rst                    |    3 +--
 Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst |    3 +--
 Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst |    3 +--
 drivers/cpufreq/cppc_cpufreq.c                            |   14 +++++++++=
+++--
 drivers/cpufreq/cpufreq-dt.c                              |    2 +-
 drivers/cpufreq/imx6q-cpufreq.c                           |    2 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c                     |    2 +-
 drivers/cpufreq/scmi-cpufreq.c                            |    2 +-
 drivers/cpufreq/scpi-cpufreq.c                            |    2 +-
 drivers/cpufreq/spear-cpufreq.c                           |    2 +-
 include/linux/cpufreq.h                                   |    7 ++++---
 12 files changed, 25 insertions(+), 21 deletions(-)

=2D-- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -274,10 +274,6 @@ are the following:
 	The time it takes to switch the CPUs belonging to this policy from one
 	P-state to another, in nanoseconds.
=20
=2D	If unknown or if known to be so high that the scaling driver does not
=2D	work with the `ondemand`_ governor, -1 (:c:macro:`CPUFREQ_ETERNAL`)
=2D	will be returned by reads from this attribute.
=2D
 ``related_cpus``
 	List of all (online and offline) CPUs belonging to this policy.
=20
=2D-- a/Documentation/cpu-freq/cpu-drivers.rst
+++ b/Documentation/cpu-freq/cpu-drivers.rst
@@ -109,8 +109,7 @@ Then, the driver must fill in the follow
 +-----------------------------------+-------------------------------------=
=2D+
 |policy->cpuinfo.transition_latency | the time it takes on this CPU to	   |
 |				    | switch between two frequencies in	   |
=2D|				    | nanoseconds (if appropriate, else	   |
=2D|				    | specify CPUFREQ_ETERNAL)		   |
+|				    | nanoseconds                          |
 +-----------------------------------+-------------------------------------=
=2D+
 |policy->cur			    | The current operating frequency of   |
 |				    | this CPU (if appropriate)		   |
=2D-- a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
+++ b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
@@ -112,8 +112,7 @@ CPUfreq=E6=A0=B8=E5=BF=83=E5=B1=82=E6=B3=A8=E5=86=8C=E4=
=B8=80=E4=B8=AAcpufreq_driv
 |                                   |                                     =
 |
 +-----------------------------------+-------------------------------------=
=2D+
 |policy->cpuinfo.transition_latency | CPU=E5=9C=A8=E4=B8=A4=E4=B8=AA=E9=A2=
=91=E7=8E=87=E4=B9=8B=E9=97=B4=E5=88=87=E6=8D=A2=E6=89=80=E9=9C=80=E7=9A=84=
=E6=97=B6=E9=97=B4=EF=BC=8C=E4=BB=A5  |
=2D|                                   | =E7=BA=B3=E7=A7=92=E4=B8=BA=E5=8D=
=95=E4=BD=8D=EF=BC=88=E5=A6=82=E4=B8=8D=E9=80=82=E7=94=A8=EF=BC=8C=E8=AE=BE=
=E5=AE=9A=E4=B8=BA         |
=2D|                                   | CPUFREQ_ETERNAL=EF=BC=89          =
          |
+|                                   | =E7=BA=B3=E7=A7=92=E4=B8=BA=E5=8D=95=
=E4=BD=8D                    |
 |                                   |                                     =
 |
 +-----------------------------------+-------------------------------------=
=2D+
 |policy->cur                        | =E8=AF=A5CPU=E5=BD=93=E5=89=8D=E7=9A=
=84=E5=B7=A5=E4=BD=9C=E9=A2=91=E7=8E=87(=E5=A6=82=E9=80=82=E7=94=A8)       =
   |
=2D-- a/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
+++ b/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
@@ -112,8 +112,7 @@ CPUfreq=E6=A0=B8=E5=BF=83=E5=B1=A4=E8=A8=BB=E5=86=8A=E4=
=B8=80=E5=80=8Bcpufreq_driv
 |                                   |                                     =
 |
 +-----------------------------------+-------------------------------------=
=2D+
 |policy->cpuinfo.transition_latency | CPU=E5=9C=A8=E5=85=A9=E5=80=8B=E9=A0=
=BB=E7=8E=87=E4=B9=8B=E9=96=93=E5=88=87=E6=8F=9B=E6=89=80=E9=9C=80=E7=9A=84=
=E6=99=82=E9=96=93=EF=BC=8C=E4=BB=A5  |
=2D|                                   | =E7=B4=8D=E7=A7=92=E7=88=B2=E5=96=
=AE=E4=BD=8D=EF=BC=88=E5=A6=82=E4=B8=8D=E9=81=A9=E7=94=A8=EF=BC=8C=E8=A8=AD=
=E5=AE=9A=E7=88=B2         |
=2D|                                   | CPUFREQ_ETERNAL=EF=BC=89          =
          |
+|                                   | =E7=B4=8D=E7=A7=92=E7=88=B2=E5=96=AE=
=E4=BD=8D                    |
 |                                   |                                     =
 |
 +-----------------------------------+-------------------------------------=
=2D+
 |policy->cur                        | =E8=A9=B2CPU=E7=95=B6=E5=89=8D=E7=9A=
=84=E5=B7=A5=E4=BD=9C=E9=A0=BB=E7=8E=87(=E5=A6=82=E9=81=A9=E7=94=A8)       =
   |
=2D-- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -308,6 +308,16 @@ static int cppc_verify_policy(struct cpu
 	return 0;
 }
=20
+static unsigned int get_transition_latency(unsigned int cpu)
+{
+	unsigned int transition_latency_ns =3D cppc_get_transition_latency(cpu);
+
+	if (transition_latency_ns =3D=3D CPUFREQ_ETERNAL)
+		return CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS / NSEC_PER_USEC;
+
+	return transition_latency_ns / NSEC_PER_USEC;
+}
+
 /*
  * The PCC subspace describes the rate at which platform can accept comman=
ds
  * on the shared PCC channel (including READs which do not count towards f=
req
@@ -330,12 +340,12 @@ static unsigned int cppc_cpufreq_get_tra
 			return 10000;
 		}
 	}
=2D	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+	return get_transition_latency(cpu);
 }
 #else
 static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 {
=2D	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+	return get_transition_latency(cpu);
 }
 #endif
=20
=2D-- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -104,7 +104,7 @@ static int cpufreq_init(struct cpufreq_p
=20
 	transition_latency =3D dev_pm_opp_get_max_transition_latency(cpu_dev);
 	if (!transition_latency)
=2D		transition_latency =3D CPUFREQ_ETERNAL;
+		transition_latency =3D CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
=20
 	cpumask_copy(policy->cpus, priv->cpus);
 	policy->driver_data =3D priv;
=2D-- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -442,7 +442,7 @@ soc_opp_out:
 	}
=20
 	if (of_property_read_u32(np, "clock-latency", &transition_latency))
=2D		transition_latency =3D CPUFREQ_ETERNAL;
+		transition_latency =3D CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
=20
 	/*
 	 * Calculate the ramp time for max voltage change in the
=2D-- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -309,7 +309,7 @@ static int mtk_cpufreq_hw_cpu_init(struc
=20
 	latency =3D readl_relaxed(data->reg_bases[REG_FREQ_LATENCY]) * 1000;
 	if (!latency)
=2D		latency =3D CPUFREQ_ETERNAL;
+		latency =3D CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
=20
 	policy->cpuinfo.transition_latency =3D latency;
 	policy->fast_switch_possible =3D true;
=2D-- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -294,7 +294,7 @@ static int scmi_cpufreq_init(struct cpuf
=20
 	latency =3D perf_ops->transition_latency_get(ph, domain);
 	if (!latency)
=2D		latency =3D CPUFREQ_ETERNAL;
+		latency =3D CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
=20
 	policy->cpuinfo.transition_latency =3D latency;
=20
=2D-- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -157,7 +157,7 @@ static int scpi_cpufreq_init(struct cpuf
=20
 	latency =3D scpi_ops->get_transition_latency(cpu_dev);
 	if (!latency)
=2D		latency =3D CPUFREQ_ETERNAL;
+		latency =3D CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
=20
 	policy->cpuinfo.transition_latency =3D latency;
=20
=2D-- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -182,7 +182,7 @@ static int spear_cpufreq_probe(struct pl
=20
 	if (of_property_read_u32(np, "clock-latency",
 				&spear_cpufreq.transition_latency))
=2D		spear_cpufreq.transition_latency =3D CPUFREQ_ETERNAL;
+		spear_cpufreq.transition_latency =3D CPUFREQ_DEFAULT_TRANSITION_LATENCY_=
NS;
=20
 	cnt =3D of_property_count_u32_elems(np, "cpufreq_tbl");
 	if (cnt <=3D 0) {
=2D-- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -26,12 +26,13 @@
  *********************************************************************/
 /*
  * Frequency values here are CPU kHz
=2D *
=2D * Maximum transition latency is in nanoseconds - if it's unknown,
=2D * CPUFREQ_ETERNAL shall be used.
  */
=20
+/* Represents unknown transition latency */
 #define CPUFREQ_ETERNAL			(-1)
+
+#define CPUFREQ_DEFAULT_TANSITION_LATENCY_NS	NSEC_PER_MSEC
+
 #define CPUFREQ_NAME_LEN		16
 /* Print length for names. Extra 1 space for accommodating '\n' in prints =
*/
 #define CPUFREQ_NAME_PLEN		(CPUFREQ_NAME_LEN + 1)






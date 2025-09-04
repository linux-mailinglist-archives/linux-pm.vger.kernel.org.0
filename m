Return-Path: <linux-pm+bounces-33852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4044BB4413A
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 17:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2221CC15AB
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD61281378;
	Thu,  4 Sep 2025 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="EtUj1aF3"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BECD280335;
	Thu,  4 Sep 2025 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001338; cv=none; b=oTra1gq4c9dlTHOj7EIqnKwbpVPTCbnoPReEs3bxK7AtX1CF+xJfc1piHnjSdsejpRI89wNrel11eK3CbIhkyTidGJP9V2ILpuiIBTULHHsGjlulcZbSbae3Y9RZ10CJ2yVmtONUhkp4wMxAgu5tBfqgkgHTEy3LMAkW30OZUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001338; c=relaxed/simple;
	bh=H2o6l74Q+Wze9cr3QOcR1WhRgm/QpQGaTuJu+mYEEP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLZV7iQLl0Y6FuEJlKXXfK9guCHd+eSQGR/vevRHjN2+Li79+2mlXjWeiL2GENQBIrYgWCDHYMCVx2qWOKp6NZFSwe91bZHRa+13DrT6JNR3LH+ULwehgNiKoUSuFZD4YWtjUkDgwLj01zOX1IkgGkyQp8FcnkdxVMb5Ov9ixIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=EtUj1aF3; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=JXBbmbucA/mSoOJjIBHCDzFXAIUYdW9KdILBDaPTQUA=; b=EtUj1aF3Y/qzGo0Tq72hQD09oH
	DzVGDhUARUe+87Q9iNJaGY+WfyFW+wPP7Vw86mFsl46R7WtcpZfi+xfwsx/G5mFUy0Nj5snEaDbIf
	VzHWxvqk2Znrt6Tvj8yu4mv/Hr4843JlrZVMneceSDCeCMEfLyDqYxbEYrKqnNwCJr9MPOEJWFV5r
	MSCyCs4ePLZZ1+CKC5FLSEG+zxJwZlZN/S5RHe7CrniaR2Fd7nyrBSwy2Y5qBUKFQZsyu+o+CsWUj
	FHjdn1QjzA7w+tSo40o+jnG9TdiKCCbpGxZnwIB3rEZlwrmSeNMJ8OWUajrtI3tXCy5W6bfzVgZ9Y
	V976g8jQ==;
Received: from i53875bb9.versanet.de ([83.135.91.185] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uuCJC-00021d-8E; Thu, 04 Sep 2025 17:55:34 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, linux-rockchip@lists.infradead.org,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH] pmdomian: core: don't unset stay_on during sync_state
Date: Thu, 04 Sep 2025 17:55:33 +0200
Message-ID: <878503621.0ifERbkFSE@diego>
In-Reply-To: <117136352.nniJfEyVGO@diego>
References:
 <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
 <117136352.nniJfEyVGO@diego>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 4. September 2025, 17:49:16 Mitteleurop=C3=A4ische Sommerzei=
t schrieb Heiko St=C3=BCbner:
> Hi,
>=20
> Am Dienstag, 2. September 2025, 20:23:04 Mitteleurop=C3=A4ische Sommerzei=
t schrieb Nicolas Frattaroli:
> > This reverts commit de141a9aa52d6b2fbeb63f98975c2c72276f0878.
> >=20
> > On RK3576, the UFS controller's power domain has a quirk that requires
> > it to stay enabled, infrastricture for which was added in Commit
> > cd3fa304ba5c ("pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()").
> >=20
> > Unfortunately, Commit de141a9aa52d ("pmdomain: core: Leave powered-on
> > genpds on until sync_state") appears to break this quirk wholesale. The
> > result is that RK3576 devices with the UFS controller enabled but unused
> > will freeze once pmdomain shuts off unused domains.
> >=20
> > Revert it until a better fix can be found.
> >=20
> > Fixes: de141a9aa52d ("pmdomain: core: Leave powered-on genpds on until =
sync_state")
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>=20
> just an observation independent of the conversation in the other thread.
> This patch/revert whatever fixes an actual issue for me.

ah and just saw Nicolas' mail from 6 minutes earlier.

So I guess what saves me here is the rocket driver being built as a
module, power-domain getting turned off early, rocket probes with
pd off and then gets its supplies as expected.


Heiko


>=20
> On the rk3588 the NPU power-domains are a hirarchy of
>=20
> PD_NPU
> 	PD_NPUTOP (core0)
> 		PD_NPU1 (core1)
> 		PD_NPU2 (core2)
>=20
> and the PD_NPU does need a supply regulator.
>=20
> (1) With "just" v6.17-rc + the rocket driver probing and then idling, I g=
et:
>=20
> # cat /sys/kernel/debug/regulator/regulator_summary
>  regulator                      use open bypass  opmode voltage current  =
   min     max
> -------------------------------------------------------------------------=
=2D-------------
>  dc_12v                           4    3      0 unknown 12000mV     0mA 1=
2000mV 12000mV=20
> [...]
>     vcc5v0_baseboard              2    1      0 unknown  5000mV     0mA  =
5000mV  5000mV=20
>        vcc5v0_sys                18   18      0 unknown  5000mV     0mA  =
5000mV  5000mV=20
> [...]
>           vdd_npu_s0              0    0      0  normal   800mV     0mA  =
 550mV   950mV=20
>           vcc_1v2_s3              2    1      0 unknown  1200mV     0mA  =
1200mV  1200mV=20
>              fe1b0000.ethernet-phy   1                                 0m=
A     0mV     0mV
>           vdd_gpu_s0              1    2      0  normal   675mV     0mA  =
 550mV   950mV=20
>              fb000000.gpu-mali    1                                 0mA  =
 675mV   850mV
>              fd8d8000.power-management:power-controller-domain   0       =
                          0mA     0mV     0mV
> [...]
>=20
> #  cat /sys/kernel/debug/pm_genpd/pm_genpd_summary=20
> domain                          status          children        performan=
ce
>     /device                         runtime status                  manag=
ed by
> -------------------------------------------------------------------------=
=2D----
> [...]
> gpu                             off-0                           0
>     fb000000.gpu                    suspended                   0        =
   SW
> npu2                            off-0                           0
>     fdada000.iommu                  suspended                   0        =
   SW
>     fdad0000.npu                    suspended                   0        =
   SW
> npu1                            off-0                           0
>     fdaca000.iommu                  suspended                   0        =
   SW
>     fdac0000.npu                    suspended                   0        =
   SW
> nputop                          off-0                           0
>                                                 npu1, npu2
>     fdab9000.iommu                  suspended                   0        =
   SW
>     fdab0000.npu                    suspended                   0        =
   SW
> npu                             on                              0
>                                                 nputop
>=20
> Observe that the PD_NPU never got its regulator and the domain also
> never actually gets turned off. While the domains directly attached to
> the cores get turned off.
>=20
>=20
> (2) with Nicolas's patch applied on top, I get the correct behaviour,
> that was also happening with v6.16 before
>=20
> # cat /sys/kernel/debug/regulator/regulator_summary
>  regulator                      use open bypass  opmode voltage current  =
   min     max
> -------------------------------------------------------------------------=
=2D-------------
>  dc_12v                           4    3      0 unknown 12000mV     0mA 1=
2000mV 12000mV=20
> [...]
>     vcc5v0_baseboard              2    1      0 unknown  5000mV     0mA  =
5000mV  5000mV=20
>        vcc5v0_sys                18   18      0 unknown  5000mV     0mA  =
5000mV  5000mV=20
> [...]
>           vdd_npu_s0              0    1      0  normal   800mV     0mA  =
 550mV   950mV=20
>              fd8d8000.power-management:power-controller-domain   0       =
                          0mA     0mV     0mV
>           vdd_cpu_big1_s0         2    1      0  normal  1000mV     0mA  =
 550mV  1050mV=20
>              cpu6-cpu             1                                 0mA  =
1000mV  1000mV
>           vdd_gpu_s0              1    2      0  normal   675mV     0mA  =
 550mV   950mV=20
>              fb000000.gpu-mali    1                                 0mA  =
 675mV   850mV
>              fd8d8000.power-management:power-controller-domain   0       =
                          0mA     0mV     0mV
> [...]
>=20
> # cat /sys/kernel/debug/pm_genpd/pm_genpd_summary=20
> domain                          status          children        performan=
ce
>     /device                         runtime status                  manag=
ed by
> -------------------------------------------------------------------------=
=2D----
> [...]
> gpu                             off-0                           0
>     fb000000.gpu                    suspended                   0        =
   SW
> npu2                            off-0                           0
>     fdada000.iommu                  suspended                   0        =
   SW
>     fdad0000.npu                    suspended                   0        =
   SW
> npu1                            off-0                           0
>     fdaca000.iommu                  suspended                   0        =
   SW
>     fdac0000.npu                    suspended                   0        =
   SW
> nputop                          off-0                           0
>                                                 npu1, npu2
>     fdab9000.iommu                  suspended                   0        =
   SW
>     fdab0000.npu                    suspended                   0        =
   SW
> npu                             off-0                           0
>                                                 nputop
>=20
> The regulator handling is working correctly and also the parent PD_NPU
> domain gets turned off when its children are off.
>=20
>=20
> Heiko
>=20






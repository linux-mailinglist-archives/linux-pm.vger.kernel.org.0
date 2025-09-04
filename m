Return-Path: <linux-pm+bounces-33850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6287BB440FC
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 17:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085CD1CC09F7
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D300212574;
	Thu,  4 Sep 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="tKBcXIo/"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F221ADCB;
	Thu,  4 Sep 2025 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000970; cv=none; b=ssV93AO1xSDddBWeB+XTqXAwBg+M0LXLmZI4dXj/kLfF2Ts9MZkwpPCQlrET/c5qFUCVFXYxk8RWz2q3W9gXXCbvod7ECFgvtp7358LGlZn+26gzGZsG36Xuc7DYpPDaOoKxN4NbbOB57HM3nDdpuiUefQ+T+Y7LimfZoRFQNco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000970; c=relaxed/simple;
	bh=7dpUkBfHGQyW3m9m8tIOE3VxsaEBNoAMwpTgufYdNNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGJoQEy3FBPnIN8ibWiK18vzF6M/PPxM2cMVOiwBHAuHpuqkmGrlDDKjQ7fKBdCFhRRzMkPixj4Nlq5+QQrAJHS6Rt63hKC5psmJuCTc6udSd9CGU2yYpaHDAb9i0H5fi6vYtUEvijBesm9fDW/WNNi84c8q/gnDcFkPnzaLdng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=tKBcXIo/; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=XYh+pZ0ydjTT94jg1/0pqmUjG8A4r6oEnz4JTByybdg=; b=tKBcXIo/ChuSMx9/OxQSUTwFPb
	glh44Cizftyzd+ebSE2FtAFPBagLvp8t+WT+FkSYRVLMMJmBqqyzORqBvdpsQ/wrSwJQC2z3EamEK
	3gcQNrKCVB7mG9sUWOolk3FObAdQYsyuhW4RQKiCmguooJ+ucWUEKy0RcQhBHJFSK6pqmeoO9HVuZ
	WNIBtG6Qk4k5QNdk9yfkek7XHT7ILDlml55AMZIXNMyFFWmkEyppiVb/GYOP0IHrsi3yjVNeWAUVK
	JgsX61o4h4FifFBuv5crtnMR9X6JFTapZbmiaw0XGu9kjJi3VkERC13YVM6BxrZvxdl2QG2yfoU+p
	EHnQu5SA==;
Received: from i53875bb9.versanet.de ([83.135.91.185] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uuCD7-0008Mm-3T; Thu, 04 Sep 2025 17:49:17 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, linux-rockchip@lists.infradead.org,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH] pmdomian: core: don't unset stay_on during sync_state
Date: Thu, 04 Sep 2025 17:49:16 +0200
Message-ID: <117136352.nniJfEyVGO@diego>
In-Reply-To:
 <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
References:
 <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Dienstag, 2. September 2025, 20:23:04 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Nicolas Frattaroli:
> This reverts commit de141a9aa52d6b2fbeb63f98975c2c72276f0878.
>=20
> On RK3576, the UFS controller's power domain has a quirk that requires
> it to stay enabled, infrastricture for which was added in Commit
> cd3fa304ba5c ("pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()").
>=20
> Unfortunately, Commit de141a9aa52d ("pmdomain: core: Leave powered-on
> genpds on until sync_state") appears to break this quirk wholesale. The
> result is that RK3576 devices with the UFS controller enabled but unused
> will freeze once pmdomain shuts off unused domains.
>=20
> Revert it until a better fix can be found.
>=20
> Fixes: de141a9aa52d ("pmdomain: core: Leave powered-on genpds on until sy=
nc_state")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

just an observation independent of the conversation in the other thread.
This patch/revert whatever fixes an actual issue for me.

On the rk3588 the NPU power-domains are a hirarchy of

PD_NPU
	PD_NPUTOP (core0)
		PD_NPU1 (core1)
		PD_NPU2 (core2)

and the PD_NPU does need a supply regulator.

(1) With "just" v6.17-rc + the rocket driver probing and then idling, I get:

# cat /sys/kernel/debug/regulator/regulator_summary
 regulator                      use open bypass  opmode voltage current    =
 min     max
=2D------------------------------------------------------------------------=
=2D-------------
 dc_12v                           4    3      0 unknown 12000mV     0mA 120=
00mV 12000mV=20
[...]
    vcc5v0_baseboard              2    1      0 unknown  5000mV     0mA  50=
00mV  5000mV=20
       vcc5v0_sys                18   18      0 unknown  5000mV     0mA  50=
00mV  5000mV=20
[...]
          vdd_npu_s0              0    0      0  normal   800mV     0mA   5=
50mV   950mV=20
          vcc_1v2_s3              2    1      0 unknown  1200mV     0mA  12=
00mV  1200mV=20
             fe1b0000.ethernet-phy   1                                 0mA =
    0mV     0mV
          vdd_gpu_s0              1    2      0  normal   675mV     0mA   5=
50mV   950mV=20
             fb000000.gpu-mali    1                                 0mA   6=
75mV   850mV
             fd8d8000.power-management:power-controller-domain   0         =
                        0mA     0mV     0mV
[...]

#  cat /sys/kernel/debug/pm_genpd/pm_genpd_summary=20
domain                          status          children        performance
    /device                         runtime status                  managed=
 by
=2D------------------------------------------------------------------------=
=2D----
[...]
gpu                             off-0                           0
    fb000000.gpu                    suspended                   0          =
 SW
npu2                            off-0                           0
    fdada000.iommu                  suspended                   0          =
 SW
    fdad0000.npu                    suspended                   0          =
 SW
npu1                            off-0                           0
    fdaca000.iommu                  suspended                   0          =
 SW
    fdac0000.npu                    suspended                   0          =
 SW
nputop                          off-0                           0
                                                npu1, npu2
    fdab9000.iommu                  suspended                   0          =
 SW
    fdab0000.npu                    suspended                   0          =
 SW
npu                             on                              0
                                                nputop

Observe that the PD_NPU never got its regulator and the domain also
never actually gets turned off. While the domains directly attached to
the cores get turned off.


(2) with Nicolas's patch applied on top, I get the correct behaviour,
that was also happening with v6.16 before

# cat /sys/kernel/debug/regulator/regulator_summary
 regulator                      use open bypass  opmode voltage current    =
 min     max
=2D------------------------------------------------------------------------=
=2D-------------
 dc_12v                           4    3      0 unknown 12000mV     0mA 120=
00mV 12000mV=20
[...]
    vcc5v0_baseboard              2    1      0 unknown  5000mV     0mA  50=
00mV  5000mV=20
       vcc5v0_sys                18   18      0 unknown  5000mV     0mA  50=
00mV  5000mV=20
[...]
          vdd_npu_s0              0    1      0  normal   800mV     0mA   5=
50mV   950mV=20
             fd8d8000.power-management:power-controller-domain   0         =
                        0mA     0mV     0mV
          vdd_cpu_big1_s0         2    1      0  normal  1000mV     0mA   5=
50mV  1050mV=20
             cpu6-cpu             1                                 0mA  10=
00mV  1000mV
          vdd_gpu_s0              1    2      0  normal   675mV     0mA   5=
50mV   950mV=20
             fb000000.gpu-mali    1                                 0mA   6=
75mV   850mV
             fd8d8000.power-management:power-controller-domain   0         =
                        0mA     0mV     0mV
[...]

# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary=20
domain                          status          children        performance
    /device                         runtime status                  managed=
 by
=2D------------------------------------------------------------------------=
=2D----
[...]
gpu                             off-0                           0
    fb000000.gpu                    suspended                   0          =
 SW
npu2                            off-0                           0
    fdada000.iommu                  suspended                   0          =
 SW
    fdad0000.npu                    suspended                   0          =
 SW
npu1                            off-0                           0
    fdaca000.iommu                  suspended                   0          =
 SW
    fdac0000.npu                    suspended                   0          =
 SW
nputop                          off-0                           0
                                                npu1, npu2
    fdab9000.iommu                  suspended                   0          =
 SW
    fdab0000.npu                    suspended                   0          =
 SW
npu                             off-0                           0
                                                nputop

The regulator handling is working correctly and also the parent PD_NPU
domain gets turned off when its children are off.


Heiko




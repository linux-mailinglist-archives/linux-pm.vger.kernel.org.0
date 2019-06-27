Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0097658A0B
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 20:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfF0Sdd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 14:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfF0Sdd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Jun 2019 14:33:33 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F6C820644;
        Thu, 27 Jun 2019 18:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561660412;
        bh=x8Yj6zbtV5AdouyL8wA6d+fGrA1EuOigCtZuHz9sTi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/bpIG868+e4sdRL9DMHjm+fOumUDfzWu6dptYgxK9gceUPjdCqWNhwX82s7U1Qvv
         Rx8Qv5OJwROl1i6QuNLOg7iKho5zj51P48n5bkkAge1T9tap4uU4eIUMvc0CtCJbnF
         USc7cnoDRkD+r8poYwvcwLVQqaTC4uPEMprLncfY=
Received: by earth.universe (Postfix, from userid 1000)
        id 3FA8C3C08D5; Thu, 27 Jun 2019 20:33:30 +0200 (CEST)
Date:   Thu, 27 Jun 2019 20:33:30 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Han Nandor <nandor.han@vaisala.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] Use NVMEM as reboot-mode write interface
Message-ID: <20190627183330.aole6zumw3l2vyet@earth.universe>
References: <20190515104658.25535-1-nandor.han@vaisala.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oelnsnnwwn2ytluu"
Content-Disposition: inline
In-Reply-To: <20190515104658.25535-1-nandor.han@vaisala.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oelnsnnwwn2ytluu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 15, 2019 at 10:47:14AM +0000, Han Nandor wrote:
> Description
> -----------
> Extend the reboot mode driver to use a NVMEM cell as writing interface.
>=20
> Testing
> -------
> The testing is done by configuring DT from a custom board.
> The NVMEM cell is configured in an RTC non-volatile memory.
> Kernel: 4.14.60 (the patchset was rebased on kernel master)
>=20
> DT configurations:
> `
> ...
> reboot-mode-nvmem@0 {
>     compatible =3D "simple-mfd";
>     reboot-mode {
>         compatible =3D "nvmem-reboot-mode";
>         nvmem-cells =3D <&reboot_mode>;
>         nvmem-cell-names =3D "reboot-mode";
>=20
>         mode-test       =3D <0x21969147>;
>     };
> };
> ...
> reboot_mode: nvmem_reboot_mode@0 {
>         reg =3D <0x00 0x4>;
> };
> ...
> `
>=20
> 1. Reboot the system using the command `reboot test`
>=20
> 2. Verify that kernel logs show that reboot was done in mode `test`:
> PASS
> `[  413.957172] reboot: Restarting system with command 'test' `
>=20
> 3. Stop in U-Boot and verify that mode `test` magic value is present
> in RTCs non-volatile memory: PASS
>=20
> Kernel: 5.1.0-rc3
>=20
> 1. Configure `arch/arm/configs/imx_v6_v7_defconfig` to contain=20
> `CONFIG_NVMEM_REBOOT_MODE=3Dy`
> 2. Verify that Kernel compiles successful: PASS
> `
> make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnu- imx_v6_v7_defconfig zImage
> ...
> CC      drivers/power/reset/nvmem-reboot-mode.o
> ...
> Kernel: arch/arm/boot/zImage is ready
> `
> Changes since v1:
> -----------------
>  - split the documentation on a separate patch
>  - add a missing header
>=20
> Changes since v2:
> ----------------
>  - change the module license to GPL since GPL v2 is deprecated
>=20
> Changes since v3:
> ----------------
>  - documentation updated according to the comments

Thanks, queued. Please fix your git/mail setup, I had to fix the
line endings (\r\n -> \n) to apply this.

-- Sebastian

--oelnsnnwwn2ytluu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl0VC/oACgkQ2O7X88g7
+poTJRAAk2T33ox4H9f695WRdSpVuZjgdJfRsyNVYrMVpd0NwDgt5CfSFtpQ7Lub
c5BDpY/LMnOH6HbcQipgW343roX4QpYhz6kwbbk2XSdfam8uuchgMtNDQqwDFNY3
zQ9PMWNKK0eECbnJqa6E825/KQPrvXHQsu0D5irtD5DtPXBizr43yfhRv2EEACBa
fnMU1XSOVVgvhWk/jpFD+mbfmVGct9YYG40yxj6migvNd9Im9soIXP6bjhQieuue
5heq3SNkCSJzAV0yw0JHHDqQq/6zChB4gqv6B1yQ9mRKY6s3Ejnkug29HCXipuZI
r1RO+U9p56PD36JW43JbECAGyz7zqnb13mcNXFBULDkjgURDOXuOWZVA1Ot2HDq2
qva4h5F/hhYc5D9o/nJ220+D+jxDXu7P9qVg1IUEXweojoWSZEJu62nnEjgVQYnE
r/AIsvZE7z3o8DfgnLpM1vq5rQKasOPN58rJOCB7yC993eIZob8IPl3c/D7llkSj
JIGb4Kg/vP7NtCHES7x87p37RTsih7pCBrfOvPt8369s7BkqRcmLTH8a5vm4TREa
y2jztX0f+n/qaGz1GkCqZ4+s1hOLOjyhX+f6ViFSNQUvkTuy9kgVZDeIn2hCbNA4
qlJI30TEH2cu+Hk8Bxc0vegYjCLtdB+C4l+MmUy+wRDx3SEryiU=
=8+eb
-----END PGP SIGNATURE-----

--oelnsnnwwn2ytluu--

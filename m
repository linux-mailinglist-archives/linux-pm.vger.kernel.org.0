Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB20222FCCA
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 01:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgG0XPC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 19:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgG0XPC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jul 2020 19:15:02 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FE5B20729;
        Mon, 27 Jul 2020 23:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595891701;
        bh=v8ts5ptfBblDrLfpJLr7TpypfwC1w1Y5XMee7bF/txE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oS8lm+/yZhJTf0FBaXIBqH7uMqfHQlZ+i3nt9fI+tIdq83DbDJpsRhO3/m1OuA0GZ
         5kiJD3SJkPIY9qVcm4I1a2pTjE23lMm7wjHprNbXdVev5ufTzAKFfiGX3JSHwiiL95
         gIFVdehazw5wYmw3R61KxR+MqSXd6xgQgTbAASRM=
Received: by earth.universe (Postfix, from userid 1000)
        id 699AB3C0B87; Tue, 28 Jul 2020 01:14:59 +0200 (CEST)
Date:   Tue, 28 Jul 2020 01:14:59 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chen Yongzhi <yongzhi.chen@unisoc.com>
Subject: Re: [PATCH v2 0/2] fix an overflow error on sc27xx power supply
Message-ID: <20200727231459.6gbmii5hfzcqsmm7@earth.universe>
References: <20200724122148.26541-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p6xj2pjprdkhghgi"
Content-Disposition: inline
In-Reply-To: <20200724122148.26541-1-zhang.lyra@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--p6xj2pjprdkhghgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 24, 2020 at 08:21:46PM +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>=20
> The patch 2/2 fixes an overflow error by changing to 64-bit divide operat=
ions.
> In order to avoid compile error on 32-bit architectures, this patchset
> also introduced a new 64-bit helper in patch 1/2.
>=20
> Changes since v1: (https://lkml.org/lkml/2020/7/17/63)
> - Added new help macro DIV_S64_ROUND_CLOSEST;
> - Fixed an error reported by kernel test robot <lkp@intel.com>.
>=20
> Chunyan Zhang (2):
>   math64: New DIV_S64_ROUND_CLOSEST helper
>   power: supply: sc27xx: prevent adc * 1000 from overflow
>=20
>  drivers/power/supply/sc27xx_fuel_gauge.c |  9 +++++----
>  include/linux/math64.h                   | 19 +++++++++++++++++++
>  2 files changed, 24 insertions(+), 4 deletions(-)

Thanks, queued.

-- Sebastian

--p6xj2pjprdkhghgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8fX+0ACgkQ2O7X88g7
+poVyg/6A2sloOske+Qb+S6kOWpcOP3Z4gJI7kEouDSwP/s1A9GpXZbOsAgd3RwY
nUBBtAXj1sR3eddebA4fqDTFNDH/HrvceCNWU7kwWEq1/5If2rnW7/vin4ZOZE3D
dZ/KgItuFvZMEuE7ikSNY0L2Eh8iMdWgRRx0bKEoNff2tvschFdIpmwgVrb2gSzu
h08ETfoyF8y5MZj0wZUJ4tKTbnUozB1g3yxp6HrYv4V3kFOOH+jdEq6LmANjuGVw
T04E9GCX0NQ4rz7VNRyFRYG5OfTk/0ig02r32BNpDu+OJtGW6e96xkYui0iY0ZYI
o9qu8zKqa6jK/LbkFvH8mtEFpWdC6xhtie00t4JHThUhAFyIRzAOALybqQ+OM1E/
N84u91MMzum4lgYT05Mr2xTEPGw6tl+SloEEgQS0ar1QoSUL7BSC3vxR2oStoA+v
UPHXc3lN8oa3FjGaClBq7lCNRfb7+SghX6IOn7oyqZZ+XUO2HGklagPHQ9hsEqHE
ImaM1kisuCTT4wB0gCLNgjwdhDeZVeG5Q+GxYhxCgedChA0MSAbQya+WOtmG2SqY
6n/jgILSC1qPZqs+9yARZqslUPTRnnmZliIzqfsfc2ItQ08Ki7tTf5uOKUk7WdnB
dYESNYPCljuBH1osmwmAOtQDHv2nITdR08rQU65k2ttfFeqIp6U=
=4KPr
-----END PGP SIGNATURE-----

--p6xj2pjprdkhghgi--

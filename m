Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8FB1E6F59
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 00:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437076AbgE1WoM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 18:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437279AbgE1WoK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 May 2020 18:44:10 -0400
Received: from earth.universe (dyndsl-095-033-156-068.ewe-ip-backbone.de [95.33.156.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C88720721;
        Thu, 28 May 2020 22:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590705850;
        bh=Of5qUS3iNNYn924FnJ7Bx2pbtxirKh2MJA2vT9aP9lY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ddkZuwXVe27DsXGWGbCeIgI2/VifW2NWwIBlSNGfi6UBSPXuwKiu2pgSwH4tKK+pJ
         ZQGcjwYDXL0Jr2mfqeksQz/JnFE9WfpQe9viNu/ySc/CJ0ziiLKt6zDnNMZUA030iC
         v1F10TzRGZIlBqGp030eqpLduipe7ajSpztNuUfY=
Received: by earth.universe (Postfix, from userid 1000)
        id 59CDF3C08C7; Fri, 29 May 2020 00:44:08 +0200 (CEST)
Date:   Fri, 29 May 2020 00:44:08 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv1 00/19] Improve SBS battery support
Message-ID: <20200528224408.4fo44kdjoqekpnpn@earth.universe>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kq3ssriyb4k4re57"
Content-Disposition: inline
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kq3ssriyb4k4re57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I queued this series to power-supply's for-next branch.

-- Sebastian

On Wed, May 13, 2020 at 08:55:56PM +0200, Sebastian Reichel wrote:
> This patchset improves support for SBS compliant batteries. Due to
> the changes, the battery now exposes 32 power supply properties and
> (un)plugging it generates a backtrace containing the following message
> without the first patch in this series:
>=20
> ---------------------------
> WARNING: CPU: 0 PID: 20 at lib/kobject_uevent.c:659 add_uevent_var+0xd4/0=
x104
> add_uevent_var: too many keys
> ---------------------------
>=20
> For references this is what an SBS battery status looks like after
> the patch series has been applied:
>=20
> cat /sys/class/power_supply/sbs-0-000b/uevent=20
> POWER_SUPPLY_NAME=3Dsbs-0-000b
> POWER_SUPPLY_TYPE=3DBattery
> POWER_SUPPLY_STATUS=3DDischarging
> POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
> POWER_SUPPLY_HEALTH=3DGood
> POWER_SUPPLY_PRESENT=3D1
> POWER_SUPPLY_TECHNOLOGY=3DLi-ion
> POWER_SUPPLY_CYCLE_COUNT=3D12
> POWER_SUPPLY_VOLTAGE_NOW=3D11441000
> POWER_SUPPLY_CURRENT_NOW=3D-26000
> POWER_SUPPLY_CURRENT_AVG=3D-24000
> POWER_SUPPLY_CAPACITY=3D76
> POWER_SUPPLY_CAPACITY_ERROR_MARGIN=3D1
> POWER_SUPPLY_TEMP=3D198
> POWER_SUPPLY_TIME_TO_EMPTY_AVG=3D438600
> POWER_SUPPLY_TIME_TO_FULL_AVG=3D3932100
> POWER_SUPPLY_SERIAL_NUMBER=3D0000
> POWER_SUPPLY_VOLTAGE_MIN_DESIGN=3D10800000
> POWER_SUPPLY_VOLTAGE_MAX_DESIGN=3D10800000
> POWER_SUPPLY_ENERGY_NOW=3D31090000
> POWER_SUPPLY_ENERGY_FULL=3D42450000
> POWER_SUPPLY_ENERGY_FULL_DESIGN=3D41040000
> POWER_SUPPLY_CHARGE_NOW=3D2924000
> POWER_SUPPLY_CHARGE_FULL=3D3898000
> POWER_SUPPLY_CHARGE_FULL_DESIGN=3D3800000
> POWER_SUPPLY_CONSTANT_CHARGE_CURRENT_MAX=3D3000000
> POWER_SUPPLY_CONSTANT_CHARGE_VOLTAGE_MAX=3D12300000
> POWER_SUPPLY_MANUFACTURE_YEAR=3D2017
> POWER_SUPPLY_MANUFACTURE_MONTH=3D7
> POWER_SUPPLY_MANUFACTURE_DAY=3D3
> POWER_SUPPLY_MANUFACTURER=3DUR18650A
> POWER_SUPPLY_MODEL_NAME=3DGEHC
>=20
> -- Sebastian
>=20
> Jean-Francois Dagenais (1):
>   power: supply: sbs-battery: add ability to disable charger broadcasts
>=20
> Sebastian Reichel (18):
>   kobject: increase allowed number of uevent variables
>   power: supply: core: add capacity error margin property
>   power: supply: core: add manufacture date properties
>   power: supply: core: add POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED
>   power: supply: sbs-battery: Add TI BQ20Z65 support
>   power: supply: sbs-battery: add
>     POWER_SUPPLY_PROP_CAPACITY_ERROR_MARGIN support
>   power: supply: sbs-battery: simplify read_read_string_data
>   power: supply: sbs-battery: add PEC support
>   power: supply: sbs-battery: add POWER_SUPPLY_PROP_CURRENT_AVG support
>   power: supply: sbs-battery: Improve POWER_SUPPLY_PROP_TECHNOLOGY
>     support
>   power: supply: sbs-battery: add
>     POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT/VOLTAGE_MAX support
>   power: supply: sbs-battery: add MANUFACTURE_DATE support
>   power: supply: sbs-battery: add
>     POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED support
>   power: supply: sbs-battery: fix idle battery status
>   power: supply: sbs-battery: switch from of_property_* to
>     device_property_*
>   power: supply: sbs-battery: switch to i2c's probe_new
>   power: supply: sbs-battery: constify power-supply property array
>   dt-bindings: power: sbs-battery: Convert to yaml
>=20
>  Documentation/ABI/testing/sysfs-class-power   |  45 ++-
>  .../power/supply/sbs,sbs-battery.yaml         |  83 +++++
>  .../bindings/power/supply/sbs_sbs-battery.txt |  27 --
>  drivers/power/supply/power_supply_sysfs.c     |   5 +
>  drivers/power/supply/sbs-battery.c            | 348 +++++++++++++-----
>  include/linux/kobject.h                       |   2 +-
>  include/linux/power_supply.h                  |   5 +
>  7 files changed, 404 insertions(+), 111 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sb=
s-battery.yaml
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sb=
s-battery.txt
>=20
> --=20
> 2.26.2
>=20

--kq3ssriyb4k4re57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7QPq0ACgkQ2O7X88g7
+pqduw//X98/LG8aTNRLOt8MjdJhqNI1GdcnfavsVOnT5Tec9ZPRqxaqpvdOkmHD
R2lQ0FUaiTJTRp7bW/PsQK9iz8nVcSp4P8WMvqeazhOzvkMFtdWinCoThlUm994w
QblthPhHT334gBQ2kP9vqXYHM/vwsBVEydJoUJtaMb5n83cgdyp6Kb393x1IGNPG
jCTUGT+NXYwFSkCZuSi0EAtGGD6s6nkAsgxx85Ta46en9ByOngAAqKQo0uwjYPl4
osYWtH0aXrQ2n/uV8Rxfy4GoPu1iEZ13WaThU2pzc5iQiz2PLpOLEMgf9oRTwS7v
Abo6SDBFvlaZQaCCWgpHEUCj4tQWckzMrXb6sp6YVMKm/5DE7hLOoNNwLvp3U/S+
M4B7bFsAlrez6sTIOQ56ORN+gV3I649Opz4lWIvSl4diRSGz1rdCGXawKTJYb2rd
ZHZZSi5lZUm52/mPkOEH4SgJixfD2sdW4Dksvug341NuLJ0mw49LqTm+p0eCa4Lt
a2tp0zEgIZ2k59hHkgQA33ifVsT941YK21TLcF2LTpjuFqlfrN0Ge3nF64w99FMh
0EjMrDUJpzGwr+/6KDoSCQAk3W+a5df7BFYzdzWp9iD+5pylpliB/WetUDCkQ3oP
hGNPvE5hXR544iBvr+fUeDUFc/9X7zOjQXh6jTqq9qiT5JVst+Y=
=tJEb
-----END PGP SIGNATURE-----

--kq3ssriyb4k4re57--

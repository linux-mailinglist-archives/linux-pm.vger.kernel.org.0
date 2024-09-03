Return-Path: <linux-pm+bounces-13496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B581C96ABB6
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 00:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E14C28BF9D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 22:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2131D7991;
	Tue,  3 Sep 2024 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZVFel7s"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14811D798E;
	Tue,  3 Sep 2024 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401067; cv=none; b=hy1Jvrgwx/a4CXeiniFdM3Rc5u3lzXOOQJBjHXDuz1ygxoRm50rS9n2+784y4OXtG/YObiH0g3xaf1YxwRUzRUriVivEspVsTrRQtL35fK2rac/Nv2DjcV2Tqq3KFMW6/T20OI+ERYtVWsPRPWczU1gzBjLUUuPlPP2HwvOMkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401067; c=relaxed/simple;
	bh=IAvJFDh2rktQgabsaLMqmIoVmG1fDxEHEeTpxxDd4fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndLCvuTaR8eupz9Yp6QoZFYnK+0nvabsqGCusTXJu1QM7xOooGlHkeySWCl7aH58UNDrfgkhPF3Dk4BKWkemuoP0lM81Oz5jPHtmafaUMVUjjxh23030GU5hdgoiVw3zfmCAPO/4Zmc/eiDZ4AgpSnTxh6YXGw4DT6g0fNq8n0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZVFel7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBAFC4CEC4;
	Tue,  3 Sep 2024 22:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725401067;
	bh=IAvJFDh2rktQgabsaLMqmIoVmG1fDxEHEeTpxxDd4fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZVFel7sc4ORVEYeqJUFAWe6zXuPUP9WRuhGgQQQurfxOx8LP+Kp6IIs0TJGhd2sF
	 uKHU1bAoQpA3hpMUZkE5By8Mgx9EsCQ+ReZ1As4GFio3VVPznZyRZxhOYTaKq3UrlS
	 cvlEXDLTVN/dQ56Z02bvpIbmexfXWYBDzefn/xLcoPOd4XB3LFnzW9uAaiR+w2fwoG
	 YdFqzesSrvi76CrVMEYCqku1CIilAckaq/rWx7IF0uyWvUgAcrMpEJkVQmHEUfCwtQ
	 98AjTEQkmwkmVfxmYCrFyIBVmDwmXtrMzo5OnxqRJsNXueTXt/86rq0aevZiVyPpxd
	 KrtcRkShsmxOQ==
Received: by mercury (Postfix, from userid 1000)
	id D2A63106044E; Wed, 04 Sep 2024 00:04:24 +0200 (CEST)
Date: Wed, 4 Sep 2024 00:04:24 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Enric Balletbo Serra <enric.balletbo@collabora.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-phy@lists.infradead.org
Subject: Re: [PATCH 0/6] power: supply: Change usb_types from an array into a
 bitmask
Message-ID: <ez5ja55dl7w7ynq2wv4efsvvqtk4xyalf4k6agtsuhpgrtlpg3@d6ghlle4cu2q>
References: <20240831142039.28830-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="btzqktsiaq62mw5e"
Content-Disposition: inline
In-Reply-To: <20240831142039.28830-1-hdegoede@redhat.com>


--btzqktsiaq62mw5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 31, 2024 at 04:20:33PM GMT, Hans de Goede wrote:
> When support for the "charge_behaviour" property was added the list of
> available values was made a bitmask in power_supply_desc.
>=20
> "usb_types" is very similar in that:
> 1. It is an enum
> 2. The list of available values is stored in power_supply_desc
> 3. When shown it shows all available values, with the active one surround=
ed
>    by square brackets.
>=20
> But "usb_types" uses an array with valid enum values instead of a bitmask.
> This uses more memory then the bitmap approach and it makes it impossible
> to have a shared generic show() function for properties which show
> available values, with the active one surrounded by square brackets.
>=20
> This patch-set moves "usb_types" over to a bitmask in power_supply_desc
> to indicate the available values.
>=20
> Patches 1 - 3:
>=20
> It turns out that the ucs1002-power driver contained a surprise in that
> it supports writing to "usb_type" even though the ABI doc says it is
> read-only. Since we cannot break shipped userspace API, the ship has sail=
ed
> on this one. The first patch documents that writing "usb_type" is allowed,
> but only for power-supply devices which provide USB power rather then
> consume it.
>=20
> Enum properties accept writing the FOO_TEXT[] string values, passing
> the enum value matching the FOO_TEXT entry to set_property(), the second
> patch adjusts ucs1002_set_usb_type() to directly accept enum values.
>=20
> The rt9467 driver was another driver which allowed writing to "usb_type"
> but there the use made no sense, so it is simply dropped.
>=20
> Patches 4 - 6:
>=20
> These patches implement the actual moving of usb_types to a bitmask.
>=20
> Patch 6 is a bit of a bigbang patch moving all drivers over in one go,
> touching a couple of drivers outside drivers/power/supply: 1 in
> drivers/extcon/ 1 in drivers/phy/ and 5 in drivers/usb/typec/ since
> the changes outside of drivers/power/supply are small I've chosen to
> make all the changes in one go rather then have some sort of
> intermediate state where both ways are supported.
>=20
> For merging this I believe it would be best for an immutable branch / tag
> to be created on the linux-power-supply tree and then send a pull-request
> to the extcon, phy and usb-typec maintainers to merge the tag.
>=20
> extcon, phy and typec maintainers can you please give your Acked-by for
> patch 6/6 for merging these changes through the linux-power-supply tree?
>=20
> This set is based on top of the latest linux-power-supply/for-next.

As we are quite close before the merge window I just took it with
just the Ack from Greg. The changes in PHY and Extcon are quite
small. I did prepare an immutable branch in case it is needed by
any of the other involved trees:

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/ib-psy-usb-types-signed

for you to fetch changes up to 364ea7ccaef917a3068236a19a4b31a0623b561a:

  power: supply: Change usb_types from an array into a bitmask (2024-09-03 =
23:20:28 +0200)

----------------------------------------------------------------
Immutable branch for usb_types change for v6.12

Changing usb_types type from array to bitmap in the power_supply_desc
struct requires updating power-supply drivers living in different
subsystem, so it is handled via an immutable branch.

----------------------------------------------------------------
Hans de Goede (6):
      power: supply: "usb_type" property may be written to
      power: supply: ucs1002: Adjust ucs1002_set_usb_type() to accept strin=
g values
      power: supply: rt9467-charger: Remove "usb_type" property write suppo=
rt
      power: supply: sysfs: Add power_supply_show_enum_with_available() hel=
per
      power: supply: sysfs: Move power_supply_show_enum_with_available() up
      power: supply: Change usb_types from an array into a bitmask

 Documentation/ABI/testing/sysfs-class-power     |  7 ++-
 drivers/extcon/extcon-intel-cht-wc.c            | 15 ++----
 drivers/phy/ti/phy-tusb1210.c                   | 11 ++---
 drivers/power/supply/axp20x_usb_power.c         | 13 ++---
 drivers/power/supply/bq256xx_charger.c          | 15 ++----
 drivers/power/supply/cros_usbpd-charger.c       | 22 +++------
 drivers/power/supply/lenovo_yoga_c630_battery.c |  7 +--
 drivers/power/supply/mp2629_charger.c           | 15 ++----
 drivers/power/supply/mt6360_charger.c           | 13 ++---
 drivers/power/supply/mt6370-charger.c           | 13 ++---
 drivers/power/supply/power_supply_core.c        |  4 --
 drivers/power/supply/power_supply_sysfs.c       | 66 ++++++++-------------=
----
 drivers/power/supply/qcom_battmgr.c             | 37 +++++++-------
 drivers/power/supply/qcom_pmi8998_charger.c     | 13 ++---
 drivers/power/supply/rk817_charger.c            |  9 +---
 drivers/power/supply/rn5t618_power.c            | 13 ++---
 drivers/power/supply/rt9467-charger.c           | 16 ++----
 drivers/power/supply/rt9471.c                   | 15 ++----
 drivers/power/supply/ucs1002_power.c            | 26 +++++-----
 drivers/usb/typec/anx7411.c                     | 11 ++---
 drivers/usb/typec/rt1719.c                      | 11 ++---
 drivers/usb/typec/tcpm/tcpm.c                   | 11 ++---
 drivers/usb/typec/tipd/core.c                   |  9 +---
 drivers/usb/typec/ucsi/psy.c                    | 11 ++---
 include/linux/power_supply.h                    |  3 +-
 25 files changed, 132 insertions(+), 254 deletions(-)

-- Sebastian

--btzqktsiaq62mw5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbXh+UACgkQ2O7X88g7
+pqgqxAAmxavPS+UWhWDuuNHRKCOCwsF5Yy/AoqXJUGMO+cnud9xuZ4TIFIA4aev
ybq790Sxu4dDn2IPzbiota+pW4tz8rgOEOLapwE+9IQLKK0DdA7yRtP/u0W9B2yk
PTeNd2KkzpFdKz/+000TumcXMaFtJhEbYjOxKS4PUcbUqn1qJ1S1v4tRXzsvEoSR
fMqYCJULbBtASQe3WZaQLfXZFAYaHIgn56+Djh8ZoTtZWIHBk2Rz0IFnSFHK9/5p
r4iGTtyC4TQw42s94AhEs5WW4LV7sYb0UYl7M6dwRqdxWV5S8k2HnNCp/3eKfOnz
eFB37yu5y7hSvkmlIL4K2ZJyZ789Zrmq+tDsTuX9VGQlnY0L0+wPotI/+HlLwJTz
q0b4AJGEepQ3Y4ahkE0O2itkJv7WC0vrZPRxHLs//t5MtjOl81aAxEkYExeqM1e4
Tl22Uj/aoVbx4FRMlEczySD7kBzzXWj+Y4kWUWin8x5mKsKEZEHeoBOs+cD/u++W
NKBvTMEZSpHdRwcdK1c07uyGgCjJkMcRdQyhXYrFxEwz9POJqaMCojqva7WtxLVH
zSd3DkA8n7c5je0ow9ug6iX9Vsa7bqHPmAIPHx7DiwCkwsMq3dw9+QE0/H+8eX1/
cXjyrTnp/CZQS1SSwDhnYzaKjy77eWHbZt9G21YDxtJbxeAWA8U=
=x3oo
-----END PGP SIGNATURE-----

--btzqktsiaq62mw5e--


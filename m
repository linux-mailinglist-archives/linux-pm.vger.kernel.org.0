Return-Path: <linux-pm+bounces-42844-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK+7F20qlmkRbwIAu9opvQ
	(envelope-from <linux-pm+bounces-42844-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 22:09:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81690159C83
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 22:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15058300381D
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 21:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF03B349B19;
	Wed, 18 Feb 2026 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2qWTE1B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCADE348875;
	Wed, 18 Feb 2026 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771448936; cv=none; b=aH4nxSWW+uAuBPg7BWfkGpQpu3ZLw0MyeWSUi5Km9d72sXohnfiLbtH6MSK1rxrfmL1CeeJhBsMWtQKu2X6IwTTR5/0DcwLXpwvZucMlJLSF5AHYjvOk8lDXf4VeCTxGq55NttARhMolsmJTIF0h7ocUkmk7cpdTgTjuCC6c3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771448936; c=relaxed/simple;
	bh=hmvBfECGVQuxo2gOjjdBGi2aazSb9iYtIqm3ldnhGCo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BNNJuofAexugzAcbXdQU2e9eX/A8i7EAYDvZFpxQFiqlhqbnRm/Yj6fekpsxONGm+Vbgup/JJn4eT5HXedq3oLsA/YHjdykm8d9NdZGxjE+2682UYU7Nv0DzT7Q3HjWZBfabzpV78jk1gUfdnRH5fswh7DQWCERdcFcEGzW7gHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2qWTE1B; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771448935; x=1802984935;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hmvBfECGVQuxo2gOjjdBGi2aazSb9iYtIqm3ldnhGCo=;
  b=b2qWTE1B6k3Nn++pdlwn0UMm3Aeif1TwkOiBVom+YO5tlFkgsHtL0cSB
   GI+2/NlMr7NHNhbIaFUOqJoLRJ5V6zFL+eMAY6j79D43NJk5uFFzG8t34
   AyJXUcppSHe4quVoSG2MAbzBRpr2S9bgMIY10pAu6BNsNdpYjjKt7EIjp
   SmG312Yx6wUFmazz4vkv94uoIiT6zMnsLhAPlGjPL8CKpxJMY+Whr6OZq
   HeHl4bZ8EbMq6USBYo5/ryKLWR3IsRw42xdDZZz9M0qroAgYhUw7GTlIC
   Py5mwwot7Ikdr8n5wPDkcApJjkhxT1fWDmLAh6QkcdP8BrJ1de9NZH3ZU
   Q==;
X-CSE-ConnectionGUID: 0TMUT8WjQ12WfXetGyiinA==
X-CSE-MsgGUID: /VzUCB+CSYWZG+ziVQkf2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="71735365"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="71735365"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 13:08:54 -0800
X-CSE-ConnectionGUID: hKIk//GmS9OwkK9ckpvQaA==
X-CSE-MsgGUID: bxglEp/zTVetrhSjqA/fOw==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 13:08:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 18 Feb 2026 23:08:48 +0200 (EET)
To: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
    linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Ionut Nechita <ionut_n2001@yahoo.com>
Subject: Re: [RFC PATCH 3/3] PCI: Update bandwidth control and thermal cooling
 for Gen 7 (128 GT/s)
In-Reply-To: <20260217080102.206581-8-sunlightlinux@gmail.com>
Message-ID: <6aac361d-7e6a-8857-9aa3-f127d96dd272@linux.intel.com>
References: <20260217080102.206581-2-sunlightlinux@gmail.com> <20260217080102.206581-8-sunlightlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1588266121-1771448928=:1022"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_CC(0.00)[google.com,kernel.org,linaro.org,intel.com,arm.com,wunner.de,vger.kernel.org,yahoo.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-42844-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 81690159C83
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1588266121-1771448928=:1022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 17 Feb 2026, Ionut Nechita (Sunlight Linux) wrote:

The subject should start with

PCI/bwctrl:

=2E..and you then don't need to repeat bandwidth control anymore.

> From: Ionut Nechita <ionut_n2001@yahoo.com>
>=20
> Update PCIe subsystem components to support 128 GT/s link speed:
>=20
>   - bwctrl: Extend pcie_valid_speed() range to PCIE_SPEED_128_0GT,
>     add PCIE_SPEED_128_0GT to speed conversion table, widen
>     supported_speeds variables from u8 to u16
>   - portdrv: Switch hweight8() to hweight16() for supported_speeds
>     to match the widened type
>   - pcie_cooling: Add static_assert for PCIE_SPEED_128_0GT enum
>     contiguity check
>=20
> Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
> ---
>  drivers/pci/pcie/bwctrl.c      | 7 ++++---
>  drivers/pci/pcie/portdrv.c     | 2 +-
>  drivers/thermal/pcie_cooling.c | 1 +
>  3 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index 36f939f23d34e..b9125b40cb860 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -50,7 +50,7 @@ static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
> =20
>  static bool pcie_valid_speed(enum pci_bus_speed speed)
>  {
> -=09return (speed >=3D PCIE_SPEED_2_5GT) && (speed <=3D PCIE_SPEED_64_0GT=
);
> +=09return (speed >=3D PCIE_SPEED_2_5GT) && (speed <=3D PCIE_SPEED_128_0G=
T);
>  }
> =20
>  static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
> @@ -62,6 +62,7 @@ static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed spe=
ed)
>  =09=09[PCIE_SPEED_16_0GT] =3D PCI_EXP_LNKCTL2_TLS_16_0GT,
>  =09=09[PCIE_SPEED_32_0GT] =3D PCI_EXP_LNKCTL2_TLS_32_0GT,
>  =09=09[PCIE_SPEED_64_0GT] =3D PCI_EXP_LNKCTL2_TLS_64_0GT,
> +=09=09[PCIE_SPEED_128_0GT] =3D PCI_EXP_LNKCTL2_TLS_128_0GT,
>  =09};
> =20
>  =09if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
> @@ -70,7 +71,7 @@ static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed spe=
ed)
>  =09return speed_conv[speed];
>  }
> =20
> -static inline u16 pcie_supported_speeds2target_speed(u8 supported_speeds=
)
> +static inline u16 pcie_supported_speeds2target_speed(u16 supported_speed=
s)
>  {
>  =09return __fls(supported_speeds);
>  }
> @@ -88,7 +89,7 @@ static inline u16 pcie_supported_speeds2target_speed(u8=
 supported_speeds)
>  static u16 pcie_bwctrl_select_speed(struct pci_dev *port, enum pci_bus_s=
peed speed_req)
>  {
>  =09struct pci_bus *bus =3D port->subordinate;
> -=09u8 desired_speeds, supported_speeds;
> +=09u16 desired_speeds, supported_speeds;
>  =09struct pci_dev *dev;
> =20
>  =09desired_speeds =3D GENMASK(pci_bus_speed2lnkctl2(speed_req),
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 38a41ccf79b9a..5ee8795107f26 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -274,7 +274,7 @@ static int get_port_device_capability(struct pci_dev =
*dev)
> =20
>  =09=09pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
>  =09=09if (linkcap & PCI_EXP_LNKCAP_LBNC &&
> -=09=09    hweight8(dev->supported_speeds) > 1)
> +=09=09    hweight16(dev->supported_speeds) > 1)
>  =09=09=09services |=3D PCIE_PORT_SERVICE_BWCTRL;
>  =09}
> =20
> diff --git a/drivers/thermal/pcie_cooling.c b/drivers/thermal/pcie_coolin=
g.c
> index a876d64f15827..9a2e39398674b 100644
> --- a/drivers/thermal/pcie_cooling.c
> +++ b/drivers/thermal/pcie_cooling.c
> @@ -75,6 +75,7 @@ static_assert(PCIE_SPEED_5_0GT + 1 =3D=3D PCIE_SPEED_8_=
0GT);
>  static_assert(PCIE_SPEED_8_0GT + 1 =3D=3D PCIE_SPEED_16_0GT);
>  static_assert(PCIE_SPEED_16_0GT + 1 =3D=3D PCIE_SPEED_32_0GT);
>  static_assert(PCIE_SPEED_32_0GT + 1 =3D=3D PCIE_SPEED_64_0GT);
> +static_assert(PCIE_SPEED_64_0GT + 1 =3D=3D PCIE_SPEED_128_0GT);
> =20
>  MODULE_AUTHOR("Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>");
>  MODULE_DESCRIPTION("PCIe cooling driver");

Once you start to use the new capability, you'll also need to check if the=
=20
GENMASK()s related to speed vector are still okay (both bwctrl and core=20
do it). There might also be fls() or something like that that which no=20
longer holds with the 0x7 reserved hole in the speeds but I didn't check.

--=20
 i.

--8323328-1588266121-1771448928=:1022--


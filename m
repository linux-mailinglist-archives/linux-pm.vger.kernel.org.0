Return-Path: <linux-pm+bounces-37719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D82C465F4
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 12:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DEC0F34801A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 11:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82DF30BF66;
	Mon, 10 Nov 2025 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MybNDpjY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC19630ACEE;
	Mon, 10 Nov 2025 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775399; cv=none; b=HFCc6oLcin3sfiZUZi8V5EIBwePG5h4WESnUUJkoMGtSkCzPJG/VfZUAXIiPNf+BKwIm75tBrZ7hj3wD7ZIu6tlcbxeqUgd8jHJDzaNW2I9pU+/itc/gntVH3gARwEUky9i8It2mc6jjJ07H9ZtRB+uTDwc9RAdpvEroFwj8n64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775399; c=relaxed/simple;
	bh=kgLvGqGW6Y2MVxPS0dVKx+QUBt0U5B7prEs50cqFkU4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cHchF+3SJs7n+nnBrL5JSJxU/LYj51e1j+Qc1y4n6t4WWiVQ05TcyGDM9JabhHMvvxvOxPpxfto4uETLWRiSjVwtqCKiHDnk4hfx6OuO6M5e5vqlAKPjbjt6mp2wFZGBjOnP3VrM1UrlSomBeCTWh3xpNaSg/iUHKbegrjZl5RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MybNDpjY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762775398; x=1794311398;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kgLvGqGW6Y2MVxPS0dVKx+QUBt0U5B7prEs50cqFkU4=;
  b=MybNDpjYgKJzlFJE1XlpRif5sw8WHu5Oa0DPp+7PPcrvsdcoEou2DCsA
   nquc7AEVVNrIdcfV0p8X+fVSJJ2s5K6UjkbYi5X6xyb/iRbwnVjFLa2KX
   mUbdG6XTlJgOz7H3b1N0+b1qfvHFcpVJ40pB0DS+RgzpZrYDR/A8Ui9Bi
   E6FGEqNksD6qGPooTKNnZsSrn3UnlOn+SMCGgisksA9sl9etTKgVAbSR4
   zEexw75QcZkFksiEb7l+GbvPSNiK2pN0yZC3uRMTGlyIGWjwacAWEoxQF
   fuGD/FtPIFSgzt/kofTi1XRcIY+zeOz137dj9ZqKlbQTVUbDsyOVYq1z6
   w==;
X-CSE-ConnectionGUID: W1fT316HSnm/TQmGTWuvYw==
X-CSE-MsgGUID: IrTEIptmT+C0026QS1VRsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="52381235"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="52381235"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:49:57 -0800
X-CSE-ConnectionGUID: Sj9MWXvmSo6S4AGtYTK6HQ==
X-CSE-MsgGUID: q0aaSUIcTOWst/+WBvw2kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="193665319"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:49:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 10 Nov 2025 13:49:42 +0200 (EET)
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Viresh Kumar <viresh.kumar@linaro.org>, 
    Matthias Brugger <matthias.bgg@gmail.com>, 
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
    Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, 
    Jernej Skrabec <jernej.skrabec@gmail.com>, 
    Samuel Holland <samuel@sholland.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Bjorn Andersson <andersson@kernel.org>, 
    Konrad Dybcio <konradybcio@kernel.org>, 
    Thomas Gleixner <tglx@linutronix.de>, 
    Nicolas Ferre <nicolas.ferre@microchip.com>, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
    Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@kernel.org>, 
    Thierry Reding <thierry.reding@gmail.com>, 
    Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
    linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 09/13] platform: surface: Simplify with
 of_machine_get_match_data()
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-9-d780ea1780c2@linaro.org>
Message-ID: <4986f752-ba21-6a5f-641a-e0dadb4abd11@linux.intel.com>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org> <20251106-b4-of-match-matchine-data-v1-9-d780ea1780c2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1580227820-1762775382=:1060"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1580227820-1762775382=:1060
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 6 Nov 2025, Krzysztof Kozlowski wrote:

Please change the prefixes to:

platform/surface: aggregator_registry: ...

Once that is changed,

Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> Replace open-coded getting root OF node, matching against it and getting
> the match data with new of_machine_get_match_data() helper.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> Depends on the first OF patch.
> ---
>  drivers/platform/surface/surface_aggregator_registry.c | 13 +-----------=
-
>  1 file changed, 1 insertion(+), 12 deletions(-)
>=20
> diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/dri=
vers/platform/surface/surface_aggregator_registry.c
> index a594d5fcfcfd..78ac3a8fbb73 100644
> --- a/drivers/platform/surface/surface_aggregator_registry.c
> +++ b/drivers/platform/surface/surface_aggregator_registry.c
> @@ -491,24 +491,13 @@ static const struct of_device_id ssam_platform_hub_=
of_match[] __maybe_unused =3D {
>  static int ssam_platform_hub_probe(struct platform_device *pdev)
>  {
>  =09const struct software_node **nodes;
> -=09const struct of_device_id *match;
> -=09struct device_node *fdt_root;
>  =09struct ssam_controller *ctrl;
>  =09struct fwnode_handle *root;
>  =09int status;
> =20
>  =09nodes =3D (const struct software_node **)acpi_device_get_match_data(&=
pdev->dev);
>  =09if (!nodes) {
> -=09=09fdt_root =3D of_find_node_by_path("/");
> -=09=09if (!fdt_root)
> -=09=09=09return -ENODEV;
> -
> -=09=09match =3D of_match_node(ssam_platform_hub_of_match, fdt_root);
> -=09=09of_node_put(fdt_root);
> -=09=09if (!match)
> -=09=09=09return -ENODEV;
> -
> -=09=09nodes =3D (const struct software_node **)match->data;
> +=09=09nodes =3D (const struct software_node **)of_machine_get_match_data=
(ssam_platform_hub_of_match);
>  =09=09if (!nodes)
>  =09=09=09return -ENODEV;
>  =09}
>=20
>=20
--8323328-1580227820-1762775382=:1060--


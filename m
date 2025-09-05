Return-Path: <linux-pm+bounces-34012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D45B46245
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 20:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E1E7BF250
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 18:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9595079CF;
	Fri,  5 Sep 2025 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peVys0lA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668FD30597B;
	Fri,  5 Sep 2025 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097027; cv=none; b=ahNqvZePXm7bIIuYA4LI6nse8wcuErBYarMzBIep42YxM6END2nkhR1zczeMS/xH9iTN5IFVU+cleDLQ91b+gAmWhE9iVaiBzKHB0H+NRg/QXyy2jYxbX10lL17Jjyp9F5rG7zdYewIUP9xQn1DM42aod3HkPFxXCb3ARGxEZr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097027; c=relaxed/simple;
	bh=Kl2F5va7TyXy3NWwvLv49hk9UoEZdpo/AOlO+Os9PKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDPPiXAYuipmKB36vXZk/8YblldDaL22sWsi6yxc1oW5j07VcrhW/S+sobolAjtPpjmtpd7isI7bFUwn9cz39WVUH9A08WBS4HylRvtBTUplaluBRfGWLUr3mB2F4OKoSANVzZDWtqLXma4mpkDJfTsgLJ/0P6fVdOA7TKhrCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peVys0lA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30E3C4CEF1;
	Fri,  5 Sep 2025 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757097027;
	bh=Kl2F5va7TyXy3NWwvLv49hk9UoEZdpo/AOlO+Os9PKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peVys0lAr6mNvSnHXeNn5Sr1eJl8B9oyf1xBroNNFeamydPynjHzqhbSIU8I6gWoL
	 J5ViyZvVCR3PhpknlxIgisK8UxX3kNygL+6azMjuG5GoH2ySO4CSrbQBt2k+aWH0sD
	 zsQWRcI4wQvgp3ASIE+RYzQESNEx3VlUh34/sfweprcg4aFNuSBiZfio2bjqa2JNWA
	 t8nepzNcpPC2wFFcHkPPmkE/5NFDWmcmhDNOZ8vgLgyJSz2KzRIiLfa8ks5D3QliQ/
	 Zl53EdVkcDTYIIibifvrsrz9QuBexfusjQRr8uKm1JvEiuhgB5uwE9NMz5wYGZuc7Q
	 /CcNwebP6N6Zw==
Date: Fri, 5 Sep 2025 19:30:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Salih Erim <salih.erim@amd.com>,
	Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 4/6] dt-bindings: thermal: versal: Add description for
 Versal Thermal
Message-ID: <20250905-rinse-haziness-93200b3de9d9@spud>
References: <cover.1757061697.git.michal.simek@amd.com>
 <c46889536b2555c25aa6f17facdf085956b648a4.1757061697.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J7hE1W70YH7CTml2"
Content-Disposition: inline
In-Reply-To: <c46889536b2555c25aa6f17facdf085956b648a4.1757061697.git.michal.simek@amd.com>


--J7hE1W70YH7CTml2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 05, 2025 at 10:41:47AM +0200, Michal Simek wrote:
> From: Salih Erim <salih.erim@amd.com>
>=20
> Add description of Versal Thermal which describes IO channels to
> be binded to thermal. Constant channel of "sysmon-temp-channel" used as
> mapped iio channel.
>=20
> One temperature zone is used for the AI Engine temperature monitoring.
>=20
> Signed-off-by: Salih Erim <salih.erim@amd.com>
> Co-developed-by: Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadama=
thikuttiyil-karthikeyan-pillai@amd.com>
> Signed-off-by: Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadamath=
ikuttiyil-karthikeyan-pillai@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>=20
>  .../bindings/thermal/xlnx,versal-thermal.yaml | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/xlnx,versal=
-thermal.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/xlnx,versal-therma=
l.yaml b/Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
> new file mode 100644
> index 000000000000..c374d7ae2d2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/xlnx,versal-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Versal Thermal
> +
> +maintainers:
> +  - Salih Erim <salih.erim@amd.com>
> +
> +description:
> +  Versal Thermal uses Versal Sysmon hardware for temperature reading.
> +  It works as sensor interface to be defined in thermal zones.
> +
> +properties:
> +  compatible:
> +    const: xlnx,versal-thermal

BTW Michal, what's the story with using amd v xlnx for bindings?
Planning to use amd for new devices and xlnx for stuff sold before the
purchase or something like that?

> +
> +  '#thermal-sensor-cells':
> +    const: 1
> +
> +  io-channels:
> +    maxItems: 1
> +
> +  io-channel-names:
> +    const: sysmon-temp-channel
> +
> +required:
> +  - compatible
> +  - '#thermal-sensor-cells'
> +  - io-channels
> +  - io-channel-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    versal-thermal-sensor {

Drop the versal from the node name here please.
With that,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> +        compatible =3D "xlnx,versal-thermal";
> +        #thermal-sensor-cells =3D <1>;
> +        io-channels =3D <&sysmon0>;
> +        io-channel-names =3D "sysmon-temp-channel";
> +    };
> +...
> --=20
> 2.43.0
>=20

--J7hE1W70YH7CTml2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLssPQAKCRB4tDGHoIJi
0lBRAQCuFoBGBqyPvjLR3ZjUW/I7G+wz1guhBI+sAfe4q8qaEgEAz0vCDCaxnCD8
XqC0S1L3TS21i1QhgXR3VujKeahCHwE=
=V8aw
-----END PGP SIGNATURE-----

--J7hE1W70YH7CTml2--


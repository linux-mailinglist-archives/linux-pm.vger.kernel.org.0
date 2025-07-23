Return-Path: <linux-pm+bounces-31350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0DBB0F8F6
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 19:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38942AA11C3
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 17:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F097D21C16E;
	Wed, 23 Jul 2025 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4j1BZKS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB082101B3;
	Wed, 23 Jul 2025 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291280; cv=none; b=vGfTTEAvk4jHo7lfe2zW4V4c4Sn7/kI5TBwHphB8/47lYIY9gfWV3GsI6qTAkINefe0QJfns/xvdW0Dors6PcIxobBt4x91sP+uM+Z9fFvARGa9fpURceqKaQ7TuZs7JSXfneHHowLRSu7lMoRz6dgeZB2G4RQ3gidLbblIXGYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291280; c=relaxed/simple;
	bh=xtv1v1vs8h+55gbAe/7DHcO2riCXUkdqyinSc/Mz4k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTeWvCoQBYuIOrtIornFO8ndagq36MdYX7QHhpsT50jGXyfpZgTVLkzAfIRsF7vLfjMOg8GWIg0a3eibkXxI+9l6iO9ZlNPffF9/Aw25wihqKjYukQE0VZmX06yRHDxFuFKBvTQkDqP81GhVUgtQP1usIeRDCd/g0U0ls0NHgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4j1BZKS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so64321a91.3;
        Wed, 23 Jul 2025 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753291279; x=1753896079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdHhJehaOGGRyz1yZkMniHUZHHY/gtuGeETDNFE6Evk=;
        b=B4j1BZKSlmyh4jINlQz3FHIhl7PND+tvxMmrJUQ9LFcQneXgsH2kCFGtPAn/T+/VhJ
         u7u6V3dtIDug3865IRz6NVvTpy/XgY1YvHfUwMMoaNj+GRUooqhyR5cGG8N2BrldFugB
         x1gvgDGJzlgGNlttH1IAuJ2nna6/vIR6ECOP/Egk7aNnfbvOzXZGR08C7DRLBhJOsJl7
         Qo8X0uKVcS6H8GGeklpduwec1gm/3R3Sw30xLVC/t6U4Yhi9+6HOwEGkaLyl9XSn/93m
         txFbjA4hu7hdnGnlOleOMPWRsz/MKMuLXeLcJpgfu4/hy8ZaME+gufXaSB/trbRo6p9L
         8QnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753291279; x=1753896079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdHhJehaOGGRyz1yZkMniHUZHHY/gtuGeETDNFE6Evk=;
        b=llYaxyjt/LxBH22tcU6jQV2WOfVU8dC1FI8Kw+l2f1we3aHBMkJQPwWSX+j/XztjHO
         e1biIVlpi0oJ79/oLMd4fqPqbgl1+4sbIlf9vjHBJ38Kqeu9rAlzRUCgn/xxsWArTsTC
         /IX+wOZISdnvJg5FxcZpn91LM85L+SbEhFdcfblijPx7h2QkXh0kUlBBpbrvtbhf4Jyd
         392Da3S3hk+4mHMpJs64/jUvtBHNixjAedt+NC4aCd4b1lCIiw+AwVseF9rvkiBLzYZZ
         hp2pDxUuOjkRGowwqDqEFhe9oM4jcUfWcIpIy0uef0LC1DzHnvsOZ1G093ISK6Bo1avg
         JHJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ6dpITcp6Xh3iUaCxo1RXCTc7vdygSeZpRpg4LmjEw9KAeavmY2oUszNSJbVh2wOVyNAQxpSDzExy@vger.kernel.org, AJvYcCWt0Bqqg6In1jfuABVmUt5iEB6r1IXzkqhpSpvSTbuzNSWlf00yBgJshxLJiI71POZQ2joHK96LFYQ=@vger.kernel.org, AJvYcCXpebgsMDs8Ksswz/Vgg8doyyi5x9g6Ib2snksfbrCKov2SK1jzbwLi4sLRdJFb8RoPeylUEqIPq99cjSzk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1lNfvU4+MQecf9hSS2vyXr4VDb2FcMoWtuBq0tgh4r2FGv67s
	WXRRdxX1q4DFcXXCw+7p0TqqwljRYYewzrOlHyv0HV4nnblJY1TxWafzi/WyVxGILdYd7sUXoAU
	jphFrDlTFwnZu90Mc5PY29iOeCPZ5jfw=
X-Gm-Gg: ASbGncuPJKpl88TKSYCeNZruCSHm44idNfcWHk6Sw8H6LWbkhyvmhTOHgo4o4dLDbCY
	1H6CbS6RgvfagB1oA0lz9bgtN1uhBDZhef1grD6/KsyqsXJKTpApSPXmwD/SItZuGp8RIb7yel2
	E244KKA5gtm27bAn7RJTOVkX6T7dpFSRZyrYDIGnLCreINvurHhjTND3ASe2U6KVmnUm5wDYiYd
	SZm/K7gYe3kK+LnOA==
X-Google-Smtp-Source: AGHT+IGhqjYs4ux4jfZuva5tLAnfpmMqHOkhr1wVS9VTWIb8RSO5zHmqE5yUvKlSgMgvOyzAgKijetY+zLxjWE6uaW0=
X-Received: by 2002:a17:90b:4e83:b0:31c:15d9:8aa with SMTP id
 98e67ed59e1d1-31e507fe866mr5141730a91.34.1753291278497; Wed, 23 Jul 2025
 10:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220706234757.3162307-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220706234757.3162307-1-peng.fan@oss.nxp.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 23 Jul 2025 12:21:07 -0500
X-Gm-Features: Ac12FXyiprxe_LGZo-24j2NghrBhcu3HCth78UZ6f-ppwtBUf5rP10c3ImRmsyI
Message-ID: <CAHCN7xJts7ki+wHGxwMw8eEa4hXkyOwZComzEf_JXiZUBhpkaw@mail.gmail.com>
Subject: Re: [PATCH V4] arm64: dts: imx8mp: add NoC node
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	festevam@gmail.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	abel.vesa@nxp.com, abailon@baylibre.com, l.stach@pengutronix.de, 
	laurent.pinchart@ideasonboard.com, marex@denx.de, paul.elder@ideasonboard.com, 
	Markus.Niebel@ew.tq-group.com, kernel@pengutronix.de, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-imx@nxp.com, abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 6, 2022 at 6:46=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add i.MX8MP NoC node to make the interconnect i.MX8MP driver could work.
> Currently dynamic frequency scaling of the i.MX8MP NoC has not been
> supported, only NoC initial settings are configured by interconnect
> driver.

Peng,

I noticed the Mini and Nano are both supported by the same NoC driver,
but only the 8MP has a DT node.  Looking through the TRM on the Mini,
I don't see the operating points listed.  Would they be the same 200M
and 1000M on the Mini and Nano?

adam
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>
> V4:
>  Georgi has merged the V3 driver and bindings patches. So only resend
>  this patch. Per Georgi's comments:
>   - Drop syscon from compatbile
>   - Drop the header inclusion
>
>  Seems I not see this patch in patchwork or mailist, maybe sent failed.
>  So gave a resend of V4.
>
>  V3:
>   https://lore.kernel.org/linux-arm-kernel/20220703091132.1412063-1-peng.=
fan@oss.nxp.com/
>
>  I not list the full change log, since this is only a minor patch
>
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mp.dtsi
> index eb2d516278eb..42ed8ee08548 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1019,6 +1019,27 @@ eqos: ethernet@30bf0000 {
>                         };
>                 };
>
> +               noc: interconnect@32700000 {
> +                       compatible =3D "fsl,imx8mp-noc", "fsl,imx8m-noc";
> +                       reg =3D <0x32700000 0x100000>;
> +                       clocks =3D <&clk IMX8MP_CLK_NOC>;
> +                       #interconnect-cells =3D <1>;
> +
> +                       operating-points-v2 =3D <&noc_opp_table>;
> +
> +                       noc_opp_table: opp-table {
> +                               compatible =3D "operating-points-v2";
> +
> +                               opp-200M {
> +                                       opp-hz =3D /bits/ 64 <200000000>;
> +                               };
> +
> +                               opp-1000M {
> +                                       opp-hz =3D /bits/ 64 <1000000000>=
;
> +                               };
> +                       };
> +               };
> +
>                 aips4: bus@32c00000 {
>                         compatible =3D "fsl,aips-bus", "simple-bus";
>                         reg =3D <0x32c00000 0x400000>;
> --
> 2.25.1
>


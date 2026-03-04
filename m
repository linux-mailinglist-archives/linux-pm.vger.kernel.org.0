Return-Path: <linux-pm+bounces-43581-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPtjMeM0qGm+pQAAu9opvQ
	(envelope-from <linux-pm+bounces-43581-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 14:34:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E23962007CB
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 14:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23B68300D178
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 13:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADED389101;
	Wed,  4 Mar 2026 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qif17WzB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABDE1CAA78
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631218; cv=none; b=aG5rolUopVrdDsDezv4uAzWpfTGUyFQuHv+Nk9Eu/UudEcNKglv1rsk/csW3O9hA0XS7DRZO5Ef+0WMsT2gW3BjYc9NtNjJ8n1XHy8nA/vRID/K9XU88954q7LLE92vSFs+C8pe/TQ6nGPOo074UDGQQbP/QjL2di4JPqOi4uzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631218; c=relaxed/simple;
	bh=qX8bwC7Pr9sLJEwNHDJdwt6wRYUINp909IFCD+BCZGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSKQ/JA0hRc2m7m3bp0AzLKmY8Qir5ig1iY7KC8HGmI50Hazbu8WA1nJuQ21ATB3ErMFfFX9uRXAVbcxmBHnejj6JAtnlTecvGkujQZ/jDUkAXdumI8HuI2VrUILkRzfpGyY4ulxK0/nJMFIAj8hr6cOHX0DFhntw2pz4uOrKIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qif17WzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27C5C2BC9E
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772631217;
	bh=qX8bwC7Pr9sLJEwNHDJdwt6wRYUINp909IFCD+BCZGM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Qif17WzBzBvkoZ/nngJnz8sJxXvmtVb7CDH2GgHnvD8Eg4wXcB7/iUPikO1Rj7Lw+
	 nTyeDShVWEJOTO6LH41cgsGChErXNk4UKZM7InHw5IsnZgGFDjFjAs2YidL2FRDYye
	 wldPBeuWRLX4A9id9QwKZBANP4J2ET6394qW5k7N2UQGEsmgZCa+jY9ZNUFKoJtfcc
	 kp4S9COjdi8zaoMeBQU/KYuckEHF9LS1wWSUozRuey+J3NCBd5gFrq0etry2kCVYsH
	 3j8h0Gcx7Fgo/89C/1X2+zm7mvzM9yMm9WVMK/zifcZLgf5JixXx4xcD8IqOZHyO8b
	 mExfYykDd2sgQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38a2f196cbaso7866711fa.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 05:33:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRR2ObkP1v4kf9XoDHWWsC1jV+uovDRZFv/K9jZPOg1gzuqbFxN+xyRWy3DM7cp4tBe8KWUonSNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqpI8gEhJptmnEjQ+u/eXWEipbInn2+aMupohtpwTFy98W93nX
	pnROmZvaj3PnLZzwhsgh7nl73nk/XfTUMoP/cZsUkm2mTg0tpkrsJnlm6sJV+9HbnKCTPt2A0ON
	evZoFmrjwYA6Q15W3LKsBzBlXrvHoQWU=
X-Received: by 2002:a05:651c:997:b0:389:ff39:d36f with SMTP id
 38308e7fff4ca-38a2c564975mr18004471fa.8.1772631216030; Wed, 04 Mar 2026
 05:33:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304-b4-pck600-a733-v1-0-2f54efdb8cc2@gmail.com> <20260304-b4-pck600-a733-v1-2-2f54efdb8cc2@gmail.com>
In-Reply-To: <20260304-b4-pck600-a733-v1-2-2f54efdb8cc2@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 4 Mar 2026 22:33:23 +0900
X-Gmail-Original-Message-ID: <CAGb2v64n_8RyWDieUKvbpkTikipB9ZvqEscYRRLowe+rvaJKCQ@mail.gmail.com>
X-Gm-Features: AaiRm52IhPssfKwic0-9MUev9i9zshO3IgtBuLjVx0xGClavhc7qhY1LONhcieE
Message-ID: <CAGb2v64n_8RyWDieUKvbpkTikipB9ZvqEscYRRLowe+rvaJKCQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdomain: sunxi: Add support for A733 to Allwinner
 PCK600 driver
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E23962007CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43581-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,linaro.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[wens@kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-pm@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 12:44=E2=80=AFPM Yuanshen Cao <alex.caoys@gmail.com>=
 wrote:
>
> The Allwinner A733 PCK600, similar to A523 PCK600, is likely a
> customized version of ARM PCK-600 power controller. It shares
> the same BSP driver with A523. According to the BSP provided
> by Radxa, unlike A523, it doesn't require reset.
>
> Make reset optional in the sunxi pck600 driver and add support
> for A733.
>
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> ---
>  drivers/pmdomain/sunxi/sun55i-pck600.c | 53 ++++++++++++++++++++++++++++=
++----
>  1 file changed, 48 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pmdomain/sunxi/sun55i-pck600.c b/drivers/pmdomain/su=
nxi/sun55i-pck600.c
> index c7ab51514531..8f9fdc3915bd 100644
> --- a/drivers/pmdomain/sunxi/sun55i-pck600.c
> +++ b/drivers/pmdomain/sunxi/sun55i-pck600.c
> @@ -52,6 +52,7 @@ struct sunxi_pck600_desc {
>         u32 logic_power_switch0_delay;
>         u32 logic_power_switch1_delay;
>         u32 off2on_delay;
> +       bool has_rst_clk;
>  };
>
>  struct sunxi_pck600_pd {
> @@ -151,9 +152,11 @@ static int sunxi_pck600_probe(struct platform_device=
 *pdev)
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
>
> -       rst =3D devm_reset_control_get_exclusive_released(dev, NULL);
> -       if (IS_ERR(rst))
> -               return dev_err_probe(dev, PTR_ERR(rst), "failed to get re=
set control\n");
> +       if (desc->has_rst_clk) {
> +               rst =3D devm_reset_control_get_exclusive_released(dev, NU=
LL);
> +               if (IS_ERR(rst))
> +                       return dev_err_probe(dev, PTR_ERR(rst), "failed t=
o get reset control\n");
> +       }
>
>         clk =3D devm_clk_get_enabled(dev, NULL);
>         if (IS_ERR(clk))
> @@ -193,7 +196,14 @@ static int sunxi_pck600_probe(struct platform_device=
 *pdev)
>  }
>
>  static const char * const sun55i_a523_pck600_pd_names[] =3D {
> -       "VE", "GPU", "VI", "VO0", "VO1", "DE", "NAND", "PCIE"
> +       "VE",
> +       "GPU",
> +       "VI",
> +       "VO0",
> +       "VO1",
> +       "DE",
> +       "NAND",
> +       "PCIE",

No need to change this part.

>  };
>
>  static const struct sunxi_pck600_desc sun55i_a523_pck600_desc =3D {
> @@ -206,7 +216,36 @@ static const struct sunxi_pck600_desc sun55i_a523_pc=
k600_desc =3D {
>         .device_ctrl1_delay =3D 0xffff,
>         .logic_power_switch0_delay =3D 0x8080808,
>         .logic_power_switch1_delay =3D 0x808,
> -       .off2on_delay =3D 0x8
> +       .off2on_delay =3D 0x8,
> +       .has_rst_clk =3D true,
> +};
> +
> +static const char * const sun60i_a733_pck600_pd_names[] =3D {
> +       "VI",
> +       "DE_SYS",
> +       "VE_DEC",
> +       "VE_ENC",
> +       "NPU",
> +       "GPU_TOP",
> +       "GPU_CORE",
> +       "PCIE",
> +       "USB2",
> +       "VO",
> +       "VO1",
> +};
> +
> +static const struct sunxi_pck600_desc sun60i_a733_pck600_desc =3D {
> +       .pd_names =3D sun60i_a733_pck600_pd_names,
> +       .num_domains =3D ARRAY_SIZE(sun60i_a733_pck600_pd_names),
> +       .logic_power_switch0_delay_offset =3D 0xc00,
> +       .logic_power_switch1_delay_offset =3D 0xc04,
> +       .off2on_delay_offset =3D 0xc10,
> +       .device_ctrl0_delay =3D 0x1f1f1f,
> +       .device_ctrl1_delay =3D 0x1f1f,
> +       .logic_power_switch0_delay =3D 0x8080808,
> +       .logic_power_switch1_delay =3D 0x808,
> +       .off2on_delay =3D 0x8,
> +       .has_rst_clk =3D false,
>  };
>
>  static const struct of_device_id sunxi_pck600_of_match[] =3D {
> @@ -214,6 +253,10 @@ static const struct of_device_id sunxi_pck600_of_mat=
ch[] =3D {
>                 .compatible     =3D "allwinner,sun55i-a523-pck-600",
>                 .data           =3D &sun55i_a523_pck600_desc,
>         },
> +       {
> +               .compatible     =3D "allwinner,sun60i-a733-pck-600",
> +               .data           =3D &sun60i_a733_pck600_desc,
> +       },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_pck600_of_match);
>
> --
> 2.53.0
>


Return-Path: <linux-pm+bounces-35664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AA9BB35F0
	for <lists+linux-pm@lfdr.de>; Thu, 02 Oct 2025 10:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D51CA7B35FA
	for <lists+linux-pm@lfdr.de>; Thu,  2 Oct 2025 08:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC892EA73B;
	Thu,  2 Oct 2025 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btSCzjks"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2C2FBE12
	for <linux-pm@vger.kernel.org>; Thu,  2 Oct 2025 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759395494; cv=none; b=N/xLQqZRHvGnfQXRpBw0shR2Q0YZQMfOW+tj/Sc2AfZP6w3gYhIGfRL0QbqmUal92xuIEn+fQplSSSq+JyQoRejbbH5FVNcNNFpQE9p+dT/jhQCXveW7lnw7VM89tovIx0fqwB75r2plEXj24eWHFNGYB1Z5RttpTSiqpUi/2YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759395494; c=relaxed/simple;
	bh=I4SP6KNXP9wNBNDQD45sLrHOkRhFeQz2BrfdEPhIUNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+c86ck66qdeug07cTgCvQNGJMRkohuu+LYrV7j+LtLLhK+s2DpRP4yAMkgxmqHSvdFg11tlUgwAGLuF+o5EF6XG6JBjK16aoV4TxF+PcTs33JI55xQKxzAe2Y56zji9yhzu8pxQA6IIdlzytX0fyZuPdC1wpAlTBVY9jOCz10w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btSCzjks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C864C116B1
	for <linux-pm@vger.kernel.org>; Thu,  2 Oct 2025 08:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759395494;
	bh=I4SP6KNXP9wNBNDQD45sLrHOkRhFeQz2BrfdEPhIUNM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=btSCzjksCbPVkonNPB29BHRt0fa1sO3TU7OFt947yofwiXOioRH73y+gwEYb3G+WV
	 +pJFG7+NiBIpNdjtyt5qEB0DAgnTXrXv0DRkiUIMk8UcvE2go2Mnx70GNRt6cgeAxP
	 P2uerqHp1q3U3TtaCHV2IIZTwsHra5tmNTmYkxk1vmCDLeadS/Mk8g/MUQg2oNzpmZ
	 tY5gviXk2i+YBzHU5kFX9OiIT5jkrzHAjJ1TttD6vC8PZ+e4GMSxvO0b8/LdoWxY3W
	 zz3xwBMsFVBcJCBOYOsHi5S1Rrpq+Epuv9xDa9VxynO8vi1OcMPJ7TRK74KO7UOSUw
	 8FMj7LYHT5CtA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-646d66626a4so379021eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Oct 2025 01:58:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWekE+Ice2dxP63467R2N5eFv8nShzIzc+WXZQfSSO8kDvQJrV/WU8sQJ2jFbooijwfZjtuaWZhSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/E7Bo8pNJYMRx+0rL9SozjeOKCa6BLTA7t1so51ysGiGN04Mq
	1+/Uxqlzl3Ov5kpE/KGB6GUhKOyfOh6TClWC6a92N0ezyC7UZ6yFkqlULVy7nXn8F01DBaLAyGY
	FkWdmVWHCdkiy1IJHmmFqYF7+lwrDfDw=
X-Google-Smtp-Source: AGHT+IEMLxjd9ZUo/Zk/S6ZXeKvQYsV2ZpEB+uhyIKOVPA1BpiREMPXNleuwDOpgKOeWqhEdBohMl5tTdZvgKgUbJ+k=
X-Received: by 2002:a05:6820:761a:b0:64e:5783:441f with SMTP id
 006d021491bc7-64e5783480fmr470666eaf.8.1759395493299; Thu, 02 Oct 2025
 01:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f5420c70643d9b35b39d9b336295d589eaf7013.1759239979.git.geert+renesas@glider.be>
In-Reply-To: <3f5420c70643d9b35b39d9b336295d589eaf7013.1759239979.git.geert+renesas@glider.be>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 2 Oct 2025 10:58:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iu=OYABdXjeYX3GPcUq-LDsq9q1JmGizDi8OX_Uzh4RA@mail.gmail.com>
X-Gm-Features: AS18NWBBfJP7yjox4AMLuLOrPsFP_Cs7O04kv8bpwFN8HDufe2l_y4eEFFPQjWA
Message-ID: <CAJZ5v0iu=OYABdXjeYX3GPcUq-LDsq9q1JmGizDi8OX_Uzh4RA@mail.gmail.com>
Subject: Re: [PATCH] thermal: renesas: Fix RZ/G3E fall-out
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	John Madieu <john.madieu.xa@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 3:47=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>   - Restore sort order in MAINTAINERS and Kconfig,
>   - Remove empty trailing line from Makefile.
>
> Fixes: 19d3a401a617c68e ("thermal/drivers/renesas/rzg3e: Add thermal driv=
er for the Renesas RZ/G3E SoC")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  MAINTAINERS                      | 14 +++++++-------
>  drivers/thermal/renesas/Kconfig  | 14 +++++++-------
>  drivers/thermal/renesas/Makefile |  1 -
>  3 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eb73b4db917596bd..fc755a50fb150498 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21881,13 +21881,6 @@ S:     Maintained
>  F:     Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250=
.yaml
>  F:     drivers/iio/potentiometer/x9250.c
>
> -RENESAS RZ/G3S THERMAL SENSOR UNIT DRIVER
> -M:     Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> -L:     linux-pm@vger.kernel.org
> -S:     Maintained
> -F:     Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.y=
aml
> -F:     drivers/thermal/renesas/rzg3s_thermal.c
> -
>  RENESAS RZ/G3E THERMAL SENSOR UNIT DRIVER
>  M:     John Madieu <john.madieu.xa@bp.renesas.com>
>  L:     linux-pm@vger.kernel.org
> @@ -21895,6 +21888,13 @@ S:     Maintained
>  F:     Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.y=
aml
>  F:     drivers/thermal/renesas/rzg3e_thermal.c
>
> +RENESAS RZ/G3S THERMAL SENSOR UNIT DRIVER
> +M:     Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> +L:     linux-pm@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.y=
aml
> +F:     drivers/thermal/renesas/rzg3s_thermal.c
> +
>  RESET CONTROLLER FRAMEWORK
>  M:     Philipp Zabel <p.zabel@pengutronix.de>
>  S:     Maintained
> diff --git a/drivers/thermal/renesas/Kconfig b/drivers/thermal/renesas/Kc=
onfig
> index c762c1c30d5a211a..5735c8728a31fcb5 100644
> --- a/drivers/thermal/renesas/Kconfig
> +++ b/drivers/thermal/renesas/Kconfig
> @@ -27,6 +27,13 @@ config RZG2L_THERMAL
>           Enable this to plug the RZ/G2L thermal sensor driver into the L=
inux
>           thermal framework.
>
> +config RZG3E_THERMAL
> +       tristate "Renesas RZ/G3E thermal driver"
> +       depends on ARCH_RENESAS || COMPILE_TEST
> +       help
> +         Enable this to plug the RZ/G3E thermal sensor driver into the L=
inux
> +         thermal framework.
> +
>  config RZG3S_THERMAL
>         tristate "Renesas RZ/G3S thermal driver"
>         depends on ARCH_R9A08G045 || COMPILE_TEST
> @@ -34,10 +41,3 @@ config RZG3S_THERMAL
>         help
>           Enable this to plug the RZ/G3S thermal sensor driver into the L=
inux
>           thermal framework.
> -
> -config RZG3E_THERMAL
> -       tristate "Renesas RZ/G3E thermal driver"
> -       depends on ARCH_RENESAS || COMPILE_TEST
> -       help
> -         Enable this to plug the RZ/G3E thermal sensor driver into the L=
inux
> -         thermal framework.
> diff --git a/drivers/thermal/renesas/Makefile b/drivers/thermal/renesas/M=
akefile
> index 0ea59224757226cc..8f5ae9af277cab5e 100644
> --- a/drivers/thermal/renesas/Makefile
> +++ b/drivers/thermal/renesas/Makefile
> @@ -5,4 +5,3 @@ obj-$(CONFIG_RCAR_THERMAL)      +=3D rcar_thermal.o
>  obj-$(CONFIG_RZG2L_THERMAL)    +=3D rzg2l_thermal.o
>  obj-$(CONFIG_RZG3E_THERMAL)    +=3D rzg3e_thermal.o
>  obj-$(CONFIG_RZG3S_THERMAL)    +=3D rzg3s_thermal.o
> -
> --

Applied, thanks!


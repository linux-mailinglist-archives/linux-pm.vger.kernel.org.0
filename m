Return-Path: <linux-pm+bounces-10343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4991E923F6A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 15:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05520280CE5
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 13:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AED1B4C4A;
	Tue,  2 Jul 2024 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhDDUx2j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D5638F83;
	Tue,  2 Jul 2024 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928085; cv=none; b=PZE9fE4OZ3yB7zzuf05jUUCh4hL4exkIIcQ4ioVmJokeD45W4VOKIqBRsELwHjU5Sfu3lNqNA1kzxgF6N+f8gTaDFF4Hr/iQKy81MLmfgdm8BrElOTItu4CPAF3QXBzfMiWK7ISMlr4UZ+4M+/ILqup334LzdylaRplt6VXDrkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928085; c=relaxed/simple;
	bh=POJpBLzMZtl3kVsUtAA1PJiP5FlqLS4DRvmTGZpjDXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2OLhyT8S2E5Dxmi3y4Vkc97I7PkbcTT61UzxEOeUf1UVo9HTx9GzzR/hoFfizSyfw9RLtj4SGaT0A88HMA94omB+AFCM44nFpf6HMVadoZMx+SXOWFEq+ME1oSlDkv1uVFDRXXxV0BcQMlST++SGfZWZNdid8+PeoLqnusYelg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhDDUx2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49193C116B1;
	Tue,  2 Jul 2024 13:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719928084;
	bh=POJpBLzMZtl3kVsUtAA1PJiP5FlqLS4DRvmTGZpjDXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QhDDUx2jnwbewWOnEtvAimQ1AOfa7YUwwYz98BP8HDl52MK7IiArBtlr3Kc0+dnyP
	 7NQwv75ILJ47KxmHHD1tQ471mljWxTOY8ceiFgwIBiOpA+IXkIOw+3uii/zaAHHARY
	 5ouBtksYlL9UzZIe5g49wS6LvUTDbi/DRnOBS92RkdkgjXgIKtILWJ+78RyctwG4LY
	 ETMgr8TNaUFmrClTAP0393pkw4T3dUd2eBmUAkeb2BkuABmBgvHPv/0wB8MTAWMMuI
	 ulyeOWaSQGINEeA3Wd8BpbEJwJqhlWBIPWMU44XjsankiWPOCjh7IrSq/fOga8wHVD
	 +w/WjJedQ6RQQ==
Date: Tue, 2 Jul 2024 15:48:02 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Minas Harutyunyan <hminas@synopsys.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, 
	Peter Robinson <pbrobinson@gmail.com>, dri-devel@lists.freedesktop.org, 
	bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel-list@raspberrypi.com
Subject: Re: [PATCH 07/11] drm/vc4: hdmi: Disable connector status polling
 during suspend
Message-ID: <20240702-qualified-archetypal-worm-416a2f@houat>
References: <20240630153652.318882-1-wahrenst@gmx.net>
 <20240630153652.318882-8-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6llmvbphtnayplvp"
Content-Disposition: inline
In-Reply-To: <20240630153652.318882-8-wahrenst@gmx.net>


--6llmvbphtnayplvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 30, 2024 at 05:36:48PM GMT, Stefan Wahren wrote:
> Suspend of VC4 HDMI will likely triggers a warning from
> vc4_hdmi_connector_detect_ctx() during poll of connector status.
> The power management will prevent the resume and keep the relevant
> power domain disabled.
>=20
> Since there is no reason to poll the connector status during
> suspend, the polling should be disabled during this.
>=20
> It not possible to use drm_mode_config_helper_suspend() here,
> because the callbacks might be called during bind phase and not all
> components are fully initialized.
>=20
> Link: https://lore.kernel.org/dri-devel/7003512d-7303-4f41-b0d6-a8af5bf8e=
497@gmx.net/
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdm=
i.c
> index b3a42b709718..e80495cea6ac 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -3106,6 +3106,13 @@ static int vc5_hdmi_init_resources(struct drm_devi=
ce *drm,
>  static int vc4_hdmi_runtime_suspend(struct device *dev)
>  {
>  	struct vc4_hdmi *vc4_hdmi =3D dev_get_drvdata(dev);
> +	struct drm_device *drm =3D vc4_hdmi->connector.dev;
> +
> +	/*
> +	 * Don't disable polling if it was never initialized
> +	 */
> +	if (drm && drm->mode_config.poll_enabled)
> +		drm_kms_helper_poll_disable(drm);

Does it make sense to add it to runtime_suspend?

What if the board boots without a display connected, and only after a
while one is connected? Wouldn't that prevent the driver from detecting
it?

Maxime

--6llmvbphtnayplvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZoQFEQAKCRDj7w1vZxhR
xUcYAP0YlWR0ZuDtA9KJMgk7F8lTvGRgIEvJmoavoyU/a9BZCgD/aDVTPguo0KhG
fL9qskoopigvTc4187S0uVSHehb/tgU=
=y7a7
-----END PGP SIGNATURE-----

--6llmvbphtnayplvp--


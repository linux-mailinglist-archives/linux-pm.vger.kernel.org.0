Return-Path: <linux-pm+bounces-10344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBAE923F73
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 15:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C57A1C21DC0
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 13:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A1D1B4C59;
	Tue,  2 Jul 2024 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuHPUAcO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5400A38F83;
	Tue,  2 Jul 2024 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928140; cv=none; b=rlaunR4HTVGKyUgYIqTNR/Mw0aDCwsWykF3XHUluVtPsXAkCUWB9DJcpeNS8Ap2ldewn+KvVLIsK01aIW8dv6TD0Aio/GANl21+DjHhL4H2xDYVH+qftSP81MhdYTQ705bDOJ2ZHoQtMPQRbS0D2QPxCJeWHFSeyKh6uZbvLSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928140; c=relaxed/simple;
	bh=VCPpptoX1lcwq96YppGpSXnQWpM75LfIS4wYd/aLFic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyEeTYkUAshVX0qcvgHiA+juOyYOTe+7kk4f2inaTGahp4KXb3uVtKk59ztNI8gDMkAuRCPxWBENntYiasV83+Pf8y7szU5BpfkFkAIeYSPvy2lUs7115nnphGnk1DRU2otfY/8cldvy/aY8vpkUa1KALXY8vT/e9BdhR4xzP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuHPUAcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D32C116B1;
	Tue,  2 Jul 2024 13:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719928140;
	bh=VCPpptoX1lcwq96YppGpSXnQWpM75LfIS4wYd/aLFic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YuHPUAcOv0zJ88c4w282ikL5+HjfDYySsZqWzZ6z4k8bucULdTOueiT8Xt39ZZsSy
	 FckqcvS8VSOY8AoToQB0wbAFVBCVrYULGeHHHRZb9TKivukD9/05lqDeRYoJTj2a3c
	 O6qwOWl/iStS9qA74fMtQppXoYNuW54FKVMi3IhSX+IHKMwNNQ13UH4jwxsA+8Y3MB
	 L6V7Amly/uTRECMB4TQpjCWMHtWt7DXgCf9If/tcQ9Tuaxi9UiJY9o++fTpsYn8M1C
	 JCtZt3EbrnWiT/+jSZgFaKzeFaaUvf3qa9rhHcZ9hAKRkYuUo7Z/VpvBZQmTGnOJ6S
	 dILkiHwJ99P1A==
Date: Tue, 2 Jul 2024 15:48:57 +0200
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
Subject: Re: [PATCH 06/11] drm/vc4: hdmi: Handle error case of
 pm_runtime_resume_and_get
Message-ID: <20240702-mysterious-excellent-hyena-0ff24f@houat>
References: <20240630153652.318882-1-wahrenst@gmx.net>
 <20240630153652.318882-7-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2tl7zqzcymelkodz"
Content-Disposition: inline
In-Reply-To: <20240630153652.318882-7-wahrenst@gmx.net>


--2tl7zqzcymelkodz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 05:36:47PM GMT, Stefan Wahren wrote:
> The commit 0f5251339eda ("drm/vc4: hdmi: Make sure the controller is
> powered in detect") introduced the necessary power management handling
> to avoid register access while controller is powered down.
> Unfortunately it just print a warning if pm_runtime_resume_and_get()
> fails and proceed anyway.
>=20
> This could happen during suspend to idle. So we must assume it is unsafe
> to access the HDMI register. So bail out properly.
>=20
> Fixes: 0f5251339eda ("drm/vc4: hdmi: Make sure the controller is powered =
in detect")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdm=
i.c
> index d57c4a5948c8..b3a42b709718 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -429,6 +429,7 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_c=
onnector *connector,
>  {
>  	struct vc4_hdmi *vc4_hdmi =3D connector_to_vc4_hdmi(connector);
>  	enum drm_connector_status status =3D connector_status_disconnected;
> +	int ret;
>=20
>  	/*
>  	 * NOTE: This function should really take vc4_hdmi->mutex, but
> @@ -441,7 +442,11 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_=
connector *connector,
>  	 * the lock for now.
>  	 */
>=20
> -	WARN_ON(pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev));
> +	ret =3D pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev);
> +	if (ret) {
> +		DRM_ERROR("Failed to retain HDMI power domain: %d\n", ret);

We need to use drm_err here

Maxime

--2tl7zqzcymelkodz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZoQFSAAKCRDj7w1vZxhR
xR4/AQDlMoVj1zwSuHz/bCYLp1ELUmStN8Gur4k7nkQPa0OGXwEAwA9Q9GmP0gCm
VfIDlBnxh2bhtPw45TXbzLBN26P30w8=
=U+hE
-----END PGP SIGNATURE-----

--2tl7zqzcymelkodz--


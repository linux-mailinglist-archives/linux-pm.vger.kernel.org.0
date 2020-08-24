Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A013924FC2B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 13:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHXLB2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 07:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgHXLBU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Aug 2020 07:01:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 560C2206B5;
        Mon, 24 Aug 2020 11:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598266879;
        bh=6SZzRMN5GGlyh79co29gSLTZO76H+8JYL5VE28sGF20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e23Bob6o6Xo0hBCl442jnXgXQlakT98GnZpvR/3dAMkOWhgYz0m51RsIAvILsTzlg
         1qScDMQv4rSd6Go0kH9xUQkOIomoMoFi6WN0w2dPPPhCgmOPc0yvIWeU2vNQ8w2qfJ
         vRNQJmC6J0WQWl1hlDoM4WBydqnrrehLjrrRhP2Y=
Date:   Mon, 24 Aug 2020 12:00:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/6] regulator: Add regulator driver for ATC260x PMICs
Message-ID: <20200824110045.GA4676@sirena.org.uk>
References: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
 <8da70f0b19de17fb8edead7ff06461ae2451b0e9.1598043782.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <8da70f0b19de17fb8edead7ff06461ae2451b0e9.1598043782.git.cristian.ciocaltea@gmail.com>
X-Cookie: Weekend, where are you?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 22, 2020 at 01:19:49AM +0300, Cristian Ciocaltea wrote:

> +static int atc260x_set_voltage_time_sel(struct regulator_dev *rdev,
> +					unsigned int old_selector,
> +					unsigned int new_selector)
> +{
> +	struct atc260x_regulator_data *data = rdev_get_drvdata(rdev);
> +	int id = rdev_get_id(rdev);
> +
> +	if (new_selector > old_selector)
> +		return id > data->last_dcdc_reg_id ? data->voltage_time_ldo
> +						   : data->voltage_time_dcdc;

Please write normal conditional statements to make things easier to
read.  It also looks like this would be more robustly written by just
having separate ops for DCDCs and LDOs, this could easily break if
another device is supported in the driver.

> +static const struct of_device_id atc260x_regulator_of_match[] = {
> +	{ .compatible = "actions,atc2603c-regulator" },
> +	{ .compatible = "actions,atc2609a-regulator" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, atc260x_regulator_of_match);

We don't need compatibles here, this is just reflecting the current
Linux device model into the OS neutral DT bindings.  Another OS may
choose to split regulators up differently.  We should just instantiate
the regulator device from the MFD based on identifying the chip overall.

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9DndwACgkQJNaLcl1U
h9CXoAf6AzUFwxgd0S5ClrLwTuv/z8XNl93mNAnQI+Lgte0VWytWqrO+qCtOPcAq
sQgGC4jUOMfZR2vcx+UGMuCCoYjDO75ApLLyN4Z79wUeNApY/VVVoSpMCy1/yvtf
wneUL9d6TNL0S/Po6/RBm0kII2vbhPcRXdJxGo1JAefjao0cc6OC7ep6OtxsnQF9
sr9aCXfvloI95sl6bc/QVaWqd5/dP7WuPINxzY6Xd20TJ4bL9gVmwv87uBdZXLZZ
8jjoAg+/7ma13fxdt7CuaGJLuXZNW+WusMKy/Bx5CqFwqpDkEPuRpA5zXXPI8/5c
axFmXEOlJ7MAB8WZg4fNbeBHCsbekg==
=H2HJ
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

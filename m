Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841D66952C0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Feb 2023 22:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjBMVLW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Feb 2023 16:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjBMVLW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2023 16:11:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178421CADB;
        Mon, 13 Feb 2023 13:11:21 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CC14766015B7;
        Mon, 13 Feb 2023 21:11:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676322679;
        bh=RkEUPNhLOk8pBPmypH99mFbmtIcOi4Up8+lGHvGYceg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jDEEi1naQMhZ5lgMROZ7RwY3XoF75H5JPNghguTcBUniawtsDhATUf9ktVaxZZrOm
         8nlsZit6LTQQXRpyZfccLwBjgbTz+bscQVIgTDtHAZ7SL+YCbmohQKIFtGLpmeTF5i
         c8bdXsmtC+maNj66fpWUoiU3F2aq0KaKvHzjlvodnM9rVmM2FNbx/FL0knsDunRwgk
         CVhntBGTAQ2f/gkTnsGIVc+RQ/I38mXpPNy0Gyt/mKQZ5Vj+T7S2OB50wqfhe3E8Lu
         MATyrddq84VqzylIEDU4HSfCGdupnlGnS2EmLBnmQfdWZ5EBjk7uhGsIn4UBSFadVf
         pPC8FPqdS0xhQ==
Received: by mercury (Postfix, from userid 1000)
        id EE08110603FE; Mon, 13 Feb 2023 22:11:16 +0100 (CET)
Date:   Mon, 13 Feb 2023 22:11:16 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH v2 2/3] power: supply: Add Lenovo Yoga C630 EC driver
Message-ID: <20230213211116.jeecwu3m5edkqxy2@mercury.elektranox.org>
References: <20230205152809.2233436-1-dmitry.baryshkov@linaro.org>
 <20230205152809.2233436-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uccsrmrntziybdlz"
Content-Disposition: inline
In-Reply-To: <20230205152809.2233436-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--uccsrmrntziybdlz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 05, 2023 at 05:28:08PM +0200, Dmitry Baryshkov wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>=20
> The Qualcomm Snapdragon-based Lenovo Yoga C630 has some sort of EC
> providing AC-adapter and battery status, as well as USB Type-C altmode
> notifications for Displayport operation.
>=20
> The Yoga C630 ships with Windows, where these operations primarily are
> implemented in ACPI, but due to various issues with the hardware
> representation therein it's not possible to run Linux on this
> information. As such this is a best-effort re-implementation of these
> operations, based on the register map expressed in ACPI and a fair
> amount of trial and error.
>=20
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

[...]

> +static bool yoga_c630_ec_is_charged(struct yoga_c630_ec *ec)
> +{
> +	if (ec->bat_status !=3D 0)
> +		return false;
> +
> +	if (ec->full_charge_capacity =3D=3D ec->capacity_now)
> +		return true;
> +
> +	if (ec->design_capacity =3D=3D ec->capacity_now)
> +		return true;

For other platforms I've seen the current capacity sometimes
reaching higher values than the full charge capacity, so it's better
to use <=3D here.

> +	return false;
> +}

[...]

> +static int yoga_c630_ec_query_usb_event(struct yoga_c630_ec *ec)
> +{
> +	struct device *dev =3D &ec->client->dev;
> +	int event;
> +
> +	mutex_lock(&ec->lock);
> +	event =3D yoga_c630_ec_read8(ec, LENOVO_EC_QUERY_USB_EVENT);
> +	mutex_unlock(&ec->lock);
> +	if (event < 0) {
> +		dev_err(dev, "unable to query USB event\n");
> +		return event;
> +	}
> +
> +	/* FIXME: handle the returned event to set the Type-C properties */

I guess this is more of a TODO than a FIXME? :)

> +
> +	return 0;
> +}

-- Sebastian

--uccsrmrntziybdlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPqp2sACgkQ2O7X88g7
+ppzeg//bShc3n3PY56ImQh0MpNymWBp1nCUcY6I6iQIRmNE00ezHD79aAz4NfOF
pUQ8j5aTksulobZ7JOE9DlNHvmYa3ges+ueMujDnEclae4lBo9YcLQoYORBKanS7
yQrqxVoL//rWLa8ObYDUYnpAc8rrF0NTwdSazWhqHif3sXcgWFGpfyQwcPnEK2yn
Oj2YQ5FSA3GZao3ip3fkHke2Grk9nouyS3kWUqU/1muU6YoHb4QAAk9h3kfS/Z/n
5ZaSx3hPPybcixmHglFAebPAmPtKiAjnSkW+TFCCrWYDLY/ea2+lKSNWZX1lNYVf
9ye+tewmY0laYYPBEP4DPKys9208lWe22yKkXiXnBtd8Vpuvzo2W5lxH4ZaAMEE+
om0Gp9pgDsJ7u7LSYuKGq7X/z/HJyi3PcInJeM090+oATyBBZK/zXOA+ZrkLQMmL
YHh/T+j9/E7I7vq+D8pthjGEqtLPq52KOyWc2GLxJiUGXVn489SsmXwUlMjhCj60
zO+sGwGJsu9rLr39YTq6D2DDBpp41ypm1cYXyC4v9vfgdINsrO3XlhieMPASufrs
LJY7WRu4Ijz1Hjr7f0alC+l2LmuRxR9M1t1SpPhBzmc26GpOtHBgtghdCKoMJxgw
wTywvfvwCuQSwh32H7Bob4qB6EWojIfmgYgI0mqf6DKIYqfFAMs=
=0Txj
-----END PGP SIGNATURE-----

--uccsrmrntziybdlz--

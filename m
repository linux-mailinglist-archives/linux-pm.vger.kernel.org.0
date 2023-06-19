Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699DA735F54
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jun 2023 23:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjFSVoL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jun 2023 17:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjFSVoK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2023 17:44:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209A3E71
        for <linux-pm@vger.kernel.org>; Mon, 19 Jun 2023 14:44:08 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 66ECB6606F13;
        Mon, 19 Jun 2023 22:44:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687211046;
        bh=acq6VLeObJYRb/VQhM565sP+oYqu3zrWLyIz7DKxh20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSkPxCcLCkisXOdDu4NTZ1aUxAzwWj/6+SleTYoAUlam3N4vmPzI47c3zSz4cNdKP
         m0hPbgFbaGCsyMXKtpzFejJ4n10eBBerFYVcr7OX0Fpy2RRmiLhIdpOv3OZea/lYrX
         fJ+jdbOWFBhz3seJPYd84/BIrRWJHCsC8UgBhHjCAQaA6ONCy0MpNE/gwWLzI7qS0g
         UZOo/jdMuh7NNqchWDfZQSQpazqYO6enMoJv/JOJDjXBgxOsTGjFItsZ4QaL8yEgfw
         ekS/yybZcvjajmHJaTiX0MHS1f6hx5fuyq9GI1hqPgsxweubsrUTkh0Ur5pEYj0FaL
         t9yGJbYDI5oYQ==
Received: by mercury (Postfix, from userid 1000)
        id 7AFD810614DE; Mon, 19 Jun 2023 23:44:04 +0200 (CEST)
Date:   Mon, 19 Jun 2023 23:44:04 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v3 2/2] power: reset: at91-reset: add sysfs interface to
 the power on reason
Message-ID: <20230619214404.tnst5elhhyr7d754@mercury.elektranox.org>
References: <20230616135252.2787679-1-miquel.raynal@bootlin.com>
 <20230616135252.2787679-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c25yaveepngxqhcy"
Content-Disposition: inline
In-Reply-To: <20230616135252.2787679-3-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--c25yaveepngxqhcy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Jun 16, 2023 at 03:52:52PM +0200, Miquel Raynal wrote:
> ...
> diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
> new file mode 100644
> index 000000000000..a59d035f1a77
> --- /dev/null
> +++ b/include/linux/power/power_on_reason.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Author: Kamel Bouhra <kamel.bouhara@bootlin.com>
> + */
> +
> +#ifndef POWER_ON_REASON_H
> +#define POWER_ON_REASON_H
> +
> +#define POWER_ON_REASON_REGULAR "regular power-up"
> +#define POWER_ON_REASON_RTC "RTC wakeup"
> +#define POWER_ON_REASON_WATCHDOG "watchdog timeout"
> +#define POWER_ON_REASON_SOFTWARE "software reset"
> +#define POWER_ON_REASON_RST_BTN "reset button action"
> +#define POWER_ON_REASON_CPU_CLK_FAIL "CPU clock failure"
> +#define POWER_ON_REASON_XTAL_FAIL "crystal oscillator failure"
> +#define POWER_ON_REASON_LOW_POWER "low-power condition"

IIUIC from previous discussion this should be:

#define POWER_ON_REASON_BROWN_OUT "brown-out reset"

> +#define POWER_ON_REASON_UNKNOWN "unknown reason"
> +
> +#endif /* POWER_ON_REASON_H */

Otherwise LGTM.

-- Sebastian

--c25yaveepngxqhcy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSQzCEACgkQ2O7X88g7
+ppFRRAAlPbAX1UZ6USuMyGAcKABb/dlIjFznXWq7M4DAD4U//pFE1O2aikOpXRu
dMSFPeQsi5N9eStDBYFaD4psa7goPIkUVTn/k7tHX358KTN0voAAOHkjz3ANO2eR
SATFZc+aau+z1hWPo80GUVorzhOil9YG7rR3fZhZMYX3nB7BY3HCVMlmubbkBZV9
XjH/77/5UDgMH5hNK1J95jpJygZSgbpnuibwIPPlpj8IiRVRLO6CvKMw5K46hnZD
h6J0NNmAJA7PFaR4QnLaN7EYwZUjmIzxPyPlGrfVb66E787fq9CMEhLvyw+s8opa
kWX9COsjjZahaddW4uEqB6bS65m46dNKQG1F+Hc8dLs5F+UED13FbRt/KQxpaVXa
KE9BOUYGWZqYopHa2peRbwPw87U3UU2yV9tjpr5KTBmq02tx1CiTuxbWdaXinhJB
gyJmKrLvwSMRUjGRZRamIr12BSSknpgdMT+GgtzBuBhq1LUXYzV+f7cTcMaStFw/
MJ+LYRJnTvIibc+O+H6D4WESZ6zwg9gU2mfdqFjGOJgjLt4hHo+L4H7O9HXgsPwS
Apalbk0tYaU77iFddEDJeGO6yoJ5ZwLIx1OuBrl5aUvrvU75YUxJPdBP0nKFTWVX
w8hprEc5PR9kgudGBRsR0hOWfUg6xYTqCiBDD7sXwkn/kUn2rOw=
=JXTF
-----END PGP SIGNATURE-----

--c25yaveepngxqhcy--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E65D680154
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jan 2023 21:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjA2UUs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Jan 2023 15:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjA2UUs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Jan 2023 15:20:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C09E14E97;
        Sun, 29 Jan 2023 12:20:47 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 04DEB6600869;
        Sun, 29 Jan 2023 20:20:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675023646;
        bh=2oLnfCE7coxknptZXDnL1evYxTjdQpQWRqH3kXVpgBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6QVIW1CUg0SkNwXco+jZi/z8RR1Qmn8TYOG0kE3NxVSU4137YaDbRXQkdSN0bu5W
         424QmwjJHwYtyC4ILeC+q4QQ0X2gQAPhg33RsCFRAchcjoC2Xvv7V6gP7qN26Rzja5
         992cKykG0cr3J01WQmbEcphzGGMqldPjH8mExrZSrG2qXmuLgk1AUDPywgzETS7agk
         g24neFu7WmGGt+l7PnLj0oWg91j3V3vXC29xh+g/1haEShWwBgW7MTuIF6yaFxrkb3
         N0vxka6G+EsQFWW8OkZhOBtjXNEQDoLVhwSftb3A0mct+xQmo9k9YHbowfb2xyjD9c
         rxQ+OmQd3d52Q==
Received: by mercury (Postfix, from userid 1000)
        id 4D04F10607D5; Sun, 29 Jan 2023 21:20:43 +0100 (CET)
Date:   Sun, 29 Jan 2023 21:20:43 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/2] power: supply: add Qualcomm PMI8998 SMB2 Charger
 driver
Message-ID: <20230129202043.w6mylxeccz2fyxl2@mercury.elektranox.org>
References: <20230127230506.3140297-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kz3ypdr3c4nspgz3"
Content-Disposition: inline
In-Reply-To: <20230127230506.3140297-1-caleb.connolly@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kz3ypdr3c4nspgz3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I tried applying this, but it generates a compiler warning:

On Fri, Jan 27, 2023 at 11:05:05PM +0000, Caleb Connolly wrote:
> [...]
> +static int smb2_probe(struct platform_device *pdev)
> +{
> [...]
> +	desc->name =3D devm_kasprintf(chip->dev, GFP_KERNEL, "%s-charger",
> +				    device_get_match_data(chip->dev));

drivers/power/supply/qcom_pmi8998_charger.c: In function =E2=80=98smb2_prob=
e=E2=80=99:
drivers/power/supply/qcom_pmi8998_charger.c:979:62: warning: format =E2=80=
=98%s=E2=80=99 expects argument of type =E2=80=98char *=E2=80=99, but argum=
ent 4 has type =E2=80=98const void *=E2=80=99 [-Wformat=3D]
  979 |         desc->name =3D devm_kasprintf(chip->dev, GFP_KERNEL, "%s-ch=
arger",
      |                                                             ~^
      |                                                              |
      |                                                              char *
      |                                                             %p
  980 |                                     device_get_match_data(chip->dev=
));
      |                                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                     |
      |                                     const void *


Also while fixing this please also do the following change:

> +static int smb2_init_irq(struct smb2_chip *chip, int *irq, const char *n=
ame,
> +			 irqreturn_t (*handler)(int irq, void *data))
> +{
> +	int irqnum;
> +	int rc;
> +
> +	irqnum =3D of_irq_get_byname(chip->dev->of_node, name);

irqnum =3D platform_get_irq_byname(to_platform_device(chip->dev), name);

and drop <linux/of_irq.h> include.

> +	if (irqnum < 0)
> +		return dev_err_probe(chip->dev, irqnum,
> +				     "Couldn't get irq %s byname\n", name);
> +
> +	rc =3D devm_request_threaded_irq(chip->dev, irqnum, NULL, handler,
> +				       IRQF_ONESHOT, name, chip);
> +	if (rc < 0)
> +		return dev_err_probe(chip->dev, rc, "Couldn't request irq %s\n",
> +				     name);
> +
> +	if (irq)
> +		*irq =3D irqnum;
> +
> +	return 0;
> +}

Thanks,

-- Sebastian

--kz3ypdr3c4nspgz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPW1RcACgkQ2O7X88g7
+poYLQ/9Hd4wxvgwNiZiE2TRpiZH96RMIkw7PSQ0mK4A+kuesFSU2XnrGTx+LRxa
9lmLWFPVmP3PNcOtCJRj215zOsO1D0y+Rva6AE0uO6wH3q8QC7HLzdkSstcTC1/T
4n4CYRhWyfkEK4HSXoDfNQdoHlbtAwDJo9KHR1eVvIOz1XzJ1HfY6AG22rTE6h14
ZNKK6prawJ8uLqD3lH9ho0MzmTXXcchW/grf47xehDkjEdMcnfpXP5rkGAvKOFMt
THrf9wITZ6kiC6uBdNfXG7PdYIi1oXXYuBSPYkGg9ebRob1Ch0/k4kEYrde/1NBu
JVUL5Zc+Bw0RjLbiX/CDPpOSSEqcDWuf9gyMTmll/YKfjZmcLTmg9oc1crvZ4BON
RywS7aizdc9Q/7qcPw8dtbPuMkXlg+dPosSpkhKD4TcTwd8TT0PxrrLutg4sGjUY
DGQfbCf55FiVYiwV1y3e61+ENCu2EIK+SzzCTI5hYtcZAK/uRVIlU/DLDl33iw+M
VuKiowJr82m1gu8NXuuPOxWN4jZnF2p5N0cmR7Mm1UIZMfPL7hASVvKM2GA8o0qA
uvezyQtbPPIARCOs924y7Bg7oeWPYiWxWr17h3zY31zzxDSHI5v9Nh5bzvkfvb+s
EA1PFNY59QL+o2couDZBC+8Y56paAoFjlyJytYxDU7cWAOE5gGQ=
=s/qD
-----END PGP SIGNATURE-----

--kz3ypdr3c4nspgz3--

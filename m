Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7564572A305
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jun 2023 21:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjFITXf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jun 2023 15:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFITXe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2023 15:23:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109832D52;
        Fri,  9 Jun 2023 12:23:34 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5BFD16606F38;
        Fri,  9 Jun 2023 20:23:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686338612;
        bh=R8Vug+mkzlvEeO3yXLCmsvhRYtBp1Bs7S/Dg8tIVXLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aU/3hf34cYYIFchX17WHwib2QDM+YqklJ91L4jWeln77CsyJLrpO7JO0QLTdLZUSc
         Qx+/STea95C/5/UuU1aNbZmjkHuZJn3LX8DFRabQ3glMxo4YP0TyQRPpIwZB1q3mhZ
         DA27pHnRqCOnuSh262iGbN9I/H8lw8KtCA9Qj5lKHbfhp6KoAZ5Go0e08MHGbggtpW
         ShLRmOc3Nn64xQ2D28RkuiDOh8Z9xOImBP9qleeUNUghZzBNrgTb33tGHoKi9rPij+
         ObsmoHs4+EXlpPJCPTV50R/PxPzWqBnVkToM0cCHP7/7R/oKw/SMjem0iZfD+AB1o6
         yMMeKfyoTW8Hg==
Received: by mercury (Postfix, from userid 1000)
        id 1452C106118A; Fri,  9 Jun 2023 21:23:30 +0200 (CEST)
Date:   Fri, 9 Jun 2023 21:23:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: power: reset: qcom-pon: define
 pm8941-pon
Message-ID: <20230609192330.tlbjmtmglb62gjgk@mercury.elektranox.org>
References: <20230609022553.1775844-1-dmitry.baryshkov@linaro.org>
 <20230609022553.1775844-2-dmitry.baryshkov@linaro.org>
 <168632956664.1263392.15400080254479022707.robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hpujgymc7hahrz7o"
Content-Disposition: inline
In-Reply-To: <168632956664.1263392.15400080254479022707.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hpujgymc7hahrz7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 09, 2023 at 10:52:50AM -0600, Rob Herring wrote:
>=20
> On Fri, 09 Jun 2023 05:25:50 +0300, Dmitry Baryshkov wrote:
> > On PM8941 pon doesn't store the reset reason. However we still need the
> > wrapping node for pwrkey and resin nodes. Add bindings for pm8941-pon
> > device.
> >=20
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  .../bindings/power/reset/qcom,pon.yaml           | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >=20
>=20
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, queued.

-- Sebastian

--hpujgymc7hahrz7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSDfCoACgkQ2O7X88g7
+pr99w/+IfN6mXM1m/HKF811iGqCNyrnlmJXVGRlhbeSQ218fR3VP2FPsgDrOPjm
eifklowC0TT+JNahTALA2Vohq3niGK5TSpTM4jNDAfZHsaVo2phqCiMtztKkZ5bb
x1dGxJdigSBGDsYkBpE15BiRrRljRD+b8XuX8CZZsQgykuz4+b9oYvBrPhfXthRm
9hgbEj+SvAR/I3+zudkAYNlaKquzILpoDyg2fLn0fkReU1L3mGu8UYEa4rc3qu/o
DoITWhXzboLKhJtsmdCV2SrCictluQJaf2FffIacWzhMa7mGgFlbE1TaTNQ+vbLy
lVKZzvqt8SDCQPboIIw5Gus9fck5bRJsf6woexH19HzEbouu8hurvRO1KlQVPTAu
WAjmolyiPzL+DlVEJNBS66EcuG1W2jBlPJJtNeuhXsZ/xWxq6jYPiyg5RBNAIIxp
obddlwQMdgTpSUJYV7nXQCofIPBhfeV96Ca7Q+o6ClHfZWVZg2+bchve4L2XtcgU
+hBc+uYtQyMGxEtsv3DPi7KArf9V8tIpXUbElBAlGrlU7d/ZSC5RSfGb1PJBu1pN
mi1VVu1QSXVdVIGHcGD1xaGZJ/pGRrSWqxN6G6NZKe/33bYzV9+BBpLao1Wo0XtN
MuD7eVsTf4LN+MbsWiUNo+oUYK9BDJn7ifgvw4IrBceeSumQoqs=
=t4/P
-----END PGP SIGNATURE-----

--hpujgymc7hahrz7o--

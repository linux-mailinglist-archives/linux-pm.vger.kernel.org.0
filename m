Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464B6545530
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jun 2022 21:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiFIT5Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 15:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiFIT5V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 15:57:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7546B1E9;
        Thu,  9 Jun 2022 12:57:17 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7D815660168F;
        Thu,  9 Jun 2022 20:57:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654804636;
        bh=RQQb7BmIektz/FsEL8cchJ+lkAHGyM8a4PfysX6zqow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BreZkrOQBydylDoZnlnE/hdoxTtyFRds91CvEpMaON93f64ZSOormVTr6Jh5+Suwq
         uZVQGhErvpzC/ePWKaurMc5t0vJkghMZbO0orQyEFGbHpGLsZdlZuT2qqFj7yetuN+
         UidtzfQWOGwVbrFVH/cxE1rj56m5gkekg0/S5qJBDuNqWYUNDbtSyjMxVIgPnPNgfX
         V0CClFFA23WqU5q/0f9XcUZLZ0mwBFBO6q1aCoe0pe5GxoPXJlR5nX+5nAxe2FnScT
         D2rUZkh7j8jG0jP+Na0a6ME/0EwD9GUE3cGfWZF0wk9FAQu4z/kJhFByPFa6plfHW6
         PPJj799p8ZyPA==
Received: by mercury (Postfix, from userid 1000)
        id B936C10605B9; Thu,  9 Jun 2022 21:57:13 +0200 (CEST)
Date:   Thu, 9 Jun 2022 21:57:13 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     corbet@lwn.net, robh+dt@kernel.org, vkoul@kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        David Collins <quic_collinsd@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: power: reset: qcom-pon: update "reg"
 property details
Message-ID: <20220609195713.u762ie4lav47fhsc@mercury.elektranox.org>
References: <20220606200203.22938-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s6475kpyxxjrzego"
Content-Disposition: inline
In-Reply-To: <20220606200203.22938-1-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--s6475kpyxxjrzego
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 06, 2022 at 01:02:05PM -0700, Anjelique Melendez wrote:
> From: David Collins <quic_collinsd@quicinc.com>
>=20
> Update the description of "reg" property to add the PON_PBS base
> address along with PON_HLOS base address.  Also add "reg-names"
> property description.
>=20
> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>=20
> New patch series to sperate this patch from applied patches.
> Last comments from original patch series can be found
> https://lore.kernel.org/linux-arm-msm/27515993-18f3-8891-4835-9b6a8d7f86b=
0@quicinc.com/
>=20
>  bindings/power/reset/qcom,pon.yaml | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/bindings/power/reset/qcom,pon.yaml b/bindings/power/reset/qc=
om,pon.yaml

uhm... the path is missing Documentation/devicetree prefix, so this
obviously would not apply. Then you missed adding Krzysztof to CC.
I will not apply this without an explicit Ack from DT binding maintainers.

Also I suppose GEN1/GEN2/GEN3 is something that can be inferred from
the compatible string, so the binding can limit the allowed options
based on that.

-- Sebastian

> index 353f155d..1d8cf900 100644
> --- a/bindings/power/reset/qcom,pon.yaml
> +++ b/bindings/power/reset/qcom,pon.yaml
> @@ -26,8 +26,26 @@ properties:
>        - qcom,pm8998-pon
> =20
>    reg:
> -    maxItems: 1
> +    description: |
> +      Specifies the SPMI base address for the PON (power-on) peripheral.=
  For
> +      PMICs that have the PON peripheral (GEN3) split into PON_HLOS and =
PON_PBS
> +      (e.g. PMK8350), this can hold addresses of both PON_HLOS and PON_P=
BS
> +      peripherals.  In that case, the PON_PBS address needs to be specif=
ied to
> +      facilitate software debouncing on some PMICs.
> +    minItems: 1
> +    maxItems: 2
> =20
> +  reg-names:
> +    description: |
> +      For PON GEN1 and GEN2, it should be "pon". For PON GEN3 it should =
include
> +      "pon_hlos" and optionally "pon_pbs".
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      anyOf:
> +        - const: pon_hlos
> +        - const: pon_pbs
> +        - const: pon
>    pwrkey:
>      type: object
>      $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
> --=20
> 2.35.1
>=20

--s6475kpyxxjrzego
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiUJYACgkQ2O7X88g7
+poOMA/9G66Nb8kSBWXvKmSMvbcCkF37B+tf5WJC++z5qhJmvNRB+HZNMcEZh/Xm
y7YgZiIcfuTIhl6N4vJjodobDlz7NdhH9s9WCMdllIrmQsObkIpRyDsf819erOkB
YFwSiKGumqfDenLedqTp0Rr5ELyiLyCgMxqH+EZxxAaCEoxHNw9zGMkP1htsa0AS
MJord0axgPM81d873R7QrD0GnQnk548CL0QKJEC47MoYQaWZgxYSq1KBBxrqhUwC
cK5SlUjSpDY0tGF3UEsOkXZHZLzoU8t1CaEpEseMmjEQNSeX++M5zumvjFMsCXh8
VlktuzIe/6nP2i8NbvDbuh0wXgk/J1msktco8D14EEsC4EIdkixQccgYYiRglWzH
DjrlzBcRQnkLHtyNsK3F4SGf9SVpG0m9MtMcVrpYnzqGmcDYDcAeRM5icBPK7425
tURbJHpljNn7IcC10XXAG92TnpbdTeT/akMt+nCFakSjwLuUo6fER3JECH2TeXKH
QEVyfd5b6NdUIXJ36+mHiA9W6i2CCvEB1VLjSkT4KehiTXv0WY6IB93RE0Tsub/w
hN9sYA9XVgfAjwxL7gLfG4ZFt2a7YHfgODwKX2UPl+tGjF9KN/ilaXAeyUhsUzC3
9x+KEXYrw9HNrNXQqEdB3mvmRMTdpOP/d/LkOCeKHGfwbMFJI/w=
=6fzu
-----END PGP SIGNATURE-----

--s6475kpyxxjrzego--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D0F359E13
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 13:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhDIL6G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 07:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhDIL6F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 07:58:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B04C061760;
        Fri,  9 Apr 2021 04:57:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A26831F4659F
Received: by earth.universe (Postfix, from userid 1000)
        id 0F1A63C0C96; Fri,  9 Apr 2021 13:57:48 +0200 (CEST)
Date:   Fri, 9 Apr 2021 13:57:48 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     skakit@codeaurora.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        Vinod Koul <vkoul@kernel.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 3/4] dt-bindings: power: reset: qcom-pon: Convert qcom
 PON binding to yaml
Message-ID: <20210409115748.xfxukqgoyvscgpln@earth.universe>
References: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
 <1617881469-31965-4-git-send-email-skakit@codeaurora.org>
 <20210408130001.k3qbq3vvwkiyykzv@earth.universe>
 <0cb9b3503000ac7206f4a3ef5fd16c17@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ioziho372aqje6wl"
Content-Disposition: inline
In-Reply-To: <0cb9b3503000ac7206f4a3ef5fd16c17@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ioziho372aqje6wl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 09, 2021 at 01:48:58PM +0530, skakit@codeaurora.org wrote:
>> Please do not drop the example :)
>=20
> As per my understanding on Rob's comments [1] I have added one complete
> example in qcom,pm8941-pwrkey.yaml (see patch 4/4) and dropped it here.
>=20
> [1] https://lore.kernel.org/patchwork/patch/1390062/#1588027

Ok, please add a note about this in the commit message.
Something like:

The example has been removed in favour of full example being
available in the qcom,pm8941-pwrkey binding.

Thanks,

-- Sebastian

--ioziho372aqje6wl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBwQTsACgkQ2O7X88g7
+ppvxA//ZDqA2HcgKmkY/5edbV1Mv2x1kz92+zc6n7n8g0HO5qCxbIDi0BVH+O9X
OPP6eoyMRa2zTcKh9Z9j/KxRVNSx7ntnIm9CS/q8nDD6f99tyCCUTcNcHsd0QC0I
Ff4T4FlGYVWwbyb3p5Qly2YaAAngd5C6zV1ln9RtKOUJs+eJxfy6lluJwSgyPPGq
ssQtuRpUdq7Ql9vuxbHa5fMzFlwvibz9UYKMfNTxIc8KU/E8NtZVegtP0q1GDX0O
Df9iNLTAYcN1olyG5gTo9223kPFwcuJtGAHMVrORjpXsmrY6kznRWtRVEB/YBZE6
8pihnV01bgdalxXkn17VvBulRzUERYzXTaLUC0z90BI9/qg8ZeUgWAk7O4TGBiuF
vo4TERUhwbI0KwOwaQ1F/qHVSlJN6XQiiq9MB5Pr7SxzNdvcCp6p6OBmGyjWhBwU
jb/0XOBG9n6C8MNjwc6GGyM6W92Vd7jRca1RRvPQaXWTKX8zijFvdXKhKgY4DCAy
yxtHKsxqUDi/uW6rQZYh1jDVKTjN4MbTJoXdlNfyHU2nkijBDKWJumtxHh5tetj4
W+ouewINUSGbpzyeiHLHWXXnPXBetuh8OOA9J3IF39wFJzp2O5kAdnpcQ35QhvIz
zc0tY9CRl4/dAl4UMezOF9RTtWIeuA0h0U0dmc6rnrnwGY4ibFc=
=KCef
-----END PGP SIGNATURE-----

--ioziho372aqje6wl--

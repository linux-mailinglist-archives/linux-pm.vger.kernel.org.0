Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D01337647E
	for <lists+linux-pm@lfdr.de>; Fri,  7 May 2021 13:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhEGLa7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 May 2021 07:30:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52890 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhEGLa7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 May 2021 07:30:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 11BD61F43F80
Received: by earth.universe (Postfix, from userid 1000)
        id 44EFD3C0C96; Fri,  7 May 2021 13:29:56 +0200 (CEST)
Date:   Fri, 7 May 2021 13:29:56 +0200
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
Message-ID: <20210507112956.3ibzuinvzd6d5rku@earth.universe>
References: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
 <1617881469-31965-4-git-send-email-skakit@codeaurora.org>
 <20210408130001.k3qbq3vvwkiyykzv@earth.universe>
 <0cb9b3503000ac7206f4a3ef5fd16c17@codeaurora.org>
 <322cbdbb022fec3f43c1cbe13c532dd3@codeaurora.org>
 <20210427083721.heavcdadeb4ajkk2@earth.universe>
 <a190e414c53af3ea094548f5011c3a04@codeaurora.org>
 <be3573974d76d7e464048b34854416ad@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ix4wlrl34amaeftv"
Content-Disposition: inline
In-Reply-To: <be3573974d76d7e464048b34854416ad@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ix4wlrl34amaeftv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, May 07, 2021 at 03:15:55PM +0530, skakit@codeaurora.org wrote:
> Seems like I have to make 'additionalProperties' as true in reboot-mode.yaml
> I have checked other yaml binding docs where allOf is used, and they have
> 'additionalProperties' as true in the file which is being referred. Please
> let me know if this is not correct way to do it.

Yes, reboot-mode.yaml should have additionalProperties = true. I
think Rob missed, that the binding is a generic one when he added
it in f84e2c5c528d.

-- Sebastian

--ix4wlrl34amaeftv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmCVJKoACgkQ2O7X88g7
+pqZqg//bAl15lpGbh5wgVjf5oRwoIJT0FsA2CjTDNeaNO9xiVJhMfQBPWzqmAhB
hKN6XC4DSemLD7BKsPgIWYTsJvNyQi7wEZKLO6G3+R6Q+bEp4Ry30Cf/heTXw76y
41udUW+UvPXY1p/v36Xyhidirt4gPfIHTTKEyQ9WEHlDI+J4TjPrH9CaU3a8FwAc
a5/73gv5OZn4tSLEfbK/VLC7OOMkGrv4zzm+GZeDfeAhv51psVGXUTp1g2UtI70j
1IlxeMNUus/dSNHqPVUmUndKWhFRAcm4xpjzz3ArGOGYcAXjG5uZzc7hdl5x3APf
Fj56H//aEn/ERAt0zVJMY+tmenq/XA3hBFZZ7Y9qewz96ep7QUkOSeYe2m5xm8pr
5ChL1RuwsXdVomwpLKx6q975+9RZi7d+HtM4GymzBQ0CJaWekE2nDPhZKnZL6aoF
/BS0Il/mVhHLVzhHel9tUGOU0JiyqvcaoZI/nKTqs7mLAFk+J0v1ya3djKo5/yFT
/VlW892Rie5Prj+c8PUpCgNDBLzrBhdlsrfQZDCob81OaC6sn5KJiNnsZGXuux3n
ZzIVQXWvsoBSU8vCKwh3hIfmfnKQfR02WdAP6TDac0TB6dOKgzz05oQ56sQ8+CSM
rCE6/07o9NePc9lvoYdS6IFWLnIwLoix125kXkmVLYfOgQX4c8E=
=szSx
-----END PGP SIGNATURE-----

--ix4wlrl34amaeftv--

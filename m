Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0407D39B795
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 13:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhFDLKm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 07:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229740AbhFDLKm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Jun 2021 07:10:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2FFD61412;
        Fri,  4 Jun 2021 11:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622804936;
        bh=iwBwbt7wIWhIr085qcXizQ5aues5uWdHTOBFESM33kE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fIqXQlp74u1ZPfFJtxNGqcLSKBsMV3w03xctfdujEY3FRhyErjEkraAi80re7BmyF
         5vCx0CaDi2hTo43P9nx1aY+1h8dkhVsMVKWE7pQsd+8CbFzDe7ApHgc1rkvX7RPivV
         ZgZSCYUxcUz7Th+MRRtAgvRbfegGlNTnqe0nDQEiuznYklRqzJ1I0C6lzHMXy5yFLd
         J72mZkiWr8WLXxwDNGsy8OjYnNCny5+qdMhhAAKMWQ3zONxveacWHU/0untCOLREba
         egxlkoSMz7HgL94OOOKFcJZSbP28n2r3gMnxo1t906NS8AFwvIh1jZjc0/6eLMIFel
         dhVEPCm0+bWAA==
Received: by earth.universe (Postfix, from userid 1000)
        id 2DA053C0C95; Fri,  4 Jun 2021 13:08:54 +0200 (CEST)
Date:   Fri, 4 Jun 2021 13:08:54 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     satya priya <skakit@codeaurora.org>, linux-input@vger.kernel.org,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        kgunda@codeaurora.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH V3 3/5] dt-bindings: power: reset: Change
 'additionalProperties' to true
Message-ID: <20210604110854.6zgxe2rbqnigdtid@earth.universe>
References: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
 <1620630064-16354-4-git-send-email-skakit@codeaurora.org>
 <20210510162047.GA228385@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zeta74hijobubqw2"
Content-Disposition: inline
In-Reply-To: <20210510162047.GA228385@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zeta74hijobubqw2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 10, 2021 at 11:20:47AM -0500, Rob Herring wrote:
> On Mon, 10 May 2021 12:31:02 +0530, satya priya wrote:
> > Change 'additionalProperties' to true as this is a generic binding.
> >=20
> > Signed-off-by: satya priya <skakit@codeaurora.org>
> > ---
> > Changes in V3:
> >  - This is newly added in V3.
> >=20
> >  Documentation/devicetree/bindings/power/reset/reboot-mode.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
>=20
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--zeta74hijobubqw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC6CcUACgkQ2O7X88g7
+pql0RAAjGMGXrdsvasJs6QxGP5afvhDfYSgt9UrzZwC7SRvhDORoWc4o6YoucZY
xjr/brpzKRwZYxFlioigY5KP220UZIbP4S05N8kB2GjTe2rqxz7nT9x81ahr8d36
QSNUFkhCBLvQWFQeaRfBwoKWydW10GKax2PdPqwaIwlhIZdRijnQVpsWkmAZfjYW
Yf0HIbP3meRQ38LlzGV0nHeZPCQarfImi2ZQ7CORoWaa4lTRlrujKkWqTNT1bZZ3
Ma8HJRBJyK053m+awuvg36GQRjuHt3wDF3RFM9yL2oavkOh/rnZ14CV4IRM3v4Lw
TJ+ygl/x/oTMpbKPzeBuL+Q+2yBY5AhMCO96KwlERk+MAZ/VWuFWlGVGlLTIbqrx
82yjdS4b7XN10K51eKaTeogEYr0YIYz8Esy98JH3DHwZanVOmvGOVIfligN6/iWZ
9zqZ/L8TBQ1OweadQSCMYwpiI7sxNC3v2bi0hPcNQKyTLPiqEZJRg9nIDP91luxY
7BP7rriPdSXcSZe2+P5Rto495FMQKsuOqmIgD7Gsxn2YrCymylQ7mBaK4l/DKygw
MFW1S7bSXqmoGqfqxVkE3PswUVFOykPn5/qlRF/GwcHLY+snx//W2sVI3HFQlwNA
1w1hDaHzZHa213qdXdgnAJ4rreEZhKoch+zziWMvGnaIATaCyRk=
=V2SN
-----END PGP SIGNATURE-----

--zeta74hijobubqw2--

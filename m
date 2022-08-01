Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EEF586AE0
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 14:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiHAMfG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 08:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiHAMer (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 08:34:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3D79A98F;
        Mon,  1 Aug 2022 05:14:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ED3360FD2;
        Mon,  1 Aug 2022 12:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22CFC433D6;
        Mon,  1 Aug 2022 12:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659356070;
        bh=w0W5ZUfjn4T03h03W8oCnoYtL38becK3wr+5hEpAC0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nZRtm4AdrxPt2REmi18BgtIuUY3TOtl0nZNBkkg3g2kp3S1HeJIi7VFwKqqbkOanq
         upyR4pD6+E7mrZFUTXmceXOsPxbjRlTvVhM2Xdkcj6X4QNI0BghoBlGtv7M8RmJeHu
         Y1XQBCaVPrTlL1bGnU9N0BlD41giqTJq7+2K3tLteDuduL6+s4/QtjI6ubn3sviXhC
         W8FSlB47jNZPD4VmwCn0gQicnbeARsju/7Gb2JuVv6JUru8T9LGrpbQq+Z9XZ5Okvt
         jCU3aqs9NITWjkP2AsEPikOajB/q0xBeFk/IVrRibwN1rldyuKx0XMa1jJkIc9Yl8C
         mb5cDNm/5gjRw==
Date:   Mon, 1 Aug 2022 13:14:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: Add debugfs support to ease debugging
Message-ID: <YufDoc7VWG4e8r0o@sirena.org.uk>
References: <20220727200901.1142557-1-dmitry.baryshkov@linaro.org>
 <20220728090806.nnighsbx2lcgugon@bogus>
 <CAA8EJpr2=y-wT_HV4H5BTm7RPsc=--6C054WHJDpQzehU=Z+VA@mail.gmail.com>
 <7d9607ed-f8eb-f3a2-22e4-4d2a240919c9@gmail.com>
 <20220801095910.ngexid57qgmvhes7@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ekcJJ+0/0YVPoSLP"
Content-Disposition: inline
In-Reply-To: <20220801095910.ngexid57qgmvhes7@bogus>
X-Cookie: Dieters live life in the fasting lane.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ekcJJ+0/0YVPoSLP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 01, 2022 at 10:59:10AM +0100, Sudeep Holla wrote:

> So if we need this beyond PSCI FID range, better you have it as generic
> SMCCC debug FS. Thoughts ?

That thought did cross my mind when reviewing Dmitry's patch but given
that as far as I'm aware SMCCC isn't particularly enumerable it seemed
like it might be more of a small library of helpers than something you
could write a general structure for.  I might be missing something
though.

--ekcJJ+0/0YVPoSLP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLnw6AACgkQJNaLcl1U
h9Cpvwf8C1LP3InR0pGaYnO72+leN/x5NE9szVPZkG6SQV/WHBXcoykpbRTPzu2Q
EvKcL8yteIs2D0Yu9qWGee1uNqBi8RuEKvrot+b+lqfW8CRlLTHJDmnxuNUwHaUv
vk7vmnS7O++IkPn50AhtBYulJuGEhMEs6Ex9Vzp532UJBqou5Yf6lMPhQzGp2+wm
gNYpJvpOHkO4SPzhyOmOwJXmwici0cFYEpIpEQ+tKh1+HbhANCvBo2UoqAuSWoVB
R5MWkIvc3XS0FseIHBUEqfaNglaEGASlp+BnC/T41rR7kazfuQafRoV1OoBUBsSq
sSDJQoAZO8JOiYBLbzmVhl58hXQaNw==
=VxKG
-----END PGP SIGNATURE-----

--ekcJJ+0/0YVPoSLP--

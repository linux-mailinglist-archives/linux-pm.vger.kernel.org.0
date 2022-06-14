Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C9754B303
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jun 2022 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiFNOSf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jun 2022 10:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343875AbiFNOSW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2022 10:18:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFB32DEC
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 07:17:45 -0700 (PDT)
Received: from mercury (dyndsl-037-138-185-186.ewe-ip-backbone.de [37.138.185.186])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5B4B6660169E;
        Tue, 14 Jun 2022 15:17:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655216264;
        bh=fLfr0gpq3wR0qhWYEE4vd9rX0xSZJXGZow966g4hRXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2JunKZHqx97/61wScHb1h8HjyGdwZM0zUMlK60lYrTl1kdKvp59pmT7ZzD7QR6Ii
         cXdzzJncFsxBPRDbNsLYeGN/If6MpvzkFA9vHLr+sCwTlpXttc5K5apkwlVaej0KNh
         arZOk+MJmEOdKZEpZpJL+7XB9VJ4FSz34VIF4PUdDofDIwCS4QUTTe2lT2eYDkTxb4
         7hpRob4BA4DWpynug2ScSKNMsvw5IBnoV+3KEdxqtmrvcUlBLb1uwbPtT7n1jh6Pqa
         aMy/TP67ESi/oyI6Mj42lBY0h2M3sjHWJ5kSibplCNjxG2gBXCcdFJTgP0zOMsG811
         Er8tOFtBYoEng==
Received: by mercury (Postfix, from userid 1000)
        id 20B6110603F9; Tue, 14 Jun 2022 16:17:42 +0200 (CEST)
Date:   Tue, 14 Jun 2022 16:17:42 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Huw Davies <huw@codeweavers.com>, linux-pm@vger.kernel.org,
        Wine Devel <wine-devel@winehq.org>
Subject: Re: How to identify the primary battery (for Wine)
Message-ID: <20220614141742.j7lrj2q5b3suebb2@mercury.elektranox.org>
References: <CAMMLpeTRZnpQ8b6puhHeKaDgzW12ZM_g3nAWjVP71HbSaeHktQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l5mxh7jehpzc6ozy"
Content-Disposition: inline
In-Reply-To: <CAMMLpeTRZnpQ8b6puhHeKaDgzW12ZM_g3nAWjVP71HbSaeHktQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--l5mxh7jehpzc6ozy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alex,

On Mon, Jun 13, 2022 at 07:54:49PM -0600, Alex Henrie wrote:
> I've been working to improve battery status reporting for applications
> running on Wine on Linux. However, we Wine developers are not sure
> what the best way is to determine which battery is the computer's
> primary battery. Could you take a look at
> https://gitlab.winehq.org/wine/wine/-/merge_requests/134 and leave a
> comment there or on the wine-devel mailing list?

/sys/class/power_supply/*/scope is set to 'Device' for all
batteries, that are not powering the main system. There can still
be multiple batteries; for example Thinkpads in the 2014-2018 era
used to have an internal and a removable battery. For a single
"X %/hours left" info the data from all 'System' level batteries
must be aggregated.

> Wouldn't it make sense for Wine to use the UPower provided
> DisplayDevice that can be queried through DBus?

UPower does the required data aggregation for the 'DisplayDevice'.
I don't know enough about the Wine codebase to recommend for or
against using UPower.

-- Sebastian

--l5mxh7jehpzc6ozy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKomHwACgkQ2O7X88g7
+pr4BQ/8CPZ/mo7XzihoFLI0hEe0Q+iE9ZGKHSQMp53rRUjBLT+zoLlTuRe5JZfI
WfR4zBDTuE6NI+QSfp9qam8RNQkhR8n08fd1t0UcblRHSnLYTW47jSxVg9oKv7nK
qKRvtQexehjg/+uJXkkp0Ce7oAGULIHMpfbdNckW9KnKcF5TcSYr6UK7YADRI20/
F4oPNBb8+W/3KMy3iQyTeGqsNFaikI+d8NPQhdo5H1UzphIaogRdzV6onbK1kjV2
CHgVpLvrt4Bdj6jpKoSneRBzzxu9b9ONsds+a8An4jSKkdVDpIeZgKDcCnCzQC31
nUS7AbgfdMit8lh9uuvJHHgd7VYTNK3ff/4d0DCZiUeFy2OnVx0Qba5CjAP8kXkA
GCQemJCHTlfGFQ8TsUE1T65N6p8YqZ+LYeEulRH6iCx8pemSXyG4Y0RnKj9bEzjs
P9eOGeqxxbdycdj9UsUJ271hX1cZs1cd9JQBxizkqo+PhjQlTBU+7mTEEUp6coc/
M0hp4sdcVzRBDROD5SK7ZV2126Pl9H8qbQpxpFwCX4v4VED+gGJ9FZXleGoan+TN
qBla2yFtcXtCO/62MhFsUJaPC8qWaFTcc7tBhgMOcflzrCN43h1bJh46F1XiMlRI
1BKSajZof+UBxI1imgmEno06oaLremJwaSRfayw8m+8RqDTucyo=
=vO7M
-----END PGP SIGNATURE-----

--l5mxh7jehpzc6ozy--

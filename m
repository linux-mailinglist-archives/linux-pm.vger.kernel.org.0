Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8445154AB6E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jun 2022 10:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbiFNIFz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jun 2022 04:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiFNIFy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2022 04:05:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E342E092
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 01:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Content-Transfer-Encoding:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=EMYNRdVbWR1RJ7SWpm+ZRjSbxEaNV11bgxbs1B/77O4=; t=1655193953; x=1656403553; 
        b=V+jFY7JumwRk7K7u6u+XTNDIygh0oF1VNLZ29lgQcM7+VaMHPo+9l9ZoevmuGYQU5qB/jthcgKt
        XjW2aNxjDONuWXESZJ78sNRW7gmcoGuPk3zZyr7gPf+lcNMkD0kdUvCBWCcpJQWpqaFNvVwEag3q8
        UBSa+OSl9c2T+wos2sFKw+dSqG3Oaf8iF7jrSk/ZsQ7nzx7TVhAFteQnshxJhwQOTyKjOqjEVuwdN
        B2TMkaC3/SATCzSM685lNmqu/9gQrNBusRaqYR3kkEbpOiA0h0cTbfNidwI+DGArdmRjeg5c5jhLH
        psjzWHamKT82GOHarxb7Axj0bzE7wIjkCrfg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1o11Yb-005OXl-GI;
        Tue, 14 Jun 2022 10:05:49 +0200
Message-ID: <be17cc9d88b557b0b9dab14ca92ecd257e766468.camel@sipsolutions.net>
Subject: Re: How to identify the primary battery (for Wine)
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Huw Davies <huw@codeweavers.com>, linux-pm@vger.kernel.org,
        Wine Devel <wine-devel@winehq.org>
Date:   Tue, 14 Jun 2022 10:05:46 +0200
In-Reply-To: <CAMMLpeTRZnpQ8b6puhHeKaDgzW12ZM_g3nAWjVP71HbSaeHktQ@mail.gmail.com>
References: <CAMMLpeTRZnpQ8b6puhHeKaDgzW12ZM_g3nAWjVP71HbSaeHktQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-L+BFH08MQ7Y6sD/4QKXs"
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-malware-bazaar-2: OK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-L+BFH08MQ7Y6sD/4QKXs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 2022-06-13 at 19:54 -0600, Alex Henrie wrote:
> I've been working to improve battery status reporting for applications
> running on Wine on Linux. However, we Wine developers are not sure
> what the best way is to determine which battery is the computer's
> primary battery. Could you take a look at
> https://gitlab.winehq.org/wine/wine/-/merge_requests/134 and leave a
> comment there or on the wine-devel mailing list?

Wouldn't it make sense for Wine to use the UPower provided
DisplayDevice that can be queried through DBus?

Benjamin

--=-L+BFH08MQ7Y6sD/4QKXs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmKoQVoACgkQq6ZWhpmF
Y3Cs5BAAqsEfg2uwYyDSQeucXCUBWufCJQ2S1H+76yx4vq3a3FpBECc8OhF0r8cz
aEYZbPMQZua3BqLiToa5XZxSXIeasSndOZnfpxU6v49iCDm9yidN7GKHoDUrZHAF
oURyDKJ7DeenjR/OQtLS506N34JOJJXVLbBx8bKq1BBFZH/djkLhofSG3VSbWbj9
HqUoMiDHn8zZWb05YQ2WSQDY7yIDobLYKPGsw9FDx23w8IJ4cg3JhS2yTBCiu5gU
0yd84K3LIVValUqjgLhJAtFNCOXgM7T5Aex1u+3Q+d83S8lpNBS0qevPXjlRNnjg
sOF+2aDwCDXyK03+4m1gSNWuUUfqOHMjippHZrob8YwiYyLN1LSFwZyIMoUixP/C
7BU9B0OQ2uTea3UiaApRzY93cPRgnJtOC+VHRrGkfhLxgcwK8itn4FsbO7G6Myem
VtibyQj0zm9YSdwo5J4n6fF38NHQl2OZT2o3gaUGnkvm5uDXEub2Gn5+xxxHUFxY
JnTfHgGl84p5O1fqEO83EGAunnAfrmx7c27JEd0xn+KStJ/1vugh56cK+245YBnM
vtpv5GLL8x/JL/b3M1JE6jXXO7nsOQxAUgaY3DKdP4yifS2A7ZGMSg6sRM+2Tn6e
d8ffw4OpHmZuVnzIvaJNSnA0BWd/sfuZRAh+2fWdgeUUv7EFfAI=
=B/of
-----END PGP SIGNATURE-----

--=-L+BFH08MQ7Y6sD/4QKXs--

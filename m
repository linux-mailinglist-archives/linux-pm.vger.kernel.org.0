Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A956FF98E
	for <lists+linux-pm@lfdr.de>; Thu, 11 May 2023 20:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbjEKSsZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 May 2023 14:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbjEKSsY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 May 2023 14:48:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B6E4205
        for <linux-pm@vger.kernel.org>; Thu, 11 May 2023 11:48:23 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 413B16605862;
        Thu, 11 May 2023 19:48:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683830901;
        bh=9HaAJj6UqLqPrUyoAeUEWEvyQXPoteedSP7O+I9HqIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D5N255alssCS27h9TZRm7qAFFHQ4mGJ/0Zz+MvL+1zI391u3LDdBdwLlsKAkNK/h2
         hosj6tSG8GrQiV9aK2t5Mycg/+7uK/OgnI7dDOrPiSFa3/BnUkOwSIhglrtp69gz7m
         3iuy0wq+AYQ8YXd9HhqG2q2DhF1oqbL1mlRkf9xUmh+IfPpwrLhgBplKjBxUNK6rhl
         DyjkF5H6b6KVvQev8lUNsg23tVWEGZj+ltp6IxdqCSzqFrz/ZAFz5PIDtYr2HfXJtE
         Hfl5jr8MJ8X8HH75TwhN3nYvwV+JyTIlQsBU9iad28wqaUVxE1Nhpcog1Lh8GR6Gvo
         FGaNn3ax9/mTQ==
Received: by mercury (Postfix, from userid 1000)
        id CED081066F8D; Thu, 11 May 2023 20:48:17 +0200 (CEST)
Date:   Thu, 11 May 2023 20:48:17 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: Ratelimit no data debug output
Message-ID: <20230511184817.rgsuggdoumyvky3y@mercury.elektranox.org>
References: <20230305205226.773025-1-marex@denx.de>
 <bd24cdb6-4db4-feff-57d5-dc0cb64aff0c@redhat.com>
 <0d74f4a4-1388-a588-f663-fc7061f6cee9@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2tiyvarhzxcilpl3"
Content-Disposition: inline
In-Reply-To: <0d74f4a4-1388-a588-f663-fc7061f6cee9@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2tiyvarhzxcilpl3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 11, 2023 at 01:46:14AM +0200, Marek Vasut wrote:
> On 3/5/23 21:57, Hans de Goede wrote:
> > On 3/5/23 21:52, Marek Vasut wrote:
> > > Reduce the amount of output this dev_dbg() statement emits into logs,
> > > otherwise if system software polls the sysfs entry for data and keeps
> > > getting -ENODATA, it could end up filling the logs up.
> > >=20
> > > This does in fact make systemd journald choke, since during boot the
> > > sysfs power supply entries are polled and if journald starts at the
> > > same time, the journal is just being repeatedly filled up, and the
> > > system stops on trying to start journald without booting any further.
> > >=20
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > ---
> > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > > Cc: linux-pm@vger.kernel.org
> >=20
> > Thanks, patch looks good to me:
> >=20
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Any news ? Maybe this could be applied now ?

Sorry for the delay; I applied it to my fixes branch now.

-- Sebastian

--2tiyvarhzxcilpl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRdOGwACgkQ2O7X88g7
+pq6lBAAqLWp044jRWvLlrPUMTEMeb1cEr9F6k2efCNjEQGeGIvX7PFE0afX5N7q
SS+pSlYxMYBKHyeZRqZvmnfA816vRWUnShAieeaAnja+OqjDrhqoLGIfDyAlypAU
je6WaXUeavtMgzbPrSxSW54KB6IzYdCYIQJkxPn8XS4Qr5WzSEvn4WmKBWD0o+is
8Tc2p6hUTqmNjA6adS6YXo6Uc6kZ9jaBD6SsoW3p4RsKbvPYvwvq9uIhRyZOYLOo
PpVrY/uplr/cGl6wyaGvU19STu1wF40PfBssM4Pp/ow7UAn58zYZnVGQb5Td1hkE
lnQ6LO4HI6jixoOWtocpU2L0aCsChQh9n6RVHU6P+pq/ZIAkwE6ohUaQDvAZd+Yr
56gG21SKbKaugarXR2soEv/Zbdrb8u6iZs2T9jkunsNXDHXCFkUDj5OcSe6hMh3w
ZQZxP4wCSB0LWXiL0+cYI1ylK6Kzw4ekSP4WmA88SMhAqaSwwPfgQrlWrDXthajf
MVaTbAxM8N0TnThANVOUgrD/9hcrUVtjk2obSe7+woTkpjhCR408XU5FUdyGuLU0
uPjzQxMGTcfAl+vQ5qC04ALkXgAUu9C5rjp+gAgg1j41m9t/02Y2nysVC5Glw8kN
Qu0iGjI/QVy0EiOf2SBm2tDYBm0l9PH91x4euXvDDFPHenxvVLw=
=C7aU
-----END PGP SIGNATURE-----

--2tiyvarhzxcilpl3--

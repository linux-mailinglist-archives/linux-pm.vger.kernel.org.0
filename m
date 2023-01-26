Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842DD67D07F
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jan 2023 16:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjAZPmw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Jan 2023 10:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjAZPmt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2023 10:42:49 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083276C105;
        Thu, 26 Jan 2023 07:42:45 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso1389826wms.3;
        Thu, 26 Jan 2023 07:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTIudzk/sap+cvL0VFQMVYsgJjE4aYqHxJiayFjfITI=;
        b=OztzPncHh4VHYVKMzVFIHwAKNXl9wdu8/k2BQ88Hsac5E/jBlMXQVEaJ8AoMUJYJn8
         ojdxnzklnu87nl0GoyA4lCRqmsVqhju7mGxXpySej1CM6a+uPxSzqRJzKdwK6z4nW9qE
         VFhWbs1+Y2j9hsMHNi3zVmgOJHB+j/tzkF7juZndTbR9Be17qLz+sic5xj1K9f86L2/7
         JLr69L994+sfRD1mcXO7st6FeUUUvcACYHY/ZB9CDmmxdHoxG/zbOqrFHk3wKEAYK3LA
         cB/iEOo/TxUaNK4F7EwTuCMKaSzBeOfpHcaGqJ2JL16XJOrYfNkOWXFxC3mUmTqUFwN5
         k7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTIudzk/sap+cvL0VFQMVYsgJjE4aYqHxJiayFjfITI=;
        b=gMkeiCGTdPlVi4Z9oIvEl+0inuBSe3F0eja8dg9+ZVvnafIoVY0+hmtDhEipu+Q8bB
         K/9imJInpKR6lNB3iJRDYRz8VLqpd+cIzEKDDhgZcexPyiMcpcBoLwe2e8ibftjlFQ20
         G6pgFQLQhIata9g/cYpmghbjLqcTmbGcDE3io3Zx7xQBISv1P3lrt6qkyqHyxeYbFIt0
         P1ixqbl/OJ9r2SEPuDKxUJwCkqOYdiX3qB3bbx0EKrp0gjCtIRb4bXQyF9bExOQIavuG
         hzvTEzXMwKRLnkXKfXHZe4SyW4zAlxHDDzHM/NPTcprHqpq0HL4/n+DHqmnt4EC5SgyA
         J4mg==
X-Gm-Message-State: AFqh2krPJ+uQ/JYstNzhNiCXMy0UzzT/lTSCe52ZUmqx2Afp9cLTIApe
        dFTrSw5/6nUA3ebs7ILg/acc0pxZzhw=
X-Google-Smtp-Source: AMrXdXt09/HPPZqqiPWwzbbrl5pN9kEFhEB2eB+H/HsJQ2Id/ErjgMBMIn1kpzRrhCUMaBtZxrmS/w==
X-Received: by 2002:a05:600c:1912:b0:3db:f0a:8707 with SMTP id j18-20020a05600c191200b003db0f0a8707mr33301326wmq.40.1674747763497;
        Thu, 26 Jan 2023 07:42:43 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id x10-20020a05600c420a00b003c6b70a4d69sm1668126wmh.42.2023.01.26.07.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:42:43 -0800 (PST)
Date:   Thu, 26 Jan 2023 16:42:41 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] thermal: tegra-bpmp: Check if BPMP supports trip points
Message-ID: <Y9KfcSwYt7utbcg5@orome>
References: <20221129153914.2699041-1-cyndis@kapsi.fi>
 <Y9KTrO+WqJJwuEDf@orome>
 <a08355e1-c393-2b2e-4a44-360e08607bb9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CeHlOAIdbP7CEBGB"
Content-Disposition: inline
In-Reply-To: <a08355e1-c393-2b2e-4a44-360e08607bb9@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--CeHlOAIdbP7CEBGB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2023 at 04:08:03PM +0100, Daniel Lezcano wrote:
>=20
> Hi Thierry,
>=20
> On 26/01/2023 15:52, Thierry Reding wrote:
> > On Tue, Nov 29, 2022 at 05:39:14PM +0200, Mikko Perttunen wrote:
> > > From: Mikko Perttunen <mperttunen@nvidia.com>
> > >=20
> > > Check if BPMP supports thermal trip points, and if not,
> > > do not expose the .set_trips callback to the thermal core
> > > framework. This can happen in virtualized environments
> > > where asynchronous communication with VM BPMP drivers is not
> > > available.
> > >=20
> > > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > ---
> > >   drivers/thermal/tegra/tegra-bpmp-thermal.c | 52 +++++++++++++++++++=
++-
> > >   1 file changed, 51 insertions(+), 1 deletion(-)
> >=20
> > Applied, thanks.
>=20
> I prefer you provide an Acked-by and I take the thermal related patches.
> Especially in this period where we are reworking the framework with the
> thermal trip points ;)

Sorry, my bad. I misread this as belonging to drivers/firmware/tegra
which goes in via ARM SoC. I'll drop this from the Tegra tree. Feel free
to pick this up:

Acked-by: Thierry Reding <treding@nvidia.com>

--CeHlOAIdbP7CEBGB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPSn24ACgkQ3SOs138+
s6HPQw//WBZ1U7g3Z+foCOMwJ+ew0kA1pS1ukA5rLPrEPFXqxeRN4fMFjmUQarAg
IMprdpjZbjuNhcGqt00aeTsZ71ISt5l8e5NYKUonawStfE8P6eNJGfpTQ2kLm32w
Kg0pX4uskgvMSrgSQ5DPREGwuxs6dnzK6GTN61EjKwfjwSjOjD4Q5Dc5Kt92Bpp9
buFuER0YiaCdqacCBBWUBe0WONBU9mRk6z1icIUoKnVk9ZXnw99cri6JtILpmLNp
OkSEsDv1WdGljZ7vLNvwacmjy/jNNOr1XKXDOhszr7RAn6TKP6hbzCL2GxfNgHNL
iyRrCm5epCa/jMETqrWm+cepD4Ubc0/zYvKR07uZodQsFDxLaW8+z0e960MLY6S7
YowX6yJ99zdUNN2s1fj+lu+Nw6KLQNtxCOytmGrjCDTrHv4jD5jJgUGMEFJnXKEP
ftmuRDWGbK5hGR8pkanBjzE+FDV0xORcINBzg7ln1OJI5wMimxdScbMWcq/FEgIC
JVtzVtvfLKhkSBHonZ7EP+UM4n0XwtrJAxRgMBHCjdIt3YUYUXZ+rfSlWsNO2nKq
xtXfAJseU5zVSYJTX22rnq0lkqNOG3IgTpFGmTlADh36CvOQxdxdS/9THoLF1VsR
iUeGQtqRnARXv0SXroA2KClUf95yx5C31yxzPD4AVwBx8wMMZ/Y=
=aveT
-----END PGP SIGNATURE-----

--CeHlOAIdbP7CEBGB--

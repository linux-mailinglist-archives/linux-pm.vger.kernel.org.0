Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5275A67CEFB
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jan 2023 15:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjAZOwv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Jan 2023 09:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjAZOwl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2023 09:52:41 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31A03C3D;
        Thu, 26 Jan 2023 06:52:31 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id rl14so5757510ejb.2;
        Thu, 26 Jan 2023 06:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FFS0TUHs+Ey2oo/Ntw/o6bWjYoSrWErDLwIOZziY2k=;
        b=SCo9b17YhG6uYNEVutHv1U3BUBPv31B17bQI6uZrYVXvdsumEfWfQTViqcuRnBEHHQ
         7p1ZcjiIDJI4Pt8E4FGkGfHKD250gt/R2jZoHrSr9dbejIaufoTUYO3ATnfLkwlI0L1o
         jAsXrYs2xHOBKVFvf18kiX7cwoGL3Bhxd49p2XB0TZQ5cEe1JtAb15L/1aG67MfViLBZ
         2HtnTq3tRLIaJkvkhZ9NmgEMInG7pQGNZiUghOu7TCD7wYTk5+kttvtWOhnsqKUFrfkc
         RpoyVo3u/cgQYOzVkm7ODMjLjTE/HIgVGP/I8BwfiFXn4DK0NO0wsOTHIGWiKgpqhlMt
         v7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FFS0TUHs+Ey2oo/Ntw/o6bWjYoSrWErDLwIOZziY2k=;
        b=jzyxZ11zzZQUefUZwdCd6FtnKaJ0xmsFyLZeaCcdxX5bI8tDgHlCkghmdy398O6qzN
         uQd8rfOk5lQzZaKKLrLuaI+R2A5M5OYaa36cjcq91d6nvmQjJZWSiTp/hEovGfoVWJt7
         O734MV27VhRZmOHnRfTyy7oseZG7DJMdlkF+cTGJVGodBQ0OC5xuFo3v/5fY7E/jHjgx
         0wph3iy050WzIFOFIgbIL08eFNvKa+2Yc/eQ4U/bPbPWvQaDjhQaOWSjrHcI2HU0TAwn
         MbDFn/zLNvxJsfLXz9vxHxtSNs8dUMqJTMjCd869RsdIB6+h9TQnt9/4TtAeN6U1vbgS
         u5yA==
X-Gm-Message-State: AFqh2krn9xZ2dVT98FCzzJjjkTRdUd5jxwIKP68TU6mR/5IOYXrZu2CA
        jijikgawCf10bWKYW5ULWT4=
X-Google-Smtp-Source: AMrXdXv9Vcin+669zXo51kVZTiVjST7eGEkpoWwueE6klMRY2mPrSFMph7MEG43CSRkEJ95Le+IiCA==
X-Received: by 2002:a17:906:2c45:b0:84d:4b8f:b34c with SMTP id f5-20020a1709062c4500b0084d4b8fb34cmr38420528ejh.66.1674744750405;
        Thu, 26 Jan 2023 06:52:30 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id pj22-20020a170906d79600b0084d43e23436sm699997ejb.38.2023.01.26.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 06:52:29 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:52:28 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] thermal: tegra-bpmp: Check if BPMP supports trip points
Message-ID: <Y9KTrO+WqJJwuEDf@orome>
References: <20221129153914.2699041-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/LpX+8uHcETRDQDl"
Content-Disposition: inline
In-Reply-To: <20221129153914.2699041-1-cyndis@kapsi.fi>
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


--/LpX+8uHcETRDQDl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 29, 2022 at 05:39:14PM +0200, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
>=20
> Check if BPMP supports thermal trip points, and if not,
> do not expose the .set_trips callback to the thermal core
> framework. This can happen in virtualized environments
> where asynchronous communication with VM BPMP drivers is not
> available.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/thermal/tegra/tegra-bpmp-thermal.c | 52 +++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--/LpX+8uHcETRDQDl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPSk6kACgkQ3SOs138+
s6HhxA/7BMVYYvAvXRde087gJuw9t7M/NRrgb+H/+pksrAI85gbb2id11WJQzn22
QYtWOlEajgOha//jNQ9ag2XV8ff2a3J1Awtk1YYVsI957zebmRWFiDaMn/1E+E3O
8kg5XRndBGW6r6xb12bSUhdRoW2h0C+K5k5e1CROr5eFbzqrfwvD1kCAqhjMzt1Z
9/HmO/QakKYtix7ggsPlnZ2ju1JReh598+bwhjJJMCMfH5t0jBNG2jcp5YpRz7+/
tPFEm08mDM+98aiRxlhgBAjvoa+Qu+qv5d4kcpmupgFdDfg94NVp8cKvwtYHaKs/
JvO91Bap3RTWxRVCukZv2AD/v9d9SkNvrKsioCH8PzNCaiUhlaVdXicfCPlQcZvx
F2aAZ3PmpjHqOlJV3VgquIQLQD784TkSe5LAKL8j9nBitm91ZeOnp+bjho2RPd0I
5e8Zn4h+TpnsoU7JHnVFwbgm5MtOgL9pZEl5UJJbiKE1TFR0VwSu7ADqEGWUxBOd
4EhYTqSz8OBQA241Jk4w4vAJWur5xgmsvtQHlAgbli+KAMzNrYFitxOcSIrSsSCj
5icZGv8ZXrW+axhkz81M/b/Iqa0SkCZehoKrbtuv5A/v3rWnO24hACoB+7u/bi/K
e5Iijo3o892K+ATtnafkEvAi686gVUejkJpPwv5OE4ch/iaM46M=
=N26B
-----END PGP SIGNATURE-----

--/LpX+8uHcETRDQDl--

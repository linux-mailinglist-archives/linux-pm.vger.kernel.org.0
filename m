Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2987C84AE
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 13:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjJMLkt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 07:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjJMLks (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 07:40:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD107B7;
        Fri, 13 Oct 2023 04:40:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so6505692a12.1;
        Fri, 13 Oct 2023 04:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697197245; x=1697802045; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH4tRv4+dZr4M5iR8AWhdg07jhklJyUHM7PsxthvZxU=;
        b=J4PGRdrKCKcqudNRCfRPHTrecxSEEGoMaPAy/mIf7Qxi+oCrkGkJ+Tcll0S6cY2h4z
         eSj4XmlNsY/WGUvs7DfA/3NykWwljbsZCdUgseHiIazTfcNAbNG/BTyMH/5UxMR5KX5o
         gcUmhZlWhQwHmTtKjriUurWLFKR4IubJkqwHUUcJXIw8olxZGRgPOxKJFi7iCoIDc1Y/
         VfyXhfhyimaM/360TRMablwAVZsIJdB4w79Oyw4aW++/8ZZT4ylrjC5XMB9qjB2EjgSC
         cp+VU/Z5upumAMbGX6IQ7vvApZdOQhSnh7Mr6cVRzj/Ox4iFGTtCm/gzoM/VNoe9bQ1v
         xFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197245; x=1697802045;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mH4tRv4+dZr4M5iR8AWhdg07jhklJyUHM7PsxthvZxU=;
        b=k4u9ycTfRogK+jxbZTZjU9VnToUgnOXqVtAY4ko9tiHQ6m2wSOmsKDTQ/KVr9PGhRF
         uPRzqaT/m/+fm3Mevxqp0pEO3QKvf9qOrSTLP0eVb0GrzN5RxbNiBtMgvIZZVpd4q+3N
         TkjkIRh2iwmTmb9kuerQQpAz3tdxHphMCs6m0BXBY6+bezfeMaYN7Bbdd2x5xMBVqzJE
         Wv+mgmur0fF64OAhqYDKc9TUxpsTbG+sbFWRFC6Jgkof525o0gRoXyMD2XDokTUfnyub
         UUUuPhrY4xuLjfVz/TM4UeMr/MUe6MJUL2xT4b5tfRdS5vGUQKPtKkCF0CYBV639HWfk
         9FVA==
X-Gm-Message-State: AOJu0YxS5hL/fkiDXEgDbaplheH/hE6WaxqA/znLtn/hYwK/B/XY3gj9
        Ouz/EsJx1dBI35j5YBnuj7c=
X-Google-Smtp-Source: AGHT+IEUKKrj+yWWt0k1ic4SMvRZQ3sKRrfjY9N2UXsvbFceieqAee1KOZsE/sjmr/6DlTtZcPEKDg==
X-Received: by 2002:a05:6402:40c1:b0:527:1855:be59 with SMTP id z1-20020a05640240c100b005271855be59mr20152782edb.3.1697197245072;
        Fri, 13 Oct 2023 04:40:45 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v3-20020a056402174300b0053e3839fc79sm916698edx.96.2023.10.13.04.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:40:44 -0700 (PDT)
Date:   Fri, 13 Oct 2023 13:40:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 04/13] thermal: tegra: Use driver-private data
 consistently
Message-ID: <ZSksuix4Imy2zonN@orome.fritz.box>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
 <20231012175836.3408077-5-thierry.reding@gmail.com>
 <24073646-373e-452d-94b6-3d91101ac5e2@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="esywz0M3I1a4TjD0"
Content-Disposition: inline
In-Reply-To: <24073646-373e-452d-94b6-3d91101ac5e2@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--esywz0M3I1a4TjD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 10:04:33AM +0200, Daniel Lezcano wrote:
> On 12/10/2023 19:58, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Instead of passing around platform and plain devices and figuring out
> > the driver-private data within each helper, directly pass around the
> > driver-private data when it's available.
> >=20
> > Also store a pointer to the parent device in the main driver-private
> > data structure for easier access.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
>=20
> [ ... ]
>=20
> > -static void soctherm_debug_init(struct platform_device *pdev)
> > +static void soctherm_debug_init(struct tegra_soctherm *tegra)
> >   {
> > -	struct tegra_soctherm *tegra =3D platform_get_drvdata(pdev);
> >   	struct dentry *root;
> >   	root =3D debugfs_create_dir("soctherm", NULL);
> >   	tegra->debugfs_dir =3D root;
> > -	debugfs_create_file("reg_contents", 0644, root, pdev, &regs_fops);
> > +	debugfs_create_file("reg_contents", 0644, root, tegra, &regs_fops);
>=20
> (Orthogonal to this series) : in case you are not aware of it there is the
> debugfs_create_regset32() function. That may make go away a bunch of code
> related to the debugfs code here.
>=20
> cf. https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tre=
e/drivers/thermal/mediatek/lvts_thermal.c?h=3Dthermal/bleeding-edge#n159

Doesn't look like we could 1:1 transition to that because a bunch of the
output is parameterized on some per-SoC variables, but it might be
possible to rework the whole debugfs interfaces and split it up into
multiple directories and files, much like LVTS does this. That's going
to be quite a bit of work, but I can add it to my TODO list to look at
when I get some spare time.

Thierry

--esywz0M3I1a4TjD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUpLLoACgkQ3SOs138+
s6GY3RAAwVtMi2CkaD1HK7reJ2BEu/fUIm+/GXGamvccsDnDcoWUa+qiaHz1TnU+
bt2tPh1qqcF+d28iThxflAFDWsEPzYa4E0YSp+OnFjDeyuXS3jEvq+9fem8VwL0c
sPx6haZ4aun6NVW0XrJwSjfBlDIkrHCY7mbNG2pWY0GznWR2bNnWcfc5VCbvQa8U
OyBAeF8UOHZ8Vj2GCpDRhiK25NLaXtLmTO38fDMHO2TMI8QHVw+wSYmc5vzGjJrs
NKtKEDfpNpfS+hrlSq6Nv5WqrY3xdaJJL1jmuwM406xZ2guQfaafZjhwDRViJQBJ
EhYASoE7giyw6v5ZM4dfk5NeQC9OlWDWcAVgB66jlZpE28NrE7XV6obwqpK2U5LE
HAKWkSoJYYFD0t9/EAaKWRyaPlzOW9eYSxNuCnO5DRhz7iesqIVlZXHtCMWdLm7n
WpyTk7WJWtUzyTKB5UIt7yR6InXNm83Xfqa6aqjSWCD1V5rEyozAxN8po7JgpP+k
Y2IWGCXjfKhSeR6tPPFB9d8uEazePKPuBhHqwNgk5XjmGmlSEDV1wCKF7bKtwRGH
0B7eF7hfPzDlmwb1RdWcejh0xAEjx0cp0Lglic+dCCfWZAmbGFRSNxpsfz1/P0dl
Rcwco02sHxqs8XFR/QH52J8YEu0djT5JnLwpLbbL4lhEehMEFEc=
=Uxnh
-----END PGP SIGNATURE-----

--esywz0M3I1a4TjD0--

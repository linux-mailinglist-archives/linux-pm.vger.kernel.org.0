Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6CD6899B4
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 11:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfHLJVB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 05:21:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38045 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfHLJVA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 05:21:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id m125so7051413wmm.3;
        Mon, 12 Aug 2019 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OKZ9N3pv+WuWQW5k/9EdD8ie6o1wYHnw2hNyQDcPSF8=;
        b=BokZEpTItaQqtP46xPeDW7jYunBIgW/1meAOF1NI3K8kSvAOlqPUjzMv9ylGJAIfTO
         xN9G4OdiWFRGX4AXV7sEJknzYL//hOGxdUoVKiLKCV6p2hMCdTmOM30adkg3Kwlbupmg
         rfdVOagoDau3buS2xxNV22MPhnD0CzS+OSLvNPUqrVG93QiH6zKm+/6l4nxsPL++RXSZ
         481dpXAITNxibg/ObZ08+DWiokp/KDBSWNYhvjVB9xluQrKyYbSaTYtZaVXRpph2f+iI
         pJvKY1xgAnLOAdc/eY8BJviBUQSmwdiIYiYtCok4wy9RydmRyv+FqojfkYmq3v5qofgI
         BkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OKZ9N3pv+WuWQW5k/9EdD8ie6o1wYHnw2hNyQDcPSF8=;
        b=eh/cFFsGbIUWcE1tonIfoMtOSKBELg/XXtkF3DT8heWacxlR86j/VUpPI/HeXNBuWK
         8db/r+0EwdybyCzr5d6wTrWnvqkEyI6V1Sho/STARjzaDOh852K7zkw60ha0iR/kwN0d
         C86pPbXD8ZFDARZOfNcxHcF/WhHdit+ZZki2R9fT3836ipHukJLXwWQY7S7/gmBAvCje
         xM4Hh4MYvbXjRsw445VIXsFRq8l0Wt1hCZuOkabywFLpPTQBYUFBfAxehKaU0EAxUfjO
         mBXo2zWHZkZkvIKCYd2swdidnoCsj3c21PWBZy0q2Gqi/GidYWXAUdz0gM9U0j0QkWNE
         hsIQ==
X-Gm-Message-State: APjAAAVODqMjenb/0plILWcQkOz5k67V5aKNVF+nBN67pJjrC5Hc7v+t
        BmM3ftRUKuAMB3G4ZmyNii0=
X-Google-Smtp-Source: APXvYqwgBCDoSM51Eoys/pu2KzGtOQvGA+KEm5sAZ80UfbHJbDxVMIvkiQNkcJzTks7yoCwFyM3dyQ==
X-Received: by 2002:a1c:7619:: with SMTP id r25mr20216597wmc.153.1565601658506;
        Mon, 12 Aug 2019 02:20:58 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id f192sm16350196wmg.30.2019.08.12.02.20.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 02:20:57 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:20:56 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, tglx@linutronix.de, jason@lakedaemon.net,
        marc.zyngier@arm.com, linus.walleij@linaro.org, stefan@agner.ch,
        mark.rutland@arm.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, jckuo@nvidia.com, josephl@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, mperttunen@nvidia.com,
        spatra@nvidia.com, robh+dt@kernel.org, digetx@gmail.com,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 02/21] pinctrl: tegra: Add write barrier after all
 pinctrl register writes
Message-ID: <20190812092056.GD8903@ulmo>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-3-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Content-Disposition: inline
In-Reply-To: <1565308020-31952-3-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 04:46:41PM -0700, Sowjanya Komatineni wrote:
> This patch adds write barrier after all pinctrl register writes
> during resume to make sure all pinctrl changes are complete.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/pinctrl/tegra/pinctrl-tegra.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1RL3gACgkQ3SOs138+
s6FnFhAAkgf/BiMUj/jlPfe6CGMU/2j+3heSekAmXhJfo1aq1v5F2JenrTTU3rdW
9lBsT0PnAgIGsSz/0eny9BCg2LksG19hn2zB94YlgA/j4eWgh+zEm0eXll4V1gXR
ZyADhb9TCC3Ez5OrMXwt/31F5qXK/npVjeTvXEAZEt2mHHYj4wniS1s76DXNBMxe
TZwHmDKVqVf8swjWnNzNthITXG79YNl4M1yBCeiKHiLPkAszrX0V6JVJv+Leq7cL
xAztBfPrZfXx5kX9rFYeqWwCPBx5oqQL+pMDyhqafcyIiB1wMvXPUGHIxcTitXHX
AHsdazSNFfK394leUuNQ/b8WEBCjw9h4rL4KQ05spl3J9WJSrMI9cf2eHhWx6O1R
g6MNZ+nZ1LbSmiIfhcqy0Uit364/vXqj3Luzu7FVa1ld15EkdhmWAaO3gWHWLbLP
VEPviaC+byT6g7Sd5Z3Hv/BflOC+McrY2oBASo1D8tQecmKJI6JPJ0A4MkHLOZJI
v2w6ohTCcdzy6zt7Z8IIBsFFwtAL5oGxJ3TdPaDKNh523mQSjyoyGjpnNNgHb0N6
sGoOGsdV4K+6Fx6i0TQOFeBPDkwmbWwnv6Jcy2ASqI44N2CiAUd2Vfg+9liX47BY
vRHKJTkliMrmxh+XfarOWRT5RfaGJSLVU4hUQcXi3aAORedVhm8=
=UfG9
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20A13984F9
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 11:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFBJKM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 05:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhFBJKM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 05:10:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCC6C061574;
        Wed,  2 Jun 2021 02:08:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cb9so2064144edb.1;
        Wed, 02 Jun 2021 02:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cWaydfLjJigmw44FbNxIINxhVVfl1aHGWYAoThRQNfA=;
        b=r6VuJ7pEBtCEEPA4EV6fBRXoDO7cPrPi4rErjxd2eDYmnfnxxt3cwtbWFRyMcockUO
         ZY34I1PZa0YSqifgVeOpLEJiuOnIGOks3wi/eoHXi4a7F8e8YmKb3bqFUYXd3jsg60IE
         uOdZA1saQNT3FP9Xgsoep5U5WiJ1pz7rTaibJX+fA7jgzMbQTx7siZIYGCph5LL/rMRV
         Cy/VjOiMg7jZ/G09gqqbx0wLoFSELkGwaLVevFY50sZpRrPGdq0kliZHRb/Rb3lo/PWN
         pwa+i0euj/g4H+GNhvA8wY1nzKRT1YPSRzWAQBSo4+kmTMzHHjNQ31pqFCFh/WG3SFkO
         AtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cWaydfLjJigmw44FbNxIINxhVVfl1aHGWYAoThRQNfA=;
        b=epSKwz/ac+oaha44mNTw5bqViNP80GlJYGvr0TB6O7/Iwl0I73e2s1tbGU+lKAAMXB
         V2Mq12otdSngUq8A3I+lzs+tibFUNkAlycQU1BkBjHdRITsg2n5BFVHHGWKyVIEyGqxX
         /hRbN4qOoXF5126y+Vu03xSnj2sRQoN7zkMGAn9zYjZRR7wR1ZibyymMFzpinsP5sdAg
         x2M09xyMcjvlimg2gryYXRBrwn3irwUmm8VDMa3UPkt/AWfmfr3zN0S9EQcWp/bQYHvz
         7d9pxeohWyfYq4mMJG/9tDwKePj1DjHn0OSm0kumFWQskcm1YZmxxgU6Mco268Nwl7Oa
         qOMw==
X-Gm-Message-State: AOAM532jzXVKtB2AEqQSLlGVz/AN7z6k4bwPW2Diz2pNJLoNuTyKcnFB
        wObnD6ZD3MaUAtF7u6Ait94=
X-Google-Smtp-Source: ABdhPJwMmcjyxWw8NqVoM9xbquGbFmpUKx1teZFfigAj7yzd5waQ9nhPqJToLeN/0PGV3u9QpFgBtg==
X-Received: by 2002:a50:8e57:: with SMTP id 23mr23614571edx.354.1622624907644;
        Wed, 02 Jun 2021 02:08:27 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id m18sm2059173ejx.56.2021.06.02.02.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 02:08:26 -0700 (PDT)
Date:   Wed, 2 Jun 2021 11:10:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] NVIDIA Tegra core power domain follow up
Message-ID: <YLdK6jp0Ybtzdstv@orome.fritz.box>
References: <20210601231003.9845-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lY82oCsGCzlMcVK0"
Content-Disposition: inline
In-Reply-To: <20210601231003.9845-1-digetx@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lY82oCsGCzlMcVK0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 2021 at 02:10:01AM +0300, Dmitry Osipenko wrote:
> Remove the lockdep_set_class(), which Ulf Hansson asked for. And
> prevent core domain syncing if domain node is missing in device-tree,
> which I accidentally missed to add after squashing the standalone
> domain driver into the PMC driver.
>=20
> Dmitry Osipenko (2):
>   soc/tegra: pmc: Don't sync core domain if it's missing in device-tree
>   soc/tegra: pmc: Remove usage of lockdep_set_class()
>=20
>  drivers/soc/tegra/pmc.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)

I've squashed these into the corresponding patches of you v6 series and
added Ulf's reviewed-by to them.

Ulf, let me know if I misinterpreted the discussion and your reviewed-by
didn't extend to the original patches.

Thierry

--lY82oCsGCzlMcVK0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC3SuoACgkQ3SOs138+
s6GbAA/9FoCHDUUnKIQcWFQKEhXKj4WsIeUsRmhZbK7aF1rj+XwqHCsRNjmFHUOl
tD77ZXzsf4OMXm5+n24UReYhy+YnRhuDTsOsFEbeb6G2SLDUZYoY2TLlqezZD8Su
5km2GRhqNh8xxiC41+0oPzQ7d3hfbOmwyBifYtHgk8I5LYB/Txl7PllrFI6lxw1t
tQvf4MxxWgY6oGAmK2rLWtkGtcb+Nqx/eDHM/IH9T7AjOvYVCc848Wm5fg3Dx3sz
//TCDQsy3bhu73ZfOGxC6hhCj0mYUcW+OYJ9LSRQeqhvizQrNojwgQpPoL3AmLis
WMsg6+anSyL1wDIEkP96ytpOuS2x/80FmBSqK3mRDfsLZQWQtHVSsH6tQpBXGQ4w
X7GweTdY26ENPcRXt6YvI/CO9xUAho+PO9YuzFCdbcP2gB3vuP/IxunixEe/kt7A
gCxHq7L0NxPzRmhTI48S7U832Hq65wf/DfVShHTux8E5INvXV0HhYC7pJ+LpT2dQ
pGDVaX2E0zrEkh9tDvP9TAVU0eVfpeRrTl/suZE/nfIxeAoyHOkG4LbGpR4q+wzM
iA6Gu3I9Eq0YV97ifUzLC1I7kasgG33C0ldlqXCPcgv1msHR2VhSo0j3qOmALXyn
ubawniK8uzc+4YkQkshcJreq/RDmLuVtroFhM4qWZn5HAV8qJ3Q=
=wvGX
-----END PGP SIGNATURE-----

--lY82oCsGCzlMcVK0--

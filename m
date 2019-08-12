Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D58C899AF
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 11:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfHLJU1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 05:20:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55053 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfHLJU1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 05:20:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so11473724wme.4;
        Mon, 12 Aug 2019 02:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MgLPMTtg6Jyzs9wt4ekHIpThJOy3S51fX4Pbs5028Qw=;
        b=MRdxqniAXGFwWGp6ovZBRFM5kKVCzLuypXpwid6B4G8z7Twcw1CyFlX5XZduWh6krN
         BvoiV1sQSftc9cDjUaJAIOA/xdD5x5IaNN4fT2PbmzflVMWDP+lnn4Uj0gJ9mrnTDb//
         QN9BugW6+JENQzNq/HeN8qdi9AxVJ5WyVlu/z74wAoImfMnLfr1BdDzzhR0VUaX/NK7B
         DjFAfJuOmwwnepWyG9icGE30RhNahktJMk1z8ZBV9B2HcjMfnrEw9PueE3xjbd5ao0ls
         4dceqzuANg44kgeClcK0gxjc/+68HYucfwePMGct+S/xb/Woo+wd1CzjNrg24nC5bztP
         11Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MgLPMTtg6Jyzs9wt4ekHIpThJOy3S51fX4Pbs5028Qw=;
        b=uLH+2WOkrWNz0tTDoB+NX4b++ENxLOgWMFLL/GNehwRSLJTcXd9LFKmRMZLDj+I2pT
         bL8TaTDDzYPX72wOhPYP5T/FByuR50JiC7ZgCzDADzyhK0auxjtGpjEvjgf2Rh2yqprR
         4NVmHzHI4EY2gETMozMiGpLxS+PZSryMEdmpIG5Mv1DUJxHvBskVTQfdBYFic6n+j8G+
         uYeFWJpJdPPftYwmuYPMX2KxrruqdZEMZZGY3sw+PzJrlaRtH20FceU6vqA3vSX5SxmW
         OTQO/2OEfq2Y+/vwsAmF/SmuE6n2HXZEMMirQ4j6L1T9o7vRhehZEE7oR0yQUTkmz/EX
         VH8g==
X-Gm-Message-State: APjAAAU4BcbzardcI25fwQQmnMQGN2cp8WC7/KrMqWvz7Gm7C/R0ga3a
        Slhtt+P6WaIDbLccF8Acq74=
X-Google-Smtp-Source: APXvYqxHLPKNrpdLLMqp0G4bXC5Z91yn/gIGCzLXSVN9445Z3ZyS5vnf0Dqr+tLu8Cusm5o3P0Nl2Q==
X-Received: by 2002:a05:600c:10ce:: with SMTP id l14mr25953651wmd.118.1565601624096;
        Mon, 12 Aug 2019 02:20:24 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id w13sm44443446wre.44.2019.08.12.02.20.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 02:20:22 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:20:21 +0200
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
Subject: Re: [PATCH v8 01/21] pinctrl: tegra: Fix write barrier placement in
 pmx_writel
Message-ID: <20190812092021.GC8903@ulmo>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <1565308020-31952-2-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 04:46:40PM -0700, Sowjanya Komatineni wrote:
> pmx_writel uses writel which inserts write barrier before the
> register write rather.
>=20
> This patch has fix to replace writel with writel_relaxed followed
> by a write barrier to ensure write operation before the barrier
> is completed for successful pinctrl change.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/pinctrl/tegra/pinctrl-tegra.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1RL1EACgkQ3SOs138+
s6GgOQ/+KHEjD8Jzg9BS66GmKuNoOclOxDM03l3CoYiOGhyyUsPjifCTvtnDFGwa
lqaq7sH3V7fOCC/qun2i5BE8pumI+NgLEkm9tYKvmLCn2vKCzIpv2LGX37+e91M8
GiMD27bmKkEDW4nLgIza9y3v/t6kJ4XhwKnFA2+eMjqZB9SNleworpYAZp832AIj
nl0HbqRiGpkLjcIaWAibNY5+0OEpRB6AhZlhsCWz5h7c00Jad8qK1rBnoLxDiq7a
s5jPfDc8fYWQ6OnIutLEjm+GdSx17odH7R+mprW9OiKqWPmdZUp/aZEHDyS434Al
+c8I0wEpxWWCEk924kF6oPytP6KKjOHy29SdhPg0RV7uuK/qPm6ylaSxem3NyCMi
sibGMlfXuMKdFaDbCEIv0XbVsu7nmu1I0h7PV1Gy+oCSnPI8EJ+tFiGozbYoy9hQ
INdJWkMQLWXsCRsECrP1zWyDdiA5zhI0nRNVSflZi5Lz9GkcGa8fmi+r0o4vOL+x
Lsy85RpW8ukLteRRUf51hpXNcvsXTGXZEempESfd+uLu7eHTpq8WciMDDT0//ekQ
L4xaq/9TB7s0sDH3D2O8VOd5s1tR0nHl0DojzeY/YS25hOi3nW/8/fHaz+1c6z/C
cZ7LUpJxyGhfs9Sj00Ftyj2fWVZGuIxFDQXh5ny339ST1DhgPRQ=
=NUo9
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--

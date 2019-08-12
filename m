Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04C96899BB
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 11:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfHLJVi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 05:21:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38122 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfHLJVh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 05:21:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id m125so7053241wmm.3;
        Mon, 12 Aug 2019 02:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BLDuAK08TKNLQJlZE4xf8scGpyyBOHsDCwJyjOgqjDg=;
        b=kMZeJErZHjqdJUQN7g33dNHR1nwoiXVLmJqq01F4jhQBFYBx3125ontVaFbi6cuvTK
         Ka6KmMxHTQ1oUxOEkUJAKx64OAagdEs65w1+8fupQX4wQ+TkHA+HA8Vz06GD9OfoVLoj
         fFENiXdoXHLJ8/8hEqKl3gWckK/Ev+ys7buLOQ17WfmgbdHnBXJei9IboIoYKngFngFT
         U2YSmAztCEzhz+QEVdOUvtiiRYBSAbZeW2ZzLLZaU/ugtHWp5a6RhFRoo5MxDsr8+YBW
         S9obvYqSIMo7XgwkRP55kyMEW61I744YgRpOIm4ENPJ1aDkr7HRiOVjlhDQybFLWhw+X
         XPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BLDuAK08TKNLQJlZE4xf8scGpyyBOHsDCwJyjOgqjDg=;
        b=Uy7T7nE5SO8DfNCHYi4svSdJYQV2VOwvjqFTePHEQdGc7IrdPmHRxPDcFloP7XGeB2
         srS499YNMtWx1puCfAsXgQ+YPp6FbzTGy5WzLuazKCOvNn9efFlI4IIf+wVSq3dARSuK
         q2M72IEFRTnwaCFUMQWtcuirVhOcfAh9Y/z4Q4GuWI22d0K7E72+ph58/OlpPc3zr1Ty
         Grw/5/HlQneT3N0NZpYs1rPzbBgT7NpwGMwmV/j/+qa7/ebn0Cw1yu89AX84+aa+y2Sh
         wew2Dwz7DrMsf1fiZohvFSRyRqMQDeLVxs0e2C+bt9n5uRyL6ZFtT5t5/riyBdPOkN2G
         ES8g==
X-Gm-Message-State: APjAAAXlq74+q9E3y7WDQ+CHlkBZkgVYjqBn3lvaXCqWClykRb1miPWP
        ryeOmHuQolZ9ybf0K5z4qSQ=
X-Google-Smtp-Source: APXvYqzkq/Kh/UDHkyDzpKpx3Xqc2ssuOI6RBB8doiDSlOyLTd0Ni+3KC1NGxxpPsyBZkUTThBxNrw==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr25845318wmi.106.1565601695283;
        Mon, 12 Aug 2019 02:21:35 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id x20sm231084483wrg.10.2019.08.12.02.21.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 02:21:34 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:21:33 +0200
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
Subject: Re: [PATCH v8 03/21] clk: tegra: divider: Save and restore divider
 rate
Message-ID: <20190812092133.GE8903@ulmo>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Content-Disposition: inline
In-Reply-To: <1565308020-31952-4-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 04:46:42PM -0700, Sowjanya Komatineni wrote:
> This patch implements context restore for clock divider.
>=20
> During system suspend, core power goes off and looses the settings
> of the Tegra CAR controller registers.
>=20
> So on resume, clock dividers are restored back for normal operation.
>=20
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-divider.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1RL50ACgkQ3SOs138+
s6GciRAAu7ihjAvzjleKr5l/wYMUx50GqCmlDbJPPj3jcAiRgKqgWMrvVdOgdbZp
QdV017XzIRxpMkj8v62RKCOm/PlnAbbZ+a7RGu0qvGpMK5a4RnfrYHvyK+e+DaN4
YSOYsPYSviDEb8kGhWGe5m6cVDaR8b6EZFhqMfNi3eFXp15+c1JZylmbHRlL0cU3
EGlVEXewNcAseec8V4d8EXNEi2DZOKfq4l1hKiTr1HfHqw3RwJeXMF0mbv5DLKey
H0LYXW+dDWn4SLGLOl4KxXh6TUi7pqhkT7Iu9Q8DSVa+LyuYS2wOcHewvDmnD6gD
ELNQ1trgtsbz6SPpVNXVbvXDuYkI+Uzxla2Cs6I7zS2xK4tbQFUeHtSKrBc8cfK9
UP3BQmVfpVR9OQmHUL+GrEiGB05CaYtIoZLOpFvv31XYjYaCy+MtvjnM0HjZGj+K
sZIQ0hSIDGcWDlg+2K7PU3wL7PXOA4C95cVjPjqghkEhnoBP8jZ6qYSHCoZ+UKEC
PhaQue7ePjTN3iSgqp0CGzUDN3+JRxS4MsYVbudTiwxAd+LYD0830r9IwDH2kIPE
o4uWmo67u4pqaoMu3MP4Ll9hJiXur61rLMQXt6MQacvD3eG/bG6W5hP5l00bPEgA
K8TMgeZWF8HtT2QNf7fyJKCzLIC6vV3/w6jtc0VP6EWvDYg3aDU=
=9Mj2
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--

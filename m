Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD46489A8F
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 11:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfHLJzF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 05:55:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36272 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfHLJzF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 05:55:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so11203227wme.1;
        Mon, 12 Aug 2019 02:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mQO/VOKFZftOK8QHN4NGuCN85/5BGprWbgm1EqjUZRk=;
        b=f3a+MClydnhfTcdBwTNQsqn6kbXHVsIhjsN5qRYW8QT/b34I8g0tBhs4xg7iZiQYmV
         /ds/dQG0Zj8/LzKHOMB2oNPLsbnUW4OcpDpRufXgbX7ZE8Q7iZDLPEfNbg0CxDB/TWhf
         IJNyPYCU8BQEi/SsiBrFdM2p7KQt+Qbcb30MS/NSHEO5kW0Ige5o5LMzv0vwFSPrvnM+
         KpFEoWGWXbDvknQM6trCaPMqES24WmDEzjIHgOwkSLULGIIoDKjJMYvw+a1cEi7oOyuz
         yeEs82+F7dOtfM4Dg8/vgqkANUWYXbMVolpmd5Oc1YCMZdK+FAwDM0YBaZZGKPu5w050
         A6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mQO/VOKFZftOK8QHN4NGuCN85/5BGprWbgm1EqjUZRk=;
        b=JnUSnq1G+xBsBouFD/kjNoM8ep1pUPTl4jtfItCYM8osJVt//JOL3mjnZFyEUtgitX
         NjS/2cuq8WgaJwQM8Qg0Rl9l0vjGOQ9pxUdCZx2HjpWyYxDFBrxc+Xu7IO+2/IHojKaK
         e+Al1rhRckRw+5nSbN+e7DPeIOtUh0yWEYJFA2MD93UZiWPW1e3RVVcFarcCjE9dw94E
         mhMY2irSr6WDZZGfEi3FgdUPiAn3Ar1ZPI8khKYctknz3mhGJnO07NG7AfnF4HJAHyuw
         vdUfbA0hQ+4YBadwvWVxEqF50ARD5AzxvmkUeqRlTxMwORPI9XkdCLTMJwfH3kPSqRLO
         E/Hw==
X-Gm-Message-State: APjAAAUHMc6KtZfd4soorYP5qoa4IRjCYOFjt0vV7+qFtYjj/CIag3WZ
        S5XmIj9twty7Jks1lwJ3o8s=
X-Google-Smtp-Source: APXvYqy+V17kwdKJdpqcY5NM6SKLstrsWvCPqEdTInpG5cnwKl78q58ZT/S2d6tCDCF6MSLio96JEA==
X-Received: by 2002:a05:600c:2192:: with SMTP id e18mr8525190wme.83.1565603702323;
        Mon, 12 Aug 2019 02:55:02 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id f23sm7593250wmj.37.2019.08.12.02.55.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 02:55:01 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:55:00 +0200
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
Subject: Re: [PATCH v8 10/21] clk: tegra: clk-super: Add restore-context
 support
Message-ID: <20190812095500.GI8903@ulmo>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-11-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hABqaeELJqnDDeDE"
Content-Disposition: inline
In-Reply-To: <1565308020-31952-11-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hABqaeELJqnDDeDE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 04:46:49PM -0700, Sowjanya Komatineni wrote:
> This patch implements restore_context for clk_super_mux and clk_super.
>=20
> During system supend, core power goes off the and context of Tegra
> CAR registers is lost.
>=20
> So on system resume, context of super clock registers are restored
> to have them in same state as before suspend.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-super.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--hABqaeELJqnDDeDE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1RN3QACgkQ3SOs138+
s6FHwRAAnYt3bQr8qabJpmuLiAWddIRGpf0XzLDW6DnRqSmhENAKH09BCH1IJ8bO
RNFI+6CZYoGt38zjU54qQxf2BGFSW1q/63T/+CU318zZ1oUws+0iWQrFPKHIxnS7
Rae4YsOE1UqTucB/uwniVcDVTGTcMmDKx9lA+WgMTcNyRcMFYuKhPjV0BL34Kq+5
2JA7MaqNqrBKSwVqOlN2kAjqa5NOUq57c8MbQ6/blbGQsdgnDrWt9TDR4s3cifCc
tu9HdlV5921/RAP42V2+oCnHnYMNvGAre7Z3ES5GZ0z5DdW48koDA99XexftElaT
+KCuXTdOUrv8Y5x6PQ5MwCxnXqqayjz+4c3v8ahygNBV8K159Kkokt2c8NR6Igbt
Mz403frb3Hp3qstDs6HfvYCsuNFmTmB+/Lhp8xciVyEiuv26CPNXg+OL7rRfJtc2
hQy6RcFw4D8uYRcOS7rkH5m2rot8R59tK+2QqSEIgMlYbNtDuciS/5r83/ro7516
tTMbjYdQWRlrFELVTzmjIQtE2i5PJ4uq8VJsbXOGlx0ESmQIwNcxdwe2nBH6vrSY
7kFuBQvOBTMv7bUvHY4/M+yhZLHOIC77Z/vYPh58Yl8JwxFTu1RNT7esQUcMyJfD
i1u4z1VztUimQjiojE4eGV8tkO6K6f38N0lz1R8T/MyOOOf67TE=
=5pWj
-----END PGP SIGNATURE-----

--hABqaeELJqnDDeDE--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1274189A6E
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 11:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfHLJul (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 05:50:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46796 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfHLJul (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 05:50:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so104001248wru.13;
        Mon, 12 Aug 2019 02:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LYJhKsvYt/qEwARkz57RcEn5E7y0ylLIqNOzwSR5vaY=;
        b=j+ixsT/vQUBGYXyvcLLskMo5u94+wjvj0LNEd8YIAb02kpECSOipIJwoGpKNOm866f
         RX6v7ancXwMaAVaSCm/KTgR1/5boh6Zl3fqXdjflKYw1OL91hG0Zkq/UPY9Jw5ZAKKm9
         Wq/LTDkiOkgp82+j4Twt1cMU5Q1ddIZg6lzBoIXeYklmb/nV4cEdYHMD4/dNRPpQh0vr
         H/bRRdyZFlP/7dIsF0L9lqMgoiDJj+HAuPpS+tLOni6bFtRw6Nq+22zUVTztWmaLkkYG
         Pz6ScMip1SaNGgb5GBtV4trLZysDNBWETQBOHyYwrjRD+1fSp/xnhZy65/hKzIGlNelY
         6jSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LYJhKsvYt/qEwARkz57RcEn5E7y0ylLIqNOzwSR5vaY=;
        b=fX+YrU6Vhdua/hgui4jvnrUStOuZaIz/KqGFb8zuGHzjpX596IkyQZr9vKq/+QvAq1
         islHxAGlR73jhWpEGn6KJTFbcteDTM1vY9z65MuSC9OL9A8cFDFV5z2+MHcrs3NyQbjD
         lFkITaNj9YxA2OgXagKB0x+Mxq26eJCdYbgnrVNjMjUYQIjIo0CF/oDr0Ia+yIyJOHLF
         7FlgA/5CpO7WgahlTWa7VvrbPaqnBb8aoE7vJ4qUb0TbLfsdTshHYXdcTfj2FGHUI/Rs
         +3SZvyH2sl+8abi6EB5pOCBjL/c+QNK2ybFnflJKIbbLl/Lo3cM33teRS5BMocvks50X
         Fbjw==
X-Gm-Message-State: APjAAAXtZ6D+R24Tbcmi3hAhntVVPRh/WcA8WOioriEghZrXRBoJe5Rw
        Wq0Ru3mfmTHC2ITiNbZoi6E=
X-Google-Smtp-Source: APXvYqzUAY5nrGrBl1vUdF+vVm/HH3d+cnVor6N4/HB5y5SgMwNap+thk1CcUMcvoUMDgpbzFuBvLg==
X-Received: by 2002:a5d:4492:: with SMTP id j18mr36985552wrq.53.1565603438062;
        Mon, 12 Aug 2019 02:50:38 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id c65sm13124522wma.44.2019.08.12.02.50.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 02:50:36 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:50:35 +0200
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
Subject: Re: [PATCH v8 08/21] clk: tegra: periph: Add restore_context support
Message-ID: <20190812095035.GG8903@ulmo>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-9-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0qt3EE9wi45a2ZFX"
Content-Disposition: inline
In-Reply-To: <1565308020-31952-9-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--0qt3EE9wi45a2ZFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 04:46:47PM -0700, Sowjanya Komatineni wrote:
> This patch implements restore_context support for clk-periph and
> clk-sdmmc-mux clock operations to restore clock parent and rates
> on system resume.
>=20
> During system suspend, core power goes off and looses the context
> of the Tegra clock controller registers.
>=20
> So on system resume, clocks parent and rate are restored back to
> the context before suspend based on cached data.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-periph.c    | 18 ++++++++++++++++++
>  drivers/clk/tegra/clk-sdmmc-mux.c | 12 ++++++++++++
>  2 files changed, 30 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--0qt3EE9wi45a2ZFX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1RNmsACgkQ3SOs138+
s6HEfQ/+JkYMY0To8C0BvVEMjYOAPMPeZFfx7/M8IkLM4JwPwvZw244rHygPAm77
lhurKqNDxH+H9j4UCGHv+h65jojQnYjBr+o7vgX5XObgj77QINiiKDFqW7shzgtl
DiYq8icVRt5m7G4S5SurfoYq1iNWfFI63OxwLGMjTl9pGaewRtlDp09QWt/0gs32
Es6aFmFXuJj9hirNLbaIHNpoN6xh1zrkLTTzLIh77DCRwvPVHZLenYpKoCeuPV1w
+IYQGpG+uIIQEDGnPcCJrotPTIQ0+V9dKDuavpznm7TuHqacAwJLQiDCVFcssddG
kGSINiKeQv2hVgQMY2/PUVkwA5rNa0ClMlTkuQzYXuN/HpjW9hqDxgNtm5xE1Pbi
Au/T2Y8ejd+032DrW+E/pKOt8pS9vLXbIol1EOl7XMnjlOprbq85r/hKzIdbVOoz
84IQKIPEZAL3HEe3KkWlOzf3by1j6uCl3L4gUccHQIjCF3WsagRjsGgq+00pm38a
yGJ5qMqHt0FYsIw5WiTNCVThqxLdFHBLvm1dOT2s50dWvdmw6yJeY+aWcP4sGC3L
U9fd8JFRJ/c3BDBFL4dxtI8EPwc7LpnywrSYxjzjn1ZSkvnkqiqwYWxIPv97tOS8
r7WKKz/v6EfGGVRYYuav/O1x+LNrhi5a9wPtOS8e8JZaJ32fTD8=
=ISLx
-----END PGP SIGNATURE-----

--0qt3EE9wi45a2ZFX--

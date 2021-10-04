Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7111142181C
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 22:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhJDUEq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 16:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbhJDUEq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 16:04:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE684C061745;
        Mon,  4 Oct 2021 13:02:56 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j8so2497447wro.7;
        Mon, 04 Oct 2021 13:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+qrvAAluq1oh1qyGb464LHUD6CDa6kJ5yA87KqgX3GE=;
        b=TWSJhc1N2t/9O+XqQnQOhAz0Gf6JC2eUFCgMhTlm4ouSQCMkk0QMkdbiiaTM5KMApW
         ZuD06bnjoysCU1V0NuApgMNmj9yLKUjO2H46ugilDzEK1Zedx6+8mTwlWROEwyfaym7h
         Q+DL5XbrecCz8WpJPLi4TUzuE+bLn1QfYHgo9JYei1PE7VihWZaXpLtz0lTfdTtL3VLM
         WA2bgSWjW8/uCABAon4u7/eTdXXP3vFgRw+ay8CvqtAGf9SAFHvfaqabD1VtWadUHPku
         g7Z6AULBK0ijFXrEG/UOogH0+WAeEpyS4ewVJj4eHB00zApFZfw3A9oyOKaRouPvwVcP
         a1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+qrvAAluq1oh1qyGb464LHUD6CDa6kJ5yA87KqgX3GE=;
        b=tt4z/zPrxKFhMoRqCsTJcP8QPlZpj1t1b5csg9axjDzKPRdYk1XfQxi6tprwoU228s
         TMKwRYAYWpMMT7mEqtTguMXpmRuX14GTXwF1yI+GXjFbpDgKnKQP5IZzwCUM9VGvCVdL
         BWWf7BivO3syAOUBEnFYb46Rp16boRaRm4vOOul//M6I/Cehi3fjx4eKqVWBHj+B7YQ3
         ZBndUixDhgBPnBm4tKtwr1FNp+Y2b70bpEUyUq4M/mXLHMDM4b/9DDEIgFaFgARvs+ve
         ZCDYW5lms7c+2ghV7pc3/4N9D6h1cJJVFis+g+WAr8qRv//DZLhivBEv/ebL54BjvuKf
         hlrQ==
X-Gm-Message-State: AOAM532Y1Xo+3UjMa8PljH/62RyNUubVcdWblBehf1/zCyEYm1C2xiSq
        GALhNr5CcspToU1as4mgd5Ly29mf5+Y=
X-Google-Smtp-Source: ABdhPJzF59HS0bN+f1Y21r9Hf/bVwODQvwfvpKxL3IWXCj0WX5d8eUbdEDf8V8Gz4CdtLTSFI61ZHg==
X-Received: by 2002:adf:b304:: with SMTP id j4mr17033978wrd.160.1633377775427;
        Mon, 04 Oct 2021 13:02:55 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id n68sm17664460wmn.13.2021.10.04.13.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 13:02:54 -0700 (PDT)
Date:   Mon, 4 Oct 2021 22:02:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/6] clk: tegra: Add stubs needed for compile testing
Message-ID: <YVtd67B0Ac+ChBEA@orome.fritz.box>
References: <20210912202907.28471-1-digetx@gmail.com>
 <20210912202907.28471-5-digetx@gmail.com>
 <YVtXJVeK2qdy8E1q@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UHyHC4/eKtymABGG"
Content-Disposition: inline
In-Reply-To: <YVtXJVeK2qdy8E1q@orome.fritz.box>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--UHyHC4/eKtymABGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 04, 2021 at 09:33:57PM +0200, Thierry Reding wrote:
> On Sun, Sep 12, 2021 at 11:29:05PM +0300, Dmitry Osipenko wrote:
> > Add stubs needed for compile-testing of tegra-cpuidle driver.
> >=20
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  include/linux/clk/tegra.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
> > index d128ad1570aa..9bd06d8a5436 100644
> > --- a/include/linux/clk/tegra.h
> > +++ b/include/linux/clk/tegra.h
> > @@ -42,7 +42,11 @@ struct tegra_cpu_car_ops {
> >  #endif
> >  };
> > =20
> > +#ifdef CONFIG_ARCH_TEGRA
> >  extern struct tegra_cpu_car_ops *tegra_cpu_car_ops;
> > +#else
> > +static struct tegra_cpu_car_ops *tegra_cpu_car_ops __maybe_unused;
> > +#endif
>=20
> Ugh... this one seems a bit over the top, to be honest. The only place
> where this seems to be used is in arch/arm/mach-tegra/pm.c, but that
> already uses one of the stubs from include/linux/clk/tegra.h, so I'm
> wondering if we can't define that latter stub in a way to make it
> unnecessary to declare this bogus pointer.
>=20
> I'll play around with this a little bit.

The below does the trick for me as well:

--- >8 ---
diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index d128ad1570aa..d261db7e6060 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -42,6 +42,7 @@ struct tegra_cpu_car_ops {
 #endif
 };

+#ifdef CONFIG_ARCH_TEGRA
 extern struct tegra_cpu_car_ops *tegra_cpu_car_ops;

 static inline void tegra_wait_cpu_in_reset(u32 cpu)
@@ -83,6 +84,27 @@ static inline void tegra_disable_cpu_clock(u32 cpu)

 	tegra_cpu_car_ops->disable_clock(cpu);
 }
+#else
+static inline void tegra_wait_cpu_in_reset(u32 cpu)
+{
+}
+
+static inline void tegra_put_cpu_in_reset(u32 cpu)
+{
+}
+
+static inline void tegra_cpu_out_of_reset(u32 cpu)
+{
+}
+
+static inline void tegra_enable_cpu_clock(u32 cpu)
+{
+}
+
+static inline void tegra_disable_cpu_clock(u32 cpu)
+{
+}
+#endif

 #ifdef CONFIG_PM_SLEEP
 static inline bool tegra_cpu_rail_off_ready(void)
--- >8 ---

Do you mind if I replace your version with that? I think that's a little
bit cleaner because it should be easier for the compiler to completely
compile it out.

Thierry

--UHyHC4/eKtymABGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmFbXbgACgkQ3SOs138+
s6FBZw/9EAf+4DRkBO0hIhFxz4e4w9Vz23kZ0xT5YXEYt0CngFYlggXD5PQuCfZH
g4/qBIezgMbMPB15f+8myIc4f1sJ3n/h2GUiKRyITDUo8J2zLE6GeD5pKqHABGMu
EuBGkDiVNJySIIvj1JwzyO1QACM+s9UaUhJDcmyytBkxYbzjUTz3fjFz2DfV/ROp
FfRdGk7Ql/5iDRuRff9lwPA+Aqmre8ntWlOFZKPtShnvqt565mjsJRCX7P+Q85ra
el80zpmqIaCKNeTyly3IgH7Ju7XlC/VH26IqWEvmr2Se9P7/u0vGUtWTVJGyLiV2
MonsrHV6i44zwEoQPdAj0pxkNENMvNVlkLNav9gutO62iqI6i2m3uOTuqa9B+63G
jGb+oFcl+cDRHOdiLK44WrkIKQOWvEftPdD3ppQW27H7lavGWInzuaP6Xg67wTmi
H/9ah+xWluN8Zmz8vTgQV030ttiuYDEO9tsugc7QpRwUm0TYyr3A1Hpnrdfv6iBg
mTm/wFZLqXGEV1BhkD3iGYhQ6sL+g3XqsH9F4apLkxfbYhp0D9VypUHrrKuTPWm8
F3fN1XQwqepDqrr7iSt4KC5UBzBbauuayq/0l8Zb3T2ypuqWypQ6bAUQB3apYJXL
RuJAOfHe6mbtFYA8MjdGFxSwMnSrMONcXqBYXcdSdXcHAyDT83Y=
=w26+
-----END PGP SIGNATURE-----

--UHyHC4/eKtymABGG--

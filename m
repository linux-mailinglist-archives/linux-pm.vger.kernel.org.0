Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F933AE7C6
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 12:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFULBu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 07:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhFULBt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 07:01:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B90C061574;
        Mon, 21 Jun 2021 03:59:34 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h2so4797683edt.3;
        Mon, 21 Jun 2021 03:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mQxqixLK5rjqMvfwNndLJU9kpq2UUMss0IdRDqE4Nyc=;
        b=YxZQAdUUkLMQ2M2mYkUfSjDJ+SB9P+64CPFg3uK5hM1E/C6K8NmCvjI6fxDHBrBoe5
         Lq7cJ78pC6eJoQL/iMslWnzhkAluJRJRKlpXrcHJnAUBY4LLp/MkPZU7sYhkLRFqBEPl
         0uRZq36q9MKx0pTNYdZeSNZVZbFJ3t7QfDM1AYpc6XcFG9PqXhyyIxdCa5GYj1KE51gX
         CERelqx0rdtwMVSq94UjUjpVTG8H0AvhhKV8qm464N8P+VLib7JBniwt5Gxc5ZaGVkw8
         lQDzEpiPMwHEZaSZ1PmHvgWOeshz1XWPFZ9zBPPsG67Jh3+Her1tkKd/DUdiLjAtUvJM
         joSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mQxqixLK5rjqMvfwNndLJU9kpq2UUMss0IdRDqE4Nyc=;
        b=njVvNvWBWgtdZ4Zc1jjo/ZF+k+3FXSkkPtDGHEfIuLP+Cg8Q9uCnfWcBTBgSvJIMSs
         spH7Wi3g8Umr3zNOgt84mH79d/Mtcq9IJBJTn/n8zKcsV2lXDfYqv1X6M5DaRDhtHH9/
         UiXbotFVdvKNAhqNhmlFpb35u/y8F/X7RL0y1WBOBRnstIadJxdk3WaxEMiWw0P1bgsy
         YXt+l0h06hjYfLNU0p9Un549obS2D+RHtnaIa78e28HEEss+KGkwPDp6d1hLDpjx15Gy
         oi04iO7HjJv1IAtdz234B6p0Abkz1bhwS3rUpN06abQEvh9Si9QhlUeGy799pSpvdvXa
         OXjQ==
X-Gm-Message-State: AOAM531ZSS2Xkjy6w9PUPPET8Jm84LZJ+AnSx4Dx8slY5KBeboBZiaJo
        bRz/+oQ1c4cgV4bUWeq8B7w=
X-Google-Smtp-Source: ABdhPJygm2GSM+8x1mA8AMigPK6YI6mwpzcBwg47WwZ0gmXyzshqwUTK6KliNuLXNpTFL6h27g8Z5Q==
X-Received: by 2002:a50:fd1a:: with SMTP id i26mr6912086eds.181.1624273173262;
        Mon, 21 Jun 2021 03:59:33 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id c15sm7817001edu.19.2021.06.21.03.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 03:59:32 -0700 (PDT)
Date:   Mon, 21 Jun 2021 13:01:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Matt Merhar <mattmerhar@protonmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v18 0/2] Add memory bandwidth management to NVIDIA Tegra
 DRM driver
Message-ID: <YNBxiFXMS9rfT93c@orome.fritz.box>
References: <20210601042108.1942-1-digetx@gmail.com>
 <8accfe1e-fc48-21ca-f7c6-bd2d60162e6d@gmail.com>
 <50912a57-aa43-58b0-02d2-6928578d6286@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hHIGeTg/3zFQR6Mt"
Content-Disposition: inline
In-Reply-To: <50912a57-aa43-58b0-02d2-6928578d6286@gmail.com>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hHIGeTg/3zFQR6Mt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 21, 2021 at 07:19:15AM +0300, Dmitry Osipenko wrote:
> 07.06.2021 01:40, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > 01.06.2021 07:21, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> This series adds memory bandwidth management to the NVIDIA Tegra DRM d=
river,
> >> which is done using interconnect framework. It fixes display corruptio=
n that
> >> happens due to insufficient memory bandwidth.
> >>
> >> Changelog:
> >>
> >> v18: - Moved total peak bandwidth from CRTC state to plane state and r=
emoved
> >>        dummy plane bandwidth state initialization from T186+ plane hub=
=2E This
> >>        was suggested by Thierry Reding to v17.
> >>
> >>      - I haven't done anything about the cursor's plane bandwidth which
> >>        doesn't contribute to overlapping bandwidths for a small sized
> >>        window because it works okay as-is.
> >=20
> > Thierry, will you take these patches for 5.14?
> >=20
>=20
> The display controller does _NOT_WORK_ properly without bandwidth
> management.

That's surprising. So either it has never worked before (which I think
I'd know) or something has caused this regression recently. In the
latter case we need to identify what that was and revert (or fix) it.

> Can we get this patch into 5.14? What is the problem?

There was not enough time to review and test this, so I didn't feel
comfortable picking it up so close to the -rc6 cut-off. I plan to pick
this up early in the v5.14 release cycle and target v5.15.

Thierry

--hHIGeTg/3zFQR6Mt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDQcYQACgkQ3SOs138+
s6HM5Q//eNrrfdv1Eha+kmKoOay07IzXHohR56bITStHor3M0uzvNVZaSCcADjl4
FpHEAIfe2FuS41Y81iUZqV3PmRNXloneCz4vzgFVkmz8poeq5aPwiQlsSPEzRawt
UJbyYSGTUhtM8GvqxW6TL47M8wYCYND7bTp+GIh45nGPSuZlGIhT4Qp9zqfxARn7
AmuA/lUkHxT5krTo1Sx9PfTENLPxMikM4MdahTnro0S1WAOqWaudqnWidV81jA2j
pAektGCfs5uanFq8nOjpO4/AkHmYfq1FSOS0ZpYn2eyhDDK9BDPLuW4L3ithBl1o
r+vqwedj/xAPeOWxha6JwEvMwhRReZHN0/uZTlWDnqvAVgVFrptefGKo7V355Brw
NRgJrJFCdoCW8m2FntrRCoxTqDy0v9h+607vD3myk9pyD94IZ7SeKEwyh31vKls3
OwIGQEVPgyDXoSolj/rG7xwF2vDN+OaW+hidqmuM3p5xpjOqwToJ996s0F0XuUc1
x0uKQ5+jnuRH132Nn2K73OBFzBS6Le/h1N/DLtxOhq1L3VcZczRx9MYDR5aT6p5r
Pug+Byyy3Qx0TRDUq6P+bJGTHu3di+ty0Rvrd/LdbTCXHNNctN/N95ZUseeUsG1E
RnN2FwphYn08qZ5QKGWesnLj4+RJHVjH+c8PpXjyaj2FNXyvsZU=
=NJyS
-----END PGP SIGNATURE-----

--hHIGeTg/3zFQR6Mt--

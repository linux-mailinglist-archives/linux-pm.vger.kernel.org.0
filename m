Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5AE29AD6B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 14:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbgJ0Nfg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 09:35:36 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:46380 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbgJ0Nfg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 09:35:36 -0400
Received: by mail-ej1-f66.google.com with SMTP id t25so2218884ejd.13;
        Tue, 27 Oct 2020 06:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8mQg3nh3RaesRS2P5WKkQKj2n7Sdjc0/yYomgGjrqio=;
        b=iNNryRd2nlTyxGTMh11x7reba8pbjJ8oqfWUoqPdnRReHWdK6LUDGWM37tgyyDiv2N
         nmVRPh2dnjwsreFvaLadAUa4r0NXafbS0cJjVn0CEAGJx4eOdW2Em5ss8a12y8JZMB+4
         /S/Yln/enOzx6L1kmudHZ1nv+NQ9o1lPA0rJg7590Wn4H6Qss8bLjEmxtM5fCCN7o9Wf
         sHUahJRhBp6VZkCtCdUFCawRCFuthVnlM3P4VIhf4F3UwSrkUf7OXKU35ikqReEa9EaX
         qKd2NASh2NmgCn+6hfZM55WiAUQ7wBFXG4WsqUWSa9XEE9JWgDuJLG4bQJJSkp7p7s2S
         JfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8mQg3nh3RaesRS2P5WKkQKj2n7Sdjc0/yYomgGjrqio=;
        b=DR98hxxTxDEYd7wFPoqFfELoL2kOdlZeDdVd20p4ZKl2p1ybiUwFX0pO+aN7kqVAip
         XLbB/Im6FTZNxfqwbbAGRYgtMfKXs3u00N/K1XyTLEB8W0p9IwppR9FuBhAeTJdbbHUt
         gt+zSyTcMKIRFsBmPkoBm4EdVUyJ1u4Uo9VxwlnS1cNoO1ciA0y22haNVXA86U5168F/
         WjOy0cFagMCLUx67L09luT/i7fUNa0pYvormWcINnlawI8gdhePE/8EhZoVW3+u2YvB6
         dH9iulXpqCHrjui14euqCpWcHqbjrQm99YscVqj00/5E9LfLXNvN4xChgWW9MfwrzC6/
         cQvw==
X-Gm-Message-State: AOAM530OH7xtpqH+VDXHaVeQlS16qddENbqROKXI9VNWLzs9WOpa+nSR
        YaQTg5e9N17/DfBkgIRNdFg=
X-Google-Smtp-Source: ABdhPJyOS2GplJQHwJKYItyPwxlHn7uJ1Z/j8baAH8JyKjiTKLXB69/Mh3ufO4PujfYg/8EqfgktPw==
X-Received: by 2002:a17:906:c095:: with SMTP id f21mr2593939ejz.108.1603805733846;
        Tue, 27 Oct 2020 06:35:33 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id 6sm1054545ejv.49.2020.10.27.06.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 06:35:32 -0700 (PDT)
Date:   Tue, 27 Oct 2020 14:35:31 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 28/52] memory: tegra: Add and use
 devm_tegra_get_memory_controller()
Message-ID: <20201027133531.GI1822510@ulmo>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-29-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oxV4ZoPwBLqAyY+a"
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-29-digetx@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oxV4ZoPwBLqAyY+a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 01:17:11AM +0300, Dmitry Osipenko wrote:
> Multiple Tegra drivers need to retrieve Memory Controller and there is
> duplication of the retrieval code among the drivers. This patch removes
> the duplication and fixes put_device() which was missed in the duplicated
> code.
>=20
> EMC drivers now use new common devm_tegra_get_memory_controller() helper
> instead of opencoding the MC retrieval.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c                | 48 ++++++++++++++++++++++++
>  drivers/memory/tegra/tegra124-emc.c      | 18 ++-------
>  drivers/memory/tegra/tegra210-emc-core.c | 39 +++++--------------
>  drivers/memory/tegra/tegra30-emc.c       | 18 ++-------
>  include/soc/tegra/mc.h                   | 10 +++++
>  5 files changed, 74 insertions(+), 59 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--oxV4ZoPwBLqAyY+a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+YIiMACgkQ3SOs138+
s6Hfiw//dsmnyOi26C1B542Xl69Kt0RSahaqPgCob+RFtXhq//XjyEuLvOvQAjRe
lxz5ae9bOY4g4M2xwaGEoD+itgWFP0Ls+bvD5nbLBGnO1Z+oHWlKyGx2qzJveXOj
qP+dJHaaIyBO49MBznLzuWCOiP/lXB32WBNU3i/qsxh9S/7X7q3ihqYqezzrUMfh
Gdhsfj+EWMF5w7ZlXv9WoiR0ZSdmqDTJTuE3JDs/r0olxRtN/wb0PRzAaYo1qyiv
7YRNvSzCDWeap4l0SH+i/Yndul783XqNtZAjEb0oS/wzCiH+szPJNhcozS/2TI+D
Xza9bOPLxiY0GcngyhUQb/z6Z3PfdODVP6tHfFjOKzHnwyh9/XqgyZIzl8dKsk73
n9aYJUmv3cFU9fqqNFf3hjpcwjXIYk1FimqFTrvoC6emwsMjwEu7qARmWqpyIDEA
bMTabxLAnzBW1Q/ftB8K1MK4h24B1jLGG6BfQDwW272+zbRkVP5fI5bhAKn85X1s
npFW3cCKehnIAuxgLIob/RxLcu0T6U5TBD7yqyiuL79WqlW8xpN1oKLirEuToWFi
0XxaYBzC4vWO/5CGlSkbxlfBXNDscHte/b/Rany9br+SuiWFybW3a/IirgDSEzUh
fiH8r5or8XwD6rXR5Qy7IhBmJOYserCHHQk0AGmwMUhfBHPgXRw=
=Gbon
-----END PGP SIGNATURE-----

--oxV4ZoPwBLqAyY+a--

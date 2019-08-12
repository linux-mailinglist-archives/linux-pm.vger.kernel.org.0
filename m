Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0769789A57
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 11:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfHLJri (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 05:47:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53480 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfHLJri (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 05:47:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so11544383wmp.3;
        Mon, 12 Aug 2019 02:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P3Tt0hVFMeQO9WKnMLt0unZfnULQUSGm6Y8+KX1wABY=;
        b=I1sE1d7EaGl/q7KxoFPph8dUQJL5MYq+TkA/7MKHlrpe5pTnqrRQ1Qyq/dyi6nqToG
         6MDKfag1hIXu0R51glp/qPsKBJEqSfBlsp6qYqASxY8rNzk/+ZdFKEF6fIzXTW6yGAqz
         RTmBMzpNT6SCMpxR5GEcTJA2At8Mw+mrnZGrrJYlNEplTz060HdwlOyc7CizuAOH0y+p
         ucsMdOD2Vb0EwMMKYfYaILJqutj7CNfWqG0z7MYxQG93MwGH500Phhh+qr7wsUPRekMC
         wmdZY8gOb8UWP0A6/r90TYJvbiVT2V2e8UXX4xG3lwyaFw1MfmPXG/RxzT1oO5AZRrdt
         XDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P3Tt0hVFMeQO9WKnMLt0unZfnULQUSGm6Y8+KX1wABY=;
        b=EDXm55vQ8+SkobmTfqinOzoLVfBl32dhX5/uMLOHTNkuD/LZRaGUYrBo8nUN8ynf6D
         hWqUiXuDHFKd88IczPNABYa3MCYX+QxEKMvWF9bU9mrQovF/HgYHSSHZ8j0u5yp5AN88
         0DuHdjKHHAEnsUvsoFcwJQawwJU16uh+bCnGuGBgGe7QVZFEFU9DUfpdXAAknlhSFup9
         6D12bxEa2gch9gA1q3//oCyNKNU9Om1gRrfcULGMVB1DSmGoRO/FCl8429xgg1EI0G9P
         V/JhrEIcyEsmVvozpnXvZ6HiK6St68LazfCrpn0Au2xTOYnKvfXvB/0pYmz6XYZ3qROg
         XnTQ==
X-Gm-Message-State: APjAAAWSmFtZrYAp5S8jQMIYkH76aU1DNn1RuGFmWOzlMntLoH+6FOY/
        alC5JL05TNGB6R9npRnpJY+VtNw3
X-Google-Smtp-Source: APXvYqx6wQo6Pmfnamku65GgkuW6kOZqIbz2Qumz2X/qbaAzrxHyWQQ1tTSaVAp8yp6St60D20w5+w==
X-Received: by 2002:a7b:c758:: with SMTP id w24mr2100045wmk.143.1565603255334;
        Mon, 12 Aug 2019 02:47:35 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id u186sm24647842wmu.26.2019.08.12.02.47.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 02:47:33 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:47:32 +0200
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
Subject: Re: [PATCH v8 07/21] clk: Add API to get index of the clock parent
Message-ID: <20190812094732.GF8903@ulmo>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-8-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Content-Disposition: inline
In-Reply-To: <1565308020-31952-8-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 04:46:46PM -0700, Sowjanya Komatineni wrote:
> This patch adds an API clk_hw_get_parent_index to get index of the
> clock parent to use during the clock restore operations on system
> resume.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/clk.c            | 17 +++++++++++++++++
>  include/linux/clk-provider.h |  1 +
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c0990703ce54..f26252e48f73 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1643,6 +1643,23 @@ static int clk_fetch_parent_index(struct clk_core =
*core,
>  	return i;
>  }
> =20
> +/**
> + * clk_hw_get_parent_index - return the index of parent clock
> + * @hw: clk_hw associated with the clk being consumed
> + * @parent_hw: clk_hw associated with the parent of clk
> + *
> + * Fetches and returns the index of parent clock.
> + * if hw or parent_hw is NULL, returns -EINVAL.

"If" because it's at the beginning of a sentence. You may also want to
turn this into a "Return:" section as described in:

	Documentation/doc-guide/kernel-doc.rst

That said, other functions in this file don't use that construct either,
so I suppose this is fine as-is, for consistency.

So with the capitalization of "If" fixed, this is:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1RNbIACgkQ3SOs138+
s6FV1A//VN8FoQqHYUZDRFeTFLp0ScDoXoSuHZPsgTeHnWdfLuI6hjX0BwnBpuou
xp0VC0KcQdVBw0mL+B/0aKRlYcTsXGB0Pk0qi786ZQ5HicqrF7ixVfWNns9TIbAC
WQbjyPR0SoG0kBTfIXn36aSRfJh9ulnaPQjJ/SpoaT+pAsc4IUjCaGFVw+Eu2LNX
Av3p5BKIcCIynHfmMFNgM4wh44PInWZ7KHqW8yVNk+yJV41rSYqzV0TO2ANg/a6b
LaWziwn3XN+aPyuo5dB++g8xIATX2dQSfG6uYjZC4HDt08f3pCBkSEAfyup2xEIF
epEcFzFYBuSqyrMZ587honAJ0a5AqzFDSGCxxZw2qd1MSiW5EaIIdQE1PEiY2zeC
ldZGCn0iMPizacDQqkRrd96KwDsZ1s8oTGHyNya7z+6PHLRF36nb4EEg0OF1AJ95
aj9EI5IfJlfKSN1RSuR1K7DaZzIunI9Ji7Ip3WlkNc4LIBL9duQ0WQ0D6ttFLpZ4
cTcrkgo/uJ2DOaK84DCEt9w21jIkOoiSFstUKBCC/0+IPURVcHC+ByhHOJbjJMge
oYq5uhB2pVscLpnzfjjy5XLBuVjYiapsuWy74tUm1YAyyRvJSLr9+6McvwLjQAHk
hpiiENkRMsXAPGywAKTdlrIUK5JYRyXTR7rVHW2xI5M47aMJOdo=
=fkP5
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--

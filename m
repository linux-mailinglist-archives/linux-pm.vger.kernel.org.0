Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D50B934537
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 13:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfFDLRm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 07:17:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34938 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfFDLRm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 07:17:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so15399199wrv.2;
        Tue, 04 Jun 2019 04:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I4Nlh1oxh4D8WziCsya63A32SoqmVSbQ0MQ1aPaj9FM=;
        b=qcDlu/YDZg6N0nXlI0LMceWz5oX3TXjEBVbGy8NvrqSY89jfzrtvlU1YzMFmpK2OeG
         E0mQvtVk4K9jPPGtfCcxbE8HVDpx4zhO9JOWPSDuaMEKaxLPjBchbjE/coM0VxMpskqw
         VnWJbbjEIp2rQRD6/W07qVkp7de/f8tvJf57RjiMC9F/UnNTlAgvWKregeehDoVyvtr2
         nD3iAAVdgtiJ1gTa+tK1rqnFlyx6U/ugWWgmVbIsBKi/p8NwC3f3M5Hdjgili1JVlexG
         Fzl0JUTtYEG3hqld+N8mKYxnn9ID8QnCWGRE41Xy8t9px0j9br1ewjTlx2cFrWjWzY2d
         XvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I4Nlh1oxh4D8WziCsya63A32SoqmVSbQ0MQ1aPaj9FM=;
        b=Gs5YIGETrx4jR/BCLEQuak06iHq4RR6FL2e9StixdaS0Idl4/59uoen1O2PtYhkL/K
         szyEcSitCUk8PhrxxZo/uF26FIOjJcDDlO0p7ONQpTgPYXaR0wPmmYHyCkjVhMcDdZzt
         e1GbNHARX1KhskKcjcXSdpf8xl74wTzwVBcie03LT4KEQQ0UTbKjc5vXOopEVRYWDRFx
         aHJcjJjeakiVVe/qSDk+9Vqu5txMDoQhuk8i3tPEASNCdHdemHKY7pcH4t9CBM5oaxLF
         b0+fXO+3kDB73HDbszSmwrY9GNjIOV2cDnZVAx6iyUeP2zUo4VaawKmp5Mny8pm5Q58l
         anyQ==
X-Gm-Message-State: APjAAAUZn3N7O4ZvOrKeQpLkX9r0ggqiaALZbZUnJbDqSTycNMabqFdN
        B8sLdW0IDe4tqonXlwEDsew=
X-Google-Smtp-Source: APXvYqwwI6I6XuLGQsF8+bKsyDhocQdX8q+TL6Z66KAJweXTdPDx5G2y38h4pCjGQbzPn8ZbsfYuKQ==
X-Received: by 2002:adf:f7c9:: with SMTP id a9mr10625546wrq.339.1559647060289;
        Tue, 04 Jun 2019 04:17:40 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id y2sm2945569wrl.4.2019.06.04.04.17.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 04:17:39 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:17:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/16] PM / devfreq: tegra: Reconfigure hardware on
 governor's restart
Message-ID: <20190604111738.GL16519@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-13-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tv2SIFopg1r47n4a"
Content-Disposition: inline
In-Reply-To: <20190501233815.32643-13-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--tv2SIFopg1r47n4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 02:38:11AM +0300, Dmitry Osipenko wrote:
> Move hardware configuration to governor's start/resume methods.
> This allows to re-initialize hardware counters and reconfigure
> cleanly if governor was stopped/paused. That is needed because we
> are not aware of all hardware changes that happened while governor
> was stopped and the paused state may get out of sync with reality,
> hence it's better to start with a clean slate after the pause. In
> a result there is no memory bandwidth starvation after resume from
> suspend-to-ram that results in display controller underflowing that
> happens on resume because of improper decision made by devfreq about
> the required memory frequency. This change also cleans up code a tad
> by moving hardware-configuration code into a single location.
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 98 ++++++++++++++-------------------
>  1 file changed, 40 insertions(+), 58 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--tv2SIFopg1r47n4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2U1IACgkQ3SOs138+
s6HpLhAAikOD/x71+zu1xYDAwoqpm21hVqJyJCw4SGxBPQyd9Qx8QkvqyYBWPtbC
R1pkG7PfUtNzB6BKufP5SWIdql+yHDw+R2ExTIWmMtlbcmrw6WLIh84kdHXQayGN
dqmYA+AgkN+xgav7Smk3/iVZPYVvf4HcnFkRq7FsQTjK3D1df0Z/1+ML1vkvrnvU
8FtGNvNiSjbGNPyreLNlKBg910dNFKrGfELPXaldE0pDQ1KRiHy9mOB7Xf+cONzU
nsN+4Zz9NDikD0fVE0f3Tmt0JN8o4XEvlXXe2KnkRG6NPTvynjzPopTS3yErpbt2
hW+2g33QaEn4rXToyiwcMUs6DkjSedDUp0u2Z0tT8nmnRkCnB2uUddLWDOHI5s+c
poqQkzcp+xW3Oqyw9yIOWa63VdCWpAAfbBHHg42PPSR5gtDYsG2JyDvSpqX3t47J
YF9ev0VsKMJydoDEuHW3Jw4Kf6q3f8jTCchhLr95jDgigXbgqHiVNyrS5KFuGaGk
zaIgF32lsIsGKcVH1QTBZlGw2i0ifZXhJaJYsFLQus2PU4CTkm1fKMbC2WCiJ0CR
YjaRHtT3kTZlz3nzfuL/xuRy2WAya2vQZ0sq3on0IXa2+7axyOpPBQxxDSNkt+DB
agqWkjcVO0nHq0YdTVqAJPD+z5nUUwzUoQJ5rpPe5TmKrLWgZow=
=2zu7
-----END PGP SIGNATURE-----

--tv2SIFopg1r47n4a--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7621729ACB6
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 14:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbgJ0NEb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 09:04:31 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:37450 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437290AbgJ0NEb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 09:04:31 -0400
Received: by mail-ej1-f68.google.com with SMTP id p9so2124754eji.4;
        Tue, 27 Oct 2020 06:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+uRUeR/hNBQddSgcO166WdWvgbjFImRejeVy9hATgyc=;
        b=EyA65ZmKIDgbELTunD6eswJw1OFdRTjqZkMMGk12M6zES+zDeaMqPelQX6kKcExW2J
         sQ8iFJZ9CWPIcrwJS8rtR54Sg2fRDNkjrxoAEr2F1hm2JzunOtnzqJXzvju2QG05bUtV
         GuETLblQo1JSSU9vVy/dnvp27xbPNFmE++fSxgqQqtJwgTDg0nEX7xkz2kZxT8cNtoFf
         N+7EJrKUC7Hr8h7m6TKxpVuFKYzjMV9ahPo4r5KCApNmevtp8OuYA43HNmRv3OGOMAuO
         B5qGrDa1ZA+fd6HNw9RLW4ZSf4OcVGvPVwN3gKJ4mXxFGyJ/PwIf2DVv5+7qtKg3dWC7
         n5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+uRUeR/hNBQddSgcO166WdWvgbjFImRejeVy9hATgyc=;
        b=hbzdb1nZtenQ3QxE7VW+wUoUtPSBM1cZJvb35zIutlLab0w2oic98COBE3lejppJRI
         whoQQvsW8hFF/Nth0MxdwB4fk5GL6V8wUOwmbCAdBPcGO9oEMNCeOA4gZRbd77JHraNo
         Tudmk99Ul4087CGvCTQW6IlP/Hint4OQY66GfoezP9QhYNW9kvz4ZNgpHaVEg/FOYnTs
         XkKSdpyxJKCY9OZ9cZnxPgpilRx7DpVkpjLQ7DrC2DVAnCP7ZWTFO8y0ozc9jIUt9FRs
         Ko9JIBFZQGsw4Eva4yR+H6rxUHigzUNc1c1ZVFZnxCCvgItivdXSfxmZLNNzYd3fHjJJ
         zV1A==
X-Gm-Message-State: AOAM533CVkNNzs6RTKP3GulXuB16Gd/JeUhChSaPaFV+XnzbPyvuVpLr
        9yOzRder0TyvtmocW53jwhtFRLrJwoU=
X-Google-Smtp-Source: ABdhPJyN7OogsAv0LGMxmo8LCCXIRgHg56DytYueYZCsWNSDc01Fl6Cqpqd9fSVylgF/Cd9IrYWOuw==
X-Received: by 2002:a17:906:76d5:: with SMTP id q21mr2401953ejn.415.1603803868036;
        Tue, 27 Oct 2020 06:04:28 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id p20sm1047296ejd.78.2020.10.27.06.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 06:04:26 -0700 (PDT)
Date:   Tue, 27 Oct 2020 14:04:24 +0100
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
Subject: Re: [PATCH v6 01/52] clk: tegra: Export Tegra20 EMC kernel symbols
Message-ID: <20201027130424.GD1822510@ulmo>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-2-digetx@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 01:16:44AM +0300, Dmitry Osipenko wrote:
> We're going to modularize Tegra EMC drivers and some of the EMC clk driver
> symbols need to be exported, let's export them.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clk/tegra/clk-tegra20-emc.c | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+YGtgACgkQ3SOs138+
s6FhaQ//XAnzBLQ57FAARJLAiQ/+/J7Z6eHOKF54sUk1tMNp3gRDg1hMQU8FJuhj
GyqgQyr00w43RXQxTjb3hi27kHTfnRexwVLYwh24TloeOYix2+FYm6IT+eSfOPRJ
SnjM9Y/ZMWnq914HhBQoy05aOcz1Gy2nS643L68h3yyVlxPWtUBvw/S0YuPbO8MO
c0R5cXOTwN0RP/HQhnBjFlvP+ICC0yB3vq9q0UQBiZqQfEzXvneIpGPJUpjEMX/u
uICY++vfNgf+sX4VzvIUegPscYHIziI38tRQ6LkCO4gCfyMluZHPIF4Ko+te3nbs
eJP2LzTiGrVwaCNT5CY5JCQEtq6HgEDEcJLa/8hUgRGHaiEIOlcZ6MyrO1PXf1/u
HO7gyh1m/+OVsgA1TJuabKMinojW2y+hdD24FfE8Y8LUOEd+oopV/id+z3Ew/iOi
61Dk/ZzYyMFvoBTet9W+W9+O0B+j0RIeiaxPZcHrREfn2+kCdrNAadjXUVpOTHpf
glXrDyEcxHAKtxamXlgqmRFTzt6YTNUDtcqdfXcjGPMwy94un0Tyuff4b15IjEX3
83y19f9svCLYnPghUhd4/WOHA94lgfZztFs6z+2zM8FHXl/eSwZq7jytrWIWP2Qc
55r/DZspHda6fZOvFsYkvVDJaiRdZxy8OkfcedC6FWHQJGuhrKs=
=MO9E
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--

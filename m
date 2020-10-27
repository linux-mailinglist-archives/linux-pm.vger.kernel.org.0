Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D3C29AD23
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 14:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbgJ0NWr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 09:22:47 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:37842 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbgJ0NWr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 09:22:47 -0400
Received: by mail-ej1-f66.google.com with SMTP id p9so2211887eji.4;
        Tue, 27 Oct 2020 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZMLUYGMKoX9mKM6hDiFyPEhjDprJlxdJ1WTRfMKyP3o=;
        b=AgscIiz/pERLbak/64dOBSVrQjrer1k1W4rN96P2GE8s24Ot2tsq74Mop+nf+k8O64
         USgcYj5qC/+ZKvi8H3Eo6e41crmISbsdAVO/06qsOffAwkjAYKEOofP8vtUird56wk/d
         GKwMasQu73FQXM5+iI48RUDn+3nT/NnuhuvNtW5bOtzo1mhiBY8HI9ImOMnM5/qdiQgS
         cojP+e4gwkt/67ITRbk+0dLzv2RQX6yr/bvHTgZQOrCXv80bg6A7v4MmnOUDB93b0x6l
         WMLs8fwiOZSDQ2srq85Dm/uCJALWK9garTb6IpK8yc62eSkf0ENXmt2at855k5o26AYA
         CNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZMLUYGMKoX9mKM6hDiFyPEhjDprJlxdJ1WTRfMKyP3o=;
        b=PBjwqw8QfFPmYZAAWYn7GFli0XiSbD+pC/AGuu676q7VcOGS7PkIfWmUyeJKrQQBnL
         R6P5rr/e8bq1JjR46qiiKAeGcjLt8tukcI1tgmia6bHwa/giU7c04nYDvJI/Qo0t4qn9
         u8pBWJN1bCQI0u7H+06/JUDXGcXWUf0voIqx/5+ct1ea2QCgEyhNHFaYblSp1RaGrX5f
         6Lo0LEhxoo46zlqU9dgPkMVkLZlIlNjW85qg3ICNaClI7id+iOjZ53FWyND6mw66RTIy
         cgajrLGqXb0+U0aNl5icKoZlHZkPonVw7LlmFncyEzN1pX3NifqoGG978zcYr9f+hV3J
         NdkA==
X-Gm-Message-State: AOAM532Mm4ThelBmyrvsrojJ5vgRaUdEqb5OkxuL1hqtonI9480PJrMv
        FtIoDmtp9hNiFZStLlqBW0o=
X-Google-Smtp-Source: ABdhPJyXjL8T6wqFPXMxyLMjoLY2xwFyK+FBv6JSqLvEj07I/7AQUFo9ETL4qG15rMkiYl4RgDoDTQ==
X-Received: by 2002:a17:906:12cf:: with SMTP id l15mr2526427ejb.540.1603804964390;
        Tue, 27 Oct 2020 06:22:44 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id t5sm977859edw.45.2020.10.27.06.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 06:22:43 -0700 (PDT)
Date:   Tue, 27 Oct 2020 14:22:41 +0100
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
Subject: Re: [PATCH v6 08/52] dt-bindings: memory: tegra20: emc: Document
 mfd-simple compatible and statistics sub-device
Message-ID: <20201027132241.GG1822510@ulmo>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-9-digetx@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 01:16:51AM +0300, Dmitry Osipenko wrote:
> External Memory Controller can gather various hardware statistics that
> are intended to be used for debugging purposes and for dynamic frequency
> scaling of memory bus.
>=20
> Document the new mfd-simple compatible and EMC statistics sub-device.
> The subdev contains EMC DFS OPP table and interconnect paths to be used
> for dynamic scaling of system's memory bandwidth based on EMC utilization
> statistics.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../memory-controllers/nvidia,tegra20-emc.txt | 43 +++++++++++++++++--
>  1 file changed, 40 insertions(+), 3 deletions(-)

Why does this have to be modelled as a separate device? Isn't this just
using a couple of registers out of the EMC register range? If so, this
would better just be integrated into the parent node and implemented as
part of the EMC driver. No need to further complicate things by adding
a dummy child.

Thierry

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+YHyEACgkQ3SOs138+
s6EvOA/9GFUCJRzhojvUyJHzwHHS7x6T3glDA/XF4WmogDP9ijUclThlH5xzRkCP
Lg0hU+S5WFRyfvIJOAA6D1Ou1b1TT9Enr0dO0+Jfq3ShIvaoRBe0XP/vqaKpKqXn
P7VLT3lbs/3ZMzABDnFGSUvLwFqMlfdjXdDEExTOhDbpnoYSaleCiPtFqn4a1yye
1yHG0aZ6zGO4Tyarc9v/ftAXiTMDfVDDUyj1sNwGeeqdlOpVT3nL7tP/8U1IFNOs
5OKk4KGV3AkP/teJOjiw7DJeQpfEItcXvcmSTZx+MzHUUwqdk0my72MUIfDLA8SB
8aB67dBJSUTExjlxSLGU+8GLVKvWrCr0cUMtU018rNNRrMAoazNfOmlU6i02eGx9
ZfzTFqCdKShZVKBJkOHEaxLXt7DJuiwQ1aYzHNVlyNMQpmA8adEfmZPFWWuYLohd
Hn8mGk0ORL5p2sdw5xXwJMOlsE+p5rKiwOsrxI4sCQ4q5stu29jiv7zruPE5pX1n
Utq15ldrFwf1VNjrbm9K0XgAfEVbrBVc7Kg2xMeMCbpTRwuRQk22jF/aaCBUjGue
h4brYNuSOCLxUdcs2NuE6suO+rYJgtT5nehI9PJXG/Y66zyc2Uxui3VqIyZdybID
ZkeKK5fxiMuuyeYPzMU/sAA37rG5xZsOKVVyOOkJOlipMX2gioo=
=a8kD
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--

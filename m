Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB3210196A
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 07:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfKSGbp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 01:31:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36320 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKSGbo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 01:31:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id c22so2080396wmd.1;
        Mon, 18 Nov 2019 22:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V9ZVAjqEehE9TZd163jDDobRL04jul9RIc/NIRcOnxE=;
        b=EsrZgw7TQcDPJOYnuV5mNgHP+RRyegJGuk8W/0SspettSC8OxWtTlYR2AnmgusdtZM
         KNWtAL49JUPYfI+Ain6qom4D8RbxBjzYXWqBIAeEETlhrNdpbQc0EseQPMY2WSiimOR1
         RJ/zeIH+yMvl+VrPplAgYsCm28RSmTWlZmbimQYLJQeEzfT+80XGNVH6u7GR3+lxcJn2
         t5euOa2FIuFXKUnQ07xR++3a+R8pYxnDLE19BHAIpyD+6Vai6hTtpiWdIDV+fEAD9HrN
         SBu+wfbKgYvwlSjbjEOJQ2esyOXkYgNvw7VwJS+IjumqnHEFSNPIfku6yomjUZ9GhRiQ
         eHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V9ZVAjqEehE9TZd163jDDobRL04jul9RIc/NIRcOnxE=;
        b=sf4Y+1ZD01tvFIV/1x6Slgb7pdwRWZJ9bkV7/4TB8S0fD65T8RrQbJzawA5p/imDTk
         HLJnYGt+NJauLBvbI3Nju6hD+bgxMiJ60aLp0CpiPXDaW0b+OqSjbuHMYAcCJWSZ7veg
         JWEDy3W2F7JJJX1ufCs7M/kUOhbqWCWTbuiem01xLtHCn57gH4qC67B1E5hVXK4ocjaT
         /6QZq3PznQ+TDDLQESFiZH/lUYQsSvN2eAUvho5WI2aBnD9+ClakQGcqwDwBC259Icy1
         jrAzIiaKJh6gfNhL1MnD5QDMyBE5PAh30udPgQlNoEPSjh8PjUie/Y+TtX77TRnFm2Vn
         XAqw==
X-Gm-Message-State: APjAAAXQtbtKHsmbl5SNck9otrwVME4yE6sIc/pG9GEjWrrw01aKDSpS
        HAUuNgo8I8GFf+WF8nJe0UTR6b3oMqc=
X-Google-Smtp-Source: APXvYqxjznwI398nWMJI2jkG1ai5MsjbFQzICGTnmQ/ZVsn7P6W4xO6iF+umFKBNbfwyCgLU1pBogQ==
X-Received: by 2002:a1c:3b82:: with SMTP id i124mr3264114wma.122.1574145102066;
        Mon, 18 Nov 2019 22:31:42 -0800 (PST)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id y19sm1976414wmd.29.2019.11.18.22.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 22:31:40 -0800 (PST)
Date:   Tue, 19 Nov 2019 07:31:39 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 12/29] interconnect: Add memory interconnection
 providers for NVIDIA Tegra SoCs
Message-ID: <20191119063139.GF2462695@ulmo>
References: <20191118200247.3567-1-digetx@gmail.com>
 <20191118200247.3567-13-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oPmsXEqKQNHCSXW7"
Content-Disposition: inline
In-Reply-To: <20191118200247.3567-13-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 11:02:30PM +0300, Dmitry Osipenko wrote:
[...]
> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
> index 1238e35653d1..593954324259 100644
> --- a/include/soc/tegra/mc.h
> +++ b/include/soc/tegra/mc.h
> @@ -141,6 +141,11 @@ struct tegra_mc_reset_ops {
>  			    const struct tegra_mc_reset *rst);
>  };
> =20
> +struct tegra_mc_icc_node {
> +	const char *name;
> +	unsigned int id;
> +};
> +
>  struct tegra_mc_soc {
>  	const struct tegra_mc_client *clients;
>  	unsigned int num_clients;
> @@ -160,6 +165,9 @@ struct tegra_mc_soc {
>  	const struct tegra_mc_reset_ops *reset_ops;
>  	const struct tegra_mc_reset *resets;
>  	unsigned int num_resets;
> +
> +	const struct tegra_mc_icc_node *icc_nodes;
> +	unsigned int num_icc_nodes;
>  };
> =20
>  struct tegra_mc {
> @@ -184,4 +192,22 @@ struct tegra_mc {
>  int tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long=
 rate);
>  unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc);
> =20
> +#ifdef CONFIG_INTERCONNECT_TEGRA
> +int tegra_icc_mc_setup_interconnect(struct tegra_mc *mc);
> +int tegra_icc_emc_setup_interconnect(struct device *emc_dev,
> +				     unsigned int dram_data_bus_width_bytes);
> +#else
> +static inline int tegra_icc_mc_setup_interconnect(struct tegra_mc *mc);
> +{
> +	return 0;
> +}
> +
> +static inline int
> +tegra_icc_emc_setup_interconnect(struct device *emc_dev,
> +				 unsigned int dram_data_bus_width_bytes)
> +{
> +	return 0;
> +}
> +#endif

Is there really any reason why we should make this support optional? It
seems to me like we would always want this enabled once it's tested and
known to work.

Thierry

--oPmsXEqKQNHCSXW7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3TjEsACgkQ3SOs138+
s6FtYA/9ES4ueQlrGUANiXpnoYLp+gOvUdGR2Om0k7LXGB1sAbdfCnAXEGv8Nh06
zMwoIQoF7yOagtouSroSK5930bLbrxrxffMXiYMzEZxzH3KmuRbxwxsN+egCLHUH
3aAfDm67bO2QmGnQTltM/nyC22xfvjCr7Eb7Lr2uhoPv+j8Gs8nwev15gw3F/TuE
fD2uAof3D/hlCwQ1eGVJf+PAQQ5c3Et6ivWXj1dLxw/bf2Fho7pxZt+B0XqvLlVR
eoPTflPJAPdqZfYTrkijN+KmHu1S/pzYT/LcTdQij3sTSn0t/rLDA4n15P78KMPd
XsKE8mUVQgJH+891UzGQLfAbmoX3UWAoQSiVMrEJ+6hLlHHEa620QWtIni46gZDP
6bryzTb4s/zkPeNrMbb2+X8iibLCWfI9i+g+aHfaqdSdmyuLj3fwFdcOqLTL1fxr
Pux+quH9+5M+brNCzkB0xBzvPqG4DSQ/Nu9WKHgf4RXARCrhqgauBYAlrK1UpnhQ
PYjrooXnMTFULsmm7r9ysaOQfsTgy7v6UDWlgKAwZApfvVv2F86bJ/jvmN0IOtpA
yiL2iBc27c24lKyzn5s4vLoy1tKEVkVO6D0e2rwP1M+cH7kU8IOXysAFGgNGcc1I
3fyAlnc9BV2mA6kqh1y6UGctADv/EA+uooJ0l4RkhClzWAlry5E=
=BBMX
-----END PGP SIGNATURE-----

--oPmsXEqKQNHCSXW7--

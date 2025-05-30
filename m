Return-Path: <linux-pm+bounces-27887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B54AC90CA
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 15:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68DE16F99E
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 13:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610AB12D758;
	Fri, 30 May 2025 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJ4Z1MWu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC5822B8CE;
	Fri, 30 May 2025 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748613465; cv=none; b=rDakKuC7r8tDQjUyjM6rJ/zyM6qQ36IKU7Z59zWgqLXEUF4pNlMrxmlmq5FPWPcv92GiCr7cNRvQqaiaZuSZHlOf4kt1gn9rFWjOa1dI/G7qeEBNw4ST31uAAcPYjbrPNEDAGWnJh0hLJtdfjDEUvSfscFzzGmLmohmaPz1Y19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748613465; c=relaxed/simple;
	bh=WIVBmamAAgu84xM0ptOS5XviTbJAv0iJbRCNRSQYsmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3yXwqBGAD3irlNnAGpfn+uVXPc9beESzQy9yo5qKPOG/kvNLRBtXblYXh+3dMB3ZODiIgnzutu/6e1EAQVfrEG+illVW5QQu9Y2E2Yn4IrKbPtp2274lCqZfJ68Tt+grdzTzWVQ1zzK8zMl7KD2xVLAI+o7tAcKEtcdM/ZzxWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJ4Z1MWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68619C4CEE9;
	Fri, 30 May 2025 13:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748613463;
	bh=WIVBmamAAgu84xM0ptOS5XviTbJAv0iJbRCNRSQYsmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJ4Z1MWuURgb66k0kTW1R2+ypG9Bb9IkZT4FBzWphPunBQ0wkk0EoMGsLtzniQloI
	 PEOA63uShRzP8ACUdhH0hZjNCbLrAtTFVHhw87NegglPWMRKKtr2dyx67qZHzbM4yc
	 GB5lrXE0dFGvvu+1Qz3ylTlsdbGi99uYzcItQP2HL8B5MkOPOwGhN4fsH/YTbX6yq9
	 7xJsNT6Z+mg7GlSTgZhPA4oNxDbjSLoaUZQaJcAUg7vy+24dLx2o9l0M/a95Binr4k
	 8D81/aIF6N4AAp04K2EiMZ1aKZHinGl87vh7F56zkbW8mwB+RcotUgfl6Q9B/EZGSH
	 0FK9z3EJ8uIyA==
Date: Fri, 30 May 2025 08:57:41 -0500
From: Rob Herring <robh@kernel.org>
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/2] pmdomain: core: use DT map to support
 hierarchy
Message-ID: <20250530135741.GA1598718-robh@kernel.org>
References: <20250528-pmdomain-hierarchy-onecell-v2-0-7885ae45e59c@baylibre.com>
 <20250528-pmdomain-hierarchy-onecell-v2-2-7885ae45e59c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528-pmdomain-hierarchy-onecell-v2-2-7885ae45e59c@baylibre.com>

On Wed, May 28, 2025 at 02:58:52PM -0700, Kevin Hilman wrote:
> Currently, PM domains can only support hierarchy for simple
> providers (e.g. ones with #power-domain-cells = 0).
> 
> Add support for oncell providers as well by adding support for a nexus
> node map, as described in section 2.5.1 of the DT spec.
> 
> For example, an SCMI PM domain provider might be a subdomain of
> multiple parent domains. In this example, the parent domains are
> MAIN_PD and WKUP_PD:
> 
>     scmi_pds: protocol@11 {
>         reg = <0x11>;
>         #power-domain-cells = <1>;
>         power-domain-map = <15 &MAIN_PD>,
>                            <19 &WKUP_PD>;
>     };
> 
> With the new map, child domain 15 (scmi_pds 15) becomes a
> subdomain of MAIN_PD, and child domain 19 (scmi_pds 19) becomes a
> subdomain of WKUP_PD.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  drivers/pmdomain/core.c | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 166 insertions(+)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index d6c1ddb807b2..b8e505516f3d 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2441,6 +2441,9 @@ static LIST_HEAD(of_genpd_providers);
>  /* Mutex to protect the list above. */
>  static DEFINE_MUTEX(of_genpd_mutex);
>  
> +static int of_genpd_parse_domains_map(struct device_node *np,
> +				      struct genpd_onecell_data *data);
> +
>  /**
>   * genpd_xlate_simple() - Xlate function for direct node-domain mapping
>   * @genpdspec: OF phandle args to map into a PM domain
> @@ -2635,6 +2638,14 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>  	if (ret < 0)
>  		goto error;
>  
> +	/* Parse power-domains-map property for Nexus node mapping */
> +	ret = of_genpd_parse_domains_map(np, data);
> +	if (ret < 0 && ret != -ENOENT) {
> +		pr_err("Failed to parse power-domains-map for %pOF: %d\n", np, ret);
> +		of_genpd_del_provider(np);
> +		goto error;
> +	}
> +
>  	return 0;
>  
>  error:
> @@ -2734,6 +2745,161 @@ static struct generic_pm_domain *genpd_get_from_provider(
>  	return genpd;
>  }
>  
> +/**
> + * of_genpd_parse_domains_map() - Parse power-domains-map property for Nexus mapping
> + * @np: Device node pointer associated with the PM domain provider.
> + * @data: Pointer to the onecell data associated with the PM domain provider.
> + *
> + * Parse the power-domains-map property to establish parent-child relationships
> + * for PM domains using Nexus node mapping as defined in the device tree
> + * specification section v2.5.1.
> + *
> + * The power-domains-map property format is:
> + * power-domains-map = <child_specifier target_phandle [target_specifier]>, ...;
> + *
> + * Where:
> + * - child_specifier: The child domain ID that should be mapped
> + * - target_phandle: Phandle to the parent PM domain provider
> + * - target_specifier: Optional arguments for the parent provider (if it has #power-domain-cells > 0)
> + *
> + * Returns 0 on success, -ENOENT if property doesn't exist, or negative error code.
> + */
> +static int of_genpd_parse_domains_map(struct device_node *np,
> +				      struct genpd_onecell_data *data)
> +{
> +	struct of_phandle_args parent_args;
> +	struct generic_pm_domain *parent_genpd, *child_genpd;
> +	u32 *map_entries;
> +	int map_len, child_cells, i, ret;
> +	u32 child_id;
> +
> +	/* Check if power-domains-map property exists */
> +	map_len = of_property_count_u32_elems(np, "power-domains-map");
> +	if (map_len <= 0)
> +		return -ENOENT;

Don't implement your own map parsing. Use or extend 
of_parse_phandle_with_args_map().

Rob


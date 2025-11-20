Return-Path: <linux-pm+bounces-38292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D37DAC73809
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 11:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA7E34E5E2D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 10:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D107A2FDC4F;
	Thu, 20 Nov 2025 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVWYZX+J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04D52F6924
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763635267; cv=none; b=PnoZHQSPItA9YghXz5QZhb3E40SI7o/21l5q3fQhlb3xpdJQ7BjDHb+vN5glb6xvptHEhV0ebCLMbwJiWkecv5Vk439KliTaDORbdsWXSvFbYkZq74bZ/HR1cxTZZ1ir9QfZGYFm8qruIGVHj55T0BG2HUT0By0lt0r83MyEns8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763635267; c=relaxed/simple;
	bh=io0yQaa1iknMZ7l3/uqh69Bqn+IbEs5aipi1mxEhbhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMGUSni7lDIMCDCPTmfTnGQDCyq1NeZPsvXmdVLQIccpiThoeDGkogjDxJ5NtNuyfpxLfLHSl0PoarsFH9smyJEyBBMXHl1fZc9k3Q0XschKznKTXvvYuIa67VHt/t0tX2/Xd4E6aojWZmB3i/V+TykG6czAs+6hv2xEtUMsAIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZVWYZX+J; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a1c28778so8492595e9.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 02:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763635264; x=1764240064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mgwJ/4Ukd3943JvYrBsHnnqudEXP4H0GnoIDUoRcjc=;
        b=ZVWYZX+JN/f8iDmjZp5yg2RjaIzZd2mokkn/eUWWs8lsP+0CaW6MejDN7PO+TeXplv
         5mTNyCO27siIgDdmJFyLxK0fDDrRDc6Dz8vmfExrPt/tQGClM1lixolhBVnF8fk7pTHb
         bvGjbX1+7sKQZ7DggPqMAggGWKNnj0j9YgLG2PHrLgR5Z39qN8ZCzlnwKqq2hkxd/B35
         J8mTU6t2kHgH2b4OuQdTkj4ImqR1WUzFPwvuiPA6WAfHqCvAI7uSmqTZ8vGAkjWCqPcU
         msPEAPWobedjWDKH9Z+0fKmdOlkMMQuGYd2aRMksXP8huVUGatKaltpwyEpEYsKQmkvy
         mrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763635264; x=1764240064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mgwJ/4Ukd3943JvYrBsHnnqudEXP4H0GnoIDUoRcjc=;
        b=cPcsWvmwxcY+IFV3cdaKxUZe5W5yyzPnvFCBzaiJjHQaDFlTzeSLdW5lh73VbQKNYk
         EceFi4ZqljZubgvxmktfl8j4xN5dO+gskx047JdqpOtUt7EpIlTPU+H/5rDaXDDLUXtM
         K+GDn0Rj3XiH/cF0LyDxgsXvh0eXypoy2dGbLVPoL5mOeFplduiarAOIgZosDq3LSWke
         BVFQ6NkPBl9fCoYj5N4SWVlz5u37pCv38eRVA/B+652zGyglew0fByqDk8vVTvvj3g0k
         I9mSDZcDnnjgxllAg16AdqBLrf32qwxNWyIGvMqLJ92fHRgu82wWjcUUO6Uk0pfNx7QZ
         bMNg==
X-Forwarded-Encrypted: i=1; AJvYcCXQSu1W7bYFF2GKMCsyAumsmkkM1SfVxv6Af7lZlDvHnLCGLSzLIDJhQVc/Dft/UD8bIZZmKy624g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+aGVvc26x1DdxlOzXyynCFVz19BVPoiLMdpV3dTESXQs9acN
	t3/eNP75sRW/8inr1SGEwhfd/kGp6yprhkTrpsoOgCo5w9h8QaunZx0X23z9D8semRA=
X-Gm-Gg: ASbGncvdG05nqVDunBhWzh3IeoLW4bjlmfDvA2zokqXQFps3zJuQdKJ9b1zKdCCeiCs
	v11Jru79WfQMkbZM2EtSsX0IqFOfecKH4cVQ+MlIbguvygWXLYtTb4/hnF7BtA75VV9Qc77CIUN
	nnZxpqkOHeDtbGJn9UmaCJzHzb1S/CAxlG1PKCKwKyU2XVdQ4cd81NMLvceu6La1dGcq3KRH9o2
	qOyUg5GBk+QZuBoW6hDuEWxzi6miDQK8+VcRT/RZ1mhGWoNrTSwnpCFUiMK8oBgAwP+K5+0CINY
	NDdlIIodqOz4Q8++5yb6a6qFryDRsqrTD6rSyHy+274kCnQhFsWYJ29GNAy23KY5OQAjoAgYels
	Op2ml34x+vG8v/BTPJWe4KrEEKviGMelu5463J2KEsF+yeTs74PRUdWN+2U3lPJoSOqi4/yKiAv
	dRx+RZVDWcjYYF0PsI
X-Google-Smtp-Source: AGHT+IGGzICrs8WsC0ZES68VHcMi+t5RlEr2PL0lmqRHtaEz9GTuPQDpK/ZRodLwmdHXmR03IHrQcw==
X-Received: by 2002:a05:600c:1386:b0:477:7b9a:bb07 with SMTP id 5b1f17b1804b1-477b8c91ecfmr28935345e9.35.1763635263239;
        Thu, 20 Nov 2025 02:41:03 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477a9731a75sm63861745e9.2.2025.11.20.02.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 02:41:02 -0800 (PST)
Date: Thu, 20 Nov 2025 10:24:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Kevin Hilman (TI.com)" <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v4 2/2] pmdomain: arm_scmi: add support for domain
 hierarchies
Message-ID: <aR7CEzlHFYmQykKm@stanley.mountain>
References: <20251119-pmdomain-hierarchy-onecell-v4-0-f25a1d5022f8@baylibre.com>
 <20251119-pmdomain-hierarchy-onecell-v4-2-f25a1d5022f8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-pmdomain-hierarchy-onecell-v4-2-f25a1d5022f8@baylibre.com>

On Wed, Nov 19, 2025 at 04:58:46PM -0800, Kevin Hilman (TI.com) wrote:
> @@ -110,7 +110,14 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
>  
>  	dev_set_drvdata(dev, scmi_pd_data);
>  
> -	return of_genpd_add_provider_onecell(np, scmi_pd_data);
> +	ret = of_genpd_add_provider_onecell(np, scmi_pd_data);
> +	if (ret)
> +		return ret;
> +
> +	/* check for (optional) subdomain mapping with power-domain-map */
> +	of_genpd_add_subdomain_map(np, scmi_pd_data);
> +
> +	return ret;

return 0, plz.

regards,
dan carpenter



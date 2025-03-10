Return-Path: <linux-pm+bounces-23732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB0CA58BD2
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 06:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242273A9009
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 05:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7331E1C726D;
	Mon, 10 Mar 2025 05:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="elnAhOBb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF181B4153
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 05:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741586203; cv=none; b=nIeSKXdmsFM/1NlpLtN2k35YAw1h5HoWTmA3Nb15cGVPttq4wCtNKrnHWHariVoHos07zLyJgdJEpWnXt8Ld0zXN67h+GcvKMQWUZ017BZjMe6TlMLT7ujYlsVqpWRvIkAqZge9Lg9XqTp3ApEp9rKBcr8H1vcApAcqTtFrNJrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741586203; c=relaxed/simple;
	bh=ogc/PLKhLA+4ildeifsiCVubE0nHzzPp5u3yxw5rR0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFg7eu6fmEhFrPuRHUp7/Wg14huhFA8Qbaw/fNylmtecluCKWOq1Ho0uAoxQuS8b59DDRELLAEYGbaQgrqrW/yMe4gAvl765dMbkkMTWt4OlNlamHbPMKKkc6CTu600j8M38/ExTrUUl6FGVV5P9SUZawgFsOR4yr7cN7e1eY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=elnAhOBb; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso6091880a91.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Mar 2025 22:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741586201; x=1742191001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CN+dyAjCjHljtJLuzbqtk/LFsy9u3W/5RR8dhe14yeI=;
        b=elnAhOBbTIIs9z8uc+B5NwMh4Sp35P5390Q6O3iOJ5eahnfRkh2TL8YyOUsmUZqUX6
         KaweTvZzZykV4AMKza8zhUDLzZAn8Suhp49TTRqqVfxajlurGWyhNfPZBFqiXHIF+XLl
         dnGrwNEw8IY6DyL1MgdLsucA0U9KsmMakYHbIps4Q4FsBeKXsMnSCORt5THlclJ0Zc//
         jGjt4uiiTct9ctIgBbYjZpWwPY2HDKN03hZ+Q/iyaksT3eVid735vx8WNUa3KNUsEJl5
         nPtCbmI4H1cZYF3XpYTLe7+GPEG2gRpU7Dwoz6X5Id8kU06Q3y+Z4qClqz7C2pkCAwJW
         4w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741586201; x=1742191001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CN+dyAjCjHljtJLuzbqtk/LFsy9u3W/5RR8dhe14yeI=;
        b=ceuFwzJ1kRrcdZADeiVvzPz7qXz9Uyxgy4jjBOCcYxU+m3BNJfxWD6bWKEjhvPjgxQ
         PSjQMaCftNPQF4mGlRkW/aN+aBns3Y+h2uROG7gG2hhu6sLP9IL0PGMm9S0nlVJ+a/pc
         pt1Xo2SyyxWA3kO3TahRGj2FWKuTNJox0fstpjvt3Ru48pa2HNgBderx54DU6JSYbcEU
         Eye8fLr6OKDpM6UaH7+AoNg0ZXlTs3G943Nx/n3mOGmJq8QubY4vpewnBxg0eVZ+Vnss
         YfKYqW8RwdtbrIgfJAOeP3ELz8M0pgtsgs2VOWzQ6o0ybZX2mFsDSKI5hVsJi1wJzta0
         qhIA==
X-Forwarded-Encrypted: i=1; AJvYcCWBYwL/QK2Nt0p/dp49ONkYZxHnqQhUbaFDB/tcKAB/zqr9XyvCFFL9b6WQpr9h36Q17uAN80WUvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YywEMKzU08lSe2+/pXw/d3FARLnhFU3oKjjQejjYIGwlgp0IUGD
	4KyDB8uLGfDvD4o419q9ps7sfEWII40ziOl4Nr1VA6YKcnLHQF0VM2yinE+WhtI=
X-Gm-Gg: ASbGnculps5PK2no3/tfrnhIKrJ7Z+6Ejf88+hEYG+HbjQEN+etPLL7tU3PlJMDglb1
	Me7m6kK0eFVb3JxlH2eIF34uXCZh0TXZBVztTPqE5ZXXd+FzLrxElGlyzFjIjKW0K+enH6eidLw
	1Th+LuhWx3i9IGFicFFFXtJGMum0+fnhct+3EdAUPDmk9/SU79i0ADjplFVkOZBOlnOK11WCjT9
	mV6pedjGqUpCbzVHnAtLyCzrTIeRdrn3ePRaUXrErXD1A33Qe7dgkl5STPZrjv47UeXGzUVY+/G
	A9K9NKwNj9fJAx6gSZmoje/KpceU0qpdm3qvB2Yh/guw7w==
X-Google-Smtp-Source: AGHT+IGs18fScHki5qpjheaZbhsERO386I6rYov4XoF2rp1kLIxdhWJTut8A6tr/2Pu8Pb+kVYz/YA==
X-Received: by 2002:a17:90b:3891:b0:2f4:432d:250d with SMTP id 98e67ed59e1d1-2ff7ce93e54mr18647514a91.21.1741586201179;
        Sun, 09 Mar 2025 22:56:41 -0700 (PDT)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff69374306sm7038067a91.22.2025.03.09.22.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 22:56:40 -0700 (PDT)
Date: Mon, 10 Mar 2025 11:26:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zxyan Zhu <zxyan20@163.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] OPP: Support multiple frequency points with
 opp-hz-<name>
Message-ID: <20250310055638.tvxz2y2sxm3e6hw3@vireshk-i7>
References: <20250304125256.3361648-1-zxyan20@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304125256.3361648-1-zxyan20@163.com>

On 04-03-25, 20:52, Zxyan Zhu wrote:
> Current OPP driver only supports a single frequency value per OPP
> entry using `opp-hz`. This patch extends the functionality to allow
> retrieving named frequency points using `opp-hz-<name>`, improving
> flexibility for different operating modes.

I believe you have a use case for this ? Can you post that too ?

> Signed-off-by: Zxyan Zhu <zxyan20@163.com>
> ---
>  drivers/opp/of.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index a24f76f5fd01..d20802b0f89c 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -752,18 +752,30 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
>  static int _read_rate(struct dev_pm_opp *new_opp, struct opp_table *opp_table,
>  		      struct device_node *np)
>  {
> -	struct property *prop;
> +	struct property *prop = NULL;
>  	int i, count, ret;
>  	u64 *rates;
> +	char name[NAME_MAX];
>  
> -	prop = of_find_property(np, "opp-hz", NULL);
> -	if (!prop)
> -		return -ENODEV;
> +	/* Search for "opp-hz-<name>" */
> +	if (opp_table->prop_name) {

There is a helper to do this job: _parse_named_prop() that you can
reuse.

You also need to update:
Documentation/devicetree/bindings/opp/opp-v2-base.yaml for this new
property. Entries are already there for other -named properties.

-- 
viresh


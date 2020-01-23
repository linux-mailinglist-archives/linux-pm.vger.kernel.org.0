Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83BA7146448
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 10:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgAWJVT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 04:21:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32867 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgAWJVT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 04:21:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id m10so867568wmc.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2020 01:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xV3Uvkw8+OKQ7AftPuv/zmhYvZIHcGHcet0EaY1PAMc=;
        b=aJkEKjQE3/f/64n6gImLdzT+UNKKttZ48omBh4KiBPym3GoXm8GSuH6mE22tAdBcGt
         fuKc3sUcl6XicHo5fuIj6mBUcCYcT9xb3zmk3gh/AqpX7Bz8Am/n8Zg3N5YqqijEm4r3
         3Gh5c4uAX1iWP83gsm+R4YH8IroSTl5LU1KciYpYAkCTgYrXiJydcrspHreSQ3rvPAEu
         LTFBgVjaEX5MuhS0pM1rhr4seoyLYYDEyg/vYhpHSztOw9c/wevwr5AVb3FflLItnJPi
         Fio1TVhDnVFjN1sibND3AWJbdWCZgfifdPWp7haO4tXLOq7GuMbU14zrsE+mfu6qO1lE
         jHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xV3Uvkw8+OKQ7AftPuv/zmhYvZIHcGHcet0EaY1PAMc=;
        b=ouZ5t6IvmrZzg2hwCNyOdYhVoACJn9ATghOT63Rv+234zxg3w0TvIb3wmZ5Cgey00G
         Qws76JfUdjkCvw2jOVD+9QJ+ZKRWvJVFS3l9YXCT+GMMycdLMPkOGzL9Obrc8An8l8lg
         XuSCBGeeRJJBRUi51u8aQCXK2lL+ULH/WT0QwbCBB8r+/sDrpUrz4JDc2njRJ0S5NfhN
         P2rv2mVUZMDgzY2ZPfw3Z3d6eXUUfvk7nVWOS07+w4dpvieBfiQ9VtwL2BWiLHB/lm7O
         us5KFxkqMgcF5+Ocu4CTICR4Tn1QDDsz55jhsVZ4NoRcXb5ZGERKmlbP7Cy6My/3ZW96
         sIaA==
X-Gm-Message-State: APjAAAVa8yjuzp4vHG9GNrSYc1LLRrDWtVnmAu4rMdK97vHRhVQDR0yA
        2inhLDV10jYNsSGdioH4Yn0+RJzLKCY=
X-Google-Smtp-Source: APXvYqy1vlVz7qyejgOuFFbvGcEkpeTJ+lzK24Qpa4hx8aUH6pO5chF+TO3i/Jkl4gOAZG92tjBh0g==
X-Received: by 2002:a1c:964f:: with SMTP id y76mr3044669wmd.62.1579771276425;
        Thu, 23 Jan 2020 01:21:16 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i11sm2316949wrs.10.2020.01.23.01.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 01:21:15 -0800 (PST)
Subject: Re: [PATCH v4 1/3] interconnect: Export of_icc_get_from_provider()
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, krzk@kernel.org
References: <20200116144202.12116-1-a.swigon@samsung.com>
 <CGME20200116144241eucas1p18dcf099873015e955d71d90712bbe9e0@eucas1p1.samsung.com>
 <20200116144202.12116-2-a.swigon@samsung.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <45e28d51-27db-2faa-d633-3a3d857ecdc9@linaro.org>
Date:   Thu, 23 Jan 2020 11:21:13 +0200
MIME-Version: 1.0
In-Reply-To: <20200116144202.12116-2-a.swigon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Artur,

On 1/16/20 16:42, Artur Świgoń wrote:
> This patch makes the above function public (for use in exynos-bus devfreq
> driver).
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/interconnect/core.c           | 3 ++-
>  include/linux/interconnect-provider.h | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index f277e467156f..0be1764d3528 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -330,7 +330,7 @@ EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
>   * Returns a valid pointer to struct icc_node on success or ERR_PTR()
>   * on failure.
>   */
> -static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
> +struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
>  {
>  	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
>  	struct icc_provider *provider;
> @@ -349,6 +349,7 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
>  
>  	return node;
>  }
> +EXPORT_SYMBOL_GPL(of_icc_get_from_provider);
>  
>  /**
>   * of_icc_get() - get a path handle from a DT node based on name
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> index 0c494534b4d3..cc965b8fab53 100644
> --- a/include/linux/interconnect-provider.h
> +++ b/include/linux/interconnect-provider.h
> @@ -103,6 +103,7 @@ void icc_node_del(struct icc_node *node);
>  int icc_nodes_remove(struct icc_provider *provider);
>  int icc_provider_add(struct icc_provider *provider);
>  int icc_provider_del(struct icc_provider *provider);
> +struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec);
>  
>  #else
>  
> @@ -154,6 +155,11 @@ static inline int icc_provider_del(struct icc_provider *provider)
>  	return -ENOTSUPP;
>  }
>  
> +struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)

Please make this static inline, as we may see a warning in some configurations:

In file included from drivers/devfreq/exynos-bus.c:18:
./include/linux/interconnect-provider.h:160:18: warning: no previous prototype
for ‘of_icc_get_from_provider’ [-Wmissing-prototypes]
  160 | struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~

> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +
>  #endif /* CONFIG_INTERCONNECT */
>  
>  #endif /* __LINUX_INTERCONNECT_PROVIDER_H */
> 

Thanks,
Georgi

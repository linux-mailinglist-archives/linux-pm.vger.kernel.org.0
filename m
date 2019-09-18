Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE1CB6B2D
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 20:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387655AbfIRSzp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 14:55:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45865 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387625AbfIRSzp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 14:55:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so469333wrm.12;
        Wed, 18 Sep 2019 11:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+GKwkrH213eo66mk9kIsB2wGkIvBZ/XCWq93MBpuNTs=;
        b=OueEn21izs4FiNfS+njmYyDmJU5X6G3uG0wOBWYZvBNGf0ER54EvxnKr9Q0ccGPvd2
         LnE6T6yvOTsyxkFQAtxNbacr1pL8sZfRrAotWH16C0qmiW+N8lbfw0BCNYf747es2cvj
         KCAcqvmMvsVFT3Ij1zUjWcCeWa9bMruHC9wxwqulgpvN0Hy+CSeV2Wnm3oV6eZEDTxNA
         nyc2aEhk0mAz5MJivpdZU4v7p14Wq5zd6cN6SYRTK+ruvBOfI8JB34S3LdwMUl5UjIg/
         l3/8ggPMqLUhifeXimbiR+Zl5nSsgjxLRlLnXvoYGNtrclJ+x+SQ29CGT03HL4bnbL2I
         VkLQ==
X-Gm-Message-State: APjAAAXAjp4QkG6PzcD9gN8FmTIJsvtJ6R7v+AFhCQisLG8nz9FSVZt2
        IG5IyUq8/KILuE1p9E+q9Y4=
X-Google-Smtp-Source: APXvYqyxmqfMFEOtiakgqmvEF0djH94lr2Acxh5XHOyom1gmyhLzMdMxPMnU2DIaunXBDTHsoYaB3Q==
X-Received: by 2002:a5d:6242:: with SMTP id m2mr3953159wrv.261.1568832942283;
        Wed, 18 Sep 2019 11:55:42 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id d10sm3312020wma.42.2019.09.18.11.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 11:55:40 -0700 (PDT)
Date:   Wed, 18 Sep 2019 20:55:37 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        kgene@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v2 1/3] memory: Exynos5422: minor fixes in DMC
Message-ID: <20190918185537.GA8463@kozik-lap>
References: <20190916100704.26692-1-l.luba@partner.samsung.com>
 <CGME20190916100717eucas1p1b8d24c74c4d0bb385aa3455cf98c76bd@eucas1p1.samsung.com>
 <20190916100704.26692-2-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190916100704.26692-2-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 16, 2019 at 12:07:02PM +0200, Lukasz Luba wrote:
> Small fixes for issues captured by static analyzes:
> used kfree() insead of devm_kfree() and missing 'static' in the private
> function.
> Checks which show the issues:
> - drivers/memory/samsung/exynos5422-dmc.c:272 exynos5_init_freq_table()
> warn: passing devm_ allocated variable to kfree. 'dmc->opp'
> - drivers/memory/samsung/exynos5422-dmc.c:736:1: warning: symbol
> 'exynos5_dmc_align_init_freq' was not declared.
> 
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 4 ++--

Thanks, applied.

Best regards,
Krzysztof


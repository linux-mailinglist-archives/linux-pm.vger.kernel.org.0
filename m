Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06C3203DB2
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 19:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgFVRTi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 13:19:38 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:35420 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbgFVRTi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 13:19:38 -0400
Received: by mail-ej1-f68.google.com with SMTP id rk21so2422780ejb.2;
        Mon, 22 Jun 2020 10:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dwF+2HyripsRV12OwozwKMOV92vpbzRBmk9VOvADIu4=;
        b=mHfzTmaOibHhoOaXJs1bCUFGhmryur7J/05iSvjRCOfXmIzWjGfmoqboCFrB6Aznpb
         FZwKnnhG1Z071mD3q9krJgXJMOoFc/YZ5oDDoCjeJa8xEMml5h/J7XGf/1Gt4pR1mkfx
         ddPhhQ21PP5RQVEGxG7lVfWDaLfDzeJ+eO1/Kyc8EgiXNFcc9vE61WPgLDiAjOcgzjl9
         xIz4SPN2jr46PG0BjpVUgvYsYiYN2JHJWlNjh1gZjoxecW4OQpLQc04CCjqk/UMJlPyY
         aXJAZxFD/TuONyNHkxbvsSwYSC8DhcHgnt4muO31bJZ6/qoZ2px/L99yaQUwdXW3MOdV
         zj/g==
X-Gm-Message-State: AOAM533+bZTPuUcH6I0urJhed+EyNaaoexaGfMSER2BdmJ3TMArAgCPr
        KhuGDsZFM8R3dzDdOM2Wuu8=
X-Google-Smtp-Source: ABdhPJz2mwUeMUW0C32rE1hMGgaTuYKrGZKTMCcB8I+J3u2co7EFXBVXmceGBdWHf5TY8OopyollWw==
X-Received: by 2002:a17:906:68ca:: with SMTP id y10mr16219242ejr.322.1592846376341;
        Mon, 22 Jun 2020 10:19:36 -0700 (PDT)
Received: from kozik-lap ([194.230.155.235])
        by smtp.googlemail.com with ESMTPSA id p4sm3538251eja.9.2020.06.22.10.19.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 10:19:35 -0700 (PDT)
Date:   Mon, 22 Jun 2020 19:19:33 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/4] cpuidle: big.LITTLE: enable driver only on
 Peach-Pit/Pi Chromebooks
Message-ID: <20200622171933.GB4174@kozik-lap>
References: <20200616081230.31198-1-m.szyprowski@samsung.com>
 <CGME20200616081249eucas1p2ad165b545f265bec88a06270d55fce76@eucas1p2.samsung.com>
 <20200616081230.31198-3-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616081230.31198-3-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 16, 2020 at 10:12:28AM +0200, Marek Szyprowski wrote:
> This driver always worked properly only on the Exynos 5420/5800 based
> Chromebooks (Peach-Pit/Pi), so change the required compatible string to
> the 'google,peach', to avoid enabling it on the other Exynos 542x/5800
> boards, which hangs in such case. The main difference between Peach-Pit/Pi
> and other Exynos 542x/5800 boards is the firmware - Peach platform doesn't
> use secure firmware at all.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/cpuidle/cpuidle-big_little.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


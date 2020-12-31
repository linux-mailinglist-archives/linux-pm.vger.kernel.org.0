Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9512E7ECF
	for <lists+linux-pm@lfdr.de>; Thu, 31 Dec 2020 09:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgLaIzw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Dec 2020 03:55:52 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:43601 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgLaIzw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Dec 2020 03:55:52 -0500
Received: by mail-ed1-f46.google.com with SMTP id y24so17605171edt.10;
        Thu, 31 Dec 2020 00:55:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uNA2f0Y9klhzKIC9fDHc8HD2Ytoultdhg1JorPCx44o=;
        b=OGqrSWYHkNQV1GHCVrxJKAsvtEUTtmE5W6WEkZzit7FY5vqCrR3X1oK3uWzEM0T26D
         BPORzGVM/UnQ8kucxGzPqTIXo5jP9Ynzuwa1jCd7DmbRytbNkrcbhAJBM8g/wZC3NU2r
         SURuu5tUDsYgj5WZr+LCQPtP/6xnM+RHLillFiAcSF3pAtNhAmyXeNmJNvc+qLktbNgm
         pw0XzJLTV+a3sQc6+nLJItBc7qUXgsRpRM5wKZwc8QT7VakvNednbAl4UP4iPHjvDJ8i
         NflYolwgID00LGtt6zuQGs8fprixKmD+ZTkVqFMvSADcs/0gCEe6aK5sdN5p9btivzkb
         L1dQ==
X-Gm-Message-State: AOAM533duvYcAQfnEDYcQ1I+p50wJdQoJdJ7oynelqUEkigYWExjra9e
        n68VM5rqemAS0F1yrPrZanc=
X-Google-Smtp-Source: ABdhPJwP5cE4L9i7CK/EJFSuSBeru/Isv9KRT+5KTAwu+XyBMrUwDAHsHT581iTxZHa5NEOez33YGg==
X-Received: by 2002:aa7:c543:: with SMTP id s3mr53448874edr.88.1609404909896;
        Thu, 31 Dec 2020 00:55:09 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id dk16sm19933758ejb.85.2020.12.31.00.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 00:55:08 -0800 (PST)
Date:   Thu, 31 Dec 2020 09:55:07 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 3/8] power: supply: max8997_charger: Set CHARGER
 current limit
Message-ID: <20201231085507.GA69707@kozik-lap>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
 <20201230205139.1812366-3-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201230205139.1812366-3-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 30, 2020 at 08:52:15PM +0000, Timon Baetz wrote:
> Register for extcon notification and set charging current depending on
> the detected cable type. Current values are taken from vendor kernel,
> where most charger types end up setting 650mA [0].
> 
> Also enable and disable the CHARGER regulator based on extcon events.
> 
> [0] https://github.com/krzk/linux-vendor-backup/blob/samsung/galaxy-s2-epic-4g-touch-sph-d710-exynos4210-dump/drivers/misc/max8997-muic.c#L1675-L1678
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
> v6: dev_info() instead of dev_err().
> v5: Use devm_regulator_get_optional(), dev_err() on failure.
>     dev_err() on extcon_get_edev_by_phandle() failure.
> v4: Make extcon and charger-supply optional.
> v3: Split MFD change.
>     return on regulator_set_current_limit() failure.
> v2: Split DTS changes.
>     Add missing include.
>     Rename charger_data members.
>     Disable regulator on regulator_set_current_limit() failure.
>     Fix ret declaration.
>     Remove unneeded variables.
>     Don't dev_err() on deferral.
>     Get regulator and extcon from DTS.
>     Use devm_regulator_get(). 
>     Fix indentation.



Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

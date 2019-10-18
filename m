Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A494CDBC23
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 06:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfJRE4U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 00:56:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36123 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392808AbfJRE4U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 00:56:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so3078436pfr.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 21:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tfGt3fWr1kwumbPQFxe11qp25uq0tySIsvg724aDQmA=;
        b=KGFuI8CR3x3LxE3B6tHHY82iaAVS9aFWFJQHPc+YDlC6ws2OgEqL2mZavAKH21Hx+N
         urFDi/fRju5x2WB1BQ8XO1R+jhVlMWSksN/B4/UY9zRT3GTIcsTPoK6OGJbzVh6MkCSn
         dWSfodppq81ggRbPJUAJlDxbG0cLFaVUy8WsN3qlimvn6ycSFTD5JwLQ3CNuPKBMSrph
         vIPwi1Lc8Bs1jCYz0FoGNy+3P+Dc3DVtB/zJtA5q6eF7nIiOnVVVaayioIwtLC7GhW5g
         EoIGr7xKR0+i4AplYvDAQaua3auhBQQw/9I4V00lXjVImKCm2cQvEpKgzvUDqgTf6iup
         /P7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tfGt3fWr1kwumbPQFxe11qp25uq0tySIsvg724aDQmA=;
        b=XQ8ogv8OZ+R2OB147c164JpO+CziMDd/v91SZWR7OcurB7D2OZstSjp455wjB7ieV3
         kYnYGXjOxunUON0SM3UTti33GVvn+a16AdUwtBJMc5t+hHFqSKGjt6dlMwI+O7YO8nz/
         1S33ivPpPf8ufyc1r+7OX0G4mUSmHXp4dL1y3tkNwRp/6bQB1ICj6Y0A0DXTxcS0SkU4
         ANv5ffNgBYK6NA4yA5UCL3nKYPgrg4ynbynjo5xp20bdloC7GeeqPucDk/l5p2jVLcWT
         b/sJrALm7ZtnIrGx2U98jKk4k+1kF7yIytAvhS8yfZQkeqz2ysz31ZfRO68rjj0COCss
         hAlw==
X-Gm-Message-State: APjAAAUdWbzPaJTY5tztnk3/hNkwS8Npr1rLSDBsCGnvljUKEEOQ6lwA
        kbfS4FDcMv9l8ZgB/FzFm63HmIcZORE=
X-Google-Smtp-Source: APXvYqxXUTl/qqRC2TrizgbN8R5z7HfGkcGAOE67XLCu4N491ssVlmnv2H4qbY7PTZNpiYtxuCM64Q==
X-Received: by 2002:aa7:93de:: with SMTP id y30mr4189899pff.98.1571373029465;
        Thu, 17 Oct 2019 21:30:29 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id i184sm4192692pge.5.2019.10.17.21.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 21:30:28 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:00:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] opp: core: Revert "add regulators enable and disable"
Message-ID: <20191018043026.xm7a6emczm6w7bck@vireshk-i7>
References: <CGME20191017102843eucas1p164993b3644d006481fb041e36175eebe@eucas1p1.samsung.com>
 <20191017102758.8104-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017102758.8104-1-m.szyprowski@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-10-19, 12:27, Marek Szyprowski wrote:
> All the drivers, which use the OPP framework control regulators, which
> are already enabled. Typically those regulators are also system critical,
> due to providing power to CPU core or system buses. It turned out that
> there are cases, where calling regulator_enable() on such boot-enabled
> regulator has side-effects and might change its initial voltage due to
> performing initial voltage balancing without all restrictions from the
> consumers. Until this issue becomes finally solved in regulator core,
> avoid calling regulator_enable()/disable() from the OPP framework.
> 
> This reverts commit 7f93ff73f7c8c8bfa6be33bcc16470b0b44682aa.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> This is a follow-up from the following discussion:
> https://lkml.org/lkml/2019/10/9/541

I suppose this must go the v5.4-rcs, right ?

-- 
viresh

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6932A9C81
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 19:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgKFSjU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 13:39:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36035 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgKFSjU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:39:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id o20so2279259eds.3;
        Fri, 06 Nov 2020 10:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u98Rgpeb4Nt49mc0QG8eEb+MB+Za9caOVTHP5k1gxr0=;
        b=GNZqdZUQZJnyRCmM2ScQAoKrXjtpoL56yijpPQAVR3EJZhFLU0kAksC4UR49zhM0ry
         61P5HebHFhbdnuEsi2E7GqO1nB4hjhuWx1jZUkIhPx6VcSoSzpcJxPQQbpFz85o2e8Ti
         H5GpxY39vQiNd3yMJs+eQNfWtpfl9tiimRjsFe1LJCveoNsH6S9CdAvQ/KiCwMmuby6y
         FGEubsOOk4CfkZ7h2fwRatU7LOVrm3st0MkhFvDUENQ22K6EuLkNrtRR7tFr5JPyuG2u
         4AbO3oD+tCS8JNqJu55OySecxt3U7p2wAs8wjOvDXxPMH+xj/jmXhCRoitXHEN8Jg6ST
         jlAQ==
X-Gm-Message-State: AOAM533yRlytOemkfrZA9VqtRu+hOdYp5VZ7Me0XX4+9SKvQta5dCsyZ
        U4YIgwlFYG2gGJuzrpvETxg=
X-Google-Smtp-Source: ABdhPJxFr3F7asxGB0TOnmt+HUoticWJ2aCBZMi5JRtZ1kzSkCobKCu6kfaAs8KEsD4jnGtxvOiVsw==
X-Received: by 2002:a05:6402:559:: with SMTP id i25mr3576305edx.128.1604687957598;
        Fri, 06 Nov 2020 10:39:17 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id j20sm1588358edt.4.2020.11.06.10.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:39:16 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:39:14 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
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
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 19/47] dt-bindings: memory: tegra124: Add memory
 client IDs
Message-ID: <20201106183914.GS65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-20-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-20-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:55PM +0300, Dmitry Osipenko wrote:
> Each memory client has unique hardware ID, add these IDs.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/dt-bindings/memory/tegra124-mc.h | 68 ++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)

Thanks, applied.

Best regards,
Krzysztof


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4F32A9C47
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 19:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgKFScy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 13:32:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44194 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgKFScx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:32:53 -0500
Received: by mail-ed1-f68.google.com with SMTP id y15so2089555ede.11;
        Fri, 06 Nov 2020 10:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wlqnu3kh6XxuBopLwHKSesOZDYblr5mvOU662DmL/14=;
        b=XUnUPnhYwZyZz4cDN4wmGCa6fkdM0SWFiM8zJ2YnOV1ih0B1UeSUHKcTCVEQjeHQz1
         yYgkvFM37FZSTmDssTURpPlAwCbOIYzrJoUzX63V4xWXoX2FVBgauP+yJ5PQWHLCKqvx
         d9MJqB9WTxqakb+bOOJb7gE3D+epKALhEpm/FNx+izmAEiaNB88+FXS3PvtltuF8UVXs
         6r4oXbq9QkY8q9i7UMOX54gj25hJYfU8Ds/7nwziMEfPwzTGNpDlL7I9+tVETqG9h8v2
         gfBnRLyxHU7Q8xrqoy9JVgVBEi96i2YhfeA7jdJmwvs8GZB8q/DiW31PiIlJbw8OYbQQ
         wqRw==
X-Gm-Message-State: AOAM532agG/jfzczNI+yEHdF2ghXP4C9OXcb6lhl5qW/7qAY6a7/274p
        MkYeeMJmw/9LasxFzZAJa5g=
X-Google-Smtp-Source: ABdhPJysBETw2OKO/y2t2f3uzbaB0a2i9/BYSM2XsqM4nZRH6RmJYYAOOYFH9TJ10tsbJnv1RfwKKA==
X-Received: by 2002:aa7:cb92:: with SMTP id r18mr3553775edt.13.1604687571150;
        Fri, 06 Nov 2020 10:32:51 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id f19sm1627353edy.13.2020.11.06.10.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:32:49 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:32:48 +0100
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
Subject: Re: [PATCH v7 11/47] dt-bindings: memory: tegra30: emc: Document OPP
 table and voltage regulator
Message-ID: <20201106183248.GK65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-12-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-12-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:47PM +0300, Dmitry Osipenko wrote:
> Document new OPP table and voltage regulator properties which are needed
> for supporting dynamic voltage-frequency scaling of the memory controller.
> Some boards may have a fixed core voltage regulator, hence it's optional
> because frequency scaling still may be desired.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../memory-controllers/nvidia,tegra30-emc.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Thanks, applied.

Best regards,
Krzysztof


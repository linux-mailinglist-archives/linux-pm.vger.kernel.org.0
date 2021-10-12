Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233A6429ABD
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 03:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhJLBJQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 21:09:16 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:39867 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhJLBJP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 21:09:15 -0400
Received: by mail-ot1-f51.google.com with SMTP id k2-20020a056830168200b0054e523d242aso14337102otr.6;
        Mon, 11 Oct 2021 18:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oNKIkgIeyAhvnUpCpJSDJiW2bX74JtLFJG0XP81iGgs=;
        b=6gajEEXYe6C6vFabQEyQUzjVs0G3Li2rH4t+vlEEbjBdGceknPXezSO6t+0bIW6xal
         I841YDyc6EqpY30Qu4TixFKMVbYPGb91RutHqNcSwd98zmgo3JmJYDdwQvFKWeuSUR/g
         gf1PyAov72Ck3wGvmLv3E+e3RqVFhk/GVzuXVEPdOJvSjyJxyaVYGDxDShzHhUMVzl3a
         3irKVpTDMVPNDNDV7mL6/WYdkz1HZL5mxrOdCzUh0zDZhRJ5GZyXDsVg6oSo4smJ4SSk
         FhDdyVWCVsJUOY4dlmOKtXw7l+vpvRdCStxYwrMgtdQ8X1458vGMsPzfb7G+6itC/GII
         sQow==
X-Gm-Message-State: AOAM531ZXF473al55iTSlUZLnwVOyBi0I9Djh/BT8AcSmJfyGgUgyvRn
        S3RIvAyq2PamuRb+HXv1EA==
X-Google-Smtp-Source: ABdhPJxZ31PlfFMh6vQNPQjBd9RwWuQtvQ5MQFK70WXxj3fALbzpUEclVT37F2/tAZV+2ZFKR/d83g==
X-Received: by 2002:a05:6830:1c7c:: with SMTP id s28mr22962910otg.345.1634000834737;
        Mon, 11 Oct 2021 18:07:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f61sm2062459otf.73.2021.10.11.18.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 18:07:14 -0700 (PDT)
Received: (nullmailer pid 1514762 invoked by uid 1000);
        Tue, 12 Oct 2021 01:07:13 -0000
Date:   Mon, 11 Oct 2021 20:07:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, linux-sunxi@lists.linux.dev,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: clock: sunxi: Export CLK_DRAM for
 devfreq
Message-ID: <YWTfwZXV/Baz+An7@robh.at.kernel.org>
References: <20211004012739.39053-1-samuel@sholland.org>
 <20211004012739.39053-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004012739.39053-2-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 03 Oct 2021 20:27:34 -0500, Samuel Holland wrote:
> The MBUS node needs to reference the CLK_DRAM clock, as the MBUS
> hardware implements memory dynamic frequency scaling using this clock.
> 
> Export this clock for SoCs which will be getting a devfreq driver.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.h      | 2 --
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.h        | 2 --
>  include/dt-bindings/clock/sun50i-a64-ccu.h | 2 +-
>  include/dt-bindings/clock/sun8i-h3-ccu.h   | 2 +-
>  4 files changed, 2 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D641032C2D4
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 01:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbhCDAAO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Mar 2021 19:00:14 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:38275 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243936AbhCCSkl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Mar 2021 13:40:41 -0500
Received: by mail-wr1-f47.google.com with SMTP id d15so9587786wrv.5;
        Wed, 03 Mar 2021 10:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i+wsmGB3nPUNErG75HhRRgO2R+I8z7au1VtRNGbI3kU=;
        b=S2nDDj6NaKIMfsme7aEjpMBG33w9VV4kEqGW5ih8EAtLxuxh9uZL8xdqaoRTXWxiMK
         HQbx0HfoH7w8pGEfVbNxcHT5iwblIVZ4cGXgqy1MWrPZbvnVicMa4KhkVPKt67ilXQOS
         Z/89ZyjTminPNvP1O3aNHPYSEf3C9KVw2p2rEbnclWrt//1hQx+Ba1ZJEpuGXu5k//M7
         fKMgbO40Uih3T6CzaajXU4TE9UBgrvFrN/k6Q6K7XDLybINIxeKeYeytUENAt6pRMdly
         D8qTTR+yxTt52FKIZKmoZ/6zyPmCuT42R8OA2NdG0ctFeL7OWUkKdRP4tag1Sp6VVy5e
         KH1Q==
X-Gm-Message-State: AOAM531EGJdDZzVHOS4AU467/zWAIaNVs7OkHM0K5xKOXQn4R6On1hF+
        AI7BSs16fXGNH/KEXtQZUgFxMX8hGb4=
X-Google-Smtp-Source: ABdhPJzXlIPSof8TuEU/xmd9uwKvcnqjSaqVZ9KBEX0z0xFsdcZ3JuEcemsbVzh06mpoU6nkjncGFQ==
X-Received: by 2002:adf:c40b:: with SMTP id v11mr28144512wrf.320.1614795584154;
        Wed, 03 Mar 2021 10:19:44 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id m14sm6511797wmi.27.2021.03.03.10.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 10:19:43 -0800 (PST)
Date:   Wed, 3 Mar 2021 19:19:41 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Cc:     Iskren Chernev <iskren.chernev@gmail.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Angus Ainslie <angus@akkea.ca>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 01/18] ARM: dts: exynos: correct fuel gauge interrupt
 trigger level on GT-I9100
Message-ID: <20210303181941.yercebdxswdetf3q@kozik-lap>
References: <20201210212534.216197-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201210212534.216197-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 10, 2020 at 10:25:17PM +0100, Krzysztof Kozlowski wrote:
> The Maxim fuel gauge datasheets describe the interrupt line as active
> low with a requirement of acknowledge from the CPU.  The falling edge
> interrupt will mostly work but it's not correct.
> 
> Fixes: 8620cc2f99b7 ("ARM: dts: exynos: Add devicetree file for the Galaxy S2")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos4210-i9100.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied 1-10 (Exynos and S5P dts patches).

Best regards,
Krzysztof

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F5B22E77F
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 10:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgG0IQV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 04:16:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37269 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgG0IQT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 04:16:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id i26so8147927edv.4;
        Mon, 27 Jul 2020 01:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xMEF9Cxyt25aen2UhueaHcaVL0gklUnwHcCIDT0r9MM=;
        b=tKxIlpD7wwKMMd7VXuWdspymA/474DeMkWUnB6fE6/bxzJjQbpGc9mOJz63rJWt5Tz
         R3PAWGELmADKRfz86v7M5A2uNVbM0JJtuX9Mb9rWbJjEWdk2zdnmDuMZy37RZmEMcBZ7
         ZWS/wYjZnrCh8hXKR7qN/XYeOaA33QE7r5V5EceJICeLIV7Uw7bEFVLq4/HEZCpjt+W9
         pEG5Y/51e2MBAkfWcihc3vEnorm2AuKwwepZ2JZf876ZObi6dFvLjy5qYhD85QeliZ4O
         x6kSy6Cn6GRzSqV8a7rsgtumNhRT+pfIcBfUqXQkkJtH8rIPKGGtUqzjB8egCJpd2Ah6
         HYLw==
X-Gm-Message-State: AOAM531+ct2a7ne6MEwoLcASBgB2FcdWAJiN9t9cKOb19oXSDuEQm+P1
        spU2qMdrfxsmwrWsNj+4KMA=
X-Google-Smtp-Source: ABdhPJzngLugS2G+hQDBLC5w0d3LxwfesuDirevJaplrT1iwz2TEeRYrAyLO+Mj3itnMVVSRJPrwHg==
X-Received: by 2002:a05:6402:13c4:: with SMTP id a4mr11123495edx.108.1595837777534;
        Mon, 27 Jul 2020 01:16:17 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id z15sm6817962edr.13.2020.07.27.01.16.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jul 2020 01:16:16 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:16:14 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/16] memory: omap-gpmc: Correct kerneldoc
Message-ID: <20200727081614.GF17644@kozik-lap>
References: <20200724182328.3348-1-krzk@kernel.org>
 <20200724182328.3348-5-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724182328.3348-5-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 24, 2020 at 08:23:16PM +0200, Krzysztof Kozlowski wrote:
> Use proper kerneldoc to fix GCC warnings like:
> 
>     drivers/memory/omap-gpmc.c:299: warning: Function parameter or member 'cs' not described in 'gpmc_get_clk_period'
>     drivers/memory/omap-gpmc.c:432: warning: Excess function parameter 'ma' description in 'get_gpmc_timing_reg'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/memory/omap-gpmc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to drivers/memory tree.

Best regards,
Krzysztof

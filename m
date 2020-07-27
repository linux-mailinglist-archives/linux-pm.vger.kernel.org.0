Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EA422E772
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 10:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgG0IPf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 04:15:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38530 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgG0IPe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 04:15:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id n2so11461341edr.5;
        Mon, 27 Jul 2020 01:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5fMnGUBo3tLDp5fBSfGcTK2wyOSowlPs+lZWjpcjUdE=;
        b=JZVq981ntM9fXIZq4vZg9WN7V4px4/inCelhh6cslpK/84g1wNYOmftrzKLq6Cji7g
         jeGp/jQYNEhvVxyTDCYH2ZdQkMkp9SABcEKmWdOJ6il2HYB0Ajfw9tgrp7qje/3zQU9K
         gOCRPMcjD6K12DTgSnlpslRu9IQ0viSmRilU4HKzt+uhZo9O0786Vx13imw3N/6ICRxO
         b+RVV9FTClnPfcCnt4a3IZgbyXi6ouUWJbPgLpefJNy8pxO/BtBY85NrULF8jmPRJD/T
         0wTS97iz0O/+5t4VEq9weuOHomWfaMkNkeVBsJ13czB5Uqj1LuUoo8XLCrU5O94zWiwq
         LUZw==
X-Gm-Message-State: AOAM531Bwxwenwq8z5hvG8Y/wSCP8KNAY76G3xpeEpalGvvNEOyu+9Xl
        sbRp4Q/2Fjjr+1quQwgge1k=
X-Google-Smtp-Source: ABdhPJzVZSR99wXtR1v+nu5d1gmP8D7E7iPm+DNOY+Y1br1yhNkW6TaNOaxezWsEQClv25in49SeJw==
X-Received: by 2002:a05:6402:1f8:: with SMTP id i24mr290447edy.251.1595837732604;
        Mon, 27 Jul 2020 01:15:32 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id gh25sm1124072ejb.109.2020.07.27.01.15.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jul 2020 01:15:31 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:15:29 +0200
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
Subject: Re: [PATCH 07/16] memory: omap-gpmc: Correct white space issues
Message-ID: <20200727081529.GC17644@kozik-lap>
References: <20200724182328.3348-1-krzk@kernel.org>
 <20200724182328.3348-8-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724182328.3348-8-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 24, 2020 at 08:23:19PM +0200, Krzysztof Kozlowski wrote:
> Remove some unneeded blank lines, align indentation with open
> parenthesis (or fix existing alignment).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/memory/omap-gpmc.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)

Applied to drivers/memory tree.

Best regards,
Krzysztof

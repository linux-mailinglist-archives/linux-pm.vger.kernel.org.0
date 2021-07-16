Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EF93CBA90
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 18:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhGPQct (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 12:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhGPQcs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jul 2021 12:32:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D158CC06175F;
        Fri, 16 Jul 2021 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=+ZVAm4xpz85ls8m+eACfkwM9aiG6C0ltgRT5LhxMQI8=; b=cMZFl3ZJj/VH1q9Wb5ETK79ZtT
        QihBAZEucOwQNwJrwDrb4ANgPasmf/Z8utphRcwRPShzAyF5cUvARa5KH8vTZZecl35Sbnp34+bPD
        gKyR0RkdMQ2E10MapvpxGZEJCPoFVKFET/MQBwxGO09N+GIxFF+W/HlfBqgOYD6eYUOanAeCy7HaZ
        aFOYzheOuI4iZ5m35RkB+0SOUBIwLQ1009wi1Mkn71mYELvIFHdn3yR7I60y1DFVuA+uf0oavkJr2
        ElajL+AWWHl7M45JaYVZ+/bnuS/cMysV7TjvaCUf9zDJPPyXxy24bIz6hltcgHnm4awCROKKr1F6w
        TKES9yzQ==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4Qim-004rvN-A6; Fri, 16 Jul 2021 16:29:52 +0000
Subject: Re: [PATCH v6 0/3] power: supply: mt6360_charger: add MT6360 charger
 support
To:     Gene Chen <gene.chen.richtek@gmail.com>, sre@kernel.org,
        matthias.bgg@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com,
        Linux PM list <linux-pm@vger.kernel.org>
References: <20210716094353.140536-1-gene.chen.richtek@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a01521d3-bd79-a813-554a-39a750775938@infradead.org>
Date:   Fri, 16 Jul 2021 09:29:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716094353.140536-1-gene.chen.richtek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/16/21 2:43 AM, Gene Chen wrote:
> 
> This patch series add MT6360 Charger support contains driver and binding
> document
> 
> Gene Chen (3)
>  lib: add linear range get selector within
>  dt-bindings: power: Add bindings document for Charger support on MT6360 PMIC
>  power: supply: mt6360_charger: add MT6360 charger support
> 
>  Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml |   48 
>  drivers/power/supply/Kconfig                                       |   11 
>  drivers/power/supply/Makefile                                      |    1 
>  drivers/power/supply/mt6360_charger.c                              |  867 ++++++++++
>  include/linux/linear_range.h                                       |    2 
>  lib/linear_ranges.c                                                |   31 
>  6 files changed, 960 insertions(+)
> 


Hi Gene,

All patches in this series are addressed to "inux-pm@vger.kernel.org" (missing leading 'l'),
so I expect that you should resend the series.

-- 
~Randy


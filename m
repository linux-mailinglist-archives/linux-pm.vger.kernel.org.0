Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EE553EC3F
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jun 2022 19:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiFFJz1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jun 2022 05:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiFFJz0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jun 2022 05:55:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97F9113A15
        for <linux-pm@vger.kernel.org>; Mon,  6 Jun 2022 02:55:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u3so19135496wrg.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Jun 2022 02:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/HGBwVcm94G6hJzxxoyTgU9jvYkuG8KyARLPoR4g984=;
        b=sSIY/sq3tJH+ruvIsuQApXH81UhkfbHOfABcA9lRdOXBMbUsWyeFwDFrglxz8GfoFY
         QmStVG7kQyI/Q+/6pzQ1jyZY82gcQ94oe3qAb4fzAxkirKGmyAUaoqUUXub2FoGcDeKV
         S/Wm7MMIB0Gh1CQX3FHGnak7oG6MzRuQNup0KHkoXlknAeFpQTqPF8kWakz2k1lHJoxZ
         dthp0Z3elQaJG1D3TE/Vs4VI3xS7Hn4Pu8rhIoTTWWgEf0GTiaogaHkE4OCPgIBPe8BV
         1InWXF/vn+LEpsxPD/Vb9arMdS+o9J/eS52eFzf2SzeGhMRIomxC+4FZ1I5qKCu7/UsL
         xuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/HGBwVcm94G6hJzxxoyTgU9jvYkuG8KyARLPoR4g984=;
        b=JHpu27Arbt3zpZe4zPD0NvBkETlxoXJXCIPzzzcWlDpqrR5L5JLD3OkNzKp4BjcJFn
         i/lh0ZRI1RKBwYK01lc87vZvbfSccPju6jwe1Vvv5htO029LL/+v8BnLvuaqcGoKl+X2
         BrJpjaAXzVx6rjtUSMEqWbg+zUWMyeeY7oIH7KdncNBl5XANQ1w3rp/3H/rJPscrtySc
         WZgW7STfX8kbp3bCdxWyphsv6D2MkKSEUcK1cW2p+WNF2/KRY/6AWdCAr6bnA71o5vhf
         Z9QgQgIukk348nKK1hg+y/ci6BzSBvfJwv5cnAnUJvF8coqQWPrEqiVGspSZ8kiq331W
         TMeQ==
X-Gm-Message-State: AOAM530nZeWXWe0xdcL2073U5JFqDEkX38ild2ibez7tsvG6aj29qTVa
        2pqjmRm9THMJV5yTn1mo99b4Zw==
X-Google-Smtp-Source: ABdhPJxFMRPPs4LSY3Kcwnsvn2fgmQxO/3GAT/dfFczxe2I21JguLlXbCT27NpSSDOKSGZaQZm8pJA==
X-Received: by 2002:a05:6000:2a9:b0:210:2530:be32 with SMTP id l9-20020a05600002a900b002102530be32mr21432918wry.153.1654509321248;
        Mon, 06 Jun 2022 02:55:21 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id o10-20020adfeaca000000b0020c5253d8c2sm14659609wrn.14.2022.06.06.02.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 02:55:20 -0700 (PDT)
Date:   Mon, 6 Jun 2022 10:55:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-media@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 4/6] mfd: max77714: update Luca Ceresoli's e-mail address
Message-ID: <Yp3O92gg9LiIzQTX@google.com>
References: <20220603155727.1232061-1-luca@lucaceresoli.net>
 <20220603155727.1232061-4-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220603155727.1232061-4-luca@lucaceresoli.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 03 Jun 2022, Luca Ceresoli wrote:

> My Bootlin address is preferred from now on.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/mfd/max77714.c       | 4 ++--
>  include/linux/mfd/max77714.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

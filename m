Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF9F5AB597
	for <lists+linux-pm@lfdr.de>; Fri,  2 Sep 2022 17:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbiIBPrt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Sep 2022 11:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbiIBPra (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Sep 2022 11:47:30 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E763DBDF
        for <linux-pm@vger.kernel.org>; Fri,  2 Sep 2022 08:36:59 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w19so2631567ljj.7
        for <linux-pm@vger.kernel.org>; Fri, 02 Sep 2022 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=hYq4cv4cNUo/9VVzRmU4eVk/nrbDfe3lb0f5HSAbg0c=;
        b=fXAJ+/P3fhtMN1q8A3rt66vZdRafbtT3fcpkG6YbzOLJGXgMenZOZnNNgfXKlGyB5r
         /neSeMRbtxKr4RaUWpB2ly4PnRRPe3twwNXT5Zp04HSiIrWrtbPfxQPl4d/DCSv7Jw6P
         v6OpRAIcUKGWzfQf/L+mK3HkoWkVWdXaqxmdGC+Oz21BBA6qkJR+PgSYOi4lpfJwFBEk
         c4m+9c6wiXw6W0fyG49lUa9QfrMJ+Lu2JQOHxBNqW5Upsci/xG1gPacMteCbU+aw8w2R
         Wa40oIUi6Z2lVi0NDIyqyuz6OUkgO1Yegq0OH/PklUbwM23JcCeCErq8rCn2j2KUs7+z
         AwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=hYq4cv4cNUo/9VVzRmU4eVk/nrbDfe3lb0f5HSAbg0c=;
        b=UjoGQyNCDJHKsfrclkeL0t8vix+sCVddlb5YXdJzHvabNxwmhiY4YW6uxhLPR+Egsw
         zW+0EnD3bkPyy8Z+l47q1sdkcy05b4d494j3CkDxkXWT5Nifgt1X6W/bgWX/PMvyjiIm
         WhZLQYEN82kqP1CXupF5ydLuaE7YuHAq3nFkpD9KbDKrromIeek5rbkxa4qfSKYv7Tye
         PYjbIl8F/sv/Swx95wL6UWBLE0g5lbh3d+XtQKL5uZlqI5opN4lgA3LlGM7pDWjHTv+U
         sGcVFpzpzDb2RUKjENO/MKMCfi6iqWoRCy6U7ujTpnqb6+JEMl+b/sBvi4IxYyNLeBnu
         iaQg==
X-Gm-Message-State: ACgBeo3p+yrigzuVSBN1d1eBkPWfUN6AtmWF1onE322UcObbbpPfVIbH
        b7o4owW+W9/35xxnAcDw9qjm1UUw2qVfE92vRpMx/Q==
X-Google-Smtp-Source: AA6agR5BgJy2rk6wsD1gHEWSl466MvJsMQgEJ7ryOhxaVIAxSSxBf5O7ox+glstyi65Tkgtdj9RtOlUAM7wEftZQWJQ=
X-Received: by 2002:a05:651c:1953:b0:268:983a:c6de with SMTP id
 bs19-20020a05651c195300b00268983ac6demr3626799ljb.218.1662133017439; Fri, 02
 Sep 2022 08:36:57 -0700 (PDT)
MIME-Version: 1.0
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Fri, 2 Sep 2022 17:36:19 +0200
Message-ID: <CAGuA+oo5HvBo6aVvpXmk+ZEgvAM_zBHW2JZLD376+s7uHpdJuA@mail.gmail.com>
Subject: Thermal Framework, Thermal Driver, Thermal Aggregation
To:     rafael@kernel.org, rui.zhang@intel.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello everybody,

I'm currently waiting for reviews of the LVTS Driver v9 series that I
recently submitted
"https://patchwork.kernel.org/project/linux-mediatek/cover/20220817080757.352021-1-bchihi@baylibre.com/",
then I will send the v10 with additional mt8195 specific code.
The upcoming v10 of the LVTS series will support Daniel's new Thermal
Framework implementation
"https://patchwork.kernel.org/project/linux-pm/cover/20220804224349.1926752-1-daniel.lezcano@linexp.org/",
plus new changes that may be requested from reviews of the v9.

After that, I will submit another series about Thermal Aggregation.
Basically, I need to create an additional thermal_zone with all
sensors registered to it, this will allow us to return MAX, AVG, or
MIN temperature based on all sensor values within this new
thermal_zone (could we call it Virtual?).
A series for the same purpose are sent by Alexandre Bailon
"https://patchwork.kernel.org/project/linux-pm/cover/20220218084604.1669091-1-abailon@baylibre.com/",
the implementation is done in "thermal_of.c" (I'm continuing on
Alexander's work). According to comments, other platforms not based on
Device Tree should benefit from this feature. So, according to Daniel
Lezcano, it should be implemented in "thermal_core.c" instead.

So, I would like to discuss it with you, and ask for recommendations
and help on how to implement this feature, because it is not easy for
me alone to figure out how to do it.
Should we update the thermal zone to support aggregation? or add a way
to register a thermal zone that aggregates other thermal zones?
what about applying some configuration to a multiple sensor thermal
zone? does it override the trip already defined in mono sensor thermal
zones?
And many other questions that should be asked to implement this new feature...
In my honest opinion, we should clarify together how it must be done.

Thank you in advance.

Best regards,
Balsam CHIHI

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEB2696730
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 15:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjBNOnS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 09:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjBNOnR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 09:43:17 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679AA9025
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 06:43:15 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id dr8so40568480ejc.12
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 06:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xrQFXlyYQ6BXMoPDycsGZ57c4QKFYnwrzSnOP2uhY5c=;
        b=AlAbePd1Q3NeUZeR2Fa4w5Tmj4lwGN2RYVp1sWM1JcuteH4S4aia6L6QcVA/zPZHsT
         HUS3yNyPJXYnbv+NeFtGYj16tN1gj/RjA2mrgoEWM+Tvba+fpl+r2SXDxgxa4ufDV1Nm
         k1KyX2CkLJDqPsXtDFta117qhcdJFmoKDznYQcMbE4usvHZ2F8PQZDDwq936sE1AiivT
         UEFYHNyFpMNOoPgBHr74B09zYdfZo44MCPmcBli6jekwlidoc0Q3TOGlnHx/p5bwtuSU
         uMBUhIVhvLKF7A+ozHGqjnoBEywHcWk+8x5UVpFajK6ClMtYyraSEugTIkoiiIX+gkVa
         bzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrQFXlyYQ6BXMoPDycsGZ57c4QKFYnwrzSnOP2uhY5c=;
        b=AKex/CEXirexPitbW9Q17iUHJSZajg9i7dvrpVbwgeDmNtmV8uGntr5dx3kg6tnhVv
         y6JjvyyjyH9lL6U7JqbeKbTF4zM/1wYUjSzcHBHq+7n9fb2GGF9NsLtyyS1IWaPWUr75
         qFWWaARZBqU/yGt2TWJnOWQNViEdwSRKoyz95uTrHEAjBxLIP3exU/o0hOjvwVA2lu3c
         sBqWHiPAtqKdSMMhmyVigSpbubA6lS1EkVgfH7ouOcHJ2hdM2/2dS5Tq0Tt0znT26NBx
         n5eA2oAXA0BVKNrx+3O/9StuPKyUmCeWL3E6PIvQYuc9HUBcbrc0UGXUaUp9cC/KP82n
         BdGQ==
X-Gm-Message-State: AO0yUKXwc8j+1ImIe2xMreZxQdzNdIYcFHmf7HKhh3dL17bK8BhA+2Gr
        CCDBgMBPQIpZ9HvbCsVx0eo9Qc0FYMGKey7FS2l4dQ==
X-Google-Smtp-Source: AK7set/eRZRwT84Ah6k0jwJ445lJrD4natFzZ1kVHXpD+dAT/lHnlzbyOxVzjwyjHZ518E8n33MZrsg1UFD9/40unP0=
X-Received: by 2002:a17:906:14cf:b0:8aa:841e:ae71 with SMTP id
 y15-20020a17090614cf00b008aa841eae71mr1387871ejc.13.1676385793939; Tue, 14
 Feb 2023 06:43:13 -0800 (PST)
MIME-Version: 1.0
References: <20230209105628.50294-1-bchihi@baylibre.com> <20230209105628.50294-6-bchihi@baylibre.com>
In-Reply-To: <20230209105628.50294-6-bchihi@baylibre.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Tue, 14 Feb 2023 15:42:38 +0100
Message-ID: <CAGuA+oqD8qDVw=50dC=Qdi8f1-4YqtN7wKtV-msx3=a_Jb24aA@mail.gmail.com>
Subject: Re: [PATCH v14 5/6] arm64: dts: mediatek: mt8195: Add thermal zones
 and thermal nodes
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Matthias, Angelo,

Would you please confirm if this patch can be applied?
and, if it is the case, to which tree it will be applied?

Best regards,
Balsam

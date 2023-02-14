Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE610696735
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 15:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjBNOoQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 09:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjBNOoP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 09:44:15 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2F7166D0
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 06:44:14 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id t24so396253eji.4
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 06:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xrQFXlyYQ6BXMoPDycsGZ57c4QKFYnwrzSnOP2uhY5c=;
        b=cyHfaTfuSm92uaxOOI5uhaqsN3TkKg07lGrEjNCHarVlWiuxKjf7oCRkDQiSrJ/KIk
         p5VPejZpJlyqc19jdm4yIAtmbX44fCAdI6wqgg9v4YAaok/eEno0mOVacSZXPDhkxp2J
         qbjHuqtbjrasP+JXVegXZbnKWHgRbS2t1jiCNmn6snPhkXdzrJH9qwW57EH/XhQrC7OJ
         GsP5zfZEwJWcGtu9B4PtuDmEAtynzF2fLSrayg1qu971n2vEqSYIpVqTOiG566AkV1yM
         rFM8V/u6mkKZxW8lB4fYFuz9Cm6kI3PSsKOAnaaCx59PjobGSRpOaMstMIaM4G63GO/I
         oKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrQFXlyYQ6BXMoPDycsGZ57c4QKFYnwrzSnOP2uhY5c=;
        b=u8Niwffvgy6yhvG8iZmXjcDjghVzbMaaMZw49wUgoRPR2n8b0wJJXIUu7y1jHzQJJy
         v7DZ6ggdgATyhOPJd2QTWDCvSdiy5fx8MyS/GyCjxARLVRjya7tinZnPPQ8QqvdUnTZc
         aPdSDT1hY3YvXRHoummnLQP/nJ2BAwfUAbrabAATlp7AYYU/z/sOfHpMzpu36w2zCwOU
         i53p3h9kQz/o1lss5xgglhuXKb8otfUJB4vjAOhWbhlB7nPn5Vx9qJk8eBXhR7NbOEPk
         zB14pebWc4ffeGsTMgLrcdFc0yS+hBjVBD3WMSFc4yX/TQ+XN9zhlHjr0w1UrjAChG/F
         vl8A==
X-Gm-Message-State: AO0yUKWieTo7XfcaIMxQJiKcz7U/SUNG2WLNkcoAvuv0N2W7oXuXdH1s
        TvdV3tL7v/PsSSncfw+4t8EmWAFCe4Zoe0s5ae2KVg==
X-Google-Smtp-Source: AK7set/YceEYxxH3TbzkuGJIzLDMG/nIB5TSYUNzc7KRmoGREeVdPIvcdk7XhvgncEgDMo7G5qTrhettsGOZMVxekYo=
X-Received: by 2002:a17:907:9877:b0:878:4e40:d3e0 with SMTP id
 ko23-20020a170907987700b008784e40d3e0mr1424731ejc.13.1676385852883; Tue, 14
 Feb 2023 06:44:12 -0800 (PST)
MIME-Version: 1.0
References: <20230209105628.50294-1-bchihi@baylibre.com> <20230209105628.50294-7-bchihi@baylibre.com>
In-Reply-To: <20230209105628.50294-7-bchihi@baylibre.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Tue, 14 Feb 2023 15:43:36 +0100
Message-ID: <CAGuA+oqOgprdu0dVcmB=qJd5HJjada3d8ZazMpoG-SBPizzuPQ@mail.gmail.com>
Subject: Re: [PATCH v14 6/6] arm64: dts: mediatek: mt8195: Add temperature
 mitigation threshold
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

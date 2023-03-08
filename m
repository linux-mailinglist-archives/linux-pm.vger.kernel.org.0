Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161236B0DD5
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 16:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjCHP5t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Mar 2023 10:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjCHP5Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 10:57:24 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4695AB67
        for <linux-pm@vger.kernel.org>; Wed,  8 Mar 2023 07:56:33 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so67503973edb.12
        for <linux-pm@vger.kernel.org>; Wed, 08 Mar 2023 07:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678290969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b9SP/9+AjaQNqqJgA/usyjVh7hC/+seg8SkazKsVVtg=;
        b=CUsDAMKRuC9iHmD9Gerp7prJzQhdiUnXXeY3NrzEvh/5ifcNv9bNybLeIqepePbiZ3
         N+thrxPlDAf63TCd+SO2/3/EszYQNfJcbn2R778RyGAlXXQ32iw370g9+WEKjDgqKb16
         GpQpfs79wgKCueeMrZ4u57f7WMyt/i3CffCL09AYPcL58z2xlbPxFqhUr9toOMbEpTvh
         IOx94oCWvM1x26U29pGwLImkRyaGV34nb1892YKzmouzmia/95PiDfjo/fGj31QYuiq4
         gJ5TVBad0VIzP1S7JsNMD2OGGK9inNgTeGsAG34Ac2NLyRWAbB+AThfy9SwVSLuNiTdR
         vPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678290969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9SP/9+AjaQNqqJgA/usyjVh7hC/+seg8SkazKsVVtg=;
        b=CZvK50y82vunHSajn1ao+XXLBgPcdZ1H3cBURhilh7nvPjrZSduAg+aeV9j7W2FTge
         ofB+MKQx5arKP9hDFgQU7fZ/K/4lXa6zT1TvDRyexddp80JoGXXNnPhPEb86DU5bHNbx
         60/FM2U1RMTwpd9Q1c8V1rgs82BohqHrSPfYAQp2SDBzLmTCvJRoGz3tgWd9pVewCifD
         4R4dy3tooPRzmpN0SYZnQtWcRt1F1Zk0g4jesCpYQ5Hu4wwf39qFkP4KcR9A3iW+4iwv
         gcKgASuFF1vtXNm3n7ZfTabFM7yOrFCaMBBZnM0Svo3dVftRakBkrtkVFyTMFR2sEc4g
         jDXQ==
X-Gm-Message-State: AO0yUKUEHxoXi51m3Uam9hBry91xdxra4C3ntDNk6JclMllrlpxF+1eo
        apRSgJpgbOch/SMnriGqcD9IDrbipyVtZd56E+IF17m0rWMyffBgc7KZaA==
X-Google-Smtp-Source: AK7set++MSA0kJY6qFTA6KF9CSRsGNNx2sdD4u4ynmCGtlRbh9tzc4ZjvrZARqg48I/75rumD77xOAEhYfM0rWdxZ6k=
X-Received: by 2002:a50:a698:0:b0:4af:515d:5691 with SMTP id
 e24-20020a50a698000000b004af515d5691mr10629540edc.7.1678290969024; Wed, 08
 Mar 2023 07:56:09 -0800 (PST)
MIME-Version: 1.0
References: <20230307135146.86084-1-bchihi@baylibre.com>
In-Reply-To: <20230307135146.86084-1-bchihi@baylibre.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 8 Mar 2023 16:55:33 +0100
Message-ID: <CAGuA+op4n+cFrkJfty2qpcFQQ1bHaK_KbjgUL_CHsPtMx=v7kw@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: fix memcpy's
 number of bytes in lvts_calibration_init()
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, error27@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Angelo,

Could we please discuss it here in this thread?
Because the other one
"https://patchwork.kernel.org/project/linux-pm/patch/20230307134245.83599-1-bchihi@baylibre.com/"
does not contain the address of "Dan Carpenter" who reported the bug
and suggested the fix.
It was sent by mistake. sorry.

Best regards,
Balsam

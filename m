Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42CE6B34B9
	for <lists+linux-pm@lfdr.de>; Fri, 10 Mar 2023 04:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCJDWY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Mar 2023 22:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjCJDWX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2023 22:22:23 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690AB106A22
        for <linux-pm@vger.kernel.org>; Thu,  9 Mar 2023 19:22:22 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id p2so2660649uap.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Mar 2023 19:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678418541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHr1GGsOjXLcWLjsmH/gUiANtjkEwqYh6mSdD4znyFE=;
        b=B90+ToIXUteCBlMGv/h+HRTmHi/Hj5vUhO45dJWlo/KFuWBFEtCuLw1vHQRdVj3a9l
         XPRRun4yKYYLVGrsnB03glAgEX+m4GKLQfT3MSfs01SXEVIWrC0H3Gj2lcuEtRZVmraP
         Q1uW2Rqv+LQH3B2szv8EsVhwNW4VRyLMAquH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678418541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHr1GGsOjXLcWLjsmH/gUiANtjkEwqYh6mSdD4znyFE=;
        b=qy2Mq2dOLreZGTLMPQmH1H/A0Few8nmkuOPH5ZOQ/jRHmKQ+OgO77TAxXexNBQhxAn
         0NqLWWAy1PAAjfynM4YeaXe9oZRWj9ZzFP14fTHhXkNA4jYyrMXHejMkJMZCiZ6pEJZy
         7JTkKvKQrBCIGTqjmddwqH7m2jvmPSxskSQwRfV+9k8hJIuevLyYPifKmCLDMM49tEvT
         ruyaXSqGkzVc2WATeyjucRklHXaZoXBq2snoia/YIrwvbdZLehhru6SHkQzo2eXgSQxh
         4cnqYoPHZwL9hxBbUJ+g3pP5zOnqSgnYhyRB6WhEpCa+0aaXLQvL28yoBJesYZG3LryU
         tdlA==
X-Gm-Message-State: AO0yUKV3KJB+cedI8NqRg5zwuTK3521qj+Ht1p4wcmINOgAxbZj60p3Z
        MzSydpC8rnsVG7eR41D7J7fcUevAtPuxZhvNjHqDaw==
X-Google-Smtp-Source: AK7set8faFGJ+bOZYGnxseavaFiHmTnrgryhuZbd0Hj/FWE/b7datWYPM+PvMM7obIRbTIYTrtYMG7ouTbxFDjo/zDE=
X-Received: by 2002:a1f:c507:0:b0:401:2297:b2e0 with SMTP id
 v7-20020a1fc507000000b004012297b2e0mr14336398vkf.0.1678418541550; Thu, 09 Mar
 2023 19:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20230307154524.118541-1-bchihi@baylibre.com>
In-Reply-To: <20230307154524.118541-1-bchihi@baylibre.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 10 Mar 2023 11:22:10 +0800
Message-ID: <CAGXv+5F6yFk+VMUe50YfV11Bx3qnQ=FHymeAM=dgfrqwLGrG7Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add LVTS's AP thermal domain support for mt8195
To:     bchihi@baylibre.com
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 7, 2023 at 11:45=E2=80=AFPM <bchihi@baylibre.com> wrote:
>
> From: Balsam CHIHI <bchihi@baylibre.com>
>
> Add AP thermal domain support to LVTS Driver for MediaTek MT8195 SoC.
>
> This series is a continuation of the original series "Add LVTS Thermal Ar=
chitecture" v14 :
>     https://patchwork.kernel.org/project/linux-pm/cover/20230209105628.50=
294-1-bchihi@baylibre.com/
>
> Based on top of thermal/linux-next :
>     base-commit: 6828e402d06f7c574430b61c05db784cd847b19f
>
> Depends on these patches as they are not yet applyied to thermal/linux-ne=
xt branch :
>     [v14,3/6] arm64: dts: mt8195: Add efuse node to mt8195 (already inclu=
ded in linux master branch)
>     https://patchwork.kernel.org/project/linux-pm/patch/20230209105628.50=
294-4-bchihi@baylibre.com/
>     [v14,5/6] arm64: dts: mediatek: mt8195: Add thermal zones and thermal=
 nodes
>     https://patchwork.kernel.org/project/linux-pm/patch/20230209105628.50=
294-6-bchihi@baylibre.com/
>     [v14,6/6] arm64: dts: mediatek: mt8195: Add temperature mitigation th=
reshold
>     https://patchwork.kernel.org/project/linux-pm/patch/20230209105628.50=
294-7-bchihi@baylibre.com/
>
> Balsam CHIHI (4):
>   dt-bindings: thermal: mediatek: Add AP domain to LVTS thermal
>     controllers for mt8195
>   thermal/drivers/mediatek/lvts_thermal: Add AP domain for mt8195
>   arm64: dts: mediatek: mt8195: Add AP domain thermal zones
>   arm64: dts: mediatek: mt8195: Add AP domain temperature thresholds

Whole series is

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on MT8195 Tomato Chromebook.

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FC04F5BAD
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 12:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiDFJjP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Apr 2022 05:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1585099AbiDFJgP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2022 05:36:15 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1763399CE
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 19:05:50 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id e4so1049224oif.2
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 19:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/B6OEeKNYPJ4Ptjy67RysQjps4ixI/LDrWNN950F0R4=;
        b=LOFD1TB5DHCmdfFhLMSs0KFUQCTqjO1cUH6JeNgY3rqhZKF4HwlfE5cVVqI7+9FwI3
         1nWfuNTNewIPCUr2fopefsiatrMpzcGWOywnhsuJ1QCvvzT/rigzes5gu0xjmGk6RTbj
         91zvAhi3vAWNLCyc3+P49DKDOOP9IICYV9kwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/B6OEeKNYPJ4Ptjy67RysQjps4ixI/LDrWNN950F0R4=;
        b=kFQ3bNQ89FZ1IiDETXjArjPmo+wzeGcX7zvQXBMokuUJnWsOr4EwjXwz0GByGU/aMf
         ZIQu0f8p/NvdAKXub9QwGfkOs7Ggs6fODgzpVai0KBeX3cUCJdH5uPI6WK+a6Jihi+sD
         x2DDuWO4TlMpKhwcFa1e6mgoeR3aYK44bQjgEEt52YjP0eWHivKAOBAdvgTTFkENE5Zy
         pjkU17mevwF8t2fUy7lBjgW0CNaMViTQCk3pHHkN9t9NZwKnYRzTg+yMq/P18zi5/BK8
         HO7Zpvc6qn9vPNgdU+erjKJKcCEGllxsN8ZCiGnocMh6JV6eUOiudHcQfwUtZOv/jvp3
         ot4Q==
X-Gm-Message-State: AOAM530iBzfdW4JCzEBumAbGS74PvU5vJWdkaXHVSji//spO8lO4hTze
        vGC8wnWRTDHFEnD2j11CtHpbV6aQBFZKAQ==
X-Google-Smtp-Source: ABdhPJwIrL4SbxRtLmHD9MxvHfdYcyoD0zMd4avpuAKBu7B/a82MHaM5OF3m48H0CLMyaS8M00PhPg==
X-Received: by 2002:a05:6808:11ca:b0:2d4:6861:2a9e with SMTP id p10-20020a05680811ca00b002d468612a9emr2739050oiv.114.1649210748698;
        Tue, 05 Apr 2022 19:05:48 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com. [209.85.160.45])
        by smtp.gmail.com with ESMTPSA id n35-20020a05687055a300b000e1e2ab91e4sm4160245oao.39.2022.04.05.19.05.45
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 19:05:45 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-de48295467so1462704fac.2
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 19:05:45 -0700 (PDT)
X-Received: by 2002:a05:6870:c142:b0:dd:d5a3:767c with SMTP id
 g2-20020a056870c14200b000ddd5a3767cmr2910063oad.291.1649210744492; Tue, 05
 Apr 2022 19:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220127230727.3369358-1-briannorris@chromium.org>
 <20220127150615.v2.12.I3a5c7f21ecd8221b42c2dbcd618386bce7b3e9a6@changeid> <CAMdYzYo9Y_pEAAtreQU0B9DVzGsbUgpTA2g7HGRyUXcSBjMy4g@mail.gmail.com>
In-Reply-To: <CAMdYzYo9Y_pEAAtreQU0B9DVzGsbUgpTA2g7HGRyUXcSBjMy4g@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 5 Apr 2022 19:05:33 -0700
X-Gmail-Original-Message-ID: <CA+ASDXP46bVqZAyzgUQkZAqqVf6Yc5Zg9CZ_1k0XCYUSYq_QLg@mail.gmail.com>
Message-ID: <CA+ASDXP46bVqZAyzgUQkZAqqVf6Yc5Zg9CZ_1k0XCYUSYq_QLg@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] arm64: dts: rockchip: Enable dmc and dfi nodes
 on gru
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Lin Huang <hl@rock-chips.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello again Peter,

On Fri, Mar 4, 2022 at 6:47 AM Peter Geis <pgwipeout@gmail.com> wrote:
> Transitions anywhere from the default 800mhz cause a lock.
>
> I'm digging deeper, but I'm hoping you can answer some questions in
> the meantime:
> 1. Does this require something from firmware that isn't available on
> Mainline ATF? (AKA special firmware to the Chromebook line)
> 2. If not, do you have any recommendations off the top of your head?

I may have a better answer for you now. In the intervening time
period, I've discovered a potentially-relevant bug, involving
interactions between the kernel power-domain driver and ATF. See this
series for my current fixes:

https://lore.kernel.org/linux-rockchip/20220406014842.2771799-1-briannorris@chromium.org/
[RFC PATCH 0/2] rockchip / devfreq: Coordinate DRAM controller
resources between ATF and kernel

If that happens to help you (it may help, for instance, if your system
was toggling NPLL off/on like mine was; it also may help if you're
hitting a race on PMU_BUS_IDLE_REQ like noticed in patch 1), I'd love
your feedback there.

It's still possible your problems are completely unrelated though.

Regards,
Brian

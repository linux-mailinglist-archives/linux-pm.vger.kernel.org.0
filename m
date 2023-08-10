Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD887772B9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Aug 2023 10:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjHJISr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 04:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjHJISq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 04:18:46 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A060FE
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 01:18:45 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58451f0fefeso8388647b3.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 01:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691655524; x=1692260324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1S3yE96sxZWitB4oiJ30vpkB3MWLEMpL6UDMSJWZXU=;
        b=sKRwat/bRypjQs0GDj+E5aX6U0l+rdH2Ppp7jgbUiwQQsqjEaK0abvIScLRA0wD+XB
         V+k33vveoWCeS1c6XgCqjjXWr//cl1HyFtdD8ttwfDC6tU5h0yWEtUhgAWWlSrBAqi9t
         tXTEm4YMv0WM1uBDtQtenVY2VwUD4UxTzpZEwHsGCFe7Z/2lAj6TisZ1wfKRqkKtHkMv
         q4kQ3tqQ3kjjJBlQFVfvfmjVGvTI9ZG6qPa9xIgWc3cwJulHzC1kKt6V4uv2UEb2aMy8
         OAS7Hff9YtpzqDV058P27LVyQvRktH36oLc1Ux2VOWBYO61uLfbyzTdGhTV/qpGrAtF8
         glUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655524; x=1692260324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1S3yE96sxZWitB4oiJ30vpkB3MWLEMpL6UDMSJWZXU=;
        b=caInKEuqCAXx9Svaewyo8dcL3/Au8cBROymUf/18vKhfLILZkAB3wfC4aF+yZKkQTF
         EUcloaaEqkAyK2TONvZ2DCpXHqvcyKcJnI1g5YDx2YgMCkSogb5CFOUZmRRA/xm7GIxa
         5CY+LdXGTpWwOwvEhmV5VoS3fRRnqGeqYhiZ1wrtc1r29rRP+NdAGV1TA0j47CN9FIH+
         ES0KUF0/oXK+ohSRIAFDj5Qxxx4spFoKAWTofTjaTAe7ccVXjILfTeB6v3hkiZ88M3OQ
         Y0Oxk3V0p3Z6WNjMiu/ahy8LzQ7N3CTxjhCtIbxdOQoxvrmt9j5YCX4VL+iTlavFsVMj
         pP1w==
X-Gm-Message-State: AOJu0Yzt1PR0b4WeC1bbtb5Un3mNOogqAbJ/r31QfXPQUpMQCs/ghz3l
        FbojEHAQ/rGudZvlpAoIRDxZ2WvWYmEuO6Rrref3XA==
X-Google-Smtp-Source: AGHT+IE+UnSxHykLJJfIQch1e5QQ0u1bPECfUCUFUDCntbpI1NXH0v2rJAWr/evYDXltegUQu7z4Swu4ag0Zr1/V/sw=
X-Received: by 2002:a25:3611:0:b0:d4c:aa71:8294 with SMTP id
 d17-20020a253611000000b00d4caa718294mr1849966yba.33.1691655524705; Thu, 10
 Aug 2023 01:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org> <20230803-dt-header-cleanups-for-soc-v2-8-d8de2cc88bff@kernel.org>
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-8-d8de2cc88bff@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 10:18:33 +0200
Message-ID: <CACRpkdaX=nABoxGMAK+3uEHOt1imucK6LXXRrNuAYFiH3-jt7g@mail.gmail.com>
Subject: Re: [PATCH v2 08/23] ARM: nomadik: Drop unused includes
To:     Rob Herring <robh@kernel.org>
Cc:     soc@kernel.org, Patrice Chotard <patrice.chotard@foss.st.com>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Has him <shiraz.linux.kernel@gmail.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jay Fang <f.fangjian@huawei.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@amd.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 4, 2023 at 12:44=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:

> Several includes are not needed, so drop them.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for cleaning out this.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Will you funnel this to ARM SoC with the rest?

Yours,
Linus Walleij

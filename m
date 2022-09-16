Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054EB5BA7FB
	for <lists+linux-pm@lfdr.de>; Fri, 16 Sep 2022 10:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiIPIQ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Sep 2022 04:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiIPIPq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Sep 2022 04:15:46 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5150E39BAA
        for <linux-pm@vger.kernel.org>; Fri, 16 Sep 2022 01:15:43 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id t184so31450776yba.4
        for <linux-pm@vger.kernel.org>; Fri, 16 Sep 2022 01:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2PnNFNUqQBrbAJ+KLmE5zE/OnqNdj3sYS9lVb/E9pKE=;
        b=pVIFVU242w9iq7DXYThjL37Si11OW6ebqwACau4FFnXH9jsTHyXtD8zowpGxU6I/0v
         CaUibP8uciXBPp1XNVfdZHglARuJhWBYwgHmXt+Zr20mV84GYplmVQGgVXgtIu3nuCGP
         vSsln3vtuynZvlsfTm9UFMf25wwCkVad5YLnFeL+qMISTWetVArsmrnivbfUvX4L21pd
         3otUXHDnxt6qZXZyP+59BDEZwYjkItz9gGz4EEPs1jnTmtEYGw+rv3wI3aq6hY5hoNQb
         NTIiBRfgJtdkdNHeaY8R2ac+TxUceQf27JceMDOugrLFocDMulsDvjjicEtd+NARCvX9
         mcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2PnNFNUqQBrbAJ+KLmE5zE/OnqNdj3sYS9lVb/E9pKE=;
        b=0WNUmmww5lc0FgdrALxRcppx8v0mfarRI+tF14qXRklN9oDrCzSeFZwR4eIu5/a6Mp
         JpXUWQ3ZYoFDUBP9EWAOv9ef+7XQybm4OthwzGDyd5i4N7oZVV7KIRSTCrN4VWMqp3PK
         1R72r+P5EIAzousU5+PH4INuqt/C7VHKSmFOU4Uv24QsLG7CTSat8kgyn8ORP3L0qPp5
         I7y5xzDoHDD5P3bYJBywdIurzzShrUmm7dw6Q5n0C12phVcHGqFlVJFYc9UVKkgowOav
         lQ3H5QYBlNqcFQqDUlm1h7jLqTDLFVAgmzodaz0S5a4bwllWNRz4alZUReN/zALO3h0S
         WLEA==
X-Gm-Message-State: ACrzQf2Xp6ST3dBBnhddKKDHm52io3gU0fsHO3MXOVukJdYtx8Hj1Mpf
        CfgU27JuuJTeRIGNf1amUiYxPnE/5b+HHpcIea+LXw==
X-Google-Smtp-Source: AMsMyM4uK5qX0hNriC08kjBGoyryzCAKwvl0ezSa6qMX7DCS06l9JI2YRDdGZ5bpYNAvRVJdroYT4ispXrrbmlqKGf8=
X-Received: by 2002:a25:708b:0:b0:6b0:8a11:b32 with SMTP id
 l133-20020a25708b000000b006b08a110b32mr1874467ybc.520.1663316142506; Fri, 16
 Sep 2022 01:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220817080757.352021-1-bchihi@baylibre.com> <20220817080757.352021-5-bchihi@baylibre.com>
 <8d6383e0-329e-ca91-6e79-85b3806a2af3@collabora.com> <CAGuA+ooEHPiHuGYXOh7s68HRTv9HSr-BexFsCLUPWTMQ3szCfg@mail.gmail.com>
 <ccd27ec5-6bce-0f5c-1b58-b7bfcbccdeed@collabora.com>
In-Reply-To: <ccd27ec5-6bce-0f5c-1b58-b7bfcbccdeed@collabora.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Fri, 16 Sep 2022 10:15:06 +0200
Message-ID: <CAGuA+oroekhVRyxa-z1VTZrzOBW2zCoGaFmH=KLYu_JfwxP3NA@mail.gmail.com>
Subject: Re: [PATCH v9,4/7] thermal: mediatek: Add LVTS driver for mt8192
 thermal zones
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> It's the wrong error number. You have to return -EAGAIN :-)

Got it, thanks! :D

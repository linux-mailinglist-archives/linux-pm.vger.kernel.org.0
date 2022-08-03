Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE055888CC
	for <lists+linux-pm@lfdr.de>; Wed,  3 Aug 2022 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiHCImO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Aug 2022 04:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiHCImM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Aug 2022 04:42:12 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A2D1D33E
        for <linux-pm@vger.kernel.org>; Wed,  3 Aug 2022 01:42:11 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id o15so27198778yba.10
        for <linux-pm@vger.kernel.org>; Wed, 03 Aug 2022 01:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHeeDipADyRKO/ve/1YLa9FmmcLAxnnHkJPKVvR+xHQ=;
        b=Kr1MIzRJHbp82BH18W4AiIBLq8Mi86rLgVOsKfFvL3BonO0chgUjPmci+J1zFj0Py2
         Vo1igVL73/Wa5/hp4+/qxzpjIMlx2XY2Ds/XhZHMe9ePEt35zR/BnUR4i2Nz2Z+8rMhC
         cRGa6vtBP8dSW8uSVD71BSwpgx6x7c0Z3mHyamN7dUZRzv+D5UAYGdt+73U2kTLvHEo1
         cSZjxuVkheDOHbHpKHMzHl02RUM+2G2y3xLBmsepXPPNqOF5j/v68e/XovRKlgS5wqab
         o8LoKWLP7R7ZYP3RE7Zap+r/9UUaC4/G5bDg9nff1q5y2xVYvCpmSbhNKruKOvrmplRC
         3Jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHeeDipADyRKO/ve/1YLa9FmmcLAxnnHkJPKVvR+xHQ=;
        b=BO7ciZyz7yP5ihurtnWxCFAm738nhCtzuD5Mv3mByZS7LA5xd1tyRrcnJy4GChjjC4
         sqRrGMMwIJBhE3cNGDO/iyGCxDWJRvc/6Rt60NfRGxNqmnqbBD9idNMiCKR1AhaSdsUY
         6IK7lH/avm1Z5oJHnSDVxGPAnS+b4nadBQDSPpuBLT3tUCyguCY/E6weUTPvDU6Pz5n+
         5teOdPvFbtZb5G8Ee94u++FlcGVOIdD+NgTlHe4ieNjfD/D/c+qSxkoKhRLSxZm4nRet
         Szzg5TNb+9GNUQyXvRg7op4Hjt+VEpBdK1tE12BoHbcZN2Qn+/VGM3CNO2jAbVRF8ZD6
         T5cg==
X-Gm-Message-State: ACgBeo1zjQ09uwVlspu99JK16QsvXvjnIZEMXe80eavSByi4UiZG8C9Z
        v2TAP7z317Z4AsqsS3JShXnGbTSDpy50TB7KuQKwtg==
X-Google-Smtp-Source: AA6agR6uuNuubZT7+RUDSt6unHI8cDiPiRdpN0Kt/LW3gXhEFlVJAevNuRyQP/VPFI/DHrq4f8ZEK0XNUzffYOzTlZA=
X-Received: by 2002:a25:4941:0:b0:670:24c7:dc96 with SMTP id
 w62-20020a254941000000b0067024c7dc96mr18031735yba.22.1659516130367; Wed, 03
 Aug 2022 01:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220726135506.485108-1-bchihi@baylibre.com> <20220726135506.485108-2-bchihi@baylibre.com>
 <24250d03-b25f-e521-5abd-f36109885c36@linaro.org> <CAGuA+opxZ7DDrWHcnTRhMcm7YveCAypdy9MDSytt58asgekayw@mail.gmail.com>
 <CAGuA+ooOUXaBM+uPvEEohFLtO8sRd4T=DMcc6Fvo9P92gsq4yg@mail.gmail.com> <9b224465-e9e5-43d3-50eb-3614decbd8b2@linaro.org>
In-Reply-To: <9b224465-e9e5-43d3-50eb-3614decbd8b2@linaro.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 3 Aug 2022 10:41:34 +0200
Message-ID: <CAGuA+op-mO5ZMz_EvSOYUNiZ_4OOwLFQqFqMrCQBVMcG3mbcPQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] thermal: mediatek: Relocate driver to mediatek folder
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
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

On Fri, Jul 29, 2022 at 5:35 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Balsam,
>
> On 29/07/2022 17:21, Balsam CHIHI wrote:
>
> [ ... ]
>
> You may want to wait next week before sending a new version, I'm still
> reviewing your series (note you can send it anyway if you prefer)
>

Hi Daniel,

Thank you for the review.
I have finished implementing the changes requested by the maintainers
and would like to resubmit the series.
Do I still have to wait for your feedback to send it again?

Best regards,
Balsam

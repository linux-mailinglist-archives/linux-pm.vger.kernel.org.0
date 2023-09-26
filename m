Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC257AE45A
	for <lists+linux-pm@lfdr.de>; Tue, 26 Sep 2023 06:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjIZEBB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Sep 2023 00:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjIZEBB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 00:01:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEA5E6
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 21:00:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so13057284e87.2
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 21:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695700852; x=1696305652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYClnlSGRE/VVPHFCk//gM0X3MtjPFgRACsIZo27ba8=;
        b=U1sgDXtUz13BzFct2TvayisYMgaYWBJbvfMFAtX7Y7s9vid9/TdGy/B7dznKR0Hiqj
         WUQACYEPWXK8RlWXap2I9khybQUwSO14jFW6jr/pySY1KUvOIMkvuLPvAeS7kL7krx1p
         kqvNPQMMaSllhx2KmEutSS1GZsEMqRJWVECqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695700852; x=1696305652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYClnlSGRE/VVPHFCk//gM0X3MtjPFgRACsIZo27ba8=;
        b=GTCOfGaWj7L0oJ8Sfi2EVHeng0CZB7AsnX9JT35nHQTuyzBlJ2Pgy4p2Aw5MgV874a
         QgOBr6XyNrBZVT8LGi62BBeDHZ4wy4921N7oU8ij31WcmjWLjiOwa2GpnXBeJ8stNsTc
         7KajHVQfM7BnaL9p1WnHoYvPWyHZrmreE/yLO41ihagHEVMdeFlF/ssXRDB+fGoUOlKk
         mTu8v/vY2ipFISbezmH+4D2tEMWGAqQd5JVqEUONZdsTbB3Dv6ouA8VjXIzp/4PH7JXA
         6n/KVC2M6nHI69AYZXqsoZCud/sOiLE+D8jcXM4bT+0qABMbcdT4XTUvQ9wt0o5BJjmF
         i/sA==
X-Gm-Message-State: AOJu0YznWePteNs0EowqdqTRdaeiIosas/8YbzNkEIFdh5G27i8tTf+p
        JL8qQCHAt/98rr4gF8qycjL5iks2ZalnqHw6/lGIwA==
X-Google-Smtp-Source: AGHT+IEtkTctsf5HbOONUd8gTf3/GdExf1zf0JDg4leCj0a9OJM+OM1FoXuuppkPECKOTlmyKr+PorFc6IG0rss5xr4=
X-Received: by 2002:a05:6512:3995:b0:502:ff3b:7670 with SMTP id
 j21-20020a056512399500b00502ff3b7670mr8220870lfu.4.1695700851585; Mon, 25 Sep
 2023 21:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230921091057.3812-1-duminjie@vivo.com>
In-Reply-To: <20230921091057.3812-1-duminjie@vivo.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 26 Sep 2023 12:00:40 +0800
Message-ID: <CAGXv+5HFsLxVqoUsa4BAC8waq=hXoh=4sdXxSmFP1vB1FhnsZQ@mail.gmail.com>
Subject: Re: [PATCH v1] thermal/drivers/mediatek/lvts_thermal: fix error check
 in lvts_debugfs_init()
To:     Minjie Du <duminjie@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Balsam CHIHI <bchihi@baylibre.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 21, 2023 at 5:11=E2=80=AFPM Minjie Du <duminjie@vivo.com> wrote=
:
>
> debugfs_create_dir() function returns an error value embedded in
> the pointer (PTR_ERR). Evaluate the return value using IS_ERR
> rather than checking for NULL.
>
> Signed-off-by: Minjie Du <duminjie@vivo.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

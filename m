Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A7A5425F4
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jun 2022 08:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbiFHByw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jun 2022 21:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241092AbiFHBs3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jun 2022 21:48:29 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AF550068
        for <linux-pm@vger.kernel.org>; Tue,  7 Jun 2022 15:40:55 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-30c2f288f13so191187647b3.7
        for <linux-pm@vger.kernel.org>; Tue, 07 Jun 2022 15:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dt0XHXk+0B7tLl6JDtHvrhkBpAVFfyqHxdqYbIVVccM=;
        b=HEzx9zzSeDeENSDkpnW7IAZKtl/TC+cTxu0m4P/Jvl19ecy4ff2/pQyuIQe7vIWueD
         iYnypeVvOCwvlTQ9Opq0zm+6guF1W2vOmt55t5HwIWnbay4AhlJHDMwugiGKYrqiordE
         llHyUsRLO0HgXZyAbZFuVuTVhcHNKi9HJ+KzCtu0V+oEUPZSz5hRYFK1gG2siABMYVyj
         I1BCHKTCptThVpIL1oMpyGzul9fAYNgEOikByMimTYs1b9XQCKD1LlwSPSpLRK8ObWwB
         nDKiGaH3ExwxLtYUzLcPJpeMItzRC4WTnJmqiCyAE7qYRzAfZ5PRpDibASAthTiH0of8
         sUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dt0XHXk+0B7tLl6JDtHvrhkBpAVFfyqHxdqYbIVVccM=;
        b=BCjynbBUOcwuIYnkmlX4lRTyCosNPafi4lmbMcaPwBSp2ujBQ60PrX/++7Un0CpzsL
         FT43tGuEhz0dik/6KWYOoZ37BpSHZApF4IsIqdfMBhnSXtDUleUCbM7DLuAk40CyiONy
         DS1HXlxJOx1lxdFgacYlTKryekGxgYpuwFrO0u45HdV726vvP8k8zrUTYkMWBOfHRmBg
         glr2G0dRLtErM8GyoJky+G7c3Rd6RYKrihCmp4NmgAHPQz2PPYI61loFJ1jH3rzjjZEF
         l/yQfnFBG3Dh4EGAqD4OqJp3chB3jrbLWRR0Bgk70lllVUTpbaRLWERWj0RD+OTFfnmX
         Pg0Q==
X-Gm-Message-State: AOAM531hEI/KqFyCECMjPu6JusK6T035cBukWVSvQbCOo/2mE5/TTd9v
        l10ejUDIC2v697zR+wXDaRw5evH19UIWUqpo0nsLTQ==
X-Google-Smtp-Source: ABdhPJyMndLIrVZVKGhPxU4fTtPWfsNGZsSLR1Wd9uZe0QwnXcuVNEvXODxksR3hwOA5mp0zpdmYFpg0hLt5nO9b+es=
X-Received: by 2002:a81:a00b:0:b0:30c:5c1a:19f with SMTP id
 x11-20020a81a00b000000b0030c5c1a019fmr33597323ywg.437.1654641654967; Tue, 07
 Jun 2022 15:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220607033328.1846-1-gaochao49@huawei.com>
In-Reply-To: <20220607033328.1846-1-gaochao49@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Jun 2022 00:40:43 +0200
Message-ID: <CACRpkdawt0YgWdz2fSXkS-Qz_yF6JRm=ee=wLk6gnLwVKezf_g@mail.gmail.com>
Subject: Re: [PATCH -next] power: supply: ab8500_fg: add missing
 destroy_workqueue in ab8500_fg_probe
To:     gaochao <gaochao49@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhengbin13@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 7, 2022 at 5:34 AM gaochao <gaochao49@huawei.com> wrote:

> From: Gao Chao <gaochao49@huawei.com>
>
> In ab8500_fg_probe,  misses destroy_workqueue in error path,
> this patch fixes that.
>
> Fixes: 010ddb813f35 ("power: supply: ab8500_fg: Allocate wq in probe")
> Signed-off-by: Gao Chao <gaochao49@huawei.com>

Oh good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

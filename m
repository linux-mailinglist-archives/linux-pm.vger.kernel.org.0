Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3261563483B
	for <lists+linux-pm@lfdr.de>; Tue, 22 Nov 2022 21:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiKVUdr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Nov 2022 15:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiKVUdr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2022 15:33:47 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6134C265
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2022 12:33:46 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-39e61d2087dso80362247b3.5
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2022 12:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SnF/2AOItpjtHhZAOeHmLLPG/kwypU0W2IxPDEf1sKs=;
        b=S5UN7rv14cIrLw2a9/Ykqsp3+pAiqxDUSdorP3K8QsG9qNCvT3mcqBlozmP1BqhRYU
         babN3GaESqHuHkqQvOag/DcOD+4pu5g3b3HJL9QFbc22syw8ovQlOk32vocTy0Ioql47
         AXiouDsx/bTpHypn+XyrlXoHjMeZhALRWn+t/zsVHX/aE6QCjMgLN/nWdSzBxpCC1r4t
         Ogv43HG+WJ+dHjDdEk1ZgYV3IEt5R+SHlQNtQIdRqT+HX5iSPezP3YMLrxixCLQnwgr3
         oU90UA++fZkSRW632gaeNi0ZC3qc/j0ml9LX07RrZpp5eSJ1VmyLYyz7/9+R11v4lFJw
         sH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SnF/2AOItpjtHhZAOeHmLLPG/kwypU0W2IxPDEf1sKs=;
        b=4LmmYU5/YIomNIkwezzWtzpNS/i3q9QFbtatZ369vH/O7EhTNehJfBF71O4m9sNDBZ
         giOhsmy/YqnaLk146yQjcHcBRFZ7rP1e4OH4XAjwGDd56uEUFRXHoSNCnOYZ7OAA036A
         dQSxaZO+gqCG6yFeDr8qkEUv9GdvIoXxTKPOJRHRRvlrfcZQJoibKW0lMlzras0Wj9yc
         Dz9KBZkm7WA4k9OcIhUcncJBe+nIgwKfRpHiO16Ra/peNaDpHB614D/PRCV3n3J5t2Rh
         YAOTvFfItGwWBqZgYxkyMXhcCKTcXOatJVobBBmpC11SWFKz1UbUAlcJtlNmzPBeC69a
         wyPw==
X-Gm-Message-State: ANoB5pmpRUaKImZgmFql04ED3M1s5i83HHB/WaE06dTR0sfyfaoMDyHr
        HhSPcxnPoIQVJZyA/EoxuHwoYnIaszGSnuyQP795mf02PvQ=
X-Google-Smtp-Source: AA0mqf7KQRnLFWYVu8qmj59uoe8GjqCLrOQx9VNRG9UQS5qsXnl4ZNbR4LfEY3ZOHkNXPkoc5TlJA2Ia4JjONZQ1CMQ=
X-Received: by 2002:a81:8496:0:b0:36f:d14a:6158 with SMTP id
 u144-20020a818496000000b0036fd14a6158mr22642352ywf.325.1669149225475; Tue, 22
 Nov 2022 12:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20221121011834.119060-1-zhangqilong3@huawei.com>
In-Reply-To: <20221121011834.119060-1-zhangqilong3@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Nov 2022 21:33:34 +0100
Message-ID: <CACRpkdYwaoGOMNTdPnUbD-2y5PHY7Wp+fSuQvTsZLm2kaNuKeA@mail.gmail.com>
Subject: Re: [PATCH] power: supply: z2_battery: Fix possible memleak in z2_batt_probe()
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     sre@kernel.org, daniel@zonque.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 21, 2022 at 2:14 AM Zhang Qilong <zhangqilong3@huawei.com> wrote:

> If devm_gpiod_get_optional() returns error, the charger should be
> freed before z2_batt_probe returns according to the context. We
> fix it by just gotoing to 'err' branch.
>
> Fixes: a3b4388ea19b ("power: supply: z2_battery: Convert to GPIO descriptors")
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>

Oops good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

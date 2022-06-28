Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC11155E3BD
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 15:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345919AbiF1Muu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jun 2022 08:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiF1Muu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2022 08:50:50 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ED324F1A
        for <linux-pm@vger.kernel.org>; Tue, 28 Jun 2022 05:50:49 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p7so20605881ybm.7
        for <linux-pm@vger.kernel.org>; Tue, 28 Jun 2022 05:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKtbEKOV9+zxoYN7EqIqx2vBNUtMCZigc7ffTBcwK8Q=;
        b=uZQymZCXoreVQDP9VaH5Xu6aY+TbA8g2WWt5B/nYT7gbNB4zf/Ez+BG3D1cvwU6Cye
         FhffW+Jun2H4wr4FzmyE5wEbsgc8X2+qfdJi25On/ceZOfSAmsFkh7x8EPc743UfJzmg
         37e0RA531885F62iRwQfmeIdod/WdziDha9TWbGSJv+2Vdojy/oUBFgwm4gj5QJ6mKmW
         HuJnBZN5byJWVxA483jTITjGJSfIRDtd+d83EgmmCsnpw68cNNtmA0Gol3O3wfvzAmxr
         sAendn0UvAkmy/w7TiPTP6XcRlZ+fbhBvDV9EbrxaTHvCOk5bC19Xo0SkFt+uqJ7pp8w
         cNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKtbEKOV9+zxoYN7EqIqx2vBNUtMCZigc7ffTBcwK8Q=;
        b=1Ggy5Sl2t1gixMjC0ut5bBOGcOYTS/IxxdF+YlfD8NEcXwILCaB+a5NYXYuz75an1J
         o4T/0IhtzUSYFzC5gB2nhu0dg6746BHr907ZYxgivfztx5I9k59NXce0ZsjCYFn2RFue
         feoNfdgTPlAkHaB4JmNAfwHAjUGJ6FEZflfWzIc5MBAmuh4hBP06IlC+Qv3YEVwTI3ZZ
         ejLoTObvSNewNNu3mSFofkxtnleZXJFlS0KJPmjlIXro4ADFiOY0TTl2fT1cj2aBkUjz
         q0IUDhHPonSYMJCqHjGzQBgbOz8GCd6sxAGZuu279SqMUHou03GN+OOsoMfeJtQz+dye
         KScA==
X-Gm-Message-State: AJIora8kEAhsP5ZmqdYOv9mLwYxD0l8dyrg/R/i0THvOT5YkrPY5MohS
        9+rugcCArnI8b0Fr6rBOju5gkSOGA1ir+TOkpaLFsw==
X-Google-Smtp-Source: AGRyM1te30st7VzTtroBHMaObPldx28Rm8JDULA6wS1L34yCcbwSW3ugPqxB3BN7D2zbOq+l5/oaQJD70zuDZLMm0RQ=
X-Received: by 2002:a05:6902:152:b0:66c:e116:6a7 with SMTP id
 p18-20020a056902015200b0066ce11606a7mr9403248ybh.533.1656420648733; Tue, 28
 Jun 2022 05:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
 <20220616202537.303655-3-daniel.lezcano@linaro.org> <f4b13249-abe8-080f-4d36-24ef67d4fb62@linaro.org>
In-Reply-To: <f4b13249-abe8-080f-4d36-24ef67d4fb62@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 14:50:36 +0200
Message-ID: <CACRpkdZBUVGP6whu-ojW9KKapeuYKQbXWn1MEpJ33KFav+8zqQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal/drivers/u8500: Remove the get_trend function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
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

On Tue, Jun 28, 2022 at 10:40 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> Adding Linus who is missing in the recipient list.
>
>
> On 16/06/2022 22:25, Daniel Lezcano wrote:
> > The get_trend function relies on the interrupt to set the raising or
> > dropping trend. However the interpolated temperature is already giving
> > the temperature information to the thermal framework which is able to
> > deduce the trend.
> >
> > Remove the trend code.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I certainly trust you with this :)
Acked-by: Linus Walleij <linus.walleij@linaro.org>

The code was originally written by Hongbo Zhang, but co-developed
and tested by Vincent Guittot I think, so paging
him as well.

Yours,
Linus Walleij

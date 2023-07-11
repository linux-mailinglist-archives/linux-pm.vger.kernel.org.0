Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DD374F0E2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 15:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjGKN6h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 09:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjGKN6g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 09:58:36 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA32170E
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 06:58:26 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-579dfae6855so69303267b3.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689083905; x=1691675905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mXc1YvJ03feFTjI9+4mTWYW8IRclnp0/xO74GvDKVns=;
        b=K4c1tZM9TOdaWLuYdl1ZHVn2jnn1MjZ0vnj7nkpJNOwVLfoC2x2rmN2BYaftSrMrE1
         1E5w7fzSkz2pX8Gi9wmGKIV2Klme0FKUzZfoIfPCjxSV2GRThGTWyDbBCTO6ievXYQkw
         LDpypspGRwyfo9laTDHBSBFmBNIue9gQn2xQc74OAXLi908e7OonNaxzibYVTTcOJpFY
         kySW11ZO8jT2EPfRrEQXzZYHscaFZCapQ7Q1njZpRFDw8v8qu1Pya5Y0Yvy3gMK41Swy
         8lNk0LH9IPn01vnZMQh5fSJpejpdoUIrom6nJIMXORQH06wo9GZR7N6Lk8xyp/SUN9ZE
         EZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689083905; x=1691675905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXc1YvJ03feFTjI9+4mTWYW8IRclnp0/xO74GvDKVns=;
        b=CqcUedfw1ZayxoVOf3o7iygZxCq9wS4xQxb32FmQERFmLBRdQCYiDDW63CcZSKfW4+
         /aSegHU3RDq7cAEjfgx1Oroe4F9cDL83fEt7ktIORPy33OHwmBV+RnEesH33KUnR1jRa
         QIZ/UxlIjmiZgEu9+aY9gjfkHmt18ZBYM5taM5lKKZwB2LTpl4pV/Lhr8mbh4TSeGmMB
         NQ0yCAuh2UDbGXB8S1AMowf/fpBUWYPNBpQOFuL4hHpT1P7Lxacxgb+/hlp7+WGbSobT
         T3pA8Rh+ujlgrjPwr/R0jIodZhNP/vYFhRtPdz7ewRipWpiC7YTc0R2/Pkr8pEck0n6t
         JVQQ==
X-Gm-Message-State: ABy/qLbP4HZTcYwx4ppCRW8u3d+lxSOwfu1mbMLD3R9FOPZfpE6ocu6j
        5n5b5KWkvWPybtjq8rskYklHhYZ/bPs1UYQtJyPYtZ19xU9MaQV0S+A=
X-Google-Smtp-Source: APBJJlGapeJdG9aorNQQzLnqUpCr1cy2ErIeA/n6FGOs7k2UeI9ogUT++UHV2i3WWXM6h8kyWVGdpT0WQz5o+TVN8tY=
X-Received: by 2002:a0d:dd91:0:b0:56c:ffd1:6553 with SMTP id
 g139-20020a0ddd91000000b0056cffd16553mr14076437ywe.8.1689083904919; Tue, 11
 Jul 2023 06:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-13-ulf.hansson@linaro.org> <20230707-vexingly-prologue-fea19dd3d962@spud>
In-Reply-To: <20230707-vexingly-prologue-fea19dd3d962@spud>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Jul 2023 15:57:49 +0200
Message-ID: <CAPDyKFoy2HZLSqSpQ8jPgDLU10p1H0_WQkHXsL1LfXEcpJDcCA@mail.gmail.com>
Subject: Re: [PATCH 12/18] soc: starfive: Move the power-domain driver to the
 genpd dir
To:     Conor Dooley <conor@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Walker Chen <walker.chen@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 7 Jul 2023 at 17:51, Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Jul 07, 2023 at 04:04:28PM +0200, Ulf Hansson wrote:
> > Cc: Walker Chen <walker.chen@starfivetech.com>
> > Cc: Conor Dooley <conor@kernel.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> If you are not going to write a commit message with an explanation,

I will, sorry for being lazy.

> the least you could do is CC me on the cover letter.

Yes, I will soon post a new version and add you to the cover letter and patch 1.

>
> > ---
> >  MAINTAINERS                                                    | 2 +-
> >  drivers/genpd/Makefile                                         | 1 +
> >  drivers/genpd/starfive/Makefile                                | 2 ++
> >  .../{soc/starfive/jh71xx_pmu.c => genpd/starfive/jh71xx-pmu.c} | 0
> >  drivers/soc/starfive/Makefile                                  | 3 ---
>
> Why not also move the Kconfig entry while you are at it?

I just replied to Geert [1], who had similar questions. Hope that
makes sense to you?

>
> Thanks,
> Conor.

[1]
https://lore.kernel.org/lkml/CAPDyKFrsBV=7CDDiZcAJDRiZsze4fcWq5tCR8zYCRyeTUu5hqA@mail.gmail.com/

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8175B557DB2
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jun 2022 16:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiFWOYW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jun 2022 10:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiFWOYW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2022 10:24:22 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500DA35262
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2022 07:24:21 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2ef5380669cso195560277b3.9
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2022 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJeQhOK1Ff5tvH4oib0FqXJ18QJZjDsQotId8PDGCZc=;
        b=L1ePpkTAA3qCERmKFqo35BT5ANmq34Yl1f90l93GGRcfTCJR4PpjmhLo+6zkhM6JTv
         xRshOrzDQn3di9d1KyUUTYGA+erMuzUY/79hjVcEttKVNZYRBN2uaOSP8uSkB2/YdgJI
         ojnVNmfSXf4zSlSgxX5B54w/jS0bWvRaWgxWtzgmz9sY+eBjKDfOi5ojxp1EErXdY0md
         xK3V2SlYivtmPlmwo9T3y6pyaG/eT5ogKc4ZTIRIthLCegGLPXekcOTbegqz1jlpcJWA
         S/8M+kj6HiBTn1iBfjiqtnUwpvUGA1ocsDddoITWQKfL7DPW2MDqFTgKayeX4oCxfbNp
         rmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJeQhOK1Ff5tvH4oib0FqXJ18QJZjDsQotId8PDGCZc=;
        b=jSzkB5qEjc5Loqze4mR8WU9NTqTRcqO19WYub/nNRAPRgcomAm2r97bA3MC5+Rmw9x
         /bJqe4IHo6ikgYDlZQLl6Nq3BSOoGXI267DuJNbkj6CQNf+7tqGLlMBgj9H9Ip9rnDpx
         IHo5Agb6eGoZTQ5E218j7XcMh6juK97NlR5yXe+UtHkfqHuAbSfuXybr+3qQqqQHBwxr
         gk8foVBSL8baujbC+kqETQ3YDJySuCl9JNBCX6wjl0VMcBJ9UEnCQUM3TFRC6N4nHeOM
         vKdInLgG5qz86aM/hK42vnkJhpmNjd0T+MyOFm3QF5w8abi414nNWslNxfR7TJtlCJ+b
         zNig==
X-Gm-Message-State: AJIora9f7qb83WT6xt5xWjScEal9amtKO9dttHRrKo6rxvKD1xStb5IK
        uSs4pYpQP787FDQWEjiwhWPKR3WVyamjV3O1VNiF749ZBdI=
X-Google-Smtp-Source: AGRyM1u3JII37Q3B4+Q8OpzB06OpakUrrBTlutREtHbBsdnm3f8RWqIzk7M0C3AIE5aSZPAEd8MaEEMcEjt0B/QCagQ=
X-Received: by 2002:a81:6587:0:b0:318:38c2:2fb1 with SMTP id
 z129-20020a816587000000b0031838c22fb1mr10788372ywb.118.1655994260430; Thu, 23
 Jun 2022 07:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <50d84193-a933-1301-b9d9-bf6cc01ee126@I-love.SAKURA.ne.jp> <20220609194329.bkvnxmxovnbqxuxg@mercury.elektranox.org>
In-Reply-To: <20220609194329.bkvnxmxovnbqxuxg@mercury.elektranox.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jun 2022 16:24:09 +0200
Message-ID: <CACRpkdaGAXvSEgR_k3obRv+yjaEDeaKfsYk1R9bvjQ9MY=WHBg@mail.gmail.com>
Subject: Re: [PATCH] power: ab8500: Remove flush_scheduled_work() call.
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-pm@vger.kernel.org
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

On Thu, Jun 9, 2022 at 9:43 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> On Thu, Jun 09, 2022 at 01:58:04PM +0900, Tetsuo Handa wrote:
> > It seems to me that ab8500 driver is using dedicated workqueues and
> > is not calling schedule{,_delayed}_work{,_on}(). Then, there will be
> > no work to flush using flush_scheduled_work().
> >
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > ---
> > Please see commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue()
> > using a macro") for background.
>
> Looks sensible to me. Adding Linus to Cc and waiting a bit so that
> he has time to review/test.

Makes perfect sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> @Linus I think it makes sense to add something like this to
> MAINTAINERS or add the files to the "ARM/NOMADIK/Ux500 ARCHITECTURES"
> entry, so that you will be CC'd.
>
> AB8500 BATTERY AND CHARGER DRIVERS
> M:      Linus Walleij <linus.walleij@linaro.org>
> S:      Maintained
> F:      Documentation/devicetree/bindings/power/supply/*ab8500*
> F:      Documentation/devicetree/bindings/power/supply/*ab8500*

OK I fix something.

Yours,
Linus Walleij

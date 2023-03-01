Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875D66A7385
	for <lists+linux-pm@lfdr.de>; Wed,  1 Mar 2023 19:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCASgg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Mar 2023 13:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCASge (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2023 13:36:34 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC32A3C7BC;
        Wed,  1 Mar 2023 10:36:33 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id u9so8254563edd.2;
        Wed, 01 Mar 2023 10:36:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677695792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZT/OJ9n++mt401vNDY8xHJSNHWuHKsSIBHt696WINAU=;
        b=5MBBrJq1Bji07QoFQ9ng1b49+xgI7OUWqKoObdwNC8vwRu2GM6DjB4/3tGQ51xB6bL
         fVL9vVLDSM5qONSgIKSTnpnWqHw6nw1I+McWImO5DDRsZjqs9k39n8EDdfUjf15DmpLj
         Y4041nHsqi06g8RhPcFaLMF+waaBrjkx2znl0T9eci3TVvWu35/PwgVoAX9dpOS6QunN
         H4I+41ynzYEN//jBvIgwK1yDjTqozglLUxdMb1jz+ZFkGnkRaOCGSJPhlQ6tfMCglXDY
         d4b6+ticuIvz9sU3y7VXQJtf2cJ3x96/Cn9cFJP4mIpoDrdd8Hop1Vva6J904ChNuxJb
         H4jQ==
X-Gm-Message-State: AO0yUKVqndX3iXIXCHVczSbX4bscEMU78bLdphdeZ8wcJbylzyBmr2AJ
        ReSj9zi7Yel0BPIU2aFkyrglnBF51STenAP7D+MHvsKM
X-Google-Smtp-Source: AK7set/H2etJvYe1d1itJBx6hspBD30RZmx5cJZgLeGAW0PK9sgtTvz5euwqOQWEzRFywRWOoz9kl56jMNflDNjzbOs=
X-Received: by 2002:a17:906:7687:b0:8ad:731:592d with SMTP id
 o7-20020a170906768700b008ad0731592dmr3628118ejm.5.1677695792428; Wed, 01 Mar
 2023 10:36:32 -0800 (PST)
MIME-Version: 1.0
References: <Y/yAzR6sWvPedLej@kili> <CAOgh=FyxFuENe6SgJB7aUwPS-ZB_51q6a=zWEcZSAsGqX034hA@mail.gmail.com>
In-Reply-To: <CAOgh=FyxFuENe6SgJB7aUwPS-ZB_51q6a=zWEcZSAsGqX034hA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Mar 2023 19:36:21 +0100
Message-ID: <CAJZ5v0jMm25S2M2g2oB9fE+U1SJO8w5Y87ENwOQ4JpPTAH6XEQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: apple-soc: Fix an IS_ERR() vs NULL check
To:     Eric Curtin <ecurtin@redhat.com>, Dan Carpenter <error27@gmail.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marc Zyngier <maz@kernel.org>, asahi@lists.linux.dev,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 27, 2023 at 11:26 AM Eric Curtin <ecurtin@redhat.com> wrote:
>
> On Mon, 27 Feb 2023 at 10:16, Dan Carpenter <error27@gmail.com> wrote:
> >
> > The of_iomap() function returns NULL if it fails.  It never returns
> > error pointers.  Fix the check accordingly.
> >
> > Fixes: 6286bbb40576 ("cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > ---
>
> Nice catch!
>
> Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Applied as 6.3-rc material, thanks!

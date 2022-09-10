Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1375B4802
	for <lists+linux-pm@lfdr.de>; Sat, 10 Sep 2022 21:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiIJTBx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Sep 2022 15:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIJTBw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2022 15:01:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876B2491D4
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 12:01:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s11so7156350edd.13
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 12:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qI17B0e4yJB+F1dL8FYkAI3R6t71e9uEt6K2KIj7Lc0=;
        b=EBLuCDJGqBeQ+vVXWU2V+wW3ZrjSNvwez+ipRbVzfAK8zQAH/EoXrDkVSs4B640GQS
         gSW4sTLCxdMKuvaKXl11kBNFyob/+yfa0yCC82OEO5JbTacyZhXLpzTecuqMHH5Ud8Qo
         TYMIxZF2qKQAJopgU/GLlcdFhKhjkN8O0+4yIejF9nzMvxEb9e5ItnofOebeWy+6ShbY
         jrpaH/HpEgJoidAtKz3t23U0mDs2NODje3jVCWMOWUG9FCJ8nuKarS7Oz2RyADeGDWpG
         dw7cRptLw1F8j8/TTYLrhRDOMB2Ys1ypFC0+QdibyUef6wuMlgFnVX32S0h5YDB/TPpF
         fGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qI17B0e4yJB+F1dL8FYkAI3R6t71e9uEt6K2KIj7Lc0=;
        b=3m5NOyTXZCF9gse5b6ljp7NoIZgSe2rxdWVvYzXqWVdu+I+xOlt8tPkR1Zk1rU0ndB
         cl1kYMj6/M/M+h3i96TbaTklhAP9ajPK+T4/APoBtx0WLNodjXdOkZaxnQXFNSupFxRt
         sIEJMrjY1oQE+k1kVNbXdbbhCjkGGUu6ytx2ttdSLGaEIc959Bw/dUm6ZDpxDxN3tHEa
         pyK0Es6hPvTM6zv42oRwRqIo7Nh600DVwei9jkLKb1SphyAq5LPcU6p6yaJPbAKGRzVD
         5yJiC1YRnQSSY/jW37o/O9+wp4J4mXKFdl8toupc5BBaCa6nQhGQ5xNAQXEdBM90pCnu
         NcSA==
X-Gm-Message-State: ACgBeo3uZ4DxkOWCeUnuUG6uCMngrNWgPx9P03sMPK4Fajyj9tpng800
        9G2HDx2IqhFLO3K8pr64fTRXZog3fEkIJlsJOZPrMQ==
X-Google-Smtp-Source: AA6agR6IzKPUM7epEfDZhvp0D8W8L0B9hFlIja5ZpA/pqoWM53+OgGd9FdmQjs0IZMBf8Ob7cSfP9ZZNy09swA/e6Sk=
X-Received: by 2002:a05:6402:1f8c:b0:43e:8fab:76c with SMTP id
 c12-20020a0564021f8c00b0043e8fab076cmr16121028edc.126.1662836510080; Sat, 10
 Sep 2022 12:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220719114131.62470-1-linus.walleij@linaro.org>
In-Reply-To: <20220719114131.62470-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 10 Sep 2022 21:01:38 +0200
Message-ID: <CACRpkdbYeCqJd1pqtEMb7oTFvYU+D5kJpE9OKnL7XGL8Ywiftg@mail.gmail.com>
Subject: Re: [PATCH] power: supply: Explain maintenance charging
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittineen <matti.vaittinen@fi.rohmeurope.com>
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

On Tue, Jul 19, 2022 at 1:43 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> In order for everyone to understand clearly why we want to use
> maintenance charging for batteries, expand the description with two
> diagrams and some text.
>
> Cc: Matti Vaittineen <matti.vaittinen@fi.rohmeurope.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Sebastian, could you apply this patch?

I think I sent it in the merge window, so easily missed.

Yours,
Linus Walleij

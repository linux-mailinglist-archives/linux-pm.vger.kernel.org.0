Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6210D7B15ED
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 10:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjI1IWO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 28 Sep 2023 04:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjI1IWN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 04:22:13 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6283413A;
        Thu, 28 Sep 2023 01:22:10 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5a22f9e2f40so942957b3.1;
        Thu, 28 Sep 2023 01:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695889329; x=1696494129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XB7yfOdb/BZVFX8xwYceeycH8uJ5tJEe/XCvC4Tw0Pk=;
        b=Roycerkk2lWEz29G2dV+mjfpEgu8iIsR41H+CeYv/O31Gt6d4YdaHDomS3Q2I1KWFV
         9DzpTokRp59K+J7kgMTLQ9N9KHc2QBaPeyjCuANAjjTTQcCLKAkGOyqXE35LBphIhuaf
         jdrIgEFJUU0FVH1MU143gy/2mYSifhnlb+HqPxD/7hKLSPfiu6lPuoSsbuvPQjfSvCqF
         1A8vVYAp6j1y0Q7Nrepnq42I6hUzOVjDYL6yyY62qWxuRTgf96BVaawPxOz6S1p3mcgw
         CrMv43RS9jhFBZEqhZrt6gfSlZTIBcsuOHpS0/N8D0RODfDYE4P304AsxfFkVfOfBQU8
         CoRA==
X-Gm-Message-State: AOJu0YyQ7iuQFFivKi6IGCTSvrCjUwmMZNJP0WRhW6qJx2xeglnjlho0
        2+TtTnCFCBCI27c3DP9cA5w56MUl57HKQQ==
X-Google-Smtp-Source: AGHT+IGWrqtIfJTjS+uw/92Cje/asvUO/G7mjKEAmlqZ6DfaiQwfnnCFY9sUkXZOzNRm/Wyf27EnUw==
X-Received: by 2002:a81:6dc9:0:b0:59b:1b87:a95b with SMTP id i192-20020a816dc9000000b0059b1b87a95bmr482472ywc.20.1695889329380;
        Thu, 28 Sep 2023 01:22:09 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id g123-20020a0dc481000000b0058c4e33b2d6sm4383493ywd.90.2023.09.28.01.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 01:22:09 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d86a0c97ae6so9655217276.2;
        Thu, 28 Sep 2023 01:22:08 -0700 (PDT)
X-Received: by 2002:a25:7384:0:b0:d0d:102c:78a8 with SMTP id
 o126-20020a257384000000b00d0d102c78a8mr431964ybc.31.1695889327815; Thu, 28
 Sep 2023 01:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de> <20230927193736.2236447-21-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230927193736.2236447-21-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Sep 2023 10:21:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVKCSBT7V_p+NCLUbRjAzh6Cf_sEA22U_X=bf8efgTeLA@mail.gmail.com>
Message-ID: <CAMuHMdVKCSBT7V_p+NCLUbRjAzh6Cf_sEA22U_X=bf8efgTeLA@mail.gmail.com>
Subject: Re: [PATCH 20/31] thermal: rcar_gen3: Convert to platform remove
 callback returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 27, 2023 at 9:49 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470A67B15F2
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 10:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjI1IXF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 28 Sep 2023 04:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjI1IXE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 04:23:04 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEC718F;
        Thu, 28 Sep 2023 01:23:03 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-59e77e4f707so155840687b3.0;
        Thu, 28 Sep 2023 01:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695889382; x=1696494182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56CIBsEjWGP2paONGyOikSAAiyEqrLz3lLMrr3Z4Ygo=;
        b=fAXUy3a/IQbHL421tg8jY60676zRN5m3jx2wll2xAU8rPvLODmoGFFYlMnc3MqhYZR
         s2YZyfwALlhHEmS27f1R/cp2lK82xiCTU4G80hJ43TVlwn5V6Tgql0iuskRZMbnL949O
         ugZG/kY8ATxTt6I5H7CZ4kxFmlNmqCt0YQhiSfRuyAOZeWv8VwHo0ryzi9fY4pq/MkWK
         P14BYsiRBHJkKpCzt2W//mPkdA/RXwrQzKcTK5zvJn5QX/1sFCUwHRNNN96wz6FJGx8t
         csERmKkYyIyUY4NUwhv/SXWsZ2SRDrYUQuBoZ0Y0dzNZEag/mDUe+kecLBV677sJwyj6
         D6EA==
X-Gm-Message-State: AOJu0YzV7uw5gvshEqljWVPWyRfM4yRNmppjbocqbJbQICHg3hvc6fk1
        Cl8lMsbpwaxsRHFIXEZtzroWoKiHcsPdOA==
X-Google-Smtp-Source: AGHT+IGsIyiibbp3lfCphABIGoSPEr9nhFGm0Ul97AxU+GrmAq69t0GWealaL4b9OzyzxD8hMyyqSA==
X-Received: by 2002:a81:9406:0:b0:59f:7ded:87dd with SMTP id l6-20020a819406000000b0059f7ded87ddmr556735ywg.47.1695889381804;
        Thu, 28 Sep 2023 01:23:01 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id z1-20020a0dd701000000b0059bd8447721sm4362845ywd.21.2023.09.28.01.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 01:23:01 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59e77e4f707so155840567b3.0;
        Thu, 28 Sep 2023 01:23:01 -0700 (PDT)
X-Received: by 2002:a0d:cc44:0:b0:59f:81c4:631a with SMTP id
 o65-20020a0dcc44000000b0059f81c4631amr592197ywd.24.1695889381077; Thu, 28 Sep
 2023 01:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de> <20230927193736.2236447-22-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230927193736.2236447-22-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Sep 2023 10:22:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWEgiO140yBaJjakpwb5TsGicqV5GeB+HwM=m7zyzkmcw@mail.gmail.com>
Message-ID: <CAMuHMdWEgiO140yBaJjakpwb5TsGicqV5GeB+HwM=m7zyzkmcw@mail.gmail.com>
Subject: Re: [PATCH 21/31] thermal: rcar: Convert to platform remove callback
 returning void
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

On Wed, Sep 27, 2023 at 9:42 PM Uwe Kleine-König
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

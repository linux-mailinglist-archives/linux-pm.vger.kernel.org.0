Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EDB78D1A9
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 03:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbjH3BU7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 21:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241595AbjH3BUZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 21:20:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17466CDC
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 18:20:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c1c66876aso648796266b.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 18:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693358414; x=1693963214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=61Qie5c2kDF2Zc0oY6tB5adEIVm20BboiMQ31ckJkUM=;
        b=LNCgTtni8E06IO9kNM5gSm4Y7I3fEcwz4hbDBBdT16h3ncYPGw/rcsEI2Z8s9kroAA
         ND5fcrAix5fBpPthCzQAjXf7u8DqtRdqeS4yhj3LwRPkWMS3M3ie9eLnFN+dcOXseZBk
         UVUSb2ceSteuKNCrSnFFx9ll83cXRs3cnKuzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693358414; x=1693963214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61Qie5c2kDF2Zc0oY6tB5adEIVm20BboiMQ31ckJkUM=;
        b=DhgHfOR4tBZkScy9zQleoQKfUaLARSBq64h9iXkxsHjFY6w2eSdfpg1nZxMZ39IDbd
         Ik0967TlstXcr5kHR3wlFlKDLWSKSfKVRvR4meQZQzvd2a0JBW3HFsHo8pFdTYkgfvUG
         vPHk/Sn/qGG0oo01FXyADSDx01uuqxhCe+eGC5u3IXjtjvhc1e3WVaPbwKYVcWrM841C
         BALmx6ck2MgFJ1Iyye71zRo1a4TIKeKTt5D2WnKBuvvscAMw/Ut4W2sf0g4hF65dNYLQ
         A9P9yDZn5WNCLEYoeEaVYQlOUQ6u2KaHNkcJkPyf712Z9Y0gR2Rq0ySkjmLLFx27dybg
         9BhQ==
X-Gm-Message-State: AOJu0YyPIDiBaJoMGM8LFx4ddP72AqNREdnKhLoaYEjRoWfnwOL6iY+6
        C8emFKkhYEM3lcekL4yn2r49HC6Ogsxtx9/ertMiglIh
X-Google-Smtp-Source: AGHT+IFvgD/xOvf/uQqr0Ip44Ddi9Maor6WLr6xar7l5Fw4Q63xt+qFWf6z8hxRosDzRKnYX4RJFsA==
X-Received: by 2002:a17:906:2252:b0:9a2:28dc:4166 with SMTP id 18-20020a170906225200b009a228dc4166mr444141ejr.75.1693358414460;
        Tue, 29 Aug 2023 18:20:14 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090624d100b0099cb0a7098dsm6655190ejb.19.2023.08.29.18.20.13
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 18:20:13 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-99c1c66876aso648794066b.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 18:20:13 -0700 (PDT)
X-Received: by 2002:a17:907:9687:b0:99c:85af:7aa6 with SMTP id
 hd7-20020a170907968700b0099c85af7aa6mr547689ejc.28.1693358412962; Tue, 29 Aug
 2023 18:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com> <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com>
In-Reply-To: <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Aug 2023 18:19:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
Message-ID: <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 29 Aug 2023 at 17:48, Arnd Bergmann <arnd@arndb.de> wrote:
>
> How about moving it to drivers/power/domain/ instead?

That sounds like a sensible name and would seem to fit logically with
our existing tree structure quite well.

> I don't think we can easily rename the interfaces that have been
> in use for the past 12 years

I actually think the interface names are much less of an issue, since
anybody using them is presumably familiar with the naming.

It was only with the directory structure that I reacted to it, because
that kind of exposes the naming to people who definitely are *not*
familiar with it (ie me, but presumably anybody else who sees the
diffstats etc fly past).

And yes, we have a number of other pretty obscure driver names in our
tree (I end up having to remind myself what "ntb" and "hsi" etc mean),
and I don't tend to love them either, but at least they tend to be
industry / vendor names.

            Linus

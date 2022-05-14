Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB9F527477
	for <lists+linux-pm@lfdr.de>; Sun, 15 May 2022 00:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiENWKK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 May 2022 18:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiENWKJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 May 2022 18:10:09 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CC4120A9
        for <linux-pm@vger.kernel.org>; Sat, 14 May 2022 15:10:08 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2ec42eae76bso120456967b3.10
        for <linux-pm@vger.kernel.org>; Sat, 14 May 2022 15:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4ClGq7yvUj7htHY+ElrZBm3AzCgZu29/ABPxk/n3Jc=;
        b=cNe6ev+ofG0b/Pazsb266II3fHCjtNi9RFC/kDTysYaSFxMz9gS2pF5tuskIXu9o+R
         kXVMnZ9F1ACQqIO/N3LUrqtcG2Iy6ddFnqEVKMcruflni/8trEsmwDwm+267T3Q+r1mC
         GHAdhU4Za7HTMm8l1QoG3gA0/GCL1hsRkfD0CJKlRn40jgLz94bvm2pdzmsiYBPxUQdw
         +kxQJ4fyX+4FG5FWOaCPbgaJ+ojXX9A9sLo64pCqPF4VsNN2FhEOQN8aavT0B/4aY0A6
         KOL+3nEzKZN78qI25uTXY91Z7kktiwYj9iR9fQo2LkeIwmxUa1aJj3AuzA6oZW4G0rkj
         3W7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4ClGq7yvUj7htHY+ElrZBm3AzCgZu29/ABPxk/n3Jc=;
        b=zwcAC9yFW4IEPoKVbw4gFNksisFcqvk8JgKFyJwCeXRVtA11XD8cz81nN1LLWNx2l7
         Uj2AcrzV5rMW+/7Q8PmQIYKzCkYWIHy6kRISm15MSZ/90iQ6lJ0uLRGdLC2qE5BPaT33
         GkTmgtREl8hKrM4yJDWi1deD6Pm0BXYZRrwjdVmUcHeyX0gW1Y8nhoVEkzlSioIbWql7
         Fkmc1HCsgJ3gDzS6qsMuAAqQ7J1Tojcxr+LWmDgOIAD+qDKwyuWD6AtSfxTwIS4t9G0w
         FkYlTvhSqWFardp4/CZWU6WIDlAREO3kQGOoRoz+plS/o13sGRat8MRcAelk2k7pP2y9
         M1Wg==
X-Gm-Message-State: AOAM533FdTdgdC292DcWj6TFBbZ+CZFJxDTVl50AcTBKhGk+395fPoqZ
        6nwNJKSxALdxtBXZ9IZtcpxCxw9oiLJDkVM/voExIA==
X-Google-Smtp-Source: ABdhPJxnR9LAgw+ZgzpNiAHNL7jSU1q/3ldJxHFFztb0pAh3Yz9r/XR3vEXevF3JB25rKEp72rvIQ1LZIbNaiU7H0dw=
X-Received: by 2002:a81:1d48:0:b0:2f1:8ebf:25f3 with SMTP id
 d69-20020a811d48000000b002f18ebf25f3mr12243831ywd.118.1652566207412; Sat, 14
 May 2022 15:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <4ca23609-11f4-881b-6676-83ac80dff254@dorianrudolph.com>
In-Reply-To: <4ca23609-11f4-881b-6676-83ac80dff254@dorianrudolph.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 15 May 2022 00:09:56 +0200
Message-ID: <CACRpkdZJV4FjgVMmRU+vr1wkcoRuMG+FS69QMC1iPTjz0qwwvQ@mail.gmail.com>
Subject: Re: [PATCH] power: supply: core: Fix boundary conditions in interpolation
To:     Dorian Rudolph <mail@dorianrudolph.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
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

On Sat, May 14, 2022 at 5:23 PM Dorian Rudolph <mail@dorianrudolph.com> wrote:

> The functions power_supply_temp2resist_simple and power_supply_ocv2cap_simple
> handle boundary conditions incorrectly.
> The change was introduced in a4585ba2050f460f749bbaf2b67bd56c41e30283
> ("power: supply: core: Use library interpolation").
> There are two issues: First, the lines "high = i - 1" and "high = i" in ocv2cap
> have the wrong order compared to temp2resist. As a consequence, ocv2cap
> sets high=-1 if ocv>table[0].ocv, which causes an out-of-bounds read.
> Second, the logic of temp2resist is also not correct.
> Consider the case table[] = {{20, 100}, {10, 80}, {0, 60}}.
> For temp=5, we expect a resistance of 70% by interpolation.
> However, temp2resist sets high=low=2 and returns 60.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dorian Rudolph <mail@dorianrudolph.com>

My arithmetics were not with me that day. I also copypasted the error :(
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Fixes: a4585ba2050f ("power: supply: core: Use library interpolation")
Cc: stable@vger.kernel.org

Yours,
Linus Walleij

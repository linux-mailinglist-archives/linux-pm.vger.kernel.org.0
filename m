Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F2F532401
	for <lists+linux-pm@lfdr.de>; Tue, 24 May 2022 09:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiEXH00 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 May 2022 03:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbiEXH0C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2022 03:26:02 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1364797295
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 00:26:00 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id x137so972083ybg.5
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 00:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3ADQCREbWZJgoHzXNT4SqhngDOz5wX2IM0lbpMtxoc=;
        b=izrk844FQF3CPJ39B7iE/hbTnzveN5okwNk4FqFu3T1zGffBMkch2CEh0DsNMudTj8
         i86k+u6QavUQH7dqEokiALt3sjaUTnyuNdYas2IkOr2LYm9vYkVc2OOFa5F3zQqagyEe
         nTGOIUMCXwZdIO1e6I68RYwTEntPwuvN9Ek0B+WWxBr8Br86FV3lOVH/gihGoBNdsUbW
         K2G648t+WETJujvuYJq/6EGQgdT7YHmHCDZvR7kRUjz1d6rF/WmeVZ+zO92hvJp242v9
         sDxBVlzYE4SQHrY06X+QbDLrZcZfMc5x5Uo4sDn+3+hnj7bqL1ygPdgqEaWDk/RwOQTx
         M0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3ADQCREbWZJgoHzXNT4SqhngDOz5wX2IM0lbpMtxoc=;
        b=mX0u7zgRePUIUk790mDZdbx5SPGxRmmeUItRCxEjz+w63fjDSk89Dx1ptm+L0Si3ES
         D7uO2O9gkKXm19N1BHZGdtqSpGOk2gAi9LCpOx3NnGACzCdrgnjK9wuSfAAPyyvSIL7s
         EPcKimPsRmLPoBoQRWZG2UP9S8UUbbmBhcuDHJW6TEmOdatVSfc8v/amhfDn9zAYFP25
         0TNckDPLkvLmHhyHWHvF1kv8AANdP4KwAACtlcMfluPBMKiBL0ol4IV82r4KxxnwRS/P
         M0Z/joBdtfJIVUyG32fvNtqI0kyekFmVKmC1UJZ2fm5QRQx3LjuPzb9LvCnYNceKE7f0
         xA3A==
X-Gm-Message-State: AOAM532fKFJM2i0epETpVxCNZf+6C92z+8xU9rgEp52OLhxXl6W9NCDw
        f7Z+G9a/+F5/5aMdVRecCKhVOfnO2ZfR/kIy7l0RAdHc3Os=
X-Google-Smtp-Source: ABdhPJxqmGs4DGjpwlmXW5yjEYYSk4jao8NINHIFisXpg712mVqO78RiARrF6d7rCCgG9J7Lhpc+C/7YDrfXZkix8LI=
X-Received: by 2002:a05:6902:704:b0:64d:f270:22b0 with SMTP id
 k4-20020a056902070400b0064df27022b0mr24774879ybt.626.1653377159322; Tue, 24
 May 2022 00:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220523141009.52965-1-linmq006@gmail.com>
In-Reply-To: <20220523141009.52965-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 May 2022 09:25:48 +0200
Message-ID: <CACRpkdb+-urzSHCuug0qa=oytNuyBZyFafBBJ+1D8Yatks7Qew@mail.gmail.com>
Subject: Re: [PATCH] power/reset: arm-versatile: Fix refcount leak in versatile_reboot_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 23, 2022 at 4:10 PM Miaoqian Lin <linmq006@gmail.com> wrote:

> of_find_matching_node_and_match() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 0e545f57b708 ("power: reset: driver for the Versatile syscon reboot")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBEC5172FD
	for <lists+linux-pm@lfdr.de>; Mon,  2 May 2022 17:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385907AbiEBPnI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 May 2022 11:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385916AbiEBPnH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2022 11:43:07 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D72BC38;
        Mon,  2 May 2022 08:39:34 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id j6so11614114qkp.9;
        Mon, 02 May 2022 08:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1cbGL55MYefR1RBZQnBzW2Qa9xyYWDeso5LJDjp3Bs0=;
        b=agbtVE+6hD43TgiKkbLdT5BGzG9qk7CR085iYY2Zh4iLLKYQTCUjcvnaHtCRFQFpom
         /LYLQmHsxTx0xVJ18DQ5wB2gkIT79iZUF1aMVhb1MR8q5gztJRP6e/JvmEFVtjYlOAue
         rgx6KaNkdxyukbRt/XkegzcXJ7q+UVYmPIHXTiMtwH46+y83mzDgIHA4wHgFIByRX3mx
         dS5EkfS0R9zs5CIw3LCDeeMbTrcTNEKxcbHLIPO84kZUip0E+GLRFLX4TWQ7FTE/PlQa
         HD8NMGwW9DP0yufeRtT8BxQb2jNcEvzea8MykVxFBlwjCcN3LNAqyEraVglNh5PLzNXP
         0GYA==
X-Gm-Message-State: AOAM533yycLW3jAqkTjzssmIc6tzGDrpnTt9GMmRNiB33pyG5ybPGWHx
        1TkzvSEsFVML7LLE59N1Az1c8Z6XKHPZdw==
X-Google-Smtp-Source: ABdhPJywu5l9QXuFBssHW2zNyBncjnPx1NvdseTZGeiA1/vQANEr0jEYFMgqeF6RjYhw9/x4Mp3PIg==
X-Received: by 2002:a37:5347:0:b0:69f:842f:bfed with SMTP id h68-20020a375347000000b0069f842fbfedmr9005184qkb.303.1651505973505;
        Mon, 02 May 2022 08:39:33 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id i3-20020ac84883000000b002f39b99f68csm4361014qtq.38.2022.05.02.08.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 08:39:33 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2f7bb893309so151715407b3.12;
        Mon, 02 May 2022 08:39:33 -0700 (PDT)
X-Received: by 2002:a81:9b0c:0:b0:2f4:c522:7d3c with SMTP id
 s12-20020a819b0c000000b002f4c5227d3cmr11532849ywg.316.1651505972915; Mon, 02
 May 2022 08:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220501081930.23743-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220501081930.23743-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 May 2022 17:39:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUouMixUNrDkinwy2U_JZSGrhsf-Pq2YZOES7tN3bOmhQ@mail.gmail.com>
Message-ID: <CAMuHMdUouMixUNrDkinwy2U_JZSGrhsf-Pq2YZOES7tN3bOmhQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: rzg2l-thermal: Document RZ/G2UL bindings
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 1, 2022 at 10:19 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Document RZ/G2UL TSU bindings. The TSU block on RZ/G2UL is identical to one
> found on RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rzg2l-tsu" will be used as a fallback.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

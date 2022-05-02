Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED5851731D
	for <lists+linux-pm@lfdr.de>; Mon,  2 May 2022 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385926AbiEBPrZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 May 2022 11:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241392AbiEBPrY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2022 11:47:24 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8DBDBA;
        Mon,  2 May 2022 08:43:55 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id a5so10491257qvx.1;
        Mon, 02 May 2022 08:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MWN1yDc7rY3c++KUHEjaTK+VZQBm1P3dLMOE3fHtyi4=;
        b=zQQI7wWIypD/Xk+pCx0cBMbLtVmmHEKSwihoy/PwiIQ1XArDwwfoEtPfG/kwPiM/Mf
         X3EzCH44rHvsOQuzybE3wt3iwDpP13KUCarC7oUU5p6775eOlTmusEeMbl5ZVIWiWgZr
         gQ/4RcteZIL5qdV8GkOJSQY3y5QBM54dieDykJX4wJyXoP8d+L64098EHWTc59lmml2I
         7Ze9mAs22opY8Me0o8hyNdQ7/Khfi5jIzUEigJcb+k0HqRrzXSbhTRoQCO2BCCmkszRA
         dwBnozlU/82EVbbT92KKcUiWLXItanEWDooJ71Eqz43SqnoTPpbyvhfQn7CroQuEgbtd
         xnyg==
X-Gm-Message-State: AOAM5309YTFBUoQryYQTaswnQTUUbAhA5rRq1oPhEzp+Atvm7FC9Zzht
        Q/ux4ANNlF4hgVUOkTO5t8ZyBWpad4WtaA==
X-Google-Smtp-Source: ABdhPJwht2JHZA9fmZJaKdWujBQseq5BTPW20V7NAkBnCgTQecMQijDN7B28IcbBBPpWYpJ2X6SQzw==
X-Received: by 2002:a05:6214:2a86:b0:45a:8a2d:1aa0 with SMTP id jr6-20020a0562142a8600b0045a8a2d1aa0mr4934422qvb.111.1651506234602;
        Mon, 02 May 2022 08:43:54 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id q19-20020ac84513000000b002f39b99f671sm4205108qtn.11.2022.05.02.08.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 08:43:54 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso152114807b3.5;
        Mon, 02 May 2022 08:43:53 -0700 (PDT)
X-Received: by 2002:a81:6588:0:b0:2f8:b75e:1e1a with SMTP id
 z130-20020a816588000000b002f8b75e1e1amr11913316ywb.358.1651506233717; Mon, 02
 May 2022 08:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220428093346.7552-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220428093346.7552-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 May 2022 17:43:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUk2A0droQp_f3V58DmPQt1j64XkPOUHqpuC-D4bi_KuQ@mail.gmail.com>
Message-ID: <CAMuHMdUk2A0droQp_f3V58DmPQt1j64XkPOUHqpuC-D4bi_KuQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/rz2gl: Fix OTP Calibration Register values
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 28, 2022 at 11:33 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> As per the latest RZ/G2L Hardware User's Manual (Rev.1.10 Apr, 2022),
> the bit 31 of TSU OTP Calibration Register(OTPTSUTRIM) indicates
> whether bit [11:0] of OTPTSUTRIM is valid or invalid.
>
> This patch updates the code to reflect this change.
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

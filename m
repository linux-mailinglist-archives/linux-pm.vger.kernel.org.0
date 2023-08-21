Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C535782513
	for <lists+linux-pm@lfdr.de>; Mon, 21 Aug 2023 10:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjHUIJK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 21 Aug 2023 04:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjHUIJJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2023 04:09:09 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E483FB5;
        Mon, 21 Aug 2023 01:09:06 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-584034c706dso32524217b3.1;
        Mon, 21 Aug 2023 01:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692605346; x=1693210146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48fQdqBaIQQrhkgOCi05tF2mCNTs8D0cqP0HbZhiW4Y=;
        b=E0Ns4L19INeBIDXMBivLsWqqQijmYzdBYm9F3yx+zcfqH0eGn7jslqYmake0m44SCW
         ESFpyK+gx5lqLR1AtdZDv5emtAP6pl+TEjdLR1CWWj5h96Z5k3Ohg/KYganjpDz001VJ
         HGRV1ZQEhVqQeIxWG3sjnWCr6N8IWOPhOib+FWx9eaK1IqHjmzwBweqHxZ7CfUwd3BY5
         pvD5QIUChCBhDDWFvHfo8PqOg2gAIMzZKeeVAvgXAQuGeZOWsTJyjzMzJBMNc0bxfk8l
         /YbD5UIrMCE6pmnbqO28+E7015jTLgJehDME/sKYXA+hbqmr3naEks7TSAEvuobF8h8B
         l46A==
X-Gm-Message-State: AOJu0YznBn7DQFKy6BXbMNrfu/fuHxXUOn/Yh4bAfbSYdxEnpoYbjl2s
        Un0XAMw3w2VYnDDONVsT9Za8GvtiJxhnVg==
X-Google-Smtp-Source: AGHT+IGJYuXD+adO3SECMh6A69WiJPI5wheyrxyau9pS3gKiPNCAMniZjBI3KCQt99zJnMvVOui98A==
X-Received: by 2002:a0d:d3c6:0:b0:577:4005:d885 with SMTP id v189-20020a0dd3c6000000b005774005d885mr5312453ywd.15.1692605345564;
        Mon, 21 Aug 2023 01:09:05 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id w6-20020a814906000000b005773afca47bsm2133708ywa.27.2023.08.21.01.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 01:09:05 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d7260fae148so3130251276.1;
        Mon, 21 Aug 2023 01:09:05 -0700 (PDT)
X-Received: by 2002:a05:6902:4c1:b0:d4b:cb62:9493 with SMTP id
 v1-20020a05690204c100b00d4bcb629493mr5227606ybs.12.1692605344892; Mon, 21 Aug
 2023 01:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230820171145.82662-1-biju.das.jz@bp.renesas.com> <20230820171145.82662-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230820171145.82662-3-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Aug 2023 10:08:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_5XtmUt_LBCHbbjS+Ds5j7KrPTtOLVYrHTw4Hipsu9A@mail.gmail.com>
Message-ID: <CAMuHMdX_5XtmUt_LBCHbbjS+Ds5j7KrPTtOLVYrHTw4Hipsu9A@mail.gmail.com>
Subject: Re: [PATCH 2/2 RESEND] power: supply: sbs-battery: Convert
 enum->pointer for data in the match tables
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-renesas-soc@vger.kernel.org
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

Hi Biju,

On Sun, Aug 20, 2023 at 7:12 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Convert enum->pointer for data in the match tables, so that
> device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> bus type match support added to it and it returns NULL for non-match.
>
> Therefore it is better to convert enum->pointer for data match and extend
> match support for both ID and OF tables using i2c_get_match_data() by
> adding struct sbs_data with flags variable and replacing flags->data in
> struct sbs_info.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -201,6 +201,10 @@ static const enum power_supply_property string_properties[] = {
>
>  #define NR_STRING_BUFFERS      ARRAY_SIZE(string_properties)
>
> +struct sbs_data {
> +       u32 flags;
> +};

Unless you plan to add more members to struct sbs_data, I see no point
in this patch: it only increases kernel size.

The various "data" members in <foo>_id structures are intended to
contain either a pointer or a single integral value.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

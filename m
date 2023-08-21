Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3247825E9
	for <lists+linux-pm@lfdr.de>; Mon, 21 Aug 2023 10:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjHUI5U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 21 Aug 2023 04:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjHUI5U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2023 04:57:20 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A03D8;
        Mon, 21 Aug 2023 01:57:11 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d6b0c2cca0aso3080844276.0;
        Mon, 21 Aug 2023 01:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692608230; x=1693213030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nz3SeqZ5mzNFTLdITSJqhm2PxWvgZjUbquhIM26FkAo=;
        b=V3Bp+qhZPxBvmsVH0Aw0qhZKOYM8dhZzW9P7rvFoa/vYkFyxyvPcNVk5cbodYPiYUh
         vK+hVCsDKYostbEpuTUEqzGcHTs3l7yJAlPs2MBAifnK8U2DhvguRICcO/v8fyXfRybl
         qZtX4/K8UC6axYum/sx6NIxcjuW6mao+1H+eeB3aJqGrF3y1V9cXkKeALg6Wfs3WMQSA
         YqSUjfoK6u1SezTiPFs8ZpXcHANDnpeLX79VzrIH5IzzUMbEZHhRorPReL0mnzOr3xiR
         YhZiUeaA62cvpsp7x1TwBLrijZVjAnS5ShMUyHj0AgQDVKui3qJin5CPeDeeLtRrkLyr
         HlZw==
X-Gm-Message-State: AOJu0YzqD/bVs2SKIsXOvaUA63JCI2vAwfvfJj/e9L3+6gm2qliBHeZZ
        vCJInx4siMjtWCvvLW2v3xG/IVGXyc+J1w==
X-Google-Smtp-Source: AGHT+IGbheshXnR8HkFhx1Zg0yjd9n4n566nz+rMH0GS+H65jTP7tfgcUAOAFsHx8x5FSL1wQvjqCg==
X-Received: by 2002:a25:6994:0:b0:d47:ba3c:a66c with SMTP id e142-20020a256994000000b00d47ba3ca66cmr4894758ybc.19.1692608230383;
        Mon, 21 Aug 2023 01:57:10 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id x140-20020a25ce92000000b00d72176bdc5csm1799967ybe.40.2023.08.21.01.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 01:57:09 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d7484cfdc11so1437051276.1;
        Mon, 21 Aug 2023 01:57:09 -0700 (PDT)
X-Received: by 2002:a25:2e01:0:b0:d04:f936:556 with SMTP id
 u1-20020a252e01000000b00d04f9360556mr5696503ybu.36.1692608229755; Mon, 21 Aug
 2023 01:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230820171145.82662-1-biju.das.jz@bp.renesas.com>
 <20230820171145.82662-3-biju.das.jz@bp.renesas.com> <CAMuHMdX_5XtmUt_LBCHbbjS+Ds5j7KrPTtOLVYrHTw4Hipsu9A@mail.gmail.com>
 <OS0PR01MB5922A59E515D4355366294CD861EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXJV+fJHWWCm8w19ryErKhHcpKbWvtoOjCn4p1NUse1sQ@mail.gmail.com> <OS0PR01MB5922A624EA3B52BA99877C07861EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922A624EA3B52BA99877C07861EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Aug 2023 10:56:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVNHJBeiU9vmpQoFjriWvWqjLLvpdoHRDxg-3f6b1CTyg@mail.gmail.com>
Message-ID: <CAMuHMdVNHJBeiU9vmpQoFjriWvWqjLLvpdoHRDxg-3f6b1CTyg@mail.gmail.com>
Subject: Re: [PATCH 2/2 RESEND] power: supply: sbs-battery: Convert
 enum->pointer for data in the match tables
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
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

On Mon, Aug 21, 2023 at 10:53 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH 2/2 RESEND] power: supply: sbs-battery: Convert enum-
> > >pointer for data in the match tables
> > On Mon, Aug 21, 2023 at 10:2 AM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > > On Sun, Aug 20, 2023 at 7:12 PM Biju Das
> > > > <biju.das.jz@bp.renesas.com>
> > > > wrote:
> > > > > Convert enum->pointer for data in the match tables, so that
> > > > > device_get_match_data() can do match against OF/ACPI/I2C tables,
> > > > > once i2c bus type match support added to it and it returns NULL for
> > non-match.
> > > > >
> > > > > Therefore it is better to convert enum->pointer for data match and
> > > > > extend match support for both ID and OF tables using
> > > > > i2c_get_match_data() by adding struct sbs_data with flags variable
> > > > > and replacing flags->data in struct sbs_info.
> > > > >
> > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > >
> > > > > --- a/drivers/power/supply/sbs-battery.c
> > > > > +++ b/drivers/power/supply/sbs-battery.c
> > > > > @@ -201,6 +201,10 @@ static const enum power_supply_property
> > > > > string_properties[] = {
> > > > >
> > > > >  #define NR_STRING_BUFFERS      ARRAY_SIZE(string_properties)
> > > > >
> > > > > +struct sbs_data {
> > > > > +       u32 flags;
> > > > > +};
> > > >
> > > > Unless you plan to add more members to struct sbs_data, I see no
> > > > point in this patch: it only increases kernel size.
> > > >
> > > > The various "data" members in <foo>_id structures are intended to
> > > > contain either a pointer or a single integral value.
> > >
> > > The match data value for sbs_battery is 0. Here the API returns NULL
> > > for a non-match. That is the reason it is converted to pointer.
> > >
> > > So, we cannot differentiate actual matched data and error in this case.
> >
> > If the driver's .probe() method is called, there must have been a valid
> > match, so i2c_get_match_data() will never return NULL due to a non-match.
>
> I agree. but "return data" can be 0,if the matched value is 0 (for eg: here "sbs_battery").

Yes, so what is the problem?
Zero is the expected value for these.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

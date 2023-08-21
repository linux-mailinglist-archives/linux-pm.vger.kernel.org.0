Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62747825A5
	for <lists+linux-pm@lfdr.de>; Mon, 21 Aug 2023 10:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjHUIiy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 21 Aug 2023 04:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjHUIix (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2023 04:38:53 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D0213E;
        Mon, 21 Aug 2023 01:38:16 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-58c4f6115bdso32543877b3.1;
        Mon, 21 Aug 2023 01:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692607082; x=1693211882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPbgadW8+o8+G25GJyu/HQLA9QoKbFEZVcUvDmSKk8k=;
        b=cphL1Vv8y+EKoIdn0IPVh+dozzFrJBZW2G4sgyJ26I+Am2MoJTUT7LwfFRFHABc+Tf
         KkNAXsBsaUbrZijr/D6TGBXouP2fJQKpnebZdmaNedrS/TZ9wJwEqpMonYoprKllcCzE
         wkUiZP1uX0zj/5dnIXcXWaYZPnrGuxM2GeT6PR2qXMyBxtBnoF9wgbyUl6hTWzEAl4z3
         Uq+y9BhmpOLRoPTQfvoUOyfRi8vRnh/TXltHwr68UU/QOKiJY3TWpjbmQ7FJpc9IjcrB
         krg2zimn1LvQRJQkixYirNk1fmyZfRWsIYsLZIzofDA5VBqMR1pe+RD2DvouO0DOnpbt
         zp9Q==
X-Gm-Message-State: AOJu0Yw0gI6dkO1n0WTgWP4I1loMAJT4MflroWaXCvYeAJUuZA1vxkW3
        At4hcItkxbCLQqQugz7/Fl8v7kNFbDl7Fg==
X-Google-Smtp-Source: AGHT+IE2gCXmcx8G5n5OwUlQMVEzjgX6uCx8ZClxLXNlDQYT4cMn0S1EWPhFf1naSDgkA9UZVqZEqw==
X-Received: by 2002:a81:a507:0:b0:583:d8d4:7dfe with SMTP id u7-20020a81a507000000b00583d8d47dfemr6450704ywg.31.1692607082617;
        Mon, 21 Aug 2023 01:38:02 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id p4-20020a0dff04000000b0058bcea54fc2sm2125286ywf.57.2023.08.21.01.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 01:38:02 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so3087219276.0;
        Mon, 21 Aug 2023 01:38:02 -0700 (PDT)
X-Received: by 2002:a25:cfcc:0:b0:bd0:8e5:d548 with SMTP id
 f195-20020a25cfcc000000b00bd008e5d548mr6545014ybg.39.1692607082320; Mon, 21
 Aug 2023 01:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230820171145.82662-1-biju.das.jz@bp.renesas.com>
 <20230820171145.82662-3-biju.das.jz@bp.renesas.com> <CAMuHMdX_5XtmUt_LBCHbbjS+Ds5j7KrPTtOLVYrHTw4Hipsu9A@mail.gmail.com>
 <OS0PR01MB5922A59E515D4355366294CD861EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922A59E515D4355366294CD861EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Aug 2023 10:37:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJV+fJHWWCm8w19ryErKhHcpKbWvtoOjCn4p1NUse1sQ@mail.gmail.com>
Message-ID: <CAMuHMdXJV+fJHWWCm8w19ryErKhHcpKbWvtoOjCn4p1NUse1sQ@mail.gmail.com>
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

On Mon, Aug 21, 2023 at 10:21 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > On Sun, Aug 20, 2023 at 7:12 PM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > Convert enum->pointer for data in the match tables, so that
> > > device_get_match_data() can do match against OF/ACPI/I2C tables, once
> > > i2c bus type match support added to it and it returns NULL for non-match.
> > >
> > > Therefore it is better to convert enum->pointer for data match and
> > > extend match support for both ID and OF tables using
> > > i2c_get_match_data() by adding struct sbs_data with flags variable and
> > > replacing flags->data in struct sbs_info.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > > --- a/drivers/power/supply/sbs-battery.c
> > > +++ b/drivers/power/supply/sbs-battery.c
> > > @@ -201,6 +201,10 @@ static const enum power_supply_property
> > > string_properties[] = {
> > >
> > >  #define NR_STRING_BUFFERS      ARRAY_SIZE(string_properties)
> > >
> > > +struct sbs_data {
> > > +       u32 flags;
> > > +};
> >
> > Unless you plan to add more members to struct sbs_data, I see no point in
> > this patch: it only increases kernel size.
> >
> > The various "data" members in <foo>_id structures are intended to contain
> > either a pointer or a single integral value.
>
> The match data value for sbs_battery is 0. Here the API returns
> NULL for a non-match. That is the reason it is converted to pointer.
>
> So, we cannot differentiate actual matched data and error in this case.

If the driver's .probe() method is called, there must have been a
valid match, so i2c_get_match_data() will never return NULL due to
a non-match.

BTW, the driver does not check for a NULL return value from
*_get_match_data() anyway (and there is no reason to change this!).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

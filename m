Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081A45A39F1
	for <lists+linux-pm@lfdr.de>; Sat, 27 Aug 2022 22:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiH0UGA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Aug 2022 16:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiH0UF7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Aug 2022 16:05:59 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D281C4CA2B;
        Sat, 27 Aug 2022 13:05:57 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q81so3714790iod.9;
        Sat, 27 Aug 2022 13:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=U3nX4cdNXZqpfLJDqBLA44CtW4+U9zWhNzo9DHIZoaU=;
        b=qpg69lwLsm8EE0skmNswnst9smx0Xds+vzMdByGY6gmduLxuLspE9phL6buIhnVJii
         gOA3bRG+OSl/7uh1on599nc9npfT6Yh1ba/sM3iu+lGhwsmqHF4U5rLzBRnyBAPCX8sq
         A9TvAAvOwXrlQdFeRfW9UuzuUw3vww8lWn6uxYwtTv1tnmdbn1d22O/q3CUSPulW0WPL
         V3SEDXs0avUTx4F3/cnxVjmaFqbp874jWn9z6Ya9VdULkXtCM3DdLvuaL6ID5XtYGQiK
         jEWy9nQlziImFjAh2r5uNaB+sIUM5monEGG2OOIBulqltmPEMA4qmZrcNAVlK1/wD/0I
         efXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=U3nX4cdNXZqpfLJDqBLA44CtW4+U9zWhNzo9DHIZoaU=;
        b=HGaL2LAcHyrANq/za4WYHuioXaD38JLp8GZlRrPL6mznAv3/GNGem4UH5TxAZe3WJr
         fZ7Q9kgftnouQFIE26hoCMwWvk3XS5kESaZikqELRDFgWQ4+lOGCwDFbsKWewvzjwtum
         o2yD/qw5gs5HXsi/pZQHU9iSWRAvJwlEd4uY1zJB5qQkRuU/7fCuGtfobfRyjlTCOgc0
         0ZQtdjAIMbnI20iusEC0CCHLxyyVPdtbf5Rmykyu5rk0L7wCMYlL5C1CFu3LgajhoQ5k
         FDs+AP+mHRXzgU54tqszwonHAvciZ6DubvMDyjPK8oni/kapqH6cbhjVKA0WgvUd7Tyx
         +bog==
X-Gm-Message-State: ACgBeo2M3hjbB4bqA6kdhDe0FonzXrqiGc5q2TH5pTahmKTWiqZrR2+R
        hHKQtilmO6/ZPjo8PTsmRfZl11jaR+neVnVGJ+c=
X-Google-Smtp-Source: AA6agR6mQKT+8qybXjCS/+jRJabXAhyutX/JaN8GU1n3O7tgg0juo+fbdSfQyWB6w+kVUABbS8dUgR8xb7E9H6GGeZw=
X-Received: by 2002:a02:1d01:0:b0:349:d886:df1 with SMTP id
 1-20020a021d01000000b00349d8860df1mr6860680jaj.307.1661630757268; Sat, 27 Aug
 2022 13:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220821200821.1837460-1-lkml@vorpal.se> <2ddade8b-7260-8497-12f2-c8b13cf35e6a@redhat.com>
 <12a39cf6-1247-d2a3-bf07-51297e9b6640@vorpal.se> <CAGdLNWFYizajrM3X7ww_=Yz6DiA34-eGoRfE0r=388+t3OAhWQ@mail.gmail.com>
 <be56c117-a62d-e0b5-db50-71fda9c04f76@vorpal.se>
In-Reply-To: <be56c117-a62d-e0b5-db50-71fda9c04f76@vorpal.se>
From:   Azael Avalos <coproscefalo@gmail.com>
Date:   Sat, 27 Aug 2022 14:05:47 -0600
Message-ID: <CAGdLNWEqaONoJ0xqwPPg0+=YsTq+6yvjC_VG+JVwXoPXbeB5sQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] [RFC] platform/x86: Fixes for Toshiba Z830
To:     Arvid Norlander <lkml@vorpal.se>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi there

El s=C3=A1b, 27 ago 2022 a la(s) 05:51, Arvid Norlander (lkml@vorpal.se) es=
cribi=C3=B3:
>
> Hi,
>
> On 2022-08-25 19:00, Azael Avalos wrote:
> > Hi there
> >
> > Sorry for pinging in a bit late, been under a lot of work lately.
>
> It happens to all of us.
>
> > You can poke the Toshiba BIOS interface directly via /dev/toshiba_acpi
> > to test your findings, once it is ironed out, you can start making patc=
hes
> > for inclusion in the kernel.
>
> Interesting. I'm new to kernel development and I can't find where in
> toshiba_acpi.c this is implemented. Nor do I see any documentation for th=
is
> interface. I would love some hints with regards to this.
>

From line 2248 onwards

Here's a link to some documents you might find interesting:
http://www.buzzard.me.uk/toshiba/docs.html

The interface was introduced to the kernel many years ago, back when
the (char) toshiba module
was used, i just added support to the toshiba_acpi via ACPI calls

> For now I have been using the out-of-tree acpi_call module:
>
> https://github.com/nix-community/acpi_call
>
> Arch Linux (which I use) packages it as a DKMS module. Handy to test with=
,
> but probably really easy to screw up your system using it if you don't kn=
ow
> what you are doing.

The interface is pretty straight forward, you can make a small C prog to te=
st,
basically you just need to:
- Open the (/dev/toshiba_acpi) device for R/W (make sure you have permissio=
ns)
- Fill out the SMMRegisters struct with your query and get the results
- Rinse and repeat till you find what you're looking for

WARNING: This might (or might not) set your house on fire...

>
> > I know there are a lot of areas where the driver is lacking features du=
e to
> > hardware restrictions on the machines I had at the time, so it's good t=
o
> > see a bit more movement here.
> >
> > Cheers
> > Azael
> >
>
> Best regards,
> Arvid Norlander
>
> <snip>

Saludos
Azael



--=20
-- El mundo apesta y vosotros apestais tambien --

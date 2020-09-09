Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F2A262744
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 08:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgIIGiw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 02:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgIIGiw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Sep 2020 02:38:52 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D556A21741;
        Wed,  9 Sep 2020 06:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599633531;
        bh=0LICaIi3kq+D5+WUKy3euwWWHpUAdW91oDd8z/1M29w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jp57dpmvW6RZRQ/Q3ee2aYo1WyvA0CdonAJXWlPJFSp0DVEUUCfbbPIXfTZxR6JGZ
         VqlQfi9lr3LFljeT5/e9mqu6sVfXHM7pChjIhqtWS4LUcR+FwYDu4XYw3Vr98qqCXN
         D4ssE2HyRBcMKLnuclh6Rc7TwoXlAYuLXGAX36tQ=
Received: by mail-ej1-f43.google.com with SMTP id e23so1912938eja.3;
        Tue, 08 Sep 2020 23:38:50 -0700 (PDT)
X-Gm-Message-State: AOAM533KqA8vElnsAQVCOpYDuLNBE+QUdthanTF6qwnMHz9i0VepBXfD
        IvHouQn4Dovoqj4ZD5APg/tQWt6o64lEtVourZs=
X-Google-Smtp-Source: ABdhPJxu1LAZZBSbaQFerdoZWgfls+KYS5zgk5uAtWmk8I3aUMxP7E8uAOqPPoAgEXA7LSjdzyHKKC+Ud3xoRO4QS+8=
X-Received: by 2002:a17:906:82d1:: with SMTP id a17mr2112835ejy.385.1599633529441;
 Tue, 08 Sep 2020 23:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200908201319.3567-1-krzk@kernel.org> <20200908201319.3567-4-krzk@kernel.org>
 <af09a19d-3261-a1bb-4d38-e7f543648154@ti.com>
In-Reply-To: <af09a19d-3261-a1bb-4d38-e7f543648154@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 9 Sep 2020 08:38:37 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfPsbbo3yTe4bL+-V=9YsHnyeiZt-dd2psQZezFdqb9DQ@mail.gmail.com>
Message-ID: <CAJKOXPfPsbbo3yTe4bL+-V=9YsHnyeiZt-dd2psQZezFdqb9DQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] power: supply: bq27xxx: use BIT() for bit flags
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 8 Sep 2020 at 22:53, Dan Murphy <dmurphy@ti.com> wrote:
>
> Krzysztof
>
> On 9/8/20 3:13 PM, Krzysztof Kozlowski wrote:
> > BIT() is a preferred way to toggle bit-like flags: no problems with 32/64
> > bit systems, less chances for mistakes.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >   drivers/power/supply/bq27xxx_battery.c | 15 ++++++++-------
> >   1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> > index 2deac3fbb036..e971af43dd45 100644
> > --- a/drivers/power/supply/bq27xxx_battery.c
> > +++ b/drivers/power/supply/bq27xxx_battery.c
> > @@ -847,13 +847,14 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
> >
> >   #define bq27z561_dm_regs 0
> >   #define bq28z610_dm_regs 0
> > -
> > -#define BQ27XXX_O_ZERO       0x00000001
> > -#define BQ27XXX_O_OTDC       0x00000002 /* has OTC/OTD overtemperature flags */
> > -#define BQ27XXX_O_UTOT  0x00000004 /* has OT overtemperature flag */
> > -#define BQ27XXX_O_CFGUP      0x00000008
> > -#define BQ27XXX_O_RAM        0x00000010
> > -#define BQ27Z561_O_BITS      0x00000020
> > +#define bq34z100_dm_regs 0
> > +
> > +#define BQ27XXX_O_ZERO               BIT(0)
> > +#define BQ27XXX_O_OTDC               BIT(1) /* has OTC/OTD overtemperature flags */
> > +#define BQ27XXX_O_UTOT               BIT(2) /* has OT overtemperature flag */
> > +#define BQ27XXX_O_CFGUP              BIT(3)
> > +#define BQ27XXX_O_RAM                BIT(4)
> > +#define BQ27Z561_O_BITS              BIT(5)
> >
>
> It seems you have added whitespaces that you submitted a patch to fix in
> 3/7.

I shouldn't... 3/7 is different #define: BQ27Z561_FLAG_FC
Here it might look like not indented properly due to the patch format.
In the file, when applying, the entries are aligned correctly.

>
> Also squash 3 and 4.

Whitespace with BIT conversion? Sure, I can. These are separate places
and different types of cleanup, but no problem to squash them.

Best regards,
Krzysztof

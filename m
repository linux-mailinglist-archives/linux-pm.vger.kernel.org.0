Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 842C1EA925
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 03:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfJaCOI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 22:14:08 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43473 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfJaCOI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 22:14:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id j5so3233848lfh.10
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 19:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Q35Qrmg9wkHjqF+0NfAUFB1yR1/10F2WnVxGw+K294=;
        b=N8tiDiHdtPsksEd3ROvQIlUsCu82XyKi8Txes5hv3NlYMQZbCqlL/T3M4JbOxPTB6p
         Oq/yIeAjAo9+HB+fMGZ6zuqkmSpCcV4SxxtB8D2Y3oRX5PP/DLtTo7oA6KRWgh7d7tGg
         uoZfrZvshqP8jjpzk5bcYJy8IthFfjxU/1WOK0wjpq41r5hr6VAtOd+SsBxLR8h3JSqf
         vrQbaNrCk1CaKOl+KtMakLELlr3Zs83OW+3ybUkkLdS7/HeN1EsmfBWp0esMiyPD0KXv
         RSAKHz+ftDKOoHI3JrnHrJ51GL2khuEKu/X7vXg6lkd8ZM4wECJzM96VL9A5BAzeYJJG
         7joQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Q35Qrmg9wkHjqF+0NfAUFB1yR1/10F2WnVxGw+K294=;
        b=bRTF1ImIF1u9v7d1DDYiW4KswbOWzfwvgZwj5yrpcfl8BUANbvoaeH6XwilKXcyZEs
         bnyjhphijAs+y/9zLD9Cs6n3sGwk7HAkeGIhyhy75ljXm7aYE5e/hkST4IdcKEAjgXdZ
         UTzF+mZhstPQbV1wsh/XMygUuMgX7QIAvu02J36c+XsG39AM5QETFvSOP8ALPL9P8eZc
         NKOLuZZRbxMfxBOjjtLO61YaOmN7CLh5zW+iKICIOisPcJjv8WF+kRkwkfmqwYAVo6FX
         yjEz7DO2iNEPX5Efzv1rkBkfF42NJkg6wSh8tC/+IwqfA+8oI96R+2K73SCIQ9jsJS3P
         UB9w==
X-Gm-Message-State: APjAAAWhOMZM/feC9VWauArpU5IvACNXp1sNKMCxbLy504rBhTCOC16d
        Vq/rpFg1e7x7/Xg/Ydx3/nyAYkk0UkmrEy94S2fGXg==
X-Google-Smtp-Source: APXvYqzt5GwVr8iqs7GK09m3Y5rMVOPcTeuhfSQpo73+hoiTYTRcTwHFX7BcTFNYVFr1DATKDchziDslGCBtc8/XWKc=
X-Received: by 2002:a19:911c:: with SMTP id t28mr1004590lfd.84.1572488046183;
 Wed, 30 Oct 2019 19:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1572245011.git.baolin.wang@linaro.org> <44f0c19510c7317cb4ee6cac54b3adfa81c2d6d0.1572245011.git.baolin.wang@linaro.org>
 <20191030143814.GA14919@bogus>
In-Reply-To: <20191030143814.GA14919@bogus>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 31 Oct 2019 10:13:54 +0800
Message-ID: <CAMz4kuKYTHWaRnYhFn2kNzv04g_pWTVqPXvRqwO78htJ9jAnFg@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: power: Introduce one property to
 describe the battery resistance with temperature changes
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        baolin.wang7@gmail.com, Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On Wed, 30 Oct 2019 at 22:38, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Oct 28, 2019 at 03:18:57PM +0800, Baolin Wang wrote:
> > Since the battery internal resistance can be changed as the temperature
> > changes, thus add one table to describe the battery resistance percent
> > in different temperature to get a accurate battery internal resistance.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  .../devicetree/bindings/power/supply/battery.txt   |    5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> > index 5c913d4c..1a6f951 100644
> > --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> > +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> > @@ -35,6 +35,10 @@ Optional Properties:
> >     for each of the battery capacity lookup table. The first temperature value
> >     specifies the OCV table 0, and the second temperature value specifies the
> >     OCV table 1, and so on.
> > + - resistance-temp-table: An array providing the resistance percent and
> > +   corresponding temperature in degree Celsius, which is used to look up the
> > +   resistance percent according to current temperature to get a accurate
> > +   batterty internal resistance.
>
> What's the order of values? The description and example don't seem to
> agree unless negative percent is a thing.

Ah, right. I will fix the example according to the description's order
in next version. Thanks.

> >
> >  Battery properties are named, where possible, for the corresponding
> >  elements in enum power_supply_property, defined in
> > @@ -61,6 +65,7 @@ Example:
> >               ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
> >               ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
> >               ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
> > +             resistance-temp-table = <20 100>, <10 90>, <0 80>, <(-10) 60>;
> >       };
> >
> >       charger: charger@11 {
> > --
> > 1.7.9.5
> >



-- 
Baolin Wang
Best Regards

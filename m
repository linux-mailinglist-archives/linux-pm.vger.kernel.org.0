Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB4A73C09C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 02:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfFKAbi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 20:31:38 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51983 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbfFKAbi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jun 2019 20:31:38 -0400
Received: by mail-it1-f193.google.com with SMTP id m3so2079635itl.1;
        Mon, 10 Jun 2019 17:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q+q3Jj3P/wEz9k/LF4yrVB0MK2jEr9dEeFUcbQlT9GU=;
        b=CM1dORqYQM2ipZY5oNybwUIL0KwgNjOfk3Kl9w/DhBKo+wCV0ASGN04Aldq+1SFYEZ
         f7Z4ShsaN/iJWjjkk5Cl3KNdcEyHieX6OWgehxxLgNbB5pOywJze2bolQ2YNJE3LdaLb
         PxlJqhya+6Gpxp31XcWLiPhkcZpqOPX6SFVoeGIwzINHyJJtFKXSnJCC7WyLMOjaIj5s
         RpHe9ZUI8OK9VnFGNRhbf4KXQW8X5NUhdecDum9jGxDBZd8Hl6P5/hQeJHrO8KKTqVqf
         7jGD4MOHYffF0q+VQy/peMbOSabL586+xGRU6Mm3I3xA2SbhnkN9uceHdeI2VKSxhfbS
         cDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q+q3Jj3P/wEz9k/LF4yrVB0MK2jEr9dEeFUcbQlT9GU=;
        b=IPxAK5Q0KQesn/zOzoUkTsFEC7wUfIpWgK+2JeiTR8wqtFCAtf/aUI+mBEqri5xa2g
         sIoh344MxUmmVdU6kv+z5OuuAGSIXlgHqUdCqmzhafhMQLZKTXpJtSFnURv9XeliY7Xn
         0Gvo7SqAq34uzZeZE0MxZG2GeZFkfVxf6Z2+8uMedzpfRWy5Dd1cmSM7A/i5D1EHGtOx
         E6YlBGXd9Bb87iFH9IpQ6eX1Zryf3OmuZDJHTc8xk469AhWrKksHXd/HhO5B26pnZ4wr
         voByfDdBshOfv7pCFecQkWdqjqg/8OQzTvYnkQ38WPfpPuabzj19NEb5lC0jfjpzTsAn
         f5gA==
X-Gm-Message-State: APjAAAVrZ8WWy0V+KCXobUpQ/9mEiTy7NnBQVs3R2P2qdXGd4gAsuSqV
        mtm7eag/MQhKrGiR6qHNDLdl8FgcDvV7BjrSW48=
X-Google-Smtp-Source: APXvYqxNggVVfpV5Krk5yzsxhZtB5DI+b0F9entbVHlyJw8x1NfRB+IUQrtXUmQsrDzcxija2zLnc+hUajb+QOgYt60=
X-Received: by 2002:a02:8816:: with SMTP id r22mr30641561jai.60.1560213097226;
 Mon, 10 Jun 2019 17:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190525181329.18657-1-tiny.windzz@gmail.com> <20190525181329.18657-2-tiny.windzz@gmail.com>
 <CA+E=qVdh1E8Y7dZO0JSS4DJE2bo=98MuSKRt7nmeFg-td7Ua9Q@mail.gmail.com>
In-Reply-To: <CA+E=qVdh1E8Y7dZO0JSS4DJE2bo=98MuSKRt7nmeFg-td7Ua9Q@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 11 Jun 2019 08:31:25 +0800
Message-ID: <CAEExFWtjNridLsMXOnBe2mJOPhUOYJ6G3wGF3gx=0oQoQROOGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] thermal: sun8i: add thermal driver for h6
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 11, 2019 at 7:29 AM Vasily Khoruzhick <anarsoul@gmail.com> wrot=
e:
>
> On Sat, May 25, 2019 at 11:17 AM Yangtao Li <tiny.windzz@gmail.com> wrote=
:
> >
> > This patch adds the support for allwinner thermal sensor, within
> > allwinner SoC. It will register sensors for thermal framework
> > and use device tree to bind cooling device.
>
> Hi Yangtao,
>
> Any plans on v4 of this series?
>

I am waiting for comment from Maxime.

I=E2=80=99ll support both h3 and h6 in v4.

Yangtao

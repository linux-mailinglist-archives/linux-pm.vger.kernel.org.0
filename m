Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5F1F515F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 11:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgFJJoV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 05:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgFJJoU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2020 05:44:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5807C03E96B
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 02:44:18 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so1638226ljc.8
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 02:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svyjfmEJc3+r5Bull8lSuu/qgDN2rTAndZ5rJi9Ba2o=;
        b=AMgNG3LbXSbZD6eBl2/IEceHF5cilPgFw2K3RxPXAl8WAyTiHclajD38G1Tc2Q7IIL
         JSAl5vPSokAFzuD6dghWzOBP8VQeaIBnEhmG7l6DbIj5XLzYlaKFxl68kpyO7qxTJuch
         Oknbf4oKQ2BxCbsKbeM4DVYh+BL5fS+J3SitSurgrSviegmUdN1RTWASwgL5E7dK3Eea
         ftChCFiQWkpFaq8mqhE2kLdcsDJoZmen1UBhmI1jCJ/cSLyTijZ0xSpCTHcX9e5qpBOV
         KK4npBNbzohL21ccWphgOTo20/ZK6StWglohLHKmhPuVh27p5gBk18RwPFlLeJWaHDQQ
         dH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svyjfmEJc3+r5Bull8lSuu/qgDN2rTAndZ5rJi9Ba2o=;
        b=Rexzc29kEukEA/r9Pzz1H80PIAX3R+nI026MmDBlmtkFqd9sI0WOIiPuViy4XDtEeI
         4rZBQu/z8JdGWPJohWTrD8fSN33J2G3QGR8jigzzFuz0CjyPSDBtANy4wpg5xk3XqbV2
         Aa7vfEf9snQJwX7T0mRPURzEbiYZTKytBVL63tK7nL4ancAkjgmZFIeOqnKN6/o1w3cI
         VW4dx82DYSvLj1thViR5SDlbcIwz86gDC8J8q3EOybFSC3P+jL5Yxec7t+xy8jRU+DH5
         eFoHs5jDAQrTDy+pn3m10rXSGKQ+0RJdkmO0KWbUYI/ctu/SWmqLfEHfYj7ZEgGn0lv/
         UN/A==
X-Gm-Message-State: AOAM530blmxUWcKNURNJYI8LAirG9Bk0aEGe47SfrWK8YIU7BW2z+DUl
        KmEInogWHYnkGecLv4tcXjxCzEANyA0Un4NVIDSNPw==
X-Google-Smtp-Source: ABdhPJxUjW4GtVDMwGhimJkXUwNvX7Tr9JwCOPxfrbQrulwUS0MDRdszf4lJ44i0EOIMa/Nnos4vHOhpiJdziWPCCqs=
X-Received: by 2002:a2e:350a:: with SMTP id z10mr1266313ljz.104.1591782257094;
 Wed, 10 Jun 2020 02:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200605224403.181015-1-sebastian.reichel@collabora.com> <20200605224403.181015-3-sebastian.reichel@collabora.com>
In-Reply-To: <20200605224403.181015-3-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 11:44:05 +0200
Message-ID: <CACRpkdY4RzgpGg-dCSJet-es39bmC7KNxxCjma_mgjpUzVTvKg@mail.gmail.com>
Subject: Re: [PATCHv2 2/6] power: supply: gpio-charger: Make gpios optional
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@collabora.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 6, 2020 at 12:44 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> While strongly recommended, not all devices have a gpio to
> detect if the charger is connected. This moves the 'gpios'
> from required to optional section.
>
> This also modifies error handling for the GPIO a bit: We
> no longer fallback to pdata, if a GPIO is specified using
> GPIO descriptor tables. This is a bit cleaner and does
> not have any real impact: There are only two mainline pdata
> users (arm/mach-sa1100/collie.c, arm/mach-pxa/tosa.c) and
> none of them specify the GPIO via gpiod descriptor tables.
> Once both have been converted the driver's support for
> specifying GPIOs numbers in pdata will be dropped.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

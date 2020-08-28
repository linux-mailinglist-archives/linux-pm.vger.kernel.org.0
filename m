Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DB0255A99
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 14:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgH1Mvw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 08:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbgH1Mvf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 08:51:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3861C061234
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2020 05:51:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v12so1150086ljc.10
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2020 05:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RSrvv0FJmitf6q9JxmYipGO4Y6PZy6cFkX1VzqR3xEU=;
        b=Pf4uaxGE3D9QkcwZ3m7v40UpPYGsLMXlPXzxXdofFxgCOrudLrDJjKqDtapXdZT1me
         U/qpgdyHur4b2ylpfOmLYfGRbbgioYR4DE8hUX9n3OD1PsJjx4bY6DfOPPLZ+nR7uoPR
         t2fPwIQzvGmoNipg0tib+zvmAuyzH0asX7NHoXYzOS+c1S9GjWZHK3ZfK4tTEAShELZn
         UQgYkmIIjXX9+QwSVHsgwAXyE2t1Y98bukfmK6CGzaKFvQbixk0LvK3eWs+XS6UxLeZr
         H6WwkkQfXpaJarmhsieD/FOJieotOGDuhvpWyJnLOHQ5bvJH2PkEoyOghCRX7loqwBdo
         Wlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RSrvv0FJmitf6q9JxmYipGO4Y6PZy6cFkX1VzqR3xEU=;
        b=L0mjhzdiaVjrAqegNguDDsWs34Hqs0C/S6xug71ErBlNDdtgEMeBLyUbx+9MhqHPnc
         rkAEF0Pt8f/QPNVbFU34o7KOj3zEM8uWsLbjc8UEG+ElsbfePBSVy3Hr9HEif36UXSNy
         R05DcTdvzafpOXFMfGH5FjjNLuPYFk3VpIRw8W1DMYWHRmcpBdu41ixjg2MGDre8sQmc
         3O+3nfU+Nn+CSa7EVivtn2ibfoYntiQHVzBqTyki5skldlahBAopC4LrRi3oYoegcq7Z
         g1fL1z8pXQRRlNPfSoJSf6TQ+mQKGq6S4OUB4EE6+VewyE9snb4Q1ck1Y0Z+yK7vIzcp
         44eA==
X-Gm-Message-State: AOAM531Ed3a6Svq5Lnc0AJfRBRMdwl5kHjo7jaG/8ty9+OsGwgnQBYMW
        ONMvg4Xn7UrZDuTfwBY1ENOzOu/6nWOJbE1qWAkumg==
X-Google-Smtp-Source: ABdhPJzTyH+jeLvxiBsauaVxTH5hij7/x8BNA+Ly/857QQXdScYFOsf9kjoayIwSsdP0TIKRwlItOzGM4zkgBEGoiX8=
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr872506ljo.286.1598619091424;
 Fri, 28 Aug 2020 05:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200825193536.7332-1-krzk@kernel.org>
In-Reply-To: <20200825193536.7332-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 14:51:20 +0200
Message-ID: <CACRpkdb4j2kJvpY23G-os9gTktZW5HT287MsvMZxC=ovgn_9LQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] dt-bindings / arm64: Cleanup of i.MX 8 bindings
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 25, 2020 at 9:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> This is a v3 of cleanup of i.XM 8 bindings and DTSes.

If you are going to be working a lot on Freescale SoC code going forward
I wouldn't mind if you could add yourself as maintainer for the
Freescale pin controller and GPIO at least, I already have high trust
in you in general so if the Freescale maintainers also have that I think you
should just sign up as maintainer. This makes it easier to do pull requests
and things like that.

Yours,
Linus Walleij

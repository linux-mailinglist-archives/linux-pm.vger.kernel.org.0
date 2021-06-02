Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E250C39943F
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 22:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhFBUIJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 16:08:09 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:41937 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhFBUII (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 16:08:08 -0400
Received: by mail-ot1-f44.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so3574392oth.8;
        Wed, 02 Jun 2021 13:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eqg/NhAI7hbUorU0sneYRdLeG0QUON8FK2Nid9hN1UY=;
        b=VJSmbYP3HrQKqbOzjw3tpJjFjGkz61G7E0Wuyulqx7ljopCAyYQ1TkDsHiApCi2M5n
         MYI57o9brvzNrMFGgsXjy58Ff4eB57diI5/D3B9m2lexq9ixRxZzqkiXo15OyK3lZLka
         Dqy8445nnJqOBZoAmoovQ9qtRq3McP/J7J0j/y3ct9FNrlPocnVIwvC8EqHkqYA7DB8l
         2aWxwia4N+wMkCPbJXgYF9gtpomNc5dHcXUtiNUb9z2uVKOHhtCjwOixJMo5yRpR7iKQ
         Z3aQt/pd/rbTZWfXuPXXINdCu80dmK6ar7LWcSs7l3GF98DweiYpLmyz68qgW6VsBYHV
         tnwA==
X-Gm-Message-State: AOAM5314IrOlteVIYirBQpnNAbfiG78TzugS+N+DEyRcJGuPuV66nsIw
        slaRP9+w/fULxl5Hbpwzuw==
X-Google-Smtp-Source: ABdhPJwOOhWiTlBUVMkgdreVunVQq9Th2V0p/jeTk68tZ2BCDbzX7OWLgT1+YDeOhvnir4cNa8WV0A==
X-Received: by 2002:a9d:6194:: with SMTP id g20mr4537073otk.8.1622664371257;
        Wed, 02 Jun 2021 13:06:11 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i9sm189166oog.17.2021.06.02.13.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:06:10 -0700 (PDT)
Received: (nullmailer pid 3900234 invoked by uid 1000);
        Wed, 02 Jun 2021 20:06:09 -0000
Date:   Wed, 2 Jun 2021 15:06:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 7/7] power: supply: max17040: Do not enforce
 (incorrect) interrupt trigger type
Message-ID: <20210602200609.GA3900200@robh.at.kernel.org>
References: <20210526172036.183223-1-krzysztof.kozlowski@canonical.com>
 <20210526172036.183223-8-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526172036.183223-8-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 26 May 2021 13:20:36 -0400, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Interrupt line can be configured on different hardware in different way,
> even inverted.  Therefore driver should not enforce specific trigger
> type - edge falling - but instead rely on Devicetree to configure it.
> 
> The Maxim 14577/77836 datasheets describe the interrupt line as active
> low with a requirement of acknowledge from the CPU therefore the edge
> falling is not correct.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Iskren Chernev <iskren.chernev@gmail.com>
> 
> ---
> 
> Changes since v1:
> 1. Remove the 'flags' variable.
> 2. Added ack.
> 3. Rebase - the bindings were converted to dtschema.
> ---
>  .../devicetree/bindings/power/supply/maxim,max17040.yaml      | 2 +-
>  drivers/power/supply/max17040_battery.c                       | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6970B3EBC09
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 20:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhHMS1S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 14:27:18 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:46957 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbhHMS0z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 14:26:55 -0400
Received: by mail-oi1-f179.google.com with SMTP id o185so17106008oih.13;
        Fri, 13 Aug 2021 11:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WYCNoGBght09bQuIXOlTFX4QMjS4tFI3LYNWjVBrRhU=;
        b=hhEywIJ0R/6LtGNSnrA983xWCAWCObIg1oe5dZmPmUfQmZoKw9xFppEJTMqjDBALFb
         c471HZVry1FS+YFshjFkO2t5/sjDIwxQbrWK5JfJyJtrOJGR17y/VYlcfZ/i1+Wda55X
         l3Glwendck7yhTrngVF7iGXkN7rI/DJ5JN0OoT1GDxUjlpoBIkJP68ofXWXfbNeDrKFb
         5gw49l6av7jFc+AvI+YovuzA0Y+5yrFZTSOrpzgCYMAifxjUM4KwK0v3XPQHI7P2pi1Y
         Xya64RoOK4SASnkRj/v1fvJYAzOUykSnp5yvdBw9Ib9ir2sKfXe/x1pcaYcxEndpsgpA
         6ttA==
X-Gm-Message-State: AOAM533McIdWbukVeof4bMJ9OPUBesHzSIDm+dTy4zG7utHspPvwT0HR
        cwnf6cFhgWxg24ZPV8Fjzg==
X-Google-Smtp-Source: ABdhPJz7SjpVK76kUR4gQAgTEtBgkp19NbC2fnCO5DFhgE88OHm6uT0GPS69jiWRjUAvMCOl3dAr3Q==
X-Received: by 2002:a05:6808:105:: with SMTP id b5mr3070659oie.42.1628879187967;
        Fri, 13 Aug 2021 11:26:27 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j125sm501170oif.53.2021.08.13.11.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 11:26:27 -0700 (PDT)
Received: (nullmailer pid 3810108 invoked by uid 1000);
        Fri, 13 Aug 2021 18:26:26 -0000
Date:   Fri, 13 Aug 2021 13:26:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] dt-bindings: power: Extend battery bindings with
 type
Message-ID: <YRa5UnBcmW1KBIEd@robh.at.kernel.org>
References: <20210805085828.3451909-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805085828.3451909-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 05, 2021 at 10:58:27AM +0200, Linus Walleij wrote:
> This adds a battery-type property and bindings for the different

s/battery-type/"device-chemistry"/

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> "technologies" that are used in Linux. More types can be added.
> 
> This is needed to convert the custom ST-Ericsson AB8500 battery
> properties over to the generic battery bindings.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Add devicetree list to Cc
> - Use "device-chemistry" instead of "battery-type" as this
>   has precedence in standards.
> I need a bunch of new bindings for switch the STE AB8500 custom
> bindings out, but I need to start somewhere, this is as good as
> any place to start.
> ---
>  .../devicetree/bindings/power/supply/battery.yaml  | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

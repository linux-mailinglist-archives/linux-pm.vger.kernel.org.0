Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72CC27D6C5
	for <lists+linux-pm@lfdr.de>; Tue, 29 Sep 2020 21:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgI2TVF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 15:21:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35106 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgI2TVF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2020 15:21:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id w16so6731933oia.2;
        Tue, 29 Sep 2020 12:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SUR5scLDsJhjFKXPnLX+1dUuyJgwuMw41ZKcdTZmVpo=;
        b=W/B4mOsg6soUKAVAGA+nBBoBG1XgCNDwHYBKRIPeUP6ML0vHLDdMSrnIpuGFiVCBgm
         TXzCOgVh7eg2imGOsvsreJJ5+BLYv9sUbagdlqHl+JIUyw7HdpdKt+MVY0PQ4p/smkyJ
         TOQoiZRtF95zuQfjeORzBm2UbgwyuGgni+Y7HJn/wa4fg/so1o6PQHpPHMpBlCWVGfXi
         49MuCh/1/r92tvKMnh0b82WOvmdC9+EGB2goaDofO4XzSGtKa6fGy3z05hOJtavU9q8L
         PEN588Q1fWfOtd09ciqD374i6MTUy08kxXV5nNSvEaQ9XYopgZd4mZrSQAhCkTogQbmI
         PHcQ==
X-Gm-Message-State: AOAM531QCxIVLrlS+Xqj1S/GRyOUgLEIhqZ0eCpQ/ZGYzAUyJIJdisWo
        FXXDNfNvYEIJbnqhp252jrDMcoeyvWcgX0w=
X-Google-Smtp-Source: ABdhPJxnA6zAMV/ZyCIPCi2WRmyQeg3SBL397Tl33WvvOvstOpFxVQ6HqejiHv9rV0GBbBQSSLNAxQ==
X-Received: by 2002:aca:b143:: with SMTP id a64mr3449292oif.149.1601407264031;
        Tue, 29 Sep 2020 12:21:04 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f26sm1202204otq.50.2020.09.29.12.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:21:03 -0700 (PDT)
Received: (nullmailer pid 1002393 invoked by uid 1000);
        Tue, 29 Sep 2020 19:21:02 -0000
Date:   Tue, 29 Sep 2020 14:21:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: power: Convert ingenic,battery.txt
 to YAML
Message-ID: <20200929192102.GA1002337@bogus>
References: <20200926173529.25238-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926173529.25238-1-contact@artur-rojek.eu>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 26 Sep 2020 19:35:28 +0200, Artur Rojek wrote:
> Convert the textual documentation of Device Tree bindings for the
> Ingenic JZ47xx SoCs battery to YAML.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
> 
> Changes:
>     v2: move introduction of new compatibles into a separate patch
> 
>     v3: - drop description of `io-channels` property and set its maxItems,
>         - remove redundant quotes in `io-channel-names` property,
>         - drop `items` for `monitored-battery` property
> 
>  .../bindings/power/supply/ingenic,battery.txt | 31 -----------
>  .../power/supply/ingenic,battery.yaml         | 55 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

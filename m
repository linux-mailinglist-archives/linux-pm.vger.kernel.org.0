Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DF13EF5C1
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 00:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbhHQW2t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 18:28:49 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:35796 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbhHQW2t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 18:28:49 -0400
Received: by mail-ot1-f48.google.com with SMTP id f16-20020a056830205000b00519b99d3dcbso367206otp.2;
        Tue, 17 Aug 2021 15:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yqBt5Rgo6x3qOVwQ9RpTYru0Ol+9vLDtDZYPvLG/Nso=;
        b=TZT6R870sFvsqAY12y6nGjUXmKVqDUSboUBohUbcj5Nb8LIvs5KlYHat6epGU12NLK
         sLLk7MA9qX6wEMvopNep2oppVxCoKQwAFT0eraxTMA41OGNbhU/FfPjHNe2e1/5jBZKv
         vH3HjdB8WZV8dvDXN4CCVC1y++6sFDl4NAJzbyv5XvKsYNKYIzdVscevYmw+Cz3WK44j
         pQ6tMswkLmDU1x6zyhp8PJIBfvsAgpUs12U0HeiMzNclL8vqEVCaPohmZ9992F9QKmwN
         VPJooWlrN6Q7BZter7qMvzZRfgjPkZ04UuQyVLZ2cLeoW0VIN9SNz16Dt31twyZTQFE9
         J4MQ==
X-Gm-Message-State: AOAM532VBGs2bcW2SPk4BdQDxKe3dzixWu6AkKe2D+3vRnmezf0dxQjS
        6ClEuJHMNd+T0LgKaiwvfQ==
X-Google-Smtp-Source: ABdhPJyxHYPltWfKk7mCAVYciyfTMzbKZ3rwbDA2cQ+BEc2np0c9ZJ016LaffgB99T8qWfF0kFBERg==
X-Received: by 2002:a05:6830:33c9:: with SMTP id q9mr4303965ott.170.1629239295491;
        Tue, 17 Aug 2021 15:28:15 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d26sm702902oos.41.2021.08.17.15.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 15:28:14 -0700 (PDT)
Received: (nullmailer pid 952015 invoked by uid 1000);
        Tue, 17 Aug 2021 22:28:14 -0000
Date:   Tue, 17 Aug 2021 17:28:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sebastian Reichel <sre@kernel.org>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Subject: Re: [PATCH 3/3] dt-bindings: power: supply: max17042: describe
 interrupt
Message-ID: <YRw3/jDApVGFBfxC@robh.at.kernel.org>
References: <20210816082716.21193-1-krzysztof.kozlowski@canonical.com>
 <20210816082716.21193-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816082716.21193-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 16 Aug 2021 10:27:16 +0200, Krzysztof Kozlowski wrote:
> The Maxim 17042-family of fuel gauges are often embedded in other Maxim
> chips, e.g. in Maxim 77693 which is a companion power management IC.
> In such designs there might be actually two interrupts:
>  - INTB signaling change from charger, flash or MUIC,
>  - ALERT signaling change from fuel gauge.
> 
> Describe the interrupt in bindings to make it clear it is about the fuel
> gauge ALERT interrupt, not the INT.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/power/supply/maxim,max17042.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

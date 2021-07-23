Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D172B3D4293
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jul 2021 00:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhGWVXA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jul 2021 17:23:00 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:33492 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhGWVXA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jul 2021 17:23:00 -0400
Received: by mail-io1-f48.google.com with SMTP id n19so4374449ioz.0;
        Fri, 23 Jul 2021 15:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AG9HST+VmRNN7mDWizk+56uFcAglFaTzlSnP4i69NME=;
        b=TnVQ4MNddDsgG/5jhMDqRGDxVWOo7eXf0dLZfSW8GPnozrUSldylurFgZ89fMwODLB
         +Epuklb3iDkEviBjxDo0JPZlJL+Na5PPSygAmJY+PA5k9mP7pmjY960qdN4KcuI/meR6
         pTooA6XZDviiRk29AGDh+bwokeDI96RPWwjXWejLIF6osD02PIgdhpCIAapEMK32e0sU
         ZKoRNuC9+EF51CtTKeycOeabEeZIwrHZDwP+XP7mQ1sL6tceRcKlXzr92S+I0uwdIIVz
         HnfONS6R9BSsE+qu4Yr/UBAHqFc59LBtjJTY/mSOW4oaeutv+5i7oq7eBloocb3fyYHr
         +c8Q==
X-Gm-Message-State: AOAM531e+jccgbTaqE6oedm07ff1AN7wzETUt36l5HF+66R306UcDbU2
        2DL+D5vMR5wQsl+qjmgwCQ==
X-Google-Smtp-Source: ABdhPJx2MS0NQwXYC/4FgdBAY4Q3UTxSuY01xz1RfJQgN68ELkLp8IeRZNQyA6G4YPyCEu3CNsnoQg==
X-Received: by 2002:a6b:f41a:: with SMTP id i26mr5499553iog.162.1627077813090;
        Fri, 23 Jul 2021 15:03:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l5sm18668729ion.44.2021.07.23.15.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 15:03:32 -0700 (PDT)
Received: (nullmailer pid 2674964 invoked by uid 1000);
        Fri, 23 Jul 2021 22:03:30 -0000
Date:   Fri, 23 Jul 2021 16:03:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 33/54] dt-bindings: thermal: Make trips node optional
Message-ID: <20210723220330.GA2674905@robh.at.kernel.org>
References: <20210721140424.725744-1-maxime@cerno.tech>
 <20210721140424.725744-34-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721140424.725744-34-maxime@cerno.tech>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 21 Jul 2021 16:04:03 +0200, Maxime Ripard wrote:
> Even though the previous binding made it a required child node, the
> implementation in Linux never made it mandatory and just ignored thermal
> zones without trip points.
> 
> This was even effectively encouraged, since the thermal core wouldn't
> allow a thermal sensor to probe without a thermal zone.
> 
> In the case where you had a thermal device that had multiple sensors but
> with enough knowledge to provide trip points for only a few of them,
> this meant that the only way to make that driver probe was to provide a
> thermal zone without the trips node required by the binding.
> 
> This obviously led to a fair number of device trees doing exactly that,
> making the initial binding requirement ineffective.
> 
> Let's make it clear by dropping that requirement.
> 
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

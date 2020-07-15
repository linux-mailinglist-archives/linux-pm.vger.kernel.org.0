Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07D5221510
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 21:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgGOTZC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 15:25:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46170 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGOTZB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 15:25:01 -0400
Received: by mail-io1-f66.google.com with SMTP id a12so3449501ion.13;
        Wed, 15 Jul 2020 12:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Av/nglgHYTh4wCaoP+Mdg19AlGfKhVEQACet9eEyJ+U=;
        b=ENzIjbEPTEAOs/mVh9Mgj/UD7L6Mu5j8JV6+6Tl8DemAF0+1h4jox/8Oh0xHPU32Mr
         TgM9Jb/zjNBtj+Cybw6AB2PNDYwZfReWDH6piNFVKPjvd/yQg0yflllsT4djnAFKxsCa
         m3MltFcv0OVwpblwrPjL56dBjoNPjdH32ORenLusGhEOvxSr4ZfljoJJXh5ll4e7YpEB
         GQFJe5jm0/dpUQCEZYWsakQYKGp1LaT4I1M35jPjhLY5XQovr/uMaPgev90gXPEMA3sV
         kKtUPgUrqOdXEsOg1ZSwhqZWN8qShd62cSelktBF1p2UvhuvOI5934FYd8ceDkBsW4Ea
         YiqA==
X-Gm-Message-State: AOAM532FFEBIlA9oKOUDT6XLluz5nzVbZYvG3ar1XuPIJIEf9T9ewTlB
        fU9afL5Uy3LWkLF1Hxy1zQ==
X-Google-Smtp-Source: ABdhPJw+JKckZiWMOAV6s9bN5tbPRf6zRYcACbF2Zulp6ybuwhWjrcZ19V/SLqi1V5XEy8mp37hBFw==
X-Received: by 2002:a5d:97d3:: with SMTP id k19mr844652ios.45.1594841100862;
        Wed, 15 Jul 2020 12:25:00 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d6sm1569647ioo.9.2020.07.15.12.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 12:25:00 -0700 (PDT)
Received: (nullmailer pid 679381 invoked by uid 1000);
        Wed, 15 Jul 2020 19:24:59 -0000
Date:   Wed, 15 Jul 2020 13:24:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: rcar-thermal: Improve schema
 validation
Message-ID: <20200715192459.GA679343@bogus>
References: <20200619151541.15069-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619151541.15069-1-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 19 Jun 2020 17:15:41 +0200, Geert Uytterhoeven wrote:
>   - Document missing "#thermal-sensor-cells",
>   - Factor out common required properties,
>   - "interrupts", "clocks", and "power-domains" are required on R-Mobile
>     APE6, too,
>   - Invert logic to simplify descriptions,
>   - Add "additionalProperties: false".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../bindings/thermal/rcar-thermal.yaml        | 53 ++++++++++++-------
>  1 file changed, 34 insertions(+), 19 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

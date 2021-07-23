Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81C43D4284
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jul 2021 23:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhGWVTY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jul 2021 17:19:24 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:33613 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhGWVTY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jul 2021 17:19:24 -0400
Received: by mail-io1-f49.google.com with SMTP id n19so4365433ioz.0;
        Fri, 23 Jul 2021 14:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zj3L7NFzU7ezgh9ad48lDD8IT/Zy14uC554qOLnwFpM=;
        b=kQ8hhGAnZpmVyws/ls5phjVYxoTDdp+Dr15uCeRvFdRD5BpIBZn4yy2J9c1ff1bhER
         T4fPhAaO9hCOxU1aTA4CwiWpk2g41aOhX40zrYtXCqVsxipKWQCpf5Ge99wePVkFtDwA
         VD/p+EGXcL9bwlJ3scsoTM+mPFoHjsKx0n89M+HSYCx/4xIcX9Qj0d7JAGfUUPh7iKBJ
         RieTKgeQ+Z5B5OD58Fw0iJHwgw24gSeEp1pJuVhcChSJWgPfUtsJ4Y5J7qmmLG8Fy4Ih
         O6ENy+DhB/nGdZIMPj8kEU2mTAiCeWu88esZTj5hQrb9aLRBrk2LOqTLaBNuvgiWBVQ9
         J/xg==
X-Gm-Message-State: AOAM531vI59XNZD4K/CnwnYDFenLhWDNcoD/6RnDtDjAKEtvx9GAYKpv
        G+UlV4M+PvCOQcdVJ2M95A==
X-Google-Smtp-Source: ABdhPJxK2WlSCSjXM0ZXZ7Vy4wp1djvaNOJaskErZAsKf9D3zMNHes13AAs2JsQdRbQdvFS6GOxt8Q==
X-Received: by 2002:a02:90d0:: with SMTP id c16mr5841576jag.106.1627077596906;
        Fri, 23 Jul 2021 14:59:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l18sm17108643ioc.13.2021.07.23.14.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 14:59:56 -0700 (PDT)
Received: (nullmailer pid 2668852 invoked by uid 1000);
        Fri, 23 Jul 2021 21:59:53 -0000
Date:   Fri, 23 Jul 2021 15:59:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pm@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 28/54] dt-bindings: power: supply: axp20x: Add AXP803
 compatible
Message-ID: <20210723215953.GA2668818@robh.at.kernel.org>
References: <20210721140424.725744-1-maxime@cerno.tech>
 <20210721140424.725744-29-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721140424.725744-29-maxime@cerno.tech>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 21 Jul 2021 16:03:58 +0200, Maxime Ripard wrote:
> The AXP803 compatible was introduced recently with a fallback to the
> AXP813, but it was never documented.
> 
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  .../supply/x-powers,axp20x-ac-power-supply.yaml    | 11 +++++++----
>  .../x-powers,axp20x-battery-power-supply.yaml      | 11 +++++++----
>  .../supply/x-powers,axp20x-usb-power-supply.yaml   | 14 +++++++++-----
>  3 files changed, 23 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

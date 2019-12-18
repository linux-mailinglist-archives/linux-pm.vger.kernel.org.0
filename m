Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A56C123CF4
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 03:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLRCMX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 21:12:23 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32902 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfLRCMX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 21:12:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so428431otp.0;
        Tue, 17 Dec 2019 18:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+JPIypBT296WwLk8CC4vkpVgQTqPJgSPUkCzgyjmxMA=;
        b=X1Y8vbQGN/0YQgfIN7etVR1CMdF7taiohtRAVXQowI09GKuNKB0oBrZJRSJ2KsDjtp
         SuLcjyZn4EuT7QAo9vID2iidcdFgWzs2RE4vYCAziHiiVcW8WJcA3f7m/r3fUdNaxjzC
         ycT3nBWnKlQ1FOGOL6o0VEtHKdJue3KOIFVNp/h4d1i/fdn2A2kdd+t5x6Wj57vgQlLf
         ro/idjO50T2dgg/A8Rc6Sg03BxCSs+iftaQGq/5lbnW08dQwabA7xBNSj6SMDl6Abd8X
         GZWb4B77nWyHsFL9HaFJ8w8VR1OeEJ+6SIWiuKQz292deRQlxdx6ED1Bdc/1I2eAESGd
         JIVw==
X-Gm-Message-State: APjAAAXTMIAD+akmFthzJ1szw+SHq1QepVZ6tNe152Lw6FAEUpgFG1aq
        CKVnuM4JMGVforZlO1ip0g==
X-Google-Smtp-Source: APXvYqwobZaUu+mbmoCysRALCWLnnpjSYEKAG/YYdm/rVqj5OZCzd4aRgtCVgTPlE9VhgMKHVxBPqw==
X-Received: by 2002:a9d:6a98:: with SMTP id l24mr435845otq.160.1576635142409;
        Tue, 17 Dec 2019 18:12:22 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u18sm256188otq.26.2019.12.17.18.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 18:12:22 -0800 (PST)
Date:   Tue, 17 Dec 2019 20:12:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, georgi.djakov@linaro.org,
        linux-pm@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH] dt-bindings: interconnect: Convert Allwinner MBUS
 controller to a schema
Message-ID: <20191218021221.GA25268@bogus>
References: <20191213074533.27048-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213074533.27048-1-maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 13 Dec 2019 08:45:33 +0100, Maxime Ripard wrote:
> The older Allwinner SoCs have an MBUS controller that is used by Linux,
> with a matching Device Tree binding.
> 
> Now that we have the DT validation in place, let's convert the device tree
> bindings for that controller over to a YAML schemas.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml   | 65 +++++++++++++++++++
>  .../bindings/arm/sunxi/sunxi-mbus.txt         | 37 -----------
>  2 files changed, 65 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt
> 

Applied, thanks.

Rob

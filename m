Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8313B460BEA
	for <lists+linux-pm@lfdr.de>; Mon, 29 Nov 2021 01:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376727AbhK2A7l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Nov 2021 19:59:41 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:43902 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376621AbhK2A5k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Nov 2021 19:57:40 -0500
Received: by mail-ot1-f43.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so1728356otu.10;
        Sun, 28 Nov 2021 16:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N7YH0QLbVQHFaw8cSRPZyCfHK8VX0tIG2IT3N92cT40=;
        b=UOsrXxm+KVJAs/h1ES2jposOTYCAc4tN4+tsTMA+PDhqPwH/hmqEafvXRCvZVplF1K
         RzVgTNXHY2gTONmc9Qf0Vypzcu9TU5fO1aftprhOZQy8j4JQk7HSP4xUppavMRY7O7d3
         Ktg+xccZT7tj6ab4sAno0jY357wwctInOa4Q5S9INxOjcJfIfz/e9YmqfBWQnv7bMx3U
         ud0puK3hqclcwhSBeVC1sZqyXIRTc5OWJv3EQ0uYvQGPOHyb9BDjSVQp36sPESb811SN
         uDmxwP2+341BQ7HE5aFEB0STOWR5rNL+hxrCVUAiO3d2wZ6L92ymbibgjdSl8mVjaRIE
         eUIg==
X-Gm-Message-State: AOAM532wQxEffLduQgtEivnjxwmz2DZWxj3c94Bu6KHOG7lMPzKkIO1C
        3mgsCo4/a/sBaUehLsTRXsFy9MNSMg==
X-Google-Smtp-Source: ABdhPJzBxkG2Fj7IMVYPPS9tanu1FPQqMplSg/BQEfXCb8YIx1EY2hsVj6bMRlz11C+vcZdptroeGg==
X-Received: by 2002:a9d:4e97:: with SMTP id v23mr43092382otk.315.1638147263506;
        Sun, 28 Nov 2021 16:54:23 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.99.229])
        by smtp.gmail.com with ESMTPSA id x16sm2394975ott.8.2021.11.28.16.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:54:22 -0800 (PST)
Received: (nullmailer pid 2924938 invoked by uid 1000);
        Mon, 29 Nov 2021 00:54:19 -0000
Date:   Sun, 28 Nov 2021 18:54:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v3 03/11] dt-bindings: iommu: apple,dart: Add
 power-domains property
Message-ID: <YaQku0La1VRQlFYa@robh.at.kernel.org>
References: <20211124073419.181799-1-marcan@marcan.st>
 <20211124073419.181799-4-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124073419.181799-4-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 24 Nov 2021 16:34:13 +0900, Hector Martin wrote:
> This will bind to the PMGR pwrstate nodes that control power/clock
> gating to SoC blocks. The DART driver doesn't do runtime-pm yet, so
> initially this will just keep the domain on permanently.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  Documentation/devicetree/bindings/iommu/apple,dart.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

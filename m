Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5426417060F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 18:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgBZR1F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 12:27:05 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45665 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgBZR1F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 12:27:05 -0500
Received: by mail-ot1-f65.google.com with SMTP id 59so126747otp.12;
        Wed, 26 Feb 2020 09:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=raaW8UBTeCl4evHlw1MVNiVxN6E05aGpaOJ0r7dkarw=;
        b=EUmVOTinWhcE9Vo90E14bDpfc0ePxs0KVUSHg7Jhk1NXVY4p/CMJL6SDs4dD3bpICB
         SmeJO8J2nEVNbgM3Z3vGw9/lGdVA8H5FM5xQlM3szzEXX+K6Azmi/iL6wcvq1riN+BcP
         WQ2hwm0yl27vPCgoEprH/amt0gtF5IemtdzrAGoFMgFWMRphtNNFK0265y9TloW6Bo4U
         oFZybBxlPg00DSfgMelyeXyEmT4xsyNC81FIXPKycNc6esQsufQESyRtINkENN5MsUg7
         1uIhBLn1UneV/RZ3JmuuZXT2zQb593P8i0pw+h9FCksuVONLIOFON/1YNsVaZQArqIf7
         zNOQ==
X-Gm-Message-State: APjAAAXFDwQhQ0zYvwuqLFabLUfQ2+LXB1yd2MyMHqraCBdxaseWaxaP
        KHf4PYfyOZBl8Vc2oDaNXg==
X-Google-Smtp-Source: APXvYqyJLt87oV1yskOgQe0FSJ7KzvncCI5vqnD6mIV6msd8sw1SY760epbuw7pYEkmK5A60+XsYPg==
X-Received: by 2002:a9d:1928:: with SMTP id j40mr4012476ota.68.1582738023444;
        Wed, 26 Feb 2020 09:27:03 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n27sm1019370oie.18.2020.02.26.09.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:27:02 -0800 (PST)
Received: (nullmailer pid 8906 invoked by uid 1000);
        Wed, 26 Feb 2020 17:27:02 -0000
Date:   Wed, 26 Feb 2020 11:27:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Victor Wan <victor.wan@amlogic.com>
Subject: Re: [PATCH] dt-bindings: power: Fix dt_binding_check error
Message-ID: <20200226172702.GA6632@bogus>
References: <1582269169-17557-1-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582269169-17557-1-git-send-email-jianxin.pan@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 21, 2020 at 03:12:48PM +0800, Jianxin Pan wrote:
> Missing ';' in the end of secure-monitor example node.
> 
> Fixes: f50b4108ede1 ("dt-bindings: power: add Amlogic secure power domains bindings")
> Reported-by: Rob Herring<robh+dt@kernel.org>

space                     ^

> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This error isn't in my tree, so make sure it's applied where the 
referenced commit is.

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> index af32209..bc4e037 100644
> --- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> @@ -36,5 +36,5 @@ examples:
>              compatible = "amlogic,meson-a1-pwrc";
>              #power-domain-cells = <1>;
>          };
> -    }
> +    };
>  
> -- 
> 2.7.4
> 

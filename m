Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADEFE9DB4
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 15:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfJ3OiR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 10:38:17 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37104 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfJ3OiR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 10:38:17 -0400
Received: by mail-oi1-f196.google.com with SMTP id y194so2163292oie.4;
        Wed, 30 Oct 2019 07:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+BfFad26abRQq38bwh8Mr1R+j43UFqfABvnUm8o1taw=;
        b=D9m5xzaNqnwcGPtyRnii6aOuyUpk/a0DvUJXKWkJY6YW0libo/O9qur7wLybAp+Rwx
         idTIArGeW8KhXb9ofxSGgkXy6WNOWRFdPdqHZKmdkUO/OiS9T2v6v66TLvYuy/UarTk4
         m4ctegdcE55f1App50AZEQ8CHf6Mi81O8kRUIxSsxukbUY7tAsD/hq19vaYYSy3vde1f
         io5cnaukk/AjRkuoRGdcGbFxZAIVObHm0eY54/wDjKeGHzfOBoUZdMgz0OOqf14HeY4d
         1ZmwS7MtI52OA+rcLxJiSEyQdcv/vWMKC2rALs1ENiuAo4+0/T3Fp7+8x67Dr8oSf0qX
         cFOg==
X-Gm-Message-State: APjAAAVgCHgEpl4jYu//L8BAneUlRai98eiApV+CPf63x6ZfNDYcAhmh
        ItU/cL7NdZKKWadiFu0rx//eXFULnA==
X-Google-Smtp-Source: APXvYqxFcqCnjzslRGByaccuPPCxbj/xGiXI0T5sZQDtLsUsBwQFx0ajU2xY2DO4ZF1wqOj3CpQ5pw==
X-Received: by 2002:aca:5441:: with SMTP id i62mr8840685oib.42.1572446295718;
        Wed, 30 Oct 2019 07:38:15 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j129sm44729oib.22.2019.10.30.07.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 07:38:14 -0700 (PDT)
Date:   Wed, 30 Oct 2019 09:38:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     sre@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: Re: [PATCH 1/5] dt-bindings: power: Introduce one property to
 describe the battery resistance with temperature changes
Message-ID: <20191030143814.GA14919@bogus>
References: <cover.1572245011.git.baolin.wang@linaro.org>
 <44f0c19510c7317cb4ee6cac54b3adfa81c2d6d0.1572245011.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44f0c19510c7317cb4ee6cac54b3adfa81c2d6d0.1572245011.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 28, 2019 at 03:18:57PM +0800, Baolin Wang wrote:
> Since the battery internal resistance can be changed as the temperature
> changes, thus add one table to describe the battery resistance percent
> in different temperature to get a accurate battery internal resistance.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/power/supply/battery.txt   |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> index 5c913d4c..1a6f951 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -35,6 +35,10 @@ Optional Properties:
>     for each of the battery capacity lookup table. The first temperature value
>     specifies the OCV table 0, and the second temperature value specifies the
>     OCV table 1, and so on.
> + - resistance-temp-table: An array providing the resistance percent and
> +   corresponding temperature in degree Celsius, which is used to look up the
> +   resistance percent according to current temperature to get a accurate
> +   batterty internal resistance.

What's the order of values? The description and example don't seem to 
agree unless negative percent is a thing.

>  
>  Battery properties are named, where possible, for the corresponding
>  elements in enum power_supply_property, defined in
> @@ -61,6 +65,7 @@ Example:
>  		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
>  		ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
>  		ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
> +		resistance-temp-table = <20 100>, <10 90>, <0 80>, <(-10) 60>;
>  	};
>  
>  	charger: charger@11 {
> -- 
> 1.7.9.5
> 

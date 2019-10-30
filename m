Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9030AE9DBD
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 15:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfJ3Ojw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 10:39:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34885 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfJ3Ojw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 10:39:52 -0400
Received: by mail-ot1-f68.google.com with SMTP id z6so2325576otb.2;
        Wed, 30 Oct 2019 07:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3tYP49i1zwXEbSPDyhdlkLTVBZpALwlhuoKF7K04zmM=;
        b=rI8rFSa/fHfQV3CPvQYGfsbVBmKeccWRryU8ql88sbcbCjrn3sn9URXE0m5IDQG/g8
         RrNu5PZOBYMO1XC+F7fuPCSbopaXhkCV5ymv+dnSQGrEGd+IAEQ3YAmuEd/+rzXXZ1tZ
         4Jrht+raTSARtTvfCM4zDVbwlDK9AGRIBWtZmgp+8FmQorQn8BVRDbxwXNyBP5o+A8Ih
         9BHyZ5tlQqpdLTJ2gCOjK+sLzcmK2ACQjPhiHCdpjAspdSkCbacDSVwzBbEyy8ziBe5c
         qIpDB2t+KP3QXuAoicUlluhgruWAL+yo861+hLZLRqKiNbZ1373HV39APp+Mg/Zu+eku
         z76A==
X-Gm-Message-State: APjAAAVmqspVWvJna2eKhhpZ0/UJdqJ6TMm/bkDczLgA4Hz75/4yIFA5
        aByNFEmlSN/k8mS9ruRZrg==
X-Google-Smtp-Source: APXvYqyNsH82RV3UbML1PF4VWeA2jBFaZexE24zwlDWMjQt2A/bTlIeRgNWRhZ/DeTtqixeBNY4KAA==
X-Received: by 2002:a05:6830:1e4a:: with SMTP id e10mr149190otj.345.1572446391375;
        Wed, 30 Oct 2019 07:39:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s71sm60743oie.27.2019.10.30.07.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 07:39:50 -0700 (PDT)
Date:   Wed, 30 Oct 2019 09:39:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     sre@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: Re: [PATCH 4/5] dt-bindings: power: sc27xx: Add a new property to
 describe the real resistance of coulomb counter chip
Message-ID: <20191030143949.GA18637@bogus>
References: <cover.1572245011.git.baolin.wang@linaro.org>
 <00202f739348258555dcc40982c330542ac61863.1572245011.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00202f739348258555dcc40982c330542ac61863.1572245011.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 28, 2019 at 03:19:00PM +0800, Baolin Wang wrote:
> Add a new property to describe the real resistance of coulomb counter chip,
> which is used to calibrate the accuracy of the coulomb counter chip.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> index 0a5705b..fc042d0 100644
> --- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> +++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> @@ -13,6 +13,7 @@ Required properties:
>  - io-channel-names: Should be "bat-temp" or "charge-vol".
>  - nvmem-cells: A phandle to the calibration cells provided by eFuse device.
>  - nvmem-cell-names: Should be "fgu_calib".
> +- sprd,calib-resistance: Specify the real resistance of coulomb counter chip in micro Ohms.
>  - monitored-battery: Phandle of battery characteristics devicetree node.
>    See Documentation/devicetree/bindings/power/supply/battery.txt

Needs a standard unit suffix.

>  
> @@ -52,5 +53,6 @@ Example:
>  			nvmem-cells = <&fgu_calib>;
>  			nvmem-cell-names = "fgu_calib";
>  			monitored-battery = <&bat>;
> +			sprd,calib-resistance = <21500>;
>  		};
>  	};
> -- 
> 1.7.9.5
> 

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3918CC4383
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 00:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfJAWJM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 18:09:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39241 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfJAWJL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 18:09:11 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so52199489ioc.6;
        Tue, 01 Oct 2019 15:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=3aP4nB0ya0wL3OqTzjmVtA8piTCJRVuNkUaglYHWt5Y=;
        b=pgDXTqutH2IiDZoUhjMaXKTFKObLME8xYXPEGYOMJSRL2wW8OR1fj7SHRBRN/vymXH
         MniPDMGEO/2CRYfKoVvHIVcJ/Acit8k8UK6vQEzcoa3I2imMlbOoWrUmXXFictcramkN
         rbpW5bZgimaRcxuMS+5I7U0LrjdiIFI7+4Xy8S3y7VldHlwusvsezUbEanEuA00scx4w
         maT1F+1GnGv+xDsjc0iq0xIgv7pbRZ34bxrbpxlokG2m3VP6kvBZlVSX3YHUJWdAIy/c
         liJX19seClQNT8g0Vm1M9iOOoA2rFOsm6lbu3DN1h/Ze0DcKGLjKT7Q/qWtK5EbEKTo2
         2POw==
X-Gm-Message-State: APjAAAXg9UkbjryrG1azOEW0SCRX44P135ieai9Bn38CceIjgVNLpLcR
        FRBaxhw9RXtRTTjgK0ewtg==
X-Google-Smtp-Source: APXvYqxcuI0Fb8V/LZ7kKtKzXVOvY7LP2sr6ULw8ouzhtTkkiPEvFBxMtZ3V8CVRFT60QdawPrX6og==
X-Received: by 2002:a6b:794d:: with SMTP id j13mr455342iop.238.1569967750755;
        Tue, 01 Oct 2019 15:09:10 -0700 (PDT)
Received: from localhost ([2607:fb90:1780:6fbf:9c38:e932:436b:4079])
        by smtp.gmail.com with ESMTPSA id c8sm8051066iol.57.2019.10.01.15.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:09:10 -0700 (PDT)
Message-ID: <5d93ce86.1c69fb81.70b0d.ba56@mx.google.com>
Date:   Tue, 01 Oct 2019 17:09:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@verdurent.com,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: thermal: Introduce monitor-falling
 parameter to thermal trip point binding
References: <1568859503-19725-1-git-send-email-thara.gopinath@linaro.org>
 <1568859503-19725-2-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568859503-19725-2-git-send-email-thara.gopinath@linaro.org>
X-Mutt-References: <1568859503-19725-2-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 18, 2019 at 10:18:20PM -0400, Thara Gopinath wrote:
> Introduce a new binding parameter to thermal trip point description
> to indicate whether the temperature level specified by the trip point
> is monitored for a rise or fall in temperature.

What if it is both?

When do you need this? Seems like you'd always want to monitor both 
directions to undo any action done on rising temp. Unless you want a 
hysteresis, but this doesn't seem like the best way to implement that.

> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index ca14ba9..849a2a9 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -90,6 +90,14 @@ Required properties:
>  	"critical":	Hardware not reliable.
>    Type: string
>  
> +Optional property:
> +- monitor-falling: 	Indicate whether the system action is kick
> +  Type: boolean		started when the temperature falls below or rises
> +			above the trip temperature level indicated in
> +			"temperature".If true, the trip point is monitored
> +			for falling temperature else the trip point is
> +			monitored for rising temperature.
> +
>  * Cooling device maps
>  
>  The cooling device maps node is a node to describe how cooling devices
> -- 
> 2.1.4
> 


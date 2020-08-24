Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A59C250C20
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 01:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgHXXKB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 19:10:01 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37783 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXXKB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 19:10:01 -0400
Received: by mail-il1-f196.google.com with SMTP id v2so8827720ilq.4;
        Mon, 24 Aug 2020 16:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pNW+FpExzUZzKAgdzLbbC3mRjgc/ErkF14qzkePzpao=;
        b=rCGPujwGgeuFwBJk9BqeNd7TFwV8sYSsw3S3vkJzcLzULZnDUnVbwv8pxDYZsRmx3A
         SrH6Sb0mMVh+ToK/wemOglj+9l0DV6bwazvD1R0XnNeDzuXDL483kkSI6M2EeqEler76
         kxqQHeD7zlMJXZQPdb9ENbBsxN+vVnVxswK8MBQv5QBHrWlabnwhnNJI3Bbgz3ukD9NY
         uAwaVBX60vKaB0VoND4UWDxF+AfHKJtVqAfA3jVXyLYcSxhZIfm/Bv+cq6QZwuXKHTR4
         0QnmnlJXI2k3kBjSYJ8dioD+S679U11Db8WssC6KLBd6FAF4lj2ZsobU6PBcBgxqXi4S
         qBmg==
X-Gm-Message-State: AOAM532KPMGGoQldfLTE5F5cJR2QoyvtDwVOE6AdMFRxL0KAEGUQhngV
        f5j+QycN9A6meVkG9gmOehDYeSX1CA==
X-Google-Smtp-Source: ABdhPJye+VWIVLJXB8wHyD0hNc5m+JPXvkFWV50q8MkRfj/wsTQkYrcYnZUWZ+rtqsOfgrGDN5f5SA==
X-Received: by 2002:a05:6e02:13ee:: with SMTP id w14mr7059209ilj.4.1598310599896;
        Mon, 24 Aug 2020 16:09:59 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id n7sm7456664iop.45.2020.08.24.16.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 16:09:58 -0700 (PDT)
Received: (nullmailer pid 3506628 invoked by uid 1000);
        Mon, 24 Aug 2020 23:09:56 -0000
Date:   Mon, 24 Aug 2020 17:09:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Finley Xiao <finley.xiao@rock-chips.com>
Cc:     heiko@sntech.de, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        huangtao@rock-chips.com, tony.xie@rock-chips.com, cl@rock-chips.com
Subject: Re: [PATCH v1] thermal/of: Introduce k-po, k-pu and k-i for a
 thermal zone
Message-ID: <20200824230956.GA3500214@bogus>
References: <20200811123115.8144-1-finley.xiao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811123115.8144-1-finley.xiao@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 11, 2020 at 08:31:15PM +0800, Finley Xiao wrote:
> The default value for k_pu is:
>     2 * sustainable_power / (desired_temperature - switch_on_temp)
> The default value for k_po is:
>     sustainable_power / (desired_temperature - switch_on_temp)
> The default value for k_i is 10.
> 
> Even though these parameters of the PID controller can be changed
> by the following sysfs files:
>     /sys/class/thermal/thermal_zoneX/k_pu
>     /sys/class/thermal/thermal_zoneX/k_po
>     /sys/class/thermal/thermal_zoneX/k_i
> 
> But it's still more convenient to change the default values by devicetree,
> so introduce these three optional properties. If provided these properties,
> they will be parsed and associated with the thermal zone via the thermal
> zone parameters.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 14 ++++++++++++++

Bindings should be a separate file and this one is a DT schema now.

>  drivers/thermal/thermal_of.c                          |  7 +++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index f78bec19ca35..ebe936b57ded 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -165,6 +165,20 @@ Optional property:
>  			2000mW, while on a 10'' tablet is around
>  			4500mW.
>  
> +- k-po:			Proportional parameter of the PID controller when
> +			current temperature is above the target.
> +  Type: signed
> +  Size: one cell
> +
> +- k-pu:			Proportional parameter of the PID controller when
> +			current temperature is below the target.
> +  Type: signed
> +  Size: one cell
> +
> +- k-i:			Integral parameter of the PID controller.
> +  Type: signed
> +  Size: one cell

What's PID?

I know nothing about the sysfs params, but the binding needs to stand on 
it's own and needs enough detail to educate me.

Rob

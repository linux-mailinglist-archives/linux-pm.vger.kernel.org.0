Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A86010274
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 00:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfD3Wgc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 18:36:32 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42633 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfD3Wgc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 18:36:32 -0400
Received: by mail-oi1-f194.google.com with SMTP id k9so9626535oig.9;
        Tue, 30 Apr 2019 15:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/mJXhoJojCpUvedjSobrKy+qo2rbTnzoSCiZ/p9K6Ps=;
        b=HS3qWGlhAnoIUv5Z8F9TepKxybv9lUZk3N85N5Vy18uHAUvtbjQFHo2KS1pfXTznEP
         cHDJIBm+Am5c5EzgCXgn5S9llXdoJogmzFF4yPxcWQmnm8MCOvg6+R32ao40zpg56mnh
         uVK98vbzkcUvQ/PojvXrPx8HZW27S2/0Gz4bTXVbNDHTRGQ4yhpi3ksdIo1uMWUkDo61
         9GvHLEOx0VECzMCmcw6llntpWb0zMvtLFOVYahIzt5/9oQfczKXqPIgGz602UBfAh5VP
         dNpbqBosdv8ck/MM03hEB4TzWho3I4CmrZhqweTSCSF5J8QEa6K4UMNGHOKtwZoif8nw
         Yw/Q==
X-Gm-Message-State: APjAAAVHd0UFLg+rdtYHqvC74+wQ441dTwtWwRjg4IlcdakZL/xrsJW/
        l0oPty8xevLni9DXgQBXrjeqN8Y=
X-Google-Smtp-Source: APXvYqwWpWTkDLi/5cn+5ZNlMzpXt22goFTzWSrZmnH77oxGSI9CYCDloavg5F/4ChkQG7MOO7VPjA==
X-Received: by 2002:aca:b505:: with SMTP id e5mr4667584oif.136.1556663791364;
        Tue, 30 Apr 2019 15:36:31 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e21sm3956588otr.38.2019.04.30.15.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 15:36:30 -0700 (PDT)
Date:   Tue, 30 Apr 2019 17:36:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        krzk@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v3 3/4] Documentation: devicetree: add PPMU events
 description
Message-ID: <20190430223629.GA22317@bogus>
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0@eucas1p2.samsung.com>
 <1555681688-19643-4-git-send-email-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555681688-19643-4-git-send-email-l.luba@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 19, 2019 at 03:48:07PM +0200, Lukasz Luba wrote:
> Extend the documenation by events description with new 'event-data-type'
> field. Add example how the event might be defined in DT.

Why do we need event types in DT? We don't do this for other h/w such as 
ARM PMU.

> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../devicetree/bindings/devfreq/event/exynos-ppmu.txt  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> index 3e36c1d..47feb5f 100644
> --- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> +++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> @@ -145,3 +145,21 @@ Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
>  			reg = <0x104d0000 0x2000>;
>  			status = "disabled";
>  		};
> +
> +The 'event' type specified in the PPMU node defines 'event-name'
> +which also contains 'id' number and optionally 'event-data-type'.
> +
> +Example:
> +
> +		events {
> +			ppmu_leftbus_0: ppmu-event0-leftbus {
> +				event-name = "ppmu-event0-leftbus";
> +				event-data-type = <PPMU_RO_DATA_CNT>;
> +			};
> +		};
> +
> +The 'event-data-type' defines the type of data which shell be counted
> +by the counter. You can check include/dt-bindings/pmu/exynos_ppmu.h for
> +all possible type, i.e. count read requests, count write data in bytes,
> +etc. This field is optional and when it is missing, the driver code will
> +use default data type.
> -- 
> 2.7.4
> 

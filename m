Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D636B7B4
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 09:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfGQHyy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 03:54:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34510 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfGQHyy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 03:54:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so4527122pgc.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7CDBem+N4Y8GonyneakgYW4yRRjV6CTTMSRhiie6FvM=;
        b=X91hHiq+XMv6rYqH0C1L60r5PFIPz0ALpX0L4rrxy3R0L7yIB7LB1wt2GigVavcOlw
         6oNDhqTXYbkwuqZn8UJsLbssFwcot9lLbvTZCgauXQHyKkA3hbliqn/Pln2C0fQfx8x5
         yx3XJh+N84gqLV5iCqeUMA5IGPCBhOJsd5+DRpIv8Kbgo3yq9BSgMAlkIy/j9JAqR/tD
         3s8BLrcNBgsG36XBmNVIcnSSPm8aUnDU06iVjLVYRaV+9zQy5rcenYGaEiCbEompeLfl
         HtejdgkFeaAnQYV7SuoOXrGEj355XnPS6yNbRH3RUNcCJ+cEEfsWiezir5dGcPT0xRLZ
         DsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7CDBem+N4Y8GonyneakgYW4yRRjV6CTTMSRhiie6FvM=;
        b=oIacCzlRrbovXy85ooMcUtlgUSC8eOXBx+rVKEznlua+hV/u6z/C3iZWB2nV2n9AgR
         UJgJ0JJLdVLc7C7v2u4EBWUFfsPJUyrC/LdvjtOaKDnUNqOzGLwMfNtv30aU3S0wO8rq
         ZfCKUR740hY11obNuOFUx2SCMrJnCzgm5eZHD/3ZPVdyxenk73szjj8TtJbXRJWoi26O
         +sYWwh4n8BKzOHMsbJcE33tG7lmqmMOpCDap9eD5N5F7oVvuuFzgScXcQ7T/GPkyn848
         TMOOm1A7LopgoFdDhJ0KgVPpfbJwhsVbPUVQx74YyE1AK7YMNJXqEMA1jmJRnSJLxUKS
         vygg==
X-Gm-Message-State: APjAAAXNCRHdFeUSTqWulM7uoxqnVTGakCuCfuSN7HtYMs6I5hwE+4Gh
        6vWnR50lIPhGxQCSiY2th+UDgQ==
X-Google-Smtp-Source: APXvYqwS793ra2K/Q8y9DiNBlQJ9AqGzBCIEAGcfR20+btRcZICeer3TBgT1cpHsLKOv5k3Z4wKZjQ==
X-Received: by 2002:a17:90a:c391:: with SMTP id h17mr42645811pjt.131.1563350093035;
        Wed, 17 Jul 2019 00:54:53 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id z20sm37644233pfk.72.2019.07.17.00.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 00:54:50 -0700 (PDT)
Date:   Wed, 17 Jul 2019 13:24:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        sibis@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
Message-ID: <20190717075448.xlyg2ddewlci3abg@vireshk-i7>
References: <20190703011020.151615-1-saravanak@google.com>
 <20190703011020.151615-2-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703011020.151615-2-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-07-19, 18:10, Saravana Kannan wrote:
> Interconnects often quantify their performance points in terms of
> bandwidth. So, add opp-peak-KBps (required) and opp-avg-KBps (optional) to
> allow specifying Bandwidth OPP tables in DT.
> 
> opp-peak-KBps is a required property that replace opp-hz for Bandwidth OPP
> tables.
> 
> opp-avg-KBps is an optional property that can be used in Bandwidth OPP
> tables.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 76b6c79604a5..c869e87caa2a 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -83,9 +83,14 @@ properties.
>  
>  Required properties:
>  - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
> -  required property for all device nodes but devices like power domains. The
> -  power domain nodes must have another (implementation dependent) property which
> -  uniquely identifies the OPP nodes.
> +  required property for all device nodes but for devices like power domains or
> +  bandwidth opp tables. The power domain nodes must have another (implementation
> +  dependent) property which uniquely identifies the OPP nodes. The interconnect
> +  opps are required to have the opp-peak-bw property.

                                   ??

> +
> +- opp-peak-KBps: Peak bandwidth in kilobytes per second, expressed as a 32-bit
> +  big-endian integer. This is a required property for all devices that don't
> +  have opp-hz. For example, bandwidth OPP tables for interconnect paths.
>  
>  Optional properties:
>  - opp-microvolt: voltage in micro Volts.
> @@ -132,6 +137,10 @@ Optional properties:
>  - opp-level: A value representing the performance level of the device,
>    expressed as a 32-bit integer.
>  
> +- opp-avg-KBps: Average bandwidth in kilobytes per second, expressed as a
> +  32-bit big-endian integer. This property is only meaningful in OPP tables
> +  where opp-peak-KBps is present.
> +
>  - clock-latency-ns: Specifies the maximum possible transition latency (in
>    nanoseconds) for switching to this OPP from any other OPP.
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog

-- 
viresh

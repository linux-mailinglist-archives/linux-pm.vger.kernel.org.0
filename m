Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5807133F53
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 11:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgAHKcR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 05:32:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44897 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgAHKcQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 05:32:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id az3so949090plb.11
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2020 02:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JRSseHLewK0ltHlOf6IIEMSjngjyOxSD/KfPZ4IpVLI=;
        b=mubr9YrxsOv2C7hQ34JdHTW+nIwSF2+agoCwwGIe38uqhRdL/w+coigyFZAX/abKN4
         53EXMRyLW1XlzXdjaYINHxBYivMQ71jxTtaj/3m8fTTW7uZn2QIMDC/RvBC2RX5GZGPj
         IBcFRr22CvB2+x/Aylp6ue8NFLAW14HcKIalz5FP+DWrW3dxQvQ3TgOJOPaK8R/UwYdc
         biITeYn18Tard2Om0MBmQyDsgP3WEQ9gqj55g4K2XjkzQKhBS7RkBn+FtnOEmmuVAsuN
         rGzBh4icbFZFEcGCVFYu0z7HvX6DwNHGTPx29tI9i+nmvt7TnlbRX29hCZVWp0QuPdgo
         Gc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JRSseHLewK0ltHlOf6IIEMSjngjyOxSD/KfPZ4IpVLI=;
        b=X2MPUgh5fwXFAre0h30gw2b1rk7TEdV5UC72zpvItozzm524MwZRlj2WpDG6wOgRDb
         +5Yileah9lHuqotWvaR0JRQps5z5sULA9/BWL+uaHA770smQe7SUSYdiYszU4YvBxlB6
         2gPbzTlorKSd9b+x96oQ2WgAIZzJ7ezPKPwkhQJkDF5om6tNY9+DQZUz+vxjHu5T9SEA
         81wCQo6vycuXqZ5MO3oAmktS/c6V48+8m1tSMZVcjQEZfg2FsoO9YQRn+0ubGvBP93Kh
         MeKiB5rno9rw4G8RpDfHuWPi6S2rCNH2AmEjAeZqU5xtrJzSpJO0izv8SqjIouZon8uV
         5/hw==
X-Gm-Message-State: APjAAAXZpMQsjxOXfj+ZcIl5Lnd1ePljNB9LKjmK5vbfEumisfKzOteV
        py2HhtWYRkWktMxj+oXwtKewyw==
X-Google-Smtp-Source: APXvYqzl2pKlCO2kMLeHPiwC65RgF/2o1TWeA38eJFNgsrc5MhPHh89c3t41AVilMN+OeoXZstB+vw==
X-Received: by 2002:a17:90a:cb16:: with SMTP id z22mr3550255pjt.122.1578479535942;
        Wed, 08 Jan 2020 02:32:15 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id d24sm3082639pfq.75.2020.01.08.02.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 02:32:15 -0800 (PST)
Date:   Wed, 8 Jan 2020 16:02:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: opp: Introduce opp-peak-kBps and
 opp-avg-kBps bindings
Message-ID: <20200108103210.oyrqxlybrdbelkne@vireshk-i7>
References: <20191207002424.201796-1-saravanak@google.com>
 <20191207002424.201796-2-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207002424.201796-2-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-12-19, 16:24, Saravana Kannan wrote:
> Interconnects often quantify their performance points in terms of
> bandwidth. So, add opp-peak-kBps (required) and opp-avg-kBps (optional) to
> allow specifying Bandwidth OPP tables in DT.
> 
> opp-peak-kBps is a required property that replaces opp-hz for Bandwidth OPP
> tables.
> 
> opp-avg-kBps is an optional property that can be used in Bandwidth OPP
> tables.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt     | 15 ++++++++++++---
>  .../devicetree/bindings/property-units.txt        |  4 ++++
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 68592271461f..dbad8eb6c746 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -83,9 +83,14 @@ properties.
>  
>  Required properties:
>  - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
> -  required property for all device nodes but devices like power domains. The
> -  power domain nodes must have another (implementation dependent) property which
> -  uniquely identifies the OPP nodes.
> +  required property for all device nodes except for devices like power domains
> +  or bandwidth opp tables.

Fine until here.

> The power domain nodes must have another
> +  (implementation dependent) property which uniquely identifies the OPP nodes.
> +  The interconnect opps are required to have the opp-peak-kBps property.

Maybe rewrite it as:

The devices which don't have this property must have another
(implementation dependent) property which uniquely identifies the OPP
nodes.

So we won't be required to update this again for another property.

> +
> +- opp-peak-kBps: Peak bandwidth in kilobytes per second, expressed as a 32-bit
> +  big-endian integer.

> This is a required property for all devices that don't
> +  have opp-hz.

This statement is surely incorrect, isn't it ? What about power-domain
tables ?

Suggest rewriting it as:

This is a required property for bandwidth OPP tables.

> For example, bandwidth OPP tables for interconnect paths.
>  
>  Optional properties:
>  - opp-microvolt: voltage in micro Volts.
> @@ -132,6 +137,10 @@ Optional properties:
>  - opp-level: A value representing the performance level of the device,
>    expressed as a 32-bit integer.
>  
> +- opp-avg-kBps: Average bandwidth in kilobytes per second, expressed as a
> +  32-bit big-endian integer. This property is only meaningful in OPP tables
> +  where opp-peak-kBps is present.
> +
>  - clock-latency-ns: Specifies the maximum possible transition latency (in
>    nanoseconds) for switching to this OPP from any other OPP.
>  
> diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
> index e9b8360b3288..c80a110c1e26 100644
> --- a/Documentation/devicetree/bindings/property-units.txt
> +++ b/Documentation/devicetree/bindings/property-units.txt
> @@ -41,3 +41,7 @@ Temperature
>  Pressure
>  ----------------------------------------
>  -kpascal	: kilopascal
> +
> +Throughput
> +----------------------------------------
> +-kBps		: kilobytes per second
> -- 
> 2.24.0.393.g34dc348eaf-goog

-- 
viresh

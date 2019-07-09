Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A90E632BD
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 10:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfGIIOk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 04:14:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35986 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGIIOk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2019 04:14:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so5044979pgm.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2019 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WwQ5bucdLWQygYxygSJozlXHDjj0Eb5bfaQTAqD/RAY=;
        b=uDcfYqYFArvBK5OKADRY9kCppXYU9MKVJkzXKP+XmdGwa+G+W5U6Apj/QIwIw1wbdq
         mlm+vab7pxbwcYkSarZB4iWWIagZSfR06v/5FgDZyMJvtCnafnawfUYqRS2naVJBmwaB
         LOeSJnW/zeQ3pjYzrACQTdcy9L9O9IwzFFme93iS59Wt2t50/F75s4YNvXQtSce43IXb
         f7LMWR3mP9zzL6KQQshGUyxJkOMGkgXTacrC0A5ifnX3kyIeBP/9PWtl5vEpN6IUzBhR
         mZkwGuCc8ayAIvv/MrH1i798OGSOpetrigTzCMeRMXV17X2KaprPL79lQpqfNY7a0Njw
         yHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WwQ5bucdLWQygYxygSJozlXHDjj0Eb5bfaQTAqD/RAY=;
        b=H0XBNw23R/j6bVerWlpw1VfRMSV/srSba6Y7EmGBl0hpw9J/MlcpeO8B978j/D8+15
         5z3Nm4cL3ZpAGKjUqifGqgK+Dc6Hph4SYYEK8/AvzLC49JlTY74wXJqmEZkOut+Q4fnR
         iph9OUX/RmlG8TrI41ktqClsT29XeA3nqq8ZpzjzMM6pgVtS1/QxYpX40+YVEFb27Nz1
         uRZPj+qmjrpG6cRs3NUlAru0pCGMDJjPk3FqZvruLs0Phr4aOCmylfJooZ9UspcfcZf0
         W9NuV86PRt5yMm01eGawPWKWHIdyhPYaupFKWXm366i4vTaBnTeLkJcGBN1YzjEi3A1r
         geQg==
X-Gm-Message-State: APjAAAXglZBIOm/iVgT4jaqcF8hprqfg0sAfXMad+rGgHlGh5YynVrnG
        PEY1FxHYGHhySxsV0yLmIVXFew==
X-Google-Smtp-Source: APXvYqzICT10j5UplTlApExoj/w21dBQdKmi/8TtBgI8+M4EnpKOLgBeiolAXaDckLPieEY5y7K7mA==
X-Received: by 2002:a63:1847:: with SMTP id 7mr29794492pgy.204.1562660079412;
        Tue, 09 Jul 2019 01:14:39 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id u97sm1823179pjb.26.2019.07.09.01.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 01:14:38 -0700 (PDT)
Date:   Tue, 9 Jul 2019 13:44:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson.Huang@nxp.com
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, p.zabel@pengutronix.de, ping.bai@nxp.com,
        daniel.baluta@nxp.com, l.stach@pengutronix.de, abel.vesa@nxp.com,
        angus@akkea.ca, andrew.smirnov@gmail.com, ccaione@baylibre.com,
        agx@sigxcpu.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/4] dt-bindings: opp: Support multiple opp-suspend
 properties
Message-ID: <20190709081436.fguhzv2quldql2k4@vireshk-i7>
References: <20190709080015.43442-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709080015.43442-1-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-07-19, 16:00, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Update opp-suspend property's description to support multiple
> opp-suspend properties defined in DT, the OPP with highest opp-hz
> and with opp-suspend property present will be used as suspend opp.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch.
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 76b6c79..6859227 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -140,8 +140,8 @@ Optional properties:
>    frequency for a short duration of time limited by the device's power, current
>    and thermal limits.
>  
> -- opp-suspend: Marks the OPP to be used during device suspend. Only one OPP in
> -  the table should have this.
> +- opp-suspend: Marks the OPP to be used during device suspend. If multiple OPPs
> +  in the table have this, the OPP with highest opp-hz will be used.
>  
>  - opp-supported-hw: This enables us to select only a subset of OPPs from the
>    larger OPP table, based on what version of the hardware we are running on. We

LGTM. Once Rob Acks it, I will apply the first two patches to the OPP
tree.

-- 
viresh

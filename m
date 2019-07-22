Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6DCE70D77
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 01:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfGVXja (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 19:39:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41705 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfGVXja (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 19:39:30 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so73702646ioj.8;
        Mon, 22 Jul 2019 16:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Re1ou/Cp7xqVBQ6KMFNH/nG+U/FTlL8aNd/MoRXidQw=;
        b=cxPkIL7XTI2cYDEdYcTCa36BsGw4YgHXOrAd8LVuB7/lgrF1kG/AAEML/OqfsKoN3Y
         yrtBXFsjLyFJYwUcu7UB0IkKQ5rch7fKqu8Qjllqv04ni0uJCX+soHTRKjqa8gekQsfD
         FGQlF3yYudOkyvpe1Yko26qMbGCErd0pxs82zamULlF2rkzURtTVI3JwAiZJZsq1Nxck
         21uJYjEuqtzrjnwCa88I6ecnjxzPHXKnM4bRsO/ES5rUeb4mYmQZh/RQtlIJk+r9r5Cg
         rluHZMPj1l+a2Gp5CkKLOswqc5buFaAChpjD4RRRcAR5ektuNAilZ/kLbWWqC9ExCY9n
         6lnA==
X-Gm-Message-State: APjAAAX58XTZJImbZ/K+DN6Z8Zr1PXO6s03UTHzD09Qj6cGhvHd0Zp73
        zchWriUMKW6zh0nJpIUUkw==
X-Google-Smtp-Source: APXvYqyxJK+kQudxi2Yk/oKLLBxmi3+hhs+D/FKOwXSGcX6KV5xW7nMlE4AxnlDjZGyuwGpb+nx6qA==
X-Received: by 2002:a5e:cb06:: with SMTP id p6mr67249208iom.79.1563838768762;
        Mon, 22 Jul 2019 16:39:28 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id p10sm58868136iob.54.2019.07.22.16.39.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 16:39:28 -0700 (PDT)
Date:   Mon, 22 Jul 2019 17:39:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
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
Subject: Re: [PATCH v3 5/6] dt-bindings: interconnect: Add
 interconnect-opp-table property
Message-ID: <20190722233927.GA1353@bogus>
References: <20190703011020.151615-1-saravanak@google.com>
 <20190703011020.151615-6-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703011020.151615-6-saravanak@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 02, 2019 at 06:10:19PM -0700, Saravana Kannan wrote:
> Add support for listing bandwidth OPP tables for each interconnect path
> listed using the interconnects property.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  .../devicetree/bindings/interconnect/interconnect.txt     | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> index 6f5d23a605b7..fc5b75b76a2c 100644
> --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> @@ -55,10 +55,18 @@ interconnect-names : List of interconnect path name strings sorted in the same
>  			 * dma-mem: Path from the device to the main memory of
>  			            the system
>  
> +interconnect-opp-table: List of phandles to OPP tables (bandwidth OPP tables)
> +			that specify the OPPs for the interconnect paths listed
> +			in the interconnects property. This property can only
> +			point to OPP tables that belong to the device and are
> +			listed in the device's operating-points-v2 property.
> +

IMO, there's no need for this property. Which OPP is which should be 
defined already as part of the device's binding. That's enough for the 
driver to know which OPP applies to the interconnect.

>  Example:
>  
>  	sdhci@7864000 {
> +		operating-points-v2 = <&sdhc_opp_table>, <&sdhc_mem_opp_table>;
>  		...
>  		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
>  		interconnect-names = "sdhc-mem";
> +		interconnect-opp-table = <&sdhc_mem_opp_table>;
>  	};
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

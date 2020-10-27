Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E379C29A733
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 10:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895261AbgJ0JDJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 05:03:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33051 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895257AbgJ0JDI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 05:03:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id w23so627752edl.0;
        Tue, 27 Oct 2020 02:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yrkq+w+CNrcs2d/CHfaDmYUZq0y1BCcvuJB0UBRduYM=;
        b=aI7yKdPROfMOTXi8+ThlRPkv+LA37S0nZv/3npSPlJ3BIjtGcuitGtk6DnsS0/8F1v
         azGuXdTLyImvNDvMIzjcqWDuh0ZvXjlD1k6xyPJR0TdH0E9qJ0SQcKmqfwrgk3sAveAH
         RRYIJ+cSk9Nr9MgnH9xpmJLCOBLFDRvOx71LDoeDLvxVNrcBsg0IYlhyDr2zfHK3m9rt
         0lW0tU3rTK2YKeTZKF6gHkRfRE8cj50HZHNZ18LTXlpyLiYPA8Jr7uisYd7+CAx4POSy
         CeE4ZyghNrJaCxiPJOZ8QS3bnkqyfPnKlsA4z7+weUMCOhpv6Pk47bmgAUmjmmMToLbp
         E5fA==
X-Gm-Message-State: AOAM531qDOVxCkQ2of8wY4x4yACjmiYTCyys20gsHQT4PGN+vJ3ADuL9
        RMuhbgo07S89qnrmzHM+xhc=
X-Google-Smtp-Source: ABdhPJzNdRHhqt+RsXfXzhPc0FfVZYTR4QTRInXFxqbry09ZA816h7phOrK/RR0xsohIY4dLm8QVeg==
X-Received: by 2002:aa7:c6d9:: with SMTP id b25mr1096980eds.27.1603789386647;
        Tue, 27 Oct 2020 02:03:06 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id p4sm587298eji.105.2020.10.27.02.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 02:03:05 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:03:03 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 06/52] dt-bindings: memory: tegra20: emc: Document new
 interconnect property
Message-ID: <20201027090303.GH4244@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-7-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 01:16:49AM +0300, Dmitry Osipenko wrote:
> External Memory Controller is interconnected with memory controller and
> with external memory. Document new interconnect property which turns EMC
> into interconnect provider.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> index 1b0d4417aad8..0a53adc6ccba 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> @@ -13,6 +13,7 @@ Properties:
>  - interrupts : Should contain EMC General interrupt.
>  - clocks : Should contain EMC clock.
>  - nvidia,memory-controller : Phandle of the Memory Controller node.
> +- #interconnect-cells : Should be 0.
>  
>  Child device nodes describe the memory settings for different configurations and clock rates.
>  
> @@ -21,6 +22,7 @@ Example:
>  	memory-controller@7000f400 {
>  		#address-cells = < 1 >;
>  		#size-cells = < 0 >;
> +		#interconnect-cells = < 0 >;

No spaces within <>. I see existing example, but bad pattern should not
be continued just because it is already there.

Best regards,
Krzysztof

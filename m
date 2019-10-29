Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5F5E7E09
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 02:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfJ2BbO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 21:31:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33210 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfJ2BbO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 21:31:14 -0400
Received: by mail-oi1-f194.google.com with SMTP id m193so3143623oig.0;
        Mon, 28 Oct 2019 18:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JIhmNRVJTaXbOFIrBLr2GZKqCE/QdwK4kQjskhXdiPg=;
        b=nNxvfP50ssqg9nvn2gwAM71VAI1Z/GkDuzqjeyt1Kq8lx/goPSKeTWnYFUCwtMDkqF
         nfHdj2GqAeOoJ+NSlnCXYfQeZE3hD6c/kFeQwJcxeoGtCB8PlJYZpAib9wWHRelMpg+W
         7QaaRGEDu4U+DEldSZHIPYQWTRZESyxlUfejBtCt4+NDt0MhILG4Zv6DGyZK+0PLLarP
         NkQpTMsXJYCPGyH8fI2JQAohZ2aJMrRq1C/Og1Qa6IgNtkRrvd2qoRz5x7GzXA9+Vv8V
         aXacLIoeFfwWljnv+6C0WJ9GwPEJy/LozR0K4KWnoxuE3Au9zWx4jdviOusBnYdcgmjh
         aJ6Q==
X-Gm-Message-State: APjAAAUUFOOQkz+yYvJuXpzRjpLFQpv4iM24OQNsG7LN+TQaLu3Ye++/
        TSTMFErrAmuU4+TO6PpB0A==
X-Google-Smtp-Source: APXvYqyEytvCCmj53skL7qS7iUpONUrq3Umjo5tCrbSGsIW/La9f1V+4pCg0xrvDI1SBUoqMb225DA==
X-Received: by 2002:aca:55c1:: with SMTP id j184mr1918381oib.105.1572312673339;
        Mon, 28 Oct 2019 18:31:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y18sm4097127oto.2.2019.10.28.18.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 18:31:12 -0700 (PDT)
Date:   Mon, 28 Oct 2019 20:31:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, amit.kucheria@verdurent.com,
        mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: Add mx power domain as thermal
 warming device.
Message-ID: <20191029013111.GA27045@bogus>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
 <1571254641-13626-8-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571254641-13626-8-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 16, 2019 at 03:37:21PM -0400, Thara Gopinath wrote:
> RPMh hosts mx power domain that can be used to warm up the SoC.
> Add sub-node to rpmhpd node for mx to be recognized
> as thermal warming device on sdm845.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0222f48..0671c8a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -3788,6 +3788,11 @@
>  						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
>  					};
>  				};
> +
> +				mx_cdev: mx {
> +					#cooling-cells = <2>;
> +					.name = "mx";

Copy this from C code?

> +				};
>  			};
>  
>  			rsc_hlos: interconnect {
> -- 
> 2.1.4
> 

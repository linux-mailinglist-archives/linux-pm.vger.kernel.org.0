Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 364359F633
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 00:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfH0Wcz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 18:32:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43238 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfH0Wcz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 18:32:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id e12so762450otp.10;
        Tue, 27 Aug 2019 15:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bG9bAPsPgtk0aXT02g27VLf1Saty2/UhvB2P1PQFez4=;
        b=lFh0XojkxV22fnbW+8yeuTFoncb0V58PwmV6D1R0gHbEE8Fnl/sk3qJJbNsDFEem9S
         IJgRLxQQenYX8WZAaUxPsCZHrsog3v12vAM+W6kzbyYl7/SRL6K4byR2nc0wa4AeBQsa
         3+4DI+hppspWCQljpfstzZROzPbfC45xcc06SdhrATNNYp7cY5h7lVpXPWltFmHVX/0x
         LCpyitPHpzTv1Zhk8bNEZINSOoNKRYT0FDW3A7a68cM+WSRFzCBRSbel8WrVkrXtejPj
         +ARLIqx4jVTYuTfKRaeo5uL6cpwyKsp3tr3thFyLP2hmyZkg9DpoWHtWZT5yaGQe2AiY
         Xzig==
X-Gm-Message-State: APjAAAUHLRa46OaVpnGKiPC+BaXrntNieNfbix5rma9DDcQd4sfoUbRq
        oW+qTEbiMXpYqTz3eXxSZUgLgo+FRw==
X-Google-Smtp-Source: APXvYqxrYCEbW6Lei7IWDJP4LIXpA5Q0iwBYIAzLRZXOMhYN8gHCCf8NUNNEpuif/S+KC2JZ8UZZfg==
X-Received: by 2002:a9d:6e93:: with SMTP id a19mr819140otr.29.1566945174143;
        Tue, 27 Aug 2019 15:32:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e27sm186531oig.53.2019.08.27.15.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 15:32:53 -0700 (PDT)
Date:   Tue, 27 Aug 2019 17:32:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/6] dt-bindings: soc: qcom: Add RSC power domain
 specifier
Message-ID: <20190827223252.GA26039@bogus>
References: <20190823081703.17325-1-mkshah@codeaurora.org>
 <20190823081703.17325-4-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823081703.17325-4-mkshah@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 23, 2019 at 01:47:00PM +0530, Maulik Shah wrote:
> In addition to transmitting resource state requests to the remote
> processor, the RSC is responsible for powering off/lowering the
> requirements from CPUs subsystem for the associated hardware like
> buses, clocks, and regulators when all CPUs and cluster is powered down.
> 
> The power domain is configured to a low power state and when all the
> CPUs are powered down, the RSC can lower resource state requirements
> and power down the rails that power the CPUs.
> 
> Add PM domain specifier property for RSC controller.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> index 9b86d1eff219..d0ab6e9b6745 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> @@ -83,6 +83,13 @@ Properties:
>  	Value type: <string>
>  	Definition: Name for the RSC. The name would be used in trace logs.
>  
> +- #power-domain-cells:
> +	Usage: optional
> +	Value type: <u32>
> +	Definition: Number of cells in power domain specifier. Optional for
> +		    controllers that may be in 'solver' state where they can
> +		    be in autonomous mode executing low power modes.

What's the value? It's always 0?

> +
>  Drivers that want to use the RSC to communicate with RPMH must specify their
>  bindings as child nodes of the RSC controllers they wish to communicate with.
>  
> @@ -112,6 +119,7 @@ TCS-OFFSET: 0xD00
>  				  <SLEEP_TCS   3>,
>  				  <WAKE_TCS    3>,
>  				  <CONTROL_TCS 1>;
> +		#power-domain-cells = <0>;
>  	};
>  
>  Example 2:
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.
> 

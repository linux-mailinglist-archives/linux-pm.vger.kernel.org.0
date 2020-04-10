Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9701A4945
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 19:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDJRid (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 13:38:33 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44212 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJRid (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 13:38:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id o25so1944972oic.11;
        Fri, 10 Apr 2020 10:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SVZM/9+cxIIYxaSpzImNtMZgxC5SVNGqgXnXXLqgFro=;
        b=b2dFjBS/RU6JMf1T4QDN1aryfxW5aW1pmj5vylLbW199udP2pYPQ++iDn6U4ZZfZ1L
         PLfRO7bnFSRbNbZ3nJr1f4PtptdizNTusSQuzailqMWLVToy5M8cTwRkKcqdtGco+7GZ
         jpla/eYGRja1cmgyd9nUWQMsihOqrkuJlmLAlApXYkHxYwb/VCRuHJR6ybcF5MiKceDN
         783B8Cdh5ynTUcPjfcqzBVlEQGEg2XydBj8H89CJ/hnotWgcpFG/+/aomqf6kCfE2hBt
         UU7zP6SiRmy5f1Ztv+StD+t5YVUomYMipoM7kxqSqlvjdhCxngyXYvueiN61X0cLI0/c
         MYeQ==
X-Gm-Message-State: AGi0PuYxwo31NLnXphHw9fP1xqO06dVs12Iq7X/J0U94OIvJnAqhNxJy
        TexaJOw35Xgpr3fKu9EEVw==
X-Google-Smtp-Source: APiQypI+b7DCb+ABbjOA1szD7WQQUkOuZmJZ5KdJmbNteEdSvFES+4ZpnMHRZhRpriWAWYsHkfug6Q==
X-Received: by 2002:aca:df45:: with SMTP id w66mr4029244oig.76.1586540311262;
        Fri, 10 Apr 2020 10:38:31 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id s127sm1546012oig.23.2020.04.10.10.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:38:30 -0700 (PDT)
Received: (nullmailer pid 4826 invoked by uid 1000);
        Fri, 10 Apr 2020 17:09:29 -0000
Date:   Fri, 10 Apr 2020 12:09:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 05/22] dt-bindings: host1x: Document new interconnect
 properties
Message-ID: <20200410170929.GA1498@bogus>
References: <20200330010904.27643-1-digetx@gmail.com>
 <20200330010904.27643-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330010904.27643-6-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 30, 2020 at 04:08:47AM +0300, Dmitry Osipenko wrote:
> Most of Host1x devices have at least one memory client. These clients
> are directly connected to the memory controller. The new interconnect
> properties represent the memory client's connection to the memory
> controller.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../display/tegra/nvidia,tegra20-host1x.txt   | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
> index 9999255ac5b6..d92d4e814d77 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
> @@ -20,6 +20,10 @@ Required properties:
>  - reset-names: Must include the following entries:
>    - host1x
>  
> +Each host1x client module having to perform DMA through the Memory Controller
> +should have the interconnect endpoints set to the Memory Client and External
> +Memory respectively.
> +
>  The host1x top-level node defines a number of children, each representing one
>  of the following host1x client modules:
>  
> @@ -36,6 +40,12 @@ of the following host1x client modules:
>    - reset-names: Must include the following entries:
>      - mpe
>  
> +  Optional properties:
> +  - interconnects: Must contain entry for the MPE memory clients.
> +  - interconnect-names: Must include name of the interconnect path for each
> +    interconnect entry. Consult TRM documentation for information about
> +    available memory clients.

Is the TRM public? Perhaps refer to the header.

> +
>  - vi: video input
>  
>    Required properties:
> @@ -49,6 +59,12 @@ of the following host1x client modules:
>    - reset-names: Must include the following entries:
>      - vi
>  
> +  Optional properties:
> +  - interconnects: Must contain entry for the VI memory clients.
> +  - interconnect-names: Must include name of the interconnect path for each
> +    interconnect entry. Consult TRM documentation for information about
> +    available memory clients.
> +
>  - epp: encoder pre-processor
>  
>    Required properties:
> @@ -62,6 +78,12 @@ of the following host1x client modules:
>    - reset-names: Must include the following entries:
>      - epp
>  
> +  Optional properties:
> +  - interconnects: Must contain entry for the EPP memory clients.
> +  - interconnect-names: Must include name of the interconnect path for each
> +    interconnect entry. Consult TRM documentation for information about
> +    available memory clients.
> +
>  - isp: image signal processor
>  
>    Required properties:
> @@ -75,6 +97,12 @@ of the following host1x client modules:
>    - reset-names: Must include the following entries:
>      - isp
>  
> +  Optional properties:
> +  - interconnects: Must contain entry for the ISP memory clients.
> +  - interconnect-names: Must include name of the interconnect path for each
> +    interconnect entry. Consult TRM documentation for information about
> +    available memory clients.
> +
>  - gr2d: 2D graphics engine
>  
>    Required properties:
> @@ -88,6 +116,12 @@ of the following host1x client modules:
>    - reset-names: Must include the following entries:
>      - 2d
>  
> +  Optional properties:
> +  - interconnects: Must contain entry for the GR2D memory clients.
> +  - interconnect-names: Must include name of the interconnect path for each
> +    interconnect entry. Consult TRM documentation for information about
> +    available memory clients.
> +
>  - gr3d: 3D graphics engine
>  
>    Required properties:
> @@ -106,6 +140,12 @@ of the following host1x client modules:
>      - 3d
>      - 3d2 (Only required on SoCs with two 3D clocks)
>  
> +  Optional properties:
> +  - interconnects: Must contain entry for the GR3D memory clients.
> +  - interconnect-names: Must include name of the interconnect path for each
> +    interconnect entry. Consult TRM documentation for information about
> +    available memory clients.
> +
>  - dc: display controller
>  
>    Required properties:
> @@ -133,6 +173,10 @@ of the following host1x client modules:
>    - nvidia,hpd-gpio: specifies a GPIO used for hotplug detection
>    - nvidia,edid: supplies a binary EDID blob
>    - nvidia,panel: phandle of a display panel
> +  - interconnects: Must contain entry for the DC memory clients.
> +  - interconnect-names: Must include name of the interconnect path for each
> +    interconnect entry. Consult TRM documentation for information about
> +    available memory clients.
>  
>  - hdmi: High Definition Multimedia Interface
>  
> @@ -281,6 +325,12 @@ of the following host1x client modules:
>    - reset-names: Must include the following entries:
>      - vic
>  
> +  Optional properties:
> +  - interconnects: Must contain entry for the VIC memory clients.
> +  - interconnect-names: Must include name of the interconnect path for each
> +    interconnect entry. Consult TRM documentation for information about
> +    available memory clients.
> +
>  Example:
>  
>  / {
> @@ -363,6 +413,15 @@ Example:
>  			resets = <&tegra_car 27>;
>  			reset-names = "dc";
>  
> +			interconnects = <&mc TEGRA20_MC_DISPLAY0A &emc>,
> +					<&mc TEGRA20_MC_DISPLAY0B &emc>,
> +					<&mc TEGRA20_MC_DISPLAY0C &emc>,
> +					<&mc TEGRA20_MC_DISPLAY1B &emc>;
> +			interconnect-names = "display0a",
> +					     "display0b",
> +					     "display0c",
> +					     "display1b";
> +
>  			rgb {
>  				status = "disabled";
>  			};
> @@ -378,6 +437,15 @@ Example:
>  			resets = <&tegra_car 26>;
>  			reset-names = "dc";
>  
> +			interconnects = <&mc TEGRA20_MC_DISPLAY0AB &emc>,
> +					<&mc TEGRA20_MC_DISPLAY0BB &emc>,
> +					<&mc TEGRA20_MC_DISPLAY0CB &emc>,
> +					<&mc TEGRA20_MC_DISPLAY1BB &emc>;
> +			interconnect-names = "display0a",
> +					     "display0b",
> +					     "display0c",
> +					     "display1b";
> +
>  			rgb {
>  				status = "disabled";
>  			};
> -- 
> 2.25.1
> 

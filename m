Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672D11FD782
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 23:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFQVhb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 17:37:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37079 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQVha (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2020 17:37:30 -0400
Received: by mail-io1-f66.google.com with SMTP id r2so4725090ioo.4;
        Wed, 17 Jun 2020 14:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eDqg9gDgvVSfPZzqiBmC+Ly0PCsBuRi5ihRQMpFBE8U=;
        b=blsnpdE83Rk2nkPaXZMnuo8F2uMG3zjYPB9+atRTIkV95ZrCMW0vU9Dxppn9T7B4DE
         E4rO/RUQkaW+UH/qNb3n7OSI2eBH5Xj31j3SPGZWosMuaKZkb1Ii24XKsdIGIDh0Jk3V
         7zkd9YCqGg4WO/04oulGG4wfcSNUOB20R6fjk4d6ZYzKJbpz2gHCX29xFczwg8Tiigwg
         Rk7gzFhUc/rD4WtyKo+Cclqiyv27TZ3nzDJu5nX4o+oWxP+Uiycvz0ZMjaUGg1FLNyKi
         qLfJ8+LNXhN7JyV/NGvfoRiTGRRtzfiZB+0eAwCQIouqgFkOy8kay8glFhClOoB3KicT
         sqlg==
X-Gm-Message-State: AOAM530zmsh+FAawsfANKtYDywyfZ9Brj4/gIHZ1aZuil+en97fSa0L5
        1NiE29gPvt5NycvM8bLJ3w==
X-Google-Smtp-Source: ABdhPJx9QQcoVumUNEnF3FgFX3xUdRgc7f0svAxUDzJFTb5OqnUWg/b7lDrd5jMkkInGDWqQ6v+G+Q==
X-Received: by 2002:a05:6602:809:: with SMTP id z9mr1553086iow.79.1592429848645;
        Wed, 17 Jun 2020 14:37:28 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r19sm608186ioj.12.2020.06.17.14.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 14:37:27 -0700 (PDT)
Received: (nullmailer pid 2869525 invoked by uid 1000);
        Wed, 17 Jun 2020 21:37:26 -0000
Date:   Wed, 17 Jun 2020 15:37:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 22/37] dt-bindings: host1x: Document new interconnect
 properties
Message-ID: <20200617213726.GA2837398@bogus>
References: <20200609131404.17523-1-digetx@gmail.com>
 <20200609131404.17523-23-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609131404.17523-23-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 09, 2020 at 04:13:49PM +0300, Dmitry Osipenko wrote:
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
> index 47319214b5f6..ab4fbee7bccf 100644
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
> +    available memory clients, see MEMORY CONTROLLER section.
> +
>  - vi: video input
>  
>    Required properties:
> @@ -65,6 +75,12 @@ of the following host1x client modules:
>        - power-domains: Must include sor powergate node as csicil is in
>          SOR partition.
>  
> +  Optional properties:
> +  - interconnects: Must contain entry for the VI memory clients.
> +  - interconnect-names: Must include name of the interconnect path for each
> +    interconnect entry. Consult TRM documentation for information about
> +    available memory clients, see MEMORY CONTROLLER section.
> +
>  - epp: encoder pre-processor
>  
>    Required properties:
> @@ -78,6 +94,12 @@ of the following host1x client modules:
>    - reset-names: Must include the following entries:
>      - epp
>  
> +  Optional properties:
> +  - interconnects: Must contain entry for the EPP memory clients.
> +  - interconnect-names: Must include name of the interconnect path for each
> +    interconnect entry. Consult TRM documentation for information about
> +    available memory clients, see MEMORY CONTROLLER section.
> +
>  - isp: image signal processor
>  
>    Required properties:
> @@ -91,6 +113,12 @@ of the following host1x client modules:
>    - reset-names: Must include the following entries:
>      - isp
>  
> +  Optional properties:
> +  - interconnects: Must contain entry for the ISP memory clients.
> +  - interconnect-names: Must include name of the interconnect path for each
> +    interconnect entry. Consult TRM documentation for information about
> +    available memory clients, see MEMORY CONTROLLER section.
> +
>  - gr2d: 2D graphics engine
>  
>    Required properties:
> @@ -104,6 +132,12 @@ of the following host1x client modules:
>    - reset-names: Must include the following entries:
>      - 2d
>  
> +  Optional properties:
> +  - interconnects: Must contain entry for the GR2D memory clients.
> +  - interconnect-names: Must include name of the interconnect path for each
> +    interconnect entry. Consult TRM documentation for information about
> +    available memory clients, see MEMORY CONTROLLER section.
> +
>  - gr3d: 3D graphics engine
>  
>    Required properties:
> @@ -122,6 +156,12 @@ of the following host1x client modules:
>      - 3d
>      - 3d2 (Only required on SoCs with two 3D clocks)
>  
> +  Optional properties:
> +  - interconnects: Must contain entry for the GR3D memory clients.
> +  - interconnect-names: Must include name of the interconnect path for each
> +    interconnect entry. Consult TRM documentation for information about
> +    available memory clients, see MEMORY CONTROLLER section.
> +
>  - dc: display controller
>  
>    Required properties:
> @@ -149,6 +189,10 @@ of the following host1x client modules:
>    - nvidia,hpd-gpio: specifies a GPIO used for hotplug detection
>    - nvidia,edid: supplies a binary EDID blob
>    - nvidia,panel: phandle of a display panel
> +  - interconnects: Must contain entry for the DC memory clients.
> +  - interconnect-names: Must include name of the interconnect path for each
> +    interconnect entry. Consult TRM documentation for information about
> +    available memory clients, see MEMORY CONTROLLER section.
>  
>  - hdmi: High Definition Multimedia Interface
>  
> @@ -297,6 +341,12 @@ of the following host1x client modules:
>    - reset-names: Must include the following entries:
>      - vic
>  
> +  Optional properties:
> +  - interconnects: Must contain entry for the VIC memory clients.
> +  - interconnect-names: Must include name of the interconnect path for each
> +    interconnect entry. Consult TRM documentation for information about
> +    available memory clients, see MEMORY CONTROLLER section.
> +
>  Example:
>  
>  / {
> @@ -410,6 +460,15 @@ Example:
>  			resets = <&tegra_car 27>;
>  			reset-names = "dc";
>  
> +			interconnects = <&mc TEGRA20_MC_DISPLAY0A &emc>,
> +					<&mc TEGRA20_MC_DISPLAY0B &emc>,
> +					<&mc TEGRA20_MC_DISPLAY0C &emc>,
> +					<&mc TEGRA20_MC_DISPLAY1B &emc>;

This looks odd or wrong. Each entry has 2 phandles? 

> +			interconnect-names = "display0a",
> +					     "display0b",
> +					     "display0c",
> +					     "display1b";
> +
>  			rgb {
>  				status = "disabled";
>  			};
> @@ -425,6 +484,15 @@ Example:
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
> 2.26.0
> 

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39C63FCC73
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 19:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKNSCf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 13:02:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41706 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNSCf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 13:02:35 -0500
Received: by mail-ot1-f66.google.com with SMTP id 94so5631122oty.8;
        Thu, 14 Nov 2019 10:02:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=roHKXqEzr+oQ+k37cODl0U/848kN5EdR38H27KFmW5Q=;
        b=Or66Qjy5oVUH1usMZTMRGmruAxQQCH691vnHSE8Uuj34sdPkfRPfoYP5JwSrKRZbpl
         iPjq/VckumnghCschb5mBjLPCqLw0u0P3f0YBsEoHA7piESTakOwN9c0HbNdAMRjDGUv
         3uZDaj+m9PHKAdOEHRqhmomlLda1tnuGB4jbFP4AQ9EpGtZ+mW/AaD7ZRH+oXHKEyNu4
         MWA93nNYTzkkoGD2M0aWBgTh4k9PfGYuevgtE2U2mf/2tLAqd54zDjpjRZxZWxkX1bct
         IuiZZ6UBjDoMWVc9nYfcStF35IdD93JkJH+Q3WJAr3hdU45A1HZ9FxEVwC518Za6/p5o
         I+bQ==
X-Gm-Message-State: APjAAAWPow6fKQ41GuqAdvpEJlnyjZ15G3DccspM3URBKjW/pLhwbJX3
        i4fE/3Zml2XY4HwY4kAuQA6N6dM=
X-Google-Smtp-Source: APXvYqwlGYgyxTe5paTFfud5Cq30NdwfF11ZMzTy+XWh+/8i7cDxYzCKjU91tB+ioJFNGetNVWu4zw==
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr7722102otb.193.1573754554506;
        Thu, 14 Nov 2019 10:02:34 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m205sm1993968oif.10.2019.11.14.10.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 10:02:33 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:02:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        mark.rutland@arm.com, orsonzhai@gmail.com, baolin.wang7@gmail.com,
        freeman.liu@unisoc.com, zhang.lyra@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: thermal: sprd: Add the Spreadtrum
 thermal documentation
Message-ID: <20191114180233.GA14860@bogus>
References: <0a6b113010ad772a633b9cfeeb280dc41f17b951.1573206815.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a6b113010ad772a633b9cfeeb280dc41f17b951.1573206815.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 08, 2019 at 05:54:30PM +0800, Baolin Wang wrote:
> From: Freeman Liu <freeman.liu@unisoc.com>
> 
> Add the Spreadtrum thermal documentation.
> 
> Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/thermal/sprd-thermal.txt   |   41 ++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sprd-thermal.txt

Please make this a schema. See Documentation/devicetree/writing-schema.rst

> 
> diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.txt b/Documentation/devicetree/bindings/thermal/sprd-thermal.txt
> new file mode 100644
> index 0000000..a9da7f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.txt
> @@ -0,0 +1,41 @@
> +* Spreadtrum thermal sensor controller bindings
> +
> +Required properties:
> +- compatible : Should be "sprd,ums512-thermal"
> +- reg: Address range of the thermal registers
> +- clock-names: "enable" for thermal module enable clock.
> +- clocks: Should contain a clock specifier for each entry in clock-names.
> +- nvmem-cells: A phandle to the calibration data provided by a nvmem device.
> +- nvmem-cell-names: Should be "thm_sign_cal" and "thm_ratio_cal".
> +- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
> +
> +Child nodes properties:
> +- reg: Specify the sensor id.
> +- nvmem-cells: A phandle to the calibration data provided by a nvmem device.
> +- nvmem-cell-names: Should be "sen_delta_cal".
> +
> +Example:
> +
> +	ap_thm0: thermal@32200000 {
> +		compatible = "sprd,ums512-thermal";
> +		reg = <0 0x32200000 0 0x10000>;
> +		clock-names = "enable";
> +		clocks = <&aonapb_gate CLK_THM0_EB>;
> +		#thermal-sensor-cells = <1>;
> +		nvmem-cells = <&thm0_sign>, <&thm0_ratio>;
> +		nvmem-cell-names = "thm_sign_cal", "thm_ratio_cal";
> +
> +		prometheus0-sensor@0{

space                               ^

> +			reg = <0>;
> +			nvmem-cells = <&thm0_sen0>;
> +			nvmem-cell-names = "sen_delta_cal";
> +		};
> +
> +		ank1-sensor@1{

space                        ^

> +			reg = <1>;
> +			nvmem-cells = <&thm0_sen1>;
> +			nvmem-cell-names = "sen_delta_cal";
> +		};
> +
> +		......
> +	};
> -- 
> 1.7.9.5
> 

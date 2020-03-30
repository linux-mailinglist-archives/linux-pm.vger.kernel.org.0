Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A06F91987AE
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 01:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgC3XBE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 19:01:04 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41862 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3XBE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 19:01:04 -0400
Received: by mail-il1-f195.google.com with SMTP id t6so13987587ilj.8;
        Mon, 30 Mar 2020 16:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JgZzZGX2+1l0VTjeEuKjYHaxC21r8KeS0zKEfm2qAVs=;
        b=Hc8ThNRi5mxwLTBGG6u+Hq/dohlgY1THn7K4NdN9+d62bxEzxR9R99Flf1rKRuWFnK
         2R7dMldfhU/DD2hly0HaW5l7Ean+otKDnCAQwOU2z4fn3CUEOwYHq7hFKRSU9ToTnl/M
         dIIkzmQ5nOLT7BIDUqG8Lr2JJ2XIuAV3C5c6AOyCpdhNsC0amuS8wDbqlL5NMRRl9r3y
         9D1sFPcS/F4F8VE2Ih7q4GyG33d6IWRra3DaFizIFrqRN2B/DgzFqgquu6U1ynQPRIR7
         mRYUUVTL+OlCLDmPFtolL4dPLIO9EXkb/+wwoXMxNfxUwUJyDWdfbcKQpcQmxlQd3Tya
         ixsw==
X-Gm-Message-State: ANhLgQ1EiRN5B9H6/Ghf7rPXIuHaa8JUQStvsrynO0DpJCoiS2908399
        162cSVIAeKMOSD/QGl5jHA==
X-Google-Smtp-Source: ADFU+vtLyFwr4FXsEUk/I3P1I5kqV+BC9DO+oyzeHHyVLyI0YrYJpOTqJX7GI29JsPy2wasg0brZSQ==
X-Received: by 2002:a92:cb49:: with SMTP id f9mr13402280ilq.193.1585609261355;
        Mon, 30 Mar 2020 16:01:01 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x12sm2011163iov.55.2020.03.30.16.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:01:00 -0700 (PDT)
Received: (nullmailer pid 21284 invoked by uid 1000);
        Mon, 30 Mar 2020 23:00:59 -0000
Date:   Mon, 30 Mar 2020 17:00:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     rui.zhang@intel.com, robh+dt@kernel.org, daniel.lezcano@linaro.org,
        j-keerthy@ti.com, amit.kucheria@verdurent.com, t-kristo@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [RESEND PATCH v4 1/4] dt-bindings: thermal: k3: Add VTM bindings
 documentation
Message-ID: <20200330230059.GA21226@bogus>
References: <20200318083028.9984-1-j-keerthy@ti.com>
 <20200318083028.9984-2-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318083028.9984-2-j-keerthy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 18 Mar 2020 14:00:25 +0530, Keerthy wrote:
> Add VTM bindings documentation. In the Voltage Thermal
> Management Module(VTM), K3 AM654 supplies a voltage
> reference and a temperature sensor feature that are gathered in the band
> gap voltage and temperature sensor (VBGAPTS) module. The band
> gap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../bindings/thermal/ti,am654-thermal.yaml    | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

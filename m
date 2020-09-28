Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9326327B328
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 19:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgI1R0d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Sep 2020 13:26:33 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44212 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgI1R0d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2020 13:26:33 -0400
Received: by mail-oi1-f193.google.com with SMTP id 185so2170358oie.11;
        Mon, 28 Sep 2020 10:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Bg8Mb9Gv2pIoiwK87TIqBreNFfJwQnzcH+LXnQL+4E=;
        b=DKnyfgXTAWzRQeaW3JaGxzzoiSP0dqnknMWsftAehv4tdc2OeHIJAbqoFraSdjqOu4
         QuC11py4w0cv3dl0kggtBOb5tWsdVhQfz+ktlbeZyItsUIjVObT9XgV5cI5MdKB7/0oz
         Crv0RtmZHjWcVbRnEWu+xY2GJ7+GgoOjT+CGXB6qc4ph/VAnXxJXQXm0SyHkaUrSYZgU
         E90My/BaNRR9Bcv9CF/Ba5nLiD4l1Mi/c3JlRNSAGlNf1jfxNR4aimdTRqmp/442AWNl
         n4KraUiMG/4TfDG2L7Egf+xCusXknSn2yFfT3aFgjTW9F5p4oMa5vXkdbbHscnxt1ORg
         4ZHw==
X-Gm-Message-State: AOAM532e/W+wCx/kKtwVgbyD32AwJBMAaeDb5yxdP2jIAvbbI51zo/gt
        yh6rc92gCcVeDiVylXIw3w==
X-Google-Smtp-Source: ABdhPJwXO9pq9TJEGuCXdjVBWwl4RWh6eeuKeJMcErJlWKZi0dMMVwHrqzNAx4K4wDL4I9iZT4xUhA==
X-Received: by 2002:a05:6808:914:: with SMTP id w20mr1614438oih.72.1601313992499;
        Mon, 28 Sep 2020 10:26:32 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y23sm2207192ooj.34.2020.09.28.10.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:26:31 -0700 (PDT)
Received: (nullmailer pid 2933713 invoked by uid 1000);
        Mon, 28 Sep 2020 17:26:31 -0000
Date:   Mon, 28 Sep 2020 12:26:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     kholk11@gmail.com
Cc:     linux-pm@vger.kernel.org, konradybcio@gmail.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        marijns95@gmail.com, martin.botka1@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, phone-devel@vger.kernel.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: interconnect: Add bindings for Qualcomm
 SDM660 NoC
Message-ID: <20200928172631.GA2933280@bogus>
References: <20200926125101.12712-1-kholk11@gmail.com>
 <20200926125101.12712-3-kholk11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926125101.12712-3-kholk11@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 26 Sep 2020 14:51:01 +0200, kholk11@gmail.com wrote:
> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> Add the bindings for the Qualcomm SDM660-class NoC, valid for
> SDM630, SDM636, SDM660 and SDA variants.
> 
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> ---
>  .../bindings/interconnect/qcom,sdm660.yaml    | 146 ++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/interconnect/qcom,sdm660.example.dts:64.33-34 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/interconnect/qcom,sdm660.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1366: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1371756

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7CF212E1A
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 22:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgGBUs7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 16:48:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36133 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgGBUs6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 16:48:58 -0400
Received: by mail-io1-f67.google.com with SMTP id y2so30366492ioy.3;
        Thu, 02 Jul 2020 13:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HmX76XVNFdnKdNstB4FEQ2AG2VQGUy0YrDhBLWg+PgM=;
        b=dgxQ/cpqkJW6RTq2C3anEP0SFffv4kNfh0VBcKSVm+6AtBy8AiwkCnrVlRlNGrp7UE
         XoackCD2FZFhzQI28tmc8vKvMGXbNLn+B5SdOIAS+cA3RqxgFp2YcI6+1dPjaVSOm3QG
         8PHvvGaKob69LzlfxYRvtsADVOLBGwlVdc95KGIvPH0p1KygncOUE2ATJdfPSJrr6Oo1
         ov57nCyc4yAAHQprqvE7pJ1ddhbHC9i2tgpmnxN/tkgKXoAf19qMqjaF+Z7tWl7O1qR3
         EIkn8rdz1B60Bvtl27JbQDPX4MmsGnd+z+hIFkUw0whXjgt0iygDqzSzkuSi5sbYJxep
         tIPA==
X-Gm-Message-State: AOAM530Q6YHmTkqZ6G098222Eu/XKS5Fu8Q75P1F3TjwZnfeREYx9sTU
        LGrCtITKj94kRmuhB7hmpD910fXjbg==
X-Google-Smtp-Source: ABdhPJyWpYN6OwRJqIZaEkMX30sxRTZIy/tJA5Eq8b9+H5/O56nWoEuFhugPb7AijBkTbRKP8mhhdg==
X-Received: by 2002:a6b:ba06:: with SMTP id k6mr9404438iof.101.1593722937715;
        Thu, 02 Jul 2020 13:48:57 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u3sm4912873iol.41.2020.07.02.13.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:48:57 -0700 (PDT)
Received: (nullmailer pid 1667287 invoked by uid 1000);
        Thu, 02 Jul 2020 20:48:55 -0000
Date:   Thu, 2 Jul 2020 14:48:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: interconnect: Add Qualcomm SM8150 DT
 bindings
Message-ID: <20200702204855.GA1667062@bogus>
References: <20200701134259.8055-1-jonathan@marek.ca>
 <20200701134259.8055-2-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701134259.8055-2-jonathan@marek.ca>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 01 Jul 2020 09:42:50 -0400, Jonathan Marek wrote:
> The Qualcomm SM8150 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  .../bindings/interconnect/qcom,sm8150.yaml    |  86 +++++++++
>  .../dt-bindings/interconnect/qcom,sm8150.h    | 176 ++++++++++++++++++
>  2 files changed, 262 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8150.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm8150.h
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interconnect/qcom,sm8150.yaml: maintainers:0: None is not of type 'string'
Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/interconnect/qcom,sm8150.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/interconnect/qcom,sm8150.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interconnect/qcom,sm8150.yaml: ignoring, error in schema: maintainers: 0
warning: no schema found in file: ./Documentation/devicetree/bindings/interconnect/qcom,sm8150.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interconnect/qcom,sm8150.yaml: ignoring, error in schema: maintainers: 0
warning: no schema found in file: ./Documentation/devicetree/bindings/interconnect/qcom,sm8150.yaml
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1320475

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.


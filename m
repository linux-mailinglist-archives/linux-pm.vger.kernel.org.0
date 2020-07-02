Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAC9212E24
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 22:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgGBUtu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 16:49:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37996 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBUtt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 16:49:49 -0400
Received: by mail-io1-f65.google.com with SMTP id f6so14772283ioj.5;
        Thu, 02 Jul 2020 13:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XzLpcf7CcS/oVOwQYs0GPpvRirY2Ca0yQdf8D43DIZg=;
        b=V1f+p28iqGot29kEmj25pe6hBmPfkiu8evJt0nGGcyDqJQIQb1XrtKveqLLU5w75eL
         9WQZq17ofTqtwujSp+2kMA2Ofqy3E3rMJF4iLeaGAy71oKwAdiFDRNH8hI0bozUhBzl0
         voRKaF0JrLD93KNu38X9vgnjo3luEJRuvy01p2Lt01qXPI3ox6vNOITEYZTroY+b9TPc
         pItlrh6V8CB2qFm8vxdb1FCrWYjlrvxWaCDEn6TKX48D34HRTABGfLmbvpBpuF84qxjN
         /f9JwipoK4fEankcdQIIsib9PIRMNYEw/YbGL3MwFsHnhwgEqpZjGCda4Th451s8/xLc
         LsNg==
X-Gm-Message-State: AOAM530XJi8PLX0K3RM8YJRuFvCr2oo2YilxRNnMFJOef0JeLwkqLxTA
        JkGE2ynZ5IrjY9LVMF9xFQ==
X-Google-Smtp-Source: ABdhPJzKY7Kn8pNstBNaygcxz0f54rhVnS6jXoeRubrWxYvji2N9q1N3qXAvyqB2G4t8JcfjTau/dg==
X-Received: by 2002:a05:6638:252:: with SMTP id w18mr23286747jaq.42.1593722988798;
        Thu, 02 Jul 2020 13:49:48 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b24sm4926398ioh.6.2020.07.02.13.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:49:48 -0700 (PDT)
Received: (nullmailer pid 1668549 invoked by uid 1000);
        Thu, 02 Jul 2020 20:49:47 -0000
Date:   Thu, 2 Jul 2020 14:49:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: interconnect: Add Qualcomm SM8250 DT
 bindings
Message-ID: <20200702204947.GB1667979@bogus>
References: <20200701134259.8055-1-jonathan@marek.ca>
 <20200701134259.8055-3-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701134259.8055-3-jonathan@marek.ca>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 01 Jul 2020 09:42:51 -0400, Jonathan Marek wrote:
> The Qualcomm SM8250 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  .../bindings/interconnect/qcom,sm8250.yaml    |  86 ++++++++
>  .../dt-bindings/interconnect/qcom,sm8250.h    | 186 ++++++++++++++++++
>  2 files changed, 272 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8250.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm8250.h
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interconnect/qcom,sm8250.yaml: maintainers:0: None is not of type 'string'
Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/interconnect/qcom,sm8250.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/interconnect/qcom,sm8250.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interconnect/qcom,sm8250.yaml: ignoring, error in schema: maintainers: 0
warning: no schema found in file: ./Documentation/devicetree/bindings/interconnect/qcom,sm8250.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interconnect/qcom,sm8250.yaml: ignoring, error in schema: maintainers: 0
warning: no schema found in file: ./Documentation/devicetree/bindings/interconnect/qcom,sm8250.yaml
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1320476

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.


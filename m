Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715EB292EFD
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 21:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgJST4o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 15:56:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40843 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgJST4o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 15:56:44 -0400
Received: by mail-oi1-f196.google.com with SMTP id m128so1294670oig.7;
        Mon, 19 Oct 2020 12:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=23Zp+C8KK8nVcIY9VL1O7eVl2RcnWdhRoLOkGuAWNbQ=;
        b=TVZHD7+Id+8Yvehn558nEkF7LcwZP1mkbJpcMh7q3Z5JQqr7ESJgJ7BheO05TdSw8t
         CNE5i8hfYuh5yzFNVAahlFlZxYU7GfC276lhUBy79ZY+2kjMhYdFPer+LX5s1zKhkonO
         B0GBeF2o+TLbo+lvEfpWxVljr5b/og16jof4Tpyn5IPn/w4Gpguk8dV16OICKzEir0ft
         F3wYhVyKUKOkjBk75iJSeAEaNoaLSH40KS9Fch4TtjFFX6IAke959l4R6krtW4jPiQZC
         nLE/226lFjKe87iHzaCfnUTvOpca6i0VRfJ4BSWYDW+V+rvEZL+3Qc0ieMSXyPWiMuhK
         a5xw==
X-Gm-Message-State: AOAM531Gl1oVf9dw04eV4Yo6heml8skFd3Wv1MZqfvN1KkdwktnxVrxT
        n290WH4ZKFrdieGqsyYb6Q==
X-Google-Smtp-Source: ABdhPJyHQVxjxdAKRHg1ACY5unwmSP3mLUt0jmtL5us9FuPThq5kJYZp/utXDqftUh/mD53ggRv5Gg==
X-Received: by 2002:a05:6808:344:: with SMTP id j4mr690400oie.105.1603137402143;
        Mon, 19 Oct 2020 12:56:42 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k6sm176971otp.33.2020.10.19.12.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:56:41 -0700 (PDT)
Received: (nullmailer pid 3506591 invoked by uid 1000);
        Mon, 19 Oct 2020 19:56:40 -0000
Date:   Mon, 19 Oct 2020 14:56:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     kholk11@gmail.com
Cc:     robh+dt@kernel.org, martin.botka1@gmail.com,
        linux-kernel@vger.kernel.org, marijns95@gmail.com,
        bjorn.andersson@linaro.org, konradybcio@gmail.com,
        phone-devel@vger.kernel.org, agross@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: Re: [PATCH v4 1/2] dt-bindings: interconnect: Add bindings for
 Qualcomm SDM660 NoC
Message-ID: <20201019195640.GA3506059@bogus>
References: <20201017133718.31327-1-kholk11@gmail.com>
 <20201017133718.31327-2-kholk11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017133718.31327-2-kholk11@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 17 Oct 2020 15:37:17 +0200, kholk11@gmail.com wrote:
> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> Add the bindings for the Qualcomm SDM660-class NoC, valid for
> SDM630, SDM636, SDM660 and SDA variants.
> 
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> ---
>  .../bindings/interconnect/qcom,sdm660.yaml    | 147 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,sdm660.h    | 116 ++++++++++++++
>  2 files changed, 263 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm660.h
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/interconnect/qcom,sdm660.example.dts:20:18: fatal error: dt-bindings/clock/qcom,mmcc-sdm660.h: No such file or directory
   20 |         #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/interconnect/qcom,sdm660.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1366: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1383662

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.


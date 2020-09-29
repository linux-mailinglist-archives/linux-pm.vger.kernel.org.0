Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5620927D1A5
	for <lists+linux-pm@lfdr.de>; Tue, 29 Sep 2020 16:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgI2OnX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 10:43:23 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:47074 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgI2OnX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2020 10:43:23 -0400
Received: by mail-oo1-f67.google.com with SMTP id b12so1330299oop.13;
        Tue, 29 Sep 2020 07:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6bgECZ9uqVfvJbocL8Cxkr581j2QQ4ktwy9AOE+ABj0=;
        b=lYhycORRmA6ytx6j9muoZcFuBec7pd1tOfLw+VKEIehHPjLHa3XaHYiT7kn/bE0vhX
         7WKbsEeqHLeRKWexDEUeWx7HLIffMn4Pnx7UPnn1I8X0Lq1NyplDbQVbrt5FbDs+Gi6N
         0EkG/VfSH67tjoU2J1T5Jt4NmHAXP/4OCLAWaM9FK78RpnqrZ1k/fs0v5sS26bz9nTx/
         SZ2idh5iYBJ2M24GLzIeRIjrPpx5PAuvvg9U3QBgEx1Z5/ytGGEyPMyyLj60U7Tpy26g
         XE8UBiEYSEXJTTtgAJU4thIQI8szppTLb0QhzmemuLvvGQuWFIz0ie7dyqLhpSu5uipK
         cBXg==
X-Gm-Message-State: AOAM532mfUhsq6pR1r0ERXFEe8UgUzAQipv/bGj6cT/iOboGlfmQKmCD
        q6yvgsML4xUvV+huJo812A==
X-Google-Smtp-Source: ABdhPJyhKRuXHenxEEbcJRR3XpS7OSTwtwMBjFAFyQvdVeSkYH+HePX6cjvIUGv3FOkseJr8KsxsoA==
X-Received: by 2002:a4a:b30d:: with SMTP id m13mr4771067ooo.50.1601390602115;
        Tue, 29 Sep 2020 07:43:22 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c14sm3106413ooi.9.2020.09.29.07.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 07:43:21 -0700 (PDT)
Received: (nullmailer pid 559478 invoked by uid 1000);
        Tue, 29 Sep 2020 14:43:20 -0000
Date:   Tue, 29 Sep 2020 09:43:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     kholk11@gmail.com
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, konradybcio@gmail.com,
        phone-devel@vger.kernel.org, georgi.djakov@linaro.org,
        linux-pm@vger.kernel.org, robh+dt@kernel.org, marijns95@gmail.com,
        martin.botka1@gmail.com
Subject: Re: [PATCH v2 2/2] dt-bindings: interconnect: Add bindings for
 Qualcomm SDM660 NoC
Message-ID: <20200929144320.GA557822@bogus>
References: <20200928195853.40084-1-kholk11@gmail.com>
 <20200928195853.40084-3-kholk11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928195853.40084-3-kholk11@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 28 Sep 2020 21:58:53 +0200, kholk11@gmail.com wrote:
> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> Add the bindings for the Qualcomm SDM660-class NoC, valid for
> SDM630, SDM636, SDM660 and SDA variants.
> 
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> ---
>  .../bindings/interconnect/qcom,sdm660.yaml    | 147 ++++++++++++++++++
>  1 file changed, 147 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/interconnect/qcom,sdm660.example.dts:20:18: fatal error: dt-bindings/clock/qcom,mmcc-sdm660.h: No such file or directory
   20 |         #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/interconnect/qcom,sdm660.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1366: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1372879

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.


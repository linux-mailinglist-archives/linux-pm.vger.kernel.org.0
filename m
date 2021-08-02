Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AEA3DE2B3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 00:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhHBWxD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Aug 2021 18:53:03 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:42942 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhHBWxD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Aug 2021 18:53:03 -0400
Received: by mail-io1-f54.google.com with SMTP id h1so22161785iol.9;
        Mon, 02 Aug 2021 15:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l3k+Dbfzm+AqaMGsa9092gdtZIDl2wnkPj179mOLIQU=;
        b=Qz9wolmYPooB3iq6Tqvg3QnyolbWh+Y/X54Zz1oXVh5X/dcYbLZys6c3hNK2SEGttp
         3CTo6GN2tjcyWsYzNM0zcq7TwjPxRVb6Pp3paJGHA57g5/+8CjgF8FQKAVKl7lr5qAIV
         OV9FNRHarIEiGyG3D9bc+qbE67FWIwdcUnbZxAowjsHvH0kmlXLcambKpiBjB9z8DpkA
         Y3/fUk/zjVcDQnmN2FlGjUAqn+x5Hhd+abmksBuEIRHNloZdWOyhWZdc7iogoZstOQ4D
         8/3cItswrVJ5jTN34hISBQyIxBIjiTIaJJOvgmJTN6YkJypNKc4a1ABuU9Cuqu5pZdKa
         +LQg==
X-Gm-Message-State: AOAM531y+E+prkRhjF7X3oaPnMxfpwYWSAusMPdpY4ju5YP/Y8qHfFLs
        n+dUA2MGdW77bCUYHvZANQ==
X-Google-Smtp-Source: ABdhPJznWzBh8yim+/rRl7z+13aP35MOjjOhi/HQygnLIKFNXeK/GJDcDCZv+NZWetNtviITcmGj6A==
X-Received: by 2002:a02:698f:: with SMTP id e137mr14018833jac.89.1627944771812;
        Mon, 02 Aug 2021 15:52:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b8sm5982485ilh.74.2021.08.02.15.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:52:51 -0700 (PDT)
Received: (nullmailer pid 1774382 invoked by uid 1000);
        Mon, 02 Aug 2021 22:52:48 -0000
Date:   Mon, 2 Aug 2021 16:52:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     martin.botka@somainline.org, daniel.lezcano@linaro.org,
        bartosz.dudziak@snejp.pl, ~postmarketos/upstreaming@lists.sr.ht,
        stephan@gerhold.net, agross@kernel.org, rjw@rjwysocki.net,
        phone-devel@vger.kernel.org, marijn.suijten@somainline.org,
        linux-arm-msm@vger.kernel.org, jeffrey.l.hugo@gmail.com,
        jami.kettunen@somainline.org, devicetree@vger.kernel.org,
        konrad.dybcio@somainline.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH v8 2/5] dt-bindings: soc: qcom: Add devicetree binding
 for QCOM SPM
Message-ID: <YQh3QJN6jkYLAFrj@robh.at.kernel.org>
References: <20210729155609.608159-1-angelogioacchino.delregno@somainline.org>
 <20210729155609.608159-3-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729155609.608159-3-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 29 Jul 2021 17:56:06 +0200, AngeloGioacchino Del Regno wrote:
> Add devicetree binding for Qualcomm Subsystem Power Manager (SPM).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../bindings/soc/qcom/qcom,spm.yaml           | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

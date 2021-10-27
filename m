Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E028843D2F0
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 22:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbhJ0Uib (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 16:38:31 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:33412 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243907AbhJ0Uia (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Oct 2021 16:38:30 -0400
Received: by mail-oi1-f172.google.com with SMTP id q129so5256197oib.0;
        Wed, 27 Oct 2021 13:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tCPDN2NKy7zH086MRPJsgjN8SkN7UBBWbdtpfQKyI0A=;
        b=Xm/yfBqxW5ZBQ+SB68Dun7iiIsTqjbg2iDdGhKP1CopxM0uIYZ9LPO0el3zLHyBCE9
         U+/6qIfPtSn4qYQ6bZlqE/17/t38S2DRvMcgTnyVZEOpMMA64EwhYUwsRU1vmHXQZIhy
         psUOiSuXtAfgt/lPSJ9+UkYDcZjWdWbpc4Um3WFZZXC3N4PXIrpgp0H7ZoUgaiKzE09x
         GkDspQh584U/jndeCS9IVHM0Z/W70dLIOCHksqMuGp5+OmM6wziklETOlXxvKIqWBF9L
         DZLq8/x6C6j/sgD3zFxcKxf1bbLZENyWhmpFrhnha7ALW+l0gJ/VPomzoFOXJYnnDRHo
         4ZrA==
X-Gm-Message-State: AOAM53389n0Xbm36r569MANglAmgLL2E/oYYBY5Id52p6mzlrY9k8UQ4
        lLxoplaIhfXgLKYM3s4wzA==
X-Google-Smtp-Source: ABdhPJwnEQUmsz6P+GvWdlDpiiibtPU66ZBDUY/rV2fjBdmNCZBaPJ74/HkGtZ8ClE+MZV4fYaScQg==
X-Received: by 2002:a05:6808:ec9:: with SMTP id q9mr5245501oiv.160.1635366963931;
        Wed, 27 Oct 2021 13:36:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n17sm363474oic.21.2021.10.27.13.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:36:03 -0700 (PDT)
Received: (nullmailer pid 2108583 invoked by uid 1000);
        Wed, 27 Oct 2021 20:36:02 -0000
Date:   Wed, 27 Oct 2021 15:36:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH RESEND v5 3/5] dt-bindings: interconnect: Add Qualcomm
 MSM8996 DT bindings
Message-ID: <YXm4MiOiA0HL+Q9w@robh.at.kernel.org>
References: <20211021132329.234942-1-y.oudjana@protonmail.com>
 <20211021132329.234942-4-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021132329.234942-4-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 21 Oct 2021 13:24:54 +0000, Yassine Oudjana wrote:
> Add bindings for interconnects on Qualcomm MSM8996.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
> Changes since v4:
>  - Rebase on Dmitry's icc-rpm patches.
>  - Add support for Aggregate 0 NoC (a0noc).
> Changes since v2:
>  - Dual-license qcom,msm8996.h and move it to the dt bindings patch
> 
>  .../bindings/interconnect/qcom,rpm.yaml       |  42 +++++
>  .../dt-bindings/interconnect/qcom,msm8996.h   | 163 ++++++++++++++++++
>  2 files changed, 205 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8996.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

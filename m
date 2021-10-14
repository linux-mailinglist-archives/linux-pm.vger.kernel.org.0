Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD75C42DBA8
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 16:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhJNOdV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 10:33:21 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:43662 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhJNOdP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 10:33:15 -0400
Received: by mail-ot1-f45.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so8449070otb.10;
        Thu, 14 Oct 2021 07:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=OXi4CKPDh7/N1pN8IG05ZecyGMde2b/PbFQW4WycOgo=;
        b=VbSzAUG9bA5Z4o0Psg8/+KNL15F5pBTrxRNrfS8gv/hHF56F6cU8xnCDbDR+yHG35Z
         Pd6pmGvBnjWzyWMTwcy73PB746Bl1mwoMkwNbzAsmKk7HSo9KZTwjkWkLW6UZOQAdAQN
         QrdM8re6f3A3Ojvz3cRBYZryTt7Y7jlr8VOuMx+8xi7quaylW86h2swrBvfxSQ3ivxQa
         9sbhJPd5axZ/LUWxig9u613rQYqVxt+TFOmSqKQOnDIDdTjRQz443BlcuNUum41gxYrn
         DPUxP7HyzNwb82dC2UljCEZJIKMBeKRS9ZJyeTgb6afCYsjgytB8mNnsNibkv2cO134L
         4pfA==
X-Gm-Message-State: AOAM531mhrM8LOyl71iuM7zJiUxEOq608n3GZftu5mQaDNi6URup82Cq
        w+VjzxzgREQQT5dM36bWsA==
X-Google-Smtp-Source: ABdhPJytJeoNVXGNls7KXBsOhvoCXJSUsHyQu5OFOYc7jd9y/ZqbuQyDwTQefZJcWpgj7LR3FVHKUw==
X-Received: by 2002:a05:6830:1442:: with SMTP id w2mr2732523otp.76.1634221869460;
        Thu, 14 Oct 2021 07:31:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h26sm479552oov.28.2021.10.14.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:31:08 -0700 (PDT)
Received: (nullmailer pid 3295881 invoked by uid 1000);
        Thu, 14 Oct 2021 14:31:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Nishanth Menon <nm@ti.com>, phone-devel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-clk@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>, linux-pm@vger.kernel.org
In-Reply-To: <20211014083016.137441-2-y.oudjana@protonmail.com>
References: <20211014083016.137441-1-y.oudjana@protonmail.com> <20211014083016.137441-2-y.oudjana@protonmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: clk: qcom: msm8996-apcc: Add CBF
Date:   Thu, 14 Oct 2021 09:31:04 -0500
Message-Id: <1634221864.186240.3295880.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 14 Oct 2021 08:31:32 +0000, Yassine Oudjana wrote:
> Add CBF clock and reg.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../devicetree/bindings/clock/qcom,msm8996-apcc.yaml   | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1540828


clock-controller@6400000: clock-names:0: 'pwrcl_pll' was expected
	arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml

clock-controller@6400000: clock-names: ['xo'] is too short
	arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml

clock-controller@6400000: clocks: [[29]] is too short
	arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml

clock-controller@6400000: clocks: [[33]] is too short
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml

clock-controller@6400000: clocks: [[36]] is too short
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml

clock-controller@6400000: clocks: [[41]] is too short
	arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml

clock-controller@6400000: reg: [[104857600, 589824]] is too short
	arch/arm64/boot/dts/qcom/apq8096-db820c.dt.yaml
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dt.yaml
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dt.yaml


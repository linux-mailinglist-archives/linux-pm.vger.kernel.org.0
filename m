Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571CC42DBAC
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 16:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhJNOdX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 10:33:23 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:46893 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhJNOdQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 10:33:16 -0400
Received: by mail-oi1-f174.google.com with SMTP id o204so8658560oih.13;
        Thu, 14 Oct 2021 07:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=LIGlTpgW1tWbiwTKp+gXJ96FX9IdJratUHQ3TqZY3b0=;
        b=hxNTomxh9KLjQqCp7hx1ediqTfBIGVdG8ECwk++KSI3sxSNQgO7c3C4fRWDpxZ1iB4
         GbhjAU38CzcuAQFBCdIjRm8rmDPNGfTqJEFtKqPLD9T4karGOe+O1zjVViMsFEAYefSR
         pKqPin/Nku3wN4lilU7baI2/nfTqXspm6H3GGez+/cLDhCP+kk/f1+jseT0BvERLAxyE
         UD+EYcfMI2gUKWQp0MCTxRep8Adzkc5axRhXNCcUIpETicoG7Ok6TqOmuKr6Odq8i+lq
         UgpgOzs0PycNISP7Zc7/Ja9BzbMlj6jC6by5Gwy+O3Rbty5KYKdGzBhOToLK2SXLSPAK
         VyOw==
X-Gm-Message-State: AOAM533K7Ur5nkBdnw33Eb8K1wSfggMQ+n5mLEF0IL+cZK5Dc9xjc9ak
        7mt0uQ67SaZ53y4s01UfsA==
X-Google-Smtp-Source: ABdhPJw/trDzPyr4wm7mQqsmQls0HHi+6ZgTWKM/1st60QAbZ/vPRbSVcXQBdXrjDoyPcU+mZ85fXQ==
X-Received: by 2002:a05:6808:1250:: with SMTP id o16mr4293459oiv.63.1634221871201;
        Thu, 14 Oct 2021 07:31:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x18sm472578oov.13.2021.10.14.07.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:31:10 -0700 (PDT)
Received: (nullmailer pid 3295883 invoked by uid 1000);
        Thu, 14 Oct 2021 14:31:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <20211014083016.137441-3-y.oudjana@protonmail.com>
References: <20211014083016.137441-1-y.oudjana@protonmail.com> <20211014083016.137441-3-y.oudjana@protonmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: clk: qcom: msm8996-apcc: Add MSM8996 Pro compatible
Date:   Thu, 14 Oct 2021 09:31:04 -0500
Message-Id: <1634221864.197594.3295882.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 14 Oct 2021 08:32:04 +0000, Yassine Oudjana wrote:
> Add a compatible string for msm8996pro-apcc.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1540829


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


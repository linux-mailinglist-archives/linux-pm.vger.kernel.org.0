Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D453F615C
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 17:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhHXPQG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 11:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbhHXPP5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Aug 2021 11:15:57 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84386C061757
        for <linux-pm@vger.kernel.org>; Tue, 24 Aug 2021 08:15:13 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso35720945ots.5
        for <linux-pm@vger.kernel.org>; Tue, 24 Aug 2021 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Y0kEI+D7S9zjGZEzmEP8rK0NWN9F8ml/ZbrO8rwdGoc=;
        b=rpzC8nqxjtvlgOqu4Uo6ccz/R+Z9Mz/PUr0z6mqMTfmcAcPvdbwnY1pM9fWcLoiyU0
         byO8XEiEF2wd2Q4puMGrpWxD8U0n/OzuaHpj6RxYfjjQAjOEFAvYeGi3Lqdvlc05lj/L
         aHg2aXuHPKooUP4bfqcCg436MQLO96qifEhk30pU2o/ZMqOHew6lV1LDVFbzGhRVNfRU
         CJezKjjDGy0UbjzsLbMCfFrutA2zwgoMr1nKsRvRNzhUYDFCSRWJ3fFigXkCbthkAf4O
         ckmc3KAPsAWoLxUMmyOOrh1YZBvdeFT3uIpjp9P3jxBSDBsw0zNEdWEN+0HMP6pcmeij
         F6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Y0kEI+D7S9zjGZEzmEP8rK0NWN9F8ml/ZbrO8rwdGoc=;
        b=kJgwtAnU2tWLBhLLrby5M/jfbbJaFxsbVhmVbFL8vawt+ZFAOUtKHJ2k9lcCjwdU6v
         8QKHJVPUxb6wBFb229i1uHhJqhfEYHcBLdHdlpWxvENaKCB4HbEnbkRkjb1adAlIiJ7L
         4+Jhkd8aWcOZXChJHhGCrZgE7FqeduXDotFpmtiGP7fX8+lxb9W7giNV1VoJG4XNJVbl
         0Nfkj5/g5ihn2OlUZ9o5NMwzGqASrACNWL5+upxUwW8sud7RXN+x728Q/jxaBnB+46yq
         fbHQs8+/wXlKoMCgwt2/Cfb1aFZmxYaf1al5d1vQhvYmef4+dGqVlzzgP9W4xGLaKQL5
         03nA==
X-Gm-Message-State: AOAM531MQiC34yfStECC7VUT0VS9E1poNNKzXyZ5R8cZ1u2S8fAKSrMc
        rozEPi85hZ9eRP6xdbxbEGCosA==
X-Google-Smtp-Source: ABdhPJy3vWSiA1OB3S6Pa+SAzoYPn7AL7zqAhUal6qCFvatvxLOdzfyVzN/0FcFLwW6PJ5dPWSuZlw==
X-Received: by 2002:aca:3193:: with SMTP id x141mr3216871oix.110.1629818110048;
        Tue, 24 Aug 2021 08:15:10 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b2sm3566712ook.46.2021.08.24.08.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:15:09 -0700 (PDT)
Date:   Tue, 24 Aug 2021 08:16:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/39] arm64: dts: qcom: sdm630: Add TSENS node
Message-ID: <YSUNSmgeGgc+x5xA@ripper>
References: <20210728222542.54269-1-konrad.dybcio@somainline.org>
 <20210728222542.54269-15-konrad.dybcio@somainline.org>
 <860f1120-c5a4-f531-3ea9-aa90c6b063dc@linaro.org>
 <2318377c-959a-a42b-81b5-44e2629570d5@somainline.org>
 <afee55a8-d7d3-709a-ea4f-0306698c9976@linaro.org>
 <b16d8000-85a7-d957-77d2-d921e5b09829@somainline.org>
 <a7f90fe0-ee24-a47d-089d-e716a5766fcd@linaro.org>
 <2ffc4e54-a501-bd2d-3f29-a6df34023445@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ffc4e54-a501-bd2d-3f29-a6df34023445@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 29 Jul 06:48 PDT 2021, AngeloGioacchino Del Regno wrote:

> Il 29/07/21 13:14, Thara Gopinath ha scritto:
> > 
> > 
> > On 7/29/21 6:55 AM, Konrad Dybcio wrote:
> > > 
> > > On 29.07.2021 12:54, Thara Gopinath wrote:
> > > > 
> > > > 
> > > > On 7/29/21 6:52 AM, Konrad Dybcio wrote:
> > > > > 
> > > > > On 29.07.2021 12:50, Thara Gopinath wrote:
> > > > > > Hi Konrad,
> > > > > > 
> > > > > > On 7/28/21 6:25 PM, Konrad Dybcio wrote:
> > > > > > > This will enable temperature reporting for various SoC
> > > > > > > components.
> > > > > > > 
> > > > > > > Signed-off-by: AngeloGioacchino Del Regno
> > > > > > > <angelogioacchino.delregno@somainline.org>
> > > > > > > Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > > > > > > ---
> > > > > > >     .../devicetree/bindings/thermal/qcom-tsens.yaml       |  1 +
> > > > > > >     arch/arm64/boot/dts/qcom/sdm630.dtsi                  | 11 +++++++++++
> > > > > > >     2 files changed, 12 insertions(+)
> > > > > > > 
> > > > > > > diff --git
> > > > > > > a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > > > > > > b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > > > > > > index 4a2eaf28e3fd..d3b9e9b600a2 100644
> > > > > > > --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > > > > > > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > > > > > > @@ -48,6 +48,7 @@ properties:
> > > > > > >                   - qcom,sc7180-tsens
> > > > > > >                   - qcom,sc7280-tsens
> > > > > > >                   - qcom,sc8180x-tsens
> > > > > > > +              - qcom,sdm630-tsens
> > > > > > >                   - qcom,sdm845-tsens
> > > > > > >                   - qcom,sm8150-tsens
> > > > > > >                   - qcom,sm8250-tsens
> > > > > > > diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> > > > > > > b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> > > > > > > index 1e54828817d5..7e9c80e35fba 100644
> > > > > > > --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> > > > > > > +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> > > > > > > @@ -627,6 +627,17 @@ mnoc: interconnect@1745000 {
> > > > > > >                      <&mmcc AHB_CLK_SRC>;
> > > > > > >             };
> > > > > > >     +        tsens: thermal-sensor@10ae000 {
> > > > > > > +            compatible = "qcom,sdm630-tsens", "qcom,tsens-v2";
> > > > > > > +            reg = <0x010ae000 0x1000>, /* TM */
> > > > > > > +                  <0x010ad000 0x1000>; /* SROT */
> > > > > > > +            #qcom,sensors = <12>;
> > > > > > 
> > > > > > Are all 12 sensors used ? I see that in a later patch
> > > > > > "arm64: dts: qcom: sdm630: Add thermal-zones
> > > > > > configuration" only 9 are used.
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > if I recall correctly, they all give output but not all of
> > > > > the mappings were documented in the downstream sources and
> > > > > we have no documentation whatsoever :(
> > > > 
> > > > Right. In that case, why not change #qcom,sensors to 9 and add
> > > > rest of the sensors if and when needed ?
> > > > 
> > > I don't think it makes sense to describe the hardware incorrectly,
> > > even if some of it is unused.
> > 
> > My thinking was more along the lines of don't expose unused h/w bits.
> > 
> 
> You're right about not exposing unused HW bits, but even PC x86 motherboards
> (I mean the smbus/i2c drivers for the big holy management/sensors chips) do
> have such a "base" configuration, where some lines are read as 0 because they
> are effectively not connected by hardware.
> 
> In order to avoid confusion to other developers, in my personal opinion, it would
> be good go for the current value of 12 (which isn't incorrect, as that's what the
> SoC supports)... I don't think that anyone would be confused by seeing zero
> readings on some sensors (if their device don't support such sensor), as I think
> that everyone is used to that anyway, even if that's in other circumstances...
> 
> In any case, luckily that's also safe, because there's no firmware that restricts
> the readings to a subset of sensors in this domain (nobody is going to get a
> hypervisor fault for that).
> 
> I would also, in case, propose to see how things go: I would expect other
> developers to push device trees for many SDM630/636/660 devices, including but
> not limited to smartphones and SBCs.. so perhaps if we find out that really
> nobody uses the 12 sensors, or if the very vast majority uses a different amount,
> perhaps we may just transfer the value to device-specific configurations in one
> go, as to avoid unnecessary noise... I think :)))
> 

If the SoC has 12 sensors I think it makes sense to define that, similar
to how a SoC might have 200 GPIOs, even though only a handful is
actually used.

Regards,
Bjorn

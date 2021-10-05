Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4382B421CCE
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 05:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhJEDN6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 23:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhJEDN5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 23:13:57 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED96C061745
        for <linux-pm@vger.kernel.org>; Mon,  4 Oct 2021 20:12:08 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id s69so24275787oie.13
        for <linux-pm@vger.kernel.org>; Mon, 04 Oct 2021 20:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2eGuF9yrfRZ7HYMXv0FDGrrnI1fdkBivhcQ+vOGTxCg=;
        b=ik3kKEdbd7mUnND8jQw8zVgpqV28vtfrJ1ITkytt48hNs5tiTSkdzvvNIP3y0t4qLF
         ygWx/AuiV7/G5O0Kj7qtQHJTFKg9TvgQdrUcOdjdQRtXCKh4R3T9Lb9KMNx2Lh2dKSQU
         EM0zYItI2DsAfwBht5VbgfRr61aHz9/OBRH7I1FR0Q7F2tUKsbMdX/9NTAFBiwLkZEEG
         mfWBhKrjuuV0lSmjm79vtHwZpc0ybcOULNLQDNtzlee9kk3dom8c5zkLv29tokvFBU8c
         wZuGVDduEA35pWKPe/I8BHmPPdGDEQetwvG3Ca33ZvrbaWpZA6lYKTaM3m/RaZ+lh16u
         8kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2eGuF9yrfRZ7HYMXv0FDGrrnI1fdkBivhcQ+vOGTxCg=;
        b=yZJMkKo33MVPXuvOOWKSfZyLun3TYdJgA59ZR6g2ZZkUmrxBcGTJAH02AMTV3/Xmjx
         qkuxHqibFfq3ruITxOmsM8Wh7mQ7DhHhv+DTA4XhpnrBR6x6UxcqT+6TGudcGAlu7Ugj
         AcMh7iaQtegL2+qyje1N0xUQBP8Y+1VAP7hqGgPjobh5fYolQ8C48h6URlf6aB/ID37k
         TPsfU6JjteaURquZ6/OAWcnJJo4Zo+MPeEWaesvXrXVWTn1G36hM6P15LEQ/N2kOJMTf
         3dAGbw4mAvIRaO/9a7z1Sp8X5TB4KmP2w884gDpNx+rIESuf2Aswjq4lu0nGgFMF7K8D
         KGYQ==
X-Gm-Message-State: AOAM532H426H/o8QOtfnmgREVVpbDS9D2Hixttv5F/90wN7gmplBKQIc
        06/smlKNZDnGI/OltE6mErUwAA==
X-Google-Smtp-Source: ABdhPJwFt21TeWx177qr6HneOnRNpt17cUbSmdfdYx5o0fzICnB6UgzOwFp5Ieqx6rc2vXlzDEQ/uQ==
X-Received: by 2002:a05:6808:2188:: with SMTP id be8mr593263oib.44.1633403527316;
        Mon, 04 Oct 2021 20:12:07 -0700 (PDT)
Received: from yoga ([2600:1700:a0:3dc8:c84c:8eff:fe1e:256f])
        by smtp.gmail.com with ESMTPSA id q133sm3066758oia.55.2021.10.04.20.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 20:12:06 -0700 (PDT)
Date:   Mon, 4 Oct 2021 22:12:04 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sdm845: mtp: Add vadc channels
 and thermal zones
Message-ID: <YVvChGwyiBF+TjlB@yoga>
References: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
 <20210923212311.2877048-5-bjorn.andersson@linaro.org>
 <YVSzJZ8G43CLml3L@google.com>
 <YVtg3lcR1HMqVdAJ@ripper>
 <CAA8EJprYij6pWD1A17yr1+5-n5fKPW=YDA_-2+f8h6JnEh4myw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprYij6pWD1A17yr1+5-n5fKPW=YDA_-2+f8h6JnEh4myw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 04 Oct 15:56 CDT 2021, Dmitry Baryshkov wrote:

> On Mon, 4 Oct 2021 at 23:13, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> >
> > On Wed 29 Sep 11:40 PDT 2021, Matthias Kaehlcke wrote:
> >
> > > On Thu, Sep 23, 2021 at 02:23:11PM -0700, Bjorn Andersson wrote:
> > > > Downstream defines four ADC channels related to thermal sensors external
> > > > to the PM8998 and two channels for internal voltage measurements.
> > > >
> > > > Add these to the upstream SDM845 MTP, describe the thermal monitor
> > > > channels and add thermal_zones for these.
> > > >
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > ---
> > > >
> > > > In addition to the iio channels exposed by v1, Daniel wanted thermal_zones...
> > > >
> > > > Changes since v1:
> > > > - Enable the pm8998_adc_tm and describe the ADC channels
> > > > - Add thermal-zones for the new channels
> > > >
> > > >  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 128 ++++++++++++++++++++++++
> > > >  1 file changed, 128 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > [..]
> > > > +&pm8998_adc {
> > > > +   adc-chan@4c {
> > > > +           reg = <ADC5_XO_THERM_100K_PU>;
> > > > +           label = "xo_therm";
> > > > +   };
> > > > +
> > > > +   adc-chan@4d {
> > > > +           reg = <ADC5_AMUX_THM1_100K_PU>;
> > > > +           label = "msm_therm";
> > > > +   };
> > > > +
> > > > +   adc-chan@4f {
> > > > +           reg = <ADC5_AMUX_THM3_100K_PU>;
> > > > +           label = "pa_therm1";
> > > > +   };
> > > > +
> > > > +   adc-chan@51 {
> > > > +           reg = <ADC5_AMUX_THM5_100K_PU>;
> > > > +           label = "quiet_therm";
> > > > +   };
> > > > +
> > > > +   adc-chan@83 {
> > > > +           reg = <ADC5_VPH_PWR>;
> > > > +           label = "vph_pwr";
> > > > +   };
> > > > +
> > > > +   adc-chan@85 {
> > > > +           reg = <ADC5_VCOIN>;
> > > > +           label = "vcoin";
> > > > +   };
> > > > +};
> > > > +
> > > > +&pm8998_adc_tm {
> > > > +   status = "okay";
> > > > +
> > > > +   xo-thermistor@1 {
> > > > +           reg = <1>;
> > > > +           io-channels = <&pm8998_adc ADC5_XO_THERM_100K_PU>;
> > > > +           qcom,ratiometric;
> > > > +           qcom,hw-settle-time-us = <200>;
> > > > +   };
> > > > +
> > > > +   msm-thermistor@2 {
> > > > +           reg = <2>;
> > > > +           io-channels = <&pm8998_adc ADC5_AMUX_THM1_100K_PU>;
> > > > +           qcom,ratiometric;
> > > > +           qcom,hw-settle-time-us = <200>;
> > > > +   };
> > > > +
> > > > +   pa-thermistor@3 {
> > > > +           reg = <3>;
> > > > +           io-channels = <&pm8998_adc ADC5_AMUX_THM3_100K_PU>;
> > > > +           qcom,ratiometric;
> > > > +           qcom,hw-settle-time-us = <200>;
> > > > +   };
> > > > +
> > > > +   quiet-thermistor@4 {
> > > > +           reg = <4>;
> > > > +           io-channels = <&pm8998_adc ADC5_AMUX_THM5_100K_PU>;
> > > > +           qcom,ratiometric;
> > > > +           qcom,hw-settle-time-us = <200>;
> > > > +   };
> > > > +};
> > > > +
> > >
> > > The example in the 'qcom,spmi-adc-tm5' binding specifies 'qcom,ratiometric'
> > > and 'qcom,hw-settle-time-us' for both the ADC and the thermal monitor, so do
> > > several board files (e.g. sm8250-mtp.dts and qrb5165-rb5.dts). This apparent
> > > redundancy bothered me earlier, it's not really clear to me whether it's
> > > needed/recommended or not. Do you happen to have any insights on this?
> >
> > Hmm, you're right and I missed this in defining my channels. I've not
> > looked at this detail, just got reasonable readings from my thermal
> > zones and was happy about that.
> >
> > Dmitry, do you have any further insights why these properties are
> > supposed to be duplicated between the adc channel and the thermal zones?
> 
> Because both ADC channel and thermal zone registers should be
> programmed accordingly.
> 

I presume our question is "why" to this particular part. The actual
implementation thereof seems reasonable.

Regards,
Bjorn

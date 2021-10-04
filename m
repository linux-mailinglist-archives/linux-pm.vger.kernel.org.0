Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20C142183F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 22:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhJDUPe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 16:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbhJDUPd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 16:15:33 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5361FC061745
        for <linux-pm@vger.kernel.org>; Mon,  4 Oct 2021 13:13:44 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id a3so23206122oid.6
        for <linux-pm@vger.kernel.org>; Mon, 04 Oct 2021 13:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zOyi2S95uxdbFdCGOc7m3K4Adp+itmzmW8gzb/ESD2A=;
        b=NHcT5M3mp7sXlQg/hJy4HQmFI4Ixa+1mArVErtOuxeYthCkG0IflqNJ/vr9/va2C/R
         vMtejRNBeHnf4z7M3fn+9rVBrsLQxmwiEnroet1ZokIGN27QHSMcLyKYVLS7gHO16r4C
         lrvB/VqjSugs30zuuNtHbfHjZOB3VXgBslVUO7alXhs1I9njL90EVQGFYy1lmUZR4LMc
         DLKnlYwrW3HjtS6ClV31364qZD4dUvxBJLOEcSnqGVRmrWNTV/on8w2bqtnzpI0tO6VE
         MLn4lq3Ajh8LxlsXqaqKreIVh/Wim+AxRy5V+wOQ+aAgkEbl3amzJiKA6Z+/HXnNFDDr
         bZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zOyi2S95uxdbFdCGOc7m3K4Adp+itmzmW8gzb/ESD2A=;
        b=I0Llcy+1Mcuv3FizVRUJFU8KOYNmtG4tHcoDTF//PxMc1LKkNs6NMjThBtZHwTzWrP
         +d8xLqSrDdt1Kw6v55w671P0ijbXbqR64UFnva3689iJolSCDEvBhN6uOoQbDQQ83NvB
         fIgooJSDMhpaedCMf7Rc65CWQHrtBi3HBUyfAJV1WItSwnoi0mLoYiMAeNlHuAigAH1m
         rjLGFu7rE2tKPRcAr7amATnJSRetdDkYS0vrgcwIKVlHCIcXDBPOMbO23uQ5CR23p/4S
         JYys2Ve+5pPEb2CAHP7LL7heXnVHqj8kRa4YQdf235mEjG1zA8IE8nAejqr7WjcZBIqM
         npLw==
X-Gm-Message-State: AOAM530PwQMUUlLdX8WLUbGoJ7e3CxJBp0mmKj7YVSOdpl4YiUgShgpl
        GejdZM9rPTe+fHdwqAHTBzVrpA==
X-Google-Smtp-Source: ABdhPJwZYp6jBuxmxXIgtPCA5/ZWf29iADPg6Bjiibxne53m0r1ddxNDFt0NNc+s8iNXD2sqzb7o/w==
X-Received: by 2002:a05:6808:8d4:: with SMTP id k20mr4026876oij.116.1633378423736;
        Mon, 04 Oct 2021 13:13:43 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id s13sm1249546oou.11.2021.10.04.13.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 13:13:43 -0700 (PDT)
Date:   Mon, 4 Oct 2021 13:15:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sdm845: mtp: Add vadc channels
 and thermal zones
Message-ID: <YVtg3lcR1HMqVdAJ@ripper>
References: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
 <20210923212311.2877048-5-bjorn.andersson@linaro.org>
 <YVSzJZ8G43CLml3L@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVSzJZ8G43CLml3L@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 29 Sep 11:40 PDT 2021, Matthias Kaehlcke wrote:

> On Thu, Sep 23, 2021 at 02:23:11PM -0700, Bjorn Andersson wrote:
> > Downstream defines four ADC channels related to thermal sensors external
> > to the PM8998 and two channels for internal voltage measurements.
> > 
> > Add these to the upstream SDM845 MTP, describe the thermal monitor
> > channels and add thermal_zones for these.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > In addition to the iio channels exposed by v1, Daniel wanted thermal_zones...
> > 
> > Changes since v1:
> > - Enable the pm8998_adc_tm and describe the ADC channels
> > - Add thermal-zones for the new channels
> > 
> >  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 128 ++++++++++++++++++++++++
> >  1 file changed, 128 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
[..]
> > +&pm8998_adc {
> > +	adc-chan@4c {
> > +		reg = <ADC5_XO_THERM_100K_PU>;
> > +		label = "xo_therm";
> > +	};
> > +
> > +	adc-chan@4d {
> > +		reg = <ADC5_AMUX_THM1_100K_PU>;
> > +		label = "msm_therm";
> > +	};
> > +
> > +	adc-chan@4f {
> > +		reg = <ADC5_AMUX_THM3_100K_PU>;
> > +		label = "pa_therm1";
> > +	};
> > +
> > +	adc-chan@51 {
> > +		reg = <ADC5_AMUX_THM5_100K_PU>;
> > +		label = "quiet_therm";
> > +	};
> > +
> > +	adc-chan@83 {
> > +		reg = <ADC5_VPH_PWR>;
> > +		label = "vph_pwr";
> > +	};
> > +
> > +	adc-chan@85 {
> > +		reg = <ADC5_VCOIN>;
> > +		label = "vcoin";
> > +	};
> > +};
> > +
> > +&pm8998_adc_tm {
> > +	status = "okay";
> > +
> > +	xo-thermistor@1 {
> > +		reg = <1>;
> > +		io-channels = <&pm8998_adc ADC5_XO_THERM_100K_PU>;
> > +		qcom,ratiometric;
> > +		qcom,hw-settle-time-us = <200>;
> > +	};
> > +
> > +	msm-thermistor@2 {
> > +		reg = <2>;
> > +		io-channels = <&pm8998_adc ADC5_AMUX_THM1_100K_PU>;
> > +		qcom,ratiometric;
> > +		qcom,hw-settle-time-us = <200>;
> > +	};
> > +
> > +	pa-thermistor@3 {
> > +		reg = <3>;
> > +		io-channels = <&pm8998_adc ADC5_AMUX_THM3_100K_PU>;
> > +		qcom,ratiometric;
> > +		qcom,hw-settle-time-us = <200>;
> > +	};
> > +
> > +	quiet-thermistor@4 {
> > +		reg = <4>;
> > +		io-channels = <&pm8998_adc ADC5_AMUX_THM5_100K_PU>;
> > +		qcom,ratiometric;
> > +		qcom,hw-settle-time-us = <200>;
> > +	};
> > +};
> > +
> 
> The example in the 'qcom,spmi-adc-tm5' binding specifies 'qcom,ratiometric'
> and 'qcom,hw-settle-time-us' for both the ADC and the thermal monitor, so do
> several board files (e.g. sm8250-mtp.dts and qrb5165-rb5.dts). This apparent
> redundancy bothered me earlier, it's not really clear to me whether it's
> needed/recommended or not. Do you happen to have any insights on this?

Hmm, you're right and I missed this in defining my channels. I've not
looked at this detail, just got reasonable readings from my thermal
zones and was happy about that.

Dmitry, do you have any further insights why these properties are
supposed to be duplicated between the adc channel and the thermal zones?

Thanks,
Bjorn

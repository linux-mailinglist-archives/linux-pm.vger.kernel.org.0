Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B5722E7C7
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 10:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgG0Idf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 04:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgG0Idf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 04:33:35 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED871C061794
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 01:33:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d4so9063794pgk.4
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eDiosr731VuGI/Nf/vg+XeOYOe+kYaAnlS6bWQS50OU=;
        b=Iqjrw9CytWsYEXgADjD42Omr9o1HnWS2K5XDdZdhYNx51v9NsrLdG3K5qXnOoD6Mha
         kUJAZeuUHssetLSpDUpcKCTjvHBDT8jkEfvz9QFPlNYpWyfCP/8mmYPTv2v+ZhslPPKS
         +/vHqAd0mSSK4vGLQBNlIIgZ2/l3PMJ5vbHtbjkiAejuPEYI7igR6oJEN9fO1XpSJnCD
         c9gcXS2l60/2ZuUm0wB9BOFujaIBDk4Og5ESzwBiTYio78Mrl3DB0M7XNL3l8vNTJX8D
         N3zaBvPz6NYbrqM2B3h6Rb2URWeIS6OjpfAhzy+gQD4hXYTbOXBUC1n2Na9hHgVmQuAw
         wXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eDiosr731VuGI/Nf/vg+XeOYOe+kYaAnlS6bWQS50OU=;
        b=MlW5MZ6vo2fU9JLKnMt27NnetZ/cf9pZIZ4OFmr4Ut63uCFP7guJ+NSwLMXvgOGo/U
         mVIqKtY7Ftbl6GUB/dCaCUsgPUtshumqZTHTIVtmawb1XwHLPSWekgpEdATN/lLzDcEa
         oC3xkFm9X77R5anujrZn4Bv2bXgBHTNPhl6yb/wm/GzMCPmaeuZM3V4agQatHklQ84BA
         GUwuQDaf0xNxhwNoztmAv8wtgwXqR6HNm2VWN6gby7mEX0hwbd3HCRlZmurhdDqhIZ16
         DVrW1BBfL43Z4uwV4PvtdsI5e3a+enGCgK0/zwI+wCsa/0jueOHUPLsW7MeIsTeSMj+G
         BKNw==
X-Gm-Message-State: AOAM532OZN42Vxg8fzkaXgRcDLv7nDoyCJaOnMz+PYxhpF5xigmL1oQM
        LCcoqCh3l5v7wHJFcvZw5HPFrQ==
X-Google-Smtp-Source: ABdhPJwHV1rqsRsykyeSE9M6iG0vkdRZrBOtHRFJ10HCQGZq5810tq/gahshd6COU7Wev+AT4ZJpvA==
X-Received: by 2002:a65:6846:: with SMTP id q6mr17659801pgt.397.1595838814279;
        Mon, 27 Jul 2020 01:33:34 -0700 (PDT)
Received: from dragon ([80.251.214.228])
        by smtp.gmail.com with ESMTPSA id a6sm569561pje.8.2020.07.27.01.33.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jul 2020 01:33:33 -0700 (PDT)
Date:   Mon, 27 Jul 2020 16:33:23 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] thermal: qcom: tsens-v0_1: Add support for MSM8939
Message-ID: <20200727083322.GA12266@dragon>
References: <20200629144926.665-1-shawn.guo@linaro.org>
 <20200629144926.665-3-shawn.guo@linaro.org>
 <CAHLCerMyEsvuhNPnwDow5JYVAbem0Rzs+5-uzKZNeFt+3rYHQg@mail.gmail.com>
 <CAHLCerPEPEOkkBd8MZq8T99eS7nE2pMio6ojnMn7bc54ian-3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerPEPEOkkBd8MZq8T99eS7nE2pMio6ojnMn7bc54ian-3A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Amit,

On Mon, Jul 27, 2020 at 12:06:54PM +0530, Amit Kucheria wrote:
> On Mon, Jul 27, 2020 at 11:56 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >
> > On Tue, Jun 30, 2020 at 1:09 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> > >
> > > The TSENS integrated on MSM8939 is a v0_1 device with 10 sensors.
> > > Different from its predecessor MSM8916, where 'calib_sel' bits sit in
> > > separate qfprom word, MSM8939 has 'cailb' and 'calib_sel' bits mixed and
> > > spread on discrete offsets.  That's why all qfprom bits are read as one
> > > go and later mapped to calibration data for MSM8939.
> > >
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> >
> > Acked-by: Amit Kucheria <amit.kucheria@linaro.org>
> 
> Shawn,
> 
> Have you not sent the change to the tsens.yaml and 8939 DT yet or did
> I miss them?

You were copied on '[PATCH 1/2] dt-bindings: tsens: qcom: Document
MSM8939 compatible'.  For DTS change, I haven't sent them out.  In case
you want to have a look, here it is.

	thermal-zones {
		cpu0-thermal {
			polling-delay-passive = <250>;
			polling-delay = <1000>;

			thermal-sensors = <&tsens 5>;

			trips {
				cpu0_alert: trip0 {
					temperature = <75000>;
					hysteresis = <2000>;
					type = "passive";
				};
				cpu0_crit: trip1 {
					temperature = <110000>;
					hysteresis = <2000>;
					type = "critical";
				};
			};

			cooling-maps {
				map0 {
					trip = <&cpu0_alert>;
					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
				};
			};
		};

		cpu1-thermal {
			polling-delay-passive = <250>;
			polling-delay = <1000>;

			thermal-sensors = <&tsens 6>;

			trips {
				cpu1_alert: trip0 {
					temperature = <75000>;
					hysteresis = <2000>;
					type = "passive";
				};
				cpu1_crit: trip1 {
					temperature = <110000>;
					hysteresis = <2000>;
					type = "critical";
				};
			};

			cooling-maps {
				map0 {
					trip = <&cpu1_alert>;
					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
				};
			};
		};

		cpu2-thermal {
			polling-delay-passive = <250>;
			polling-delay = <1000>;

			thermal-sensors = <&tsens 7>;

			trips {
				cpu2_alert: trip0 {
					temperature = <75000>;
					hysteresis = <2000>;
					type = "passive";
				};
				cpu2_crit: trip1 {
					temperature = <110000>;
					hysteresis = <2000>;
					type = "critical";
				};
			};

			cooling-maps {
				map0 {
					trip = <&cpu2_alert>;
					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
				};
			};
		};

		cpu3-thermal {
			polling-delay-passive = <250>;
			polling-delay = <1000>;

			thermal-sensors = <&tsens 8>;

			trips {
				cpu3_alert: trip0 {
					temperature = <75000>;
					hysteresis = <2000>;
					type = "passive";
				};
				cpu3_crit: trip1 {
					temperature = <110000>;
					hysteresis = <2000>;
					type = "critical";
				};
			};

			cooling-maps {
				map0 {
					trip = <&cpu3_alert>;
					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
				};
			};
		};

		cpu4567-thermal {
			polling-delay-passive = <250>;
			polling-delay = <1000>;

			thermal-sensors = <&tsens 9>;

			trips {
				cpu4567_alert: trip0 {
					temperature = <75000>;
					hysteresis = <2000>;
					type = "passive";
				};
				cpu4567_crit: trip1 {
					temperature = <110000>;
					hysteresis = <2000>;
					type = "critical";
				};
			};

			cooling-maps {
				map0 {
					trip = <&cpu4567_alert>;
					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
				};
			};
		};

	};

	qfprom: qfprom@5c000 {
		compatible = "qcom,qfprom";
		reg = <0x5c000 0x1000>;
		#address-cells = <1>;
		#size-cells = <1>;
		tsens_caldata: caldata@a0 {
			reg = <0xa0 0x5c>;
		};
	};

	tsens: thermal-sensor@4a9000 {
		compatible = "qcom,msm8939-tsens";
		reg = <0x4a9000 0x1000>, /* TM */
		      <0x4a8000 0x1000>; /* SROT */
		nvmem-cells = <&tsens_caldata>;
		nvmem-cell-names = "calib";
		#qcom,sensors = <10>;
		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
		interrupt-names = "uplow";
		#thermal-sensor-cells = <1>;
	};

Shawn

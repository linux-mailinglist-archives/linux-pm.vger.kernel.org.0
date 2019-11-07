Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F16F2532
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 03:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbfKGCUU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 21:20:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44374 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732777AbfKGCUT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 21:20:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id q16so351800pll.11
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 18:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H+QqKLPEQoeG1GGGgw3cHviviQT0DnHW7MBvGPeHz6k=;
        b=ArKI6GjaGqnXyXXJugquFesbMPo4+FgiRDM8C38iV5D242vyprAXN+S3nkmPK/OMVm
         SuIClw+4vYZMtzpL46SY9Q1c3tqqHMt0C8odoR6ghGzVtvoR1QVVjHRYjpR2GFqSu03K
         RoNm7pOKyX1kbfrT+ftQrMhpwUX2OZgavt9vT/tSLAOtvJJo4zc/k6uuAEQ/gt5nH3zl
         WaLigY0cKkQ+WUTN3M6i0YtWSKn2GA8f51dMOZawULnuJZ2X6p3irFUE5iLeE5YX4Csr
         fMucxcs03GCVx4tnBl1cSjKFf0ttE/ivjDB3O9/CHD/VLXG3Mxd7nKFHuRS3J9nizG/X
         NL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H+QqKLPEQoeG1GGGgw3cHviviQT0DnHW7MBvGPeHz6k=;
        b=HmlVWnY1qrXO/AeDbFjtXnWAb1/Gp+2z48dMeRqy3uXj/AI1k7HowqWoHBwBWijoiz
         7EhfrKlogOUJ1B28+SHXQgFnf5YnZjM5joDgLwTsq2j56d3Hs/ewdHMLu7B26qjaD8ym
         ecLN6d/ZTX7oFthNj+MDmaIVew/q4yZdGBiA5aIexyuBlOyx2VyvWcs3X0mx7MpABBsT
         jQEDvblYccCuaW1vtM61saL8hHbdHq+cql0G1cHE+VIufeFA5cNeV+DRIoWwsPRrKIjR
         sd5MwcCmOZoxSSZ5qnejWO/FEC0Coug0JyOosQLn4/NgQvcbX04w47SlCICfuqjgviCk
         ejZQ==
X-Gm-Message-State: APjAAAVXkQ75J1rkkCewu/gpNFrHpr9NLEGhIi/vwB7iboahzkcb1GdK
        gtYVqrIvLfXgYa3huDvD+i6+BQ==
X-Google-Smtp-Source: APXvYqw5NEouYeHvrSFPg8kUw7qbtEhGDZ0vtBPCr/SO2elR5vBWUuBiUcos9vmJW6rYBJKddhrR3w==
X-Received: by 2002:a17:902:8208:: with SMTP id x8mr1033222pln.232.1573093217114;
        Wed, 06 Nov 2019 18:20:17 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id j126sm354534pfg.4.2019.11.06.18.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:20:16 -0800 (PST)
Date:   Thu, 7 Nov 2019 07:50:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 06/11] thermal: mediatek: Appease the kernel-doc deity
Message-ID: <20191107022012.o7wfyoerhomc3ztu@vireshk-i7>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
 <2961e4ac4b32ea7db8b5f6916751a5c02ee85960.1573046440.git.amit.kucheria@linaro.org>
 <20191107021929.hsuyzswcl27n7wqt@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107021929.hsuyzswcl27n7wqt@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-11-19, 07:49, Viresh Kumar wrote:
> On 06-11-19, 18:58, Amit Kucheria wrote:
> > Replace a comment starting with /** by simply /* to avoid having it
> > interpreted as a kernel-doc comment. Describe missing function
> > parameters where needed.
> > 
> > Fixes up the following warnings when compiled with make W=1:
> > 
> > linux.git/drivers/thermal/mtk_thermal.c:374: warning: cannot understand
> > function prototype: 'const struct mtk_thermal_data mt8173_thermal_data =
> > '
> > linux.git/drivers/thermal/mtk_thermal.c:413: warning: cannot understand
> > function prototype: 'const struct mtk_thermal_data mt2701_thermal_data =
> > '
> > linux.git/drivers/thermal/mtk_thermal.c:443: warning: cannot understand
> > function prototype: 'const struct mtk_thermal_data mt2712_thermal_data =
> > '
> > linux.git/drivers/thermal/mtk_thermal.c:499: warning: cannot understand
> > function prototype: 'const struct mtk_thermal_data mt8183_thermal_data =
> > '
> > linux.git/drivers/thermal/mtk_thermal.c:529: warning: Function parameter
> > or member 'sensno' not described in 'raw_to_mcelsius'
> > 
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/mtk_thermal.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> > index acf4854cbb8b8..76e30603d4d58 100644
> > --- a/drivers/thermal/mtk_thermal.c
> > +++ b/drivers/thermal/mtk_thermal.c
> > @@ -358,7 +358,7 @@ static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
> >  static const int mt7622_vts_index[MT7622_NUM_SENSORS] = { VTS1 };
> >  static const int mt7622_tc_offset[MT7622_NUM_CONTROLLER] = { 0x0, };
> >  
> > -/**
> > +/*
> >   * The MT8173 thermal controller has four banks. Each bank can read up to
> >   * four temperature sensors simultaneously. The MT8173 has a total of 5
> >   * temperature sensors. We use each bank to measure a certain area of the
> > @@ -400,7 +400,7 @@ static const struct mtk_thermal_data mt8173_thermal_data = {
> >  	.sensor_mux_values = mt8173_mux_values,
> >  };
> >  
> > -/**
> > +/*
> >   * The MT2701 thermal controller has one bank, which can read up to
> >   * three temperature sensors simultaneously. The MT2701 has a total of 3
> >   * temperature sensors.
> > @@ -430,7 +430,7 @@ static const struct mtk_thermal_data mt2701_thermal_data = {
> >  	.sensor_mux_values = mt2701_mux_values,
> >  };
> >  
> > -/**
> > +/*
> >   * The MT2712 thermal controller has one bank, which can read up to
> >   * four temperature sensors simultaneously. The MT2712 has a total of 4
> >   * temperature sensors.
> > @@ -484,7 +484,7 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
> >  	.sensor_mux_values = mt7622_mux_values,
> >  };
> >  
> > -/**
> > +/*
> >   * The MT8183 thermal controller has one bank for the current SW framework.
> >   * The MT8183 has a total of 6 temperature sensors.
> >   * There are two thermal controller to control the six sensor.
> > @@ -495,7 +495,6 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
> >   * data, and this indeed needs the temperatures of the individual banks
> >   * for making better decisions.
> >   */
> > -
> >  static const struct mtk_thermal_data mt8183_thermal_data = {
> >  	.auxadc_channel = MT8183_TEMP_AUXADC_CHANNEL,
> >  	.num_banks = MT8183_NUM_SENSORS_PER_ZONE,
> > @@ -519,7 +518,8 @@ static const struct mtk_thermal_data mt8183_thermal_data = {
> >  
> >  /**
> >   * raw_to_mcelsius - convert a raw ADC value to mcelsius
> > - * @mt:		The thermal controller
> > + * @mt:	The thermal controller
> > + * @sensno:	sensor number
> >   * @raw:	raw ADC value
> 
> This doesn't look related to $subject

I take this statement back :)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

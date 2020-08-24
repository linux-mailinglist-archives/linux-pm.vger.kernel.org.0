Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AE324FD4D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 14:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgHXMCM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 08:02:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51067 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgHXMCL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 08:02:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id t2so7830232wma.0;
        Mon, 24 Aug 2020 05:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ShrC8bNE0fWXwV7cdyP50z+72KVJ6UwIOeGyUMMXgFg=;
        b=BhwfE80zmdA2gaCYrqcu5zf8o508nnPGSb7cngxGXetbAI2ilugFu69kzeLgQ/zq1D
         7o1WrjM3BHCMtRq634rXUYFm472Nc6Jc0hIMu6gZAYhubBQnflFdCqMS3RV4223yEr/U
         ipqpFLUhjQPXts/jAdlde3HPVAGOsx24Ie9GIx1hgWrcE0aPggyWbLny7+lcDuQrmu1K
         PqgUEAKRpCqJcQTyxaXOXQn2Kg/zq64iUKNq0Tkh+6Y0Rk5cDpl3jwSJ8DGQzFL71B7n
         z1iaDML4I98mJXvtMza5hwMBClU0fC24Y/AaP3dykvItExrfTBcuezOrgM5fCmioQoOy
         sf9A==
X-Gm-Message-State: AOAM5339cS/UkzfeqhZerIwYdrXL7EASucvhaCz+mD/GRk8tz+Sr/YWp
        tFSl00POYpHGeFNgFYrPhFk=
X-Google-Smtp-Source: ABdhPJzF1cM0Zjw0kxDgr2wLhdwUVnQA5czSUo+QkX5E+42+jzTSTB2poBG97XmO5GaNvpJJfYU/Wg==
X-Received: by 2002:a1c:48c2:: with SMTP id v185mr5294620wma.5.1598270528919;
        Mon, 24 Aug 2020 05:02:08 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id y2sm25347861wmg.25.2020.08.24.05.01.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 05:02:08 -0700 (PDT)
Date:   Mon, 24 Aug 2020 14:01:39 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] memory: samsung: exynos5422-dmc: remove unused
 exynos5_dmc members
Message-ID: <20200824115815.GA5258@kozik-lap>
References: <20200822163218.21857-1-krzk@kernel.org>
 <20200822163218.21857-2-krzk@kernel.org>
 <6c61572d-ef7a-ca0a-2253-7a3c0736f0a5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c61572d-ef7a-ca0a-2253-7a3c0736f0a5@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 24, 2020 at 12:43:33PM +0100, Lukasz Luba wrote:
> Hi Krzysztof,
> 
> On 8/22/20 5:32 PM, Krzysztof Kozlowski wrote:
> > The struct exynos5_dmc members bypass_rate, mx_mspll_ccore_phy,
> > mout_mx_mspll_ccore_phy and opp_bypass are not actually used.
> > 
> > Apparently there was a plan to store the OPP for the bypass mode in
> > opp_bypass member, but drivers fails to do it and instead always sets
> > target voltage during bypass mode.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >   drivers/memory/samsung/exynos5422-dmc.c | 9 ---------
> >   1 file changed, 9 deletions(-)
> > 
> > diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> > index 31864ce59b25..df02afa8aa90 100644
> > --- a/drivers/memory/samsung/exynos5422-dmc.c
> > +++ b/drivers/memory/samsung/exynos5422-dmc.c
> > @@ -123,9 +123,7 @@ struct exynos5_dmc {
> >   	struct mutex lock;
> >   	unsigned long curr_rate;
> >   	unsigned long curr_volt;
> > -	unsigned long bypass_rate;
> >   	struct dmc_opp_table *opp;
> > -	struct dmc_opp_table opp_bypass;
> >   	int opp_count;
> >   	u32 timings_arr_size;
> >   	u32 *timing_row;
> > @@ -143,8 +141,6 @@ struct exynos5_dmc {
> >   	struct clk *mout_bpll;
> >   	struct clk *mout_mclk_cdrex;
> >   	struct clk *mout_mx_mspll_ccore;
> > -	struct clk *mx_mspll_ccore_phy;
> > -	struct clk *mout_mx_mspll_ccore_phy;
> >   	struct devfreq_event_dev **counter;
> >   	int num_counters;
> >   	u64 last_overflow_ts[2];
> > @@ -455,9 +451,6 @@ static int exynos5_dmc_align_bypass_voltage(struct exynos5_dmc *dmc,
> >   					    unsigned long target_volt)
> >   {
> >   	int ret = 0;
> > -	unsigned long bypass_volt = dmc->opp_bypass.volt_uv;
> > -
> > -	target_volt = max(bypass_volt, target_volt);
> 
> 
> Could you explain which use cases you considered when you decided to
> remove these lines?

There are no use cases attached to these. These are simply not used,
never assigned a value. For example max(0, target_volt) is always equal
to target_volt for unsigned numbers...

Best regards,
Krzysztof


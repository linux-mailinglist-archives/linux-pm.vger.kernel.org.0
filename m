Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CE5365107
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 05:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhDTDiU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 23:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbhDTDiT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 23:38:19 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A263C06174A
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 20:37:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c3so5800973pfo.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 20:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Dp71bvPzPe1wCYmcL3dWmnHaA9IPMYpDW9V8NfdSkc=;
        b=cOHrtIRKKzf406ywioOpMEaI+JxTsgk24dfL1j85yEFOTioqe/Wkk3sfhI44Q1dE7j
         65QSzSe7Z5qv4E353StbnoU87r08IMCCsvDePdtRLfyeOfxq2KcvK1buyUuUmOqvWSqz
         ISCulD8eTGSSTliYfl+gFyTSGoWap85k4iVgMnhZuvi6VpsbrnE+2Jx5THcQE3SMLZdK
         MrcBDFn56VUg1JySPufcM+Ap2ekmV7xJGFyRvg4QYL9JAZALlwWWOP5KAZszoNI30/p5
         3APL0pQTHzjyYoZTfbdeoS2N20VdZ+QdFjt1sZ6ThujTFMch4srMEWYVFTghQ5kbijRi
         sTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Dp71bvPzPe1wCYmcL3dWmnHaA9IPMYpDW9V8NfdSkc=;
        b=iymr+/clnm+WTmCE3j/5A/GAumbhor0CQJy23UjE0pgS0R7xcgZ5NY1r2vyHMZzCRR
         PwGcYbBeMNvMFgM0JY67kDLLTfexNVeRXBPv7RewrErY6lphzl3AYfHEx7QF+rNiO0Kz
         AfFNLpeql9jLX6Vu7I2Z8XOmAQKoyqN6zAzmfvFdzquehK+8C0AzOuJqQYCVU8N42DkK
         DU0Ega2/+zWvkar3Yl5W69u2DYXATJqXrP+6/YetPGvJln8EwLp5GH6//T2YzX0Q3Mt2
         d0ltaVFSHxlnXDQVEow4MyYBh5usHKsgIaz3HmKcKeekOS8+0U71tzEogOnQUkOh+Gfu
         VPqQ==
X-Gm-Message-State: AOAM530pm8j3UuDiV1KB3CWiT5uCVFsU363AL+xAlxe+JShyHDDYYMer
        pfBZ/DsBrJpmtmt5kTGU4biaLg==
X-Google-Smtp-Source: ABdhPJzltqFZqUcdsXgG1fCqHZwqiJ17U3Dp9tAYxqC2lP00fX+Ti2Epbbf3KvGFjg7XD1qjZj+9gg==
X-Received: by 2002:a63:48c:: with SMTP id 134mr8927069pge.448.1618889866955;
        Mon, 19 Apr 2021 20:37:46 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id 71sm8454476pfu.19.2021.04.19.20.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 20:37:45 -0700 (PDT)
Date:   Tue, 20 Apr 2021 09:07:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>, agross@kernel.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com
Subject: Re: [PATCH v4 5/7] cpufreq: qcom-hw: Implement CPRh aware OSM
 programming
Message-ID: <20210420033743.cqfw7vb4zrewdsbl@vireshk-i7>
References: <20210119174557.227318-1-angelogioacchino.delregno@somainline.org>
 <20210119174557.227318-6-angelogioacchino.delregno@somainline.org>
 <20210419185203.GQ1538589@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419185203.GQ1538589@yoga>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-04-21, 13:52, Bjorn Andersson wrote:
> On Tue 19 Jan 11:45 CST 2021, AngeloGioacchino Del Regno wrote:
> @Viresh, do you have any suggestion regarding my last comment?

> >  static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
> >  {
> > +	const struct qcom_cpufreq_soc_data *soc_data;
> > +	struct device_node *pd_node;
> > +	struct platform_device *pd_dev;
> >  	struct device *cpu_dev;
> >  	struct clk *clk;
> > -	int ret;
> > +	int clk_div, ret;
> > +
> > +	cpu_dev = get_cpu_device(0);
> > +	if (!cpu_dev)
> > +		return -EPROBE_DEFER;
> > +
> > +	soc_data = of_device_get_match_data(&pdev->dev);
> > +	if (!soc_data)
> > +		return -EINVAL;
> > +
> > +	if (!soc_data->uses_tz) {
> > +		/*
> > +		 * When the OSM is not pre-programmed from TZ, we will
> > +		 * need to program the sequencer through SCM calls.
> > +		 */
> > +		if (!qcom_scm_is_available())
> > +			return -EPROBE_DEFER;
> > +
> > +		/*
> > +		 * If there are no power-domains, OSM programming cannot be
> > +		 * performed, as in that case, we wouldn't know where to take
> > +		 * the params from...
> > +		 */
> > +		pd_node = of_parse_phandle(cpu_dev->of_node,
> > +					   "power-domains", 0);
> > +		if (!pd_node) {
> > +			ret = PTR_ERR(pd_node);
> > +			dev_err(cpu_dev, "power domain not found: %d\n", ret);
> > +			return ret;
> > +		}
> > +
> > +		/*
> > +		 * If the power domain device is not registered yet, then
> > +		 * defer probing this driver until that is available.
> > +		 */
> > +		pd_dev = of_find_device_by_node(pd_node);
> > +		if (!pd_dev || !pd_dev->dev.driver ||
> > +		    !device_is_bound(&pd_dev->dev))
> > +			return -EPROBE_DEFER;
> 
> I wonder if there's a more appropriate way to probe defer on resources
> described in the CPU nodes...

Recently we made some updates to the OPP core to start returning
EPROBE_DEFER on failure to acquire resources. I think you can get rid
of many checks for resources here by just trying to create the OPP
table and check its return value for EPROBE_DEFER.

-- 
viresh

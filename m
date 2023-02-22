Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1020569EDC0
	for <lists+linux-pm@lfdr.de>; Wed, 22 Feb 2023 05:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjBVEDZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Feb 2023 23:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBVEDX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2023 23:03:23 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5A3B777
        for <linux-pm@vger.kernel.org>; Tue, 21 Feb 2023 20:03:20 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id a26so3802736pfo.9
        for <linux-pm@vger.kernel.org>; Tue, 21 Feb 2023 20:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QuI/VvwDNYNNazJWSsosiKrPGXGOzC0MjV/AUA+0Y18=;
        b=nCQyd6hFnx68A0tFIWYPEgBjsOibWoTXo/smz+3gYmBRuFPBPE4pSywkfCdKUgkvpA
         2hEWf1fS6sHfJJXEu8DWcYvgIJnpq7iCy2lvMkzx+HoVbnLXGhDO3iOZBooeJGtaR0Pd
         PIZdAXgjwX/QLrf6b4kb2lhJNJ1j/mPGS3Ik1K0eu/3Wy4urzl1+NUghMtTwh0O3P7VO
         XwlRUrcPNrxw9hmttzjw+mE8ECx7oXM2WAMltKMJ6Ph5wzLKVBrlFjqFfJs7uN86eaQv
         wJJXhF1XzUfKegtHqxyQWMa88wL+GMAeFpaouHVUjOmGIQMWTqRQH3o2TN5f/VRX0YMW
         7WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuI/VvwDNYNNazJWSsosiKrPGXGOzC0MjV/AUA+0Y18=;
        b=Y1kY2j6OD8dalCZPn2xyYueOv1iih5ZwD2q0ZnFr88nMBPfvBujr6FSg7u5MuflNXl
         7FCIt1vSUumusGNyVXfmRcUf3snE4Vd5QgyF73/nj6ZgyqbPdLThpKEhQavIPz+wsv6M
         rTyXtrd4CY95wO6VhgR6yMNvUgSEonQk4LJtrqipeBwM/t97z0hRT2ta7o+nIVEqToex
         SS7ble0ce3UIm7Lgz8gKyOAXqD+2PKHyIb+GRgx8rQoYcOYfkTuE52JliWhbQMqnOJ/2
         U+72+2sAPSAyFqzTkhErNRJcfrxj8rYfkCYgwEIhq87AdJq9YD2nJtkq0KqhUOXJ5geW
         hreg==
X-Gm-Message-State: AO0yUKXt4MMmLkcGS0WO178utReVPnjCmFcW8P3vZsipn2e7R8FBXnef
        ROyg/HYdMgiloslFQm8pL02OMA==
X-Google-Smtp-Source: AK7set+j5AzguT+wPMqJTKHp23ybKVMqcUGOXK1UT3NyydZuoWzKn02WTplOAHKPGXm8wetjgNETZA==
X-Received: by 2002:aa7:96d0:0:b0:5a8:515a:eba4 with SMTP id h16-20020aa796d0000000b005a8515aeba4mr6768719pfq.10.1677038600006;
        Tue, 21 Feb 2023 20:03:20 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b005ae8e94b0d5sm6764079pfn.107.2023.02.21.20.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 20:03:19 -0800 (PST)
Date:   Wed, 22 Feb 2023 09:33:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     treding@nvidia.com, krzysztof.kozlowski@linaro.org,
        dmitry.osipenko@collabora.com, rafael@kernel.org,
        jonathanh@nvidia.com, robh+dt@kernel.org, lpieralisi@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v2 7/9] cpufreq: tegra194: add OPP support and set
 bandwidth
Message-ID: <20230222040317.r2p6zlbumazymluc@vireshk-i7>
References: <20230220140559.28289-1-sumitg@nvidia.com>
 <20230220140559.28289-8-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220140559.28289-8-sumitg@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-02-23, 19:35, Sumit Gupta wrote:
> +static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, unsigned long freq_khz)
> +{
> +	struct dev_pm_opp *opp;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = get_cpu_device(policy->cpu);
> +	if (!dev)
> +		return -ENODEV;
> +
> +	opp = dev_pm_opp_find_freq_exact(dev, freq_khz * KHZ, true);
> +	if (IS_ERR(opp))
> +		return PTR_ERR(opp);
> +
> +	ret = dev_pm_opp_set_opp(dev, opp);
> +	dev_pm_opp_put(opp);

What about dev_pm_opp_set_rate() instead ?

> +	return ret;
> +}

-- 
viresh

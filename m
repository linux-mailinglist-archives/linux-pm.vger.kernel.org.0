Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96ABD29CA13
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 21:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1831263AbgJ0UW7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 16:22:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39726 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788567AbgJ0UW7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 16:22:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id m16so3276997ljo.6;
        Tue, 27 Oct 2020 13:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L50iVw7FLmT3wGVAPb+hegW9AcFLwxxQql22N1YNr3s=;
        b=Osq7f6NjC6ISj1R2BgrpzFkaTOIKofACZRAtBSa4SrXYxI+3d+GBoKGHSIkOwNHcvB
         UvsWbgVgQNE+3OGfNtzZF5unO04U88aePHGsjklEtbjQLFWX7553MPixlZyVN+s4+WO1
         Vf9yVY+JWv5qYvkFhJWU7gO6QwEUVjdu2Vz8j3ok3dgunfF2kyG7hie3KTgXZ1s1/gZJ
         gFKYb9OhRCG7w8kF+6swG4GHsuXs6dxh8UfRItF3f+lH+KRinGgI3JfKy8FJBzF0MAus
         a0XOpOMhpHxZapOru7oVQgaMJ4s8d2MJ60b0Y9GUnYWN58OSVL1pDkJbkKd/iDjeo/wU
         +9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L50iVw7FLmT3wGVAPb+hegW9AcFLwxxQql22N1YNr3s=;
        b=Jc8SCO4BjRL+seseCA5jUqK/Mz+JapeZQoqr8RgPRgiBLSIFYhrAeHxw72wK1ch2qe
         USeJROjtKRVABmoWtHncTtYsDr+VCi4cdqXlHyP4mD35m2ACK68JO+MOF3mvfaNy6V6s
         6HIKR+LwaUjYEiKCKI8YYf5yb/mQLf54HQbsn9XfQ8gVgnmeuWzxZ0Zy8EgN/56mLAfk
         /+ltlZg0BxPXdNryqnVVerkt8mw0OwjVE2em4YR4Y1b01cK1vyFbUjeD5Qa5ked8LPiw
         QzM3XFxGd4BuomF6mhhwZtF7XY6UQQ84YWbaxQmRKp8A0vRYKnlxHg6NUbjCfu0pDJQe
         xj7A==
X-Gm-Message-State: AOAM531EHmCxKnY6ukYgYSyREKwfi6hlzN4Lm2jv0+RhSCyxhERaVOek
        aLpoAM6s58wd3O3CGsPaGUqmACns5q8=
X-Google-Smtp-Source: ABdhPJwL4Q3axPQhjx8u6GfilK2mbyNcLAJMab3+6Bu/x6z8sYJBTZgcQRvvzZfAlSBhe4ovtwUq0A==
X-Received: by 2002:a2e:b014:: with SMTP id y20mr1846339ljk.362.1603830175544;
        Tue, 27 Oct 2020 13:22:55 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id w142sm281413lff.108.2020.10.27.13.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 13:22:55 -0700 (PDT)
Subject: Re: [PATCH v6 33/52] memory: tegra20: Support interconnect framework
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-34-digetx@gmail.com> <20201027141152.GN1822510@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <713bf4eb-dc5b-9c4b-4ab4-23b36ba4fab1@gmail.com>
Date:   Tue, 27 Oct 2020 23:22:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027141152.GN1822510@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 17:11, Thierry Reding пишет:
...
>> +static int emc_icc_set(struct icc_node *src, struct icc_node *dst)
>> +{
>> +	struct tegra_emc *emc = to_tegra_emc_provider(dst->provider);
>> +	unsigned long long peak_bw = icc_units_to_bps(dst->peak_bw);
>> +	unsigned long long avg_bw = icc_units_to_bps(dst->avg_bw);
>> +	unsigned long long rate = max(avg_bw, peak_bw);
>> +	unsigned int dram_data_bus_width_bytes = 4;
> 
> Perhaps use something shorter for this variable (like dram_bus_width)? Also,
> since it's never modified, perhaps make it const? Or a #define?

It actually could be 2, depending on a board configuration, but I don't
know whether a 16bit bus was ever used in a wild. AFAIK, nv-tegra
kernels assumes 32bit bus for all devices.

...
>> +err_msg:
>> +	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
> 
> It might be worth duplicating this error message to the failure
> locations so that the exact failure can be identified.

I think it should be better to extend error messages on by as-needed
basis. It's very unlikely that we will ever see this error in practice.
Okay?

...
>> +	 * of the client's FIFO buffers. Secondly, we need to take into
>> +	 * account impurities of the memory subsystem.
>> +	 */
>> +	if (tag == TEGRA_MC_ICC_TAG_ISO)
>> +		peak_bw = tegra_mc_scale_percents(peak_bw, 300);
> 
> 300% sounds a bit excessive. Do we really need that much?

It should be possible to drop it to 150% by tuning priority timers and
hysteresis of the clients, but some of those configurations are placed
within device registers range and we will need a more complicated
bandwidth manager.

The 300% is an overestimation, but it's better to overestimate for the
starter than have an unusable devices. This is what nv-tegra kernel does
as well, btw.

>> +
>> +	*agg_avg += avg_bw;
>> +	*agg_peak = max(*agg_peak, peak_bw);
> 
> I'm not very familiar with ICC, but shouldn't the aggregated peak value
> be the sum of the current aggregated peak and the new peak bandwidth?
> Currently you're selecting the maximum peak bandwidth across all
> clients, so isn't that going to be too small if for whatever reason
> multiple clients need peak bandwidth at the same time?

It's up to the platform drivers to decide how to interpret and use the
avg and peak values.

Please see the above emc_icc_set() which selects max of (avg, peak)
values, but maybe it also should be good to move it out from ICC set()
to the ICC aggregate() callback:

*agg_peak = max(*agg_peak, *agg_avg);

I'll need to take a closer look.

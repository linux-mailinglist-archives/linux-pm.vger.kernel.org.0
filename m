Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FD93F92E8
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 05:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbhH0D3W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 23:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244102AbhH0D3I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 23:29:08 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4BDC061757;
        Thu, 26 Aug 2021 20:28:19 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id f2so9022398ljn.1;
        Thu, 26 Aug 2021 20:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+U5aSlU9F6s4CJChb8fLuniyYCxL02p3ONKQon0NCj4=;
        b=OVjjxOrBh1KW9LXgEP6fGQ2odeRhc95dCMhPyuGmYrwE3U7/klMS7kzfqBXs7zNKFl
         50coJ0DpyKURPR54iA0Cwm+BLnCjoiAUAFdQkzpIR0m0/JFXxVktqJuX+FEaAopVL71x
         5ss8BDc1s6HCRd7UmSKzlrgbkvCB76A2/+OIbqsBD6ayTOTbg+tRYv741L1Tocw3hf+b
         kVNYEPMNMWlP91pKn+wk5aDYziEovW3D02R63zMlYvSpkOmCEZcmaihdbMzOp7tjmBW/
         KWagM+EwnUb77OC2hmciNqjqq8GjntPYrDtaMH6e0G1/VZg/nGz1mqeuxvJ3rdsEWLLK
         KZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+U5aSlU9F6s4CJChb8fLuniyYCxL02p3ONKQon0NCj4=;
        b=J8I2Ah6VIvzkbZefq6rEVmtcw6ZBKI3ra0G5l5Xr/7nWjQi5mpIOjF3nxT+PQCXOiT
         JHOqD1BhEJAlF5jOaK4bSH+bP6oS71QXo/EIdoww2BRBguQ5a9fPmcbp60QFgpX/F7ux
         AwN6ZCuL68hsHqeu0RTrGX9kd71QNDxz6GJ+1DMHNmGe3XVnPTm/jEnxCux1kAoilyT7
         fI/ArH9RHufXL61EZSM2hSSsS1q3MCauzO/DGxpGvMM9A/4ulFV5FnS9Bdh9/xY9VS+y
         Zko2Lfe0CXoFZei6S3XfjHKFL6Mcoc41GTTIAKDQWp3rEJyKXWXrY4+G4dEfKwAMFzdc
         y2EA==
X-Gm-Message-State: AOAM532JujjpodL0Y4YWzVTSRR+gIGxp/gU4Jlyy7epPaPB9EBcC6cXp
        OeGb4L2RkonfSIFyNPAJ/OvT3GhLlWw=
X-Google-Smtp-Source: ABdhPJw6uhIWF/04hBkiI7l6/XxBmjdTaNRmv1B2KEBAVH93Dd45nsn0NEUi26EBLckNQpdAmipfyw==
X-Received: by 2002:a2e:a4ca:: with SMTP id p10mr5807971ljm.415.1630034898095;
        Thu, 26 Aug 2021 20:28:18 -0700 (PDT)
Received: from [192.168.2.145] (94-29-17-251.dynamic.spd-mgts.ru. [94.29.17.251])
        by smtp.googlemail.com with ESMTPSA id p14sm526286ljj.140.2021.08.26.20.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 20:28:17 -0700 (PDT)
Subject: Re: [PATCH v9 5/8] soc/tegra: pmc: Implement get_performance_state()
 callback
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210827013415.24027-1-digetx@gmail.com>
 <20210827013415.24027-6-digetx@gmail.com>
 <20210827030557.aymjkky7athjxpow@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9c2287ca-4c51-d782-a0a5-4b1227c2e9db@gmail.com>
Date:   Fri, 27 Aug 2021 06:28:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210827030557.aymjkky7athjxpow@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.08.2021 06:05, Viresh Kumar пишет:
> On 27-08-21, 04:34, Dmitry Osipenko wrote:
>> +	clk_opp_table = dev_pm_opp_set_clkname(dev, NULL);
>> +	if (IS_ERR(clk_opp_table)) {
>> +		dev_err(dev, "failed to set OPP clk: %pe\n", clk_opp_table);
>> +		ret = PTR_ERR(clk_opp_table);
>> +		goto put_hw;
>> +	}
> 
> Why do you need to do it ? OPP core already does this automatically.

Indeed, thanks.

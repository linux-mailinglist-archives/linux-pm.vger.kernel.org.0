Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B34A405927
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbhIIOhy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243822AbhIIOhv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:37:51 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1B4C04E20A;
        Thu,  9 Sep 2021 06:48:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s3so3074857ljp.11;
        Thu, 09 Sep 2021 06:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bxkGWvkG15EX7FPbo2/qIhSnLQMIC5j+VmNjXur2hE0=;
        b=FUTheVRVsrRnARDguAmHDKCc0rBVWHPfIHqTEf8zHzLlfz49IjS5FZFInh8lBAul+S
         OGVVHfOAdwbz42TgQjvivEMMxO5o4+ucZuaojJyXigCU3W77fHYSRDAc1yhADfxBmupq
         VRsjCjlRAcUr7IptHolkpjYk9JtgmQmjUXz7lnJoY/mc1EvmeOu2EN9uz/5WDnE6aA1X
         raaXF2owvRzbDJyKPc06yJwz+S9L6le/u3um3Cw3yNgmu5DwJYuqLlsYVqqIsQqB/wNg
         F8f1ChOo+LQNjItcbdNZzlGdgpSvJjJjQcXD6KLfUfKb0J7gIYjf2+ZGYhm/O8Gx2Uev
         lcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bxkGWvkG15EX7FPbo2/qIhSnLQMIC5j+VmNjXur2hE0=;
        b=uqMgFnIYvM7sq/sxy5ZTIy/c53GlvjjqhGMSvQdE1DZu/TB4jPzCd/L1hlBWOBCKMa
         Tfrmpla2a4pp9jdGOWj3flV91pUZz1ldp/qn+JybQaChHuVcH/yMmA1c+LD4ZFMTyzz3
         Hf5EQ+M7/0WmRg4yynaHfCVBu8OKIxM0KWCG3lvGI/jPSTCNIHMuR8Nx80hIk4T8/Okl
         7BV4kglfCwi5l2m4Cp1P/GWoTEQ93sIHVftnuw4ArKQD3vWzws0y1TkJyKsPWz2djUMM
         KEGz4xT7epkbXEdYJ/hcPsEheZAntoNrBUYOHvrv7InD9KvsuUxJBulhmPBSpWXmMqct
         LPsQ==
X-Gm-Message-State: AOAM533rEUm5de0K0lgO2kMIxinvE+SSm6DsDAZ7mt3ceQp4shhou7Zs
        n92+qQzAtd/SnXpXExq8RkoOTHs6TNQ=
X-Google-Smtp-Source: ABdhPJyeEUCBM7smg8nBYms1axUV3RPC40bfc93XOsmNvdiIR+JqL5qVRLvXDAywA4Po1KMd2Q+N/Q==
X-Received: by 2002:a2e:5708:: with SMTP id l8mr2382083ljb.481.1631195318124;
        Thu, 09 Sep 2021 06:48:38 -0700 (PDT)
Received: from [192.168.2.145] (46-138-3-129.dynamic.spd-mgts.ru. [46.138.3.129])
        by smtp.googlemail.com with ESMTPSA id o7sm211141lji.17.2021.09.09.06.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 06:48:37 -0700 (PDT)
Subject: Re: [PATCH 3/3] PM: domains: Add a ->dev_get_performance_state()
 callback to genpd
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-4-ulf.hansson@linaro.org>
 <4e36e732-6ca3-1d00-e6dd-38bb8877577b@gmail.com>
 <CAPDyKFr2oQnKOhKhWt_9VyBoe=HQ7Y0uZUMKTcZ05a7G9RaBYA@mail.gmail.com>
 <1124dae5-478f-f0ca-ea91-b6945f7c9254@gmail.com>
 <CAPDyKFqE+thX0pLTg9d-ds7Tj3hsB78EmDB1Cryh26tN3kvQDA@mail.gmail.com>
 <3d92711f-ce30-2c19-c6a4-bb77d32df2dd@gmail.com>
 <CAPDyKFpJU3g2OzJeR9KUdtN-8wJsDckqVAMQMHBV=enu=DfURg@mail.gmail.com>
 <fbca049a-e673-1598-658f-a7bb5de52f18@gmail.com>
 <CAPDyKFqw2tp3-J8dW03Kqw9xC_gO7nWfEckMvT3=zB0AbR8jeA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1ca9a2d5-e89a-5bbd-2ecc-01f1c4a820ae@gmail.com>
Date:   Thu, 9 Sep 2021 16:48:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqw2tp3-J8dW03Kqw9xC_gO7nWfEckMvT3=zB0AbR8jeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.09.2021 12:57, Ulf Hansson пишет:
> I don't mind extending the genpd API, but it needs to serve a good purpose.
> 
> As I said earlier, genpd doesn't know nor can control how the consumer
> driver deploys runtime PM. Unfortunately, that also includes genpd
> providers, as the behavior isn't a platform or PM domain specific
> thing. This means genpd needs to be generic enough so it works for all
> cases.
> 
> In the $subject patch, we rely on the pm_runtime_suspended() check in
> dev_pm_genpd_set_performance_state(), which should work for all cases,
> even if it may be sub-optimal for some scenarios.
> 
> Note that, in the approach your suggested [1],
> pm_runtime_status_suspended() is used instead. This doesn't work when
> a consumer driver doesn't enable runtime PM - or calls
> pm_runtime_set_active() during ->probe(), because
> genpd_runtime_resume() won't be invoked to restore the gpd->rpm_state.
> 
> That said, I wouldn't mind to simply skip adding the
> ->dev_get_performance_state() all together, if that is what you
> prefer? In this way, it becomes the responsibility for the consumer
> driver to do right thing, with the cost of some boilerplate code added
> in its ->probe() routine.

Until a day ago, it wasn't clear to me that consumer drivers now can set
up rpm_pstate during probe(), which is a cleaner solution that works
well. So let's skip adding the questionable ->dev_get_performance_state().

The boilerplate code in the probe() is minimal in comparison to a
previous variant with the state-syncing done by rpm-resume callbacks of
consumer drivers, it's good enough.

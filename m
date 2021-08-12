Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED97B3E9C91
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 04:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhHLC2m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 22:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhHLC2l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 22:28:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA57C061765;
        Wed, 11 Aug 2021 19:28:16 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e11so2639840ljq.4;
        Wed, 11 Aug 2021 19:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lrsZ4rJ1ke6TJoqbLeEh/j8Z0FFWGW9U5SAbObO/Mfc=;
        b=Cys4umoiPPyJT6ooVaSOUEB0BWEIuQ4qmvNYyoLOTvwAVceMyrweZUbsm5pTnbadue
         MUwWmMe5P7HuYah/CseKsTVLg+qKqGYoEkKRow8inJ3HyCN1JiI81KKNCw9iIvnvU5/f
         +KDQsAj0iIAAVis6GjgHFaZ3qiVYybMy8KNYCVIlKRDa8gFomd4ad/pcn2sxNsLb8GQ4
         TRMoyPiH4xKltc18Bolvd/EcPO7vCel26oUjzCR/pM+lngktMh/lcJdVFsJhYTMjo+RM
         FBxkuSeYVa4whaAoNG9g1meAK4mi3iZWcyAEo23MEhiSqjJSpad92pNy3K/TBIChXfrc
         v7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lrsZ4rJ1ke6TJoqbLeEh/j8Z0FFWGW9U5SAbObO/Mfc=;
        b=Ev40Y9k2j7lAHG5NWhWut2bisPzABqey6XIG7fA9bwuBfEpuC07YKxd8pW85b/N5Da
         KF0k8LEEs/5updJESYGQcrVMHF8b7qX3gL5CA5Ad6oC98Sd5NdnZqqTyBXE4ehEhkVnP
         1SvJWkKUl6Ma3Iai++RaZbTFKoJhDOW2ElaPDkdDuKri4x0ADnQz9E3IhJhUmoz6vF3Q
         gdVmPAf+fR1KnIr+a0tC31dD4hQLZJHoqPDVhrcOmQ6opAh8KZSVZEecnRvDvjuCSk4H
         uyMgsyX1sMH34BegsSJioMOxlxvxSGDoZgb+/xzhQuSSNnbeeZTIJygVT5y3pn3WgAch
         ps1w==
X-Gm-Message-State: AOAM5325tqkaHsSgSBMiVZxtInZViC9NUWTAB0rAEZFAqL0AZRzSkFku
        l7DWl3FcTYCrpIU5ce91Bs0=
X-Google-Smtp-Source: ABdhPJzoRVRDfSAT8m40auDl/FPWy4ltx1mT7G2jaDNXtR1e0YBmzAhx9YwF0WLHsSjqCTU0LgDEEA==
X-Received: by 2002:a2e:991:: with SMTP id 139mr1221729ljj.188.1628735294975;
        Wed, 11 Aug 2021 19:28:14 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id b4sm108196lfp.68.2021.08.11.19.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 19:28:14 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] PM / Domains: Add support for 'required-opps' to
 set default perf state
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, rojay@codeaurora.org, stephan@gerhold.net
References: <1628074696-7979-1-git-send-email-rnayak@codeaurora.org>
 <1628074696-7979-2-git-send-email-rnayak@codeaurora.org>
 <f58e631d-67a7-4981-ce59-6a4772b44564@gmail.com>
 <c43ddc6b-32ca-433d-76f2-901cb594eaf1@gmail.com>
 <9588f01d-1cb6-7ca3-eb41-74259f1678f6@gmail.com>
 <5f676dbe-6b8a-d302-cd81-2d12fe089e5a@codeaurora.org>
 <453bdc88-95a3-3798-9a11-ca8038c024ba@gmail.com>
Message-ID: <85e207da-51ca-bb25-4de6-90b287fa31f8@gmail.com>
Date:   Thu, 12 Aug 2021 05:28:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <453bdc88-95a3-3798-9a11-ca8038c024ba@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.08.2021 22:48, Dmitry Osipenko пишет:
> 11.08.2021 12:45, Rajendra Nayak пишет:
>>>
>>> If you have more than one power domain, then this will override the
>>> pstate which was set for a previous domain. This code doesn't feel solid
>>> to me, at least a clarifying comment is needed about how it's supposed
>>> to work.
>>
>> I don't quite understand the concern here, this should work with devices
>> having multiple power-domains as well. __genpd_dev_pm_attach gets called
>> once per power-domain, and we use the index above to identify the
>> power-domain.
> 
> The domain core code supports only one domain per device, see what
> genpd_set_performance_state() does. This means that the second domain
> will set the state of the *first* domain, which doesn't make sense. The
> genpd_set_performance_state() will actually fail with -ENODEV for all
> domains if you will try to do that.
> 

I confused the base device with the virtual device there, looks like it
should be okay then.

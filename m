Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACBF3E9934
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 21:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhHKTsx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 15:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhHKTsv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 15:48:51 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAA7C061765;
        Wed, 11 Aug 2021 12:48:27 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h11so6452379ljo.12;
        Wed, 11 Aug 2021 12:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BOF7L3BVa8QDJhfRLBEE2dkpehIt/0IbmaCR5Ju8kEQ=;
        b=euJh4y0FhoWH6pYTnzBBsez+zcsN7wbayT7FzUMdxnBGrRPbohqA9hpTuq9SxP28HU
         N4zqC7oI6CiWxixbAA5aWSGij7HnMAuSlr5H8LBB7bV9/Crtmga+YiwjCIp1pr01Mx0b
         qe5v6YEvWkwuLNb6GxrESGs5C7gx+i5r6du6D0VxEu/PlkYy/5X7W6CYtRGoPHRRDNgp
         n1u4nGiAMXjGdnsIZnsNGVqglhnacq/C7lUJnU9dDCk7bxSsG0TH/JWHaUoXvfry+s/4
         soRCGpSvJeW3Ps/u6Osy9OYXSHkWja+GwosH/iV6NY4GPFwILJdPb0nUVsvJtyrZptdC
         vCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BOF7L3BVa8QDJhfRLBEE2dkpehIt/0IbmaCR5Ju8kEQ=;
        b=COTwsxHrj55jPjC+hRTFs+LX98pcqHK/8iYzCjmnq+0PYpEG7HZmUcrXx7++88hchh
         TaUyPnVhQyfMldm4QOqQdnHm8w/vcbC6J/l/lG/514uEaDw7pAs/c2wNRjeY+qyqrCgF
         GNUIUk1WdgKfEtO7Xm+h5mWSpq0FAKrFsccIxTIZQUZR5E14ofPAdxFrIYljCxX5eLzg
         OIwJDLjIZAQ3m7OBoAtMEAq6/dRjt4sWRozXoJ9Y0m7gVTQGFSDdt+B1lDIe3KobDyRH
         C3M2UTeucEGSATc9CI5xn/NTklzpbWBEs8q+xKZ2KxjlAlCO5U6vmcIRFB0ux3R69A19
         /FJQ==
X-Gm-Message-State: AOAM533oezPhsSpAbUq4+59j34+Js/uPS5M/CdkgDJK8F0FJrDI14dzC
        GJ0qOyBVJ0aZFavpNWe++5+DjAHfbBw=
X-Google-Smtp-Source: ABdhPJyx8U1sSGOrw1admCN44QzcYM8AaKJTmXMopj+xi5BUo9wtOVNg6bRIxBqitQkPM3dp32Xiyw==
X-Received: by 2002:a2e:740d:: with SMTP id p13mr226354ljc.237.1628711305564;
        Wed, 11 Aug 2021 12:48:25 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id j17sm36267ljq.136.2021.08.11.12.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 12:48:25 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] PM / Domains: Add support for 'required-opps' to
 set default perf state
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <453bdc88-95a3-3798-9a11-ca8038c024ba@gmail.com>
Date:   Wed, 11 Aug 2021 22:48:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5f676dbe-6b8a-d302-cd81-2d12fe089e5a@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.08.2021 12:45, Rajendra Nayak пишет:
>>
>> If you have more than one power domain, then this will override the
>> pstate which was set for a previous domain. This code doesn't feel solid
>> to me, at least a clarifying comment is needed about how it's supposed
>> to work.
> 
> I don't quite understand the concern here, this should work with devices
> having multiple power-domains as well. __genpd_dev_pm_attach gets called
> once per power-domain, and we use the index above to identify the
> power-domain.

The domain core code supports only one domain per device, see what
genpd_set_performance_state() does. This means that the second domain
will set the state of the *first* domain, which doesn't make sense. The
genpd_set_performance_state() will actually fail with -ENODEV for all
domains if you will try to do that.

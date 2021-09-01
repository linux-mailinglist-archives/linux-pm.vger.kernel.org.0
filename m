Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E453C3FD328
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 07:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhIAFp0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 01:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhIAFp0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 01:45:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7557C061575;
        Tue, 31 Aug 2021 22:44:29 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id k13so4044278lfv.2;
        Tue, 31 Aug 2021 22:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sYmYM1pECiK9Q38GRtaMP6Q1CrynoiwRu+HWisG+zJ8=;
        b=hnPc2hjB2mSMWtsTKe7ZxknVrt+OYhq5tXoiv/vWmqga3ZVjkj9FzN1zdQKN8L14Hv
         Ob9Aua/BvdMZEy/+UK0LFJOEdyjihWw5jIc83Kppwpdw8dxtyYjhsa2OJ+BN7ZC9ZeGJ
         X5HkGpu2ScDJmCOO4e8Q3zVnDu9u2094FFW9cfY/ETG5t8xK0QwdMnbawmtNeJ+XOoxg
         iMw7YL1XUVHyV8ZYT7eVdDcGFo+TLJ5z+qVoWcddQANm8TDwvGNn9cz5ErYzp/RAMEKz
         z7E8qG2f3BDkW7qu0Tn1DmmMc4XQrewjMzhOgn/WbeheaDbP1gxxenrvpGlbZZXqdfeT
         juhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sYmYM1pECiK9Q38GRtaMP6Q1CrynoiwRu+HWisG+zJ8=;
        b=C/Oa4IHGYt5vXz+mYgDTDRfRXgOHnd0f1xRJoua3nqlViHtFZ0nII5wa6H/k8Ay2ID
         pB/r0xlKrHJETqT1OC8YX8GEcHVf5fzZG/9XbflkNc983M/yYOcb+JlbCvnvR9jehPJC
         uFRQ1KQsextC5ZY7un+Fi3kIG+HBBj7DIwD0GYnwW7hfwTYbbzgPHscdIfqXl1/Qo1xA
         u9PJ82LZ+4VmhGbv0AqtNXooqquPAfa/or6ElFCtgha4VvHPqfUttolL1VgZ6X91nc0K
         cmt6lTysbYTqH2Q3Lrd8iFJ3hZz+h2EP1sSxfK+ZQGQpYiJdAkZ7nFF/ACvX7l+7P1kH
         EPjA==
X-Gm-Message-State: AOAM533q7gX1wOWWHxevMA6LhyS3lwOdQBx9am7A97IkHm0xzHKSYKV5
        xqKpzV4U1sZu50SBb/gyNhYyygSVbyw=
X-Google-Smtp-Source: ABdhPJyQwk4WBez3hbfm2GPU0Jr8+35fqENuCwMyVYDODCtiyJR3hagzGc9T+DtHgcQiu73SmQbOZQ==
X-Received: by 2002:a05:6512:3404:: with SMTP id i4mr23046809lfr.149.1630475068204;
        Tue, 31 Aug 2021 22:44:28 -0700 (PDT)
Received: from [192.168.2.145] (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.googlemail.com with ESMTPSA id j1sm2425015lji.124.2021.08.31.22.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 22:44:27 -0700 (PDT)
Subject: Re: [PATCH v10 3/8] opp: Change type of
 dev_pm_opp_attach_genpd(names) argument
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
References: <20210831135450.26070-1-digetx@gmail.com>
 <20210831135450.26070-4-digetx@gmail.com>
 <20210901044117.abfwfebqw5lbn5zj@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e166f6e8-6de1-6e10-2607-78fbdc196a9d@gmail.com>
Date:   Wed, 1 Sep 2021 08:44:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901044117.abfwfebqw5lbn5zj@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.09.2021 07:41, Viresh Kumar пишет:
> On 31-08-21, 16:54, Dmitry Osipenko wrote:
>> Elements of the 'names' array are not changed by the code, constify them
>> for consistency.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/opp/core.c     | 6 +++---
>>  include/linux/pm_opp.h | 8 ++++----
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index 602e502d092e..d4e706a8b70d 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -2359,12 +2359,12 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>>   * "required-opps" are added in DT.
>>   */
>>  struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
>> -		const char **names, struct device ***virt_devs)
>> +		const char * const *names, struct device ***virt_devs)
> 
> I am sure there are issues around space around * here. Please run
> checkpatch with --strict option for your series.
> 

It is the other way around. This fixes the checkpatch warning and that's
what checkpatch wants. You may also grep the kernel to find that this is
the only variant used in practice.

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457CC3AA464
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 21:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhFPThZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 15:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhFPThZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 15:37:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F49C061574;
        Wed, 16 Jun 2021 12:35:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p17so6163779lfc.6;
        Wed, 16 Jun 2021 12:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rJAS0QO9/vvlILD/ZTa23zQtC2ltrapB5MkxJmRJVEg=;
        b=u0wPDzi4TM4v9c0jKyiLTcoEHZcJrKv79KDx7HBUAB+NNCsX1QCE7lsQ99gdqzYAZB
         pk1A9TXLT6qAWjqhV1m422oec+rlGkGOSi5qmpQ0NhVnYTDEsvELl7i8V8jAuVEGMCfP
         a+pqS2ci86prcmcQbnrrEhnfSpxkC8cyDkqBR/MpktLSidAzdpe16qbQkzRGHatOI31J
         nopbkcPm4Mq2PN4f9gnMjgtxW8giaW5/FrS4CnqcnjqMJ4dhI4fN8NXPomQx/COseANZ
         tLGglTqjz8hlUnghwu0wjkwNHQ1SFiDsQwssHwvPBCQr17YKg5uIfYfcTGKRZdIRe5s8
         ZeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rJAS0QO9/vvlILD/ZTa23zQtC2ltrapB5MkxJmRJVEg=;
        b=ivXWNyapq4DhJ9BQpDXZyi14azO8XKE9Ky+Vj6TfvMtFlXTj9eAocT4u1zw0jk3mag
         qrUUr4S8h/cnlUGopjCjtJKzE8skWsoKpXsIzPFcqquzJl9fJijDdSWjRO8qbjr7g9hT
         +jZLekA7FgyBxzlirakJCcLmUH/XKtmS12vANIyTpJVSnPZwGnFkg+lJgH8LpbDUa6vr
         Yp0QIuHiLBhmYWR68OEpMJPkh6yWKKTy946zpiiJkGbPhDOVHaFOAh3qQd13JwYENMHi
         FUxqYgRqLLs0G9uMEuUwyQDIL6KGkiq6k6oPfWcCtQw84bdlfwkAcZdCWZ4Jj+53/U8K
         6UVA==
X-Gm-Message-State: AOAM532NR958sGLLsJWNtl/0QXIyrtBkfsQogWJNAsCRpXE2ERL9rSX1
        Q0QhoUsZ1uKgKZcZDJdqdtOThhHks2c=
X-Google-Smtp-Source: ABdhPJwgBlDXU759cTSbp1ARDF1wy7fEejghYvLbfJfdsgHuij2hiUMaUEql8EuKrmF8RWkWIIuhtA==
X-Received: by 2002:ac2:5fd1:: with SMTP id q17mr860162lfg.496.1623872115743;
        Wed, 16 Jun 2021 12:35:15 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id q21sm370449lfm.240.2021.06.16.12.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 12:35:15 -0700 (PDT)
Subject: Re: [PATCH v1 4/5] clk: tegra: Add stubs needed for compile testing
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210606222817.12388-1-digetx@gmail.com>
 <20210606222817.12388-5-digetx@gmail.com>
 <d74be172-1ef5-48f7-e1a1-de63a05f64ba@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <53fc4f69-436b-8779-fc36-c54234d35449@gmail.com>
Date:   Wed, 16 Jun 2021 22:35:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d74be172-1ef5-48f7-e1a1-de63a05f64ba@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.06.2021 22:08, Daniel Lezcano пишет:
> On 07/06/2021 00:28, Dmitry Osipenko wrote:
>> Add stubs needed for compile-testing of tegra-cpuidle driver.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  include/linux/clk/tegra.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
>> index d128ad1570aa..9bd06d8a5436 100644
>> --- a/include/linux/clk/tegra.h
>> +++ b/include/linux/clk/tegra.h
>> @@ -42,7 +42,11 @@ struct tegra_cpu_car_ops {
>>  #endif
>>  };
>>  
>> +#ifdef CONFIG_ARCH_TEGRA
>>  extern struct tegra_cpu_car_ops *tegra_cpu_car_ops;
>> +#else
>> +static struct tegra_cpu_car_ops *tegra_cpu_car_ops __maybe_unused;
>> +#endif
> 
> Why not just have __may_be_unused without the #ifdef ?

The first variant is an external symbol. The tegra_cpu_car_ops* must be
specified somewhere, otherwise linkage will fail. The __maybe_unused
won't help here because symbol must be resolved by linker for the code
where it's used.

The latter variant is a static NULL pointer marked as __maybe_unused.
This allows to include header file universally without producing
compiler warning about the unused static variable during compile-testing.

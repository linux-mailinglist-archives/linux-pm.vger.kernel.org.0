Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFEED922F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 15:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfJPNQe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 09:16:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38868 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfJPNQe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 09:16:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id b20so24007436ljj.5;
        Wed, 16 Oct 2019 06:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2eaJx/OyqQZZTAm5CsVFp16VmzPO10Nk4o0s0ZEsAbE=;
        b=L5HWQ7i77HCMSkrt+9MBCEIdM82oyxiO56FPQ4V3yuINQD7Bb0RPXG52TTouiLOMxW
         1SbxmWqaWiXG2jPJB0ZOZ/lXqPBmk3ybN0zcrvyRcDxZg35c4UuPA9mBfaTDL+WxtW2V
         PqxIhB2Z9tjHnD+Yj/pOvGBl46PUNlhH77QoTB2LG6z6u2Ro1Uq8qWly+wGjKSYpkvdu
         A3DITIXXAswEdW3GgsF4+ZG6hPQaOgxMhr4SFIbbCIDy64ZObuIypKVTGQPPImIeMI3S
         X4rdl/yRlhDMjY9MUNwhpeBWde3RHKyElIZ4RLPeSr4zfVc+Epr5eAdvkNmg5W2ALqii
         FPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2eaJx/OyqQZZTAm5CsVFp16VmzPO10Nk4o0s0ZEsAbE=;
        b=GpPws1sP2kra8nWWf7r9aKq6bLseC0pgOZK28zfwdbWPWXgQXneniUMyishwIb82VA
         LDeyghuq+WWPJCPJvU8Sc5wp5ZLCgO7Oi8rN2ZuJObtP0pSnpk895GbrhlDwgY3mUWPI
         fmsCsGi5BCLFnNEILq+EeNwQeNyfNR8mIM1hTOu2crP7ZapVzGeddO1MKZ6s5YCgwJpW
         NkZuoprJiimeV1piIAo3hES9Ymi3PO2K14lYYzPR56oCIKTi3AbrQxBkcTELwqCdm56v
         YpwAnabqJh4y+bmP/fuMevPe0PZkQeHmiP2CDOjQzl6Ju6YUKIcSZNDbbXkGdj9/201Q
         HWqg==
X-Gm-Message-State: APjAAAWXyYB4hAoVJZZ9ghXIKOy1MCLFU/2f5nB4yuU8NDA0mzgtRvCm
        EOyIqJZhiYwK7hR1sGlO9uqo9KuI
X-Google-Smtp-Source: APXvYqwLPxmgwfFTEd8ELrVAVxO3Sr1h1NF0s2EVJlAjvaMb778NDDAG/JFViNEb+c3Tu7tEFOTw2w==
X-Received: by 2002:a2e:8593:: with SMTP id b19mr26008676lji.34.1571231789792;
        Wed, 16 Oct 2019 06:16:29 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id m17sm9866003lje.0.2019.10.16.06.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 06:16:29 -0700 (PDT)
Subject: Re: [PATCH v1 00/17] NVIDIA Tegra20 CPUFreq driver major update
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191015211618.20758-1-digetx@gmail.com>
 <20191016052716.yipztnpg7bcuzhfn@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8cf055a3-57fd-c275-9e74-a9fb5d284866@gmail.com>
Date:   Wed, 16 Oct 2019 16:16:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016052716.yipztnpg7bcuzhfn@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.10.2019 08:27, Viresh Kumar пишет:
> On 16-10-19, 00:16, Dmitry Osipenko wrote:
>> Hello,
>>
>> This series moves intermediate-clk handling from tegra20-cpufreq into
>> tegra-clk driver, this allows us to switch to generic cpufreq-dt driver
>> which brings voltage scaling, per-hardware OPPs and Tegra30 support out
>> of the box. All boards need to adopt CPU OPPs in their device-trees in
>> order to get cpufreq support. This series adds OPPs only to selective
>> boards because there is assumption in a current device-trees that CPU
>> voltage is set for 1GHz freq and this won't work for those CPUs that
>> can go over 1GHz and thus require voltage regulators to be set up for
>> voltage scaling support (CC'ed Marcel for Toradex boards). We could
>> probably add delete-node for OPPs over 1GHz if there are not actively
>> maintained boards.
> 
> How do you want to get these patches merged ? Can I just pick the cpufreq bits
> alone ?
> 

The cpufreq bits strictly depend on the clk patches and the regulators
coupler/balancer series. Hence all patches in this series should collect
acks from relevant maintainers and then Thierry will pick up the
patchsets in a correct order via tegra tree, at least that's my vision.

Thierry, are you okay with that approach?

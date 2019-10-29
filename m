Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86655E8B05
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 15:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389417AbfJ2Ol3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 10:41:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43643 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388712AbfJ2Ol2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 10:41:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id s4so14669842ljj.10;
        Tue, 29 Oct 2019 07:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mq0rcck4YENtZgkBoH2X5LqHkGf3xXbIuvoCt8jLIbs=;
        b=pdfvkdU03R2UCabpac0Z9HYX/Lrlc+6UwP8tVqkXXQdh3l15LiQM652yORNcqIC8LQ
         MU6WTI/00Ys2RVA2iuo6Bz/kYShtftbxNO62WNrWXoVegTDPOJS+0lpJmXkHMMnoZhPb
         N2zhAVtj5JEMr3Szbu25Usgysbb746vJo2WVvXcpfVdxBNzzO4OeWsx6dSSoSmzm2rjA
         KWU+x97k6QYkkuFQyBXERxOv8Q3sQ3RhfiwmwF3sAyVJGfa1AwiTMFw776O7OnMMipXR
         4tQ2Wpg+9MP0MmLOx2sUhgih5EZ7YOd13d34BMnDoXtBU0QC3wf2tf52YQ1ctAeh/15W
         G17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mq0rcck4YENtZgkBoH2X5LqHkGf3xXbIuvoCt8jLIbs=;
        b=R935XsEY0XWodX7pRCE9Fs5Y9LqQFyIM2a//5qOMPho3mmE/wV3PyEK9ka6cWN92OW
         Zxh14QTqftufacVtbfaiUXVuIdRWpMrs0BKUEd4DFb/c0me4VScyPwAKLFQgpTJkyvdS
         ydNa6o0S+e+W1DP5F+idmp0NYmkT9nmQ3tAybDpPqLoolr7uGz+B+ar9eoMq89mBye1d
         vsoz98r5nIbgMiP/3Je1DXPKro9XKtOaBmTML8ilzm7+tsszp6izilw7V9PFEIQN2Rze
         tKxKbzVrXdDmRDNVX11E61J7iK0D+Hp9X4ZxfZlwl1kAs/UTYW+oiv1Y1QQKdO2cbQ6s
         q+PA==
X-Gm-Message-State: APjAAAVaDoZ3lnvsNyEcLtH9P6FUQlMCaGatyiKOjW98n03+XHbmHYQE
        tzF5MLHrcrcigxBQP2WQ8DgTMPkP
X-Google-Smtp-Source: APXvYqzq3B/MhcDmK3EWG9bARkLKloL5JDnxFGy/C6uKmIvGY6mrnKiQQ3Gl9ED5nEcGmUWKWlGxhw==
X-Received: by 2002:a2e:9b9a:: with SMTP id z26mr2981322lji.59.1572360085051;
        Tue, 29 Oct 2019 07:41:25 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id q14sm7223768ljc.7.2019.10.29.07.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2019 07:41:24 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] NVIDIA Tegra20 CPUFreq driver major update
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191024221416.14197-1-digetx@gmail.com>
 <20191029140959.GL508460@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <374c3916-7c25-d684-0506-4c3992fa5241@gmail.com>
Date:   Tue, 29 Oct 2019 17:41:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029140959.GL508460@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

29.10.2019 17:09, Thierry Reding пишет:
> On Fri, Oct 25, 2019 at 01:13:59AM +0300, Dmitry Osipenko wrote:
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
>>
>> NOTE(!): the voltage scaling functionality depends on a reviewed and yet
>> unapplied series [0], thus [0] needs to be applied first.
>>
>> [0] https://lkml.org/lkml/2019/7/25/892
>>
>> Changelog:
>>
>> v2: - Kept modularity of the tegra20-cpufreq as was requested by Viresh Kumar
>>       in a review comment to v1.
>>
>>     - Added acks from Viresh Kumar.
>>
>>     - Added tested-by from Nicolas Chauvet to the "trimslice" patch.
>>       Nicolas told me on IRC that it works fine.
>>
>>     - Fixed compilation of the "Add custom CCLK implementation" patch. The
>>       error happened because v1 was based on top of yet unreviewed/unapplied
>>       patch "clk: tegra: divider: Support enable-bit for Super clocks". Thanks
>>       to Peter Geis for reporting the problem.
>>
>>     - Replaced Tegra30 "beaver" board with "cardhu-a04" because turned out
>>       that's what NVIDIA uses in the testing farm.
>>
>> Dmitry Osipenko (17):
>>   clk: tegra: Add custom CCLK implementation
>>   clk: tegra: pll: Add pre/post rate-change hooks
>>   clk: tegra: cclk: Add helpers for handling PLLX rate changes
>>   clk: tegra20: Support custom CCLK implementation
>>   clk: tegra30: Support custom CCLK implementation
>>   dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
>>   cpufreq: tegra20: Use generic cpufreq-dt driver (Tegra30 supported
>>     now)
>>   ARM: tegra: Create tegra20-cpufreq platform device on Tegra30
>>   ARM: dts: tegra20: Add CPU clock
>>   ARM: dts: tegra30: Add CPU clock
>>   ARM: dts: tegra20: Add CPU Operating Performance Points
>>   ARM: dts: tegra30: Add CPU Operating Performance Points
>>   ARM: dts: tegra20: paz00: Set up voltage regulators for DVFS
>>   ARM: dts: tegra20: paz00: Add CPU Operating Performance Points
>>   ARM: dts: tegra20: trimslice: Add CPU Operating Performance Points
>>   ARM: dts: tegra30: cardhu-a04: Set up voltage regulators for DVFS
>>   ARM: dts: tegra30: cardhu-a04: Add CPU Operating Performance Points
> 
> I've applied patches 9-17 (the DT bits) to for-5.5/arm/dt. I'll hold
> back on applying the others until Peter is happy with them.

Thanks, I'll update the patches and re-add OPPs for the Beaver board
since you have it.

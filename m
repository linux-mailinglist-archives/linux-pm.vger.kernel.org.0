Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA97D924F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 15:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393477AbfJPNVY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 09:21:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41520 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388141AbfJPNVX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 09:21:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id f5so24006776ljg.8;
        Wed, 16 Oct 2019 06:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8t0MjC1TDAZp6Auw3cZVTxNMQ8hM6OEjKScXfrE2vxU=;
        b=n3woTuDzJV9AoYhlwEUS1oYaJH8ERL8aYYerhx7ked9ZxHwomfoUQiakFZyIw0xAi8
         jMDcaoxBQjAQMQV8ee76tUAQYLQJINhX+iuVSmtMW9x1wah/TE/9JRrvqkaQZP/awuEG
         fLCuUk6k3lsgz00JEB65n09eoVuFDP9M5V1+Im9hG9wmjchAHPqVqYg8HpXa7Pdc2qvB
         cEeU4v//zGCTQBr9LBU1wZ3yaxFlC/4lM8cX8zw5Om9brz2SjYb8vFipX2XwDckTRdXh
         LOBWQRACI2X2/mVMjYrS0UmPi/3Jz8FA0WEqoTpMn5Ik8FZjg6mlCMftiqkd4kPutKiD
         hUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8t0MjC1TDAZp6Auw3cZVTxNMQ8hM6OEjKScXfrE2vxU=;
        b=PZWQS8qGBLPXVVxs0T9M3vjgRq4JuaXvGHivIo55cz9ntcjDr6+Y/zxdcHn0+zbcMH
         y5g1SlbjEZ3kSxiVrvqrX7Z1aAsAimEaKYJ9xF+NSxGE0pN4fBVXmtzXlE+t8/nufEzJ
         5UuZ4C0/cv4v7vCzL9L2hn4vGJ2xyadyJII7kiyThsp7XbV1RsRPshHhKWar3bKk7JCf
         tGxxZmjibHx2OEnXwmbPeEIuDW8EtFa7fuaWjfKaDAlCvHkKp2TbAWmh9p07ocAFNv9z
         FL5rCcFu4ax9Uh7nofi9mZNvezqaJsDqDkMCiZva5XYQ55+MBnBPCoW90CitaZZxgbPE
         /2Bw==
X-Gm-Message-State: APjAAAUqkd4d7K9nB+kXsLiU3Xe3gQNHS7oazYOenR2zs/k1YYJSNvUA
        eIc5Q+sQkqroHryxH9mU+NV0muwS
X-Google-Smtp-Source: APXvYqyCT7A8rXmaOtj0hAM67N241Q5cshOzSzWgLHHqVdjLhd39lFdCGWmC4ZBv8jOCBy6BfBhnBg==
X-Received: by 2002:a2e:42d6:: with SMTP id h83mr25258614ljf.21.1571232081003;
        Wed, 16 Oct 2019 06:21:21 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id b67sm7983191ljf.5.2019.10.16.06.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 06:21:20 -0700 (PDT)
Subject: Re: [PATCH v1 11/17] ARM: dts: tegra20: Add CPU Operating Performance
 Points
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
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
 <20191015211618.20758-12-digetx@gmail.com>
 <20191016052323.w6hav4qqn3ybt55q@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ba9d6de0-38dc-a851-cf0a-fb9d06461671@gmail.com>
Date:   Wed, 16 Oct 2019 16:21:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016052323.w6hav4qqn3ybt55q@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.10.2019 08:23, Viresh Kumar пишет:
> On 16-10-19, 00:16, Dmitry Osipenko wrote:
>> Operating Point are specified per HW version. The OPP voltages are kept
>> in a separate DTSI file because some boards may not define CPU regulator
>> in their device-tree if voltage scaling isn't necessary, like for example
>> in a case of tegra20-trimslice which is outlet-powered device.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../boot/dts/tegra20-cpu-opp-microvolt.dtsi   | 201 ++++++++++++
>>  arch/arm/boot/dts/tegra20-cpu-opp.dtsi        | 302 ++++++++++++++++++
>>  2 files changed, 503 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
>>  create mode 100644 arch/arm/boot/dts/tegra20-cpu-opp.dtsi
>>
>> diff --git a/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi b/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
>> new file mode 100644
>> index 000000000000..e85ffdbef876
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
>> @@ -0,0 +1,201 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/ {
>> +	cpu0_opp_table: cpu_opp_table0 {
>> +		opp@216000000_750 {
> 
> Maybe just drop the _750 (i.e. voltage) from the names as we don't generally
> follow it :)

The reason for the _750 postfix is that there are multiple OPPs for
216MHz and they have different voltages for different versions of
hardware, thus those are separate OPPs and they can't be squashed into a
single OPP node.

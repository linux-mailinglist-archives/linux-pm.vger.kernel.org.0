Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1495A2B921D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 13:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgKSMHX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 07:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgKSMHV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 07:07:21 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FEEC0613CF;
        Thu, 19 Nov 2020 04:07:21 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id x9so5959522ljc.7;
        Thu, 19 Nov 2020 04:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XNcQDlSky0473W8VySzMpMuIce1nRSFbAcunyERFzjM=;
        b=BJV/VSOQ3xMoNz/C2XTRHFXlHvh/qldIAfJK0NVTpgWQbjLLMN3qwJLa2d5V7QpmeF
         5q+7sBV/Ru5M+wEFbjLtafbEPwB4yIlLzfdirPbrQbqzbEXX8qcEcTZBtsmoH5LE8PV+
         JE/FsB+p4FKIxKi1rY3paYHIRf5357+xtYzVLZiEexJoyYiZOaC2WdeilQSq4ct5htsm
         IZGBRkwQc8qdtNCOnQuMJCtme/2FwPuKnZ2rUf1sjt/i4UTgH+uGXiGyNS4b+gFYQ6UD
         2cY7FFYkkl8CfmCFjKvKwWtH3Wa/FgxZg/ewFq/F8uhly93waz6nvPcvGwEejLv+Ly2g
         taVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XNcQDlSky0473W8VySzMpMuIce1nRSFbAcunyERFzjM=;
        b=gobK9Tq0vNH6NAO4xAgXCJ4mPmaZZlm7a4Vpo2q4qf7xeUqgArqTPSGfAKlce307iD
         BTH2f3GCPyNAXDe+25n4InZ3UyA765F62jxE6JxvAp5zGDzLfKTwLIWsl8mfLm95Cy+I
         Fv+B6RYsTJCEKTRkQm7U9YChXS4xGcetDavAQ9wLvNnVusaAC+ncpLIIsyKw+cb9uyD5
         haR7kz1hIl7l34GS+lkhNOSSoXfb8sOyxNMxLzNZst/AwfjlhhGnEvAHN3NK51bSvMRG
         Aj3266DNq9PfDNzuS0tYlgRy10m0nwYffpvtfEUMdElQtYdtvM9jHcLMHBMbCFLMJJWJ
         +fWg==
X-Gm-Message-State: AOAM531XOgJlY9qBe3JCBtSPPsJRtWcK1Pqb3c/LRMuyQiIOypnHBg6R
        WEH08at+elIsNXpCa4TP/3k=
X-Google-Smtp-Source: ABdhPJzTGHmquQc4BHfAODo4wPFuYfs6q8K9WgflUR9F3k6wl2Eq2xQD6S3z58PAyprBfztKp9Ogcg==
X-Received: by 2002:a2e:9083:: with SMTP id l3mr5729986ljg.118.1605787639748;
        Thu, 19 Nov 2020 04:07:19 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id e15sm3960412lfn.292.2020.11.19.04.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 04:07:18 -0800 (PST)
Subject: Re: [PATCH v9 01/17] memory: tegra30: Support interconnect framework
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
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
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201115212922.4390-1-digetx@gmail.com>
 <20201115212922.4390-2-digetx@gmail.com>
 <61e777d9-b730-02c6-cedf-cf0aa1a50fb8@linaro.org>
 <7e484678-43cc-e612-1017-73ed580f9840@gmail.com>
 <83a3f33b-3695-2a40-1c2b-5c38d117c1ad@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2c186e6a-444c-c2b9-56fc-1d519ecd4e20@gmail.com>
Date:   Thu, 19 Nov 2020 15:07:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <83a3f33b-3695-2a40-1c2b-5c38d117c1ad@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.11.2020 18:30, Georgi Djakov пишет:
> On 18.11.20 0:02, Dmitry Osipenko wrote:
>> 17.11.2020 23:24, Georgi Djakov пишет:
>>> Hi Dmitry,
>>>
>>> Thank you working on this!
>>>
>>> On 15.11.20 23:29, Dmitry Osipenko wrote:
>>>> Now Internal and External memory controllers are memory interconnection
>>>> providers. This allows us to use interconnect API for tuning of memory
>>>> configuration. EMC driver now supports OPPs and DVFS. MC driver now
>>>> supports tuning of memory arbitration latency, which needs to be done
>>>> for ISO memory clients, like a Display client for example.
>>>>
>>>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>    drivers/memory/tegra/Kconfig       |   1 +
>>>>    drivers/memory/tegra/tegra30-emc.c | 349
>>>> +++++++++++++++++++++++++++--
>>>>    drivers/memory/tegra/tegra30.c     | 173 +++++++++++++-
>>>>    3 files changed, 501 insertions(+), 22 deletions(-)
>>>>
>>> [..]> diff --git a/drivers/memory/tegra/tegra30.c
>>> b/drivers/memory/tegra/tegra30.c
>>>> index d0314f29608d..ea849003014b 100644
>>>> --- a/drivers/memory/tegra/tegra30.c
>>>> +++ b/drivers/memory/tegra/tegra30.c
>>> [..]
>>>> +
>>>> +static int tegra30_mc_icc_set(struct icc_node *src, struct icc_node
>>>> *dst)
>>>> +{
>>>> +    struct tegra_mc *mc = icc_provider_to_tegra_mc(src->provider);
>>>> +    const struct tegra_mc_client *client = &mc->soc->clients[src->id];
>>>> +    u64 peak_bandwidth = icc_units_to_bps(src->peak_bw);
>>>> +
>>>> +    /*
>>>> +     * Skip pre-initialization that is done by icc_node_add(), which
>>>> sets
>>>> +     * bandwidth to maximum for all clients before drivers are loaded.
>>>> +     *
>>>> +     * This doesn't make sense for us because we don't have drivers
>>>> for all
>>>> +     * clients and it's okay to keep configuration left from
>>>> bootloader
>>>> +     * during boot, at least for today.
>>>> +     */
>>>> +    if (src == dst)
>>>> +        return 0;
>>>
>>> Nit: The "proper" way to express this should be to implement the
>>> .get_bw() callback to return zero as initial average/peak bandwidth.
>>> I'm wondering if this will work here?
>>>
>>> The rest looks good to me!
>>
>> Hello Georgi,
>>
>> Returning zeros doesn't allow us to skip the initialization that is done
>> by provider->set(node, node) in icc_node_add(). It will reconfigure
>> memory latency in accordance to a zero memory bandwidth, which is wrong
>> to do.
>>
>> It actually should be more preferred to preset bandwidth to a maximum
>> before all drivers are synced, but this should be done only once we will
>> wire up all drivers to use ICC framework. For now it's safer to keep the
>> default hardware configuration untouched.
> 
> Ok, thanks for clarifying! Is there a way to read this hardware
> configuration and convert it to initial bandwidth? That's the
> idea of the get_bw() callback actually. I am just curious and
> trying to get a better understanding how this works and if it
> would be useful for Tegra.

MC driver can't easily retrieve and convert initial bandwidths because
they depend on knowing hardware state that is not accessible by the MC
driver.

But in fact it's unnecessary to know the initial bandwidth in the case
of this MC ICC driver because if configuration is re-set to the same
value, then this is equal to leaving configuration unchanged.

It's okay to keep memory latency configuration unchanged if memory clock
rate goes up, which is what happens here during init. Please notice that
EMC ICC drivers (which control the clock rate) don't skip the initial
bandwidth change.

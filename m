Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E7C3FD624
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 11:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241783AbhIAJFl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 05:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239862AbhIAJFl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 05:05:41 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EA9C061575;
        Wed,  1 Sep 2021 02:04:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id k13so5002585lfv.2;
        Wed, 01 Sep 2021 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lb0WDcooiLjZrWJbuHVyVI526nowEEZaeh+uW9o5yGU=;
        b=bZlIh7qCjMF/PKK2cyjMG5o3RoUdvhTou5w6Ca6AL66ITESvOlqYLVm1/K4X6M2F4F
         lrY2Rs5CBujH+NjvNnYVr9yzzkstu4072p00UkiVuvckmN2/mPKY96JgfGcxT9KKOpYe
         fbKnX9PdnLQYtVw+1RfJ5ozByJudimTxSzNLGJceHJ6/MNyuq8CWfcflAhKMkM437uUb
         MSyuzu3aGX7VtMoCUdqbxXdYkQYaqTQmdL7ij7t2RIMWHezYTorr1KxbFsFJH5s4gbBC
         VsN3Cf8GyPR/nwig9qeY4LR8nOd7iGxOmLpJEJekgWQmZ/pIRu5zc/7K19WEYMhu7TiZ
         V7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lb0WDcooiLjZrWJbuHVyVI526nowEEZaeh+uW9o5yGU=;
        b=KAv21Q2hJi80J6NJ44m9uORWgLLdKU+8JCsCAWWTtM5qpvTYyhjRQ/d6cd00/5CV8U
         9Kj7yCXriSLAfI/Ne27C/tG8xd+AyhiXOBjEKezkhUqCwVHS7YDa+hF5QVFFxfAWlhGB
         vku9eyfTHcyB/DrFzG9LIo5FebddIdvcjnP0zejkOGRbLfvFar4S040l/jEGeQZBfwsZ
         BphfK15VN/kSkQc9e1T3uqmfyND+6J7fODD8gSxw4cV4unWDIv1x3eYPiXQ5St2TUx71
         o74ksoPsTy02n0ViviDhPqFE4Mup6T9mbHlV3NncOyAJ5HSykXWYHMDQBX1rlpGwvzJa
         BIBA==
X-Gm-Message-State: AOAM530IL2vtHhtTsAkxsy/9+04sV9ydG6kL/9Vh10eYRxRHtwvUqBiC
        +bBwt4pn37uf1JXV46PoYsrAq82euFY=
X-Google-Smtp-Source: ABdhPJwzaDt1aFXlRH32T3WVMxLRthCkSWz2MVde/5TqrcObDEhEMTXnSffl1OGatrNgdqPOK5kusQ==
X-Received: by 2002:a05:6512:398c:: with SMTP id j12mr434739lfu.102.1630487082749;
        Wed, 01 Sep 2021 02:04:42 -0700 (PDT)
Received: from [192.168.2.145] (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.googlemail.com with ESMTPSA id 10sm2466404ljo.112.2021.09.01.02.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 02:04:42 -0700 (PDT)
Subject: Re: [PATCH v10 5/8] soc/tegra: pmc: Implement
 dev_get_performance_state() callback
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
 <20210831135450.26070-6-digetx@gmail.com>
 <20210901061050.4x3t4cc434zdwx3a@vireshk-i7>
 <7f4f5ab0-cf23-3e27-211e-4dcd8903f96f@gmail.com>
 <20210901071655.gf6qg7piisddg2a3@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7f1eacd5-683c-1bba-4503-58ec418e1c85@gmail.com>
Date:   Wed, 1 Sep 2021 12:04:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901071655.gf6qg7piisddg2a3@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.09.2021 10:16, Viresh Kumar пишет:
> On 01-09-21, 09:57, Dmitry Osipenko wrote:
>> 01.09.2021 09:10, Viresh Kumar пишет:
>>> So you create the OPP table and just after that you remove it ? Just
>>> to get the current OPP and pstate ? This doesn't look okay.
>>>
>>> Moreover, this routine must be implemented with the expectation that
>>> the genpd core can call it anytime it wants, not just at the
>>> beginning. And so if the table is already setup by someone else then,
>>> then this all will just fail.
>>
>> This is not doable using the current OPP API, it doesn't allow to
>> re-use initialized OPP table.
> 
> That isn't correct, you can call dev_pm_opp_of_add_table() as many
> times as you want. It will just increase the refcount and return the
> next time.
> 
> Yes, you can call the APIs like set-clk-name or supported-hw, since
> they are supposed to be set only once.
> 
>> The current limitation is okay because genpd core doesn't call
>> routine anytime.
> 
> Yeah, but is broken by design. People can make changes to genpd core
> later on to call it as many times and they aren't required to have a
> look at all the users to see who abused the API and who didn't.
> 
>>> Can you give the sequence in which the whole thing works out with
>>> respect to the OPP core? who calls
>>> devm_tegra_core_dev_init_opp_table() and when, and when exactly will
>>> this routine get called, etc ?
>>>
>>
>> gr3d_probe(struct platform_device *pdev)
> 
> Thanks for this.
> 
>> {
>> 	gr3d_init_power(dev)
>> 	{
>> 		static const char * const opp_genpd_names[] = { "3d0", "3d1", NULL };
>>
>> 		devm_pm_opp_attach_genpd(dev, opp_genpd_names)
>> 		{
>> 			dev_pm_opp_attach_genpd(dev, names, virt_devs)
>> 			{
>> 				// takes and holds table reference
>> 				opp_table = _add_opp_table(dev, false);
>>
>> 				while (*name) {
>> 					// first attachment succeeds, 
>> 					// second fails with "tegra-gr3d 54180000.gr3d: failed to set OPP clk: -EBUSY"
>> 					dev_pm_domain_attach_by_name(dev, *name)
>> 					{
>> 						tegra_pmc_pd_dev_get_performance_state(dev)
>> 						{
>> 							dev_pm_opp_set_clkname(dev, NULL);
>> 							dev_pm_opp_of_add_table(dev);
> 
> What you end up doing here is pretty much like
> devm_tegra_core_dev_init_opp_table_simple(), right ?

Yes

>> 							opp = dev_pm_opp_get_current(dev);
>> 							dev_pm_opp_of_remove_table(dev);
>> 							dev_pm_opp_put_clkname(opp_table);
> 
> You shouldn't be required to do this at all.
> 
>> 							...
>> 						}
>> 						// opp_table->clk = ERR_PTR(-EINVAL) after the first attachment
>> 					}
>> 				}
>> 			}
>> 		}
>> 	}
>>
>> 	devm_tegra_core_dev_init_opp_table_simple(&pdev->dev);
> 
> Can we make the call at the beginning ? before calling
> gr3d_init_power() ? I mean you should only be required to initialize
> the OPP table just once.

This breaks dev_pm_opp_set_supported_hw() which isn't allowed to be
called for a populated OPP table, set/put_hw also isn't refcounted.

> If not, then what about calling
> devm_tegra_core_dev_init_opp_table_simple() from here and from
> tegra_pmc_pd_dev_get_performance_state() as well ?
> 
> And update devm_tegra_core_dev_init_opp_table_simple() to call
> dev_pm_opp_get_opp_table() first and return early if the OPP table is
> already initialized ?
> 

This doesn't work for devm_pm_opp_register_set_opp_helper() that is used
by gr3d_probe() because set_opp_helper() should be invoked only before
table is populated and it's already populated for the case of a
single-domain h/w since domain is attached before driver is probed.

But it's a good idea to use dev_pm_opp_get_opp_table(). I got it to work
by adding dev_pm_opp_get_opp_table() to
tegra_pmc_pd_dev_get_performance_state() and moving
devm_tegra_core_dev_init_opp_table_simple() before gr3d_init_power().

Thank you for the suggestion, I'll change it in v11.

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4703E4CA0F2
	for <lists+linux-pm@lfdr.de>; Wed,  2 Mar 2022 10:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbiCBJi1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Mar 2022 04:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240557AbiCBJiZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2022 04:38:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 719D224BC7;
        Wed,  2 Mar 2022 01:37:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3B9F1042;
        Wed,  2 Mar 2022 01:37:41 -0800 (PST)
Received: from [10.57.21.27] (unknown [10.57.21.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDA013F66F;
        Wed,  2 Mar 2022 01:37:39 -0800 (PST)
Message-ID: <b9f12eb6-9156-022d-1069-662a0af05aaa@arm.com>
Date:   Wed, 2 Mar 2022 09:37:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/4] OPP: Add support of "opp-microwatt" for advanced
 EM registration
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220301093524.8870-1-lukasz.luba@arm.com>
 <20220301093524.8870-4-lukasz.luba@arm.com>
 <20220302074515.dqzoutfiobildiph@vireshk-i7>
 <e02d9113-d1ae-c029-750f-aece1cefab2d@arm.com>
 <20220302093036.qanm3vxuajinzbwb@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220302093036.qanm3vxuajinzbwb@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/2/22 09:30, Viresh Kumar wrote:
> On 02-03-22, 08:50, Lukasz Luba wrote:
>> If you like, I can introduce new dual-macro implementation
>> in energy_modle.h which would sole this issue:
>>
>> ifdef EM:
>> #define EM_SET_ACTIVE_POWER_CB(em_cb, cb) ((em_cb).active_power = cb)
>>
>> ifndef EM:
>> #define EM_SET_ACTIVE_POWER_CB(em_cb, cb) do { } while (0)
>>
>>
>> Then we would keep the single call to the registration EM and
>> we would have:
>>
>>          if (_of_has_opp_microwatt_property(dev)) {
>>                  EM_SET_ACTIVE_POWER_CB(em_cb, _get_dt_power);
>>                  goto register_em;
>>          }
>>
>>
>> 	
>>          EM_SET_ACTIVE_POWER_CB(em_cb, _get_power);
>>
>> register_em:
>>          ret = em_dev_register_perf_domain(dev, nr_opp, &em_cb, cpus, true);
>>
>>
>> I can do that, please let me know.
> 
> That will work as well.
> 

Great. Thank you for your comments. I'll send v5.

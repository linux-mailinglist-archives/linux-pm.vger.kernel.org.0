Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC075B96F5
	for <lists+linux-pm@lfdr.de>; Thu, 15 Sep 2022 11:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiIOJFf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Sep 2022 05:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIOJFe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2022 05:05:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60BD595E4B
        for <linux-pm@vger.kernel.org>; Thu, 15 Sep 2022 02:05:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73A3C1692;
        Thu, 15 Sep 2022 02:05:38 -0700 (PDT)
Received: from [10.57.14.196] (unknown [10.57.14.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEBA93F73B;
        Thu, 15 Sep 2022 02:05:30 -0700 (PDT)
Message-ID: <ca1138d7-a67b-77d4-bc64-7bfbd7ac020b@arm.com>
Date:   Thu, 15 Sep 2022 10:05:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Subject: Follow up to the LPC2022 discussion around power cooling device
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel, Rafael,

Thanks for discussion on LPC around the power & thermal control [1].
Here is the list of known issues which could be used as requirements
for this proposed 'power cooling device'. IMO it would be a good
place for new approaches how we estimate power. Then we could
clean up the cpufreq cooling and devfreq cooling code.

A known design issues from IPA perspective:
1. Input power estimation based on CPU utilization and current
CPU frequency. The estimated power can be wrong, especially with
schedutil and uclamp when the frequency can be changed in the
middle of the IPA period (e.g. 50ms). Also missing accounting
of idle time contributes to this. I've sent a proposal how to
track better the frequency residency time combined with idle
time [2].
2. The maximum allowed frequency (for CPUs and devfreq) can be set by
user-space but IPA doesn't know about it and uses the default max value,
which is a wrong assumption. The our power budget split is wrong. I've
sent some proposal how to get that info into IPA at that time for
devfreq only [3].
3. Missing possibility to equpit a HW energy meter, which then could
be used for deriving total power for a given IPA period for the
cooling device (e.g. CPU cluster or GPU). I have patches internally
to address that which could be send to LKML as RFC to EM extension.
This would address the problem of different power usage due to
different instruction & data mix in the workload.

I can see a good potential to nicely split the work and build a
momentum to address those challenges.

Regards,
Lukasz

[1] https://lpc.events/event/16/contributions/1189/
[2] 
https://lore.kernel.org/linux-pm/20220406220809.22555-1-lukasz.luba@arm.com/
[3] https://lore.kernel.org/all/20210126104001.20361-1-lukasz.luba@arm.com/

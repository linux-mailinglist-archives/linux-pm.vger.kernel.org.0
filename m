Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA6070C4B3
	for <lists+linux-pm@lfdr.de>; Mon, 22 May 2023 19:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjEVRwn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 May 2023 13:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjEVRwn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2023 13:52:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48A9A107
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2023 10:52:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91C4911FB;
        Mon, 22 May 2023 10:53:26 -0700 (PDT)
Received: from [10.57.23.216] (unknown [10.57.23.216])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6AF13F67D;
        Mon, 22 May 2023 10:52:39 -0700 (PDT)
Message-ID: <097bd237-81f9-0636-2e8c-0ab6785fab45@arm.com>
Date:   Mon, 22 May 2023 18:52:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC2023)
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 5/22/23 18:12, Rafael J. Wysocki wrote:
> Hi Folks,
> 
> I'm going to submit a Power Management and Thermal Control
> micro-conference proposal for LPC2023 along the lines of what happened
> in the previous iterations of it.
> 
> If you have topics that you'd like to be discussed there, please let
> me know by Friday, May 26.
> 
> Please note that LPC MC topics are expected to cover work in progress
> or at the concept stage.  They are not supposed to be about work that
> has been done already.

Sounds good. What would be the time slot for one presentation?

Regards,
Lukasz

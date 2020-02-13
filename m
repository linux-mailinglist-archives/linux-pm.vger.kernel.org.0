Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE8615C14A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 16:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBMPWP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 10:22:15 -0500
Received: from foss.arm.com ([217.140.110.172]:47730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgBMPWO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 663CD328;
        Thu, 13 Feb 2020 07:22:14 -0800 (PST)
Received: from [10.1.195.59] (ifrit.cambridge.arm.com [10.1.195.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FE623F68E;
        Thu, 13 Feb 2020 07:22:12 -0800 (PST)
Subject: Re: [PATCH v3 5/7] cpufreq: add function to get the hardware max
 frequency
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, rjw@rjwysocki.net, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-6-ionela.voinescu@arm.com>
 <b63a4a47-99e5-9c71-73be-740aedde4714@arm.com>
 <20200213125918.GA2397@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <cf821516-e66b-94d4-ee63-5f94602a7cff@arm.com>
Date:   Thu, 13 Feb 2020 15:22:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213125918.GA2397@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/13/20 12:59 PM, Ionela Voinescu wrote:
>> What about intel_pstate / turbo stuff? IIRC one of Giovanni's issues was that
>> turbo freq is not always reported as the max freq. Dunno if we can do
>> anything about it; at the very least maybe document the caveat?
>>
> 
> Okay, I can add details in the description in regards to potential
> reasons to overwrite this function. But basically this is one of the
> reasons for making this a weak function. The best information we can
> generically get for maximum hardware frequency is cpuinfo.max_freq.
> But if platforms have the possibility to obtain this differently from
> either hardware or firmware they can overwrite this.
> 

Right, that would be handled by a different implementation of
that function, so this wasn't too relevant of a comment. Sorry!


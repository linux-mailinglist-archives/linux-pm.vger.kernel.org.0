Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4592F5FCF
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 12:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbhANL1i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 06:27:38 -0500
Received: from foss.arm.com ([217.140.110.172]:48192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbhANL1h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Jan 2021 06:27:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12112ED1;
        Thu, 14 Jan 2021 03:26:52 -0800 (PST)
Received: from [10.57.10.156] (unknown [10.57.10.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C99D13F719;
        Thu, 14 Jan 2021 03:26:50 -0800 (PST)
Subject: Re: [PATCH] thermal: power allocator: Add control for non-power actor
 devices
To:     daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210105190107.30479-1-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <6c2d06e7-8eda-53b0-30e1-10a21fe86f0f@arm.com>
Date:   Thu, 14 Jan 2021 11:26:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210105190107.30479-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Gentle ping.

On 1/5/21 7:01 PM, Lukasz Luba wrote:
> The cooling devices which are used in IPA should provide power mapping
> functions. The callback functions are used for power estimation and state
> setting. When these functions are missing IPA ignores such cooling devices
> and does not limit their performance. It could happen that the platform
> configuration is missing these functions in example when the Energy Model
> was not setup properly (missing DT entry 'dynamic-power-coefficient').
> 
> The patch adds basic control over these devices' performance. It
> manages to throttle them to stay safe and not overheat. It also adds a
> warning during the binding phase, so it can be captured during testing.
> 
> The patch covers also a corner case when all of the cooling devices are
> non-power actors.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   drivers/thermal/gov_power_allocator.c | 71 +++++++++++++++++++++++++--
>   1 file changed, 68 insertions(+), 3 deletions(-)
> 

Could you have a look on the patch and if OK take it into
your tree, please?
If you missed it, I can resend. I'm still going through emails received
around my holidays.

Regards,
Lukasz

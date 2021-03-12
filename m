Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEF73395D1
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 19:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhCLSFz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 13:05:55 -0500
Received: from foss.arm.com ([217.140.110.172]:58980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232233AbhCLSF1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Mar 2021 13:05:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E625ED1;
        Fri, 12 Mar 2021 10:05:27 -0800 (PST)
Received: from [10.57.17.106] (unknown [10.57.17.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F7A43F7D7;
        Fri, 12 Mar 2021 10:05:25 -0800 (PST)
Subject: Re: [PATCH v2 3/5] thermal/drivers/devfreq_cooling: Use device name
 instead of auto-numbering
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
References: <20210312170316.3138-1-daniel.lezcano@linaro.org>
 <20210312170316.3138-3-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <dbc20126-c976-ba5d-2746-91e82fafc454@arm.com>
Date:   Fri, 12 Mar 2021 18:05:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210312170316.3138-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/12/21 5:03 PM, Daniel Lezcano wrote:
> Currently the naming of a cooling device is just a cooling technique
> followed by a number. When there are multiple cooling devices using
> the same technique, it is impossible to clearly identify the related
> device as this one is just a number.
> 
> For instance:
> 
>   thermal-devfreq-0
>   thermal-devfreq-1
>   etc ...
> 
> The 'thermal' prefix is redundant with the subsystem namespace. This
> patch removes the 'thermal' prefix and changes the number by the device
> name. So the naming above becomes:
> 
>   devfreq-5000000.gpu
>   devfreq-1d84000.ufshc
>   etc ...
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> V2:
>   - Removed idr.h header
>   - Used kasprintf instead of fixed buffer length on the stack
>   - Fixed typo in the log
> ---
>   drivers/thermal/devfreq_cooling.c | 25 ++++++++-----------------
>   1 file changed, 8 insertions(+), 17 deletions(-)
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8172F19A663
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 09:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbgDAHjg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 03:39:36 -0400
Received: from foss.arm.com ([217.140.110.172]:44576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731680AbgDAHjg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Apr 2020 03:39:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3F3D31B;
        Wed,  1 Apr 2020 00:39:35 -0700 (PDT)
Received: from [10.37.12.63] (unknown [10.37.12.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92B223F52E;
        Wed,  1 Apr 2020 00:39:34 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: core: Make thermal_zone_set_trips private
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200331165449.30355-1-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <9cc7589f-8e76-62a7-34de-f79522b54622@arm.com>
Date:   Wed, 1 Apr 2020 08:39:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200331165449.30355-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/31/20 5:54 PM, Daniel Lezcano wrote:
> The function thermal_zone_set_trips() is used by the thermal core code
> in order to update the next trip points, there are no other users.
> 
> Move the function definition in the thermal_core.h, remove the
> EXPORT_SYMBOL_GPL and document the function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_core.h    |  3 +++
>   drivers/thermal/thermal_helpers.c | 13 ++++++++++++-
>   include/linux/thermal.h           |  3 ---
>   3 files changed, 15 insertions(+), 4 deletions(-)
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz

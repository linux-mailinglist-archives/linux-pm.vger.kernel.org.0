Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC82E336FE5
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 11:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhCKKX2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 05:23:28 -0500
Received: from foss.arm.com ([217.140.110.172]:60448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232280AbhCKKXO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 11 Mar 2021 05:23:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EE6B1FB;
        Thu, 11 Mar 2021 02:23:14 -0800 (PST)
Received: from [10.57.19.51] (unknown [10.57.19.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 031F63F70D;
        Thu, 11 Mar 2021 02:23:12 -0800 (PST)
Subject: Re: [PATCH v3 2/5] powercap/drivers/dtpm: Create a registering system
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210310110212.26512-1-daniel.lezcano@linaro.org>
 <20210310110212.26512-2-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <bbafd2d8-ea89-5e96-5742-6d1a924e3649@arm.com>
Date:   Thu, 11 Mar 2021 10:23:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210310110212.26512-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/10/21 11:02 AM, Daniel Lezcano wrote:
> A SoC can be differently structured depending on the platform and the
> kernel can not be aware of all the combinations, as well as the
> specific tweaks for a particular board.
> 
> The creation of the hierarchy must be delegated to userspace.
> 
> These changes provide a registering mechanism where the different
> subsystems will initialize their dtpm backends and register with a
> name the dtpm node in a list.
> 
> The next changes will provide an userspace interface to create
> hierachically the different nodes. Those will be created by name and

s/hierachically/hierarchically

> found via the list filled by the different subsystem.
> 
> If a specified name is not found in the list, it is assumed to be a
> virtual node which will have children and the default is to allocate
> such node.
> 
> When the node register in the list, the function will be dtpm_register
> where the previous semantic was to create the node. Thus, the
> functions are renamed to reflect their purpose.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> 
>   V2:
>     - Fixed error code path by dropping lock
> ---
>   drivers/powercap/dtpm.c     | 161 ++++++++++++++++++++++++++++++++++--
>   drivers/powercap/dtpm_cpu.c |   4 +-
>   include/linux/dtpm.h        |  12 ++-
>   3 files changed, 164 insertions(+), 13 deletions(-)
> 

apart from the above, LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

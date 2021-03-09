Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622CF332A16
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 16:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhCIPRt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 10:17:49 -0500
Received: from foss.arm.com ([217.140.110.172]:55184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231829AbhCIPRk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 10:17:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB8B71042;
        Tue,  9 Mar 2021 07:17:39 -0800 (PST)
Received: from [10.57.15.199] (unknown [10.57.15.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 037AC3F71B;
        Tue,  9 Mar 2021 07:17:38 -0800 (PST)
Subject: Re: [PATCH 4/5] powercap/drivers/dtpm: Use container_of instead of a
 private data field
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210301212149.22877-1-daniel.lezcano@linaro.org>
 <20210301212149.22877-4-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <654792e7-f0ca-73b4-2a68-721bcffc8ff0@arm.com>
Date:   Tue, 9 Mar 2021 15:17:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210301212149.22877-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/1/21 9:21 PM, Daniel Lezcano wrote:
> The dtpm framework provides an API to allocate a dtpm node. However
> when a backend dtpm driver needs to allocate a dtpm node it must
> define its own structure and store the pointer of this structure in
> the private field of the dtpm structure.
> 
> It is more elegant to use the container_of macro and add the dtpm
> structure inside the dtpm backend specific structure. The code will be
> able to deal properly with the dtpm structure as a generic entity,
> making all this even more self-encapsulated.
> 
> The dtpm_alloc() function does no longer make sense as the dtpm
> structure will be allocated when allocating the device specific dtpm
> structure. The dtpm_init() is provided instead.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/powercap/dtpm.c     | 27 ++++++++++------------
>   drivers/powercap/dtpm_cpu.c | 46 ++++++++++++++++++-------------------
>   include/linux/dtpm.h        |  3 +--
>   3 files changed, 35 insertions(+), 41 deletions(-)
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

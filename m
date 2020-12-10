Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D25B2D6248
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 17:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391956AbgLJP7T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 10:59:19 -0500
Received: from foss.arm.com ([217.140.110.172]:49748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391175AbgLJP7S (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 10:59:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6882B1FB;
        Thu, 10 Dec 2020 07:58:32 -0800 (PST)
Received: from [10.57.1.60] (unknown [10.57.1.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AE103F68F;
        Thu, 10 Dec 2020 07:58:31 -0800 (PST)
Subject: Re: [PATCH v2 2/4] thermal/core: Precompute the delays from msecs to
 jiffies
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20201207190902.30464-1-daniel.lezcano@linaro.org>
 <20201207190902.30464-2-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <5b440656-3f89-c6fc-652a-6538e82ee71f@arm.com>
Date:   Thu, 10 Dec 2020 15:58:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201207190902.30464-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/7/20 7:09 PM, Daniel Lezcano wrote:
> The delays are stored in ms units and when the polling function is
> called this delay is converted into jiffies at each call.
> 
> Instead of doing the conversion again and again, compute the jiffies
> at init time and use the value directly when setting the polling.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

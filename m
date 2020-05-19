Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF38D1D905D
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 08:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgESGxX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 02:53:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35576 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726841AbgESGxX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 May 2020 02:53:23 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C2B80AAC56C0FBE5A135;
        Tue, 19 May 2020 14:53:18 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 19 May 2020
 14:53:14 +0800
Subject: Re: [PATCH 0/6] cpuidle: Make cpuidle governor switchable to be the
 default behaviour
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
CC:     <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <1589869525-29893-1-git-send-email-guohanjun@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <b01ce164-d41a-0e84-05a7-971fceb51175@huawei.com>
Date:   Tue, 19 May 2020 14:53:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1589869525-29893-1-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020/5/19 14:25, Hanjun Guo wrote:
> This is the formal patch set after the RFC v2 [0].
> 
> For now cpuidle governor can be switched via sysfs only when the
> boot option "cpuidle_sysfs_switch" is passed, but it's useful
> to switch the governor to adapt to different workloads, especially
> after TEO and haltpoll governors were introduced.
> 
> Make cpuidle governor switchable to be the default behaviour by
> removing the sysfs_switch and switch attributes, also update the
> document as well.
> 
> Patch 1/6 and 2/6 are bugfix patch which can be triggered if the
> governor name is 15 characters, it is not a 'real' bug for now as we
> don't have such usecases, so we can merge them together via this
> patchset.
> 
> Patch 3/6 and 4/6 are the functional update to make cpuidle governor
> switchable to be the default behaviour.
> 
> Patch 5/6 and 6/6 are the document update.
> 
> Changes since RFC v2:
>   - Remove sizeof(char) in patch 1/6;
>   - Fix some minor typos;
>   - Adding Review/Test/ACK tags.

Forgot to mention that this patch set is rebased on linux-next
branch of linux-pm.git

Thanks
Hanjun


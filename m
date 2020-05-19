Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6671D8D73
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 04:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgESCET (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 22:04:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbgESCET (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 May 2020 22:04:19 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DF8EA7384591CCB81E45;
        Tue, 19 May 2020 10:04:17 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 19 May 2020
 10:04:13 +0800
Subject: Re: [RFC v2 PATCH 6/6] Documentation: ABI: make current_governer_ro
 as a candidate for removal
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
CC:     <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <1588235987-12300-1-git-send-email-guohanjun@huawei.com>
 <1588235987-12300-7-git-send-email-guohanjun@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <e6bba607-20fe-7c85-e820-d7cbb12a3dd9@huawei.com>
Date:   Tue, 19 May 2020 10:04:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1588235987-12300-7-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020/4/30 16:39, Hanjun Guo wrote:
> Since both current_governor and current_governor_ro co-exist under
> /sys/devices/te system/cpu/cpuidle/  file, and it's duplicate,
> make current_governer_ro as a candidate for removal.
> 
> Signed-off-by: Hanjun Guo<guohanjun@huawei.com>
> ---
>   Documentation/ABI/obsolete/sysfs-cpuidle | 9 +++++++++
>   1 file changed, 9 insertions(+)
>   create mode 100644 Documentation/ABI/obsolete/sysfs-cpuidle
> 
> diff --git a/Documentation/ABI/obsolete/sysfs-cpuidle b/Documentation/ABI/obsolete/sysfs-cpuidle
> new file mode 100644
> index 00000000..f984b9c
> --- /dev/null
> +++ b/Documentation/ABI/obsolete/sysfs-cpuidle
> @@ -0,0 +1,9 @@
> +What:		/sys/devices/system/cpu/cpuidle/current_governor_ro
> +Date:		April, 2020
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +	current_governor_ro shows current using cpuidle governor, but read only.
> +	with the update that cpuidle governor can be changed at runtime in default,
> +	both current_governor and current_governor_ro co-exist under
> +	/sys/devices/te system/cpu/cpuidle/  file, it's duplicate so make

Another typo here, s/te system/system, I will update it, since
it minor, I think Doug's reivew and Daniel's ack are still
valid.

Thanks
Hanjun


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD6A14A783
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 16:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgA0Pud (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 10:50:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728783AbgA0Puc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jan 2020 10:50:32 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 100A224654;
        Mon, 27 Jan 2020 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580140232;
        bh=l4vkYQEbw+215jDrvc2or4bZB2M0545GfZ/8flIQKNY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a6i6J3DQfpWbjblq/Em3af+OsFAjd+ZneObyvGgoWMbrNwRO2+XtK0yloK76URUya
         SAieEMBVLq8w1gi691tkuHunOucS+UZ5fp51X86PXnEi+Op4ogqNerKS7p65tGxn9L
         0RNxnNMPqpujEKkzM7Xxw8bZH5NH7ZOur3To9jHc=
Subject: Re: [PATCH] Correction to manpage of cpupower
To:     latha@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trenn@suse.com, shuah <shuah@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20200123143319.19580-1-latha@linux.vnet.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <6971ef88-7187-94d4-1693-45f6e57040ff@kernel.org>
Date:   Mon, 27 Jan 2020 08:49:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123143319.19580-1-latha@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/23/20 7:33 AM, latha@linux.vnet.ibm.com wrote:
> From: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
> 
> Manpage of cpupower is listing wrong sub-commands in "See Also"
> section. The option for cpupower-idle(1) should actually be
> cpupower-idle-info(1) and cpupower-idle-set(1). This patch corrects
> this anomaly.
> 
> Signed-off-by: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
> ---
>   tools/power/cpupower/man/cpupower.1 | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/power/cpupower/man/cpupower.1 b/tools/power/cpupower/man/cpupower.1
> index baf741d06e82..bdbf089794c7 100644
> --- a/tools/power/cpupower/man/cpupower.1
> +++ b/tools/power/cpupower/man/cpupower.1
> @@ -62,9 +62,9 @@ all cores
>   Print the package name and version number.
>   
>   .SH "SEE ALSO"
> -cpupower-set(1), cpupower-info(1), cpupower-idle(1),
> -cpupower-frequency-set(1), cpupower-frequency-info(1), cpupower-monitor(1),
> -powertop(1)
> +cpupower-set(1), cpupower-info(1), cpupower-idle-info(1),
> +cpupower-idle-set(1), cpupower-frequency-set(1), cpupower-frequency-info(1),
> +cpupower-monitor(1), powertop(1)
>   .PP
>   .SH AUTHORS
>   .nf
> 

Thanks for fixing this. Applied to

git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git cpupower

for 5.6-rc1 or rc2 pull request to pm maintainer Rafael Wysocki

Please remember to run checkpatch before sending patches in the future
I fixed up minor white space errors in this patch before applying it.

Please run get_maintainers as well to get the complete list of
recipients in the future.

thanks,
-- Shuah

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3CBCC0BF6
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 21:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfI0TLA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 15:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfI0TLA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Sep 2019 15:11:00 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A56B8207E0;
        Fri, 27 Sep 2019 19:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569611460;
        bh=Rj+zOWbCgAMU/VeCrq0ZDP+rKJWcVz6Tpq1CDuc72hE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=v7kNqHHqlXj5WbOEyWDLR/STTwDc1DWbefmA3wH7bswfwU1zEd5uwbBrfU9uqERle
         fAWiZNEt0dDVi4RAQlimPiip7PQGP7jzIdrzjjAo7n1gdDviaR9WeYPhLi3k+W93wT
         LQkdcyReLcWYNIw2IZ365jHzt0eSlDCJzcD18apc=
Subject: Re: [PATCH] tools/power/cpupower: Fix initializer override in
 hsw_ext_cstates
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Renninger <trenn@suse.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, shuah <shuah@kernel.org>
References: <20190927162642.2292584-1-natechancellor@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <209b17e8-9800-eec9-f781-8becebeddea9@kernel.org>
Date:   Fri, 27 Sep 2019 13:10:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927162642.2292584-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/27/19 10:26 AM, Nathan Chancellor wrote:
> When building cpupower with clang, the following warning appears:
> 
>   utils/idle_monitor/hsw_ext_idle.c:42:16: warning: initializer overrides
>   prior initialization of this subobject [-Winitializer-overrides]
>                   .desc                   = N_("Processor Package C2"),
>                                                ^~~~~~~~~~~~~~~~~~~~~~
>   ./utils/helpers/helpers.h:25:33: note: expanded from macro 'N_'
>   #define N_(String) gettext_noop(String)
>                                   ^~~~~~
>   ./utils/helpers/helpers.h:23:30: note: expanded from macro
>   'gettext_noop'
>   #define gettext_noop(String) String
>                                ^~~~~~
>   utils/idle_monitor/hsw_ext_idle.c:41:16: note: previous initialization
>   is here
>                   .desc                   = N_("Processor Package C9"),
>                                                ^~~~~~~~~~~~~~~~~~~~~~
>   ./utils/helpers/helpers.h:25:33: note: expanded from macro 'N_'
>   #define N_(String) gettext_noop(String)
>                                   ^~~~~~
>   ./utils/helpers/helpers.h:23:30: note: expanded from macro
>   'gettext_noop'
>   #define gettext_noop(String) String
>                               ^~~~~~
>   1 warning generated.
> 
> This appears to be a copy and paste or merge mistake because the name
> and id fields both have PC9 in them, not PC2. Remove the second
> assignment to fix the warning.
> 
> Fixes: 7ee767b69b68 ("cpupower: Add Haswell family 0x45 specific idle monitor to show PC8,9,10 states")
> Link: https://github.com/ClangBuiltLinux/linux/issues/718
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>   tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
> index 7c7451d3f494..58dbdfd4fa13 100644
> --- a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
> +++ b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
> @@ -39,7 +39,6 @@ static cstate_t hsw_ext_cstates[HSW_EXT_CSTATE_COUNT] = {
>   	{
>   		.name			= "PC9",
>   		.desc			= N_("Processor Package C9"),
> -		.desc			= N_("Processor Package C2"),
>   		.id			= PC9,
>   		.range			= RANGE_PACKAGE,
>   		.get_count_percent	= hsw_ext_get_count_percent,
> 

Looks good to me. I will queue this up for 5.4-rc2 or rc3.

thanks,
-- Shuah

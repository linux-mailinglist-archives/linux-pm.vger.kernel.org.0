Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 593E3AFA0B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2019 12:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfIKKLu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 06:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfIKKLu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Sep 2019 06:11:50 -0400
Received: from [192.168.7.66] (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E27207FC;
        Wed, 11 Sep 2019 10:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568196709;
        bh=gZ6bs0LnQLjGM5VBVpFb9Y9GrE9uVAF7+RmNqjsXlYI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ffS1OydmfU0f9nYgyOKGyEy/cao5T2q2LocmnSscBCKO32tMbtkddqOeFt2bdx6iT
         1CfOMBz97zLKEGzAgD2pt+sZeyS1n6aG2XoK2GwwrOn+0vbzHEy8XQs//NN09oHRV6
         HmzBmjPN8Wrb9+kFAVVWV0mxBioNjn7BgmQgBYxI=
Subject: Re: [PATCH] cpupower : Handle set and info subcommands for powerpc
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trenn@suse.com, shuah <shuah@kernel.org>
References: <20190911095424.49605-1-huntbag@linux.vnet.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <3326dc53-f8a1-dd7b-5ae8-b86ef5ef8b24@kernel.org>
Date:   Wed, 11 Sep 2019 04:11:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911095424.49605-1-huntbag@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/11/19 3:54 AM, Abhishek Goel wrote:
> Cpupower tool has set and info options which are not being used by
> POWER machines. For powerpc, we will return directly for these two
> subcommands. This removes the ambiguous error message while using set
> option in case of power systems.

What is the error message you see? Please include it in the commit log.

> 
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> ---
>   tools/power/cpupower/utils/cpupower-info.c | 5 +++++
>   tools/power/cpupower/utils/cpupower-set.c  | 5 +++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
> index 4c9d342b70ff..674b707a76af 100644
> --- a/tools/power/cpupower/utils/cpupower-info.c
> +++ b/tools/power/cpupower/utils/cpupower-info.c
> @@ -39,6 +39,11 @@ int cmd_info(int argc, char **argv)
>   	} params = {};
>   	int ret = 0;
>   
> +	#ifdef __powerpc__
> +	printf(_("Cannot read info as system does not support performance bias setting\n"));
> +	return 0;
> +	#endif
> +

I am not in favor of bailing out this early with this ifdef switch.
I would rather see this checked somehow(?) when the ambiguous error
happens.

>   	setlocale(LC_ALL, "");
>   	textdomain(PACKAGE);
>   
> diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
> index 3cd95c6cb974..c95b29278780 100644
> --- a/tools/power/cpupower/utils/cpupower-set.c
> +++ b/tools/power/cpupower/utils/cpupower-set.c
> @@ -41,6 +41,11 @@ int cmd_set(int argc, char **argv)
>   	int perf_bias = 0;
>   	int ret = 0;
>   
> +	#ifdef __powerpc__
> +	printf(_("System does not support performance bias setting\n"));
> +	return 0;
> +	#endif
> +

Same here.

>   	setlocale(LC_ALL, "");
>   	textdomain(PACKAGE);
>   
> 

thanks,
-- Shuah

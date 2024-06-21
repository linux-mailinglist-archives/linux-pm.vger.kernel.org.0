Return-Path: <linux-pm+bounces-9767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E539128D6
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 17:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 879C7B26F71
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 15:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191E258ADD;
	Fri, 21 Jun 2024 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dfSdTzfc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6A208A8
	for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2024 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982173; cv=none; b=FMVDeyC2ie2MGCHUhpSRwFdyUCJagaVt2YxoWTXvDbJ5d5x+XvF51vLWXYOE7LxmmNZ5l7IS+lwIBNoz2gU1a49m0OOryBoJmAKI/kzKonYR24j5Z4NlZZzclmx4j5xXqJFhWvSi1ecT4YJ5jvqbzZKCocbDhB8ObbsPTCo8HYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982173; c=relaxed/simple;
	bh=fiMx6wwu690oOQT9nRgHH9YTRFAiNUeCWyOvwt4eb8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5SaNUTagJEHmJZVvoNY/yI9lPTkg22fQePHEDQP1tAYIP+eRowI0vqX3xFRzkrmMKq3zVGj+ir/gHLk+jYoZfitQEjZwat20N0zwd+szKpFMq8k/0250vfrIuy4q4hC0g8oRLcIcYJ0qKAKLwrE2ao7qyDIbhSwOEd1HFYjHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dfSdTzfc; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36dd6cbad62so844875ab.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2024 08:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718982169; x=1719586969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VdGKVZptRgurC360cgfB2zYHtm1AtWvC4+2AMI4Ms4=;
        b=dfSdTzfc800GjjbkChYobMLQvcKyPUmGaUrSQbPwHYdONhItAoXTO5BWFYZ/ZKMO9W
         JrEtc37Paa+42ZVpOgzjjQ4X+XpldBwjnOsuH6STesCV+qeKnZPNIE/JPJ4yx8C+Hrba
         ZmFFJoaIzTc09GD83WxC2LXYOer3rYLVzzwoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718982169; x=1719586969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VdGKVZptRgurC360cgfB2zYHtm1AtWvC4+2AMI4Ms4=;
        b=f8fmsQT9fhN6kf/6gUgPuOBRbRfHO8LzM5dnoLDBPH9Gvjj/sG5uHRpga7isKFfzp4
         LDtB4WqUACJcLcsxxRniC9BmSG5CBLaKN38wWqKvw89AmyP1mavlynAtoB1wHYQOhtOn
         cdcqMxyPVmifR4io6vfO+p7eVZsldj/3g/bsZTtMUH2g6lW25PPtU98fqJN6crydeOGu
         J2yuXWZlEvT08600ClaJVRp5Ixesjj++qw9O3rBoiO9CWF8UygLNjfruWg3qzpev4ClS
         7jXkxvnaL/aH3Ztc5V7UXOzgxNXWVtQDPeLGyc0QxffUTaqglfDs/OLmNDkmgjkk+a8c
         qwVw==
X-Forwarded-Encrypted: i=1; AJvYcCXTd0OuZ+daUs4R2pe5dyMh6WWkP6KrZOi6uDI+0cS/PEpxLnV00O4gFnFy8bZGpCN5Cxv3Y0ny7Jm+RwwjfyTXSEwuROyskUY=
X-Gm-Message-State: AOJu0Yxg4TE1sz8dB+s3S/VIMCkdUpAfDOykyOPbMc43X7dOatrfqxnj
	1TC9vFuKO36XRJ7yH7oRJpsLIRyEp0Q2d8LvD8Hd7oa34E8VgDS4hID7zNY4jfk=
X-Google-Smtp-Source: AGHT+IFztYqDBk66dDZ2hF4/FpkflmaJEY1uhuE6eavvh4EsUEA+b3wfX7Rzs65/V+QX6uyVUv2Ybw==
X-Received: by 2002:a05:6602:1d57:b0:7eb:ea26:3471 with SMTP id ca18e2360f4ac-7f13ee6c867mr851671039f.2.1718982168852;
        Fri, 21 Jun 2024 08:02:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f391ff7650sm37794239f.33.2024.06.21.08.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 08:02:48 -0700 (PDT)
Message-ID: <6d745d8d-33b1-4aed-b9c5-095073bc8cde@linuxfoundation.org>
Date: Fri, 21 Jun 2024 09:02:47 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Make help command available for custom install
 dir
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240621-fix-help-issue-v1-1-7906998d46eb@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240621-fix-help-issue-v1-1-7906998d46eb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/21/24 02:13, Roman Storozhenko wrote:
> When the 'cpupower' utility installed in the custom dir, it fails to
> render appopriate help info for a particular subcommand:

appopriate -> appropriate
Spell check the commit message.

> $ LD_LIBRARY_PATH=lib64/ bin/cpupower help monitor
> with error message like 'No manual entry for cpupower-monitor.1'
> The issue is that under the hood it calls 'exec' function with
> the following args: 'man cpupower-monitor.1'. In turn, 'man' search
> path is defined in '/etc/manpath.config'. Of course it contains only
> standard system man paths.
> Make subcommands man pages available for user using the following rule:
> Render a man page if it is installed in the custom install dir, otherwise
> allow man to search this page by name system-wide as a last resort.
> 

Good find.

> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
>   tools/power/cpupower/utils/cpupower.c | 54 ++++++++++++++++++++++++++++++-----
>   1 file changed, 47 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
> index 9ec973165af1..da4bc6de7494 100644
> --- a/tools/power/cpupower/utils/cpupower.c
> +++ b/tools/power/cpupower/utils/cpupower.c
> @@ -12,6 +12,8 @@
>   #include <unistd.h>
>   #include <errno.h>
>   #include <sched.h>
> +#include <libgen.h>
> +#include <limits.h>
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   #include <sys/utsname.h>
> @@ -21,6 +23,8 @@
>   #include "helpers/bitmask.h"
>   
>   #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
> +#define MAN_REL_PATH "/../man/man1/"
> +#define MAN_SUFFIX ".1"
>   
>   static int cmd_help(int argc, const char **argv);
>   
> @@ -80,14 +84,17 @@ static void print_help(void)
>   
>   static int print_man_page(const char *subpage)
>   {
> -	int len;
> -	char *page;
> +	char *page, *man_path, *exec_dir;
> +	char exec_path[PATH_MAX];
> +	int subpage_len;
>   
> -	len = 10; /* enough for "cpupower-" */
> -	if (subpage != NULL)
> -		len += strlen(subpage);
> +	if (!subpage)
> +		return -EINVAL;
>   
> -	page = malloc(len);
> +	subpage_len = 10; /* enough for "cpupower-" */
> +	subpage_len += strlen(subpage);
> +
> +	page = malloc(subpage_len);
>   	if (!page)
>   		return -ENOMEM;
>   
> @@ -97,7 +104,40 @@ static int print_man_page(const char *subpage)
>   		strcat(page, subpage);
>   	}
>   
> -	execlp("man", "man", page, NULL);
> +	/* Get current process image name full path */
> +	if (readlink("/proc/self/exe", exec_path, PATH_MAX) > 0) {
> +
> +		man_path = malloc(PATH_MAX);
> +		if (!man_path) {
> +			free(page);
> +			return -ENOMEM;
> +		}
> +
> +		exec_dir = strdup(exec_path);
> +		if (!exec_dir) {
> +			free(page);
> +			free(man_path);
> +			return -ENOMEM;
> +		}
> +
> +		*man_path = '\0';
> +		strncat(man_path, dirname(exec_dir), strlen(exec_dir));
> +		strncat(man_path, MAN_REL_PATH, strlen(MAN_REL_PATH));
> +		strncat(man_path, page, strlen(page));
> +		strncat(man_path, MAN_SUFFIX, strlen(MAN_SUFFIX));
> +
> +		free(exec_dir);
> +
> +		/* Check if file exists */
> +		if (access(man_path, F_OK) == -1) {
> +			free(man_path);
> +			man_path = page;
> +		}
> +	} else {
> +		man_path = page;
> +	}
> +
> +	execlp("man", "man", man_path, NULL);

You can simplify all of this by using getenv() to get the environment
variables for the program.

Take a look getenv() usages in the kernel sources for reference.
>   

thanks,
-- Shuah



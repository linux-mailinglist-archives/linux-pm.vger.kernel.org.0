Return-Path: <linux-pm+bounces-9210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A58190920D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 19:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB461F22040
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 17:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B4D19CD0F;
	Fri, 14 Jun 2024 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WqIbMLeO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98817BCC
	for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718387830; cv=none; b=UWEzdvLzS43ZU2/qIiFkjz15QsyFcSCrr2GdKo1MIVoh9aOJYEmhsfjQ0KkS9KhJ2I0ePwKGu//lwUPkOWC41LG7omLjVQGkcbUfZfPFXXrwrozkQ7ptQA8mvaijHj6Puz1mZjaKgBDLygBPxkVlQIIWh3L4Jh/mz/gDTRPufFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718387830; c=relaxed/simple;
	bh=kIlso5lHGmvm66K0GmFxRXFu6AlRnWKn2dqP0Zq1OlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uik2K8jlSCkzo3e5jPdSsglpGprwrpg3HBbQyNWsmS0McWuekmZYxTZEXPtDy4cxvyc677SMDo3ZCiEfQNYxIGN70jeFDsDM3MzOYtJ6eAklwqWRAUWnzwNd6mN+ngjH8ocRTSLs4IUtjwRbbsBeVLzsiOYDSSP8/5K6vTA+lHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WqIbMLeO; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7e8e7306174so8533239f.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718387828; x=1718992628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0xFxAxL3p7rQ/3BamGUAVQZpyAlO5EvKBh8u8KSXhQ=;
        b=WqIbMLeOjy3BHNsZ+MXEdKmszagwvC+xsMlnVvSaaU4U5CkA9XqMJApFx3sHBiaKJQ
         v3J0lXABXyKpBK6cWp7FUe5oWYKHe4MTxMXXke7zH5nHrG+eRkP45wD6ip0vgB4CymMt
         P+UHyVW5pDWlZ8wz8r3qxGfq7tCwkt+gyjwjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718387828; x=1718992628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0xFxAxL3p7rQ/3BamGUAVQZpyAlO5EvKBh8u8KSXhQ=;
        b=KwLkhuk/Ywo7ej99dd7IF2qYnuZUQNcABev+23fGXoNXSmqrH5QVhZOPXd97JHumeW
         RsOavuz6WnLQ91fm4NzlE8IQY/I/O8rZ5mXkrBLFeuF6JlkPl1OR5hbvG0XnyOEXQOED
         E24zKUOklOpsb+ijp+o+qo7Nb4efaxMNFKEBlS7/l+VoetshQLQ58CCI7FwF8blbVWMQ
         FqSsXLBP15fQ5fozQ9TYH1n3rHxGDVHOtSRD+CSjhyRJAbxlr8L1VDSHbsBpRQ7i8jKU
         DNFJvL8Jd9tY+hckcKRXf1faKoIyM2zcdOorUp8w6WNyZU5tq09bU4UJVN43YdBB3N4v
         wdjw==
X-Gm-Message-State: AOJu0YwM6oEg8VUFwwedNGP4sjUPCnI+wsKEc0hyLZMWZMjhK6PX4pJV
	PkGr5pwCIWUTIVq1SQ/Ndrzvlt3DINZKySCbmwpnmd/Di8bJ+Qoi/b6zcTy6CuNxMLmZh22AcpG
	n
X-Google-Smtp-Source: AGHT+IG0W4aVy8mHW8ktlpRyx7ZBKPfaexCWQ85yNAjRql2bgD6ek+BiCHvc1jnE5/URe8BTMD1IKA==
X-Received: by 2002:a05:6602:234b:b0:7eb:98cb:d770 with SMTP id ca18e2360f4ac-7ebeb50ede9mr351748139f.1.1718387828087;
        Fri, 14 Jun 2024 10:57:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b958ee4441sm934548173.59.2024.06.14.10.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 10:57:07 -0700 (PDT)
Message-ID: <b3f78091-1931-4e2c-a2a1-2031b09e566d@linuxfoundation.org>
Date: Fri, 14 Jun 2024 11:57:05 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Add 'help' target to the main Makefile
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240614-make-help-v1-1-513118646b71@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240614-make-help-v1-1-513118646b71@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/24 01:56, Roman Storozhenko wrote:
> Add 'help' target descriding building and cleaning targets
> to the main Makefile
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> Make "cpupower" building process more user friendly by adding 'help'
> target to the main makefile. This target describes various build
> and cleaning options available to the user.

You could include the above in the change log.

> ---
>   tools/power/cpupower/Makefile | 37 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index b53753dee02f..cd0225a312b4 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -332,4 +332,39 @@ uninstall:
>   		rm -f $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo; \
>   	  done;
>   
> -.PHONY: all utils libcpupower update-po create-gmo install-lib install-tools install-man install-gmo install uninstall clean
> +help:
> +	@echo  'Building targets:'
> +	@echo  '  all		  - Default target. Could be omitted. Put build artifacts'
> +	@echo  '                    to "O" cmdline option dir (default: current dir)'
> +	@echo  '  install	  - Install previously built project files from the output'
> +	@echo  '                    dir defined by "O" cmdline option (default: current dir)'
> +	@echo  '                    to the install dir  defined by "DESTDIR" cmdline or'
> +	@echo  '                    Makefile config block option (default: "")'
> +	@echo  '  install-lib	  - Install previously built library binary from the output'
> +	@echo  '                    dir defined by "O" cmdline option (default: current dir)'
> +	@echo  '                    and library headers from "lib/" for userspace to the install'
> +	@echo  '                    dir  defined by "DESTDIR" cmdline (default: "")'
> +	@echo  '  install-tools	  - Install previously built "cpupower" util from the output'
> +	@echo  '                    dir defined by "O" cmdline option (default: current dir) and'
> +	@echo  '                    "cpupower-completion.sh" script from the src dir to the'
> +	@echo  '                    install dir  defined by "DESTDIR" cmdline or Makefile'
> +	@echo  '                    config block option (default: "")'
> +	@echo  '  install-man	  - Install man pages from the "man" src subdir to the'
> +	@echo  '                    install dir  defined by "DESTDIR" cmdline or Makefile'
> +	@echo  '                    config block option (default: "")'
> +	@echo  '  install-gmo	  - Install previously built language files from the output'
> +	@echo  '                    dir defined by "O" cmdline option (default: current dir)'
> +	@echo  '                    to the install dir defined by "DESTDIR" cmdline or Makefile'
> +	@echo  '                    config block option (default: "")'
> +	@echo  '  install-bench	  - Install previously built "cpufreq-bench" util files from the'
> +	@echo  '                    output dir defined by "O" cmdline option (default: current dir)'
> +	@echo  '                    to the install dir  defined by "DESTDIR" cmdline or Makefile'
> +	@echo  '                    config block option (default: "")'
> +	@echo  ''
> +	@echo  'Cleaning targets:'
> +	@echo  '  clean		  - Clean build artifacts from the dir defined by "O" cmdline'
> +	@echo  '                    option (default: current dir)'
> +	@echo  '  uninstall	  - Remove previously installed files from the dir defined by "DESTDIR"'
> +	@echo  '                    cmdline or Makefile config block option (default: "")'
> +
> +.PHONY: all utils libcpupower update-po create-gmo install-lib install-tools install-man install-gmo install uninstall clean help
> 
> ---
> base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
> change-id: 20240613-make-help-14359a943e7b
> 
> Best regards,

Something wrong in your process here. There shouldn't be
addition text at the end of the patch.

Use git-send email to send patches.

thanks,
-- Shuah


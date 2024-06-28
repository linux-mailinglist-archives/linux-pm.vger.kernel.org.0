Return-Path: <linux-pm+bounces-10224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A68C91C77F
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 22:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F78280DD3
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 20:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DC158AB9;
	Fri, 28 Jun 2024 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PLdC4c8V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FFA79B8E
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 20:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719607701; cv=none; b=V7Wri9XQ1DhVrcZgmQr2WA8y0fPJ/mlCZaDIgQfC/vNOrwS0Q7WWRtTSjSQRShyrJd6y6xmWZDBlqsYIPME0sbgeRKqiDlth+ddMIqhVgYGKn5IfXrMHDAaRtUMWrRWK1zz8nW6P+g5Bvb/q4ISJk/Y1HA8jONF++QmKYwGj4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719607701; c=relaxed/simple;
	bh=/SZ/JnYlwLFnsngI10vRLKDskTGPI1uYxgAhl8eFLLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Plbwa9PHaeYOiOnPxtbl18VvzEO6lUJ8+hEWSxvrxY3gs/wqfbqQJUJiRL/PZGfYpR8xcSijXeM1QVXl8esRnRoi+ROE7eJKMoFvYy9e+cZqeeMNl0Fh/VkePmLc4IYWxrs81SH+XuWVVPl7jJ27R7ht9R6OlUcjhrKYAie7hvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PLdC4c8V; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3745eb24ffaso674235ab.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 13:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719607699; x=1720212499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RhRAaIcFckOGbSwBM0gw3fA4UHYAsq+QsUTelxyxGQ=;
        b=PLdC4c8VQg6bWcjZC86vGrDsJnb/Bm4tXvEX35m+bGxIufLWByZZM1Ah41Zcnh+8ec
         9i7ECKKOkQKJclZiBQ5GJof0MXHF3qgY6AEQ1EigEL6oDGxRvW8uBpEOVoca6Fz1QJzu
         EPWm/ZvwxU8Q7qW9v4yEyLuCCfS1xGYQfLXbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719607699; x=1720212499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RhRAaIcFckOGbSwBM0gw3fA4UHYAsq+QsUTelxyxGQ=;
        b=FbLJhyZUGWYM+vH4MFY2Lonl2hc8QBLynsKZo8R7Ovpm0XgDWnyTV1EAo7XxnvRMHy
         b6pFWtVgNCyQV4ZB8e3Q6mdxtZP/rfB37RCeg4Lnu8iQqjtT5XAio6NH+qG7CNPZAX3F
         ie7uJAV2um8y9EDq4oYzE0sHfeXOz+xPKBf0obDE0LnKTM5dMJGshE2PkVpiswZWsZ8z
         XI1AkuckpeAZZAeHxFjRfWsu9HdoC08fhW3ukcrSsJa0AtVDXBMpFwg9y0hiYFFUHNao
         x5OgyyHokWQ4Km/WAhqiT04TaVfCz8N0BpY+rCJH75skzXRmdfoop6CTvLvZWuEK2Kzm
         qzcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe1hqM2eJoVwCOBh7RmGEbDO3dUXVIqiEsJ5y8lx2qLIit72BGuECy0xt5vZV6BlNv3QN6Jto+7lY53Uch/FL4cdGDpcQDepA=
X-Gm-Message-State: AOJu0Yz7iyLwRQZbBHmC5cfAgxjbEPR5vrYccLaFVA+sdO60+evK6LlS
	vFlaPLyQsBe7Fff2jaLH9dPsz9zWPqWtppvwEkxowTxdSaNZCsk2us1EDMExPnYhJeb1svD3UZ9
	x
X-Google-Smtp-Source: AGHT+IEpT2FqyZwzrw4cgsy1Nsyp2Z/9sYFxpXDuMiO3v/g1MjK8gxBVsPt+mwmLQGOJ+AvYGMYPvg==
X-Received: by 2002:a05:6e02:15ca:b0:376:4224:7611 with SMTP id e9e14a558f8ab-376422477a7mr196355695ab.3.1719607699339;
        Fri, 28 Jun 2024 13:48:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad29827d6sm5844565ab.32.2024.06.28.13.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 13:48:19 -0700 (PDT)
Message-ID: <30c9717b-3714-4340-9fb1-9b4a78701daf@linuxfoundation.org>
Date: Fri, 28 Jun 2024 14:48:18 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] cpupower: Add 'help' target to all the makefiles that
 don't have it
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/24 13:19, Roman Storozhenko wrote:
> This patch series adds the 'help' target describing all the user-available
> targets to the makefiles which haven't had that target yet.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> Roman Storozhenko (4):
>        cpupower: Add 'help' target to the 'bench' subproject makefile
>        cpupower: Add 'help' target to the 'debug/kernel' subproject makefile
>        cpupower: Add 'help' target to the 'debug/x86_64' subproject makefile
>        cpupower: Add 'help' target to the 'debug/i386' subproject makefile
> 
>   tools/power/cpupower/bench/Makefile        | 12 ++++++++++++
>   tools/power/cpupower/debug/i386/Makefile   | 12 ++++++++++++
>   tools/power/cpupower/debug/kernel/Makefile | 12 ++++++++++++
>   tools/power/cpupower/debug/x86_64/Makefile | 12 ++++++++++++
>   4 files changed, 48 insertions(+)
> ---
> base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
> change-id: 20240623-make_help_rest-e799889f43a1
> 
> Best regards,

Sorry. I don't see value in adding help messages for common make targets

thanks,
-- Shuah


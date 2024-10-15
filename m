Return-Path: <linux-pm+bounces-15661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6F099F128
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 17:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E055E1C23082
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 15:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A166F1B393B;
	Tue, 15 Oct 2024 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aNcySvls"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE81E1B3931
	for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006093; cv=none; b=jLikBXM6l6x/t+ArNc8yuygDO4iiaGhuLHEbOpnYlddqwZBBL4xy+nAk73K7PjOWL9oYxKE+jvXWnNAqTkhnFOuvel/pz4SnCRD0climydgt0tFkRzysoiDhY9txiGKcBNQY6Ai/D4lkVjwaNb72+0usXqGIKSff2qTrL96085U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006093; c=relaxed/simple;
	bh=bB3qE+QQbPCSz/dxowJ3Xjm9yeWNBK+c8xh0/LagJOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgvbcTPONByIzBCk4mtS6xyxezEfkZrQKq/FdzcapGvhcTGRvlM+rbZaANywhIWL4MT9VDCbRqrC97gud9e9r9qJEqA+gL5eHjyD6NquDmu49z/XJEu4NTO+SWr9WY6bjXNsWnRXhd5FVTpvq/A33CvJxup/ZySiir5bPdrLudE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aNcySvls; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3b7442db5so11126855ab.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729006091; x=1729610891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58XXxzb/f7DbIeyvwpPstj4H2U17649HJlz4R9yjuzE=;
        b=aNcySvls8IhbQxOMII2whEeWhM4wzH0hSzJU3NgMVHLerNGaSZohFjQUne3RLyolae
         dVTWHKUVodLpvI7XlAwi6E7p4WHakNMJuSqee6+euQ+lR9cuPz3C9Z8lLeLhXwI2awtd
         G1cR93lP8mD1gJGNpG12UsD1madIqWSJCyO4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729006091; x=1729610891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58XXxzb/f7DbIeyvwpPstj4H2U17649HJlz4R9yjuzE=;
        b=QbUODe5dv+bfu6SXC6S4uLS5nBUrpttUCNYD7smUBTZVqaH/iCU82BcOb7vnwiNOnF
         JAE+acSLycSShWlmVyxHJIyuNczr+WzHSmhlMjFRQpSGvWq4GFg3UuMD2W9ItdwQ7dbn
         YGS+2nlVplgS2eIbAXNHarOtk/xUmB9wLKm3Xh3E+ZjA0rLmqk/ypCvPMLART0E5RHis
         +0V4cLa9JM6YNov+krohsFe4G1HLCo/DS0PmeVkXqkwx+2ifCM73hqFjimHthagcaFNZ
         tozOvMpTyZUnxZMosTObVG3AeXUVtWoc+VKtdDOAg07wHjMaluCIqc2gICcU1gjJwgGH
         krFg==
X-Gm-Message-State: AOJu0Ywm5YCWdSvnUMqEWOF3m1XABa7iIq7iWj4N5MIzBizOPo7x2ply
	LDQaKMWVrKf6eVedubtweq4uFhO8o0fwagL4xe1qtJtkgojDUFL4wrKBvam5GCE=
X-Google-Smtp-Source: AGHT+IHQBjQgsnWhTd9fKT+tKpp6Bqh73uHrI6TGtjJsWPy9h6VmLdpO8NtF3beR5NRLYF59XiIaXA==
X-Received: by 2002:a92:cd8f:0:b0:3a3:983a:8741 with SMTP id e9e14a558f8ab-3a3dc4b5094mr7680895ab.11.1729006091000;
        Tue, 15 Oct 2024 08:28:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d707486asm3603635ab.16.2024.10.15.08.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 08:28:10 -0700 (PDT)
Message-ID: <49b016d4-a628-49e7-bb9b-3be303517c2a@linuxfoundation.org>
Date: Tue, 15 Oct 2024 09:28:09 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] applyed suggested changes
To: Kieran Moy <kfatyuip@gmail.com>, shuah@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241015150921.78678-1-kfatyuip@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241015150921.78678-1-kfatyuip@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kieran,

On 10/15/24 09:09, Kieran Moy wrote:

Missing change log. I can't take patches with missing change logs.
You are supposed to send v2 with the same short log.

[PATCH v2] cpupower: Add Chinese Simplified translation

Is this the complete patch?

> ---
>   tools/power/cpupower/po/zh_CN.po | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/power/cpupower/po/zh_CN.po b/tools/power/cpupower/po/zh_CN.po
> index 456cde997..33fb3f000 100644
> --- a/tools/power/cpupower/po/zh_CN.po
> +++ b/tools/power/cpupower/po/zh_CN.po
> @@ -19,11 +19,11 @@ msgstr ""
>   
>   #: utils/idle_monitor/nhm_idle.c:36
>   msgid "Processor Core C3"
> -msgstr "处理器核心 C3"
> +msgstr "处理器 Core C3"
>   
>   #: utils/idle_monitor/nhm_idle.c:43
>   msgid "Processor Core C6"
> -msgstr "处理器核心 C6"
> +msgstr "处理器 Core C6"
>   
>   #: utils/idle_monitor/nhm_idle.c:51
>   msgid "Processor Package C3"
> @@ -35,7 +35,7 @@ msgstr "处理器套件 C6"
>   
>   #: utils/idle_monitor/snb_idle.c:33
>   msgid "Processor Core C7"
> -msgstr "处理器核心 C7"
> +msgstr "处理器 Core C7"
>   
>   #: utils/idle_monitor/snb_idle.c:40
>   msgid "Processor Package C2"
> @@ -47,7 +47,7 @@ msgstr "处理器套件 C7"
>   
>   #: utils/idle_monitor/amd_fam14h_idle.c:56
>   msgid "Package in sleep state (PC1 or deeper)"
> -msgstr "处于睡眠状态的包（PC1 或更深）"
> +msgstr "Package in sleep state （PC1 或更深）"
>   
>   #: utils/idle_monitor/amd_fam14h_idle.c:63
>   msgid "Processor Package C1"
> @@ -59,11 +59,11 @@ msgstr "北桥 P1 布尔计数器（返回 0 或 1）"
>   
>   #: utils/idle_monitor/mperf_monitor.c:35
>   msgid "Processor Core not idle"
> -msgstr "处理器核心不空闲"
> +msgstr "处理器 Core不空闲"
>   
>   #: utils/idle_monitor/mperf_monitor.c:42
>   msgid "Processor Core in an idle state"
> -msgstr "处理器核心处于空闲状态"
> +msgstr "处理器 Core处于空闲状态"
>   
>   #: utils/idle_monitor/mperf_monitor.c:50
>   msgid "Average Frequency (including boost) in MHz"

thanks,
-- Shuah


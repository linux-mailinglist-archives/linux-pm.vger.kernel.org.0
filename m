Return-Path: <linux-pm+bounces-15683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A4299F4FC
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 20:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E48B23142
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 18:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C401FC7D7;
	Tue, 15 Oct 2024 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S1uVf4xE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799931F9EA8
	for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016150; cv=none; b=UxaJz0FOb2IsZVLNs1YI2Ds09YnNR1KqxP+G2iJE+e4T/xFENbgqjnw9yGVsQm7UEfP5zWjYHLKvdHczOBrYY2T4OSvFBhujBVf/7B7Lt4JlQImeC1GjwNzfqPwtq0AOh1+waO47vbPTqNP004PlaAN+nYaY0ASPc05m3xNGLCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016150; c=relaxed/simple;
	bh=OV7m/RIwDh9PI9C8iyhJxskFRtV54C0OMBLpxPdpxZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0ZOIXEMe/tpx0CFC4VJbNREMS2mOWriIc3f10q5NJywwIL9Q7LoFkra/xQe6mdpQGUFz5MI65+hx5SV/uhPa9OOz/OD4FJEu5LAd5AqwssN6SuTDrp3Ls61eTmVWOWRwa3xTXve3NUaIa5ckyZZ8se0UVzGbD+/bfmM2ACWZ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S1uVf4xE; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83a94a6032bso4696639f.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 11:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729016146; x=1729620946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYDGK3P91Ny7tPifi6aUq0wsosqxVY/nTMFBHYgb2Kc=;
        b=S1uVf4xE7VdMwo7e1pv8ecjrcrFyNEfltAV8gi5njiB6OBJ5dM/ztHbxTGpRQ6brPK
         RtQwKAtenm/F/ksnPIPK6eQ4kn5CrzgGmGgbHGwseXlc3O9JzxlJ6VrOtKU7jTyiGG1z
         FgXYjQ8wVxcgrVDljuM4pJST5vIn//ZKXdZ9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016146; x=1729620946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYDGK3P91Ny7tPifi6aUq0wsosqxVY/nTMFBHYgb2Kc=;
        b=GGo/HU3DSiXtuuLqlsTdhcFtPeRcOXePys4pL7pIeNM9UZ4GNR5Db14hB9tmdWZ01W
         kF/cj7HLX8NDY5HYZsxj0oGNGaxONh8/wyvhtNlo3QK4puSfRGUTW53pqOVAR4kCqzDa
         F0OowuR4GT7eVttdGfFviEhYkJ0Oc8opTp+Qu7vvB2zMhrunaUxsoxkh+/GOQgvPwdDR
         o+tyJ9O59n+CMbIy7xlVdNCs73P7fUmaXAj5lkm+S+4JZbnD07I1FP3REBDP/LKTcpVA
         XC6DTI/A8Tqd8xi+KeQVbFqNcQqbQRAKuzeypoFvPObog5KfepxtZfXycnvsfquHV3f7
         I6EA==
X-Gm-Message-State: AOJu0YzFUvvSowhGnzRv4cSkoQn7RzotkGq2sFtTYX2lize+T5lX4/C3
	ceYDNiFCch9ORAcweSSyxJVlcWqhii+uoJf3CHidU5Jxryw/Tp4oo8TDskTSVKc=
X-Google-Smtp-Source: AGHT+IHjCRiCOpvYWGxfwHMRcBQPjCK7myqqLAhfpGz6N7ADNIYBFVv/mXoMGCkHL0O7vNzWDD/zbQ==
X-Received: by 2002:a6b:4f06:0:b0:835:4552:6c36 with SMTP id ca18e2360f4ac-83a942d4c15mr107619139f.8.1729016146521;
        Tue, 15 Oct 2024 11:15:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecc4924dsm422077173.153.2024.10.15.11.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 11:15:46 -0700 (PDT)
Message-ID: <4f645873-2ba8-415a-8ee1-c6779a189609@linuxfoundation.org>
Date: Tue, 15 Oct 2024 12:15:45 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: Add Chinese Simplified translation
To: Kieran Moy <kfatyuip@gmail.com>, shuah@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 ccheng@linuxfoundation.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241015163319.9114-1-kfatyuip@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241015163319.9114-1-kfatyuip@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/24 10:33, Kieran Moy wrote:
> Sorry for disturbing, here is patch v2, thanks!

You still need change log. I can fix that when I apply.
But this v2 isn't a complete patch. You have make changes
to the original patch and then generate v2 with all the
changes.

You patch one had all these changes:

tools/power/cpupower/Makefile    |   2 +-
  tools/power/cpupower/po/zh_CN.po | 942 +++++++++++++++++++++++++++++++
  2 files changed, 943 insertions(+), 1 deletion(-)
  create mode 100644 tools/power/cpupower/po/zh_CN.po

This patch doesn't have any of the above changes.
Can you make the changes and send a single complete
patch?

Candice has been helping me with reviews - please cc
ccheng@linuxfoundation.org

> 
> Changes in v2:
>   - appplied sugested changes
> 
> Signed-off-by: Kieran Moy <kfatyuip@gmail.com>
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


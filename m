Return-Path: <linux-pm+bounces-10223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 273A191C77D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 22:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A17284DC0
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 20:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522CD79B84;
	Fri, 28 Jun 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ThNVsoFn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C758758AB9
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719607664; cv=none; b=J5q3J09Dkr7wZ7AGml9xOqdJO+ROlClabCDurmTxsM27OptMrd9CQ5efJ9wAPAlAnkKbMGGa2/rTSwh6n9A8jjt+omZauPcUUA8YvSwxGB5SwfxF9UGrre4Tlh3bltOKzXxLj/5WBy1eNvlm9Ll7HemgdsI9PibEeNIhzjIE1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719607664; c=relaxed/simple;
	bh=NQlio7vdY/v+4Pph9BxET0lpVLYx2s2xwxd4M9X+TgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWT1xU0+8z9TcKI36NSt9I1KLARLVAHFMEq4+PRjNaOeefIHwCSQLXzwsVVXRqxGQtTYXUCz09S52FB6fJQuI9F1r20+F1fTq52+AdUnMffXLRlmknN52nF7CmoSjYnwDbJRanZoW9WcvKZROqSIrQyq72KeylTFcQ9cNMG3/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ThNVsoFn; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3748ec0cae2so769325ab.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719607662; x=1720212462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVbzw5/lfJr1zoZUcLthvORO3HlmTqGHkbTzKCG2AtE=;
        b=ThNVsoFnRZ7JHUhYG5Yp/g3Af70N3X9oSS0syyTjIJ2wQDQsm1grMS2pvI82Lg0t19
         RSYiKiRxm77o89MLZ7a291CuavEtaGa8S2uc9ROaQBYKEoIDdF7nthrfwWhGm3gO2J1t
         dpNhewkEQmvygR5sbD+PNn9gfe52qKXD7lvsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719607662; x=1720212462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVbzw5/lfJr1zoZUcLthvORO3HlmTqGHkbTzKCG2AtE=;
        b=KvnRY28NpiiR7BPZoBQv0RKC03pV37suecugWL5ZqigduDwq+vLF9Csl5Y2kxmhdcb
         GQx7op0SdTuHiWIZgH5J2T3u01GOxzbPyR2oScRmRa43J8Wu3wbBcFQzy/yw3RVZKrbI
         1uqLL+T65q53Lfo9q4A/xgXf+KyVF3FBvHZdzOgQ22xATTUgMngTHPMT5cI4c2bl3T7z
         oZ17K0ITyxqZy+9zMY7XecahcUx+k8jVCMfHOEwKLF5zdEYUXMWaCr1vQFJ8Tmkz/PHy
         TE5pX28FpUz2zuKcvMH17bRTsaubPfduZNWju/KNJa3Ao2GYUdeBvCCG8N6DwpsegDg7
         NsSg==
X-Forwarded-Encrypted: i=1; AJvYcCXHirQ+h0Vh3rWxGtSRtPz0zkqDwrU8uHuIuxZPQHtSXRs0duMUUuNCPHlF3T8AMErkqZ/Je+AgodOlO3G1nqC7rwUoMRfseW4=
X-Gm-Message-State: AOJu0Yxs2x1SY+4sH/3amoFwl4RfodyFCmRddq4TkGQPf9EcdkXxKcQa
	bi/ZBCUf4kq6tFsBwyS1+WcMqWVtyGI4mOP/OIURpEkKdGnZ14UtiqWjpClhf+I=
X-Google-Smtp-Source: AGHT+IE4ELhZPGkhF2SpPfk2FPsx6NXVVUYlTOMjU7DLZNr/ofq6BA+1WUSb3ogxRZDrJIEMYmNz0w==
X-Received: by 2002:a05:6602:25d7:b0:7eb:66a5:d1c with SMTP id ca18e2360f4ac-7f39c44f029mr1784506539f.0.1719607661845;
        Fri, 28 Jun 2024 13:47:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73f90ed8sm699183173.99.2024.06.28.13.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 13:47:41 -0700 (PDT)
Message-ID: <c24d7ae3-8f4b-4573-9c44-9c2f53585613@linuxfoundation.org>
Date: Fri, 28 Jun 2024 14:47:40 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cpupower: Add 'help' target to the 'debug/i386'
 subproject makefile
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
 <20240623-make_help_rest-v1-4-4bd3fd51064b@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240623-make_help_rest-v1-4-4bd3fd51064b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/24 13:19, Roman Storozhenko wrote:
> Add 'help' target, describing all user-available targets, to the
> 'debug/i386' subproject makefile.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
>   tools/power/cpupower/debug/i386/Makefile | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tools/power/cpupower/debug/i386/Makefile b/tools/power/cpupower/debug/i386/Makefile
> index b3f771039b17..361265170986 100644
> --- a/tools/power/cpupower/debug/i386/Makefile
> +++ b/tools/power/cpupower/debug/i386/Makefile
> @@ -39,4 +39,16 @@ install:
>   	$(INSTALL) $(OUTPUT)dump_psb $(DESTDIR)${bindir}
>   	$(INSTALL) $(OUTPUT)intel_gsic $(DESTDIR)${bindir}
>   
> +help:
> +	@echo  'Build targets:'
> +	@echo  '  all		  - Default target. Could be omitted. Put build artifacts'
> +	@echo  '                    to "O" cmdline option dir (default: current dir)'
> +	@echo  '  install	  - Install previously built project files from the output'
> +	@echo  '                    dir defined by "O" cmdline option (default: current dir)'
> +	@echo  '                    to the install dir  defined by "DESTDIR" cmdline'
> +	@echo  ''
> +	@echo  'Clean targets:'
> +	@echo  '  clean		  - Clean build artifacts from the dir defined by "O" cmdline'
> +	@echo  '                    option (default: current dir)'
> +
>   .PHONY: all default clean install
> 

I don't see a value in adding this - these are common targets and
nothing new about them.

thanks,
-- Shuah


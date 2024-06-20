Return-Path: <linux-pm+bounces-9685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B93E9109F2
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 17:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F811C20FBC
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316B61AF6B4;
	Thu, 20 Jun 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MkgwPz8g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D781AF697
	for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897765; cv=none; b=l5F+119OWIR6ZQUpK5hmXNZ2+GjYeRLxsJUOSPxF5+fMki/EMsvetTFzV9uZFFVdJxgtJ6avIgMrNhfUI2BNvOdYqmDYvkCXFKko8Zqn0oq0PM8S8EymcSMsgp+LJnSfGFNrmR9zwti17/3HtpdDZkWOp8xM1TP/6uxXWB2XSG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897765; c=relaxed/simple;
	bh=Jsw9X1mHuaFL5XYgTd4SOQKZZ10HagZI1CBz7jCDX2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpF99pLFhjkZy9wf0R8sDQqGroDOvsLchQn2AkC5pi9QYmsGGwQn3zo2Jz6i+aB6o/JjCFwBtsjz1YxIl12Pk12l2YdedPQryD+mbnxvJU2mjtGYiCuJfp3pyJ//odD2vkgPOGnfGzQeVJGTfxxFziCkJ3zmvTuBQPIr4iiXhNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MkgwPz8g; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-375deacb3e1so429525ab.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718897761; x=1719502561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6W4tJANgLoO4iUCI9w+RyNcvDtbjH3tRJtS/qipMcM=;
        b=MkgwPz8gJTeLdxXXadrp1ZEnfVAOpLCa5nqiAN+g9VZ5pAuTqeDloP6BdhxweLN63s
         sdHg6zk7GG/te9CCtvKA1m2nefOlo5IfUz6N9p2q2fwEv7MOK1xnJceUuSvqhnClsnpE
         Vci9RaKAcZ6jg00gZddGxSJrxlzog9BPDYVbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718897761; x=1719502561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6W4tJANgLoO4iUCI9w+RyNcvDtbjH3tRJtS/qipMcM=;
        b=G9HL/F1VpYUQImKAHZOXtGEdQdTIGSrW5PCd6Gol41s7IyK2WZrLFBrIZa08SS3YXn
         jACpmW4FmVTvitRiQU2P0MBUzL32df/x/cwkj9He5llk90QeCQgHHw3QUYXj2z6dMjqy
         0B1ViQUwi/JzmwaU+BwI1NvL+7xnm9rBj74BhbM+pl3OGT0ikofdaygM+mV9PFR7BRLS
         yKkhZS1bDrtFyO8CleTrmsnh1J4WyCzvxWeYY43d4MlWPnpnEU6QJ2tddYKUoF/XQjsY
         SstUGuQjuBIzvpsfL08RG0XmPacwoeZzVPDquO78UegSph1uFu22h3PrQrX7owvCJ+fv
         6sOA==
X-Forwarded-Encrypted: i=1; AJvYcCVehTGYeF5EhTVu+6p1+9WRG6iWDnMgLZFjYgNzpROKt2nNzEliU0dn0LKRE1IDyUXetYvfLKs9RZpMnhnw9J3G0jsBg5tpWbU=
X-Gm-Message-State: AOJu0YxfKAphcxVlGMMY06GIEnLMH4U59AE9xgdHOthN+bmBsJh8YNms
	L/ajTTgsz1aL0OCMFcJ/7O0QCEDZka24e2LJbnvDWsjOuha3dt8U00r75hpQ068=
X-Google-Smtp-Source: AGHT+IE62fY5IaJWHSKcQBB3+r71W1tXrEigfYnuO0ExhF/a0NGR86ugEoobZwFQM7KAWijR2k3MtQ==
X-Received: by 2002:a05:6602:19c7:b0:7eb:6a6e:c830 with SMTP id ca18e2360f4ac-7f13ee8ac50mr617369139f.2.1718897761047;
        Thu, 20 Jun 2024 08:36:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9568de15esm4521709173.21.2024.06.20.08.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 08:36:00 -0700 (PDT)
Message-ID: <65598c9b-984a-4bbd-98dc-fb15792ce1cf@linuxfoundation.org>
Date: Thu, 20 Jun 2024 09:36:00 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Change the var type of the 'monitor' subcommand
 display mode
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240619-change-mode-type-v1-1-31e7e45028f0@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240619-change-mode-type-v1-1-31e7e45028f0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/24 01:54, Roman Storozhenko wrote:
> There is a type 'enum operation_mode_e' contains the display modes of
> the 'monitor' subcommand. This type isn't used though, instead the
> variable 'mode' is of a simple 'int' type.
> Change 'mode' variable type from 'int' to 'enum operation_mode_e' in
> order to improve compiler type checking.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> Built and tested this with different monitor cmdline params. Everything
> works as expected, that is nothing changed and no regressions
> encountered.

This above belongs in the change log. There is no need to add
throw away things for patches in general unless there is a reason
to such as v1 to v2 changes.

> ---
>   tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> index 075e766ff1f3..f746099b5dac 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> @@ -35,7 +35,7 @@ static unsigned int avail_monitors;
>   static char *progname;
>   
>   enum operation_mode_e { list = 1, show, show_all };
> -static int mode;
> +static enum operation_mode_e mode;
>   static int interval = 1;
>   static char *show_monitors_param;
>   static struct cpupower_topology cpu_top;
> 
> ---
> base-commit: 0c52056d9f77508cb6d4d68d3fc91c6c08ec71af
> change-id: 20240619-change-mode-type-e8de8430ccca
> 
> Best regards,

thanks,
-- Shuah




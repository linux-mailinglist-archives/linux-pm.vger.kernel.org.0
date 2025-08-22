Return-Path: <linux-pm+bounces-32870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8460EB30DE4
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1422F602439
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 05:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3219128AAEE;
	Fri, 22 Aug 2025 05:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCg8obaA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717BA28505F;
	Fri, 22 Aug 2025 05:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755839872; cv=none; b=XQtx6z717GMCAbcCJr7/Hl7PvuGXtvgbB6SRQlA5U4OrsQ5WoGUAuBRh8uVac8KVcSRilxCTvQy2zFLDgUHRNCA3oZ95w6/9VHKQSxfqdPcXBC2muyI0jEDbnGgoD4aFOwe28pQYe90bQ4oGbY7t1KKaMsArp+8WVJRvub1bgtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755839872; c=relaxed/simple;
	bh=AB60qIhIhcIch7DTjDb61PjbSqMJsqIbyQYnTPNHunI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQtYAEZQ759mn1JswcNbOeh3XBcbEXdcKv8h/0Ty8JJn+FLHQfynl5LHR32bM9YiTj7Y6yB/8nuBqhmD23tSBgOqwKie3ymb5AR2zZBzaiogU8D4OUGJbVaWHVNauDs8nFx74rZMvsZc/Ylejvjf4nTQxVE6zbJ4JLYzq39Kg+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCg8obaA; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55ce4b9c904so1969773e87.0;
        Thu, 21 Aug 2025 22:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755839868; x=1756444668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iSaBW0x71qieK9bpCWJ9scXNoxXVJRabKHQeklCtRJ4=;
        b=KCg8obaA7dj/KjIln0c0xIER9pdWEkxdRcBecGGKsVAkaklIIU/8Bi3Eo3gDpDI2mE
         sJa6lPCPqbGXk/2UfEb8gyk1jHyIqO6mjvMRi1A3Y1GdOLeewmZ2NeSt7HOYbs1Nx3ME
         GxaArEyszgsenxBjjEwRYeT9d4fAaZeqhPnmGOYsSW9vS7ofohy9FXKVPh1hdDPjScr9
         pDkoIWlSnk4klGuIZrB/UwW/XGggBRcSDpoCJU0Cf1boNDOu/8mRge+TFhjxhamY4Dy0
         wbRdYO1E7XJ7CR2swZega/73YMeienYaMgp41IlPrl8GY97CRA3n808abA/9Pz5IoYeW
         CbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755839868; x=1756444668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSaBW0x71qieK9bpCWJ9scXNoxXVJRabKHQeklCtRJ4=;
        b=lfX7CA3wOopVRrE60E5brIaSZhCH5zW1cqS/XsqMYajTUK04tve93932BPyaZkxgLx
         kLJlenOcw3uP0L/LKhGm4umPqGOFm4IfnU2j43VosmcN5T8XUCIwVqrFkwau1Zb/UG+N
         0LYWHehE+jsyX3WYJ1Ru2PKinB614vISmRgB/cPMPmLN2EMM+JBPtN1zix24myKk8aih
         m+TBmVa46uwXKQ9DX1RcKBxgRn64/S3GBAeb/t+uwS6kV30cgusqqiZ5jnjcHeCo4+ja
         E7K8jbCnhnU62cPRKiMlaMAYsCPI7ZHYLGB4+q9GI20kHoanjgPlnu76a1wZmAEzwN0d
         mEVw==
X-Forwarded-Encrypted: i=1; AJvYcCW64sQ8UB38Bv0o3U51//oYiB1DQK91YJgJFU7spsMilc4Q5hyWDxKzZXPUHL793pPYhwyrzMB6Dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDRalStN/7ddYFVuoprtGoqjk7hsNLDfsMwuwAQQgqrp3ZDHq/
	+zeChy2EbV+EW6Tvhsw82TW6g8pA8IXHWbgqmyvxJ3OsuFpctsM4yivh
X-Gm-Gg: ASbGncvQHIcjcKHCtdNMOLkTeisDiaBOCu8BaZVugFlYmGT/Lcs6RtU9pAlLgD4RS2/
	QgvN+n5qRi6PluY9/dBf9Ajqpm3l9tVi7sf1AHhXncjdcT/1hB+AWxesahR+nVDFp4/fXo4cvy2
	l6KRQQvH5JhE8n7GOY0eNDgY3ao7P2U0JeWUilnErpDTKcLmFVryumbfb9BpnEcnTDxBTbFgLiX
	t96vxSElvoedzaxZjG9b8ghURLEULEAjakN4kWWbVKw0vmMqEE5mrRmhMONAiKDvXLD+h2eLcur
	IaG1h8qff/ljLiPKyCzHgWjAuppOpDhYw6eVihXko47Acsiap7123+5HK+vqoCACdOxLKJ4fukz
	JtXfjeL8yL+hzPu4Z8O/pChbbsuCN4qXvQaYBcatvkBOkGdQj+EJ3KWTGH1/F5fvJ7v5sxVG2Lh
	vnFl0=
X-Google-Smtp-Source: AGHT+IG8RWq1klFTMuD28Avdtf+hTkHAWutzP/vryHUsjUB+d7h2rG/l8/gP/xUbz5TgiMZrKZSm4g==
X-Received: by 2002:a05:6512:1087:b0:553:2884:5fb3 with SMTP id 2adb3069b0e04-55e0da1b488mr1683506e87.12.1755839868274;
        Thu, 21 Aug 2025 22:17:48 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef426b59sm3303088e87.142.2025.08.21.22.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 22:17:47 -0700 (PDT)
Message-ID: <9756dc55-ec54-4c96-b72a-6b9c0501d7e6@gmail.com>
Date: Fri, 22 Aug 2025 08:17:46 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Add entry for BD71828 charger
To: Andreas Kemnade <andreas@kemnade.info>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20250821-bd71828-charger-v3-0-cc74ac4e0fb9@kemnade.info>
 <20250821-bd71828-charger-v3-3-cc74ac4e0fb9@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250821-bd71828-charger-v3-3-cc74ac4e0fb9@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/08/2025 21:23, Andreas Kemnade wrote:
> Add an entry for BD71828 charger driver.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa45..044eb41ba4797 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21848,6 +21848,12 @@ L:	linux-serial@vger.kernel.org
>   S:	Odd Fixes
>   F:	drivers/tty/serial/rp2.*
>   
> +ROHM BD71828 CHARGER
> +M:	Andreas Kemnade <andreas@kemnade.info>
> +M:	Matti Vaittinen <mazziesaccount@gmail.com>
> +S:	Maintained
> +F:	drivers/power/supply/bd71828-charger.c
> +
>   ROHM BD79703 DAC
>   M:	Matti Vaittinen <mazziesaccount@gmail.com>
>   S:	Supported
> 



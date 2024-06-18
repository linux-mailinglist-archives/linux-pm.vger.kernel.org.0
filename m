Return-Path: <linux-pm+bounces-9496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5911F90DB71
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 20:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F07283400
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 18:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0131A15E5C3;
	Tue, 18 Jun 2024 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ev9iG9tE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E52515DBC0
	for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734609; cv=none; b=OGSt1jCuH7YfdG+fKXEWOJusJXjIu6KiH0cu3ahQt9GVhfO3p4QPiS8bP8Iif5ZDL6O1KY7CBfUbjCesZ4bOGgl2G17widw4XiHJOxaWXJdBiX/OfDjIR5ASBiR3yG1c0N1Mp6H0smcpg6/76cwmK/cyIDlKkUDPkatdjcTZoYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734609; c=relaxed/simple;
	bh=LYbsLyMxhPyCUqjFs5SDnPiSuKULFc5fhPt8hJLQxzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K35zUnpSX80G+e+bwbNMRhVBHr1QnBwAnMyDHb+hOus1I6n+vSXJjWHvhKGk3H5liRH0SjAc1SHXoYShn17sjtgopn+apbQzq4Q7J4Ab0eWvfjKZU6WgvaWM5aj4HOLVpOQwXNIbI+erGR6K9h7GeKvy7Ap/coHglY9S/VXXKhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ev9iG9tE; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7ebebdec6c0so19968239f.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 11:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718734607; x=1719339407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwxr8N672PvC1chOiaIusBRHecicNeuV94DwrBoa4Is=;
        b=Ev9iG9tECJo2a9mqrbr75339GZ/euMIPfhLq4J24HRKS86Sxewjf8siZ8NrVngKgDa
         0/KPYwYvZD7TEgPNoGD6taqckLE2l+Zh/BH7tydGf75GUMmyzvaB6x7cO5E0DePhfxRj
         +hGmlReg5+/OsmbRFL4QHVXOBgIhkrbyGRZNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718734607; x=1719339407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwxr8N672PvC1chOiaIusBRHecicNeuV94DwrBoa4Is=;
        b=DL1dBIEMERyHIGgzCldHVhvPuQfoejU/l+5ZaRWbL/nifa1MgjB2qIRpa8Oj8ZybsI
         G3PALi//K6wnGbW1nQ+zCOExFBqJIpCebW4odb/mj/SBsCR4/CgRtvOxXMYzs9MwCqjl
         ahYXRztg5lnvSh/LDiUvHeCV9isMJ3TYnMvq454tWnHPlTSlikK/lGFFro9hQ+zOGmT6
         peIT03VrD77GoxPiAiNSFsqWBFlCz73zH0AsU+veDeewiS3i3ozuoYvHQm2lzSX6fZO0
         oi6j2l09e08aze9SkzDC3TmC11iOKEMQ4eqoSZI/HHMEpOo1nRYy2Uov80Ydg/KSb3QY
         Rszg==
X-Forwarded-Encrypted: i=1; AJvYcCVTRYo4RfymoW4b+GJMq7BxJO5me5kvpJHFhUJHUdG0+yvDe56ZlxEeAJK5mEYBgxrdYens0HTflckS5K5qF5v5zywoCDtgjwY=
X-Gm-Message-State: AOJu0YxNPxMXEuOVGe5d0ioArwmpUXIBWUdu1lHwGQ4WOnhWNKjPEGnW
	qwSKdiHnIlGHRHBKQtdnkDHoxA4vFOWoTc+VSmAErvvzM5/jKUm5TdiI3TnH7W8=
X-Google-Smtp-Source: AGHT+IFO2IQLysVTMfRTsculCCW5EQvbPVk0HKMGLn3N6uK2FWeLmCvMVYQe+UxwTtNaaRZTGSI2nQ==
X-Received: by 2002:a05:6602:54:b0:7eb:66a5:d1c with SMTP id ca18e2360f4ac-7f13ebd412bmr69520939f.0.1718734607495;
        Tue, 18 Jun 2024 11:16:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ebdba17b7asm282608739f.4.2024.06.18.11.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 11:16:47 -0700 (PDT)
Message-ID: <f5b9aace-c71e-4f65-af9a-7034a0afe2fa@linuxfoundation.org>
Date: Tue, 18 Jun 2024 12:16:46 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Replace a dead reference link with working ones
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240617-fix-man-ref-v1-1-81c218212e60@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240617-fix-man-ref-v1-1-81c218212e60@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/24 12:05, Roman Storozhenko wrote:
> Replace a dead reference link to a turbo boost technology description with
> a reference to a root page of the technology on the Intel site, and add
> another one, describing power management technology, which includes short
> description of the turbo boost.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> During my review of 'cpupower' documentation I decided to read about
> the Intel's Turbo Boost Technology and found that the reference link is
> dead. I couldn't find this article on the Intel's site. After careful
> reviewing of available articles and manuals I decided to replace this
> link with two others that could substitute the disappeared one.
> ---
>   tools/power/cpupower/man/cpupower-monitor.1 | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 

Applied for Linux 6.11-rc1
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah


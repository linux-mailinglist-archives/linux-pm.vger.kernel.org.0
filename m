Return-Path: <linux-pm+bounces-19767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DE69FCC8B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 18:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76DA11602A1
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74696142E77;
	Thu, 26 Dec 2024 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Au/+jhPe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B813B780
	for <linux-pm@vger.kernel.org>; Thu, 26 Dec 2024 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735235793; cv=none; b=YfW2oDTGN1Tm+Adav9K9fpIma4Agxj0zVRRuaWLPyHO4DXpur8CdT1op0ZAeE51xfUkAsf6e0RooM3vdiBqVcyJJQBEuUk6VJEBtRaw0waq5OVsv+VH+OFBb6hyxkHIqTdbAV5X2yC6Luuvu/znVYC7G07hJtS9E8GjSfjRZbSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735235793; c=relaxed/simple;
	bh=M2PH08CsesUP6tXYAmNF9noNelaV+3uiedlZxgtQpYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgaB9E/MHUKsRXgaLNMGd/kaksfynmPqsipYl60HzHx/oBMdjGw6x17mA0u8Rt+AScZKQmMQpcs2N8ni896xfDZugVWgdPT9DAA8CqRsLFbzR7EvEajGwj4StZOIpFx7+9qygixzs3PZHQVSLVCnQ7sR3MwAyMCseAGkdjg96hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Au/+jhPe; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a9caa3726fso22964425ab.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Dec 2024 09:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1735235791; x=1735840591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEAYaQoQFtrQwUZktkiFbLCglG9SJB+JzX3zNkxnsWQ=;
        b=Au/+jhPeaI0iuFDuuVmc64h+VcT/tOHpPThxHHFTCo8pL6f3p6h0Q2syW+S8woDlHY
         p54NRC/QpU7cPUrn0k58UgEJ+pB4cbBXRqJbSs2obcM13HjxyZj65hoLvHfHL5KwOxrx
         uvIK/IEshoEfmVG/Wb7m+jWoAIo6wSAJhysbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735235791; x=1735840591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEAYaQoQFtrQwUZktkiFbLCglG9SJB+JzX3zNkxnsWQ=;
        b=hOW/YRbpRHP1NuP8AtPZqISJOaOWZXj8zxtPmf6Y2FPr0bTmunLTdf6FjaHl8UZoAF
         T6RoF1z3A99nlhjmubZ3YjYmlIx7NstQyb05LY6FZ/zMrXawMd/UDMsMPa4gTgl5vUpy
         tzr1LKNiR+7mo31yKzNZcpELC0g+/pWsA/XMO84RQ8WKgU77KlA6cX1bAz3UJFgsLe/x
         yM3wxQ9owPIvePOe2cDq9Y+iqZ2z0MJYyPcDC6NbZAjHSOn8lteV2eSlTtho2A50hK9v
         TdZ6Wo8AvijdRhlDgo7m5WgHjR6ZDlnNPFLFLDNn82PFJs1z1GyvXlFFgBD871z8x09f
         B2/w==
X-Gm-Message-State: AOJu0YyuVuODWh2cdko6yyPrZ3m8evPXk0Pc8np/tzQNpZlsDK/NyJmx
	NvBDe8tlKrJRNpoCCQ8j9BHoHFJ3EwxVtzvaXfIUzkYvGzZBOXM0dW6+K/7XOPM=
X-Gm-Gg: ASbGnctUfIvn1C1cfnGRbSdqOsYKE5F8ZIoiQZGXuKGrDliK7ghXoMYD2H6SFYN880u
	JFf5yCg004ip4G3teREwQCcoSapzVBUbbwMpFoNCgf+JUztpac8vmy0IdPz4GFQEqEOHAy8Gfq/
	YKGseqMSr76hI4D/t5fRgzztf10aH+kWIXGmHoWaecr+bXObo4OTj1enKRURLLBHGhzLO8XP5JK
	NNh0ZZfmSa4gu2ylD46ZxOj7qm+AaFJIh/2gjMhySaag1Adxy+dV3yjc6EVWeOEMNOB
X-Google-Smtp-Source: AGHT+IGQcyerPq2LPJWEn0ElherSriFY4zOl7KaXNRRiSCMlcKWgWPm1id5YQJfoljn9U38+5DtC1A==
X-Received: by 2002:a05:6e02:3c86:b0:3a9:d32c:d312 with SMTP id e9e14a558f8ab-3c02f9e9555mr252943675ab.9.1735235790765;
        Thu, 26 Dec 2024 09:56:30 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf508acsm3597029173.30.2024.12.26.09.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 09:56:30 -0800 (PST)
Message-ID: <4fe9560f-2e0c-42eb-a67e-4d1c5382bae1@linuxfoundation.org>
Date: Thu, 26 Dec 2024 10:56:29 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: Add header changes for cpufreq.h to SWIG
 bindings
To: "John B. Wyatt IV" <jwyatt@redhat.com>, Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
 "John B. Wyatt IV" <sageofredondo@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241224062329.39606-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241224062329.39606-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/23/24 23:23, John B. Wyatt IV wrote:
> "cpupower: Add support for showing energy performance preference" added
> two new functions to cpufreq.h. This patch adds them to the bindings.
> 
> Link: https://lore.kernel.org/linux-pm/8dc731c3-6586-4265-ae6a-d93ed219a963@linuxfoundation.org/T/#t
> 
> Tested by compiling both libcpupower and the headers; running the test
> script that does not use the functions as a basic sanity test.
> 
> Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
> Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
> ---

Thank for the patch. Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/?h=cpupower

This patch will be included in the 6.14-rc1 pull request to Rafael.

thanks,
-- Shuah


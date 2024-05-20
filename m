Return-Path: <linux-pm+bounces-7994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487408C9DFC
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 15:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04661283E07
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCADB7E767;
	Mon, 20 May 2024 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pchLScKF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAFA53E07
	for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716211089; cv=none; b=Ty3mTkGnuwltrSOAf8FzdPc4Q0EL+eZ3jFEdqYHP++zW/6y4u64Af3byRkZCS+LCCJ6gwXPBjaX8Zd4FcS82xtw2Of4sS8uIKc0gLy77oJY/De1cKiSyByvQxPH80TFf3GycMKVqdlCEt4t5aNE3srhfJi+5c56H2nyirfV/PeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716211089; c=relaxed/simple;
	bh=2hALWE8fnBqoM58T1YdEXuHjivXfafCW3bI9ZwC9+E8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlfzigrfXq2/cplo4Qizm368Ob6/49v6OATfAkDyTy4VgCo1KgSsIuBdzjbPxFLg3xN8hvQmQYicEf/wmQhmsD6eWFFmynyZ4lRNdW6Fa9sfa3F7C3qnD83sC3LsZaSyVISPuJOAE17jy/6scRLga0FaO5uQu3FZ7GhWNjIAvnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pchLScKF; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e3e18c24c1so46205531fa.1
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 06:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716211085; x=1716815885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2hALWE8fnBqoM58T1YdEXuHjivXfafCW3bI9ZwC9+E8=;
        b=pchLScKFPMSYD1igrT0unQyxomTHu7+K0MJvcY66II8kL+TpfIlwBtyUvbyZaK2EIQ
         vakKL0YSsWbFSrwVgHENnRPkWdKAAl5Pnb93O1Ts1fUZpN+aXHJ2CMeL4JsCUpxNIDtj
         NTw86IqJhZAty3ikPMRPp8gCQK20YN8+Edg4oDS73W88mk2cqDhP/U5kIJcHRv9PzSTH
         CFGpW8WQT3WuEN0ZPR127PlPMDNLDCRLCUL+2R8zQFv44oiASZct6k4jFSWaF9EnyFia
         HndoB4ioDCUkRrQ65A8y8pRuGF9zZ1crEjdqyXhBr9YPzE8qa6Cwop+m9YbacQgJkPof
         kZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716211085; x=1716815885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hALWE8fnBqoM58T1YdEXuHjivXfafCW3bI9ZwC9+E8=;
        b=gq+HGHJeYI4NVL7escXGpoOYv//MjY6qjgZ92gr2AasEHtar1S3QenMmhirXvEb8rk
         YZl91xU1ryS6u1AlZWNZBJ5E/QxI0j3OsTc2DX8GuC968a2vkzCKYKkJ09gdb/Lq4t7Z
         EWeaxjmLUJ4M7Bo8KXjOtowpB+md+C54zTTN4rb9fOWB9Ub9GyWKAG04q8u/SDVadenl
         dtxDldNAoefD1OBAd4A8pqjjI8C4THMimlUQFZg7teh3Wsvw7rdzNmvei6ClRRujGvSA
         TK9+Z1Sx9q2qlRB0lNGkGqllVTVPNwSQYVZShO6cunuWt0fpnWuMuw5oYwCWVnP+kjr2
         oGIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbEPExR0UuS6QZztX6aW73HMOFqB6llVx4wmDDApEebQjU2fSuH38rexfDqqbCooJzWcy3Fc7L5tNT+djwnj/+FoZyX5Sl9Xk=
X-Gm-Message-State: AOJu0YylOuC7xRhc5s1Q0mmuTbFvg7YjVtkgqslLyXNDhUie2Axz1src
	D8Rj3U/SDBnE4R0+LU6QJzoZW9nSoyzgvzZ95YJYCL/ELU2FMvKFaVe1udl2eSM=
X-Google-Smtp-Source: AGHT+IHeYKVAaE5HyEsDgFLcMCPB2WCj14+aNFb2GEDcGEbOgS6uETP3DFE/sf70LFxupGhpUsHcGw==
X-Received: by 2002:a05:651c:1542:b0:2de:7046:b8f8 with SMTP id 38308e7fff4ca-2e51fd2e6a8mr293920221fa.5.1716211085159;
        Mon, 20 May 2024 06:18:05 -0700 (PDT)
Received: from ?IPV6:2a01:cb1d:433:4e00:3518:6eec:d551:4012? ([2a01:cb1d:433:4e00:3518:6eec:d551:4012])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a77f8sm28983023f8f.54.2024.05.20.06.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 06:18:04 -0700 (PDT)
Message-ID: <13468147-6853-4bd8-bd3d-d1f1927133fa@baylibre.com>
Date: Mon, 20 May 2024 15:18:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Mediatek thermal sensor driver support for
 MT8186 and MT8188
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Nicolas Pitre <nico@fluxnic.net>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
References: <20240402032729.2736685-1-nico@fluxnic.net>
 <981a8748-16d0-4744-b097-aa9dd14c63a8@collabora.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <981a8748-16d0-4744-b097-aa9dd14c63a8@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 11:22, AngeloGioacchino Del Regno wrote:
> Il 02/04/24 05:25, Nicolas Pitre ha scritto:
>> This is a bunch of patches to support the MT8186 and MT8188 thermal
>> sensor configurations. Several changes are needed to cope with oddities
>> these SOCs implement.
>>
>> All values (calibration data offsets, etc.) were lifted and adapted from
>> the vendor driver source code.
>>
>
> I picked patches 7 and 12 (and also fixed them) introducing the nodes for the
> LVTS controllers, but will not pick 9 and 15, as they're either missing thermal
> zones and/or using the wrong names; let's wait for the next cycle for those, as
> I will also be able to add the SVS on top (needs a bit of time for testing),
> getting both SoCs complete on the LVTS side, without rushing.
>
> Cheers,
> Angelo
>

What do you mean by "missing" thermal zones ? (is there some reference
code somewhere listing them, or whatever ? how can I know which ones are
missing ?)

It seems to me that Nico took into account your comment about 'tzone_name'
and fixed these names in v3 ('cpu-little0-thermal', ...). Are they still wrong ?

Julien


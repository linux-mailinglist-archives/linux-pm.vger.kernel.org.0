Return-Path: <linux-pm+bounces-19583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C8E9F96AA
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 17:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594D81881CD3
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA13A216392;
	Fri, 20 Dec 2024 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EN0O6VGS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FC8364BA
	for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712568; cv=none; b=EPl0D9UE+8eZ4xQf8/zXcmZQMLRuPuYyclg0BaWjfWjPwl9PKt1OsfyTkq9ADqeryj4E+azyH0CG4qLz5kAW7b9S3CxECLKaNtGEueIIecPXFE/LHJe9qgK1cgwxQSAx5G9BNjJMk4/ahNsTQgoqMFX6c6tLPnTr/xCeujMO9/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712568; c=relaxed/simple;
	bh=v4RA1NZpbo8zxcXRNbKKR2hPLFIoCcYg1nfBwTKup4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKjOc+tbHXOmVcZddkYE47JNbwOyO5EEg9ciaCHew/YzIKXwFiCA9KQvTzJd3s4P6F73MYDhlp7AZwKZzH+f0sYpRAgHeEWHKrgLZllkxFsexcnQWv2ZFEsk/2TfCVwUpYhHyIZse5t6yWer8bQ1UQAW/ene6Zx+JnCXAlTB1z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EN0O6VGS; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a9cb667783so15050745ab.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 08:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734712565; x=1735317365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F1lMGJUxPzrqcmPgxafYyv3+sUC+a2qb5dBzUO0z9eI=;
        b=EN0O6VGScj377/7uRskw+gLCz9G4DXan6XHcRPjtmAO+XmH7uXG744X0VeDxC2308h
         Mgt4JWQ9QmGTaYygFoJ4Si81qT5NU1VbhcccyptPkKOVYxpwewjBsdxv5roiJ+M0Sv3U
         3XjwckVVNzWK0mo9onEWNykrE5y1eDK+QvEV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734712565; x=1735317365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1lMGJUxPzrqcmPgxafYyv3+sUC+a2qb5dBzUO0z9eI=;
        b=Vdd0XLTFi2iuZVs8nXyTYZ/8qiNuOuPCTrIk5i4X8uIlISGOiV7vEkwyYArr3XiJPB
         85KWgS0yIF6wttjZGeO3ZU9tQOWuotjXpiTjY7ldVpv+DyyWq0KpFZPGio7P7xKrYJ9C
         dS3Ov3W82vBrc/imxt8Atpl9XE7kD6gyY5/kqNqTUDSsmjF4SGg0mlgUgftoMIm+C7ih
         pblAyg6+sNAwHL4DZiDYRT+OaAumWvrD6pprcbMc4l/eKwNJziahOgfA7FzwiY31R/zO
         SQNofFV/g0GfFVRoS/mV9zpUoxMs0jA5fT/tPUuf3eh1fLwT76AV2CDfcG6cp0t6WWyo
         pfAQ==
X-Gm-Message-State: AOJu0YzSjT5uZyd5mfmmqVq+AWCi3jOWF6SowH1R4YZxUYAMtu24mYle
	/cL/h3Xttzt86BBBA/bBzvi1aCSwMtgGgYgDLzOhEUND0akYHH9MVmpw4DuEHWo=
X-Gm-Gg: ASbGncsx8094rSF5MKntzrQZ3sPwvZiB9HxmCbRjR9ZaPf+sZwGPBjy53vy9UuWQaRO
	WZbB/omNNvHD+ltdCJfIQuIkM2pL5tfDniJII8RsFb1pgONKBEHh9H6bIcNQmSpZ+YASlI6IXup
	oNRxuI8Pdir6UxxuqKDHJkmEqfF0ju2nUyEnnDAz04npdd/+JMsMJYedAm8qQa/OIrQvqKHA65P
	mHlMLOC18PD97DZXEMB32nXmgI7Ojkpb5ZlvjTB86ca29yyppkeEO2rgpvKiKUAeQuH
X-Google-Smtp-Source: AGHT+IGUEWhbwJjSpEZlwDAC/Y/Iw+OEKHHCpBCjHUPvC10v6ADtdKgYBdZq7mPbXyuPy5+xIOi+ag==
X-Received: by 2002:a05:6e02:1889:b0:3a7:5cda:2769 with SMTP id e9e14a558f8ab-3c2d2f3b65emr32745735ab.12.1734712565445;
        Fri, 20 Dec 2024 08:36:05 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3c0de05312bsm9560035ab.16.2024.12.20.08.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 08:36:04 -0800 (PST)
Message-ID: <dd1bcb9c-9dea-4e55-908e-869c57629f85@linuxfoundation.org>
Date: Fri, 20 Dec 2024 09:36:03 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: Add install and uninstall options to
 bindings makefile
To: "John B. Wyatt IV" <jwyatt@redhat.com>, Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20241219012606.38963-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241219012606.38963-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/24 18:26, John B. Wyatt IV wrote:
> Installs the .so and .py files generated by SWIG to system's site packages
> directory. This allows the Python bindings to be used system wide. This
> commit also includes documentation on setting up and installing the Python
> bindings.
> 
> Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
> Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
> ---
>   tools/power/cpupower/bindings/python/Makefile | 10 ++++++++
>   tools/power/cpupower/bindings/python/README   | 25 +++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 

Thank you. This patch is now in

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

I will include this in pull request to Rafael in early January.

thanks,
-- Shuah


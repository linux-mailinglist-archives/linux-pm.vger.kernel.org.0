Return-Path: <linux-pm+bounces-29015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC397ADF805
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 22:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 840297AA585
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 20:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF4E21CA03;
	Wed, 18 Jun 2025 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AY1XhNaW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C6821ABC2
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279476; cv=none; b=UwrmMlWZ39vG/rfMXUsm3Tw5XaVNikgmmR+WmuDWjedHV3iWxtoh+tDD59G1S2N1qYbuiiutWNnZFp6F78jsdkla8Mqv061LsH+pFb58iD8LWQvNsIkSco3/FMLDyTwz7thCSJLEfWvR41eUUXzo4SZ9Yv0ANBA4/z0vTWFsQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279476; c=relaxed/simple;
	bh=A5V77MHGHxoltQ9oWQNW08wwJlpbGRsTMYBy4qGK4RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E06Mn6M2lRvGc/L81bHIU+vlsyqdiDZHdlYbIp/+4O5V2WtK8GnCef4/SaqAsN5s5JjmFzpa3uGaEmMWcAHzgwCwv5jDKGEmsINPsdrhi2e4T7sEFeSETts4IrHyALtpViWrSpbp69KEPUyo3e2gDncy09x4aP67aL0T/HSMdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AY1XhNaW; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8760d31bd35so754739f.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750279474; x=1750884274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Ako2fd6NKJ2bP6NpCy5kPqjwnh1toCTc4fAZAJEcDU=;
        b=AY1XhNaWuQwWdpKSLvQcIueK6FNokFmknlm91FFd3DBoinj0SGleoshhpPClXqi+vS
         XQlIYccEx3eD4V6dE/J2wxr+gjQzXEVEwELObGreW4vQphyefDA0Cu/tkrI8pdkY157b
         A5gJvMNsttfuL0dRppQsD7aa5FJGdzorV3hR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750279474; x=1750884274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ako2fd6NKJ2bP6NpCy5kPqjwnh1toCTc4fAZAJEcDU=;
        b=jawUL7tVDnOLVxaiPN7zqHBHYTRtJ/vsvsH5gDO+iGGVvHvXNyZmgVeaQOutgxl16l
         0AYf6BG3++2tWTFPD3WFVpGHvWPSio5j76wd6u3z0NuT7ONDGgBlbvbY4gC2/oFwzvby
         d/9H4O7Ncck6w84rf5g86PhSnnWKumydabdFAAj6cTb28yAM1o67EbdZUievpAa3CcMU
         olvxVbDFUtaaktO0IUad0by1wOL6MLXjPIWbKlJkUy5Ysa+Dzimkbdnt38ysYm4jfoWp
         U+6ZCKsxGc2e5tmVQqU2NyV9eD672r99ZN/BOP8gMm6kaehoTqApTVMoq/576Lwv80p0
         C6zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmAdLoVCw48JO8tk1YUtKiTWAAmK0mOgu84AargMvjda2G3zHj28lIFk/UPKqekkG9mIQTiIOQPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/OPiuid7XJ5+XXtlQ9ii8fRMYoLXlIlhUEOqxHpuFJJeWJfCu
	au7rrvYc/qHCMUxo8c4nUFiAxzcBhASEh1ddihoFva/2+DTZIyCOQm4k1LM5JjMtzlw=
X-Gm-Gg: ASbGncv+cyHC6PFsGdc1geaHJvLl7304DStuF1kHKqYc8QoKbuuAyhmYJVXXgj4YmvB
	1KQ7BB4rvL+GdVaAXvw/d58QYv6T5EtfvTopm57RpBXapR+jGuv2ulgURGX0rqmY3MLv5xA4Q4N
	lpqvIuSTk7H8C+tIil98SG7g0SlBNd9W4jmN5FRKtQJrO3REFKO/xpHrwZXWi/OsdgC0zH0uqG8
	k678ZAhaLWnU1N93f+vlgZQvf6A0blVaEv7f257aHtZba/AJ76E2W6jO3oz+7eH1CkEOagkQz4v
	4CtKACQtEvNB46ILdINZX6SYQ6ZKbHqyPn6Brj+1SPWtn0yPVkB3lyVOzWJ2GkHXj/qV4/tXJQ=
	=
X-Google-Smtp-Source: AGHT+IGBjo9SKc7leBQCMa8Hw77h+nyuKDNR2sMTMdtJdYEON8VxYPtAlm1helcS8akEtiF6cPaOoQ==
X-Received: by 2002:a05:6602:1612:b0:861:6f49:626 with SMTP id ca18e2360f4ac-875ded13886mr2529017139f.6.1750279474117;
        Wed, 18 Jun 2025 13:44:34 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875d582dec6sm278667939f.33.2025.06.18.13.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 13:44:33 -0700 (PDT)
Message-ID: <34f6b974-7fb1-444a-861a-4bdb458eca53@linuxfoundation.org>
Date: Wed, 18 Jun 2025 14:44:32 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: ABI: Fix "diasble" to "disable"
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: arjan@linux.intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux@dominikbrodowski.net, rjw@rjwysocki.net, stern@rowland.harvard.edu
References: <20250523220238.455718-1-sumanth.gavini@yahoo.com>
 <20250611215306.2989590-1-sumanth.gavini@yahoo.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250611215306.2989590-1-sumanth.gavini@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/25 15:53, Sumanth Gavini wrote:
> Hi Shuah,
> 
> Just following up on my patch submitted on 2025-05-23 22:02  with subject "[[PATCH v2] docs: ABI: Fix "diasble" to "disable"]".
> 
> Original message: https://lore.kernel.org/all/20250523220238.455718-1-sumanth.gavini@yahoo.com/

> Would you have any feedback on this change? I'd be happy to address any comments or concerns.
> 
> Thank you for your time and consideration.
> 

Sumanth,

I am not the maintainer for this. Hope you have the right
people on the thread to review and accept the patch.

thanks,
-- Shuah



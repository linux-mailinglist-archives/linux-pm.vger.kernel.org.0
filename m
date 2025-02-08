Return-Path: <linux-pm+bounces-21595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7101BA2D864
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 20:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B442A7A35E8
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 19:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBDE1F3B85;
	Sat,  8 Feb 2025 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV5zBUFn"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DAF19DF8D
	for <linux-pm@vger.kernel.org>; Sat,  8 Feb 2025 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739044573; cv=none; b=nsEcTAUryK9P3qLp1aoqZWPqJZFE91KAtrgg5WkxSf4Zk47ye16xmBBbguY7CtCLrJhQvRjelsAJW2TDnj+Hh0WE97GD7FbrPoneuDgjtmfJE1U0KOiJrnHnE21g1itewik3QrCkkuX8WYed6P19MLOFRM24C6l8YyScxIsPlHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739044573; c=relaxed/simple;
	bh=1drWUIgvHFq0hezfTkFnWaTwhco6irh+3Gr9yrHOpOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3HXhC4TjYVHE+1BW/Mo5LnE6UAnWmpJFXxDjYSJ1rRQIu+2VOQ3lK2DSlCNLh8OSjefhaLYz+yZHgkOcLyO9OREBklR4kVOFWgWWFA/na149SdoRR/5H9dklcwWALQIOyDY0ifYr/PxDI9yChuhfs9I14bLKUeMQWZWtXX+dwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LV5zBUFn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739044570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJrBPQnhtPlXH6IxDYHNsAVehPX7LGhNXc/5vBp7/qY=;
	b=LV5zBUFnRP9vixvNRpQuXjrqLiwjXIQumXXnjbQobHFA9t1NMixNRhYD8umt5sKr5dc54G
	KH/BtfywJ5TFXJ6SAtPe2QMNA/zMEMqVDFn3zz7b+REF2IVCH7x8A1BjyCrHvxudYIvcqr
	/hzLQeBeIAA6JakV8nWQ1Wnn/e0pAjA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-j07LXBhAMAes5matTfkcng-1; Sat, 08 Feb 2025 14:56:07 -0500
X-MC-Unique: j07LXBhAMAes5matTfkcng-1
X-Mimecast-MFC-AGG-ID: j07LXBhAMAes5matTfkcng
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3f3aa4b60bbso386042b6e.3
        for <linux-pm@vger.kernel.org>; Sat, 08 Feb 2025 11:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739044564; x=1739649364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJrBPQnhtPlXH6IxDYHNsAVehPX7LGhNXc/5vBp7/qY=;
        b=cNQ2FWRlJp5frSwCc3RJXHssY/z0Wfu3ZFkliqPNtLCtauOdDn84jiUiib+0bY1rLT
         0cRl9RsiufqOwc3ybroRH9XWqomOHIU9Cq9K5i2N0qCDBGRpTBbDu4wdXc7a56jO80DF
         Nt5HWsQ6oLTE9CVyBXmvtc2vXGE4rcxZhwxaR12pbTc9K4iBE0O46yRHlepW+1hmPC1D
         NkbWcsQZGxEPVMou/k11womNIe29SZq8JBDrBNmxl8UDGmwxlorMicyWJAaXuXFSYjpu
         niCYFDDsL67v98K6yyXjzEELUIJasWbSUcpS2t4itjgdPdNZBKWbKk5K0pHud62viVGT
         I4yg==
X-Forwarded-Encrypted: i=1; AJvYcCXzin2NAAsx8lfQbbjpw4cc8+h5hFnhKXKEJqFF/cscykg0/g7vbChwkQNvnwaVDsxDK/Q3yPR9rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwTw6TKoSBX/DaGOj37zc2tfnbiKbdxeAzVJV1dII4jxNyYTov
	iRGJiPIHeEhi8ntgsCmoiCmJJ1ZONMjszxcaHX1px4HYgYRRXUMeLzLXCB/fe7c0dsZXPQVKMeg
	GfWq3Tva6eZf1LtZZC0m3W5Zo3LrkII5fnsrdZ58KiEOtef2aTCEZWy6I
X-Gm-Gg: ASbGnct2AMJy4zVW5JqSBigxjYeawRirl1hp8hyMDCWnmWCexyBWoeUqV5viQ3wqnvU
	KJhHWMdd5EmOrFCZs3DOZHslePfjl3jYwa3KF6ujM7AUaEsyVxkLUiP1NqfwcrUNLkAPHcAOwzT
	sJDcBh93adPcb+09RTpOuoiOpKkMbQkLr2Spmp02LxAVzkMZS2eBDWy2Mx4JhfuobjdnVRQtAY2
	QyUM2p0xJz+AJdwGwbcgB3xWH5KVJPgI3Fjrg48sRpr4bIilSlnxPFpOflmD9P+MPkjH0sRVZmO
	oY0P
X-Received: by 2002:a05:6808:80cc:b0:3e6:3116:99d0 with SMTP id 5614622812f47-3f39222b3fbmr5393568b6e.13.1739044564699;
        Sat, 08 Feb 2025 11:56:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF77f8SjJ5aO8jURW5smUN5SBZK/+nJGx6pVJEW7YxApvAY6WlsUk5VVFGjgRkKRDc4TDJ/xA==
X-Received: by 2002:a05:6808:80cc:b0:3e6:3116:99d0 with SMTP id 5614622812f47-3f39222b3fbmr5393561b6e.13.1739044564465;
        Sat, 08 Feb 2025 11:56:04 -0800 (PST)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389fda9a7sm1417358b6e.48.2025.02.08.11.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2025 11:56:04 -0800 (PST)
Message-ID: <720944c4-48b2-4d1c-8a02-d81416ed7484@redhat.com>
Date: Sat, 8 Feb 2025 14:56:02 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] intel_idle: introduce 'no_native' module parameter
To: dedekind1@gmail.com, linux-pm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>,
 Prarit Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250128141139.2033088-1-darcari@redhat.com>
 <20250206164009.816232-1-darcari@redhat.com>
 <6c258775cdf2f8f3c370c0cb81daf22dacf6aeed.camel@gmail.com>
 <9241eff1-0c2d-4c82-a77d-cb8b67cab6f9@redhat.com>
 <c25d3b9abced9263da463b3ef4f31fff73878189.camel@gmail.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <c25d3b9abced9263da463b3ef4f31fff73878189.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/8/25 5:37 AM, Artem Bityutskiy wrote:
> On Fri, 2025-02-07 at 12:13 -0500, David Arcari wrote:
>>> And if kernel was not configured with ACPI support, are these not
>>> recognized? Or
>>> they are just no-op basically?
>>
>> They are a no-op - the flags are all set to false so ACPI C-state tables
>> are ignored.
> 
> It would be nice to mention this too. Otherwise it sounds a bit incomplete. Like
> this:
> 
> 	If A then B. (nothing about "else").
> 
> Better way:
> 
> 	If A then B, else C.
> 
> :-)

I actually took that from what was already there.

So I can add "In the case that ACPI is not configured these flags have 
no impact on functionality."

Does that work?

-DA

> 
>>>
>> Sure - so is this better:
>>
>> ``use_acpi`` - No-op in ACPI mode, the driver will consult ACPI tabees
>> for C-states on/off status in native mode.
> 
> Yes, thanks!
> 



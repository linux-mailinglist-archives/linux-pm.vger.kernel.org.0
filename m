Return-Path: <linux-pm+bounces-32359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7E3B2562D
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 00:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA26D884804
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 22:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5CD2ECD37;
	Wed, 13 Aug 2025 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EWKqfwS6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBB72EFDAC
	for <linux-pm@vger.kernel.org>; Wed, 13 Aug 2025 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122422; cv=none; b=IbzUwtcfmiTn2GOmnSV6NW6Uun4B5nciYPF60ZzFzCIms+QovGUgvopchc6/+LANB25a7SWJ0QafuOIUK7PyG8+YaAI3J24LsWHkXj5nXXnWQYcC56Kh72P+q0ELY5OJqevcZDm1NoGa7PzWPGZEzIOB6B2CGsXG5SrTxHBx/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122422; c=relaxed/simple;
	bh=8vDml3sm19tCud9DP2FIyK5L6JNeKNtaH2cdIxByAUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2a71kua5r+ervjiAkvZdOwVwCfAg9Az8YPkmEd7c/X/+y2nB/UPqQnTYir8DSWf5BO83RMcj2creEDSm0l/YONjZk3hLyDfRC02vjQ6QqQuGqMdgqQB+0fID6zG7Bm/dkdl2B3jt5NNtHvzM91Vbsg8dTZh3AeGV7TDF16p6YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EWKqfwS6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9dc52c430so161737f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Aug 2025 15:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755122418; x=1755727218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rSErH38GJLhhhn6LqWdJPstddGMa0f2KvMQKCmhEM7c=;
        b=EWKqfwS6n0+pi00/14gPZtww0wsKDsU/bnL2RV6DVShw0GfzXLJyVn/Cc6MnjrssZp
         X1836amMcspSQw5nYXA00Ml9O3UbX+gjlmchzXl95TdTs11f16NIC4aQxgH78UVe2H9L
         P0Fg3ru4kSJfhNvata/V3cuiq5PJwcVTrAAzZl5zqK88A7uYapKOVnu41VLYqOH7KCaJ
         R5TGyhnUDAsgEo4FWfzss+EgnJbtgs7Igh3KSAWjzJ/+Dmtf0J7UZzSdebJhMrCwWPBU
         O5Fpyqn0/2JIynOKU+3Bi8r/siHEFAUUOvwen3EeKSjQ0T3jgzH3QTib9ovz6LB/H51n
         NCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755122418; x=1755727218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rSErH38GJLhhhn6LqWdJPstddGMa0f2KvMQKCmhEM7c=;
        b=m4O9hvEVpToRBrYKiG/1QoKbHddLw44i8HOEXkpQjUKTeL+NbDYmhq6OJbIFZ/FkLy
         ZKcGvRBlQrhGiE/d8VA8dpYGa41ocw93OnNh4pGhqgVbn2zsW8eyjCFUMTP60pOHCnF1
         0BMClZkdJE59GY/xWthiK6sxiPS+Yn6v1E3hP9o2A4I59W8yUKbWM8B1rmzP2sQytMru
         pQTxlu1Tw3Cpjf3KhDn+DQsMSkUesOv7w1/Esi3dhG+D7Bgr7jf6JuwFNtKxzv01iD4x
         bcGoZs7nxhXttp2RsAKlDUNxTwViXFP+K3+K2HmLjeFP5MeYnsU3c39Es4KIuVJdyDPq
         yXeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLY8l1v0DJ3OVeisLFMENgCjjFFZGDCeW9uzcoJD1YlP87pxOLgnXDTAsl6Oi7+1SxCKpF79eKBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5clDVplc0PGNCs4PJDsXgkzfjqU1uKjuYznzKZQNeredxz9xd
	To75m3RuJFsMfLNeOvIm3S9MaHB1gy8RquWKypB1duHc55iE3FWSlr1HSbWpiHHQ7E4=
X-Gm-Gg: ASbGncuBMUu3sqPK7vv6UBxwv4MK2337n74vlNpQGWnsH5i4VyvYdVTEHJHC/EWEokw
	HESoa/yarOZ/mnLHO/bqoP1GKLBuWH6wAmcocBS3iHwrZwGd+ggAWcg4iHs0HdUgTIyAHQaYWMh
	kZcyjxEC2pFeagLW6xFm+tunb8pOPDo4MPhPMcuzRQI4J4f6CRSmlhWiIrAKb+ASTLIxXnGNcze
	OS++MKebFXWJPQHwi/ymIOEbBM4INx5+Na/A7E6B+uz7gATnakAz7t/gKZaG310tnL2k0iv1Pte
	YkzuJK/pm8zAH71rXpWV5wmFWklz01rABQ83ZOdCzsheDJ7YO0NQ9vaYq2v8SfLWftwO0Mqlmfx
	BqNi/rGP+B1e8DuALJFMBpRnVhROmdKcrbnj1y6CzeDVPJKFThnWf3XvWGyBmZg==
X-Google-Smtp-Source: AGHT+IG0p9l2T2LkiySIWZNQMyABUdzq08C6+UvfHOcIuzynYb0qaNHHfhjbPlxnMtD+LCH7f48i5A==
X-Received: by 2002:a05:6000:4014:b0:3b9:132a:a554 with SMTP id ffacd0b85a97d-3ba50d84fa8mr154588f8f.51.1755122418500;
        Wed, 13 Aug 2025 15:00:18 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c3bf970sm48674093f8f.25.2025.08.13.15.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 15:00:18 -0700 (PDT)
Message-ID: <5ffb67b8-cded-412b-881c-14179c2ba3b8@linaro.org>
Date: Thu, 14 Aug 2025 00:00:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] thermal: rcar_gen3: Add support for per-SoC
 default trim values
To: Marek Vasut <marek.vasut@mailbox.org>, linux-pm@vger.kernel.org
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
References: <20250625181739.28391-1-marek.vasut+renesas@mailbox.org>
 <86f5260f-6625-4e2d-88a8-013143922fb9@linaro.org>
 <a65ae3e9-8970-46b4-a80f-3654daa7a0c2@mailbox.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <a65ae3e9-8970-46b4-a80f-3654daa7a0c2@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/08/2025 22:37, Marek Vasut wrote:
> On 8/1/25 11:59 AM, Daniel Lezcano wrote:
>> On 25/06/2025 20:16, Marek Vasut wrote:
>>> The Working Sample R-Car SoCs may not yet have thermal sensor trimming
>>> values programmed into fuses, those fuses are blank instead. For such
>>> SoCs, the driver includes fallback trimming values. Those values are
>>> currently applied to all SoCs which use this driver.
>>>
>>> Introduce support for per-SoC fallback trimming values in preparation
>>> for SoCs which do not use these current trimming values. No functional
>>> change is intended here.
>>>
>>> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>> ---
>>> Cc: "Niklas Söderlund" <niklas.soderlund@ragnatech.se>
>>
>> Applied, thanks
> Is this series supposed to be in linux-next by now ?
> 
> I don't see it either on git.kernel.org thermal group tree or your tree, 
> where was the series applied to ?


Sorry I did push the branch.

It is in the thermal bleeding-edge branch now and will go to linux-next 
in a couple of days


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


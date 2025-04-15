Return-Path: <linux-pm+bounces-25495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01F1A8A77D
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 21:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E0119030A6
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 19:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC7220ADCA;
	Tue, 15 Apr 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WR53fj1x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB2323D299
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744140; cv=none; b=iaaXPvJQCBFKLoxvBhTiENrAiwIvyHoylqBSnqGX+85366CNgHNXz0G/SMJ0S/7tcQvz5bTKZ0DF2vAWDf4B1tKkBQmJENJBmt9nwcXq8nbp3DhRHkO+5LFHkDm250BN9N8zYn/6RENzGUztDqy+cQGouxBKYxp9YiYMBw1g7+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744140; c=relaxed/simple;
	bh=jrQ1OGDRRdfmrMsY4A4miwnrG6WMz22GPGk9HT6p6Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRP/LGau80GQ7E2z4LDpR7immzTs4F6evBj9iASRyoSCbXCxO/60xASFImNXUQanJIwvo8p38+BbbV7de6IiJ7t6dS1M+rShZfcszaeNl2tLcPuexDAzoyS8vQ955EuoIgnUO1GbqP7oJgrUK/SbiCRviqLZ5ToBj3WLiUkrFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WR53fj1x; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72a4793d4e2so3597853a34.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 12:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744744137; x=1745348937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t8YiPd1ZphysNTUjgASCoCw3dBdpJDSVkH79WF+uK0o=;
        b=WR53fj1xHIFaRcS8WPe2ub5SKs4thDutGMGyRFB3UY4RbR9YUUEeP/YW+64ILQHeDz
         Rfl31MV0ciIa0s7Wlfhp6PEKsTF2ciMu69mNzrbJKMHE5/BSNqF87ZAefpCf1PkcZqbb
         CBSe7/9Qvi/ZOFCAi52mQhgQ6QTZi1UO8W1cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744744137; x=1745348937;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8YiPd1ZphysNTUjgASCoCw3dBdpJDSVkH79WF+uK0o=;
        b=OTToTdZvmVTZSwkINfufSuAr5IVPL+3xuYg5aC4nw8ZTi9v9UeI1UYg+VOHRdOSQMO
         BWBg5hiRhgUli+3M5kgfd1oMBELIF9tPUlwfv5mQ5PJXAq49EXEREx0vyvbO3krL246P
         Bw+qcyOsXLomrgtIwyrkp9u4mFXW+mbk5lj9srRJLRpXgUxaDXCrMdyanyRd7RF6f2ok
         WQ4GIn4LdqE126YyVWVlVjmQeXHO0rBMIaXbRmsgjuRhvaoPG2ofIdxf+bA9TGEposif
         uj/9Z/PFglZ3zuThzkS79NK5zQMNHrZpe/lZWygEQ6edOTZFwXtQATedot8Y/d2GXe0l
         Gf8A==
X-Forwarded-Encrypted: i=1; AJvYcCXpDUX9hqYeoPzQOL5xg+4ChpYArD574/wdc2ZCCdl1sTu45SZlFSbuIXgXrS0jPwO61oPvmrWoDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDbLYL3Qxgz3gCscYeMm+V2ToFgTlQlXb5BmAQdQOiMS0oUST9
	7u5ovpNsJnCTRP/e25DW7110vqPyXfh2kNUXFMwk4V87foC7SjyUgIdyH0gLLg==
X-Gm-Gg: ASbGncvKexqnOH94TSGt1rccajlJUsZ3R+Q0E/N7g3V6Sh40/7hNq2cpOdW7bU2+B53
	gNyQKMFyydcfHJzGQOROJUyb0Km4zmKj4Q75ZhOflMWcUybTtwXWAMea2FAcj3QbxcCGhohTngH
	QZBZGSmYCINoLvuSp/1iH41OuoYDYMvBn2K+0dTCNWZtCL5XXn9rk9PLkzulTLlUJgWwTdc9Yby
	kFiZ+KQp6rcdZoWbgXHmmx9Re39WJvgdY6vEBtjHntjxUSOWnh3wsW1783yXRRtPz/qfCOJYQxD
	QdWr+QnweQN6E4w/EmJnhcxjREzil2vyH8B0Z+XtgRIVvF/L2ZLSXIOj7ow1Xz4q2j/+mNyoJn6
	hr5tNYUlRsRbeMJI=
X-Google-Smtp-Source: AGHT+IEdIO6hs+AQENhHU/Q4pBw0xIAh3rKosnODs1WPRYYqWq5Vk2+oRWHgZPkrZVPbj0ckU1aOlQ==
X-Received: by 2002:a05:6830:aca:b0:72b:92aa:b69f with SMTP id 46e09a7af769-72ec1b5249emr392783a34.16.1744744136978;
        Tue, 15 Apr 2025 12:08:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73d8cc9asm2526253a34.30.2025.04.15.12.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 12:08:55 -0700 (PDT)
Message-ID: <1b2faf6c-6a8e-4d16-8248-ba7fdb5c1702@broadcom.com>
Date: Tue, 15 Apr 2025 12:08:54 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: bcm: bcm2835-power: Use devm_clk_get_optional
To: Stefan Wahren <wahrenst@gmx.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com,
 kernel-list@raspberrypi.com, linux-pm@vger.kernel.org
References: <20250415190558.16354-1-wahrenst@gmx.net>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250415190558.16354-1-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/25 12:05, Stefan Wahren wrote:
> The driver tries to implement optional clock handling with devm_clk_get.
> It treats all errors except EPROBE_DEFER as a missing clock, which is
> not correct. So use devm_clk_get_optional here and get the corner-cases
> right.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


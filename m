Return-Path: <linux-pm+bounces-28693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5D6AD94B5
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 20:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099AF3B927B
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 18:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10810246797;
	Fri, 13 Jun 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yl39qKKt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7C5244691
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749840269; cv=none; b=q/tF5cEI9DwR7c/r7UsLxqlfBgzKgLuXMQ7VADyXJUOyWwYg5xr8+sA33nFxvuCUTmGxFACmIPjajiO5TE8ch/w906fu6elwblE254fvoD8BT92vgCzlCYtZclueZfpYRY7rN+qydklXBFhQgJNvECbFqMrMs3yaBEaSiCrl64k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749840269; c=relaxed/simple;
	bh=3b7axUpbAuU9SlpN71lwKlTvySJnDInVui/A5UkWlDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L6cV9n2M3BpHhb+M2Bw9Ku4rz0J8zcnkM+EAUqt6UMsHOGChZCyegyR3n+EI+Oqm626wQdjRYVGodun8Df4UUZrFy7je89OWOyyw99Aob7p9WWvG3+7lGXTi/M0CavupOitg4WHg1PO5wbhcCRy1PfXEatsJkjwhPQcYTHgicZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Yl39qKKt; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so2517207a12.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 11:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749840267; x=1750445067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHeYqEVybulKIAJ/SLz1vtqwVOqbhPS/lmlXAmsbCt8=;
        b=Yl39qKKttWEwqolcMtqmQ2xv+ecmtcQ03Wvdq8hTRriZ+lJe+oGPu0umwbHYbVmsvH
         XPQHsg0g6jAoSDHlaaGRpZyAR80ALCXQVbmtmnvorTQhSvgzGYMc2bZDIfdTtAGyd6p4
         oHMc4VFlDBNMN2btR6xMXmzrTPlxiwq4WEOcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749840267; x=1750445067;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHeYqEVybulKIAJ/SLz1vtqwVOqbhPS/lmlXAmsbCt8=;
        b=VkCc84H39sU8mt9lssat2jDd+rdj+NvzHy7+Vbnm3+LOgxmSXhVlrOGiNngq4o04Dx
         NhWUIWwmA+m+r9uzP/WGp4/YJtSy4CiGlYpEIdDaCfRMG6K6GUQo3MzOGtBOmdmv5G/n
         +9tSQ+cuGq/QZ7NhxpphiCRP4jL1GbiuSq3Fj6/TMnPosSdcUpU3vMHuaLM0YLsBxB9h
         MvHQXmT4dCzEDLeRfe/7wBcynHbAavmaWzOk/1QcsWOERbMM+QSCdUhUYe0qxz4BfOad
         AAk4qUUZiFwhjqIlUhdvbIuTF7O4f/EAGB+IYEusTnRhc2e0x5nCFq3qE6mTUjrXPSRP
         rwAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx7OZ6BblXhxzQ6PM8j0ep3gkIHMoGdEpuxuVe4r1V3xfoIc3u4Rpa1uGo6oINxlWyyaFxGQulYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCrfMEqRn6NYIjYWDzFHwGnxpmjLjseo5NG2O9j6Rm2hYICbp0
	qTl6Dg6joyZTVhjvilO8W1g3s9q7FOHn2frzQIdR05pGOtROmV2DmI5IFGXI0qSG0A==
X-Gm-Gg: ASbGnct6uYWCJDJ4gRv9EuvVzx5wDIufex2KbwIkwujqcSR6BVaMaJGDYU3qu7OcNih
	8w0N+KPSxTl32EYj2kVVK59ETvIHD/66/p8OB0lzGYs2PO6oaN05k1OBR6wm5AbV362k6hkfE7S
	Zf/KNEYw4fzFnbcT4Q2CVTEqDVm+nMWgfFBnlurqkbM9PGdocvmRK+uDbUyMadHbEqnd8kth1vI
	eT7KwUI179xoR89QOTb64eNMWXbzyYS/n3/hCDsXDUqyk93m6B+F1Vti3Ymxlz5VYg2IYglLZhX
	Vu2HYYP/h4AU5cQAv4Rg5T7xXaBzPPy9WPQVEO7gP9Fg3J+2fuVOZyPyhLt+hXOLY+mCR80Rd2t
	51Gv/F5KEaL9rcg4+DHvYKwoGmw==
X-Google-Smtp-Source: AGHT+IE3l/ieo58PZuP/VXIQXaNY72ns5eLc69FqJbf0YSdSZl1/lgIYYyrYbd3f+TjZzr4aXsSomQ==
X-Received: by 2002:a17:90b:4cd1:b0:311:f2f6:44ff with SMTP id 98e67ed59e1d1-313f1db806fmr1227482a91.17.1749840266701;
        Fri, 13 Jun 2025 11:44:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1bca4c7sm3729100a91.3.2025.06.13.11.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 11:44:23 -0700 (PDT)
Message-ID: <d995799f-b4d9-4c90-a1a0-2e8e212a6b59@broadcom.com>
Date: Fri, 13 Jun 2025 11:44:22 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: brcmstb-avs: Fully open-code compatible for
 grepping
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Markus Mayer <mmayer@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250613071643.46754-2-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20250613071643.46754-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/25 00:16, Krzysztof Kozlowski wrote:
> It is very useful to find driver implementing compatibles with `git grep
> compatible`, so driver should not use defines for that string, even if
> this means string will be effectively duplicated.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


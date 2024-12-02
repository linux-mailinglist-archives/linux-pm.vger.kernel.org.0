Return-Path: <linux-pm+bounces-18369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABF49E0B57
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 19:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45083B26DBD
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 17:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F531DA103;
	Mon,  2 Dec 2024 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DE1vYQoZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4871D9A78
	for <linux-pm@vger.kernel.org>; Mon,  2 Dec 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159541; cv=none; b=fl/eerZFGOSQFzGm7x3JLwv+2BYmKqtqcnKNdW2Vfb/1OJF7hvFmsTSRZ5TLLUtO4/0Cun4zO03QSX/Harkrs15EB4GCoBDf5o6o4RNqAqfPRt+aSVfQ2Fqf0qJNoP85SuTzWbMrnSC/gQFDmQZ2uwnGPbEs4DJ9G7gZXUxr6eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159541; c=relaxed/simple;
	bh=COU8ALBB1M8n8azO+bp397MJPBYzy1rSR7MILa+Vi4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z+dE5nEgUcXdPBeWFMYzu8wBWiW0bB0nEFGNzQJc2PPyFgWkdCN3Wr2N1OFR1NG53yKRII/mVRqCe6dn5+sQXWp0KtEwpyAt0WtFjLHR34PHTLGs2TorSY1zh37OlRVx1G3zdV+tnGUU9o7sSSf/si/3sU9ryt4i42n7CWbDqwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DE1vYQoZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2127d4140bbso41919925ad.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2024 09:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733159538; x=1733764338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cjc0i5KKj7PMcS3davQgI9vIs+6ac4C5hvNirHHDB/8=;
        b=DE1vYQoZBhywVyFfBh2+Bhx41kp6sJNqTAZBDY4PjGZkCbHEYpJm9M1s0UhNX+jNay
         HEwIDhWP35AoUQTmhi9bGGiuGEAG+IeQVJl9oZE73/WvBoDCpm7DB+A1PGNw66OENxTM
         9NLs6MizTykMHAXgb+zdWq9pZql7Fu9UIr6SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733159538; x=1733764338;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cjc0i5KKj7PMcS3davQgI9vIs+6ac4C5hvNirHHDB/8=;
        b=w9Ns79RgBQIVFMfUZTZEiUE9NuWGq2VYWm4xIDzAJWHGXqqvA1pMD3eDzHEXje29ch
         idwu/jlq/SSGg/caHISShJ4LFSuZvIdvBK9xUNwWS42LSIeXSOuPlDlminnQhx5m7DBS
         wFektTYA12FrjkIFi24aSezzkvOlbxTad1nnbjnNzIjM6i7ck1Iupj43I2hhnJbmoJ8A
         IQyoVsEonVOvIca7f2UPs64I/IOlz3a9segNzNEbIGcNFK4IVObKiiN9E1kHYrQ5jY0V
         e0UXjZkP3Ns65XybNs5u99s2l76dmk1/HDNCV6aAayRrueC/liRFXhsDr3kXWPtMAA4z
         rdfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkQu54NKSfBJFJhWhMnsEjpSlLiNoMrLv7WBhVI3lzw2t3Tl64tiOJlGO62y2DznPJKyEnfVlHtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuqawD+LHYHF/osRsK5OWAdsk1VqJyG5N8CGX00f8zXppqiwy7
	cCzsZfAyANXFI38yd3qnlzBh92hindKy/2krxbrlFLNmpfcE/W2ms4nWd2vVUg==
X-Gm-Gg: ASbGnctrZWyGd9XfI29DtsTLqgK4AWoRq75dt+lGXeOoc6eSXI9z4HPCorgxqybNzkt
	D8ig0iAuSiHbYeUkvZM5LT5zYKHRVPt/raCYONN75X0aKM/Znp/7x02W22g9AS+5RSQRsgvOl5I
	uRx/uvCXcfnKQLZTck11ZZ8OjNae9i6vNYlB2p/C7STmHVEt/6oo+4dn20/IjE5RPN2kAsvPOwl
	g1WlxiOK1h6CKPK3KzmgqQnqcxJcuzBEoXG7dsoThpRgIFFLEAR+iDgfDZj/01KGVMGyKCniPeg
	uhny/dNYJYFNbg==
X-Google-Smtp-Source: AGHT+IFSRI6kopXmcpfDJvsewB2NidSBGsHuz3IrHvvrZQD1/NAQ4JE3ohyxpii3WkEx+Cwp8JMBAQ==
X-Received: by 2002:a17:902:ec88:b0:215:72a7:f38c with SMTP id d9443c01a7336-21572a7f559mr115234075ad.25.1733159538610;
        Mon, 02 Dec 2024 09:12:18 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215964b6b76sm19632625ad.191.2024.12.02.09.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 09:12:17 -0800 (PST)
Message-ID: <ae5eba41-e2ae-48c4-b25d-daece4d329ca@broadcom.com>
Date: Mon, 2 Dec 2024 09:12:16 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: Makefile: Fix cross compilation
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Peng Fan <peng.fan@nxp.com>,
 "open list:CPU POWER MONITORING SUBSYSTEM" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241129012006.3068626-1-peng.fan@oss.nxp.com>
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
In-Reply-To: <20241129012006.3068626-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/24 17:20, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> After commit f79473ed9220 ("pm: cpupower: Makefile: Allow overriding
> cross-compiling env params") we would fail to cross compile cpupower in
> buildroot which uses the recipe at [1] where only the CROSS variable is
> being set.
> 
> The issue here is the use of the lazy evaluation for all variables: CC,
> LD, AR, STRIP, RANLIB, rather than just CROSS.
> 
> [1]:
> https://git.buildroot.net/buildroot/tree/package/linux-tools/linux-tool-cpupower.mk.in
> 
> Fixes: f79473ed9220 ("pm: cpupower: Makefile: Allow overriding cross-compiling env params")
> Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Closes: https://lore.kernel.org/all/2bbabd2c-24ef-493c-a199-594e5dada3da@broadcom.com/
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks!
-- 
Florian


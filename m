Return-Path: <linux-pm+bounces-20896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3E1A1AB58
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 21:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE9067A1524
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 20:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9101C5D42;
	Thu, 23 Jan 2025 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PKzXCC4u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6081CEEBA
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737664026; cv=none; b=pdRP4tKoc6ROIXKdRUEWbW+911M/6O66Ro7RQ7ribP5YzMRtwxnLiwSqOg/Nn5Rz63mjk3fLHAYX2PhT/bxJ5ADeAL2pW5Ry+iZ8yZd30IuKGEehMM76m6m4fDBpbbtjNlI/NKicUFgXjWrdKzWMql9U1kdvG3oE204EyZw3M/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737664026; c=relaxed/simple;
	bh=/htVanBsjhyysSuMmKzY72TCFuvP7tDtqfAcUDG54/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDb3Q5AeN+H3XyeqVBrKm6rh3LNQkw/+DxfsmkZjUktg3IxpKXI+yMhg9pZqE/oClZHHmD/c2J9A+a29Zoc8/YF6H9qEjXYEFl01nk7DGkUN4XSCtyQJSEXCmpSggZAGjNiqomlAPvy0VhysXhCL5gPJVJFGEjvpRoUHH8UyQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PKzXCC4u; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3eb8bdcac2eso336786b6e.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 12:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737664024; x=1738268824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RnTOe7yFWT4UYNJIuLdQZTeHUNhoeVu47fqL7N52te8=;
        b=PKzXCC4uyycLDjLqjEfGnm1wanyxUzCrk67HqLN7fD/SulTPt13LV5/5vkd5PK3M/f
         dBThMMT5B18rRoBqiSmnCQGGgAX0LsOxtOcgkZ8nU4Ni3X0YunAbzGIfW4m8JEC+zJNJ
         81xdkFfU3RwDP4L/XBy25tV9sb83DKvd1WuuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737664024; x=1738268824;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnTOe7yFWT4UYNJIuLdQZTeHUNhoeVu47fqL7N52te8=;
        b=uXKBWkmaNyb0x1z7NB1wWUiQwzhg52Ob5dfNLbDrrjGCNYl373VmRyrx6EwhAaYfd6
         bfvTClg3pDc9LRqnfggmyeTk0gqd5ELQhhxYXgQg0+ppXOXEM/2Zc7QMuUhRDUrMsHDr
         jcDOzx9QdBxQtbAcj7nRwYSKX++oL9VyBI/D40xFvPtwivzpIFrTvqv+yYJCUNGf4Jkl
         JDHYKEWnoyefkqeZAGKXu4SwF1x0iaPpNpGfRVqNrUcXN+pAO+C0nXWmu4wUQA4uRCDa
         jYdR3aYvUia/P349k+0gpF9WN+c8cb3YxO3/dK8nw287igH2xLSnwLrvoa3sUXorDmmC
         NdpQ==
X-Gm-Message-State: AOJu0YyX3YN9BttITcqF9XmiTB5MI1rDqIqwGrhUby3/gKMyzq0ZQoVc
	+0mQwqma2PEfaVglBZJj9oJ5YeKM2txwEIsyy1ZCK7hG8PWxmZKTgCYir5PrzIUQqHoIBT0etB8
	=
X-Gm-Gg: ASbGnct/QVFNM3VIZg5FUmY51hBsgZZ/iC8+/36GbCXfTkM5pMAbAEZb7//ngPVCuJu
	i2nN906end4y/szeVD8KRH22eEh6PwStlgmRQGYSjImWCRviT+tLF6TKqntPaad0NA/FGyj9n/6
	c5NUAGTWXazLyD1QuavPO0jpV1tPtvs+5Ldg6/WCGFxp1Hdb2Bfw5cXZfzblx0N6Geu4D4IyEJ6
	EptS7G57rLqOzVU98nKsfkWYPB8kVU6uyYWS3FgzzUwUyGDqrkBSMOMqyzbPLukuonDBI+xgYJY
	qpfkaGUwIQoCPBCU3l8AOR3KsEIFCjHPCnptzwaii/Jf
X-Google-Smtp-Source: AGHT+IGoXpwCo6KUpEa1mgyEsN3GlaOew1nrW9GfIqCjqRaZGtjUxFVw4Q2NPiRX3bzz35kSues//A==
X-Received: by 2002:a05:6808:490e:b0:3ec:d251:d758 with SMTP id 5614622812f47-3f19fc9e9e8mr13292209b6e.23.1737664023776;
        Thu, 23 Jan 2025 12:27:03 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f1f08c2f03sm58176b6e.30.2025.01.23.12.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 12:27:02 -0800 (PST)
Message-ID: <f27f9f63-32d3-4e90-9e12-2f893198f02e@broadcom.com>
Date: Thu, 23 Jan 2025 12:27:00 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/33] cpufreq: brcmstb: Stop setting common freq
 attributes
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Markus Mayer <mmayer@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1737631669.git.viresh.kumar@linaro.org>
 <3e6d8f8ac58727a8ca4d2a57fd90600618085936.1737631669.git.viresh.kumar@linaro.org>
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
In-Reply-To: <3e6d8f8ac58727a8ca4d2a57fd90600618085936.1737631669.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/25 03:35, Viresh Kumar wrote:
> The cpufreq core handles this now, the driver can skip setting it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


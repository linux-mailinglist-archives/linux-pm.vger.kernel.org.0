Return-Path: <linux-pm+bounces-20897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1252EA1AB64
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 21:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA8E1671AE
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 20:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB45D1D416B;
	Thu, 23 Jan 2025 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UM0OyFCe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B81D4609
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737664035; cv=none; b=WAwE1BFYg41OneL+/IqY+JD7po0bR1o6jUmXAynxyWNoN5oL6eHtF+uebBv4uzD6p25gRPBeQ4su0oWORjR9FlpSyxJ5MOcP/ZVKX9iqpvo9Rfu+6cmT4eymUjcf0wpUm78Ndkgi67cdYqU73m4te3wArZkBerhiKsf9YembVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737664035; c=relaxed/simple;
	bh=V6E8gLiCWouBWR4ci/EbNwVU5FSgGhcYnW9p7swTiIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BO/JPMx6nqaoberOYiuNWLeY7nbTRqzjJwDUDCeODwrvdZNlJ1wY4I8dtvBVSPC7oMjcC4laCwUFXUpPI+8J6REaEsPYUfP85Gu3c6Sw4R7fgkwAs0yGeYc2WtHdb07P5zxMa9dEEa/2+9AgiTbOwy0xP6cnYrQAQAUsF/W7/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UM0OyFCe; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71e157a79c8so366324a34.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 12:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737664033; x=1738268833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=odZIk9jV3ObCbvf4cr97WGjVy0OltAEzFbnKC9/mtww=;
        b=UM0OyFCeaXVqbW3qXrKD4IJftXPuq+veodqYPDT1LNw+CmgYl+GMW150dBrKt/XQKg
         sEW/G/5/jLTVUDX6pWdOZb6Q1YKueF12f+1zGNVJDGez6wHYphqmAayIAZCwIhWD/Qau
         ZBNdh6E22+sy4VIU49/BgrgpyQP5k+KE0i8tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737664033; x=1738268833;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odZIk9jV3ObCbvf4cr97WGjVy0OltAEzFbnKC9/mtww=;
        b=BLn5yD+ZltyNYIKK8CdwbnRDjxqzwHhdpVsWoJnWsKqg56GJcbcnPbxRF+oJ4e2BBw
         ByS+tqJRI37a+Yaod8/jvpwvCu9PRjvC2BWMEJfCpTn4rdwsdB75oJvJi1uyZJz5TFK5
         kXVEZGaktHsumbhy2PZ53P18a57Ln648cKxcHo1uKXbl2oKvDMudljozw8TcHtBWptsw
         6N5ddriCf345wSbl4M8T2jbEOsZmamWzgWt8v8c3t/eR9xmvezuI2stllJL399bxZJm7
         3zMr/rcgkdmrD/ovzLg543yiugpVP29VMp68XhHJjKrBtWJmLGbq5yjE6BCSg9QW9e0v
         75RA==
X-Gm-Message-State: AOJu0YyVnslivff5UgaeYgwq9umieENjqTMl7MaBFNJL2CbedsqNpBd9
	ApQ+QaLeaVUnd6KKo8wQkevi8gBTnTKBg+rxdQlQe4NPBcUelNR+uYW9J01E2w==
X-Gm-Gg: ASbGncuoFU1huaMjIHBhH2HqfR2Q9moL0yBQY50AYG2HYBCL7T8UBoyLSLF9UpmZlV3
	jsFAGv4XMzjccCXQdbQhVvENWUGWJbHni9AoJa1TWaI1G7trkVcBGXwBuFeSutE5ZFR+XG2hQ/4
	BqVzSLRfPOiVvwA5MLLhXzbpMrUmfDBdRblkTMy08puMqTasJY0Fqxh5g2auaewuMkC72jJutgp
	m2mAHXd2lyfKKTS3B7guRlFMd0lRq8RP7UUyIcqC9p7PlG8n/IVzN5NN90Fv+riVdnM27MTjh2o
	lYaEpV1ftfh6SyJ55Ph4jg6CyF8D2PByBZk9U9CLSbyW
X-Google-Smtp-Source: AGHT+IFheVh9FvpO7lW5Y1VjYNE+SEdSXEFtdJomr+9MJiafxNidR/dijCNRK/gIustMM2Qjv33c2w==
X-Received: by 2002:a05:6830:6e02:b0:710:ea11:3d35 with SMTP id 46e09a7af769-7249da8fc59mr19955057a34.15.1737664033007;
        Thu, 23 Jan 2025 12:27:13 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fa8b528e7asm38879eaf.5.2025.01.23.12.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 12:27:12 -0800 (PST)
Message-ID: <4c1b6a28-7568-4a22-a6ae-42ae5005a99a@broadcom.com>
Date: Thu, 23 Jan 2025 12:27:10 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/33] cpufreq: bmips: Stop setting cpufreq_driver->attr
 field
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Markus Mayer <mmayer@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 linux-kernel@vger.kernel.org
References: <cover.1737631669.git.viresh.kumar@linaro.org>
 <b88de39b31fdb69f8b49bd4b7d5364a356ad58e0.1737631669.git.viresh.kumar@linaro.org>
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
In-Reply-To: <b88de39b31fdb69f8b49bd4b7d5364a356ad58e0.1737631669.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/25 03:35, Viresh Kumar wrote:
> The cpufreq core handles this for basic attributes now, the driver can skip
> setting them.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


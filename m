Return-Path: <linux-pm+bounces-20057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CCAA049B2
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 19:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE73E1672DD
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 18:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79181F3D5D;
	Tue,  7 Jan 2025 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E+lxOYVk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF4132111
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276185; cv=none; b=r2wqivcNsuH/ldd1ksKyvDYx7dnJNCpt/fFq0S9Ouq6+2jSStR63GhPHc7ZOfnZaak10sTbDwKqBxUC+gQdDFshmvV9mvbiGxq4RXtyo+UXOVTLXoEtx3+zFjYaZ3kQ99j7ZnTdi/yLPSMjZe8Ll1E0HwwLfikZOv9Ba6EnFH/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276185; c=relaxed/simple;
	bh=G/SU4bp2x56Sxa/eCNhqCvE+be6KG3bHDAKazxJy6Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FNWXdaT3pHIkT2CF9n1RvaS+S51GKlF1rdOeSsl1YDAcss1Bb5WPR6ULndP59fk2wTmU+IFsLw2pfDGhDdS9K3dpkq05Nqizmgt0ggsxQ9z+o5/ot9S1n8j8mK9XSiGAmaCToGG9VXsdUki8NrU9AYZafXGgJNSrvk0bRXXkcig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E+lxOYVk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21631789fcdso1023055ad.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 10:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736276181; x=1736880981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MuI9OKu5AbgNWjiYCDCw9aSk7M/oM+ljzdpHRQ6j6TM=;
        b=E+lxOYVk5RjRC8szop+IaBDMSW9W0ayc8tfWhoxY6B3ktH+NPXpFQsB53cfbqk0fxN
         +PyvtBqsx3zDR7IzfaRno/q752d8cFFrmAXH/N9UI6faJtzNpL6ouvhu2WBEZ2zE8bE+
         qKody81gRYNMSTSqBMqj5ZwKAYwta/meCShx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736276181; x=1736880981;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MuI9OKu5AbgNWjiYCDCw9aSk7M/oM+ljzdpHRQ6j6TM=;
        b=ssJ8bBkNbOlVM53x6UEIerRueO2GBzmJ+txRdvv0g0gDr3fUy73GkJUH0GfO/ndZ23
         16HxYM3gN5T+ygo17MffpziZONOtoLDcHXo4cvLdRJ8xPpypKZHQSk7Cyj06uo1bXFQC
         gvE20jXREwYqldinxUEKCqUfMIUCXZjqZp2clJRNsmNGkfLtPZtxwoLwfCAcP5zFkun1
         CLUVDUSiPqogQyEAtiOtgTgDAXpGvKpqy2aNu+3uSFvUmUUVuqsnBf784VtfC37XYapW
         W52sTaPXc0HC3G1AQm0ei7qOGgoGkgdwjM3/IY4BObal2jIGGxRJc7tGs+c8Es3pn3cP
         YP0g==
X-Forwarded-Encrypted: i=1; AJvYcCX+glbyQ5bdiCwcHurBapQy9+XXRezy0VaggGiinza1Q6K29zluMbZXJzbA1gi1zipmpUFM4w1x3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3nS7ZXbF4aHsT8ybbq+Vyc6fCS+V59+lGubfl3EyvhmGlErZk
	Lhkr1grAZXnpjcO0j5dgsiC5/cqwPocDm/Sx9+75U/SdDXAkR6MLR37sszZFhg==
X-Gm-Gg: ASbGncs1B74Hy+xx5tfX1fa+oj4jPnwyG0oEV+hw15ELTyIg3yEU9pGPmZLu+mzpY7w
	w8LfuODFDBdF4jKFA9iXFBz+cUmqhKNxL/xp7qB19AXbgst7+2LR4m2IyNz+ITMkQPBU7oGwGL2
	8AaBR0uthRJX+8NCiHm6v+Zm9asf0VHL4diDvnzAmoY3ggC78v1sKt7twmGlQXJfNLfmUQqZQrs
	oCm0dcajxeBnLdsmG2w4+raNlpKPytbzdFHkt3eeVQ0uBEeSNifbNJR0nlSXia+Q5jZwCke55GU
	oFNu4wCbf/B5Gw3Mdg8U
X-Google-Smtp-Source: AGHT+IEcsV3ag9uYql8R4kx/TLhOFafGiqdNh9OlCOn8C6c/mc5CiisMAIzzz8bJpp8U3g0al8fpBQ==
X-Received: by 2002:a05:6a20:3948:b0:1e0:d5be:bf75 with SMTP id adf61e73a8af0-1e88d2fc6b3mr288060637.17.1736276181077;
        Tue, 07 Jan 2025 10:56:21 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbb09sm34635754b3a.121.2025.01.07.10.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 10:56:20 -0800 (PST)
Message-ID: <3b55d23b-aa37-4187-9649-aef663ee1de8@broadcom.com>
Date: Tue, 7 Jan 2025 10:56:19 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: Makefile: Fix cross compilation
To: Shuah Khan <skhan@linuxfoundation.org>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, Peng Fan <peng.fan@nxp.com>,
 "open list:CPU POWER MONITORING SUBSYSTEM" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241129012006.3068626-1-peng.fan@oss.nxp.com>
 <ae5eba41-e2ae-48c4-b25d-daece4d329ca@broadcom.com>
 <16615e97-268e-4daf-a991-6cad7803ac16@linuxfoundation.org>
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
In-Reply-To: <16615e97-268e-4daf-a991-6cad7803ac16@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/24 16:58, Shuah Khan wrote:
> On 12/2/24 10:12, Florian Fainelli wrote:
>> On 11/28/24 17:20, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> After commit f79473ed9220 ("pm: cpupower: Makefile: Allow overriding
>>> cross-compiling env params") we would fail to cross compile cpupower in
>>> buildroot which uses the recipe at [1] where only the CROSS variable is
>>> being set.
>>>
>>> The issue here is the use of the lazy evaluation for all variables: CC,
>>> LD, AR, STRIP, RANLIB, rather than just CROSS.
>>>
>>> [1]:
>>> https://git.buildroot.net/buildroot/tree/package/linux-tools/linux- 
>>> tool-cpupower.mk.in
>>>
>>> Fixes: f79473ed9220 ("pm: cpupower: Makefile: Allow overriding cross- 
>>> compiling env params")
>>> Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>> Closes: https://lore.kernel.org/all/2bbabd2c-24ef-493c- 
>>> a199-594e5dada3da@broadcom.com/
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>
>> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>
>> Thanks!
> 
> Thank you. Applied to linux-cpupower for my next full request to
> Rafael.

Since this is a bug fix, any chance you can fast track that change so we 
can keep on building that tool in various environments?

Thanks
-- 
Florian


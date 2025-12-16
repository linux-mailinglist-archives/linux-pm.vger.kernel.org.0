Return-Path: <linux-pm+bounces-39640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E381BCC5897
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 00:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 671D1300F5AF
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 23:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7338033B6EC;
	Tue, 16 Dec 2025 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Kh8xx3dZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E169F330B07
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765929551; cv=none; b=g/mFamDpTn4HCG9C2OX4iS9ErJBNBViRec8Sgz7unhxfDCVl/p8HvaxKirwmrBe3yvJTSmuXQA/dIWlIqqC5QkvgQyn0MHcr0VM7g++b1+MpPBEZBhrdrV77nuhupzp036eoPH7Z7bhpRq9b7C9ulifQhl06cJ8KvXuyqyP0B3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765929551; c=relaxed/simple;
	bh=fMC9tJLieTLmzlyQGBrGXMnjFZX4/ci0YgAXNKGc7eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OY4XOGX17A6H/JfQNzoFIbE0UM7RPJR+5UWa8wxM/hqX6LqvjteHyz59+IvefIGDoR72oz6hXqNa0wf3VYB4zW18Q3jqXBRH7QMkFROCMVJIFzIBwiQOowBqpqU7uco/Kfi14stUMVksvE8EKwT7vFKU9hbVF6Z16fkq10XflO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Kh8xx3dZ; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7c7533dbd87so4450677a34.2
        for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 15:59:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765929549; x=1766534349;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qTR8sWzuQg6qCv7sqYnowcXeRDt8t5dlxcGqTpMBq4g=;
        b=nhuuq+LxA1347rM4cx+Y41TI4+tSt7uMCwO5ULtk110CBPnJ/T8KN1Li2hSYNnSGrt
         cqOwO0G3Iz59Uvcn4ImKhqLrXimxb1UhbmgoEJISSm64Uz8Zx1rHZDbK7xLjV2W0jz/u
         NHMXzlGJa1ojH3oYhAqDM1btZCVm9LdRHMAMZ1ayRI3jjKtKYPNHk2DPLE9Di7gSSDfp
         BxKyjZeqyPgKuZi1paIhb1sz/oB6TQTX5JxFqe5Qr/UwawoiO4O4gmM5r6KJfiBizgZ9
         UmGt0OQ7ebqNDmGHfbSc+RUeBj85Hr92rGog4B8O/qLj7uUgllLrlJynmEu8vPoL12dZ
         RB2A==
X-Forwarded-Encrypted: i=1; AJvYcCVOt9R78cf/ue3iBC+OP1YvPIziTUJ3PcpJAuU2TXfum3k2gJWK3mCKZprrbGE95h9YFQHUTKxqTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ohJxOY82iZ6Qa+OpXBa3KkeYfJwPrOpdF9Hz6V4Vsz0XYqbe
	EXJ1xpdZMNbJV2Ky/3B7WU2YOWJzwhQfe3Qkm3u42ecZcRTQ/u/02DxoK2/FIm2m4mi1f/ZjZ3I
	UbkSWVzRW3rv40SdVWtxPZCUKQMqj5+VO0mwXVeg0f74RCLHcTf8AobpFckW+c+Ntza3u+e0eTL
	6QIS9NPm6DoliNPNEFddQBlw0G7jeNIyZH2Zs9KCnmIj4xX9xbcWQ+o2/gDuTXeiO5saOri1Yq1
	NxjqSSfqLo4irGFilg=
X-Gm-Gg: AY/fxX5ejQmeNzznCDZckTl9BhxKPkHkJsOpKf/i7VlN9LMlpf8ljKcWcPZmhx3vYSK
	6pwhMXkgDCGlXIG971ACVOU1SyGjw3G26hEPkioU3HpgEX0YbgIlV96gEj3u6tN7e1XPX3SZOb7
	nXC/Qp3BKuLZGCXGUL+SnOpzMGUNE2T7HqWQzcMa9equOcQv0ZSoqpeVPmgbkB13C22y/eiIBpB
	EBmrJys+h6O2mPOXxPp6rLhpNOiFZpABNe9U1RYE4rpPM8efWBRY+LNwpd2J42/CcvhAgxNzjRQ
	gv/b0bd0QI+0H+YsqJd0Gz6i9OA7IPQoDgjN5Nz3ofqoE1zG56WZs1Es12gIlrc+fJ6IJ3Y27Oa
	V/Tg1sd8Kq9XIiDLpAu7bdXXMQ3AlLJoaKnzh1ag/6UBBZfHB5dnxKjWbAuB1Pfe6bH0tlI9aC1
	9pRXmCBGfhWqZIaIEPEof1XI4IdF5fVzUZr6NL0bnUIoRk9Nk=
X-Google-Smtp-Source: AGHT+IHoQZ9/DKQjvjXJk0q3yTaLU2zS5gRopQBtmM0WjE7bdtN/+c7FpezhSr4DywyPsmPW7GaGcNfBlu8j
X-Received: by 2002:a05:6830:7194:b0:7a0:239:809f with SMTP id 46e09a7af769-7cae82e98b3mr10732154a34.11.1765929548720;
        Tue, 16 Dec 2025 15:59:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7cadb2d0063sm2878252a34.4.2025.12.16.15.59.08
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Dec 2025 15:59:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0d43fcb2fso103413805ad.3
        for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 15:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1765929547; x=1766534347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qTR8sWzuQg6qCv7sqYnowcXeRDt8t5dlxcGqTpMBq4g=;
        b=Kh8xx3dZv6IE4R+s0duzkfMNblwZg+sjy8uNf1SyCsdEWPtH3Y3kVZnT0X9I9g5YTC
         zm0tb7n6cPQaduGArswh2BwY9xY5BSmaZGZojAQIAZcw3WF3hDXUnCwy6mLLdxcqcmFa
         iloy5SDTQW0/ICBLmoOKrLrIgl0eGaxc4hgGM=
X-Forwarded-Encrypted: i=1; AJvYcCX2d2j6n+TLnmlXxQWJeqAVMByA+/HrChovC++oyZJtR27tpunJ6p0lzZcDH5/0uxC8wsTKLXmI8A==@vger.kernel.org
X-Received: by 2002:a05:7022:ed05:b0:11d:f440:b743 with SMTP id a92af1059eb24-11f34ac5471mr8397454c88.7.1765929547277;
        Tue, 16 Dec 2025 15:59:07 -0800 (PST)
X-Received: by 2002:a05:7022:ed05:b0:11d:f440:b743 with SMTP id a92af1059eb24-11f34ac5471mr8397441c88.7.1765929546752;
        Tue, 16 Dec 2025 15:59:06 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb28dsm58042465c88.2.2025.12.16.15.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 15:59:06 -0800 (PST)
Message-ID: <351d9321-e5e9-43cd-bd74-68aef80aa177@broadcom.com>
Date: Tue, 16 Dec 2025 15:59:04 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: broadcom: bcm2712: Add watchdog DT
 node
To: Stanimir Varbanov <svarbanov@suse.de>,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Lee Jones <lee@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Willow Cunningham <willow.e.cunningham@gmail.com>,
 Stefan Wahren <wahrenst@gmx.net>, Saenz Julienne <nsaenz@kernel.org>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20251031183309.1163384-1-svarbanov@suse.de>
 <20251031183309.1163384-5-svarbanov@suse.de>
 <20251105165553.3910996-1-florian.fainelli@broadcom.com>
 <189702e0-e6f0-44c5-bed6-eef058d90b76@suse.de>
Content-Language: en-US, fr-FR
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
In-Reply-To: <189702e0-e6f0-44c5-bed6-eef058d90b76@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 12/16/25 05:00, Stanimir Varbanov wrote:
> Hi Florian,
> 
> On 11/5/25 6:55 PM, Florian Fainelli wrote:
>> From: Florian Fainelli <f.fainelli@gmail.com>
>>
>> On Fri, 31 Oct 2025 20:33:09 +0200, Stanimir Varbanov <svarbanov@suse.de> wrote:
>>> Add watchdog device-tree node for bcm2712 SoC.
>>>
>>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>>> ---
>>
>> Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
> 
> For some reason this is not part of v6.19-rc1.

I did not send out the pull request, sorry about that. Let's see if the 
SoC maintainers can still take it, if not that will be v6.20 material.
-- 
Florian


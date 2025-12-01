Return-Path: <linux-pm+bounces-38941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C034CC95803
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 02:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6980C4E03D5
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 01:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0BC26AC3;
	Mon,  1 Dec 2025 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G6GB+YJj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DDA72622
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 01:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764552727; cv=none; b=DPZd+NHfoJ/CcDX/FzgDaoPulncYOHu+UjNiQGhW1jUz3QO3ZeZbrlz2gychWCQ9xCOfts+eBdSCL8+Inq/M3rnvYv7pr0TqPqlV9ZWBjWZfj+1YWN9R8FUTnTEOvoVAtMkcSZb0zbLzOjwdjPKoCNZ7Jy4gfvbiA4TqyEdI09Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764552727; c=relaxed/simple;
	bh=1npw0Zx/TeNAYmFV4g4tjfnbahOBmW1mqQpGk7tIjSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNgP5z0EGSfIZ6ESxRgyWeDlq19bCqppzv4EuK1gJH3d5PLUVj23DDGqFwvmr6v4qBLHKgKKfM4NiZNYVWud9dd/PzxMa+Q6+8EzgEGjCx2/+hCycvXw9kkGmeNdo6kFjcZrgH2MMWpi0GgX5qRnwbQe4XGAJe2yVOsC+hp7Va8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G6GB+YJj; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-29ba9249e9dso40735675ad.3
        for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 17:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764552725; x=1765157525;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=83BoxqtEa9VPOLHGoNG7qoF5Uy8DWXOM1R/kh4ik3Hc=;
        b=ID+LsAMiIHsNk6kgFi/11/Slu037WLo694uOxBna3lHN5BI6b4IaJ0bOfNGfc3FIFK
         0Nm3MVv8amtKS0NGGVE2XsmDx/bqwms8rIKsU/uwAVihEIhMCxKcfdC13p+KR3ZSueY4
         XPXHJvE08MUiBp5GEO/YIY9Uy3IOu1w6KW2WomjCbddqplPycMwAvogPy51qE5tPqBSG
         TSbSHdwMjd22XPrQz1HDMUbTs9bCEhyIFCsimBTwT/paS8gBRRKsVYhwpksKbRzaD80X
         likV7SwrfNI7NRaBejoi2su7+sMtXikEKV5uUkOoOFBBTvifNSFusyNzE+tDqakwbGvm
         c8oQ==
X-Gm-Message-State: AOJu0Yxw6+kM5RiJGWnYVnuLzdbMJlt9V+x72NIN+8cJwcxkWj1GOFv5
	3ly6cOYxSzyf2P5Z3gpabefJEN5tBXexUNNU4d7a50qALvVafH9nLKYNXbDVF5mNLwox7PfTsaW
	2obi6idHVjv8n4xngXuCAho450YQR48EiTVjfjIpV+zftFkzTZT+melxkM86w4//9Twr2p3MSQS
	1/Wpa1WXp6gew3wKetg0BIMzpnoZjGD9VFQp5Tp3DAzc26DwK75zSfJzTsJP0s8NQvl6cVJJOEA
	ZnwxoZCrQKgZD3NGCA=
X-Gm-Gg: ASbGncsZ3kK755CeCPwDHAfldTOv+GbRtLsPTNO1MfEZEnyuum4MLxwWuduJuaVn8sa
	hMNNRNEm/SWPoe63ceZ0/FBVzthWCM/DJGZ+POpdWwr/s1A679kQkdrkws6eCfoVwITXkcewkbn
	L3SAYxrX4eiYatb4Xmuttm9V27HcWrfp6h7tKNarGzvU8uHu9i1lrxaw+RgeyFMbQmxcY1A+c97
	X81ch1WrQ2dabtI1EIs1WZ3lPvsReOxeFxF/TmsxcUq6nES8jO8OZ9nHXB94gogoq1yhObzaHlw
	gZDv8vAXRtV/kyNz0e81DnY7SVuiHAjireJ4+Aww0XIKNwx3+zSfhYV9IrbjtVnERgIOZhatyVC
	Rsh4nRG6q3lCe+HUQBS2rHj8yGYQBsiXeU9n5A+PDai+1nSPZZztVAu7OlMbek+M3njPLI5H9KY
	8nG2gNNt8VPeIuYx05RD3jILnWC9Jymd0kuMsN8dzX6MzvOcu4DnvM
X-Google-Smtp-Source: AGHT+IFJL1Frs/0IrrVVhw1/wKDNHqoKZqbsmZuPTrb4nI+WmIUfrcrCzcJC5KxqQJGusKtq4drbDRbddwkJ
X-Received: by 2002:a17:902:e5c8:b0:295:987d:f7ff with SMTP id d9443c01a7336-29b6c6925c1mr434329105ad.42.1764552725369;
        Sun, 30 Nov 2025 17:32:05 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29bce453e6fsm14314445ad.23.2025.11.30.17.32.04
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2025 17:32:05 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-bc2dd93f7a4so5394480a12.2
        for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 17:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764552723; x=1765157523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=83BoxqtEa9VPOLHGoNG7qoF5Uy8DWXOM1R/kh4ik3Hc=;
        b=G6GB+YJjXBysms0W3GyrrrKwqEZJmRSwkR2dUje1iMD4H73gvWzs1RqNgvPAxRqEF7
         MugtNlCRfxcla/PZMIp5Ffc1sndiqboLK28pVuy/PP4948u2ySOa2L9tnnRcI46ijUf5
         JFr7jOSOWovOpbVeLpfMWQRpXJWXeCmdIvEZY=
X-Received: by 2002:a05:7022:2082:b0:119:e569:f27d with SMTP id a92af1059eb24-11c9d8659abmr17756539c88.38.1764552723536;
        Sun, 30 Nov 2025 17:32:03 -0800 (PST)
X-Received: by 2002:a05:7022:2082:b0:119:e569:f27d with SMTP id a92af1059eb24-11c9d8659abmr17756520c88.38.1764552722976;
        Sun, 30 Nov 2025 17:32:02 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb03c232sm52303449c88.6.2025.11.30.17.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 17:32:02 -0800 (PST)
Message-ID: <a6de72ce-3dc0-4259-b0d7-6cf385031fc9@broadcom.com>
Date: Sun, 30 Nov 2025 17:32:00 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/brcmstb_thermal: Use max to simplify
 brcmstb_get_temp
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Markus Mayer <mmayer@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251130225459.46241-1-thorsten.blum@linux.dev>
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
In-Reply-To: <20251130225459.46241-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/30/2025 2:54 PM, Thorsten Blum wrote:
> Use max() to simplify brcmstb_get_temp() and improve its readability.
> Since avs_tmon_code_to_temp() returns an int, change the data type of
> the local variable 't' from long to int.  No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

-- 
Florian



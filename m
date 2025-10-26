Return-Path: <linux-pm+bounces-36857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3205DC0B2DE
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 21:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492103B9DEC
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 20:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBD42FFDCC;
	Sun, 26 Oct 2025 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LorHSvIc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D552FDC3F
	for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510108; cv=none; b=kOVmMBPPRz0CWUFi0tWg3MddY0BpdmCB/JYjXD+y+LsjKah2Bd1RSyvqjRvJxb8fYtCIUYxF6bX+u713KPlx0h7++CpdXM2QzvrhSC39lJhUp3bUHq1zAiW7jX/d7vuEm+nE5dMWrfoyQGoPNrkC/NJRdnbBUv3WBF2z0cZ/vk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510108; c=relaxed/simple;
	bh=4tSahBmQN6jMzP2JQ5nDoVOyrZcYN3xAPDSgMy6+xo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zsx14z4GOpX4BWlt94eMAEiTl14BBPy1LL+tCT5dDK8rJEmittHVL8RlkjkhGXd5x76QaAf9ORLDmEVM2bLPAle+1SZfbMD0t0Wmk0yJttUBiEwRkX7UFApVLdXLN8KQ0KusudN9xqBfcaQOkFQlVmJYXCYAOE5E+A6OG+P6ziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LorHSvIc; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-9459db1337cso136184139f.0
        for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 13:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510106; x=1762114906;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVS6LiUU36AQl8NmfGBhHoZlr4o5V+sFm0sfdWcZXDg=;
        b=qadGtHWHy0mUo95QlENMNQ9k2tj6Kik+zrAkpYYIxmsnoc+BBGAIfUTb9PnW2tcLTA
         AM664AEjhdHSu8+ktMfOJi/+8nteOmWqhhlY8BLjcFI7wRMImJ/QxWoN3gpvKrf7Y8eg
         JKURdTsnCMpfv0KApcNGaeARLeikHcaw0DWmIAsGVyjIrTMpwCU5wlO71WY4j0zXcFAR
         hom/aNGsKXIrlxQCQQePQOsMdi2KAX4jlF4+6cYybhbsNafQGsQF+QMZ7/1+XOILgxmG
         CfxlhKdXrLs9pc438UIdASa/wASeJwzBGJAD/R1eFSL6OhejhQsbHwom25jol6xXi9gN
         eDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl5Gu3bzu0g8EcvOABPkdCvIRzKUuwwK6tHf9xXWXKvcTmFP30KJCTtQCKtVy8NKXZ4lio9pMKDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDbqUKh/9V47FESCRTNH/yv7SOq2CcMDNwdVvWuLSuWSMQiJLJ
	5hCR4AKRJK1DS2PrpbLWd7o9SCg6OY5p54wx5xF9CjdeI86mcPSfSXbp1Q57OTPHphUsXZgfEmN
	HM2hFqFYqMvrMIOlIRSjLLHZ8dNPFaRNUMV9SDXIDfgECSxYLTStP21u1+yibSm8hK2yr6TMOWx
	bArUPaRdW4DOuSVu1xcxPWD/uot6Odjx20lCqUU9eHHl141DDnitJEtNws82Ky5awEYiCkKX+Rq
	2Z0SHFMh9BFXiR4f3Q=
X-Gm-Gg: ASbGncsktZ6kXZy5tP1H+V/yM0it+e1kA3mZ5GnU56OWcWY1HB1iLQam1G1dLNVSmaz
	Lw9iwY6/L5lGM9G7ns3gbGYgKtaqCrBAqQCNnNdiABaNiNRHQCAOrHk04bvNCfIbSuxJkeElKXp
	8u5dNr/8RxkcRdXRAMx1m4h/jfLyZpwf/UfzLQ+Enb5sAOtHmxc+O2iis1rQHJAmo5zrpc01XQe
	NSewZ65YOOOl6OZOUT77fz7MOWrq8JiFuRH9Cxo4KSA4z+lzskn5BA6pkNfmlfPlFTF5RJyaRYb
	9HC7r2+kX3L0PBbbr8jrvCkSoZO4/WbP95jQxrKFRiyl42WIc8O1jkJ5HUcFTpbysT8mp3PP6iF
	bT2FxsqNtlq5bxNiot4uy/FW4cHrlzJw0vuO5xZWbKNzMv2dhjFTSxd7ctonmFGriL5HnF82DGX
	uHryTijjtTiAGdeFLAmt1oXWB+tzSxM+RUZvaANeEcHg==
X-Google-Smtp-Source: AGHT+IHN8G+0fjH3oG2QkSJ0YmsH3FquFJ1i0Luk6ZAAKUCu4AK1CkK/nW9PEhpJHwHOp0zfOpBFozD7nwDi
X-Received: by 2002:a05:6e02:268a:b0:430:ac49:b3b1 with SMTP id e9e14a558f8ab-431ebee1c2amr143793485ab.12.1761510106042;
        Sun, 26 Oct 2025 13:21:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-431f689a18fsm5332665ab.28.2025.10.26.13.21.45
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Oct 2025 13:21:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a43210187cso111284b3a.3
        for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761510104; x=1762114904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YVS6LiUU36AQl8NmfGBhHoZlr4o5V+sFm0sfdWcZXDg=;
        b=LorHSvIcioOq2Jr4Qudbto7UAIxpJQNsCO4fC7nPgIkZ5H79ludiB8lnuvuKfAaz9f
         /V565ASwK24BB4ATbK9JHJYy7I1wZ/Iqkv99lSCS+O2JqcUICJPAMzLQeKDwqpjdOXiA
         AVeXAX0MoLfrpKOX/y2NPI4LdLhLo6Z6iyArU=
X-Forwarded-Encrypted: i=1; AJvYcCWiIPLnDKTqal2kgn3/bVQ02PCOMKZ5NR68LvL7viuwV0uvJ6bfs9VO6w1yihqCyuZtSrmHG2+ypg==@vger.kernel.org
X-Received: by 2002:a05:6a20:734e:b0:341:2fea:6b5 with SMTP id adf61e73a8af0-3412fea07ffmr6653452637.20.1761510104268;
        Sun, 26 Oct 2025 13:21:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:734e:b0:341:2fea:6b5 with SMTP id adf61e73a8af0-3412fea07ffmr6653436637.20.1761510103855;
        Sun, 26 Oct 2025 13:21:43 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049290sm5593723b3a.34.2025.10.26.13.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 13:21:42 -0700 (PDT)
Message-ID: <88c3c5a1-1b51-4b08-8b01-803659e9b1a0@broadcom.com>
Date: Sun, 26 Oct 2025 13:21:31 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: broadcom: bcm2712: Add watchdog DT node
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-pm@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Lee Jones <lee@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Willow Cunningham <willow.e.cunningham@gmail.com>,
 Stefan Wahren <wahrenst@gmx.net>, Saenz Julienne <nsaenz@kernel.org>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250917063233.1270-1-svarbanov@suse.de>
 <20250917063233.1270-5-svarbanov@suse.de>
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
In-Reply-To: <20250917063233.1270-5-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/16/2025 11:32 PM, Stanimir Varbanov wrote:
> Add watchdog device-tree node for bcm2712 SoC.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
>   arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> index 0a9212d3106f..3094a8e69f35 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> @@ -243,6 +243,15 @@ uart10: serial@7d001000 {
>   			status = "disabled";
>   		};
>   
> +		pm: watchdog@7d200000 {
> +			compatible = "brcm,bcm2712-pm", "brcm,bcm2835-pm-wdt";
> +			reg = <0x7d200000 0x308>;

The register actually spans up to offset 0x600, so the register size 
would be 0x604 here.
-- 
Florian



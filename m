Return-Path: <linux-pm+bounces-42582-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIOaIPgljmlrAAEAu9opvQ
	(envelope-from <linux-pm+bounces-42582-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 20:11:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED44113096F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 20:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 589B23012237
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 19:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4333F27A92D;
	Thu, 12 Feb 2026 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VL6YV3K8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006322D4DC
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923510; cv=none; b=AqNOIh4uPKeS9X2oPP1cUMm5l5+tqXMWjMcn9JHY0pbc0XK58i15IyCpfZ7lcDNHAjeHR13GRHVsHD14jgJNZyr3z1tCv6bPAaOibjtN3pG+KLQRPcEcmQRyY1JPvfZCWZEzhIR0OenF6Ly+DA17GmzkkbHTvJfD419VBTUSxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923510; c=relaxed/simple;
	bh=yRSEhTRSlC3lMfpLjUObDruPwrD6/hzAFN5iYNmaHP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQshjQPdoaGxN1RX6cc4c8VEqRinvGyppjATdymMsP+bj2Dy1/Y3+ve6hJ6lj3an3ylTyhI4XeV7J4PKMKdJTpefTjgth/MhDIzCg8Hjnr4V27+8s/LkAMQCj73fYmXb5im655tq1xJKs63iSgbTenFVy2RmXXhErwQKiOuncbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VL6YV3K8; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-79639c2d2b5so2472587b3.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 11:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770923508; x=1771528308;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C5b0aMPiLLEIVy2NpaR3RVyx+gvUXOAAi7eEHMzx70I=;
        b=LAqRWPSQN9Ua4LtPnIJvonHUoMgnsIXkOv1IWJ0UA6wtPkknoi8nZZfdK13hf6vX0r
         vWp6HqPAPZr1cBVQifa8KdYNlUtNQE7084ZCdH9BByB/E1mr5Kp8wXrN0BPFKkn0iRJA
         mzKO69TnSAgIG7tJwgk9m5YyAGSEmGh1mmhm1KVWD3RmOXg95rBnClweTDvF+U9ThUPP
         kqS1h/Ew8VBtd0SDsCSRAV8DPfYc55zBwb8v9D1UESLlE83B6MaZhIqbHjk6N5GUd3UT
         Dn3ivAq8/XdiL5TCq6YAvNA+P4kw2AFlBsb+S7I62w2IR4pPdHf3zsuiJZM+l53BUuB7
         Nh4A==
X-Gm-Message-State: AOJu0Yy6hJL2hM1mol7S4zNFYqJrnE99eCW7xNy02D3ESwkD/uwuCdQa
	humwp8i8GVRlYRnkfJxO7UmXs+x3jdfwfp/ex2kqtRcAowgd5+AdKa5UYB77fA8PiZbCYGlWnl/
	LLeqjiPLmjwlVMqhdrZQhrmaqdWgtQSAjXToz7fkgmbFIvtdK4pROT8ijgaSphdP+b3GXTrB4/+
	9KTZDLZxEi2/Nuo4xmZ0smD7WOxQhK9VLGpCpGVQn0uwXYneKinw+/F0UYKaGbJh4tjv6l1LL73
	5AFWA61Dnteg5AyLmg=
X-Gm-Gg: AZuq6aJvpZCEJJoLfJJrMCKzERml0630wBKvWMIGeNebqASES6y+ObuHNaxXe/5+P4E
	RI131FBg/fCCHgbPELgsPLXRfkiu5czEX1FHIbRXOnejR/MaUZfeMt/umkaaFfeC/2Kc1K0gOda
	9LHsqY4Orj6oAF9E+GEMror5Jlttnmnu0Yra+ep0Z9UJdt4FMEexGbk6fDuEHBHu0YUghEGbRyU
	aRU4wahZy0lolOFSxEGXw8c7PgXsKtA55NlrBYuFGYDlN04dpRuMegh22WeVd56eIT6a6ONxCX2
	7knW387QPmjwMO27s//fud9vU0QeHmygwJwCufA6VdO8ljOkS6buLBPjh+FF0J659Kz8PXaJpV+
	8jAxfHpCTorGzOOIQ0lG3+sONCWbFiGfOFEYDyXWMEqJclLyQ8YQ5oBbXmRXYJ5Ldw2RZh+Piw1
	7BcwFdkRYmxdOtVKRZSaLfsQiE7GCM4lBLIj3rJzacGN58eonyvOsJS+7QPaGgTg==
X-Received: by 2002:a05:690c:fd1:b0:796:4b0c:1c9b with SMTP id 00721157ae682-7972f1075c8mr40657937b3.15.1770923507809;
        Thu, 12 Feb 2026 11:11:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-94.dlp.protect.broadcom.com. [144.49.247.94])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7966c25f565sm5283017b3.28.2026.02.12.11.11.47
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2026 11:11:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-896f8dd00beso6408436d6.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 11:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770923507; x=1771528307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C5b0aMPiLLEIVy2NpaR3RVyx+gvUXOAAi7eEHMzx70I=;
        b=VL6YV3K80Az6C3i8v0jdCnmdmuUAO3tEn0CTGclX6j8mrWkeTVVyM8CnSgpzxOp793
         +4DfY4EcVGFS6tgclEQhpk27ats6X0IDYqlP/m9VclvX7V/snPJm6kl6l19YcaDjXyLX
         Njpso7/TqVYRJHou77GWsUXdAUAKmhPuPArAQ=
X-Received: by 2002:a05:6214:411c:b0:896:fe42:e897 with SMTP id 6a1803df08f44-89734986099mr1217956d6.67.1770923507041;
        Thu, 12 Feb 2026 11:11:47 -0800 (PST)
X-Received: by 2002:a05:6214:411c:b0:896:fe42:e897 with SMTP id 6a1803df08f44-89734986099mr1217546d6.67.1770923506568;
        Thu, 12 Feb 2026 11:11:46 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc94dffsm43549986d6.14.2026.02.12.11.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 11:11:46 -0800 (PST)
Message-ID: <69ac37c3-c384-4592-b76a-507724727b19@broadcom.com>
Date: Thu, 12 Feb 2026 11:11:43 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: bcm: bcm2835-power: Fix broken reset status
 read
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel-dev@igalia.com
References: <20260212150039.67117-2-mcanal@igalia.com>
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
In-Reply-To: <20260212150039.67117-2-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-42582-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[igalia.com,linaro.org,broadcom.com,gmx.net];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ED44113096F
X-Rspamd-Action: no action

On 2/12/26 06:49, Maíra Canal wrote:
> bcm2835_reset_status() has a misplaced parenthesis on every PM_READ()
> call. Since PM_READ(reg) expands to readl(power->base + (reg)), the
> expression:
> 
>      PM_READ(PM_GRAFX & PM_V3DRSTN)
> 
> computes the bitwise AND of the register offset PM_GRAFX with the
> bitmask PM_V3DRSTN before using the result as a register offset, reading
> from the wrong MMIO address instead of the intended PM_GRAFX register.
> The same issue affects the PM_IMAGE cases.
> 
> Fix by moving the closing parenthesis so PM_READ() receives only the
> register offset, and the bitmask is applied to the value returned by
> the read.
> 
> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


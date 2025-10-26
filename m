Return-Path: <linux-pm+bounces-36855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4604C0B1D6
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 21:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5001C189AA25
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 20:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472AF2417C6;
	Sun, 26 Oct 2025 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="REjD8/MO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEEA1DB127
	for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761509877; cv=none; b=pXsjym9XclW5mEa4xTvvHU7aHxImCDNto1HvjC5wAH6Ok/h6LvY0E+9ZKCtqABmCW11N6I8bfz7ZorsoXi9qmdgbDyrKirRFS71p3YNwt+cdWjwp1CkiCf5k2/0ileOOwbmcy0H9P9uAMHd46To70ri/yB2gUDZhsYj58jI7bQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761509877; c=relaxed/simple;
	bh=SEXPVe7AZ3SQELbxEg1TJcZLqE8KhWcX1OtfFpd2nlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4I3QaqpE38z/2pVpF7DPGn9UscBUywdWA76BvpylsYwfwAnysPOa5EN/7CuolBwQvGUC6O8IA/AJ2wRB8kHJdZxINH/9HTDhLMOGpz/tjSb5WP9sfsSRSDTIpQUQJoohBL3RFk52SkyUfVwQpR7fXzr8mX8p1NnvRbHv+x/2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=REjD8/MO; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-940dbb1e343so235064539f.0
        for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 13:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761509875; x=1762114675;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J58LymEyd0eWh2BlEICOgBmMyqoMmGyghTiG80Pa5/o=;
        b=S6pB9yXqobYwG/1POOsz8H5KWoSieH3ZU6hw4C5IaIxBhEJFyoH3jnowUMKZErPmN3
         14ylDzKFfFNj4yMua7gFGB9/CjJG2WVilBcUeiIhgAjdEg+aVTtFst9Mvoml4illhOFE
         PyrlmX0l3huSJbQVQ5TlPuwjk62HnzydyQ8wVrlnVtC4dCjz0FD80gq+61R5ZiLjT74W
         BjJgC5HX5ISkOEq6s7thTNlS6D7z9P6eBjAPt7VtFSSqCv3ZFjoVdO1/37izAUUILC80
         rMHP/jmgD7EHndbGleCKbD39OWlj3G6O8Z5ey0UIWWojS0nevKjAFxhh97k51Er9LRvT
         14YA==
X-Forwarded-Encrypted: i=1; AJvYcCXHmiWvuWSpFrtg2Jq4KLIUFSg/ezFA6RGI4hTptWlnXr6/4MxlKLHyW9RA84axQqksBt9dD7UmXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXFz22DYi3MWyjXpAwrqTBuwAlIfOPqa0tMa+/A49uIMnmgH29
	Vn9ZyV28taUUIl3hNAcSln0NH3us+X1GnCRS/g4UwUUj2OC8dt9v0A3Nzbq8ttYVHEc5L66kXbQ
	TiCxiPOmMcWaUYABC8LjMUqcWnVVPctZWB6IB/rlTZvfJgMhUcJl87cDS+7VMjVY+86pRHGdJ2R
	tvtTLbyeIHxIZlwllaPR7/okOZuFRtSUKTahZa4+4kKDSd5Zd9ktAfHSYF2ctNGNeZ3pYbDScp7
	JwygzXXLJihEJDApEs=
X-Gm-Gg: ASbGnctuSi/T0xn3N9A5brplI6ezV3erBoqrRp9gYvT7p9VY3UiJjHWO1qlefVd0FGz
	tSZXfvysSOs5c49lrdKpiEd+jrRzi/Czmlw4Hn/w77XToSasvbPUWH9DKTcaqQeu15AJ2bppt1t
	toZ9wD/5/ggjeRXF3L1JIpJtmOEhzOUyPr1yKpEfA1EQ88kiD8W1sA6YHVGjXrspzRP0ZsBJr0d
	/yx5T9s/kFqGtnENgyCOO+KfeFi0MpNc8s8vSNJ6RA/8JPMinRbJAzqAcffT8WpBVfK0dzdFv2K
	CF8GNkD0KQAM99GcSR5fiKHGAED9bjIjjOFREj+wcFeAwMcgXdfLCWHWk9YvBpz05Haq3lQoZDt
	65GliYI7bbx2jGoQ1q+lrhc6g7ExQryIY4JAZekBFfLbf6Bw/Jmkc2VTvtMF7mT5S6hPjVaopxC
	VzetOMcHRxQX09tOVs6/U28q19Gch+RIvQiO9HdrA=
X-Google-Smtp-Source: AGHT+IEarfRKHDeo1ESOm9qJ7j2hYSev8UuMJQT2LtBGOANIAghkLfBmzb2MWVkZhWLdRZhzZFvbW9H1qUen
X-Received: by 2002:a05:6e02:3c85:b0:424:805a:be98 with SMTP id e9e14a558f8ab-431eb63e7bbmr115952975ab.9.1761509874945;
        Sun, 26 Oct 2025 13:17:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-431f808642asm4801175ab.21.2025.10.26.13.17.54
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Oct 2025 13:17:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33ba9047881so3885563a91.1
        for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 13:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761509873; x=1762114673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J58LymEyd0eWh2BlEICOgBmMyqoMmGyghTiG80Pa5/o=;
        b=REjD8/MOB1dIquucEYdsDKnTImHzokIktvUWxi/0DEYTslzQCVAmg3+9QbJI5paYP3
         +P961O4oKa/TXUVSlAcPAa+QSbDT+UW3ncA4kq4b3EeLtyPhv2RPebSRZQH7tDS0115a
         W0ehlleO3Nka1li291vsvZkXgFrb2PjknS+8k=
X-Forwarded-Encrypted: i=1; AJvYcCU2LXLTXsYFyUu9n3lTE+9WhxjIbRePqCWzjFXtv3ibTsI3LI7zJArZrxYZyv1El4q9bhlW+f71RQ==@vger.kernel.org
X-Received: by 2002:a17:90b:5490:b0:32d:e309:8d76 with SMTP id 98e67ed59e1d1-33fd3bbda7amr10674464a91.10.1761509872518;
        Sun, 26 Oct 2025 13:17:52 -0700 (PDT)
X-Received: by 2002:a17:90b:5490:b0:32d:e309:8d76 with SMTP id 98e67ed59e1d1-33fd3bbda7amr10674445a91.10.1761509872119;
        Sun, 26 Oct 2025 13:17:52 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81b40fsm5946267a91.16.2025.10.26.13.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 13:17:50 -0700 (PDT)
Message-ID: <8f2edb24-e5fa-4ef2-ac8d-609ceb454c33@broadcom.com>
Date: Sun, 26 Oct 2025 13:17:44 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: soc: bcm: Add bcm2712 compatible
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
 <20250917063233.1270-3-svarbanov@suse.de>
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
In-Reply-To: <20250917063233.1270-3-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/16/2025 11:32 PM, Stanimir Varbanov wrote:
> Add bcm2712-pm compatible and update the bindings to satisfy it's
> requirements. The PM hardware block inside bcm2712 lacks the "asb"
> and "rpivid_asb" register ranges and also does not has clocks, update
> the bindings accordingly.

s/does not has/does not have/

With Conor's feedback addressed:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



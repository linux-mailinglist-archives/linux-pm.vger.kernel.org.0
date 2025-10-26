Return-Path: <linux-pm+bounces-36858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5532FC0B2BD
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 21:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208FA188C129
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 20:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABBB3009C0;
	Sun, 26 Oct 2025 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X6QiNGDV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81372222C8
	for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510190; cv=none; b=pWJU3FzvtUv2PCRVPoJwU6gGxX7ZtOnHQVrJ80NDWbcvilwoLyc+JJkAhuoYjXs4+No0coQ2kZ8sphqlNuYuKTXdCG0lbhL51xBz7LnXuj2pXfJgPUPD1ViHKkAp4EB9qb6CmRDSVH12EaZozJiOA9Fn9PQMCtp//WV7pzYDdtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510190; c=relaxed/simple;
	bh=rRQ1+ntCz6compsldbj49MSoD9DCOxn7CudapH/7LFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGFk+VIn2LKPZoEh0hzWcVh2o+coFiOp8bYFmiDvDV3UbVucO9DRUeJtz6Vhc2yEgbyt7O8Z+Elsr/hLIfZiYvKb9Ve8vnsfI4stu0OIkhhrAkI7QsW80cgR6qHoiGKUA79XGlNH8lje2E7Q9i6tz2E1Qx0Iv0PRhIHfwS+0S8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X6QiNGDV; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2907948c1d2so40740415ad.3
        for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 13:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510188; x=1762114988;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tv4EJsASL1wPUSDcCCUa8FCSZ/HO6INTApnbMDnxMQ=;
        b=H98ub0FGAtNmFlWqgahqJi0p1JmjWlAGe2xs00/F90BrE0e7X6HukVfpBXI7QOnmsC
         BWEKbOeO0wUdNYDNtUKhu1GcIxO6WyMZZMogc/u6TT2uX1wI3yqe5k0z+kocbzPkrzF+
         NPOsU2kqENg4Ci4XRPs4nt1aZMGs2woRYP++QNGffpoPonjTPza72/cDw/FDKN3wq5BX
         LizqIcPNThohzliNu/n+HdJWEmecSwXuIe7bTg36Pmj6fAfmgkxDivsdhyTUEOXh18+m
         JfAZ0KfvYEMVWrv6yZrt3GknnZThehXFB0iyE4p9VygVXM/k2V2kfXZvUe2Fq4PD/klr
         Rong==
X-Forwarded-Encrypted: i=1; AJvYcCUAh+tnOPMSeqjmWFfi0sej2IKjkp5LOw6rCcJvk6zlOkEQSSemuYEqpkoN9GoZBxmJwyLg0hbAVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3cmMXVGwFuJqhZbJLPUDxZXep5aEu9i3ua0qa4aQq/fwJhIK
	0gv+k1vzFGLhOlkPfOMdWGGOycrRWw5V6bB3YW2XXXwwDW6r1jbiac3ABKE1i5yW2+itfvyRIq4
	abEG9LpGddIHAACGuGhRsdKSW3WdJHtib92PAZpZ/INoFyvWuueEPjlznQl98n07a6baID5qLdp
	SCv43VrpLWgegyMackqCEf/pTR3qYS8tjzp9eoD+w+z/zjgAzosomtUHKW2D02yu9t+CargyqnN
	w3bKIKUTz8AK43b8ro=
X-Gm-Gg: ASbGncvnLIYbVszUptXihCiMAiy71SJYgSaixwuYdlKq3s8GGaR0cPPyechQdNUwe/Z
	R+YAlNGzBULOBlHNm8aSSRdVrAlhSuJDcmowcd3qjr/H/axRTpJQy9VO67e47Yvzf4E+wQYPmkZ
	Dx0sOYPLdrcMc6qyuVWVc9qqa+eb0dc9BuzMYdMFlEbpxroi/9Ad9AB1PbtUn8kgGiClV4BIgrl
	u7rE4vUyUbAI2sjLZoAOeQUUV62YW2fb9kn0/wwOOT39D1tAlnshfnjtHp3Kr0XHj/9TpAdafL2
	8w+Al9Rbx6ZZcuARz3tYEvyx76BwS/XnAeKazEXWq9CcG7TNLHJFPzfCWzkfIHQ2w5+VR0Of/IT
	vCtHabcLrfRD6Z14QxSJTe+qQPoFELwCvYwm/uiirMfyaDgX1TfpLMjai7xhJli8=
X-Google-Smtp-Source: AGHT+IHx+FS+bLeQ6S/9omVQNB3UXXBz74fb7Fq2qT2jnaRb+Z4FmeVDzi5Jhl7oP+5Dghoul7eCI/emrDon
X-Received: by 2002:a17:902:c402:b0:290:52aa:7291 with SMTP id d9443c01a7336-2946e26e98emr160589885ad.53.1761510187794;
        Sun, 26 Oct 2025 13:23:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29498cf30c1sm5435195ad.2.2025.10.26.13.23.06
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Oct 2025 13:23:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eddb7e714so3281771a91.1
        for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 13:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761510185; x=1762114985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8tv4EJsASL1wPUSDcCCUa8FCSZ/HO6INTApnbMDnxMQ=;
        b=X6QiNGDVTXSUOgSPUyhv3vUrZ1N7+XRgy8mZ3cWxsnEL2M2STJXaZEBaJ70ktOnElw
         R5XQdzBuUndDXz186WtRBWykVcLiCP2qpjQGGct2ou0OcDiE3c6bBbOiHOlJZhM7hMDO
         5/Ec20eLbSpG3JBlUWEnFxxqJvswdE0uUppa8=
X-Forwarded-Encrypted: i=1; AJvYcCW/gKT2Pw5XER3Cw3/An7uFa2fsbSyNqCW1fpzkE2mlfYmJNRHEpCMjzm7t9EdQAmSC6XAFr0DCFQ==@vger.kernel.org
X-Received: by 2002:a17:90b:38c6:b0:33b:c853:2d95 with SMTP id 98e67ed59e1d1-33fafc8a042mr16326546a91.33.1761510185388;
        Sun, 26 Oct 2025 13:23:05 -0700 (PDT)
X-Received: by 2002:a17:90b:38c6:b0:33b:c853:2d95 with SMTP id 98e67ed59e1d1-33fafc8a042mr16326533a91.33.1761510185004;
        Sun, 26 Oct 2025 13:23:05 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm5951572a91.16.2025.10.26.13.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 13:23:03 -0700 (PDT)
Message-ID: <c379087c-1702-44b7-a890-beb5b77d794b@broadcom.com>
Date: Sun, 26 Oct 2025 13:22:57 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add watchdog support for bcm2712
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-pm@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Lee Jones <lee@kernel.org>,
 Willow Cunningham <willow.e.cunningham@gmail.com>,
 Stefan Wahren <wahrenst@gmx.net>, Saenz Julienne <nsaenz@kernel.org>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250917063233.1270-1-svarbanov@suse.de>
 <CAPDyKFpus05RAkYAoG7zjyvgAJiuXwRt3=z-JB5Kb7mo0AK4vw@mail.gmail.com>
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
In-Reply-To: <CAPDyKFpus05RAkYAoG7zjyvgAJiuXwRt3=z-JB5Kb7mo0AK4vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/13/2025 4:08 AM, Ulf Hansson wrote:
> On Wed, 17 Sept 2025 at 08:33, Stanimir Varbanov <svarbanov@suse.de> wrote:
>>
>> Hello,
>>
>> The following patch-set aims to:
>>
>>   * allow probe of bcm2835-wdt watchdog driver for bcm2712.
>>   * prepare bcm2835-power driver for enabling of v3d for bcm2712.
>>
>>   - patch 1/4 is preparing bcm2835-power driver to be able to
>> control GRAFX_V3D pm-domain. This is a prerequisite for the follow-up
>> patch-set which will add a v3d DT node for bcm2712 (RPi5).
>>
>>   - patches 2/4 and 3/4 are adding bcm2712-pm compatible in MFD driver
>> and update the dt-bindings accordingly.
>>
>>   - patch 4/4 is adding a watchdog DT node for bcm2712.
>>
>> Comments are welcome!
> 
> This looks good to me!

How do you want to proceed with merging those patches? I would assume 
you would take patches 1-3 and I would take patch 4.

Thanks!
-- 
Florian



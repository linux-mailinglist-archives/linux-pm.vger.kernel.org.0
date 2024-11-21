Return-Path: <linux-pm+bounces-17840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC789D46E9
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 05:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35E3B227B0
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 04:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0295512DD88;
	Thu, 21 Nov 2024 04:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X2PN88gH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF874068
	for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 04:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732164120; cv=none; b=AKVjIsFhkVitjJoSJO8HD3t/ookxlG+cZk0eRI22mcTVU7rRvHiQl0mPJzhJd6j9BRLM1GqlKYgQDwn1Cv26AX23THccL97iqxXdQWwzg9zFM6VvjdNsOkkBE33QJF1TKfsuu3uW1wbSk0JE15M8KiyQUQqWqMmPPbUxnP1pvOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732164120; c=relaxed/simple;
	bh=p/0sB4AX+918152esN9qd1d1vnZqLro+1Gq282jmrhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+MNRip+xRkL6Jb9TD4HAQdHFnt5TTbWtc5/8xNHqwjoJUe9CLhwbK5X0VEVu5J/khHzrBU8kX4XJtkTTNnPKtrsTFGbhpu1sqWJlH+Rr9bvisqIcRxfTRuwyfEJ0CwrQiG5vQozh5UUG/trlvNRRsR4G40fjOM6Lref7JO/izY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X2PN88gH; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e6005781c0so314793b6e.3
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2024 20:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732164118; x=1732768918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nfHqocenXF6LMdPk6riaCyrcgPERHktgeXrCbdq/tcA=;
        b=X2PN88gHQCs5/bFbVk9BsdTded5UQvXIW51QTGPmwJhpy3LVpXQ7ep3/rKrml+gud+
         PhA6lkvmgHAmeJYHIT6VBbpXOR83sNWfmV5U3zSrubfLo6AK9NUVFPMrt0JTRkVLEuSF
         7TLZxXQFWNxRDCD9GLmKpbqDQXsYDRwo/wPWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732164118; x=1732768918;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfHqocenXF6LMdPk6riaCyrcgPERHktgeXrCbdq/tcA=;
        b=HmkLLNTNdhYG/Th282f8TC+mSz0gwK8VG8qWYgPXAIfZE8w6CuwnO6RxTRFjh91nxa
         YBUI/KrDBqMk5lagc8SGSno7v+gli5QXOAyCUBh5LHCcJN5Dx2NfbSkoZKZqdP23N7Tw
         G6E/1p3BL+7mV5y61fRXqQozovXaSDkoY20cWtxQcojlcRJwLH++1oufWTwRQrZalj1b
         vn/2FkemhL/YoBLO9HH4ZewVddhm5g3J6wBOr2G6v7fMlkpM2MuGbuNlRj/tc1fd2RhR
         WILs+zl05TnZbAWcjJ4WIfNgFGXK/6Gvyib44NAWHVhwJthWzVFKLHbhHSdsfO2zq7wG
         u0pg==
X-Gm-Message-State: AOJu0YybLYAmQsZPXpMFZ0Y2beSBOXf07IND4mW/ODsfRqV+zKJCYMHr
	GReKalclc+Pp6Loyap4cnXI13LLA0LiLhC/ihDOQ3fk1qXqR3s1jHwejOcPVyA==
X-Google-Smtp-Source: AGHT+IHzFpWm/WA2fgtqA0mNI3iM41GQPoF9TLOW6Y7VEyA6nW0P/rRQ3svpzhXqDPNkmPH4XKWJVQ==
X-Received: by 2002:a05:6808:281:b0:3e7:edd9:8eb1 with SMTP id 5614622812f47-3e7edd990f0mr3924868b6e.1.1732164118398;
        Wed, 20 Nov 2024 20:41:58 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724bf4eeb2dsm2542104b3a.70.2024.11.20.20.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 20:41:57 -0800 (PST)
Message-ID: <48c0adb5-4ae8-48bc-8e83-3d1c413f6861@broadcom.com>
Date: Wed, 20 Nov 2024 20:41:56 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pm: cpupower: Makefile: Allow overriding
 cross-compiling env params
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peng Fan <peng.fan@nxp.com>
References: <20240919-pm-v2-0-0f25686556b5@nxp.com>
 <20240919-pm-v2-2-0f25686556b5@nxp.com>
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
In-Reply-To: <20240919-pm-v2-2-0f25686556b5@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peng,

On 9/19/2024 5:08 AM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Allow overriding the cross-comple env parameters to make it
> easier for Yocto users. Then cross-compiler toolchains to build
> cpupower with only two steps:
> - source (toolchain path)/environment-setup-armv8a-poky-linux
> - make

This patch breaks the way that buildroot builds cpupower:

https://git.buildroot.net/buildroot/tree/package/linux-tools/linux-tool-cpupower.mk.in

and after enabling verbose it becomes clear as to why, see below:

 >>> linux-tools  Configuring
 >>> linux-tools  Building
GIT_DIR=. 
PATH="/local/users/fainelli/buildroot-upstream/output/arm/host/bin:/local/users/fainelli/buildroot-upstream/output/arm/host/sbin:/projects/firepath/tools/bin:/home/ff944844/bin:/home/ff944844/.local/bin:/opt/stblinux/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/opt/toolchains/metaware-vctools-0.4.1/bin/" 
/usr/bin/make -j97 
CROSS=/local/users/fainelli/buildroot-upstream/output/arm/host/bin/arm-linux- 
CPUFREQ_BENCH=false NLS=false LDFLAGS="-L. 
-L/local/users/fainelli/buildroot-upstream/output/arm/target/usr/lib" 
DEBUG=false V=1 -C 
/local/users/fainelli/buildroot-upstream/output/arm/build/linux-custom/tools 
cpupower
mkdir -p power/cpupower && /usr/bin/make  subdir=power/cpupower 
--no-print-directory -C power/cpupower
cc -DVERSION=\"6.12.0\" -DPACKAGE=\"cpupower\" 
-DPACKAGE_BUGREPORT=\"linux-pm@vger.kernel.org\" -D_GNU_SOURCE -pipe 
-Wall -Wchar-subscripts -Wpointer-arith -Wsign-compare -Wno-pointer-sign 
-Wdeclaration-after-statement -Wshadow -Os -fomit-frame-pointer -fPIC -o 
lib/cpufreq.o -c lib/cpufreq.c

Here we use cc, aka host compiler, rather than $(CROSS)gcc as we should, 
so we are no longer cross compiling at all.

The issue is the use of the lazy set if absent for *all* of CC, LD, AR, 
STRIP, RANLIB, rather than just for CROSS. The following fixes it for me:

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 175004ce44b2..96bb1e5f3970 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -87,11 +87,11 @@ INSTALL_SCRIPT = ${INSTALL} -m 644
  # to something more interesting, like "arm-linux-".  If you want
  # to compile vs uClibc, that can be done here as well.
  CROSS ?= #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
-CC ?= $(CROSS)gcc
-LD ?= $(CROSS)gcc
-AR ?= $(CROSS)ar
-STRIP ?= $(CROSS)strip
-RANLIB ?= $(CROSS)ranlib
+CC = $(CROSS)gcc
+LD = $(CROSS)gcc
+AR = $(CROSS)ar
+STRIP = $(CROSS)strip
+RANLIB = $(CROSS)ranlib
  HOSTCC = gcc
  MKDIR = mkdir

-- 
Florian



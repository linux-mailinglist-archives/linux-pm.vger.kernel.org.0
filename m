Return-Path: <linux-pm+bounces-17965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEFD9D6335
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 18:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFFA1603F9
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 17:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5321DDC1E;
	Fri, 22 Nov 2024 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LkKSFH7K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AFE154BFB
	for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296878; cv=none; b=dFWSiaLY548lmN2n3JfntXVHdQUvRj2t80eZKPQslSw0gP4x5hk9TC4w0AURh0owNWuKt7jG00zp+CVry6RtyYRLaK3/B6FzE9ypdXZS+2xpHAFLMNR5egL8sCSUjpodBJDDBvKX3hrlDOoqcAqCfMdd2jUkgGmiXJHBY6Yx+Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296878; c=relaxed/simple;
	bh=zJmGRV/XLfgv1minZchcrJ05wfS111uz/2SdQ7i3e1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enGbFK3ud4fWlcjqde/ZPfNOOq0XrquXMimTnC6g437nCoDQPTFAunkTn4QMqGYIdqre11zK2T2q/PpbJVTnHA5QD07UVK07JcGMQGtMECoLiwWMMy5fmHLRrjFISNp5/dw5XoRWJ/FrW0MlBeNRMUT0hkdK5Reo/uljkznHvuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LkKSFH7K; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b157c9ad12so145812085a.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 09:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732296875; x=1732901675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=83b7g5aoVQ6QV5azyGDnUZTlT7N8YipVfmdnjziv6cw=;
        b=LkKSFH7KR8enz0qJJvrBkoK6/l9WVuIjXUgW1wqRr5KDrxQYOm8Rb4L46LBw0L/QBf
         vK79fjMZDJtWoSCOnAZiQMrVULfsyESmvrx6hE1SptxFbk+75f9aWyVXvIbya3f9YoDl
         4S8eiyxgqCZt5t5wCaWDATaBBkYQk5JG9svn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732296875; x=1732901675;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83b7g5aoVQ6QV5azyGDnUZTlT7N8YipVfmdnjziv6cw=;
        b=FT3u52uQT3XAgeO56BavVp2lOCVrHV/5G4LaxhbxIlqFcLeMItPpQgHcypY42JHYOC
         DmGVpD5PqzJURVmVLQfPKwmmO43qPcadX+PONbsJ/lzLX/jSO1q9BsSMFzRQn+hZA6ZS
         rGQQyRHOptCsp/U3AlxMouFfjxe2Kj5xEoQEnOQ4cKJaEPvQfmYj6Hw3/jyLuCCdk5YH
         FnW+TDbDNKJWuTb3ovXj5001Zrifig0hkup6kduYa/OrByy039Wc7DTUieEjhPkxebAm
         SM6n0hOu7A5RfJKNMHTvV2WEruZRboni5L7coEYfpfi42PuxY18W6343HE4iQuWruIv0
         tMyQ==
X-Gm-Message-State: AOJu0YzgxAXNwPsuhloXd+4KFoW8QHVEcHUS6PwFfC1nL722ZVzsXM6Y
	Q/ShMv9qF7y+o6t0cmeQcgvR9M2nqbewn53tTLLmqazoJ54NBBnb91HSiDzFO3cM3gthG36yTnJ
	Blg==
X-Gm-Gg: ASbGnctDBih6BdhVYwGu3fam0ySi5FavXZicLXEr6deVCMn25xi/fMSDbVfJgToRGFS
	VbF85OFAdQ/9/TnYPE/1xf2sWdJZUzel247ID+XrjsJFeqaoQhLKMWWivPgOuUX7+C9hUz2V+bQ
	rOZpT6GXN+VW9bh6iHmOhO6/mNxgBIH8604vHysuhILR5Zb1Mm7eFBKPfiafFfOyX7GLUaA+CpZ
	VPY3OXQeTA+TAR5V/39DpNtlPaqTMe2Ol2NE1lOdgatXTM//USqJPhefR9lQ5LolHsV/VKbndMD
	Ou2vk9cnA+mg+g==
X-Google-Smtp-Source: AGHT+IELhNdRSSZFENGKmL+tlX/9Y8GxrMQS5BMWZYh2tFHKH2804mIePTE0YhbXDyn/kFz9j9p17A==
X-Received: by 2002:a05:620a:4710:b0:7b1:12e0:39ef with SMTP id af79cd13be357-7b51453475dmr487504485a.21.1732296875298;
        Fri, 22 Nov 2024 09:34:35 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b514051368sm106031085a.71.2024.11.22.09.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 09:34:34 -0800 (PST)
Message-ID: <2bbabd2c-24ef-493c-a199-594e5dada3da@broadcom.com>
Date: Fri, 22 Nov 2024 09:34:32 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pm: cpupower: Makefile: Allow overriding
 cross-compiling env params
To: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240919-pm-v2-0-0f25686556b5@nxp.com>
 <20240919-pm-v2-2-0f25686556b5@nxp.com>
 <48c0adb5-4ae8-48bc-8e83-3d1c413f6861@broadcom.com>
 <DB9PR04MB846134093D2302B6D67E7E6288222@DB9PR04MB8461.eurprd04.prod.outlook.com>
 <16411b6f-3e1d-4d52-a047-8c322774ec8c@broadcom.com>
 <PAXPR04MB84595BA5BEAE2D21F015036688232@PAXPR04MB8459.eurprd04.prod.outlook.com>
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
In-Reply-To: <PAXPR04MB84595BA5BEAE2D21F015036688232@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/24 16:13, Peng Fan wrote:
>> Subject: Re: [PATCH v2 2/2] pm: cpupower: Makefile: Allow overriding
>> cross-compiling env params
>>
>> On 11/21/24 04:40, Peng Fan wrote:
>>>> Subject: Re: [PATCH v2 2/2] pm: cpupower: Makefile: Allow
>> overriding
>>>> cross-compiling env params
>>>>
>>>> Hi Peng,
>>>>
>>>> On 9/19/2024 5:08 AM, Peng Fan (OSS) wrote:
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>> Allow overriding the cross-comple env parameters to make it
>> easier
>>>> for
>>>>> Yocto users. Then cross-compiler toolchains to build cpupower
>> with
>>>>> only two steps:
>>>>> - source (toolchain path)/environment-setup-armv8a-poky-linux
>>>>> - make
>>>>
>>>> This patch breaks the way that buildroot builds cpupower:
>>>>
>>>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
>>>> git.buildroot.net%2Fbuildroot%2Ftree%2Fpackage%2Flinux-
>>>> tools%2Flinux-tool-
>>>>
>> cpupower.mk.in&data=05%7C02%7Cpeng.fan%40nxp.com%7C246da9
>>>>
>> 2d8b6243d138c808dd09e6d644%7C686ea1d3bc2b4c6fa92cd99c5c3
>>>>
>> 01635%7C0%7C0%7C638677609234547728%7CUnknown%7CTWFpb
>>>>
>> GZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJX
>>>>
>> aW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat
>>>>
>> a=nL1YUl%2F07Vd8F0GpW7uRqdpZT74avOku1ox9N3%2FFkUg%3D&r
>>>> eserved=0
>>>>
>>>> and after enabling verbose it becomes clear as to why, see below:
>>>>
>>>>    >>> linux-tools  Configuring
>>>>    >>> linux-tools  Building
>>>> GIT_DIR=.
>>>> PATH="/local/users/fainelli/buildroot-
>>>> upstream/output/arm/host/bin:/local/users/fainelli/buildroot-
>>>>
>> upstream/output/arm/host/sbin:/projects/firepath/tools/bin:/home/ff
>>>>
>> 944844/bin:/home/ff944844/.local/bin:/opt/stblinux/bin:/usr/local/sb
>>>> in:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local
>>>> /ga mes:/snap/bin:/opt/toolchains/metaware-vctools-0.4.1/bin/"
>>>> /usr/bin/make -j97
>>>> CROSS=/local/users/fainelli/buildroot-
>>>> upstream/output/arm/host/bin/arm-linux-
>>>> CPUFREQ_BENCH=false NLS=false LDFLAGS="-L.
>>>> -L/local/users/fainelli/buildroot-
>> upstream/output/arm/target/usr/lib"
>>>> DEBUG=false V=1 -C
>>>> /local/users/fainelli/buildroot-upstream/output/arm/build/linux-
>>>> custom/tools
>>>> cpupower
>>>> mkdir -p power/cpupower && /usr/bin/make
>> subdir=power/cpupower
>>>> --no-print-directory -C power/cpupower cc -DVERSION=\"6.12.0\" -
>>>> DPACKAGE=\"cpupower\"
>>>> -DPACKAGE_BUGREPORT=\"linux-pm@vger.kernel.org\" -
>> D_GNU_SOURCE -pipe
>>>> -Wall -Wchar-subscripts -Wpointer-arith -Wsign- compare
>>>> -Wno-pointer-sign -Wdeclaration-after-statement -Wshadow - Os
>>>> -fomit-frame-pointer -fPIC -o lib/cpufreq.o -c lib/cpufreq.c
>>>
>>> You are building on an ARM host? Or you are cross compiling with cc
>> is
>>> actually arm gcc?
>>
>> This is cross compiling targeting ARM, which is why CROSS is set to
>> ../arm-linux-
>>
>>>
>>>>
>>>> Here we use cc, aka host compiler, rather than $(CROSS)gcc as we
>>>> should, so we are no longer cross compiling at all.
>>>
>>> I not understand. CROSS was set, but using cc to compile for host?
>>
>> See below.
>>
>>>
>>>>
>>>> The issue is the use of the lazy set if absent for *all* of CC, LD,
>>>> AR, STRIP, RANLIB, rather than just for CROSS. The following fixes it
>> for me:
>>>>
>>>> diff --git a/tools/power/cpupower/Makefile
>>>> b/tools/power/cpupower/Makefile index
>>>> 175004ce44b2..96bb1e5f3970 100644
>>>> --- a/tools/power/cpupower/Makefile
>>>> +++ b/tools/power/cpupower/Makefile
>>>> @@ -87,11 +87,11 @@ INSTALL_SCRIPT = ${INSTALL} -m 644
>>>>     # to something more interesting, like "arm-linux-".  If you want
>>>>     # to compile vs uClibc, that can be done here as well.
>>>>     CROSS ?= #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
>>>> -CC ?= $(CROSS)gcc
>>>> -LD ?= $(CROSS)gcc
>>>> -AR ?= $(CROSS)ar
>>>> -STRIP ?= $(CROSS)strip
>>>> -RANLIB ?= $(CROSS)ranlib
>>>> +CC = $(CROSS)gcc
>>>> +LD = $(CROSS)gcc
>>>> +AR = $(CROSS)ar
>>>> +STRIP = $(CROSS)strip
>>>> +RANLIB = $(CROSS)ranlib
>>>
>>> The ? is just allow to override CC/LD/AR.., so in your env, CC is set,
>>> but should not be used for cpupower compling?
>>
>> Adding debug to show the origin of the CC variable shows the following:
>>
>> CROSS=/local/users/fainelli/buildroot-
>> upstream/output/arm/host/bin/arm-linux-
>> CC origin is (default) and value is (cc) LD origin is (default) and value is
>> (ld) CC=cc LD=ld AR=ar STRIP= RANLIB=
> 
> 
> How about
> CROSS ?= #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
> ifneq ($(CROSS), )
> CC = $(CROSS)gcc
> LD = $(CROSS)gcc
> AR = $(CROSS)ar
> STRIP = $(CROSS)strip
> RANLIB = $(CROSS)ranlib
> else
> CC ?= $(CROSS)gcc
> LD ?= $(CROSS)gcc
> AR ?= $(CROSS)ar
> STRIP ?= $(CROSS)strip
> RANLIB ?= $(CROSS)ranlib
> Endif

Yes, this works just as well, do you want to submit this if that works 
in your environment as well?
-- 
Florian


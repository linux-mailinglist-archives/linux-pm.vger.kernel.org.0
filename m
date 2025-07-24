Return-Path: <linux-pm+bounces-31406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3085B1131F
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 23:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E642B5A6870
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 21:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFA02EE99A;
	Thu, 24 Jul 2025 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SM+lRFo7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3942EE973
	for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392450; cv=none; b=jFYhpUvvzxDtw8aDaMz+pTHfSa5WpQQMeKqM1rotLP3uv/VQX091ckKC3hBKA7bB2hhQ2P4Xs9Cm2eaqdNm70KP01MHmfLhuV8Lv/2zQIJ6bqJogJ4OaIF9PlOvEf7d9DfMvUGmtwz2VCPpc6ONfYXUsDNq+ECRre3d3gXUWLGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392450; c=relaxed/simple;
	bh=wNCd3EJBV8JmYYmxRVMwzijvsmCmObXzyS6voU1YqDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBGoVVBVl0hhC1gis6q9SNs0+xkrdHc8fFht39lhdp7dvxOzt6nlRuhSUNPknR9dmKOd6fYEwz58UYYjAsCdnjTnWSISfMY47jzSqTtUTqQekaErKU9ekRbhxtX9QnTem1nexPzFdJyKbtytrh921WmikgkuYqeFqOvg1TCPVq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SM+lRFo7; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fada2dd785so14458966d6.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753392448; x=1753997248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eb7LwTrwfKZRGwsWl7FQwuOc+LHKc/Q1TZHaaM57R8o=;
        b=SM+lRFo7N1mbFZfA3hHMXOBmBgQhT2Q5Jqm4GiZ7DzeSol+W2X6WyFPGADIx7r+aB5
         1rultwrb5EaOiP11okmK8Ot0hzKrfh3mc5nMW6clw8Lgp4HIRPP4dJSuHhXR2pbUxF+v
         084CeppGGsxQpw9hKcs62wSthkFAkMFGLwKjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753392448; x=1753997248;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eb7LwTrwfKZRGwsWl7FQwuOc+LHKc/Q1TZHaaM57R8o=;
        b=EOkg6ffz60zIXJCoYyENTG4krJ6Oq8qTanS5tjPtDfWTm9prUEMYXK3awG2r6cED4R
         QhQFxynFe4OXeu4FUMwSi6L6PEytNvDPrclVLbIN+ziu0UXpLF7y7vxnNIKwDQcQBmcK
         yKHl+MX1OgjxXPA9Sqr/ZdhjOaNOkg5HhSQtNTZ9EH9PZIBkagJ41mdsMOUoq4/NNq/+
         +Q7bMDMTxFBgcGCmUR7dMO5+XvdJQpAkCzsKwWGc0SEAXjBRhNCPNO48ylUQNrZsto1f
         UBfZzyR02Ueq9GesQHeFxFSdvX1X+3k7+qy8k+rA6foCRDiMT2tMCKFwcWmdWBDal//R
         bxhw==
X-Forwarded-Encrypted: i=1; AJvYcCXp5Umau7B1d3ttNU6IwgnvsL8/DomayEjteeFq43PujjL1XH1zKN0OURkoV9re5xNur5ecp6SpnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yybee8glyyANK/xLoeXatfL0HNZRF4KDhcryKaG3ec7R6lNnWwA
	jGsN93v4gj6kbVRDf58yKIv38jCGjXQ9d63S2Bi0BROfXoUpxZ+XDK3DKTtpJagDLg==
X-Gm-Gg: ASbGncumy84GlEQ0iYrPamWQ8McTBrISRarRLv3TVPiTVw/5pI8MZsx7i1lLv1Vlvcr
	mIiIKjpqkhvsX7Q7zQmqXSPJrHY4bzm5iQ265C0ZYg3T+Hd31wK9UvQWDql+98vEHfp6i2GkNDe
	JvhwA+MgrtSOb0dvVOEqlCxxoi0xxSsE28tKd4YA0P2ZVhfqZ6466qjl1ye/kGQVnuzaeSVUBUJ
	1/C26okYN3woFpmgI4IHV7jWHXuJpc2DziXTvxEUFSf5qRlzMM+JAMSG4BMEmiuWf6dCOAybehS
	0Bz9ryo0uC3dx1LGk1OyWKQPRZ+xnlW6peVqjd3yUXTF8K318Oz/Pdv+pCMr0Qmi8tmutN7AWGs
	W7o/xDmdtfV5RikbDwWVrm12JsW0K7l0FMbvZTQUN0r5qH5SrH4HPzgpi4EBaQOaaBGF0o8ug
X-Google-Smtp-Source: AGHT+IFXe1AUozr/VBWe0gYnK+qQoY2TYFea6yXJGINXUcVKLGT6eNnGYGkrp3ZYYhKBw7J09w5K5w==
X-Received: by 2002:a05:6214:500d:b0:6fb:4e82:6e8 with SMTP id 6a1803df08f44-7070051b347mr106591216d6.14.1753392447547;
        Thu, 24 Jul 2025 14:27:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7070faec0b9sm18388806d6.5.2025.07.24.14.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 14:27:26 -0700 (PDT)
Message-ID: <136af381-5c31-49dd-98fe-1703a2cd57df@broadcom.com>
Date: Thu, 24 Jul 2025 14:27:20 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] MAINTAINERS: Include dmesg.py under PRINTK entry
To: John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham
 <kbingham@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Uladzislau Rezki <urezki@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Kuan-Ying Lee <kuan-ying.lee@canonical.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Etienne Buira <etienne.buira@free.fr>,
 Antonio Quartulli <antonio@mandelbit.com>, Illia Ostapyshyn
 <illia@yshyn.com>, "open list:COMMON CLK FRAMEWORK"
 <linux-clk@vger.kernel.org>,
 "open list:PER-CPU MEMORY ALLOCATOR" <linux-mm@kvack.org>,
 "open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>,
 "open list:KASAN" <kasan-dev@googlegroups.com>,
 "open list:MAPLE TREE" <maple-tree@lists.infradead.org>,
 "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>,
 "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>
References: <20250625231053.1134589-1-florian.fainelli@broadcom.com>
 <20250625231053.1134589-13-florian.fainelli@broadcom.com>
 <84v7oic2qx.fsf@jogness.linutronix.de>
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
In-Reply-To: <84v7oic2qx.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/25 01:43, John Ogness wrote:
> On 2025-06-25, Florian Fainelli <florian.fainelli@broadcom.com> wrote:
>> Include the GDB scripts file under scripts/gdb/linux/dmesg.py under the
>> PRINTK subsystem since it parses internal data structures that depend
>> upon that subsystem.
>>
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 224825ddea83..0931440c890b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19982,6 +19982,7 @@ S:	Maintained
>>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
>>   F:	include/linux/printk.h
>>   F:	kernel/printk/
>> +F:	scripts/gdb/linux/dmesg.py
> 
> Note that Documentation/admin-guide/kdump/gdbmacros.txt also contains a
> similar macro (dmesg). If something needs fixing in
> scripts/gdb/linux/dmesg.py, it usually needs fixing in
> Documentation/admin-guide/kdump/gdbmacros.txt as well.
> 
> So perhaps while at it, we can also add here:
> 
> F:	Documentation/admin-guide/kdump/gdbmacros.txt

Thanks, v2 coming up.
-- 
Florian


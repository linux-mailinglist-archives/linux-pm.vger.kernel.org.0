Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D6390488
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfHPPUN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 11:20:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44271 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfHPPUN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 11:20:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so2561408plr.11
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2019 08:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uq/BinxihOIL92bxz7COo1OH8fndOXzflXkJ66CJ19A=;
        b=FxXYCkh2GJGzW+y3E6GB2GbD4JUyWi1I909xPQEFDK+/uBTdNviWz/3xCYRvYkILD+
         aptxFpmBIVkQCuUDP8QU9jyvjRpPVoPSJ2kxH1CXneishDCT/oPHh7b6G368e6XPMCyP
         euJIeceBbum1X17fm28m1pqWHvRL8sVydZWM4x5Bb27tGB8ih3RbZm+ZjONt6A913B8q
         BFtw3tL3RiYdY0AIhcsO74HmsYX0JogVcDQQL2A4sH5qgAhXAh/5AqYZ2qq/d3PTXzg1
         SyiYOFAF+OvF2D7PrQjf3q+rTuJuwDrLT7kDcCnbqZPczudI01driaiiJCLYEh6MGn+B
         PxVQ==
X-Gm-Message-State: APjAAAUAqz1xOc5KFR9aeQnDgMPhfFa8qLBf6Jd4ykvfulfPSkxibdsl
        ROjLqYh85xYwHBeTpt482TgZGg==
X-Google-Smtp-Source: APXvYqzFpiOvuE1Nb1T9iFvZuHhM5Z6kiBulQJFo5iggAoyERZSO6STGCj2ft+AMElV8wMfVwqHgvg==
X-Received: by 2002:a17:902:7d84:: with SMTP id a4mr9646776plm.90.1565968812494;
        Fri, 16 Aug 2019 08:20:12 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id h9sm4839072pgk.10.2019.08.16.08.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 08:20:11 -0700 (PDT)
Subject: Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family 15h/16h
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <87dacbb4-1733-fd70-1356-7f8d5c69c029@kernel.org>
Date:   Fri, 16 Aug 2019 08:19:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/14/19 2:17 PM, Lendacky, Thomas wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> There have been reports of RDRAND issues after resuming from suspend on
> some AMD family 15h and family 16h systems. This issue stems from BIOS
> not performing the proper steps during resume to ensure RDRAND continues
> to function properly.

Can you or someone from AMD document *precisely* what goes wrong here? 
The APM is crystal clear:

Hardware modifies the CF flag to indicate whether the value returned in 
the destination register is valid. If CF = 1, the value is valid. If CF 
= 0, the value is invalid.

If BIOS screws up and somehow RDRAND starts failing and returning CF = 
0, then I think it's legitimate to call it a BIOS bug.  Some degree of 
documentation would be nice, as would a way for BIOS to indicate to the 
OS that it does not have this bug.

But, from the reports, it sounds like RDRAND starts failing, setting CF 
= 1, and returning 0xFFFF.... in the destination register.  If true, 
then this is, in my book, a severe CPU bug.  Software is supposed to be 
able to trust that, if RDRAND sets CF = 1, the result is a 
cryptographically secure random number, even if everything else in the 
system is actively malicious.  On a SEV-ES system, this should be 
considered a security hole -- even if the hypervisor and BIOS collude, 
RDRAND in the guest should work as defined by the manual.

So, can you clarify what is actually going on?  And, if there is an 
issue where the CPU does not behave as documented in the APM, and AMD 
issue an erratum?  And ideally also fix it in microcode or in a stepping 
and give an indication that the issue is fixed?

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32F2311CF7A
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 15:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfLLONy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 09:13:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22045 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729650AbfLLONx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 09:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576160032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZExjJXZmAxrisVlHnSSzmAF44okPSODnrWMGgB8ZBE=;
        b=RbEsSyYHh4081uLX/iIS2+QYlxT5pUB5wzAVddC2Uq3DKJMqoxyJHzuunzGsGsILHs0WVX
        vG0dLjLm8ZKZngCPtCkPnDhnFlDK9J2wbSXUxx+7ZDIcbrCpj1yv6OBD0OYsbBFIN8GlMN
        k8a4IyR7MIrvjSEK6GqpnxcguLYSwG0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-VrGpp-vFPGSD1zKlaiG1IA-1; Thu, 12 Dec 2019 09:13:49 -0500
X-MC-Unique: VrGpp-vFPGSD1zKlaiG1IA-1
Received: by mail-wm1-f71.google.com with SMTP id i17so910651wmd.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2019 06:13:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+ZExjJXZmAxrisVlHnSSzmAF44okPSODnrWMGgB8ZBE=;
        b=FyVyDw2IpvG6gZybv/xj6D682A3JsJInvJRCPeSzE5IAnffkjaDQdgVkJku5k6XC7K
         M4d38GtyNiKzssJLdy/93QxkzLdr1lkywLexVudhwypfdabfUoW1v2iSPZX9vchI0jXt
         SVap7oWDpjfTHND5luXnqoTM8QL5/M5b2otqGMWgeE9gtv66BvN8l/hJsmFFhsw8Kkj/
         B6eRLMrmAhcuWv4uFu1oBq16LUlyhtjeMc5jM6eSFeuy8W9egXGVVKAo3DMO4hW7z/8l
         kUcIEu8MNqShHk+TzgCYBDxlfpuvrGwV4Y5N0B4he0IMg6FNk7+4PnuPqRJoo9pX/KGF
         uBDw==
X-Gm-Message-State: APjAAAV6avFurDnSL9NMGCp2fIN+RUixi7YC5neg+e937k4tFjel11ax
        ObLQ6BvLvUvFP3SALgt9Hf0LMNKLEUuD31cJEz0pzS/Du+IiHbhxpJ+Tkx/Huc/VjnJUoJTs54S
        GS9m5FwxajfzW3M2pJRA=
X-Received: by 2002:a1c:1d16:: with SMTP id d22mr7146074wmd.158.1576160028583;
        Thu, 12 Dec 2019 06:13:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqzXF4yU0mb+JGHuD4jVpmfrMhrWl7mkfC0/B+dcZzKjBOfKW3ZFj8XtTi3XukYIj/A/1colAQ==
X-Received: by 2002:a1c:1d16:: with SMTP id d22mr7146033wmd.158.1576160028358;
        Thu, 12 Dec 2019 06:13:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id v3sm6151298wml.47.2019.12.12.06.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:13:47 -0800 (PST)
Subject: Re: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using
 VMX_FEATURES_*
To:     Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-12-sean.j.christopherson@intel.com>
 <20191212122646.GE4991@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0b21e7e-69f5-09f9-3e1c-14d49fa42b9f@redhat.com>
Date:   Thu, 12 Dec 2019 15:13:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191212122646.GE4991@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/12/19 13:26, Borislav Petkov wrote:
> 
> vmx flags       : virtual_nmis preemption_timer invvpid ept_x_only ept_ad ept_1gb flexpriority tsc_offsetting virtual_tpr mtf virt_apic_accesses ept vpid unrestricted_guest ple shadow_vmcs pml mode_based_ept_exec
> 
> virtual_nmis		-> vnmis

Even vnmi

> preemption_timer	-> preempt_tmr

I would prefer the full one here.

> flexpriority		-> flexprio

Full name?

> tsc_offsetting		-> tsc_ofs

tsc_offset?

> virtual_tpr		-> vtpr

Do we need this?  It's usually included together with flexpriority.

> virt_apic_accesses	-> vapic

apicv

> unrestricted_guest	-> unres_guest

Full? Or just unrestricted

In general I would stick to the same names as kvm_intel module
parameters (sans "enable_" if applicable) and not even bother publishing
the others.  Some features are either not used by KVM or available on
all VMX processors.

Paolo

> and so on. Those are just my examples - I betcha the SDM is more
> creative here with abbreviations. But you guys are going to grep for
> them. If it were me, I'd save on typing. :-)


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED5411D195
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 16:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfLLP5T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 10:57:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22264 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729507AbfLLP5T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 10:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576166237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRNrufMF5ZmcT+/5HZMlWib9qPtBnpXc+naU09rmhxc=;
        b=I/1D3NeyxiyZlMNbK4bu4WwA5RQCzhKoRFQo8VNt3mEFce0g//irADh5p+53pDACxO2wIy
        NMgItXamgQAxJuD8tZ1r/rL9RN+1xBW8xioK2s1u7fgyoFYP6xvAk4Nu7uEUnkJWShBAJw
        N0zHG8T4c4sf6JA0bGDl4jWpGJhcOr4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-WWB_7KBMMvK6eyFVLvFdyQ-1; Thu, 12 Dec 2019 10:57:16 -0500
X-MC-Unique: WWB_7KBMMvK6eyFVLvFdyQ-1
Received: by mail-wr1-f71.google.com with SMTP id c6so1190780wrm.18
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2019 07:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rRNrufMF5ZmcT+/5HZMlWib9qPtBnpXc+naU09rmhxc=;
        b=GICyeqfSq8YSMzpwNRexZTjhUh6NAKiLhNxbwm5Vs1YJmfBRJQvAIFcMjiyNjtplxO
         LIta3vBhVl5aKFnBwvoeFCI2KW0Y+ZH75pco6AGNMrTmn0g1KDn4Op8lL86kDLExTRpG
         wWaC8trs2MuiXLk/Ks+pyW8RfcCgmW7h36cL/L3b5jGIHwHdWndIqL1OorjkEm/k5uau
         3+xuiMqBQX5sElZfFQVo2X3DFebBClmegP2k4KWlO0IeQ0XFeNZ1sthtMctYB8M3VbNd
         BOb4edix3ekvbGzw98Mkp0LEn7876k3iuXelDL5ZxslqJA08kIbZWU7Xyk3imvoKu/15
         z81A==
X-Gm-Message-State: APjAAAWbUU7ELxE4FtE7c3dukksJGVmW/G3dcUb5NZG5uZEeRtL6dlW9
        1tqTsORDSpwS15jZN+Y21MOV0L6BBGHeqLKxH8kO9Qgun/A56l8R9ZDBtwCRPLpSwgUBLn1uJS2
        efVgGbiIeFOe6IDeHOGE=
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr7226961wrm.284.1576166235415;
        Thu, 12 Dec 2019 07:57:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxCcJblbdBpu6fVRmTMMxd9YCps91vlO3a/KrWqDMJ5D1GjIwC7bcnVpKVuMe+qGktQ2LnvbA==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr7226922wrm.284.1576166235182;
        Thu, 12 Dec 2019 07:57:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id s10sm6451431wrw.12.2019.12.12.07.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 07:57:14 -0800 (PST)
Subject: Re: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using
 VMX_FEATURES_*
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
 <d0b21e7e-69f5-09f9-3e1c-14d49fa42b9f@redhat.com>
 <4A24DE75-4E68-4EC6-B3F3-4ACB0EE82BF0@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <17c6569e-d0af-539c-6d63-f4c07367d8d1@redhat.com>
Date:   Thu, 12 Dec 2019 16:57:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4A24DE75-4E68-4EC6-B3F3-4ACB0EE82BF0@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/12/19 16:52, Liran Alon wrote:
>>> virt_apic_accesses	-> vapic
>> apicv
> Frankly, I dislike APICv terminology. I prefer to enumerate the
> various VMX features which are collectively called APICv by KVM. 
> APICv currently represents in KVM terminology the combination of
> APIC-register virtualization, virtual-interrupt-delivery and
> posted-interrupts (See cpu_has_vmx_apicv()).
> 
> In fact, the coupling of “enable_apicv” module parameter have made me
> multiple times to need to disable entire APICv features when there
> for example was only a bug in posted-interrupts.
> 
> Even you got confused as virtualize-apic-access is not part of KVM’s
> APICv terminology but rather it’s enablement depend on
> flexpriority_enabled (See cpu_need_virtualize_apic_accesses()). i.e.
> It can be used for faster intercept handling of accesses to guest
> xAPIC MMIO page.

Right, I got confused with APIC-register virtualization.  Virtualize
APIC accesses is another one I wouldn't bother putting in /proc/cpuinfo,
since it's usually present together with flexpriority.

Paolo


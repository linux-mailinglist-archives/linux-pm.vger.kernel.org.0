Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E48E611D46B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 18:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfLLRrj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 12:47:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34365 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730170AbfLLRri (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 12:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576172857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/nKa20xp4tV0yE47Y8o9W3Vq936Vx8/IC/mznXJwZU4=;
        b=d0O8zHHn0FxH+GaANDEjURR9FZHGTXtAkHo0dBPEsb3p8SlBmUNBWEw9k79ZTjZXK0LHLQ
        egWlMCn7tWjW1ZVNAzlqYMQTeNADHP6zIslri8VCTFj8aWn08Xcm4F2z65LIbod3PV0SSZ
        14TyHt2+qJT4sQJY/cU/n+ez9ASee0Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-7Oiyz_o8NKSjolJOKirtuA-1; Thu, 12 Dec 2019 12:47:36 -0500
X-MC-Unique: 7Oiyz_o8NKSjolJOKirtuA-1
Received: by mail-wr1-f69.google.com with SMTP id y7so1323860wrm.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2019 09:47:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/nKa20xp4tV0yE47Y8o9W3Vq936Vx8/IC/mznXJwZU4=;
        b=A/BHeJPCXBEahUmH7NShCvdkSZIbYBUfKdCAhUgxBrCtYCFn7goofyNaYG3U0CxsPw
         Qzi/mZx3vdVg/FP0DbUsb5ODgbceMlJvQqyjkCPN4hEUCZe/WsghMLrRLN48sJvdsBZQ
         9WT8pEl/kxq7yufxgKHA38yPJQstuSswArJiqe9WkYt/pR6ts2HtU9+1SNJ7KihD8xN8
         p9xltlL0/nn6E3ktvn3evoqUiAChHn7LQUdqEfdmSR0dPnnUitXKiRocHN13i2X5T+IV
         sWBADlNhVz3DDsew5eHi7wt58svKl/EQHID0uG60tiWLmNQR5s08WuG9thnVCduKah5m
         4c2A==
X-Gm-Message-State: APjAAAVFxO0kjgmk13A1JnE/xKfdymiK0C0vvycPdiOuapN7L/brmddk
        J+8LNMQ8UCW9FdMJ7OIIT1E2QzZVfaFMRsGZAaVhtWSxLiwEwsJhXHdxUQGZQJoXAV98Z7Xu5FK
        7rccL8r+MunY0wiJbt2k=
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr7989941wrx.288.1576172855427;
        Thu, 12 Dec 2019 09:47:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzv2+I65Ibao5YAYxVeTp4kfGB0dGHdLw6/s3Qr+938uZEtANPwUxdA+sHWu8+QDpYFcjRJqg==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr7989920wrx.288.1576172855163;
        Thu, 12 Dec 2019 09:47:35 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id q3sm6813826wmj.38.2019.12.12.09.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 09:47:34 -0800 (PST)
Subject: Re: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using
 VMX_FEATURES_*
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Liran Alon <liran.alon@oracle.com>, Borislav Petkov <bp@alien8.de>,
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
 <17c6569e-d0af-539c-6d63-f4c07367d8d1@redhat.com>
 <20191212174357.GE3163@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <52dd758d-a590-52a6-4248-22d6852b75cd@redhat.com>
Date:   Thu, 12 Dec 2019 18:47:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191212174357.GE3163@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/12/19 18:43, Sean Christopherson wrote:
> Key word being "usually".  My intent in printing out partially redundant
> flags was to help users debug/understand why the combined feature isn't
> supported.  E.g. userspace can already easily (relatively speaking) query
> flexpriority support via /sys/module/kvm_intel/parameters/flexpriority.
> But if that comes back "N", the user has no way to determine exactly why
> flexpriority is disabled.

There are tools such as vmxcap.  It is part of QEMU, but I wouldn't mind
moving it into the kernel tree.

Paolo


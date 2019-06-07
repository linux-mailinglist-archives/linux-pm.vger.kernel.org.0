Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9BC239432
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 20:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfFGSWj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 14:22:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35208 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbfFGSWj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 14:22:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so3098586wrv.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2019 11:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eNp/kwCcjJ3WyRs1HdEQeYz66YbQ4zXrLFnd6CGtqfQ=;
        b=EBOJ0lCe+AbVfkHcD/ZIKCet+jtethkh/PuATjCbqomkdcXHjYnuiUfZr1O5oRDs6u
         y+OBj+3FX+80sJcDblzTsXIYms0CyimuLtFL5iFMeH9alcB2pA4soaLAcv3KbMDKkhAD
         S3jS9LYRWJSo/6JjkTkjdlL4ASgvB+OjA6GhWSCXCrGfZavA2f2GQJa0yY5zAUwfThbH
         TPl3+LXENKp2CB/ZxpsT4ikNZcUehwFYEj/Eyoc0Xf3uT+4jbJX3IKKF3IXHFJx24Prr
         sR78jwtBmJ6CFu2STzr60MnaoUmQdHgvjFs79w5q2uRbLHve8TP2ZY5m0jpDBQvC8+EQ
         HRQw==
X-Gm-Message-State: APjAAAV3p1X7E0OdJsaEzdEB7J2NvZFCkIO6uYbi/gwg9h08voe3ZkGT
        IsIY4KKlnSgGRZ+X2xNDGiKennDECPE=
X-Google-Smtp-Source: APXvYqwrf60J+k2JN6vMRpE7QAF5l8jsltiwzK3HTHX6hWafz/VFEn5A2JWE/ev0sD8j3/Nw/SvQPA==
X-Received: by 2002:a5d:414c:: with SMTP id c12mr21816421wrq.88.1559931757855;
        Fri, 07 Jun 2019 11:22:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d43d:6da3:9364:a775? ([2001:b07:6468:f312:d43d:6da3:9364:a775])
        by smtp.gmail.com with ESMTPSA id w14sm2975048wrt.59.2019.06.07.11.22.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:22:37 -0700 (PDT)
Subject: Re: [patch 0/3] cpuidle-haltpoll driver (v2)
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     kvm-devel <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LDhD9tw4PCocOFPw==?= <rkrcmar@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <kernellwp@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Raslan KarimAllah <karahmed@amazon.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20190603225242.289109849@amt.cnet>
 <6c411948-9e32-9f41-351e-c9accd1facb0@intel.com>
 <20190607171645.GA28275@amt.cnet>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9c3853cc-d920-03e8-245c-86c33b280c80@redhat.com>
Date:   Fri, 7 Jun 2019 20:22:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607171645.GA28275@amt.cnet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/06/19 19:16, Marcelo Tosatti wrote:
> There is no "target residency" concept in the virtualized use-case 
> (which is what poll_state.c uses to calculate the poll time).

Actually there is: it is the cost of a vmexit, and it be calibrated with
a very short CPUID loop (e.g. run 100 CPUID instructions and take the
smallest TSC interval---it should take less than 50 microseconds, and
less than a millisecond even on nested virt).

I think it would make sense to improve poll_state.c to use an adaptive
algorithm similar to the one you implemented, which includes optionally
allowing to poll for an interval larger than the target residency.

Paolo

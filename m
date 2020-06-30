Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E5E20FBEC
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 20:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgF3Skc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 14:40:32 -0400
Received: from cmta20.telus.net ([209.171.16.93]:46048 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgF3Skc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jun 2020 14:40:32 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id qLBAjf7NpmPBRqLBBjqXbR; Tue, 30 Jun 2020 12:40:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1593542430; bh=5lsW47LwcbLEtRnjtW+QOJmsT1zddKUIUZH9u4fGksw=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=JFx5kCLqN4LamJppGxGwSOJsn9jznwF87fwxh6722QXMSiD2/1+2vTC85iCounDJb
         A/Z1VDokZ03f16c18KzTQxFYcSgkuv074Ma8DrxSwwVwoLzIXPhWjGBUDcMmV1TusO
         2g1lQsIoGpa5OvVx2cr9IHRSxC+2H2o6w3faGo1GXOX9WlX/hmePbyAqkLNJj5p8iu
         ubPQyGnTpuSlA/ybpuVdEyQ77F0Edsjh5ah37tDwyM3akuBuFXdg7FxVO7hdLiga4W
         BjeKpRvtnUhPJH6ntLUqUHz/BEylmPF7ncqJqtw4/iLK9fCTpG9Dz07tF/UhhLcwUn
         OkLGi/j2H5uCg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=ZvmT1OzG c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=OM2GBPE6UocqHCZ_6TsA:9
 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>
Cc:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <lenb@kernel.org>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <peterz@infradead.org>
References: <20200626183401.1495090-1-srinivas.pandruvada@linux.intel.com> <20200626183401.1495090-3-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20200626183401.1495090-3-srinivas.pandruvada@linux.intel.com>
Subject: RE: [PATCH v4 2/2] cpufreq: intel_pstate: Allow raw energy performance preference value
Date:   Tue, 30 Jun 2020 11:40:24 -0700
Message-ID: <002301d64f0d$ee4bea10$cae3be30$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZL6GfN1BQpAfQRQwWuKbhHibbLRAA8mfVA
X-CMAE-Envelope: MS4wfO7oaIfxSFx3svGsM9XZ/bOt6LbDnNC2uVTFiGTFwNKr2B82MLeELAmZZnTJX9D9cQCCyy14mIw/vSa16A5QxZSJUQ5UYE6UBTogEYH0rzdE9/6yAVIE
 2ydKkpE+D+89ZJRgt3xkzdaV49R4nSSX8Po2vgWhqAmunKRhEstLsHdakLxbjFUwSl+stHrUB77scr66zINi+bBKFdl52IRDkP0t5daD8bJ4XdXOwSB/hOTo
 KPCPX2Ed4tyrVMDckiKrnIOfip7pPWw+s/Xhx2BKKJmBabElLJcBgYGcvd7lTMYodgtxaSiWz47J1icIBbuzRFFU6HKZjpKSwUO/4RBWy/LoYmJpdolVg7Mg
 2v2yIELSTDG/9hfPLu0SgK/WjLRjhNBBprEmOD95TerlpGMmRyUqmkCpxGdy+RTKPexLmorgC0ovlGRny4eMtN4WBraxNvRzrK4mHuOgHYXQkyrX+DPUAGtI
 EDDmKt2C82CvTn5KO961z5k4rNaeDIiuwophog==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Srinivas,

Thanks for all your work on this.
I have fallen behind, and not sure when I can catch up.
However...

On 2020.06.26 11:34 Srinivas Pandruvada wrote:

> Similarly on battery the default "balance_performance" mode can be
> aggressive in power consumption. But picking up the next choice
> "balance power" results in too much loss of performance, which results in
> bad user experience in use cases like "Google Hangout". It was observed
> that some value between these two EPP is optimal.

There is a possibility that one of the issues I have been ranting
about could be a contributing factor to things like this.
(I don't know if it actually is.)
One way to compensate is to lower EPP.

I am going to send a new e-mail in a minute about it.
Please consider the possibility that some of these
EPP adjustments might just be programming around the issue.

... Doug



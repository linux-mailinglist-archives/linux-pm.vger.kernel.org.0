Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF10525F128
	for <lists+linux-pm@lfdr.de>; Mon,  7 Sep 2020 02:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgIGAQl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 20:16:41 -0400
Received: from cmta18.telus.net ([209.171.16.91]:58656 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgIGAQk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 6 Sep 2020 20:16:40 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id F4plkpO5iiMStF4pnk1gM8; Sun, 06 Sep 2020 18:16:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1599437798; bh=6f5D6BntBLDfIBY82JWUrBrCSFl5V3/wNPJtcHK/pHg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=kC8Xt+UWxFS7tqq8znBSolSAkZ7ryjbHauCRJholmIHuOJhuvT4LBAfnPByWi8PXM
         Fj4H8zj9OGpjmamWesFy0kbkiiwSOx0z9kk3CAlJcrm7NC6ObKrJJv8VSNh2b29e6I
         jzKHTCt+27xnzZrOCbIPQX84/rhTccngzBAE3ZQEfcFiYbydBnItlRMNyCPJj5Lbm8
         8Mh7KBWfX4mlFblSiMBdeO51cuwDEwhY4AZb+iJh/paeTQVldI7zXCDt3seTp0UXQN
         ol++HF6egTP5Go6SNT8W4gTF9DdqkrPo8yoEsYY0uMmuO/DtOp8qXvCgiD2Zx6Q97L
         AeiRc/eKWvNiQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=X7os11be c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=NUCYY5ABiiWEOdNnIBYA:9
 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Linux Documentation'" <linux-doc@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher> <3226770.pJcYkdRNc2@kreacher> <122847018.uQ7iJ9lzrg@kreacher> <000901d674da$4521bda0$cf6538e0$@net>
In-Reply-To: <000901d674da$4521bda0$cf6538e0$@net>
Subject: RE: [PATCH v7] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Sun, 6 Sep 2020 17:16:32 -0700
Message-ID: <000401d684ac$26ee4880$74cad980$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdZsF+Ny9o2RVgG1QuO4ZJYAcV1MWgIFjVRQA3cqLPA=
Content-Language: en-ca
X-CMAE-Envelope: MS4wfCZvXPEvELx7qhybaoshebBIm6qp8gVxi6FxeGfTzSxZzoG52v1iLvek6iZjvzw9WJO5JYAkmINNOeLPU8AGJS0C74uVY0VfDfh4TVPVabbVwfcUGCQt
 YZtwvFRoQSFJeWxodlaRaK2Dj8XlYt0N4GJzPNNiTiz0aCXQ2tAy1JLZqVoBoCbIdYpjZ8XuUB1gI7kULWd79kNhgW6ciKL9e2HHsNDguVUgzN+nLso0ComW
 5IyHx8Vd7ojxTxTu7wjbHTSIjO18g840WNR/+/hg+AF7HyGI8abFWu7I6LRocBNsIvfaFk2ErV1jygffRw+7eMGcy8NCDAoIb1FuKURSUYKg527+lKkYqLXg
 xVG+5vSofK7kuNJ5C3lo3bGN8YR321R5/KjhxedLmsAWGaAjmIjSPKHj5xIZ1tmnVrf3f7XmWPjGjEESzliSrvnBQHijBv4QS9dtMe0zzdr2Y7GKdcY=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 2020.08.17 14:06 Doug Smythies wrote:
> On 2020.08.06 05:04 Rafael J. Wysocki wrote:
> 
> > Allow intel_pstate to work in the passive mode with HWP enabled and
> > make it set the HWP minimum performance limit (HWP floor) to the
> > P-state value given by the target frequency supplied by the cpufreq
> > governor, so as to prevent the HWP algorithm and the CPU scheduler
> > from working against each other, at least when the schedutil governor
> > is in use, and update the intel_pstate documentation accordingly.
> 
...
> 
> powersave governor:
> acpi-cpufreq: good
> intel_cpufreq hwp: bad
> intel_cpufreq no hwp: good

It occurs to me that my expectations as to what 
is meant by "powersave" might not agree with yours. 

For the powersave governor, this is what we have now:

intel_cpufreq hwp == intel_pstate hwp
intel_cpufreq no hwp == acpi-cpufreq == always minimum freq
intel_pstate no hwp ~= acpi-cpufreq/ondemand

Is that your understanding/intention?

My expectation was/is:

intel_cpufreq hwp == intel_cpufreq no hwp == acpi-cpufreq == always minimum freq
intel_pstate no hwp ~= acpi-cpufreq/ondemand
intel_pstate hwp == Unique. Say, extremely course version of ondemand.

... Doug



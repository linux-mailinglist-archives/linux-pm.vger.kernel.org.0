Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 702031298C0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 17:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLWQeO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 11:34:14 -0500
Received: from cmta18.telus.net ([209.171.16.91]:35569 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfLWQeN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Dec 2019 11:34:13 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id jQekiig2fgu2QjQeli8VrW; Mon, 23 Dec 2019 09:34:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1577118851; bh=LYjQc+QsXvLslMFxlBKPfwzBtd8uWbZdsNcC1DpAMvs=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=wt7gYFDyHmCSUecalxriil/HXl5v1PRTjG4z6oMbgHWAWcaetrh1drK1QwV78gWE1
         wJ6TMgsOohBG0GBnfLdekJ6C3RM7K0ChPHu5kJpRJuTS1Y2Qzhz9uIvDiB1qcose9j
         EAfc2gMHHibk7QHV5SMoiZ9QggSHmD5zBQPXmGu5gPeT92aodLkzU2T/L9rcKUVjES
         SLqtz6a2YIHgWFTJi0TH6UrWUPYzb1kWUGBpnyNlufulkxHBqgx+d6sXpHqrE6vsV0
         N42Y7mdy7J+kO63QZKzjmv9+wZfov/PtQeXV7f9sftPrA42uVEtmQDL5R66G2M+6mD
         gqyYR4fvZNrJw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=QIcWuTDL c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=u-mPKCrbiWlf-ac98vYA:9 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Qais Yousef'" <qais.yousef@arm.com>
Cc:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>, <x86@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Mel Gorman'" <mgorman@techsingularity.net>,
        "'Matt Fleming'" <matt@codeblueprint.co.uk>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Juri Lelli'" <juri.lelli@redhat.com>,
        "'Paul Turner'" <pjt@google.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Vincent Guittot'" <vincent.guittot@linaro.org>,
        "'Quentin Perret'" <qperret@qperret.net>,
        "'Dietmar Eggemann'" <dietmar.eggemann@arm.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Ingo Molnar'" <mingo@redhat.com>,
        "'Borislav Petkov'" <bp@suse.de>, "'Len Brown'" <lenb@kernel.org>,
        "'Rafael J . Wysocki'" <rjw@rjwysocki.net>
References: <20191113124654.18122-2-ggherdovich@suse.cz> <000001d5a29b$c944fd70$5bcef850$@net> <1574697961.16378.5.camel@suse.cz> <000801d5a41e$a7fce2c0$f7f6a840$@net> <1574781600.7677.2.camel@suse.cz> <001d01d5a4f4$d96b21b0$8c416510$@net> <003d01d5a63d$f6ab3950$e401abf0$@net> <20191219104813.6fr34qavpaplecoz@e107158-lin> <000701d5b965$361b6c60$a2524520$@net> <20191223140743.o2wfoqtf56g4yrk5@e107158-lin.cambridge.arm.com> <20191223144043.ticfxfgbolsqk74i@e107158-lin.cambridge.arm.com>
In-Reply-To: <20191223144043.ticfxfgbolsqk74i@e107158-lin.cambridge.arm.com>
Subject: RE: [PATCH v4 1/6] x86,sched: Add support for frequency invariance
Date:   Mon, 23 Dec 2019 08:34:04 -0800
Message-ID: <000301d5b9ae$cd8f5b30$68ae1190$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdW5nvjzmCjbzpTaQ32aAttVlnFmYAACZkeg
X-CMAE-Envelope: MS4wfPIIFS3hhbjmNYigcQ3hmKUkxdMUaejULBwnkwNTqN+MK+a0iAD8LHjBJerRqkJxo0QI11UpXkeT+Hnvi7MbIaCT3YiaARszTbeYjpFIwFkGWstbVtpo
 qxdaX/q/dBF7QJCl9ene/FoX6Nkg+w7vnv+uyTq3kX86BwL87JXbxIZOBgQejXk72us7bQQibktnwND5coSSHKRBmnfkUPJ2XtQfYe0BUM7sAo2QRJ5+f0mN
 LMfTvE+dKAV2LuWFuBXV/TRpJpcq9VXCJb0eOmixef3kuLRq7IYNFTcPP99LV7LNIHgNtMfniihgbxfjyZ+St2wL9i1Tn/DbGjUzmqjCD94pTu7CTG2y+Tld
 EAGedf3Gz2vrn3WxAgjsIgIaN4v99LgFclK83pnUaZj4O6RQffK7ki447NvDwCytYU3yQeG3SbcQIu8UVLQloknaSfiUxX9wb3g7G/tJrQSJ2kmScB57B2/Q
 7RLTaIdx3qogw6FPsbeth82UreTdEHV754uivWofyUDNRCHKWeaqk8eYfX5UB1Ox1OTMnMWHK7IDuowHJmaKJkEHLNiJOjDq22STL5oFzgpBFsrL7c6riLDr
 d1L1ISgq6rE8ZMfOGgpwnjTImoEFZc5YOr8hbQG2afhnf/pt7+zsEhXVSJChrCarVNORhse0b0AD9JT7cKWY8Yv/isRLf6sQYmFTcGaJdT2wa5IrfzuOKteA
 NVvzpKyWhqX3PYYiBsnA/P99p8lTMiAEhd9PMk75XiaoWOIDMRRpUo3odNobAUvucsAl5b8ekJU=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.12.23 06:41 Qais Yousef wrote:
> On 12/23/19 14:07, Qais Yousef wrote:
>>> Re-boot to the nocgv1 (stock + cgroup_no_v1=all) kernel.
>>> set the schedutil governor.
>>> launch test 2 and related monitoring tools.
>>> verify performance governor like behavior.
>> 
>> So as stated above, by default uclamp_{min, max} = (0, 1024). So it wouldn't
>> act as performance governor by default unless you explicitly write 1024 to
>> uclamp.min.
>> 
>> Let me go find Ubuntu mainline tree to see if they applied anything extra in
>> there. If they modified the default behavior that could explain what you see.
>
> Actually I see what you were saying now that you copy the config. So I think
>  I misunderstood and you are running Linus' 5.5-rc2 + Ubuntu PPA config.

Yes, exactly.
I have a clone of the main Linus git branch, but steal the kernel
configuration from the Ubuntu mainline PPA.

>
> I'm trying to to reproduce the issue at my end.

... Doug



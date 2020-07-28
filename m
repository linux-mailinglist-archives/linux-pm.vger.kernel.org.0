Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FF0230B61
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 15:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgG1NXv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jul 2020 09:23:51 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:32900 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgG1NXv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2020 09:23:51 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1k0Pa8-0008S8-In; Tue, 28 Jul 2020 07:23:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k0Pa7-0004Jh-IY; Tue, 28 Jul 2020 07:23:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <87h7tsllgw.fsf@x220.int.ebiederm.org>
        <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
        <87d04fhkyz.fsf@x220.int.ebiederm.org>
Date:   Tue, 28 Jul 2020 08:20:41 -0500
In-Reply-To: <87d04fhkyz.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 28 Jul 2020 07:39:48 -0500")
Message-ID: <87h7trg4ie.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k0Pa7-0004Jh-IY;;;mid=<87h7trg4ie.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Lsxp9D29SGoF42ZMFfbqoBJ10C5tdn2s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 314 ms - load_scoreonly_sql: 0.14 (0.0%),
        signal_user_changed: 12 (3.7%), b_tie_ro: 10 (3.2%), parse: 0.96
        (0.3%), extract_message_metadata: 16 (5.0%), get_uri_detail_list: 1.29
        (0.4%), tests_pri_-1000: 15 (4.7%), tests_pri_-950: 1.49 (0.5%),
        tests_pri_-900: 1.27 (0.4%), tests_pri_-90: 57 (18.2%), check_bayes:
        55 (17.7%), b_tokenize: 6 (2.0%), b_tok_get_all: 7 (2.1%),
        b_comp_prob: 2.3 (0.7%), b_tok_touch_all: 37 (11.9%), b_finish: 0.88
        (0.3%), tests_pri_0: 198 (63.2%), check_dkim_signature: 0.59 (0.2%),
        check_dkim_adsp: 2.4 (0.8%), poll_dns_idle: 0.68 (0.2%), tests_pri_10:
        2.1 (0.7%), tests_pri_500: 7 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] exec: Freeze the other threads during a multi-threaded exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> It also makes for a possible _huge_ latency regression for execve(),
>> since freezing really has never been a very low-latency operation.
>>
>> Other threads doing IO can now basically block execve() for a long
>> long long time.
>
> Hmm.  Potentially.  The synchronization with the other threads must
> happen in a multi-threaded exec in de_thread.
>
> So I need to look at the differences between where de_thread thread
> can kill a thread and the freezer can not freeze a thread.  I am hoping
> that the freezer has already instrumented most of those sleeps but I
> admit I have not looked yet.

Alright I have looked at the freezer a bit more and I now see that the
point of marking things freezable is for kernel threads rather that user
space threads.  I think there are 5 maybe 6 places the code sleeps
reachable by userspace threads that are marked as freezable and most
of those are callable from get_signal.

For exec all I care about are user space threads.  So it appears the
freezer infrastructure adds very little.

Now to see if I can find another way to divert a task into a slow path
as it wakes up, so I don't need to manually wrap all of the sleeping
calls.  Something that plays nice with the scheduler.

Eric


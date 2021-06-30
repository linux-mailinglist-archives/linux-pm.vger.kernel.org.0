Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875963B875D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 19:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhF3RIS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 13:08:18 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:36469 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3RIR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 13:08:17 -0400
Received: by mail-oi1-f171.google.com with SMTP id 11so3855670oid.3;
        Wed, 30 Jun 2021 10:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dPVvMgKGMPozzTPi57Z6C+oEWFK/3BbhBj8XI0SQu4=;
        b=T8OH+lCLwS3+M3DexXcvPA5RKsQ+vX8VKjXzpPwQ+Vbr1P96rTzZsDdhNsbatG2YHP
         5HtUKEFQ0b6uwD+1gcDtMfE0R1Fe23yvIaIL3QPs7Z+pS8mCoSFIwUHvv7VsBbpyygnH
         jpRRXkTiZjJ21SrE35gk3e5G5Y2KIOzOFvrHAgGnYIetEUWPyiwMVF6JEti9lHwkSb0P
         KocFpGQl/rMJKGV6LelGSzh3sJlmzaSuRNTy0UM5r4pViyxGm7teKEl7xjlbe1wFShrQ
         7N4EUvDC40em5sEVniu7mN0pbtxUFV7ZGZgQAhuIbS4u92uU0ie4RCHmE+YSK2A/6YbI
         yNSw==
X-Gm-Message-State: AOAM530n2yhDTX+jTjiWGNHjzVgP3ncEIJz4GkXl1pYgwyfC1W5ttmDO
        lmku/XeIDgTLDnyWuHuMqv1K2U0p9Kb1ySDgA2k=
X-Google-Smtp-Source: ABdhPJxZ85pjc+J+8YwJ3+RDJINx2Id+yfifXp0BcoJrCQnE7dFW9nhME6aq0FTTcpHcqjI4hmRKtcwkEzO3QPwuGVc=
X-Received: by 2002:a05:6808:15a6:: with SMTP id t38mr3890642oiw.157.1625072747262;
 Wed, 30 Jun 2021 10:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210624092156.332208049@infradead.org>
In-Reply-To: <20210624092156.332208049@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Jun 2021 19:05:36 +0200
Message-ID: <CAJZ5v0j8MYBq1+dM-VaH6eA28bTMWV-U7Vk6K2Obf2A8mO17-g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Freezer rewrite
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 24, 2021 at 11:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hi all,
>
> Now with a completely different approach to freezing the special states.
>
> Patches go on top of tip/master, as they depend on the
> task_struct::state rename.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

for the entire series from the power management side.

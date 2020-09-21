Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC84272ABF
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 17:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgIUPvx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 11:51:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38114 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgIUPvv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 11:51:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id y5so12777402otg.5;
        Mon, 21 Sep 2020 08:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPJjBMxHKHUceSNmN9Nn7k9JJsU0eMQLMBgotnWjMpk=;
        b=dXeaqskShL5VdJIDEZqgY5cQSMleaYNXNMayX/zKxBZc4ngCZDILlN9mRyTbhlUmjb
         poO+uyotmk5kz7GDmiRol+/a0iNSQJDgC62SutF56E6qRqWkwMQ0eVU+uSrLlZlV5O3u
         r9brwsxJlUdOHlEA0MQF7P6w4I1XXs+6qQwmxb7p9+x1FHyU/PG1OpCB6cd2aKyiFyRO
         dPaq8UoCxNWQZznQq0jGNfKq6AVQd1q6yLPKy5yWE+iy4yYH+oaqDoxDwCbt4spRId8q
         p8xOOAqBA4tagufC1mDRc7WjBbGBuU4muXWM/6E6KmauPclJKMSEh8WtUZqlWFZEwZu/
         Um9w==
X-Gm-Message-State: AOAM530MZZ0CJLQjN5oIguFUZg20VeqWTrWu25I9OckXU7O5ojVcTfAg
        U2qeRAVedN3iC6qUDA5mTgJt9kkibCS9QTLyHQ4=
X-Google-Smtp-Source: ABdhPJwyZBHi30AoB3e0t3aFxTO9o6sVcsJ+5b6Q9mDBTXNnZGwnR/bJVyZjwVBonJuX1wH+//jBBbMAhXmIuFbBLpU=
X-Received: by 2002:a05:6830:1f16:: with SMTP id u22mr120500otg.118.1600703509133;
 Mon, 21 Sep 2020 08:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200729105206.2991064-1-victording@google.com>
In-Reply-To: <20200729105206.2991064-1-victording@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Sep 2020 17:51:37 +0200
Message-ID: <CAJZ5v0jfMAi2UjvwjYG6=hytGeHZkuaeNEsu+oaz8tEMcuHnPg@mail.gmail.com>
Subject: Re: [PATCH 0/3] powercap: Enable RAPL for AMD Fam17h
To:     Victor Ding <victording@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Beulich <jbeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 29, 2020 at 12:52 PM Victor Ding <victording@google.com> wrote:
>
> This patch series adds support for AMD Fam17h RAPL counters. As per
> AMD PPR, Fam17h support RAPL counters to monitor power usage. The RAPL
> counter operates as with Intel RAPL. Therefore, it is beneficial to
> re-use existing framework for Intel, especially to allow existing tools
> to seamlessly run on AMD.
>
> From the user's point view, this series enables the following two sysfs
> entry on AMD Fam17h:
>   /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj
>   /sys/class/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:0/energy_uj
>
>
> Victor Ding (3):
>   x86/msr-index: sort AMD RAPL MSRs by address

I haven't received this patch.

Any chance to resend the entire series with a CC to linux-pm?

>   powercap/intel_rapl_msr: Convert rapl_msr_priv into pointer
>   powercap: Add AMD Fam17h RAPL support
>
>  arch/x86/include/asm/msr-index.h     |  3 +-
>  drivers/powercap/intel_rapl_common.c |  2 +
>  drivers/powercap/intel_rapl_msr.c    | 58 +++++++++++++++++++++-------
>  3 files changed, 47 insertions(+), 16 deletions(-)
>
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AE38548F
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 22:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388934AbfHGUkg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 16:40:36 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36047 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388428AbfHGUkg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 16:40:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id r6so109675680oti.3;
        Wed, 07 Aug 2019 13:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hsr+7IuYZ22l7OIvx3fQa1mKuz2z9lcudCb1f5vrKBw=;
        b=lEhV3X4YTQyW9sc35BXtfzvcHrJqfkUliJ6bzuDTWcGFqYi21PFP5dHOqusDQW0vxL
         EJ/p2Gs3LKGEdSskQdd0La2eCtnAEvM6sgv9lyylrCIYr3xREzaFMyzjho0xzBBK5uxH
         F5J1oIfXhau/C0scn76ub9QbaZC/i7H4rQdPZq9z8fA5tV3G5Z/hS6uJQJ6jYkM+lS45
         BA+UR6JnjLjrtjUwmxGz8HxZeNm/24qzjZZiDqIpc9NfSwH25p0G8nwJY36EqR291AmS
         C+PNEbObw2vKTWcEiHRQ+G492FRFGHDp89DiA0rmFKYlf+/8SPuYnLKIokTxxZ9yj7fg
         VWGg==
X-Gm-Message-State: APjAAAUvSVkwbV2m2iy3NlgogmgwXqcPcQ/BaWXIoYXYxgf4X0XwryQP
        O8+L4Lr5ZFZTy3q83p/u927sTZn0MNXNWejgxms=
X-Google-Smtp-Source: APXvYqwbzYP+gDUmu7cbwPvt0vp7/DQxqVeeAZBEikWiVadypsE38JfE9Mz9EtZXqcgJs9TJ1uyeDx8pGAkHEMmP/og=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr9983761otq.262.1565210435206;
 Wed, 07 Aug 2019 13:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190807153340.11516-1-douglas.raillard@arm.com>
In-Reply-To: <20190807153340.11516-1-douglas.raillard@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Aug 2019 22:40:23 +0200
Message-ID: <CAJZ5v0gqqoOzjUMhUgqKzaj8tCegddJphr+MHj5HD2_VAc1QYQ@mail.gmail.com>
Subject: Re: [PATCH] sched/cpufreq: Align trace event behavior of fast switching
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 7, 2019 at 5:34 PM Douglas RAILLARD
<douglas.raillard@arm.com> wrote:
>
> Fast switching path only emits an event for the CPU of interest, whereas the
> regular path emits an event for all the CPUs that had their frequency changed,
> i.e. all the CPUs sharing the same policy.
>
> With the current behavior, looking at cpu_frequency event for a given CPU that
> is using the fast switching path will not give the correct frequency signal.

Do you actually have any systems where that is a problem?  If so, then
what are they?

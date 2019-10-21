Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 137C8DE750
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfJUI75 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 04:59:57 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43383 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfJUI74 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 04:59:56 -0400
Received: by mail-ua1-f68.google.com with SMTP id k24so3559848uag.10
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkOKxxpsGK/80WlQWwLBXhyhiD8tMwT8+Cgd/zEVlCY=;
        b=gkO7kkILMDe7OJ4KFmrFBHJ2ZE1ERHJD1rmFfjWKt4iYJxpHRjQFsR5YmbgdNoGqlQ
         RdqhZ7g1SOnR99RsgsurMaDeuGuzGcZGnOM6/vbC+m6YDrcDI/s+R8iHEGq/225QMv8S
         BNZ/5z2RSQfjyt6mFh+ARMFUOGF2p256asXG6RXH0R59A4tV+/MZqC6SY5jO4oihmr9y
         1eHwV9hExJcsM7prdU8uLUGv5oQHJxgUqafgwkM7tTOBW915Z5QczaoSas68EUPMrsrG
         gvYdDZ4+MvCf7GPMJbdM09rRUuZAGetP38SPMjYDuyKgnNF4BEXhkJrMAmoTE6trglqn
         IIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkOKxxpsGK/80WlQWwLBXhyhiD8tMwT8+Cgd/zEVlCY=;
        b=T5DyESEZm9852Mn4rkGqm5A+X06hoBTNdbuKVSNskIPKGE0w3WDmShrENqVDZcP8DO
         78deoqHtjDQfJQPhpbduMEnHMWFztIld5DjgtcTLpnV3mLUeisPNgxK8FWxm1+IbEsO8
         zkVq7YLA2GPFu+vg4ayxDavI3QGFjW/BaCRjqTo5IhA8DPVO02jH5SqHnIjA14Lo84na
         AAnmaiKa+naDpO85aDTAxBomPTxaH6JcdQxdXZztIt0yDuO5brwn3YUxQm7/jRVPckgk
         B8HVO/IP+WiolpK4/uRDF/bj0iKNB6iWgMjGSVMa8PUfMW/dUnJW44xn9QgotW9E9tK+
         CZDA==
X-Gm-Message-State: APjAAAUx6Ch1137ooIXK5GNrnjz7Y2oB6XIBLSMCwS4MXEJU2BsDWXTO
        qFTY6HhTfi3NuyoiWuaFrR/8O7m/YuenoMVaWJJHTQ==
X-Google-Smtp-Source: APXvYqy1skCw5iA/y67UrQPP3MAZhJ04h3rF2rtlEMmZQVVO3ryPl7j+34VyGLMMcpvzuCqueqM59hhRx1AvMlcjFdo=
X-Received: by 2002:ab0:2015:: with SMTP id v21mr12191265uak.94.1571648394900;
 Mon, 21 Oct 2019 01:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571387352.git.amit.kucheria@linaro.org>
 <66d8ae593ce7936a5f492d0c6855c1ac225b64ee.1571387352.git.amit.kucheria@linaro.org>
 <20191021080811.GA54219@gmail.com>
In-Reply-To: <20191021080811.GA54219@gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 21 Oct 2019 14:29:43 +0530
Message-ID: <CAHLCerOcdnSTppKRm2vi6V8E7vyVWvwDakaQcnXnnDVqKDXmBA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] cpufreq: Initialize cpufreq-dt driver earlier
To:     Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 21, 2019 at 1:38 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> > This allows HW drivers that depend on cpufreq-dt to initialise earlier.
>
> My obsessive-compulsive in-brain spellchecker noticed that the title says
> 'initialize' (US spelling), while the comment uses 'initialise' (UK
> spelling). Just in case this is not some post-Brexit expression of
> cross-Atlantic friendliness you might want to fix it. :)

Naah, its just my confused brain that grew up learning British
English, then spent enough time in US to pick up some of that too. I
think it is a form of selective spelling blindness :-)

Will fix.

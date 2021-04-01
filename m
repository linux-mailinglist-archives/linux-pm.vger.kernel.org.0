Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82C0352387
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 01:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhDAX1P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 19:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbhDAX1O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 19:27:14 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D942C06178A
        for <linux-pm@vger.kernel.org>; Thu,  1 Apr 2021 16:27:14 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id v26so3791794iox.11
        for <linux-pm@vger.kernel.org>; Thu, 01 Apr 2021 16:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/Cy9GFSSG292kbWWXXjaNyNH/4apg+3HJDMSJ6lS/0=;
        b=cnGPeiI0reWFraLFVR4ze+oO/uopDQHdjCCjQGr7HYMB3+g/7D7+MyXjBwAxVqqAcg
         Z8gbSe19fHzXp+1tRlQB/wNt++TDIlccEIj7DzgssBOoHWqg75WcMQgHetZEA9vQ0dHS
         puqYQ22lO5Y3r6baZBtXdEkpznip1fHW1wVA4YeOAe7hqwQG7NsMkRxDy5ISkk6VicP3
         1YUxLe90IYzaODAl/7qi/l5c8aJZVpFzu4nvs4zzw8zcadsqPrjCtailwDOurWHsK7Pq
         TAQ9MNeZ8X4tgyvF9z7uXQ7rQgaoAf/R/qSlyHDc41d9/ou94mxwOVG4pGPJVC2W7w1b
         n6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/Cy9GFSSG292kbWWXXjaNyNH/4apg+3HJDMSJ6lS/0=;
        b=Ja+ADz3ji8YZ9PiXuS6NsIppKMIRxYgknOk1IkbjRIY19mRD4nBpGSKKqqvGq2eaFF
         EdOB+Bm65PEI8IVHPKLJ7SRNINB90yDd4I35bC78BiD6MtwB9h2/CE25d/pNAbeDrbba
         CLQzBdUW0UB2MdVZoQJr1eVjKajU1z+xndw54ELf8nAWZdCcijhzEynw4MbEMLNN8qY/
         WGIdxv4Nrv4QPDpx7SvK7gJ0Z9qv1JgnUeY0Wo0zh35aJbhzhKuX4t02kJfEWE9khL/F
         Igd6+Sywc/SKEw6H1RIQBIQH6yS24Ed5m4IxK6nlhzAqlWD1xTlixIKGVZKUTTYRkFzO
         YDew==
X-Gm-Message-State: AOAM532hxYofYhaeCJadjIRRisdWz2W74XwzybFNrEh/kysHGcE8O/Ql
        VhB/XSsKik2eiZwVs4u4D6SMKhafiLrmKeb/5Q35Qg==
X-Google-Smtp-Source: ABdhPJy5WrUR32ElfKa80MigZbS1m8oMj+ZQkP4ozZ9oygO7G1Z+PTnvQcBiDCoRD/ZUi/2BaLZkWoRmbEi3OD8LhqQ=
X-Received: by 2002:a5d:8453:: with SMTP id w19mr8595652ior.25.1617319633765;
 Thu, 01 Apr 2021 16:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210401114504.13466-1-psampat@linux.ibm.com> <20210401114504.13466-3-psampat@linux.ibm.com>
In-Reply-To: <20210401114504.13466-3-psampat@linux.ibm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Thu, 1 Apr 2021 16:27:04 -0700
Message-ID: <CAAYoRsWKw2eXXoXGhdaM2pqhvDGXz8o=hV5K5HmYaZvetxv96w@mail.gmail.com>
Subject: Re: [RFC v2 2/2] selftest/cpuidle: Add support for cpuidle latency measurement
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Pratik,

On Thu, Apr 1, 2021 at 4:45 AM Pratik Rajesh Sampat
<psampat@linux.ibm.com> wrote:
>
...

> To run this test specifically:
> $ make -C tools/testing/selftests TARGETS="cpuidle" run_tests

I have not become any smarter than I was with version 1,
and still assumed that the "$" meant regular user.
Please put it as "#" or separate the two steps, compile and run.

>
> There are a few optinal arguments too that the script can take

optional

Suggest to also specifically mention how to run without re-compile,

# ./cpuidle.sh -v

Note also that the test still leaves all idle states disabled when done.

>         [-h <help>]
>         [-i <run timer tests>]
>         [-m <location of the module>]
>         [-o <location of the output>]
>         [-v <verbose> (run on all cpus)]
> Default Output location in: tools/testing/selftest/cpuidle/cpuidle.log

...

> +cpu_is_online()
> +{
> +       cpu=$1
> +       if [ ! -f "/sys/devices/system/cpu/cpu$cpu/online" ]; then
> +               echo 0

incorrect. should be:

> +               echo 1

... Doug

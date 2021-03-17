Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8E533FA3E
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 22:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhCQVBZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 17:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhCQVBK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 17:01:10 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B52C061760
        for <linux-pm@vger.kernel.org>; Wed, 17 Mar 2021 14:01:10 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id j26so38792iog.13
        for <linux-pm@vger.kernel.org>; Wed, 17 Mar 2021 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIuPYjA6l+N0tkJmYvNT6UOMEbB5ifXWgNDr0ucCHII=;
        b=ImORc1nRT/HRASaMXqkXN8BsCBCKfXQItBBAcRUwhtwhwx7T3t4HpX0kKhNIhdJcVD
         hr12+6tl6yzFb6eiNmPL5l7on75J0NnMH9UgvxtxPvdR/1HmYLuG85PHPQlPLPLM8M3S
         9F0JmEediC2gHcPB0KjzghL5IwOT55EEN3eQqrTdP3aNEnbUm9eIQ+9gCSCJnWyiS5M6
         VUfy9DBpyzzy70cB4Yt8O7Fx7Akz/0mCIjK9DMJ06y3t0I6Vaud0shtNs9g4hKa2deX2
         jxCQmQTCUk+Os0qfffc4SFDyIdGj0LHqSbXtc9OTH1jbv64gbrQQWHb8Pd5bzU7p3wAk
         oqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIuPYjA6l+N0tkJmYvNT6UOMEbB5ifXWgNDr0ucCHII=;
        b=Hp0gO1y9AL/4cJ9tR3WyMc3/x2C8Chb9pDqYgUaYcxG/D5hxmDMDdrYveqOCKxnEXd
         xrORNlCTCnUoBZlRQ9zXOHgUFTGPG+JpzMUEL5sLAtmSsqmDZs1LJlF7lmi5aLwBrK9n
         DCYe8Nb9MuEeUnvx4ltjeihUHWnMv1Zoc7QwIAA6tN1RtaTm8hT0XnBdstpO9Uyeoltd
         RE0CYhO9x2Y9Eqk1aZLy2zTAzozqGRWWOSOb4lpZvJNuDtO9HEmbr2YLxMfZug0XzNzm
         eSNwoN1a2v517sbIAYQVNtseerrr/XYiUtwj4C24eFZh1xMZVN388siZ7t1d0nuS7NEz
         Y3mw==
X-Gm-Message-State: AOAM532Q7bHGilsQaviEiCAQQZrDEe3jsdIik8PKF7yJg6mjsmagwYoh
        Q6CRSomNobijxYmXeGcC4d1en3OA/Wtlq9SQSo0phA==
X-Google-Smtp-Source: ABdhPJwDP2lj/gbUKX+TfHoZVhc7uAFCyPe2vkNo1ZpAiZISMMaL+B8kp8uDxM+MMbmRLZGBK3p1cC3U27SktHyGObw=
X-Received: by 2002:a02:9048:: with SMTP id y8mr4339484jaf.66.1616014869772;
 Wed, 17 Mar 2021 14:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210315114827.46036-1-psampat@linux.ibm.com> <20210315114827.46036-3-psampat@linux.ibm.com>
In-Reply-To: <20210315114827.46036-3-psampat@linux.ibm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Wed, 17 Mar 2021 14:00:57 -0700
Message-ID: <CAAYoRsW-E_Rek-c=e3xr8dTNUWud1AkndNaNySCZpt=h1qSf7g@mail.gmail.com>
Subject: Re: [RFC 2/2] selftest/cpuidle: Add support for cpuidle latency measurement
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

It just so happens that I have been trying Artem's version this last
week, so I tried yours.

On Mon, Mar 15, 2021 at 4:49 AM Pratik Rajesh Sampat
<psampat@linux.ibm.com> wrote:
>
...
> To run this test specifically:
> $ make -C tools/testing/selftests TARGETS="cpuidle" run_tests

While I suppose it should have been obvious, I interpreted
the "$" sign to mean I could run as a regular user, which I can not.

> There are a few optinal arguments too that the script can take
>         [-h <help>]
>         [-m <location of the module>]
>         [-o <location of the output>]
>         [-v <verbose> (run on all cpus)]
> Default Output location in: tools/testing/cpuidle/cpuidle.log

Isn't it:

tools/testing/selftests/cpuidle/cpuidle.log

? At least, that is where my file was.

Other notes:

No idle state for CPU 0 ever gets disabled.
I assume this is because CPU 0 can never be offline,
so that bit of code (Disable all stop states) doesn't find its state.
By the way, processor = Intel i5-9600K

The system is left with all idle states disabled, well not for CPU 0
as per the above comment. The suggestion is to restore them,
otherwise my processor hogs 42 watts instead of 2.

My results are highly variable per test.
My system is very idle:
Example (from turbostat at 6 seconds sample rate):
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt RAMWatt
0.03    4600    153     28      2.03    1.89
0.01    4600    103     29      2.03    1.89
0.05    4600    115     29      2.08    1.89
0.01    4600    95      28      2.09    1.89
0.03    4600    114     28      2.11    1.89
0.01    4600    107     29      2.07    1.89
0.02    4600    102     29      2.11    1.89

...

... Doug

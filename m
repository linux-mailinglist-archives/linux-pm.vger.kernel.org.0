Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919B61BB706
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 08:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgD1GvD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 02:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbgD1GvD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 02:51:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C971C03C1A9
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 23:51:03 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x2so6505813pfx.7
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=73b8MpZ41+Ingj3LJ1wD9N1HHCgHdQpMES8I3SDX4/4=;
        b=BIs3Rw7VovieoI6m6elWsDysx36WBz4hD013W53L8/N6GbhSSQWeraFRJL+LlabvN3
         PjL9nddZl8oA2V3hZtK352umaVIMUEeTB87VyxUiNT7eP37sLe8VfmnxsApuvcxmIbM2
         v9RUo4289xGnpfMqepzcPl57xmgYX+N7F9BYT44LDD7VYXaGFDo802dEP2VMroM1vMYc
         xpmkszDBXA5lcI/qoX2f/7BJ3vpPGBAd94xWSf2sir4Af6JNiU+QoP/fRLGNKFufRyg/
         j1ssWwnrgnioMCiGbQmyEyq/VsmoC73f7GeKufgwici7Rv1a/GTIPSuzkzSx6QgiJgYZ
         VNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=73b8MpZ41+Ingj3LJ1wD9N1HHCgHdQpMES8I3SDX4/4=;
        b=MDKYqayqYQ/a1/qvlU7FII7yrwOrw7nf0ZoUhLp60tmX6S7LeFvwrIwDyh3Wxk1ea9
         8FvwQ7ikMChjRY5U7hP4OED60/LUhS2TxoHgZo+lbQsfSIpjKpH6foeYn2wEFXSSlCKK
         tbXbJIQvlWgjur90Xf4Qrycva+cymmf/CG7KqOiMmE6oU7RSc0IlI016+lcXAJILzMU4
         c65F+yeBBPYN7C8RzBS93raXDI2NTtuvDerwWX2lVyQAt+ZRv3A4ZUR1VznWEQLlZL9M
         pMrs4Df4FSZm8cIP/snffrTw0Xut4gK/UDBzOo2jSi5VKxOj+nArEaUgnkAQeNPgPLoP
         06fQ==
X-Gm-Message-State: AGi0Pub2DOH889agN5FxWlKPGBT4UNzHMPLPv1miiN5r3hCk9KzC/LwJ
        IriwqnICkImanJiveVZEvhCqfHjTEz7DWdc8N1A=
X-Google-Smtp-Source: APiQypKFPtZdHueGqnqOSJo6KDF4uIlL6gZrv9ZKfcCkl+JUfQCZM5rOK8nwlp9ZqTdlV1GHaa4/11BPHV6G278RBAc=
X-Received: by 2002:a62:dd45:: with SMTP id w66mr1360585pff.177.1588056662956;
 Mon, 27 Apr 2020 23:51:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2129:0:0:0:0 with HTTP; Mon, 27 Apr 2020 23:51:02
 -0700 (PDT)
In-Reply-To: <f6a57336-a591-09df-49f6-7f80cc6ddfb4@linaro.org>
References: <1587365320-25222-1-git-send-email-gao.yunxiao6@gmail.com>
 <20200422080439.kkpl7xmaawkxu5re@vireshk-i7> <CANO_MSLwA6PWEqGEbj50y98TR=trqddENQ6Qcne5edvf1oi9jg@mail.gmail.com>
 <20200422095433.br2zgpzm7f66ydhi@vireshk-i7> <CANO_MSJdi_12=OV4mOju9M0dDc1Sd4daZJ1WBXM1A++XKqBLgQ@mail.gmail.com>
 <CANO_MSK28MgNM8ohXaoONQa69bM2Nz1N8Rh8t53peQ9kboT6Xg@mail.gmail.com> <f6a57336-a591-09df-49f6-7f80cc6ddfb4@linaro.org>
From:   gao yunxiao <gao.yunxiao6@gmail.com>
Date:   Tue, 28 Apr 2020 14:51:02 +0800
Message-ID: <CANO_MS+pqKvkSgMuO0W615UE4tzfK__hB92HazJHLNQgN=mM9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal/drivers/cpufreq_cooling: Add platform
 callback functions
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, amit.kachhap@gmail.com,
        javi.merino@kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Jeson Gao <jeson.gao@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Daniel

Thank you for your suggestion

Yes=EF=BC=8C the platform can support voltage scaling.
I will porting cpuidle cooling and double check it on our platform.

By the way, I have a question trouble to you
when one cpu is forced into the cpuidle, the running task on it are
stopped or migrated other cpu?



On 28/04/2020, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On 22/04/2020 13:11, gao yunxiao wrote:
>> On 22/04/2020, gao yunxiao <gao.yunxiao6@gmail.com> wrote:
>>> viresh
>>>
>>> On UNISOC platform, CPU's temperature can not be controlled when
>>> cpufreq has been limited to the lowest frequency, we have to hotplug
>>> out CPUS to mitigate temperature rising.
>>>
>>> adding platform callback to have a chance to check whether the
>>> normalised power at power2state() is lower than the power
>>> corresponding to the lowest frequency. provide an example in another
>>> patch
>
> You can use in addition the cpuidle cooling device if the cpufreq
> cooling device fails.
>
> Add two trip points. The first one mitigated by the cpufreq cooling
> device and the second one, with a higher temperature, mitigated by the
> cpuidle cooling device [1][2].
>
> For my personal information, does the platform support voltage scaling?
>
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/driver-api/thermal/cpu-idle-cooling.rst
>
> [2] https://lkml.org/lkml/2020/4/14/1442
>
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

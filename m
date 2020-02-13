Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30B8415B9E8
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 08:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgBMHKT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 02:10:19 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37490 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbgBMHKT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 02:10:19 -0500
Received: by mail-lj1-f195.google.com with SMTP id v17so5342643ljg.4
        for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2020 23:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vg2ne5AyyglOAv8FBMMwHyfnVt31BO4UzavNdGGQICU=;
        b=v/6iFBYYAvUyH1ig7uVxg5hp1J8W8pqTDvVe0oceLhdcpHrvCci4+tF2xXQNtxzQPu
         NKnZfw4MmkSWjVBNlp37Az1Fd4k9TFuYRV7SWLWH2ToujZ9cpggJ2KTajdvy+bzqJ48u
         Amm262fwmwPMBW9u/oNOafTF4C3pXNHBnUAnMohr9hjAefmdH/GbH5ceZCSvT6lWJlxb
         VcufdzCYyhzDOx9Qc2EMeKSYxnTz8XK0IjrM6+4eSYLVdJR0lhAALzQ+4VIlbb6G16d/
         INxdJ1lb3L/AZVPz49LRoyCYB6KYpEau3aOcTip0b/Dk4M6kU7SKMGO2Bmt7UkBrmAaa
         6a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vg2ne5AyyglOAv8FBMMwHyfnVt31BO4UzavNdGGQICU=;
        b=eL7CIVqLr53soiLfrFIChOezCvXTrqZsNTOdU3wkyzA9waqXP7dBihuvwvMPZ1q1RL
         BJOrtZ1YdJ3hyiZQ2B0tS34zgRx7avF7AJJz4lpO76MzDW2r1nmk24x0NYEVfUTnjSYT
         +XSynpv42bmPEm7LyRjkMGg4mc521plc4spIGVA7KbBZCywXkQ5wD/f8pFO6QWYQKsuV
         GkEQcE8f8zbIpCqBqhPjh3LOQL2ZuKaTuACo2hPX05HIKoCWOkX/uGj9XSpzperuQPPS
         1nuJ3npPdD6Z58ynd6vQ1jmJBTd2AqEZelkdoPHj/87eTahaWLc7wVsZ3gIlZ58RddRR
         JRtA==
X-Gm-Message-State: APjAAAUCBfSbohTNgG3GFah4YmzDFHI/SgKHttxq6uRriEFK5Ga9PQlh
        sN7ChpQwAVMphp7VRs3y6EsniYOhZjnkSSdwKbLvBQ==
X-Google-Smtp-Source: APXvYqzaqiU/b6IGWITzU+eEe7MG3UAMGPlHrN3BYM1ZLAe965Y8HgMBCww+Yvh2kbxnhfBUSc8FAGZm3qKahOTJp04=
X-Received: by 2002:a2e:7005:: with SMTP id l5mr9592622ljc.230.1581577817025;
 Wed, 12 Feb 2020 23:10:17 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 13 Feb 2020 12:40:05 +0530
Message-ID: <CAP245DXY2MsV6rf95QdATTXXZWoYYLFBO3QxQgkg=44Fw0cLNA@mail.gmail.com>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU
 latency QoS interface
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 12, 2020 at 5:09 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi All,
>
> This series of patches is based on the observation that after commit
> c3082a674f46 ("PM: QoS: Get rid of unused flags") the only global PM QoS class
> in use is PM_QOS_CPU_DMA_LATENCY, but there is still a significant amount of
> code dedicated to the handling of global PM QoS classes in general.  That code
> takes up space and adds overhead in vain, so it is better to get rid of it.
>
> Moreover, with that unuseful code removed, the interface for adding QoS
> requests for CPU latency becomes inelegant and confusing, so it is better to
> clean it up.
>
> Patches [01/28-12/28] do the first part described above, which also includes
> some assorted cleanups of the core PM QoS code that doesn't go away.
>
> Patches [13/28-25/28] rework the CPU latency QoS interface (in the classic
> "define stubs, migrate users, change the API proper" manner), patches
> [26-27/28] update the general comments and documentation to match the code
> after the previous changes and the last one makes the CPU latency QoS depend
> on CPU_IDLE (because cpuidle is the only user of its target value today).
>
> The majority of the patches in this series don't change the functionality of
> the code at all (at least not intentionally).
>
> Please refer to the changelogs of individual patches for details.

Hi Rafael,

Nice cleanup to the code and docs.

I've reviewed the series, and briefly tested it by setting latencies
from userspace. Can we not remove the debugfs interface? It is a quick
way to check the global cpu latency clamp on the system from userspace
without setting up tracepoints or writing a program to read
/dev/cpu_dma_latency.

Except for patch 01/28 removing the debugfs interface, please feel to add my

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

Regards,
Amit

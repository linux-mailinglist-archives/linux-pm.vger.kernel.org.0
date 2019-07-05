Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFE960AFE
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 19:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfGERWj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 13:22:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35123 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfGERWj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 13:22:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id x25so3192186ljh.2;
        Fri, 05 Jul 2019 10:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=lT49eBtmE30QT+N0LpenHBVtCzyNDyCGeA0xIY9l0tk=;
        b=TH1cOfk7h7XdTuH/U8jqosVLTVKqq3nVANlSKgBsXnDb19Bj07zotkkXWGko5UjXte
         +GAE7pWx4g3csHgt9q7+ze2QC4u2QUhVH03dxA2PWhq4Rm2I17tWoAlW9dUZNxBAp3Dg
         aciXgHWRHP/FT+SZK1BZpT7vPLoH1r+ySJ5K8tobYqWGnu0Ezcel/H4+fnu7nQyKdQt8
         sxtTWcpGYMG9SsumQf4ZdsVRZepSjvTPzuRR9hP5BPiJm6WvhexuJB3Eyp1UgGFCmAQf
         pDkT6cxe0YjzUkrktUep0A2WIkhwZkLLG9bSEQdUYg9noOhDcwJvGiMJ17KoMKs4xcAz
         9yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lT49eBtmE30QT+N0LpenHBVtCzyNDyCGeA0xIY9l0tk=;
        b=gSOZ4SKZVwm2EmZ5bbnVbEQZP3xDmsMYhcYankbqZbDpN/X22BAczuxEpDfc6Ro8Lw
         Cl73yl5Zwl4V1k5v/F8S0jFx/1dWos5qO3z+ttma6/rjOsCVByZNYIo6X+fxUlLFDeNU
         q7CU6B83erITBdnYAo/eMYy3zYIvwfa0vOH7+ZbzGuY5l7NFtG7G9AKb/YL7zrbiQ0/1
         BkzfV1PSipwkx7CRuQ4rAqhQOiPmBzQNVuBFNMlEOjQGCvfpDnyYX3Cry+4nxMYUb45h
         tz1uhNAD7UFKeFWLwjaFdZ2UKu1IgJJK7RSSreEUYjuxiOeRhbuL+iDY7Y6JAY19yjrA
         Cb2g==
X-Gm-Message-State: APjAAAVez9SiKX/+Z/DJM5+c7TOUBW9CJq5Ewzul/UiOQiQKVet90uk4
        kKeOYLF3HRponhfRtaDjUzZQ9trQ
X-Google-Smtp-Source: APXvYqw7Qm+qEYpk3A3RJry+Amj8SF4cm9oidAvxOjWwZNzOcNeOFGY1EtmC8fT+i6z9xursIIRYLg==
X-Received: by 2002:a2e:25a:: with SMTP id 87mr2830557ljc.183.1562347356709;
        Fri, 05 Jul 2019 10:22:36 -0700 (PDT)
Received: from [84.217.171.228] (c-74afd954.51034-0-757473696b74.bbcust.telenor.se. [84.217.171.228])
        by smtp.gmail.com with ESMTPSA id 27sm1852775ljw.97.2019.07.05.10.22.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 10:22:36 -0700 (PDT)
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
From:   Thomas Lindroth <thomas.lindroth@gmail.com>
Subject: The tick is active on idle adaptive-tick CPUs when
 /dev/cpu_dma_latency is used
Message-ID: <79b247b3-e056-610e-9a07-e685dfdaa6c9@gmail.com>
Date:   Fri, 5 Jul 2019 19:22:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On recent kernels the tick remains active on idle adaptive-tick CPUs when a small value is written to /dev/cpu_dma_latency to restrict the highest C-state. Before the idle loop redesign in 4.17 idle CPUs had the tick disabled even when C-state were restricted. Is this change intentional or a regression?

I use an x86_64 system built with CONFIG_NO_HZ_FULL that I recently upgraded to the 4.19 series from the 4.14 series. I noticed that adaptive-tick CPUs (nohz_full=1-7) still fire timer interrupts about 1000 times/s (CONFIG_HZ_1000=y) even when they are mostly idle. Some debugging showed that this only happens when a program is writing to /dev/cpu_dma_latency to restrict C-states. The old 4.14 kernel only have around 10 timer interrupts per second on idle adaptive-tick CPU even when C-states are restricted that way.

I would expect an adaptive-tick CPU to turn off the tick when it has 0 or 1 processes to run and enable the tick for >2 processes. Kernels after 4.17 instead have the tick on when 0 or >2 processes are running and the tick off in the 1 process case. Since the tick is off when a single process is running that workload isn't directly harmed by the change but if the CPU use hyperthreading the constant wakeups on an idle HT sibling will reduce performance on the other sibling.

They way I look for timer interrupts is by comparing the LOC line in /proc/interrupts or using the hrtimer_expire_entry tracepoint when function=tick_sched_timer. Both methods seem to give the same results.

I can reproduce the problem using an i7-4790K CPU with /sys/devices/system/cpu/cpuidle/current_driver:intel_idle. I can also reproduce the problem on an old core2duo laptop with current_driver:acpi_idle but I can't reproduce the problem in a virtual machine where current_driver:none. I also can't reproduce the problem if C-states are restricted using the intel_idle.max_cstate=1 kernel argument instead of /dev/cpu_dma_latency.

The commit that introduced the change is 554c8aa8ec "sched: idle: Select idle state before stopping the tick" in v4.17 and the problem exists at least up to kernel 5.1 using the menu cpuidle governor.

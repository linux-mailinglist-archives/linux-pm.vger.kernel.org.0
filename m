Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 627B615A505
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 10:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgBLJj1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 04:39:27 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36119 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbgBLJj1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 04:39:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id j20so1288542otq.3;
        Wed, 12 Feb 2020 01:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVHOXdZQIG1hvtkU7bEsPCeerg5kIqs/hMFqFNcg7JQ=;
        b=MgFVvTtWfybkX/WaurDlA9sq1dsTTfieDJf//q15OBbbO0GlW5+RyhJ8SpmhaYvtkE
         Zxb1aFYLWqamEfHj37bpMvcjvi5E3OdSY23+Yt2HCafifN3BjjTCseJgjc6hNlPGBNFQ
         d7a5rx98Df1AIATFgzn552ndLacOCSbQr0LbQT2KiJQBpZFg6RgMT2rQUKmPC2JR1ieT
         IgWL9QWevNbNCzJIAeL7GZdJ4TEtWN6uTLlged6igijw2sMDBeLKpThXrS5YuSK9+Iff
         XIOte3k7juJUzPsjEiuqOXxu/W9rO9sroqSPDQ1pUdkfa7kIGhTBijisAMxn+RMCWTFq
         rAfg==
X-Gm-Message-State: APjAAAWp+MmFWraqspUWsBYGa096WhtO45cJNLZ5Wo6hDQkAuZPnjxpU
        24p45HZ+JFi9L1n5KtapY7b/9IhJqoAcV9/djkEEYlsv
X-Google-Smtp-Source: APXvYqyf5AKNcupGWKoQbkmna9mQluMsReB0/JD7RKP0eRz9UunJT3HBsSKQKZIs5ApbFq6dG7AZKOkfvWCTNbbuqa4=
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr8653774otn.262.1581500366103;
 Wed, 12 Feb 2020 01:39:26 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Feb 2020 10:39:13 +0100
Message-ID: <CAJZ5v0h1z2p66J5KB3P0RjPkLE-DfDbcfhG_OrnDG_weir7HMA@mail.gmail.com>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU
 latency QoS interface
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 12, 2020 at 12:39 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
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
>
> Thanks!

This patch series is available in the git branch at

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
cpu-latency-qos

for easier access, but please note that it may be updated in response
to review comments etc.

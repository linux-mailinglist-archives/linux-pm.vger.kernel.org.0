Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEB9355317
	for <lists+linux-pm@lfdr.de>; Tue,  6 Apr 2021 14:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343673AbhDFMFy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Apr 2021 08:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232861AbhDFMFy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Apr 2021 08:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617710746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vp3T9WyxmxyZPRwkl/3ZtSCMVT5sfpKeevKbiLuA1gE=;
        b=aSbd0lyhuV5usUFnESv/RHSM4wnaR7o6EwI4/+6MnE/ZlsK9zapkk0/CEAK2A1/C/liJFU
        eOppGC8Ng9phooSkt7QFQJ5NId+YmcjabUM1VGS+Y00SkC+UxBUR7mOaH6qwyveApAbeS1
        jNkJfaVpYOg7wCX8GY21zxEX1KBe098=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-slBiYSWlNCSx1_Tyh4TfcA-1; Tue, 06 Apr 2021 08:05:42 -0400
X-MC-Unique: slBiYSWlNCSx1_Tyh4TfcA-1
Received: by mail-ed1-f72.google.com with SMTP id n20so10369976edr.8
        for <linux-pm@vger.kernel.org>; Tue, 06 Apr 2021 05:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vp3T9WyxmxyZPRwkl/3ZtSCMVT5sfpKeevKbiLuA1gE=;
        b=TMmf6iU19BfWU9KllXxmK0fKRlH+G68Bnuu8GgU5Tg9fT9mU3tS0dHpITS2Cj7QreE
         l2isaQ7+bQJ5maJnIa1+sujBR+fr6kSLijy1mlMUcnkBzztud2tciFHZnqjdDnW8Pmvo
         sXFHulSkhalkmsuh1oUdh6n9pfygrYsZrGvX8kbBjhrJCeGK3KdzBEtmteCCMXULVaE2
         O0uK5LNcxPnzL7BbUiPQSqc6mAOX0iPW8aW4dYH/S9NLtTrYWK1X9hzssBQ/AqGJaBnh
         HwlPzUj6nJnTUEfI0MpInH0ZaACQJiJGGd5DFVUrP7pT0K76gtmVFLpOXh8ENSBlItEj
         tM/Q==
X-Gm-Message-State: AOAM533kNifsn0yDyJEj7uB4CZ9kiauYzbi2qOSvwNcx+HDImkSWEXnJ
        +eNaiP6X2SYPevbedBQK1gYWdrbKe87obKj1N+4lA4jGlOPrD+1f+kvQqpoch0/Cn9OCoN4Hr2w
        nLnqKvHd1e0LMhaQi394=
X-Received: by 2002:aa7:da48:: with SMTP id w8mr36467706eds.81.1617710741363;
        Tue, 06 Apr 2021 05:05:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBKpJ9E534Qj1pqc/mP9nueThPgXDagj2Ht/zBw/U/QtOJmV3/8q6pbAm9VCHPpc7z+5bBoA==
X-Received: by 2002:aa7:da48:: with SMTP id w8mr36467698eds.81.1617710741254;
        Tue, 06 Apr 2021 05:05:41 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u13sm5594888ejr.100.2021.04.06.05.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:05:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, kernel test robot <lkp@intel.com>, x86@kernel.org
Subject: Re: [pm:acpi 1/2] ERROR: modpost: "wakeup_cpu0"
 [drivers/acpi/processor.ko] undefined!
In-Reply-To: <202104030252.XSSunJui-lkp@intel.com>
References: <202104030252.XSSunJui-lkp@intel.com>
Date:   Tue, 06 Apr 2021 14:05:40 +0200
Message-ID: <87pmz7d3e3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi
> head:   91463ebff32d3e6fc71134784ae6aa91402bfe3d
> commit: 8cdddd182bd7befae6af49c5fd612893f55d6ccb [1/2] ACPI: processor: Fix CPU0 wakeup in acpi_idle_play_dead()
> config: x86_64-randconfig-r016-20210401 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=8cdddd182bd7befae6af49c5fd612893f55d6ccb
>         git remote add pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>         git fetch --no-tags pm acpi
>         git checkout 8cdddd182bd7befae6af49c5fd612893f55d6ccb
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
>>> ERROR: modpost: "wakeup_cpu0" [drivers/acpi/processor.ko] undefined!
>>> ERROR: modpost: "start_cpu0" [drivers/acpi/processor.ko] undefined!
>

This happens when we have

CONFIG_ACPI_PROCESSOR=m

as wakeup_cpu0()/start_cpu0() are not exported, sorry about the breakage
:-( I'll be sending a patch to fix things up shortly.

-- 
Vitaly


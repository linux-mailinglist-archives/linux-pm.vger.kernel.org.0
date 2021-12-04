Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5248F468663
	for <lists+linux-pm@lfdr.de>; Sat,  4 Dec 2021 18:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355554AbhLDRH5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Dec 2021 12:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355347AbhLDRH5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Dec 2021 12:07:57 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A578C061354
        for <linux-pm@vger.kernel.org>; Sat,  4 Dec 2021 09:04:31 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z5so25039810edd.3
        for <linux-pm@vger.kernel.org>; Sat, 04 Dec 2021 09:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+IHFqT+1cIu4d25MxA/33I5hw37sbqf3L8hQmO39cs=;
        b=gdi/hrEsdJa+MtfK1vcA4icU4vcH7+xTuMkSP1+Kea3LWAERjc6zptW/sunycSyp5v
         7GO/CviYc2t+irIBL4f5IVweYDR37BBXHv0XPvKNO3yTVOTfhx3PLAdMKNBU8l/5h01P
         gMrZXiGARkAf9jAbSY4vCAHvvk4TJ3KY/gPhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+IHFqT+1cIu4d25MxA/33I5hw37sbqf3L8hQmO39cs=;
        b=TTK7eyVUAiP19snWx0JNpvdMTgJfiJN/nMOXGHirkVuN8MM9HcBDU4ZZOWcdvLrDIX
         OSh62r49cZ+ABFDN3foJauWgsgyKthQzLMnctUuHgZy4YkkmYxEMy4Toxz0qHYG5bUnE
         HwsBzwbkUc0v2jKV/mvAg43HVngmXnq1Apettixn/g9aAQYFLPIx99imBoqv9VD94aSn
         EvqnPKP8+kStvQAMtT9UmMrDUOBL2hzakjTlSMON3wv1ic9k7ErFNWm6URKYUntx/73s
         U9eY5SyFu2rjHjR3RKcZ+FwbC4XXs/nn59fB9Cobinj+t9I7znO0txCk7Ca7ocU1a4D/
         mN7w==
X-Gm-Message-State: AOAM533Zii+f5qgAi5Fg2e14ASCrrwBenp7hrNmu9tw/Y6kH68gOVFy2
        /MsOTit9V+WbxgjfRgf6CE9xrqrFLLJoYFgd
X-Google-Smtp-Source: ABdhPJzxaLxB5NWSM92b21qxIj1AsOhBBzEveBOk9r8V7QXkaXEdPOHxjDMCDGSsd7ClzwjrI33Exw==
X-Received: by 2002:aa7:d445:: with SMTP id q5mr36826937edr.330.1638637469294;
        Sat, 04 Dec 2021 09:04:29 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id gs17sm4187598ejc.28.2021.12.04.09.04.28
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 09:04:28 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id u1so12667206wru.13
        for <linux-pm@vger.kernel.org>; Sat, 04 Dec 2021 09:04:28 -0800 (PST)
X-Received: by 2002:adf:f8c3:: with SMTP id f3mr30048229wrq.495.1638637467944;
 Sat, 04 Dec 2021 09:04:27 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0hQaF-ANLc4JO=Ub_JMsqLFpZev_gmpb=NPpg=zmqcauA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hQaF-ANLc4JO=Ub_JMsqLFpZev_gmpb=NPpg=zmqcauA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Dec 2021 09:04:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGbtmc+FoUjcgaQRavL=B=rfTmA_VhTtGpmhmk2873cA@mail.gmail.com>
Message-ID: <CAHk-=wiGbtmc+FoUjcgaQRavL=B=rfTmA_VhTtGpmhmk2873cA@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.16-rc3
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 26, 2021 at 11:38 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpi-5.16-rc3

Hmm. This may be unrelated, but I don't think I've seen this before..
On my laptop, I get

  WARNING: CPU: 4 PID: 95940 at kernel/workqueue.c:1441 __queue_work+0x2f9/0x3b0
  Workqueue: kec_query acpi_ec_event_processor
  ..
  Call Trace:
   <TASK>
   queue_work_on+0x20/0x30
   advance_transaction+0x1a1/0x500
   acpi_ec_transaction+0x15c/0x410
   acpi_ec_space_handler+0xd2/0x270
   acpi_ev_address_space_dispatch+0x216/0x2a3
   ? acpi_ec_resume+0x20/0x20
   acpi_ex_access_region+0x1dc/0x255
   ? acpi_os_wait_semaphore+0x48/0x70
   acpi_ex_field_datum_io+0xfd/0x178
   acpi_ex_read_data_from_field+0x12e/0x171
   acpi_ex_resolve_node_to_value+0x1fe/0x281
   acpi_ds_evaluate_name_path+0x75/0xe9
   acpi_ds_exec_end_op+0x8f/0x411
   acpi_ps_parse_loop+0x495/0x5bc
   acpi_ps_parse_aml+0x94/0x2c2
   acpi_ps_execute_method+0x15e/0x193
   acpi_ns_evaluate+0x1c6/0x25d
   acpi_evaluate_object+0x12e/0x226
   acpi_ec_event_processor+0x63/0x90
   process_one_work+0x217/0x3c0

and it seems to be happening at resume time.

This was when running a51e3ac43ddb, so not the very latest git tree,
but recent.

Maybe I've missed a report of this?

               Linus

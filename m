Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE3F782F61
	for <lists+linux-pm@lfdr.de>; Mon, 21 Aug 2023 19:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjHUR1r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Aug 2023 13:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjHUR1r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2023 13:27:47 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2E2F7
        for <linux-pm@vger.kernel.org>; Mon, 21 Aug 2023 10:27:46 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-564670fad4bso316688a12.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Aug 2023 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692638865; x=1693243665;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NfGnRSxxU73Njw7QDIO3tunHxi3eC+1sB9vYnAe716c=;
        b=WRhaCMq1Po52oVbtqBPspQtidx3LK0e3KSbnq4ENRnkWw4xo/5JlFlI/UFLxvt6KHG
         7GC0bIElfKa7jStT0PoJGdIKRx2Q9UckKG4Qkevo+Xyw9zDtVFASZMGP+hxjYmbbXEHl
         1kA//TuETLvcWBJaysCTmp9Mbi6OI9RSDfnyTK6gGRhPdV1YazVfr3GXeHvwkLo7aSAm
         XRlDfU+rNv42dceQd8Z58r1JueQQL6kQ+jqjfToPxYMqd2pQWTqzAYJW6IX4BuhaxXou
         2++hmfbDHt6ZmSI+WB2GkiPHVOHCwlkUNVt9cL9C7XkDc4LqtkabYHHqDCxG59ffsCkj
         GdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692638865; x=1693243665;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NfGnRSxxU73Njw7QDIO3tunHxi3eC+1sB9vYnAe716c=;
        b=llGxrJ32TXE38/Esfy6X22sg9wMqCClER+3ItXeq4lYwGJuK7ncip1Lyv273zY5dRa
         NfOgfNnUu8I6o0ssEhfomp3mYyFBnjPC2W7lWbffQSJXN/ekGv1/aSp+BZq3hGAN9r28
         Ud04CvbuOl/n2iySOrbBlHPvMseJO1SwQ+GIbJSM7pqjdJa5Sdz55Fts7vUQjq76H2jq
         PCcFax+38/Ds8yWFWFp+4liDLxKTpEiHv0Cr2eUcpHpOuiD6/ke6Idd593QgPYGB9PFU
         7lZ1lBLEQ5z+HZxuE+JwGQyrnt2sGrF0D3BKAruO/Few9KHttwJqJ5RNDJL3VIw/rZu2
         X+uQ==
X-Gm-Message-State: AOJu0YxTHmWc+iMT7U+KcCzoK7fjfGhOAHe8LIdf2clTH7AlVrMbnDXM
        KyTow1wsnt8fkF8mAh7zFomsDHlEtWaDhhvnRDo=
X-Google-Smtp-Source: AGHT+IHLGxejbIboc4ajQ5mKgUoqM6Qr3MEpLphLQ4SmCiuYf3e8g8n/lN4Ll7tRfN9qyLTBlhErnWwYsyg5WZp9l1M=
X-Received: by 2002:a17:90a:4142:b0:26d:412d:9ce8 with SMTP id
 m2-20020a17090a414200b0026d412d9ce8mr6512703pjg.0.1692638865412; Mon, 21 Aug
 2023 10:27:45 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 21 Aug 2023 14:27:33 -0300
Message-ID: <CAOMZO5ByXdEK6Zsa3ObNinnROn=qsde_xvn3WcR2RLioMKk0JQ@mail.gmail.com>
Subject: imx8mm: Forcing a reboot when critical temp is reached
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I am working with an i.MX8MM-based board and I do see that the system shuts down
when the critical trip point is reached, as expected.

As the board is unattended, it would be more appropriate if the board
could reboot itself instead of shutting down when the critical
temperature is reached.

The bootloader has a mechanism to only allow to boot the kernel when
the temperature is below a certain temperature.

Is there a mechanism in place to force a reboot instead of shutdown
when the critical temperature is reached?

Thanks for any suggestions.

Fabio Estevam

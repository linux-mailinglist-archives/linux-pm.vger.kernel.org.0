Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33D2258DC9
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 14:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgIAMAt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 08:00:49 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42660 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgIAL5t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 07:57:49 -0400
Received: by mail-ot1-f67.google.com with SMTP id g10so885143otq.9;
        Tue, 01 Sep 2020 04:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bS1viyL8NjfwjcMbt5ItRCCKbfY+WgWbL+lmwBqbddk=;
        b=XCQGOoNfFs7MiAmmizNo4TWmVBcua3WaMZz7HcTQXw8pErpaf8/8UqzU5o8Tp2urpO
         FGyrXrTHYR1XQmgTVZi+60BVNpF7sI2M0gajqmo2AIXkPQsPoNobexCEikXHN3eqIw94
         e1dVimrJKJKOR01Vpr0Ch25gfgHPbhYTgqD/yvWOuGR8uJD2hlhZG9m/TxIQptd/RypT
         1MkCmkAlnW0b6nbN6zvkfmj+mx2RseZjyW1P1S88GY5B0whn3L4fNTEN2b2WYxi99tbu
         jgbtaUhY9aQcpOy2vmYdc8/FT+6XmJ8dQP+4uOtZe3umVF0aWjyq+xWrGxL/LeHVkmTn
         oHVw==
X-Gm-Message-State: AOAM5330+LDVvHLTMO/w5s1GmWoxNlq4Dwt5cmz+uOGZJOdnlmLhMRZz
        GsdKY/qVKUDwhej8hczlpR2XqOpsqBFCBqASUgU=
X-Google-Smtp-Source: ABdhPJwOq6HEEjQ3xAjudQZKFJPfbYu1NdSQrGq3FL2K08dbGzeOdfoH+V2BBxV3R1Xz+2libeoWvf6J9F6bWaodlSI=
X-Received: by 2002:a9d:7e99:: with SMTP id m25mr1059559otp.118.1598961464586;
 Tue, 01 Sep 2020 04:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <1598943859-21857-1-git-send-email-claude.yen@mediatek.com>
In-Reply-To: <1598943859-21857-1-git-send-email-claude.yen@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Sep 2020 13:57:33 +0200
Message-ID: <CAJZ5v0hOGEUamXw124q4CnL67o97qRHy9Vv9_F2AQqefDdu3vQ@mail.gmail.com>
Subject: Re: [PATCH] PM: s2idle: Introduce syscore callbacks in s2idle flow
To:     Claude Yen <claude.yen@mediatek.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 1, 2020 at 9:05 AM Claude Yen <claude.yen@mediatek.com> wrote:
>
> This series based on 5.9-rc1
> This patch makes s2idle call existing syscore callbacks. Currently,
> when s2idle is selected as system suspend method, callbacks hooked
> by register_syscore_ops() will not be triggered. This may induce
> unexpected results.

They are not executed by design.

> For example, sched_clock_suspend() was added to s2idle flow in
> commit 3f2552f7e9c5 ("timers/sched_clock: Prevent generic sched_clock
> wrap caused by tick_freeze()") to fix clock wrap problem. However,
> sched_clock_suspend() is originally registered in syscore callback.

I'm not sure why this matters here.

> With this patch, if another syscore callback is needed in s2idle,
> additional migration effort could be saved.

s2idle cannot execute syscore callbacks, because it doesn' take
non-boot CPUs offline and it won't do that.

Thanks!

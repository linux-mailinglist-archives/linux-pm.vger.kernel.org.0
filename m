Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1DF489F8C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jan 2022 19:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbiAJSty (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jan 2022 13:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239913AbiAJSty (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jan 2022 13:49:54 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52A9C061748
        for <linux-pm@vger.kernel.org>; Mon, 10 Jan 2022 10:49:53 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id u13so47602674lff.12
        for <linux-pm@vger.kernel.org>; Mon, 10 Jan 2022 10:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jaXzWb8RIYggtumZsRquSImyXJVvqgGVeqysl2CjfNs=;
        b=IwCpV9hqvo50xIXYGoYiOow1RTXRzZo7PKZJjfCTn13mW8l9wl9EInMYf83Pb1KtHW
         q6rPtrMCBguxNQp3+UIOrQNBOEaNW4z1jwOHmFqeHxloxBdSljnRwDnXJ61BFjJtOspl
         mzqfZnx8aoXoI7XsciYTiGZDlgigps74TTbqySregXY0YMT3tPBBXCpnr9YrTc5L+oaw
         wVENgAQd7zOxIM1/atqXqxF5tivHgQdvYRqGp1okLa68fUduUXgezhkKAWxcu6TFfJoF
         7Wk7ZfdSJiTxnEbdOw1JU04j1NXecY2ufE3JCOMOYGYHuhvFCAr0WuZZhI+M5HU/T9OI
         7Ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jaXzWb8RIYggtumZsRquSImyXJVvqgGVeqysl2CjfNs=;
        b=0jq/lnbOfAFXw/RPB4TXVToN+5nUNW8deza825OWhlh4C093NSy/S/My9F3ePwXk22
         tuLxI6t/YJ2sgb9g91DBuY3q8GVZJxllejIsEcU0Iso4hQsXAvRCQorcESr34jRy0EJJ
         oMl465l2dZuxqACgY0m4i1MvOHi2Kb78x/G2vDUhgN2OARyniq2eSawCYObbknwBx6Ye
         Iek53HGs+uVoPgTCnhJol03J0cEtnWeRhgJd4IEb33SDd1M62FevLHkyF5h5usRlB9Lg
         m5lvad4TyX1hTJGdlZmk++7vxajUb+W9m11/eT/ZDi4M1O6M6eW7yinDORpAy7AKFKUY
         AMFw==
X-Gm-Message-State: AOAM532CVjymFHIiinCLAIJ/m8ihNFGMxHsRQn3PqeIa1UAjwU9tIrrT
        PHekHI5YVjUZa4icurngbcpxDwVCoaxpBR36skCT/w==
X-Google-Smtp-Source: ABdhPJwjegyxg0bdZ8Zl85KkHVjwm9LjDPonIAZnkNAkwCS/RJdKgnpG5w9l+AAc6SdkIJXrkrRu1/12whOyHhCbSgU=
X-Received: by 2002:a05:6512:1116:: with SMTP id l22mr735334lfg.253.1641840592002;
 Mon, 10 Jan 2022 10:49:52 -0800 (PST)
MIME-Version: 1.0
From:   Kelly Rossmoyer <krossmo@google.com>
Date:   Mon, 10 Jan 2022 10:49:15 -0800
Message-ID: <CAHTsKTdSyC7Jwk56tDR8QwM_oO13ByBRaA78VpHymOZ7J4NQ9Q@mail.gmail.com>
Subject: [RFC] PM: suspend: Upstreaming wakeup reason capture support
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Vijay Nayak <nayakvij@google.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

# Introduction

To aid optimization, troubleshooting, and attribution of battery life, the
Android kernel currently includes a set of patches which provide enhanced
visibility into kernel suspend/resume/abort behaviors.  The capabilities
and implementation of this feature have evolved significantly since an
unsuccessful attempt to upstream the original code
(https://lkml.org/lkml/2014/3/10/716), and we would like to (re)start a
conversation about upstreaming, starting with the central question: is
there support for upstreaming this set of features?

# Motivation

Of the many factors influencing battery life on Linux-powered mobile
devices, kernel suspend tends to be amongst the most impactful.  Maximizing
time spent in suspend and minimizing the frequency of net-negative suspend
cycles are both important contributors to battery life optimization.  But
enabling that optimization - and troubleshooting when things go wrong -
requires more observability of suspend/resume/abort behavior than Linux
currently provides.  While mechanisms like `/sys/power/pm_wakeup_irq` and
wakeup_source stats are useful, they are incomplete and scattered.  The
Android kernel wakeup reason patches implement significant improvements in
that area.

# Features

As of today, the active set of patches surface the following
suspend-related data:

* wakeup IRQs, including:
   * multiple IRQs if more than one is pending during resume flow
   * unmapped HW IRQs (wakeup-capable in HW) that should not be
     occurring
   * misconfigured IRQs (e.g. both enable_irq_wake() and
     IRQF_NO_SUSPEND)
   * threaded IRQs (not just the parent chip's IRQ)

* non-IRQ wakeups, including:
   * wakeups caused by an IRQ that was consumed by lower-level SW
   * wakeups from SOC architecture that don't manifest as IRQs

* abort reasons, including:
   * wakeup_source activity
   * failure to freeze userspace
   * failure to suspend devices
   * failed syscore_suspend callback

* durations from the most recent cycle, including:
   * time spent doing suspend/resume work
   * time spent in suspend

In addition to battery life optimization and troubleshooting, some of these
capabilities also lay the groundwork for efforts around improving
attribution of wakeups/aborts (e.g. to specific processes, device features,
external devices, etc).

# Shortcomings

While the core implementation (see below) is relatively straightforward and
localized, calls into that core are somewhat widely spread in order to
capture the breadth of events of interest.  The pervasiveness of those
hooks is clearly an area where improvement would be beneficial, especially
if a cleaner solution preserved equivalent capabilities.

# Existing Code

As a reference for how Android currently implements the core code for these
features (which would need a bit of work before submission even if all
features were included), see the following link:

https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/kernel/power/wakeup_reason.c


--

Kelly Rossmoyer | Software Engineer | krossmo@google.com

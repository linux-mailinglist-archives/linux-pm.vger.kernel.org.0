Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA30F1EF70F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jun 2020 14:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgFEMKm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 08:10:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43725 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgFEMKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 08:10:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id u23so7389317otq.10;
        Fri, 05 Jun 2020 05:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ki0XRRt/3xylS2T7+BudBy+Y2/q2g6zhA3yfCqfbxE0=;
        b=dk2Dm4C267jEc5CVqmcRgY5RJGl9lBjbH8fVkw+UC5HzpPfhH+zLkoN3QAv7wRgNH5
         R5sJpxY7acyw0pTQNaRcE0WzJFJh9L3YYJLQveLSXU0MxqgsZIk0qV4bzBRtaoyzJP/z
         o8wnOVHfZBxJhj7G3hg4hBhefAN8tpVTUWPFZP9tSrh8LwpuTjA2Uov2j0xcuUgYRmyY
         z3bQ5Pl0SAwcJJHsB2hjrXdM9hlRxCqvTsb3SUzwZOo8OkDXzfh44dyPYONRtn/4fi25
         mQ4xxVe68noj/T4zzL8xxMYH2VJNoWfdw55vwWq0eZRo7WnkUsBQyJTL9b79THCa/cWv
         x1AQ==
X-Gm-Message-State: AOAM531R1OWfyNArvf0qkZAImgGIebTk7YPOZ2MFSTN9u7tvlINv5m4v
        lNN9B1nUyjcYb4LV77tqXX4on7X5wK0E/8f5bh4=
X-Google-Smtp-Source: ABdhPJyHw96qrI71jDhVPI5gmoPjUoqV7YYa2stYFxVhrtUOTBQZp72w5lsLlPJKXihcUL8pzSZ1tQUCksbYhaAckeE=
X-Received: by 2002:a9d:5185:: with SMTP id y5mr6958142otg.118.1591359041284;
 Fri, 05 Jun 2020 05:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <94fe944c-c528-9459-fc75-7c94273dd2b1@gmail.com>
In-Reply-To: <94fe944c-c528-9459-fc75-7c94273dd2b1@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Jun 2020 14:10:30 +0200
Message-ID: <CAJZ5v0i-6PBa=UuOkwZhmGvEpuUYkMeu9eubbvUNcGvc=DmDuA@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: add RPM_IDLE_SUSPEND / RPM_IDLE_NO_SUSPEND constants
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, May 30, 2020 at 6:33 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> runtime_idle() callback implementations have to return a non-zero value
> if they don't intend to suspend now. Several drivers use an errno like
> -EBUSY for this purpose. This can be problematic because the return
> value is propagated up the call chain, from rpm_idle() to
> __pm_runtime_idle(), and from there to callers like
> pm_runtime_put_sync(). A driver author checking the return value of
> e.g. pm_runtime_put_sync() may as usual check for retval < 0 and
> bail out.

Which would be a bug anyway, because rpm_idle() may return -EAGAIN or
-EINPROGRESS due to concurrency and -EBUSY should be treated
similarly.

> Therefore a positive value should be returned.

While it is recommended to return a positive value then, returning
-EBUSY or -EAGAIN should still work if the callers are careful enough
(and they should be).

Thanks!

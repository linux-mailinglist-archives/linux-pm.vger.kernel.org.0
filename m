Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC1E5C28E
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 20:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfGASDE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 14:03:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35315 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGASDD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 14:03:03 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so30905452ioo.2;
        Mon, 01 Jul 2019 11:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2tpItKwuKZOogitEmK5udMyyQM1691xM5APcPto608=;
        b=Wfo6MybS7hH5DKgNXldkNyj/G7ZcAkedgRpXC1z/5iSm+HK5Xk1PMACgeewleePYHB
         MUxt71ZWh+8eRyEcTP5BZGIilgCuE5rPk/k6+4dUbg9Ob/3iTbU0/wnOsu7an/o1gSsK
         DrvnCo3rOf8Sua0uIWAlO2+0FLa0Mjd/F3LoyD5yZpsal9sso2OMfFoPyFNBLIE1ZdmS
         9Y4V7SpcZMDLudhphdChqGcObQvCtDqvkWvqtK4UkMGbO0EF29Bdf68FvhqRa/Hz2a/5
         xR4qAZvsrEQFIt16yYWSXChJ4kLjyVUkf6kd0eSNBhf+Qq68hpHGQGx/N9hSlHbdMDi6
         YRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2tpItKwuKZOogitEmK5udMyyQM1691xM5APcPto608=;
        b=fHvo4ydlyBV+MIUkhqAltG0rFEPhzEXZNbsmyXRN1ndBUDxYyHkPpiXSJgPyCn3FL9
         nqf0olVVPMEnexnKlG6rjJjgNFaDz4e4DFvn3q6ZNby3045CfhIgyYopBFsuFiEHE0gG
         QTNs6NCVGW0BKXd4oWH4vVlwMmGKqpjIxJbXv5OztHIvA3sq6SDlNH9rDpocLbRL/NRL
         +6WRc7fJe5mVGL/5+D0elCxq58v4sAkmB9yGZuQKLCW/oJ5o1XinMDt7OBFHMsbjCJFl
         sg6xsPKWqF4DdhbK3kFvgFGfYPmyL1l5/Brt6nGrBjfgFELqCtx9NnVoUWvK6ybJqpmV
         hwzQ==
X-Gm-Message-State: APjAAAX3ohTcZo7T6413+l0MeTg5bmDVjWN5NiEuXR8MuJGmN7FSQAsv
        93ICWwsEODu5CJEoHZ45GeVQi4iXMLuzyL0IZ/c=
X-Google-Smtp-Source: APXvYqwzMbEiuqzBEGi8Ma814/2Wm8+1QLsd2TC+xpIY9gX5+hw7VVWydloLi3QoDkPpFr8OY2VVgWK6VjVIqQicj+g=
X-Received: by 2002:a6b:f607:: with SMTP id n7mr548056ioh.263.1562004182900;
 Mon, 01 Jul 2019 11:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190630150230.7878-1-robdclark@gmail.com> <20190630150230.7878-2-robdclark@gmail.com>
In-Reply-To: <20190630150230.7878-2-robdclark@gmail.com>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Mon, 1 Jul 2019 12:02:52 -0600
Message-ID: <CAOCk7Np7jjdzbhX2qUf4h-JyLrqSwthX+=7Hd3vQETBtQDp9DQ@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH 1/5] clk: inherit clocks enabled by bootloader
To:     Rob Clark <robdclark@gmail.com>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        aarch64-laptops@lists.linaro.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 30, 2019 at 9:02 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> The goal here is to support inheriting a display setup by bootloader,
> although there may also be some non-display related use-cases.
>
> Rough idea is to add a flag for clks and power domains that might
> already be enabled when kernel starts, and which should not be
> disabled at late_initcall if the kernel thinks they are "unused".
>
> If bootloader is enabling display, and kernel is using efifb before
> real display driver is loaded (potentially from kernel module after
> userspace starts, in a typical distro kernel), we don't want to kill
> the clocks and power domains that are used by the display before
> userspace starts.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Seems sane to me.  I'm curious what Stephen Boyd thinks.
I'll try to give it a spin on one of the 835 laptops.

Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

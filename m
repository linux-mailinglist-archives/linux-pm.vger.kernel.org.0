Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99CD4AE4E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 00:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfFRW4M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 18:56:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39340 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730532AbfFRW4M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 18:56:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so14336622otq.6
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2019 15:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJ5LRH3aSkUT8+emIV4gcPDlPDy8wH64a0B2BUGXeBo=;
        b=RPlHdt8AqIofYiCvpdqq0CPzYVe2zITlP/aNVy4VYHEs87wey/Y/EqqH2Nx89LO9tE
         GGGvYFl2KhyypNcAgQMB2wx5xboB4ZqRQq09kU32VBqGu9sPdSOAkML3iqNELBVaWDS/
         493Vv/c+suOTZt13p08tMDnvm8rYgS9Iephqkkmgv/ZxOMumO7bG3/hU+1G+CZDTUw84
         rapaWjpzP/Lk5EqVpOQ9op+cGxL2I2O1lvS3NZYuGawHhRJB0u5EXhfM8LpSUyuFlOvC
         z6lHGrhSyl6RRAAj8jIGzEYBP89ZnNPwTMmcOddr1IXu8sNgsfF27hSoqg6Z4HRph29a
         +2Hg==
X-Gm-Message-State: APjAAAVgpJobvoJFN6S62GlTRfQgr7TAa2A4gU8p8CgTy+DQvTbUi9c4
        RI765YfcUodJEKm/9EjkNUCgOHUv1N5SP1Ik+yc=
X-Google-Smtp-Source: APXvYqzHepwLzt2ZdFygVsQYdBDoY//SSrF5XiZWYRYxMGuUaom0ts8hmxdc90vjlrz28egr1k8xUl9g2/PcinQSYjE=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr1919153otp.189.1560898572106;
 Tue, 18 Jun 2019 15:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190605161237.176983-1-bvanassche@acm.org> <0b367c17-11a9-3f37-4359-8c15703e8828@acm.org>
In-Reply-To: <0b367c17-11a9-3f37-4359-8c15703e8828@acm.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jun 2019 00:56:00 +0200
Message-ID: <CAJZ5v0i5pm65tQSXC0quOgMHWm5ozWUm3ShFgFsU7MrDko_1JQ@mail.gmail.com>
Subject: Re: [PATCH] PM: Show how long dpm_suspend_start() and
 dpm_suspend_end() take
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 19, 2019 at 12:54 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/5/19 9:12 AM, Bart Van Assche wrote:
> > When debugging device driver power management code it is convenient to
> > know how much time is spent in the "suspend start" and "suspend end"
> > phases. Hence log the time spent in these phases.
>
> Ping?

Already applied.

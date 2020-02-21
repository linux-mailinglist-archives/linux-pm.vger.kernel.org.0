Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3CE6168161
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 16:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgBUPWN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 10:22:13 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42827 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgBUPWM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 10:22:12 -0500
Received: by mail-lj1-f194.google.com with SMTP id d10so2556654ljl.9
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 07:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=exuAjtpKxgZ7i5AH9HXCKWVlRd9sU0cfO8mDnBFc0RU=;
        b=nWJQI+9L7DCA8Ayl9t/XIuyrE3NcUydyRFAA89Dndn5F/u38EWON/eVC6HJGZDfkIZ
         aZoE1J2/bQVxvRODxYDS3VWDPkqPM2kp1s3wFzYR3eZ9Gr9hLxaY4yRTOl8C6lS5GBCe
         j4/hZazy5ZeyDNWILADRjbQFkNY9N71WMwZlFhUyFod9wTrQCHl/IRMSea8I0PsHNPyH
         /r8AyZCi0g/HW6x1SlG7/N6Z7rmvSQcvWhLcp9suy3ypfiihHtLePeNGrW2XlkKaECfd
         /p18fg+AXexJlKHc4jc3XDJ5esSgJI8uh9MwK7AUTJRv9GxuqOr/eM39t3rIgP/H9RCI
         F6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=exuAjtpKxgZ7i5AH9HXCKWVlRd9sU0cfO8mDnBFc0RU=;
        b=n8GEQNV/76n6anlSxomv0j7RsBwxMJuJ25SJB7GvJvQS1TwgjMXhseMXmOrNC5vNyW
         ioDMxu4Xwi+mrSCc4Xb6efBvg5i9uD6wUIjrh9/FEGQrUzjy08hOeBmC/Px/tOUi6P9q
         2lpeqBZuFJWWuPHjqvtUzPq8qJgwIUIsCQnc+9ph123yExX3gI2zxsS/MAcRRUGXZ3Xg
         WASbpnjai9/ocwq+ZpIgLDAyZu3jeTUFwgylwaxXXU5SG0ZRsluoIGcZgC0bO4I8o6Wh
         4ogVoyrAC5W49nwwlH8AIlF/kwSWMM47Q7Kia/QQjLhrminju93wKIAHqZ/YB1ODTlwx
         hXsg==
X-Gm-Message-State: APjAAAWlvHid+I5ivKvrIdWCZA/Zwm5obdDEZU3Vy6gs/41Vyr6mible
        6czvvz6u0FF3rz6OL6RDEcYWpIDG6ZVctREkRWGLZw==
X-Google-Smtp-Source: APXvYqwZU623dWBmI+RqyZ+fasWfep+rEmqFbWrsvBd4fMrL/FDepPpf5X5DjWg3+ZKIgPDrckxSlsGph5amZfGYv/o=
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr21858980ljg.168.1582298530346;
 Fri, 21 Feb 2020 07:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20200220050440.45878-1-john.stultz@linaro.org> <20200220050440.45878-4-john.stultz@linaro.org>
In-Reply-To: <20200220050440.45878-4-john.stultz@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 16:21:59 +0100
Message-ID: <CACRpkdYVQs0dDT8dn2GzQQXrbXATRi8iqHB41EQBMEwMiEFgzA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] pinctrl: Remove use of driver_deferred_probe_check_state_continue()
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 6:05 AM John Stultz <john.stultz@linaro.org> wrote:

> With the earlier sanity fixes to
> driver_deferred_probe_check_state() it should be usable for the
> pinctrl logic here.
>
> So tweak the logic to use driver_deferred_probe_check_state()
> instead of driver_deferred_probe_check_state_continue()
>
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Change-Id: If72682e0a7641b33edf56f188fc067c68bbc571e

I sure trust that you know what you're doing here.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I assume you will merge this through device core?

Yours,
Linus Walleij

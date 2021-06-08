Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9513339F19E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 11:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFHJF5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 05:05:57 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:37501 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhFHJF4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 05:05:56 -0400
Received: by mail-lj1-f182.google.com with SMTP id e2so26043614ljk.4
        for <linux-pm@vger.kernel.org>; Tue, 08 Jun 2021 02:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0ds+l2wwmikGBIkarzC+RWkNxvJMelGG4IknEWp7ak=;
        b=QzWpE4d7Czo3Zzuvhv+Wm8SOjKM7edThMVzlJK8RuUE5nNdoUEl19aWE/sd7LJmDHJ
         VqKCUb0i6PoLbvwyCMdn1VDa7/12/HC0sX0CyTwfcQgofGUxwmOY6YgoMa4J8armXTDn
         Jemd4DUXYbGk5wjagB0xfxRN/IIdjw1HWDjwNwFFMNbSnCA+s/WWOwZ1C+XkH5sN4nlm
         Sx8R1byKEXnCGlAClEtDjrPJJiL9xxPGswV/Z8x/EGAGVU/Lijv5j4QTCUXfqJdPvQ/k
         A6MmbefYfSU/d7S32LbjloQfzUELzcIHsB+ty+To3ojyeGIM6fvi7luoHXiA8treZv9K
         xbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0ds+l2wwmikGBIkarzC+RWkNxvJMelGG4IknEWp7ak=;
        b=dfW2o2iCsl99jULBV+Avd1O4aayIMKkRhFU4NYaKAGOHXybpnfvOXqQjALY7fM8lz5
         itPLAZJGInB5c+RPdmjZo4G6zkYL4zm9kDb0qZmn2VFLgYkrIOdBHtTES0+VjyreFgnH
         zloMrCiHftCNJJCNZEIDzTgpVnAH8lUqafP5SoTqhv+xVdnglYT+mcYNa8B7J7NpSzfC
         jmOAvGoEMaV+0htpISctZEVO5OH8cK1LrKBeTolzmEHZM71jC7TnPResvCySYvSpbO0H
         DEKf70/Cqxfd9GxV6eSSI6VSnnlwjzk2eXHXBMYNedJ0yMZLVu3qyTkHnYabolOqncSe
         R7xw==
X-Gm-Message-State: AOAM5333+8IwUb9js+k6gD5c+10paCaAhJcKSFHQUM5OttTogXjIvCvT
        05KJ80ikH10FZmqSV1PFlIlfHA==
X-Google-Smtp-Source: ABdhPJwkH3G8ZdlvfKKYqYu8Q01goGfnSxTrJLfHwYUX4RxNytFLFgCXQO7z+MAGuPyDCnsi8X9ewg==
X-Received: by 2002:a2e:8817:: with SMTP id x23mr17928556ljh.17.1623142982721;
        Tue, 08 Jun 2021 02:03:02 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id n17sm1295197lfq.118.2021.06.08.02.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:03:01 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] PM: runtime: Update behaviour for no callbacks
Date:   Tue,  8 Jun 2021 11:02:47 +0200
Message-Id: <20210608090250.85256-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While reviewing a patch on the mmc-list, I ended up inspecting the behaviour of
how we deal with the no callback case for runtime PM.

A couple of observations:

*) When pm_runtime_no_callbacks() have been called, it allows the PM core to
takes a quicker path, but at the same time, consumer/supplier device links are
being skipped in rpm_resume|suspend().

**) Calling pm_runtime_no_callbacks() to avoid boiler plate code (assigning
empty functions to ->runtime_suspend|resume()), doesn't work if there could be
consumer/supplier device link being used or a platform dependent PM domain that
could get attached to the device.

Therefore, this series suggests to change the behaviour in the PM core, to
allow the ->runtime_suspend|resume() callbacks to be unassigned. This is already
supported for ->runtime_idle() callbacks, so it would also move things into a
more consistent behaviour.

I have looked at various error paths, in the kernel of callers of
pm_runtime_get_sync(). I couldn't find anyone that made sense, that looked for
the special error code, -ENOSYS, which is the error code getting returned when a
callback is missing. Whether that is sufficient proof that these changes are
100% safe, I can't guarantee, but I think it would be worth a try as the
benefits of avoiding boilerplate code and the corresponding additional code
paths are quite nice, if you ask me.

Kind regards
Ulf Hansson


Ulf Hansson (3):
  PM: runtime: Improve path in rpm_idle() when no callback
  PM: runtime: Allow unassigned ->runtime_suspend|resume callbacks
  PM: runtime: Clarify documentation when callbacks are unassigned

 Documentation/power/runtime_pm.rst |  8 ++++++++
 drivers/base/power/runtime.c       | 18 ++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

-- 
2.25.1


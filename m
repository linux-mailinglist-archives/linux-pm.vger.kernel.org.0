Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F51310CC8F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 17:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK1QPE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 11:15:04 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45724 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfK1QPE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 11:15:04 -0500
Received: by mail-oi1-f194.google.com with SMTP id 14so23666087oir.12;
        Thu, 28 Nov 2019 08:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSC7F7yk/BW+Fyk3jmUFf+tZZmOgmave+L/zyXMm1tM=;
        b=NTILan0CH1oEYJkD4tFsaQQEY4Q0cl4SVZOKyGekEogEZc7zEMPlHqbPrPUwgE7qql
         HNgnLjFwQlFsgv7ABO9539j9iUZ2/3KNd8ye/wp3R18g27Zl0qRfH1F5GPIn8Hf03scA
         OqWog5AAHYjjz9v56qSoNo3AkoM2Jq2T5UEVSBe1CouA8KcEJCnHYGrvoGlz0HBC4CbD
         q4g44zhT6Us6V7rQzjRnUqieWt1VP+6rJqZ+QwnVs7+hvSgpRfhq3L3KeVfnmx/XZ1ra
         tGB/oIBtiF+40chXW2kvFNGVIuZ/VM2RjFHoKgJIzO8bjl/aiJdSO9ZThs2tz0cnI7yW
         cC1g==
X-Gm-Message-State: APjAAAW3sZIhwCTbS+L+tN7jpFhi+lw+H9B2DVAJZUkfig5YPo4fjLq5
        1azD8KG0t9eYgFv2XxisSjBFSNnRRp8u+Cbwk1I=
X-Google-Smtp-Source: APXvYqwhxMUbMGhmMJprgyvzx11BYfaTLnL/vCA9TVN0vVRheLA/jfsQ+eIH24QAnWCqyRTbBQaVbxlcCQSivdHhRCo=
X-Received: by 2002:a54:488d:: with SMTP id r13mr218717oic.103.1574957703131;
 Thu, 28 Nov 2019 08:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20191128160314.2381249-1-thierry.reding@gmail.com> <20191128160314.2381249-2-thierry.reding@gmail.com>
In-Reply-To: <20191128160314.2381249-2-thierry.reding@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Nov 2019 17:14:51 +0100
Message-ID: <CAJZ5v0haOB1vc8aKk11RR-OnfLHChcqa+z7QkeKyN66s6xM3OA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / runtime: Allow drivers to override runtime PM
 behaviour on sleep
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 28, 2019 at 5:03 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> Currently the driver PM core will automatically acquire a runtime PM
> reference for devices before system sleep is entered. This is needed
> to avoid potential issues related to devices' parents getting put to
> runtime suspend at the wrong time and causing problems with their
> children.

Not only for that.

> In some cases drivers are carefully written to avoid such issues and
> the default behaviour can be changed to allow runtime PM to operate
> regularly during system sleep.

But this change breaks quite a few assumptions in the core too, so no,
it can't be made.

Thanks!

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6CA60532
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 13:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfGELRw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 07:17:52 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37173 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfGELRw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 07:17:52 -0400
Received: by mail-oi1-f193.google.com with SMTP id t76so6909196oih.4;
        Fri, 05 Jul 2019 04:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJykiUYFj6hzG7xUJGriRTMCMv/u4A8O1aHCnEkl0w0=;
        b=eFlv+G3qbY1HGuPxHLPxDh0TGeXEOCmFgtQE/OTBenfXytrW8KjhugOviYvx2Et6FH
         bGg6tbjZf176yR4EyREsBJ4hm4h2unwoVbNeagOe2UxGU91wba8H3BrTa65CnQ7lZOun
         aTiyowJ31OsVN22GSyvbzvdTC0c55EVHW9SrhB+69GOxzFXs0sA78gIzOqVbwwzCZCzd
         gIkNMigNknqnGduysM5EIBqfelHaxfgWWOa8mxPb+ahWMEL9nCu11GF8oH9VYwmpdcy5
         zDI+qw6R4aD6QvARs5zTATJbaojaIBY/Ocdt3NOrdj/TajF9f8JYKvU+VtNpn4+nH7H9
         NR1g==
X-Gm-Message-State: APjAAAVTJKWYhBH8DlHoxl7Lhaj38FxvLbCFjfdEq5DLa1/6yHAxeVx1
        GL6kCO8DFFSjfhlvLMd8Qp6Ctfludke5fvfLzoU=
X-Google-Smtp-Source: APXvYqyA4zxAOi+yjyxTVf3p2c2E7VT6zUb8ULRSkez1ua3b/aYJNXRlSKGyy6dqbLT6ZO99XyiRYU0sfcXqY+GVzGs=
X-Received: by 2002:aca:edc8:: with SMTP id l191mr1690147oih.103.1562325471384;
 Fri, 05 Jul 2019 04:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <0d4c2a013b32bf18d45817011b028918220580f5.1562210705.git.viresh.kumar@linaro.org>
 <7589f158a5522ff04ba2b63daca77bcdd4952f74.1562323803.git.viresh.kumar@linaro.org>
In-Reply-To: <7589f158a5522ff04ba2b63daca77bcdd4952f74.1562323803.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Jul 2019 13:17:40 +0200
Message-ID: <CAJZ5v0h+wm5d4d3_NfYp-LY=oaJkTZaMMfdR=EjTOOkhw9PFZw@mail.gmail.com>
Subject: Re: [PATCH V7 7/7] cpufreq: Add QoS requests for userspace constraints
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 5, 2019 at 12:52 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This implements QoS requests to manage userspace configuration of min
> and max frequency.
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> V6->V7:
> - We can't call dev_pm_qos_remove_request() for a request which was
>   never added. This happened in one of the error paths. Fixed that by
>   allocating the requests only right before we try to add them and also
>   take care of things properly during errors.
>
> @Rafael: Please apply this version instead of the diff I supplied on the
> WARN email earlier. This has proper protection in place at many places.

Applied, thanks!

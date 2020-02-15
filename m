Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05D9D1600B6
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2020 22:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgBOVcz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Feb 2020 16:32:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:35332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgBOVcz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 15 Feb 2020 16:32:55 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154AF22314;
        Sat, 15 Feb 2020 21:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581802374;
        bh=FJlM6awljKheoHJxHVog3hx9VpLfCwBGD88kyRsUC5A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gFCK9jrX9lelGW+XhAR5NVe9mv9TFIbyOiz2B7Y3cdBk7OTAskVlpFX2vf8Yv6mc+
         gDzUz7RX8okD9saHqoIq0kx68UBD8MmdcO+0S+GSwgP39r6LbbQ+JzYzYT6otK0+dZ
         D16P4zrRgAK4y6QiKqFvPdTtT+6KbulyxUg4UXH0=
Received: by mail-qt1-f171.google.com with SMTP id d18so9498801qtj.10;
        Sat, 15 Feb 2020 13:32:54 -0800 (PST)
X-Gm-Message-State: APjAAAXNMaTjCmp6zVY1ylzOtGIYl1iWa1fmWhgqZnlfdTIeZzTJo+Fu
        HeN/9zvj/WUVRMr/J0G+sV+M/VcFmv7tvbxuIA==
X-Google-Smtp-Source: APXvYqwU7jQTYPG9ycP4S16NzWKydsVGJSD7UE7tmbPM0G507fDjypLqTfr56JuKKhazhtu8N3j7A7CTD06AK+VHBVw=
X-Received: by 2002:ac8:59:: with SMTP id i25mr7813033qtg.110.1581802373165;
 Sat, 15 Feb 2020 13:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20200214233226.82096-1-john.stultz@linaro.org>
In-Reply-To: <20200214233226.82096-1-john.stultz@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 15 Feb 2020 15:32:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLrrRUJ=rtkNV-xr8A_KHGYnMFm6F15c1=xPZt3=SdJ4A@mail.gmail.com>
Message-ID: <CAL_JsqLrrRUJ=rtkNV-xr8A_KHGYnMFm6F15c1=xPZt3=SdJ4A@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Extend returning EPROBE_DEFER for two
 minutes after late_initcall
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 14, 2020 at 5:32 PM John Stultz <john.stultz@linaro.org> wrote:
>
> Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> at the end of initcall"), along with commit 25b4e70dcce9
> ("driver core: allow stopping deferred probe after init") after
> late_initcall, drivers will stop getting EPROBE_DEFER, and
> instead see an error causing the driver to fail to load.
>
> That change causes trouble when trying to use many clk drivers
> as modules, as the clk modules may not load until much later
> after init has started. If a dependent driver loads and gets an
> error instead of EPROBE_DEFER, it won't try to reload later when
> the dependency is met, and will thus fail to load.
>
> Instead of reverting that patch, this patch tries to extend the
> time that EPROBE_DEFER is retruned by 30 seconds, to (hopefully)
> ensure that everything has had a chance to load.
>
> 30 seconds was chosen to match the similar timeout used by the
> regulator code here in commit 55576cf18537 ("regulator: Defer
> init completion for a while after late_initcall")

My intention was not to copy the timeout value, but use the same
timeout (which should be configurable on the command line IMO). There
doesn't seem to be an easy way to hook the regulator code into the
deferred probe code though. Maybe just make the timeout value a global
var.

Rob

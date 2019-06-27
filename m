Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A4458D23
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfF0VeN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:34:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44404 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0VeM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:34:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id b7so3807662otl.11
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2019 14:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uu1cBiiGAo/tbASDtMwTf1o4Bx06ro1cmMYABiAiDcs=;
        b=s1FUypo1YVV6wcX/iwnDz3ogWMmqfxJFnwtEFqcIUPGXjEYTz+vie5LfYMZzPdfvWR
         VryQw0uDikM+8xOrRC3DHg6PPBUoANQzUoYUKUdX8ZEOxE9cVT3XmjRQkesK7jHyHWIE
         6FUvhmJ+yZNtXo8/33V07fBJgDtQ7fYfKGShFYaOcIoQMPkXEzUXY7WWUNoAVrtX2sNG
         +pVClxrgFt3FLphLMPXJ2UoSGDnhFE0wAQSj76jkmUjJg2yKZCH0We1NqLcio+y6Gn+D
         Z9iykKbD7h25nmbckoljMop8vQdRsSNBRqffm9oATClD6wBzYp2jBzWA3ShoN7yNzbEH
         cIZw==
X-Gm-Message-State: APjAAAV0ZY7OKOdOAPF3FQAmr7zTP2H2qNPAZx1xWPrYOiOpFQX531Mg
        L/CuB/UFEyKfSzcL/yzyXH0t7gbCuFpu7AoTmno=
X-Google-Smtp-Source: APXvYqxD+2pLR1YJInC9RRvbCCkCIMmBv4zpoRp68b8TLFfG4lpUb/WiBItcaaCup8knRDAbAhx8sT0miAmc7/pSK5s=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr5016980otp.189.1561671252211;
 Thu, 27 Jun 2019 14:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190626071643.enxekm6qxx4qgpht@vireshk-i7>
In-Reply-To: <20190626071643.enxekm6qxx4qgpht@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jun 2019 23:34:01 +0200
Message-ID: <CAJZ5v0gnNZujrvEHOz1rViFzOhWJf=AvGhzem==jSNEjZVga1A@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm changes for 5.3
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 26, 2019 at 9:16 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains:
>
> - Minor fixes for brcmstb driver (Florian).
> - New imx-cpufreq driver, its bindings and code around it (Leonard).
> - New Raspberry Pi driver (Nicolas).
> - Minor fix for s5pv210 driver (Pawel).
> - Minor cleanup for armada driver (YueHaibing).
>
> --
> viresh
>
> -------------------------8<-------------------------
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
>
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
>
> for you to fetch changes up to f9020441dbc39133591ff72b420f21f51896afc5:
>
>   cpufreq: s5pv210: Don't flood kernel log after cpufreq change (2019-06-24 10:27:02 +0530)
>

Pulled, thanks!

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2FD3E0785
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbhHDSY0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 14:24:26 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:33313 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbhHDSY0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 14:24:26 -0400
Received: by mail-oi1-f174.google.com with SMTP id 26so3960572oiy.0;
        Wed, 04 Aug 2021 11:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDTQBFnCXodZBPTlZJxMnSffHlZHqHvoychgteMDXpU=;
        b=RzfKkK4LVQrYwasaZiFBdTi1EUvGppDGaYW71XsD3TxW7OxEXPGRfyohHjgGZpijNI
         6IrsW2CsSlo9VjtaJptBdGyWeJC6D+GomWb2tdTDrNGdW2u/e+YeUz19/EjfF4o6mIjU
         5J4msTnj5xKf7VoiAw2V6S1cDLV3lxgQ9hrkPLPyI5Gl8WU2qjqsaOWnC4pXlu9k44cX
         PBaexWvhdCyDUZIUVGfeea8YQw9bGQ5VRaVAKwqMSCME/Qe8ZBn+OL0NeEtYRiOoFO1O
         ra+8iJa/JXPHi3qJld5gEh7h2x6s602zISNicrTR2/Taa9mrOUUa4XBZIAOy2foxarWU
         Ye7Q==
X-Gm-Message-State: AOAM532aj1GZeRYy8KTEcLNp1uilJwvQgCtkQlXdtwUZVEhPLzg4FKtA
        Fr6SiP+m7FpvNTTGCj9KJQhPzHnc84/moaDBC0A=
X-Google-Smtp-Source: ABdhPJw/pYJXlsNu/jSaFTf0PXAfDAnnBK724/IctR7NyKbUxxCPQvnxIswFxGL1KwUTSaDl9qLNiudssg8cBpc4mjI=
X-Received: by 2002:a05:6808:198c:: with SMTP id bj12mr587895oib.71.1628101452040;
 Wed, 04 Aug 2021 11:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210804104407.5600-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20210804104407.5600-1-alexandre.belloni@bootlin.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Aug 2021 20:24:01 +0200
Message-ID: <CAJZ5v0gtDP1NXMfpfXzDUWAhV_2GcN3DtRWJvdhv9eZprpnQ2A@mail.gmail.com>
Subject: Re: [PATCH] PM / sleep: check RTC features instead of ops in suspend_test
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 4, 2021 at 12:44 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Test RTC_FEATURE_ALARM instead of relying on ops->set_alarm to know whether
> alarms are available.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  kernel/power/suspend_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/suspend_test.c b/kernel/power/suspend_test.c
> index e1ed58adb69e..d20526c5be15 100644
> --- a/kernel/power/suspend_test.c
> +++ b/kernel/power/suspend_test.c
> @@ -129,7 +129,7 @@ static int __init has_wakealarm(struct device *dev, const void *data)
>  {
>         struct rtc_device *candidate = to_rtc_device(dev);
>
> -       if (!candidate->ops->set_alarm)
> +       if (!test_bit(RTC_FEATURE_ALARM, candidate->features))
>                 return 0;
>         if (!device_may_wakeup(candidate->dev.parent))
>                 return 0;
> --

Applied as 5.15 material, thanks!

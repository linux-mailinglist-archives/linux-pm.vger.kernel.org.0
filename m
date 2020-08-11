Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C297F2422C6
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 01:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgHKXL7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 19:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgHKXL7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 19:11:59 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27059C06178B
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2020 16:11:59 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k12so514356otr.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2020 16:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGbgkpKabSRtvJFDP2cpGjFLq6qGka/uiZ+Vq9DL/Ow=;
        b=c+fmFqlTRhySOXMlvaJbso581+GBoEadjNClaEYTZEpjECXyeroSqJz0uvu/2+65RS
         GljkKHWebLTvyXe+LX5oUd7YPsah8EBUA6JHSjDQxpvFuhki5b7wMxRNSsUbXHUCJnqq
         SiAdhBT/u5SkBV0BNPQrO+NNNl2c3K4iF1EOQzL9Ozj/7uZ20bTMLYgzOeFbGVTz33UJ
         Io3yO/6ahoYdq8CmnNmVbeddS3V92417Yyv0lhIvmABUcQdBRbm5+lb3tq9/u6AX0IHE
         4FTDr409qB7h2z4Ao2Z/8iqpBOElJ568n7exBhDKyQRsW0gXenyYLgx+TTbk0US7++/G
         k5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGbgkpKabSRtvJFDP2cpGjFLq6qGka/uiZ+Vq9DL/Ow=;
        b=T0zIFyykVAqvX6OkOR9js0e4C8RP8pI2tAl0sZ18rkvD6KwX5HZSX72+FSpoQQ27qY
         2XIptxzXMZNlppc59Niegr7nDTr7Qe9fRE8QlPc0KsZxsRoO9u6CyLpAMMf+/RZZmYgk
         bsVS2c0DUzmK4bP0bjLwqQg8RuSs1bYk05yyKwWLm8obd8NDkhLDfpLdqMJ0CuxI3/VH
         7D2seK/z0TPnXNzAceTc2f0j0GxwVsQSDRe5zzK1AO6nRNCMMFPo67AR6crtUMgnxZTB
         uJpprcBT9tvx3rGcNs/eKg3qTxnmtttJyl80ynOpWAlZ8skHpVgEcrZz+Wc9mpVu+h9l
         klhg==
X-Gm-Message-State: AOAM532XWCCyifH7AIbQd8BNWO6w0jP3j2CMCrWDiGbwgHsA+Wd9lfvJ
        J1I/obbQkqfvPFuWQypd2LOaEus4sLJrieBlnq3fkQ==
X-Google-Smtp-Source: ABdhPJz1l9i2eKeP99P0PVUqqfuqJ5MZWZKQYvADHHuV2THqxFZqfBLD5UUNVDPsADND7VkQzMhYIL9g7q6OWzOUHNI=
X-Received: by 2002:a05:6830:3196:: with SMTP id p22mr7492118ots.102.1597187518112;
 Tue, 11 Aug 2020 16:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190320094918.20234-1-rnayak@codeaurora.org> <20190320094918.20234-4-rnayak@codeaurora.org>
In-Reply-To: <20190320094918.20234-4-rnayak@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 11 Aug 2020 16:11:46 -0700
Message-ID: <CALAqxLV2TBk9ScUM6MeJMCkL8kJnCihjQ7ac5fLzcqOg1rREVQ@mail.gmail.com>
Subject: Re: [RFC v2 03/11] tty: serial: qcom_geni_serial: Use OPP API to set
 clk/perf state
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-scsi@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 20, 2019 at 2:49 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> geni serial needs to express a perforamnce state requirement on CX
> depending on the frequency of the clock rates. Use OPP table from
> DT to register with OPP framework and use dev_pm_opp_set_rate() to
> set the clk/perf state.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>

Hey,
  I just wanted to follow up on this patch, as I've bisected it
(a5819b548af0) down as having broken qca bluetooth on the Dragonboard
845c.

I haven't yet had time to debug it yet, but wanted to raise the issue
in case anyone else has seen similar trouble.

thanks
-john

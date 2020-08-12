Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8756D2423C2
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 03:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHLBdt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 21:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgHLBds (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 21:33:48 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDD7C06174A
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2020 18:33:48 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h22so688193otq.11
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2020 18:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOPEDXgtktX+STOhnXLIGFgUbz2AXCn5XtOhUs7FFWI=;
        b=qSkeLFvVCBeyPkmdkgo9OCu5OWH5Dw6+0Twq6g7pWRUKkrgMSI2z7oY5mGZviazadc
         spoPzCobAhW7sEDx1xtNZWsQ/0F5j9CvS7EzK+4CW832Mnin/Tfo74DU3bVJJmh1Dw+u
         12je9qrMQ19aLS/Ik6iyA4QMhSdyMq16Q2Wk0lYS7xTu0JEVkE/wofm+Ov+w029jUpR5
         lELK88tQ8d/m445rIjFhk4LKCQ/rYg6C2Xur4Da8IfMcqe85B6YdRVQRj4d5QPCbhkIU
         RCK17RLFpRllpJN4hkBKlEYHX7P6xA7j56ZedLQjmPHHtCOzIyZ6joZ7irT53PcAqEqZ
         OdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOPEDXgtktX+STOhnXLIGFgUbz2AXCn5XtOhUs7FFWI=;
        b=Ca+fjvLzfJdVRqx573NUwVEfFDqbcJ9CTG6NVTvA/E0QdNQRQyxXT/EgKCT7ANVVCG
         RD5OfMOQRj6QmnSlgEtNalGrwlqvhREkKCAb69AgTUTvnT4AL7XQsOr68Uxs9j2gb9PS
         eIf1yxzP9WOofbWpsL0rued3PUQi5L3M+g7VJ/n1gkKbKXs/hyTvoW82X0L6SVxwt4wT
         PE5GaMKwNXdUYIT1pgLIFwuR0tUjCUuVWwafZhX1QCRaYbFp/6dfO/Cha5XBXvWUQdX0
         +zILpdW9Mz5miXyOwVm4boWNQrneZApu4o6kAldo7FsEwicwlGoc5HoJD7FtKY0sDc9D
         EE8A==
X-Gm-Message-State: AOAM533GYKMrlq6MXDJ9ZMD9v+ZOdV5j+JFqVMedKvojQdZEagwok3iH
        5XYwHXMPXPKTAtd2QIHDnPEmPTVj6vZNk2GBXOpoZA==
X-Google-Smtp-Source: ABdhPJxLxPaIzKvPWsnNCzFrhyTFYZetvE3df4QriA+UBfu0xBdgDZG7G/eP+D69kfw+gwQ/XsFyZuhoDhcuSqY1Mvw=
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr7099143otq.221.1597196027730;
 Tue, 11 Aug 2020 18:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190320094918.20234-1-rnayak@codeaurora.org> <20190320094918.20234-4-rnayak@codeaurora.org>
 <CALAqxLV2TBk9ScUM6MeJMCkL8kJnCihjQ7ac5fLzcqOg1rREVQ@mail.gmail.com>
In-Reply-To: <CALAqxLV2TBk9ScUM6MeJMCkL8kJnCihjQ7ac5fLzcqOg1rREVQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 11 Aug 2020 18:33:36 -0700
Message-ID: <CALAqxLWg3jJKJFLnnne-mrQEnH=m7R_9azCGaGnEmFYR4EMh=A@mail.gmail.com>
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

On Tue, Aug 11, 2020 at 4:11 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Wed, Mar 20, 2019 at 2:49 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
> >
> > geni serial needs to express a perforamnce state requirement on CX
> > depending on the frequency of the clock rates. Use OPP table from
> > DT to register with OPP framework and use dev_pm_opp_set_rate() to
> > set the clk/perf state.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/tty/serial/qcom_geni_serial.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
>
> Hey,
>   I just wanted to follow up on this patch, as I've bisected it
> (a5819b548af0) down as having broken qca bluetooth on the Dragonboard
> 845c.
>
> I haven't yet had time to debug it yet, but wanted to raise the issue
> in case anyone else has seen similar trouble.

So I dug in a bit further, and this chunk seems to be causing the issue:
> @@ -961,7 +963,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>                 goto out_restart_rx;
>
>         uport->uartclk = clk_rate;
> -       clk_set_rate(port->se.clk, clk_rate);
> +       dev_pm_opp_set_rate(port->dev, clk_rate);
>         ser_clk_cfg = SER_CLK_EN;
>         ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
>


With that applied, I see the following errors in dmesg and bluetooth
fails to function:
[    4.763467] qcom_geni_serial 898000.serial: dev_pm_opp_set_rate:
failed to find OPP for freq 102400000 (-34)
[    4.773493] qcom_geni_serial 898000.serial: dev_pm_opp_set_rate:
failed to find OPP for freq 102400000 (-34)

With just that chunk reverted on linus/HEAD, bluetooth seems to work ok.

thanks
-john

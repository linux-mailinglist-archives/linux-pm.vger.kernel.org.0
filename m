Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A626BFAC0
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 22:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfIZUvO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Sep 2019 16:51:14 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32805 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbfIZUvO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2019 16:51:14 -0400
Received: by mail-qk1-f196.google.com with SMTP id x134so238686qkb.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2019 13:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFXRrFau2iJzsurfLrZlI44R9YQ5W58lJvvcXaxbZxI=;
        b=KfUP2SE/YczAT4JhpCDujik7WoLJGyfqT3XGtzKI3SNB9DXBFNzL5mRonozZ1n2YQP
         LJr2eSJSaF5hXp3ti/nJwV7A5FTVzR7PfNvyyF6wpTOQaAg3HkdZCJJSZraM5Ec8+pzT
         whmvG1e7OsMifGARMfI3T70qIMuG5fdAVlS+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFXRrFau2iJzsurfLrZlI44R9YQ5W58lJvvcXaxbZxI=;
        b=gr/PowmN6amloFbo25y0AkzTPxGBWx9QWvt8osfxkDCHyzrdqP0u1ooHrrQJZwGpSH
         D9e5FbWmvy3Fc70gNY7fiYG1qQa8N78JJRAcX/jD9pq0GEVUm1z7hN6WguadQUp3g6/C
         wAuQhYXLGuoRf9jGZ4ZrRa8jcFfXMaTmveQgeV6UFBoA8L+E8gzQzH0BTvmTUMwoAflW
         dUnbdu8yY/Q0BXNhTr0kUKXPlTk5U/812GHb+q8HcZ7lFdb+gj3F8PykcNpZhRRT7HaX
         ARO4tRtyuE/KtpqCjfJCfp5wvBugKR0CZ/MC6DdoOkHr0Y8DurvBLptx/caJdEAL2H19
         E0BQ==
X-Gm-Message-State: APjAAAVKwHRk62xRk+t5/MRgZBfk4Tpjqn4t4QD9zm1fwYy6l/vqRhPJ
        gWi0nkRUxDqCZsdJdSlUJchKhiA07NX4/wDVPEia0w==
X-Google-Smtp-Source: APXvYqyOH46/TFqgHUrRLcD+R2H/hvTOilF7SBW1cOWfI7cZ6m4E2KFuCxu8bdmVWQs6LfcrJZg983Bh2DYShcIK4bE=
X-Received: by 2002:a37:498f:: with SMTP id w137mr855825qka.419.1569531073398;
 Thu, 26 Sep 2019 13:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <CANFp7mX=THOVk-4TgSSscgtm598txqesDZYKE2sFtEVNHjN+-g@mail.gmail.com>
 <Pine.LNX.4.44L0.1909181442330.1507-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909181442330.1507-100000@iolanthe.rowland.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Thu, 26 Sep 2019 13:51:02 -0700
Message-ID: <CANFp7mWj8V=Hyo7b0xisYVde2dC9Ju0Rc+ituftnjcqXMuD5GA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Reset realtek bluetooth devices during user suspend
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hui Peng <benquike@gmail.com>, linux-pm@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Len Brown <len.brown@intel.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mans Rullgard <mans@mansr.com>, Pavel Machek <pavel@ucw.cz>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 18, 2019 at 11:51 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, 18 Sep 2019, Abhishek Pandit-Subedi wrote:
>
> > Sorry, last reply went out with HTML. Re-sending in plain text.
> >
> > On Wed, Sep 18, 2019 at 7:23 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Tue, 17 Sep 2019, Abhishek Pandit-Subedi wrote:
> > >
> > > > On a Realtek USB bluetooth device, I wanted a simple and consistent way
> > > > to put the device in reset during suspend (2 reasons: to save power and
> > > > disable BT as a wakeup source). Resetting it in the suspend callback
> > > > causes a detach and the resume callback is not called. Hence the changes
> > > > in this series to do the reset in suspend_noirq.
> > >
> > > What about people who _want_ BT to be a wakeup source?
> >
> > When BT is enabled as a wakeup source, there is no reset.
> >
> > > Why does putting the device in reset save power?  That is, a suspended
> > > device is very strictly limited in the amount of current it's allowed
> > > to draw from the USB bus; why should it draw significantly less when it
> > > is reset?
> >
> > I don't know that it's significantly less (only that it's OFF). My
> > greater motivation is to make sure the bluetooth chip isn't
> > accumulating events while the host is turned off. Sorry, I should have
> > made that more clear in the cover letter.
> >
> > When the host is off, it continues to accumulate events for the host
> > to process (packets from connected devices, LE advertisements, etc).
> > At some point, the firmware buffers fill up and no more events can be
> > stored. When the host is resumed later on, the firmware is in a bad
> > state and doesn't respond. I had originally just reset in ->resume but
> > then connected wireless devices wouldn't disconnect from the BT either
> > and I had trouble getting them to reconnect.
> >
> > >
> > > > I looked into using PERSIST and reset on resume but those seem mainly
> > > > for misbehaving devices that reset themselves.
> > >
> > > They are, but that doesn't mean you can't use them for other things
> > > too.
> > >
> > > > This patch series has been tested with Realtek BT hardware as well as
> > > > Intel BT (test procedure = disable as wake source, user suspend and
> > > > observe a detach + reattach on resume).
> > >
> > > This series really seems like overkill for a single kind of device.
> > >
> > > Is there any way to turn off the device's BT radio during suspend (if
> > > wakeup is disabled) and then turn it back on during resume?  Wouldn't
> > > that accomplish what you want just as well?
> >
> > Probably (but I couldn't find a way to do that).
>
> There's no way to turn off the device's BT radio?  Then what happens
> when the user turns off Bluetooth from the wireless control panel?

It looks like bluez invokes hci_dev_do_close. This gracefully clears
any packets in flight, clears any pending actions and disables the
device as a wakeup source (which for Realtek allows it to enter global
suspend). This is approximately what I was trying to achieve.

> >  I want to prevent
> > bluetooth from waking up the host and to reliably be in a good state
> > when the host resumes. The reset logic I implemented causes the hci
> > device to disappear and reappear, which userspace seems to handle
> > gracefully.
>
> Have you tried out the persist/reset-on-resume approach?
>
> Alan Stern
>

I think I'll abandon this patch series. The general sentiment seems to
be "don't do this" and it looks like closing the hci device is better
in my case.

Thanks for the feedback and pointing me this way.

Abhishek

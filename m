Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1721451F26
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 01:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfFXXfQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 19:35:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34840 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfFXXfQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 19:35:16 -0400
Received: by mail-ot1-f67.google.com with SMTP id j19so15365398otq.2;
        Mon, 24 Jun 2019 16:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVTF8w/bzxzzwjKjirb84YOUkp8C13yHKMBgkRlLO8g=;
        b=GPpkEuo+T6BYzCHnNw1ZDvNOGW3ZPWCrYS7ASbOTWQQ8mRYEND+0OZy1U0HpYtF+3h
         qXQJH5x3vHqPRogpRo3Dpl5S9sQPWJX7I8pk6xZYX8BMXN8f1QlmynXJPhG/mYVLbGju
         tG8AJTi01RzAboH8W/zq3wxoNqA2dkhRtV0Qi3Lh1sPyQh6uXtXtNHKBwue9bJc5h4qp
         ZUponajRTmvbD6gVopIqyZ+V8jLc0j1DeXSonpcxJIRtbkkcWazyIH5JunXZa4wmDUQT
         xSnfyWj/6Oh5ft0N4x1YkIV0ebOtarTzbuiDs9jFI4L3LDddcRBo7BdRPiRs2AFeYBAW
         qYFg==
X-Gm-Message-State: APjAAAXBqSGvZOK7xKe1cd0hpLrP94r6BQqo+MTaUyJQVujo4fEYuFFy
        Qf+roxTEYXqDvfOfXWImL5xDpUqr6tnfy2OPMK2Jog==
X-Google-Smtp-Source: APXvYqyFQkUx+xbPfx+5gzJAsHNW3cvKrczeO9rQxKYaPCCOA7T4Fjyjd7gESq4zedpVyar64cOnspuEaWq6wzgCQus=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr25954887otp.189.1561419315644;
 Mon, 24 Jun 2019 16:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190619175142.237794-1-ravisadineni@chromium.org> <CAEZbON4e1=w6G4KEqq2qP0nTD4z00fcqHErWTBVGFGb17f=+1Q@mail.gmail.com>
In-Reply-To: <CAEZbON4e1=w6G4KEqq2qP0nTD4z00fcqHErWTBVGFGb17f=+1Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jun 2019 01:35:04 +0200
Message-ID: <CAJZ5v0hKtp0vqHzk1Gkh6fUPGWVFfUvHropCZMs5SRfMv2ORFA@mail.gmail.com>
Subject: Re: [PATCH] power: Do not clear events_check_enabled in pm_wakeup_pending()
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Todd Broch <tbroch@google.com>, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 25, 2019 at 1:25 AM Ravi Chandra Sadineni
<ravisadineni@chromium.org> wrote:
>
> Hi,
>
> Just wanted to check if this is o.k.

It is in my "for review" queue, I'll let you know.

Thanks!

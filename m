Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5810D7EE804
	for <lists+linux-pm@lfdr.de>; Thu, 16 Nov 2023 21:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjKPUBA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Nov 2023 15:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjKPUA7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2023 15:00:59 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0FE1AD
        for <linux-pm@vger.kernel.org>; Thu, 16 Nov 2023 12:00:55 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso1262625276.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Nov 2023 12:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700164854; x=1700769654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ok5oEYyXACKtRAnxSj7shUh1fHjt6/BETulwYHET3J8=;
        b=rxTSa0Kw3So/e2V0ZSuwxBN+YlltRjnq0Mp353ju2pJq7THy8PU6SqEVg/Zuvj1qor
         cC3ae9ZbsqgdyI0FYZ0mnedug+F3a0FclZXhQFaa2y4KKPGJFdPCBrDcBk1P9lRMUxG0
         a7b7jEjKjJ1kK4neYsh8sktM432093AHhJFSadE7MHkThoGtmDlg6i67urlpXHr138uZ
         cv77MDy04r87QugjD6Mtezu2JMUAehk4f8xZ1p6QlnS+uBbzMckLkhGOyaTplwxU3Zdg
         j07RHPpe1Vdcv++U0LUbQ1qCv/8+i8qPtYBERxpsZaEnWukErLPZ+HnVls2u7A5ovsTW
         +Xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700164854; x=1700769654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ok5oEYyXACKtRAnxSj7shUh1fHjt6/BETulwYHET3J8=;
        b=gPjiHII+ky7gqyYCnsXlChVD/cFOt0mz+txfwzAN8koY8MuRq1jlibZJKaNYLRMR6T
         HoFDcC6ma1DFbihIxtMDIQb6o1h+3Kq9bWedujcka1z5aQeqd2+Pkz2rTILEVUS2qyMi
         LIL2ZrYTxeluYdbYw4BDoldIIkm63GTYUsnkLSr1HYMpwRU/HNWHt62blJM4z9cU6Qnw
         tu/OciXDLlkasupAfAnVMP6ssNR0o467Y38djwn2w2w6ObFTQpGyEsMBKwERngwO1i8Q
         d9FtZkjJsbEeRdNE1UW8HHVuaI5V+5r8XA0kHQ3bZcJESIIeHXyk/9Mmbq97N/2Wc+t9
         Gy/A==
X-Gm-Message-State: AOJu0Yy3HBIxYG83YMMHkyvRFzAfPNVz5XIKPm41oAbrfyayXAId6VmB
        b+dtgwwe9u7YCCSHvpEfEl0riV4yCoEwoGoH1Si6bw==
X-Google-Smtp-Source: AGHT+IHXHEiD1fCPxnFB64Qcn9k09uG7DTWs3UXXMo27GUdTxTDJptHZQ7snis+dTMetBqRJxQMLPrFWWq/2jADCkZk=
X-Received: by 2002:a25:48a:0:b0:da0:46fa:cabe with SMTP id
 132-20020a25048a000000b00da046facabemr15582651ybe.7.1700164854238; Thu, 16
 Nov 2023 12:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20231110102054.1393570-1-joychakr@google.com> <CACRpkdZ9RHcHh4o5g62ywK0eQHpLZuGUF0Ud6jogk9Sfqe4krA@mail.gmail.com>
 <ZVQkLqDB3KtOlIpK@surfacebook.localdomain> <CAOSNQF3QeFd857RCJE8wfJ=__-K7Bi4vfMeTVP-+O+LJ7y9SmQ@mail.gmail.com>
In-Reply-To: <CAOSNQF3QeFd857RCJE8wfJ=__-K7Bi4vfMeTVP-+O+LJ7y9SmQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Nov 2023 21:00:42 +0100
Message-ID: <CACRpkdZ+UMOqatH4oOusdaX1ieeH2TtpC7VbX1wf+tzGDSfR3A@mail.gmail.com>
Subject: Re: [RFC PATCH] PM: runtime: Apply pinctrl settings if defined
To:     Joy Chakraborty <joychakr@google.com>
Cc:     andy.shevchenko@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, manugautam@google.com,
        aniketmaurya@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 16, 2023 at 4:34=E2=80=AFPM Joy Chakraborty <joychakr@google.co=
m> wrote:

> I tried to place the calls to set the pinctrl states after driver/user
> callback  based on my understanding of runtime code so that existing
> users do get a chance to set the state with any special sequence that
> needs to be performed post which doing another call to set the state
> would be ignored in the pinctrl framework.

This makes sense. (And also is in the original commit.)

I think you should actually over-document this by also mentioning
this in the kerneldoc above each of the *_try_* callbacks so
users simply can't miss this point.

> But this only would be possible with the assumption that even in any
> special sequences executed by users they set nothing but "default"
> state in runtime_resume, "idle" state in runtime_idle and "'sleep"
> state in their runtime suspend callbacks.
> And like Andy mentions about "->prepare callback", if there are
> drivers that are setting pinctrl state "default", "sleep" or "idle"
> from any callback but
> ...
> int (*runtime_suspend)(struct device *dev);
> int (*runtime_resume)(struct device *dev);
> int (*runtime_idle)(struct device *dev);
> ...
> it could indeed be a problem.
> I'll dig into users of pinctrl_select_sleep/default/idle and see if
> there are such cases or if it could be done in some other way.

It's worth a check but I doubt much will turn up. The "idle" and
"sleep" states are simply not used much in the kernel.

Your users will likely be the first.

So which hardware target will use this?
It's immensely useful to have a good example to point at:
that device use "defaul", "sleep", "idle" the idiomatic way.

Yours,
Linus Walleij

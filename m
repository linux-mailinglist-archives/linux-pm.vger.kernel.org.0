Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB89ECBC2
	for <lists+linux-pm@lfdr.de>; Sat,  2 Nov 2019 00:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfKAXBm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 19:01:42 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35736 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfKAXBl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 19:01:41 -0400
Received: by mail-il1-f196.google.com with SMTP id p8so10006113ilp.2
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 16:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bf69Nkr7XBkmTO1YD+9sNVV+WBGtzvC5rxPzFLKlWNo=;
        b=fef9ITiroUgvdPL9dSereSDmc2uHGR7fnIsdwnXDmA0MFiLxHlMcWFQLIHWQVYz488
         wepTmOx6B3NDyuQStyl0eD2Y0ifgeBrEdd4uyG48SyEac7cZmtepCiNECLJ5HIE9h1Ku
         nuK5ExP5bNiE27blrdbkdwG0Y7XVk8OxK0D1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bf69Nkr7XBkmTO1YD+9sNVV+WBGtzvC5rxPzFLKlWNo=;
        b=qufFqC/gCWlBY+rfBhRyUdjrg/IKb/lcXDuYuDSgqoNWYm9HG/TB8EYk7tVeayPGcH
         Lj5nt5uh87qLdAjLDqxqGEPNsc8Ya53w0aJl48m/UjAjrtMxIMmXvVXhhZ0PrQwV8p0F
         hxizK5kCL0Av9VkWeDS57XNSN4KNpA9qdu5BqZ+LnfrcdIUofzhG1HUzuSyqE1tzctcv
         tWnwucFkXgldqre4mX0+jhNycKc8SajAc1E41SQKJFOwovgIIaROVPF17KncB40zkryr
         QncS1hQRwa7YAKOy6aaAyRIAWg9kqchtTWUkBBOWmZ7jWnXmt+ovoR8kH+qF3uCLukt9
         bImQ==
X-Gm-Message-State: APjAAAV4NFlDaM6+norqBhBXGu/flJCk/NQTgcK8IzarLVM678sCN8sL
        TbJqFl+kee4lIm1qUT0tCiBx5wnjXu8=
X-Google-Smtp-Source: APXvYqyxtmgyeX1ccoSVdS2mmk4IO4Svdlg0seWoqk5t32WeR2Cec1BtT9EMH7Gw7eGR+ZTyx14zRw==
X-Received: by 2002:a92:9c95:: with SMTP id x21mr15255909ill.115.1572649300646;
        Fri, 01 Nov 2019 16:01:40 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id r22sm872597ioh.77.2019.11.01.16.01.40
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 16:01:40 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id t9so7727052ils.4
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 16:01:40 -0700 (PDT)
X-Received: by 2002:a92:d0a:: with SMTP id 10mr14227736iln.218.1572648817422;
 Fri, 01 Nov 2019 15:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1572526427.git.amit.kucheria@linaro.org> <18717de35f31098d3ebc12564c2767b6d54d37d8.1572526427.git.amit.kucheria@linaro.org>
In-Reply-To: <18717de35f31098d3ebc12564c2767b6d54d37d8.1572526427.git.amit.kucheria@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Nov 2019 15:53:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X3o3JKye8pZZckEtk=9XNoajf-Kj8XGUemut7NS2bZjw@mail.gmail.com>
Message-ID: <CAD=FV=X3o3JKye8pZZckEtk=9XNoajf-Kj8XGUemut7NS2bZjw@mail.gmail.com>
Subject: Re: [PATCH v7 03/15] drivers: thermal: tsens: Add __func__ identifier
 to debug statements
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>, masneyb@onstation.org,
        Stephen Boyd <swboyd@chromium.org>, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thu, Oct 31, 2019 at 11:38 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> Printing the function name when enabling debugging makes logs easier to
> read.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-common.c | 8 ++++----
>  drivers/thermal/qcom/tsens.c        | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)

Obviously my opinion doesn't trump maintainers ones, but I have always
heard that this is the wrong thing to do for "dev_xxx" debug
statements.  Specifically:

* For "dev_xxx" statements, the device name is already printed which
is pretty good for getting you to the right driver.

* Once you're in the right driver, error messages should be unique
enough to find the right function.

If having __func__ in all messages was beneficial then the "dev_xxx"
macros would include it by default.  They don't and such things just
uglify the logs and chew up log space.  I suppose you could try
including a CONFIG option to add it to all "dev_xxx" functions and see
if it would be accepted?  Then you can turn it on locally.

Using __func__ in cases where you don't happen to have a "struct
device" (and can't get one easily) makes some sense, but otherwise I
believe it should be kept out.

-Doug

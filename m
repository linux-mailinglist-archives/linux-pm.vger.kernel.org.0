Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97831181BC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 09:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfLJIHp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 03:07:45 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:33151 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfLJIHp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 03:07:45 -0500
Received: by mail-ot1-f45.google.com with SMTP id d17so14798038otc.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 00:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyYe6EG1eR85EamOhs2MKwp5XjznMxh4JnufSm2TXrY=;
        b=SlcxttfpWdv5h59BFl/iDyc42vHNpRmPeYyzp+wAR1b9bHXiEeWhlBAO88nkX2/P1G
         7NMuWbRE+mO6/tCOBVCdZ6WOJ8tw3Y1GQt2tHhz5NOcD5KSdygmGYpJtphOozAqzw4f6
         wGrNA2ugUzE3VvRW9JgXfzUFSxU8Ulflo9fS5oz6/Ea7g5+rnj/bCdt2pf1RrifAb7zu
         WFRcvwc7OmfwgVrILr4So1tXxfpRjebLl1gzk+k8xhqucBmrg7/vprs+2aABSQFit/x8
         5BZ5ceZ/rww6kBhOPZJycrc5C2LA0wPT+iaOYDqu0x7RQwa1uASFbf7OGtFJqlK6hvkP
         AL+g==
X-Gm-Message-State: APjAAAVDMqH1uam8Kb3YnY/FrXiPZFOnq6UdztZh8WAqpZOJBbPLm8Tv
        OvKYnWeuOjgUJz55BFqjXaAIQ9LOd1whKTDM78JHTQ==
X-Google-Smtp-Source: APXvYqy5CGMq+iiunHgcx3aFMvb7txobQmVmPM7p07onvDYC9Wfi06S+7tn5ZLkMfXnVNdRrOhJopBvzdk8VvZDN2Z8=
X-Received: by 2002:a9d:7483:: with SMTP id t3mr24932402otk.262.1575965264591;
 Tue, 10 Dec 2019 00:07:44 -0800 (PST)
MIME-Version: 1.0
References: <7b0313c4-0d2b-fbd9-469b-1e0ce79aacc3@linaro.org>
 <CAJZ5v0iXJz5yAbr_Dhk4k0FqGW6nhn2QF1oGf7Xi4Kfdvc83Wg@mail.gmail.com>
 <62b866a1-739f-8349-81bc-4ccff4ad3a28@linaro.org> <CAJZ5v0i44Rb8PeB65sZmnu=8Ctzjw4BeSHqQC2XTG5A7K2pcsw@mail.gmail.com>
 <a2f4c5f4-e416-93dd-24f9-431308a692a0@linaro.org> <CAJZ5v0hkdGGkioVpmMPtroBYEt-42jgkG_zMfReuZUWDH8WHYQ@mail.gmail.com>
 <c326a33d-f147-b6c2-a967-1170cf6917a3@linaro.org> <ce4b6bb4-7921-598d-b7f1-1bc377e07602@linaro.org>
In-Reply-To: <ce4b6bb4-7921-598d-b7f1-1bc377e07602@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Dec 2019 09:07:32 +0100
Message-ID: <CAJZ5v0hwQmrVgW0DdkkCAwj06GJY30SvDG2o0Ys3nu89aOP-_A@mail.gmail.com>
Subject: Re: cpuidle regression ?
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 10, 2019 at 9:06 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 09/12/2019 18:22, Daniel Lezcano wrote:
>
> [ ... ]
>
> > However, kernelci does no longer report a regression on the baseline
> > with your patch applied on my 'testing' branch.
> >
> > I can not guarantee the bug is fixed because I can't reproduce it
> > locally and check the patch is effectively solving the issue.
> >
> > In order to increase the confidence on the fix, I updated the branch
> > without your patch, so in a few hours, we should see the if the
> > regression appears or not.
>
> The regression came back without the patch.

OK, thanks!

I'll post the patch properly then and queue it up as a regression fix.

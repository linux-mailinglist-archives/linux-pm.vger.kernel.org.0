Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 134566D848
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 03:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfGSBTQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 21:19:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40768 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfGSBTQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 21:19:16 -0400
Received: by mail-lf1-f67.google.com with SMTP id b17so20555900lff.7;
        Thu, 18 Jul 2019 18:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9QLEGMzSK4YGdP01cu5FZUyVBbLiWJOfejTtBqzNYE=;
        b=huiyx0FgZSgDs+ObuumC2+PAKhlEnoJJiGLr0t+Mg+oamc9cD30U7TUmRX11Wu8j8E
         T47XHPehLHSB0EATxccZOWjHfitvAsQr+My6CoLngX1TIain59uuCof4NHjYC8Qr4iS0
         /oEkbXsM1JwyON7/uurxsPL/33OueWlz+ejliuyqEX0r9JPyZl65nQ44B103LeOvNPmf
         wmvv3b/5b1ybBh8QXcutxvVRvAzugQOJk3IDJZO/1jOstWW6951RWkYS6oA6a9bUBlSp
         JrbRINJShPg8RAOEfnsJlqfZ1F88qkP+zsrs9DwDW+4Vy4Km6445xrfZ8bmtiOhll2oy
         ltUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9QLEGMzSK4YGdP01cu5FZUyVBbLiWJOfejTtBqzNYE=;
        b=HO+W4xCQXT5aFJe3COt194VYh+fb/x+AojqsM4Rxrox+us/cufAMw3WDOiZmwRcE6i
         X4M0njFofVkTQVJf+p4YXo19G4VffByDhvI77UifVijZqJe5W2/As/QIxu+LB0hjC4xp
         87NTxAN1/h5wSSOZJeKs6GsuKR0L4GFEevfLCBTU9LsIaBu1WfB2p7aXMFz6uyFFulB4
         OykdB/clqCdWYoAUJZMGxkywWLZoj5/WbHI6ymtB703YHwwd5rGDVb7NP3hw9US1nE5z
         3z73RHLO/K0gLBRH23nDwQY4Gn/6SgDy0nCZLMTO/zP0K+V8LoccgwZwZbJQoQeOZT9R
         qP8A==
X-Gm-Message-State: APjAAAVZgTA3dJ8RwcfO6qxv4ni1XiOL7mDLy4NM1yaJ1Iq+Rfam9oC8
        5KPbYNfIAJxHam8UGpMrrKm6/MZT
X-Google-Smtp-Source: APXvYqxjjnD+Ny2ftHQkiiV1aPoKV1gHnArd+3inMK4sKVZFVCIpX4CXkA60/+6tlcwUuW9jH4NPAg==
X-Received: by 2002:a19:ca4b:: with SMTP id h11mr21446231lfj.162.1563499154383;
        Thu, 18 Jul 2019 18:19:14 -0700 (PDT)
Received: from dimatab (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id u17sm4270320lfq.69.2019.07.18.18.19.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 18:19:14 -0700 (PDT)
Date:   Fri, 19 Jul 2019 04:22:51 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/24] PM / devfreq: tegra30: Inline all one-line
 functions
Message-ID: <20190719042251.37cc9cda@dimatab>
In-Reply-To: <45621f73-2f86-cde7-a92e-2a34810b9c05@samsung.com>
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223633epcas4p3873704f3199126be0e8d5cb7454c7a51@epcas4p3.samsung.com>
        <20190707223303.6755-13-digetx@gmail.com>
        <b5634fbe-8bc1-0f04-e13b-6345dfbb5615@samsung.com>
        <b7da3fa2-00d1-5bd6-408c-202c85be917d@gmail.com>
        <45621f73-2f86-cde7-a92e-2a34810b9c05@samsung.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=D0=92 Thu, 18 Jul 2019 18:09:05 +0900
Chanwoo Choi <cw00.choi@samsung.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On 19. 7. 16. =EC=98=A4=ED=9B=84 10:35, Dmitry Osipenko wrote:
> > 16.07.2019 15:26, Chanwoo Choi =D0=BF=D0=B8=D1=88=D0=B5=D1=82: =20
> >> Hi Dmitry,
> >>
> >> I'm not sure that it is necessary.
> >> As I knew, usally, the 'inline' is used on header file
> >> to define the empty functions.
> >>
> >> Do we have to change it with 'inline' keyword? =20
> >=20
> > The 'inline' attribute tells compiler that instead of jumping into
> > the function, it should take the function's code and replace the
> > function's invocation with that code. This is done in order to help
> > compiler optimize code properly, please see [1]. There is
> > absolutely no need to create a function call into a function that
> > consists of a single instruction.
> >=20
> > [1] https://gcc.gnu.org/onlinedocs/gcc-9.1.0/gcc/Inline.html
> >  =20
>=20
> If you want to add 'inline' keyword, I recommend that=20
> you better to remove the modified function in this patch
> and then just call the 'write_relaxed or read_relaxed' function
> directly. It is same result when using inline keyword.

That could be done, but it makes code less readable.

See the difference:

device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);

writel_relaxed(ACTMON_INTR_STATUS_CLEAR,
	       dev->regs + ACTMON_DEV_INTR_STATUS);


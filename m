Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7024D6D8C3
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 04:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfGSCKx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 22:10:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39557 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGSCKx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 22:10:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so29209060ljh.6;
        Thu, 18 Jul 2019 19:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j1C21+f0ZZxOBtFVDj1L3bfAXqnNfJEOByZtlSHJOoE=;
        b=UtzbaHE5hMkyyAKW6u5Fe90gnYzBM7jVsWKogTM+FcpVVAjA1X1+2QgclM/qVVCner
         nSo8A3MFJ9CQ1O0MlAdlUSaNH52Ma1/uaBFQzDBy8/Clu2rov6G3QYGPtRZD1NESxuQb
         b9bxVtlrz1Psxxui9661qETk26i93/j+puksRceUkzNk43EDhDSAYRncKuEbx0cE9Yqz
         XqLMyN1lQkaMHbHibjkiz8X+vtZ+OXq2ySTZBuU1XNZH/Y1QBRY3773qnVkK5dGZ2dWP
         WAHdjcbBsy+J6FNJRjZKP+ge7rc1lEiIGJMgnOr+2Pz2c/KJWApwUYbqWLit4WsoQy7+
         X1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j1C21+f0ZZxOBtFVDj1L3bfAXqnNfJEOByZtlSHJOoE=;
        b=M1g580XXo4c956ARy6hNh3ES70TXrEXsfX7grlxLSId7oX3WbcyY6b1ITIwBxkeT7i
         xUAjaqDoJwt92pK2apWXujYifXxSofXDCXlaLEx1IYYvKA6c5AumGWELi9Jk8pQcw2V2
         N/o1FUItO+vIi70JHUbmif4D50iz22afgrXXy5UuZFt4g5z7AuCDQNNmmx3SjBi5jygb
         3lzJRZk7b6vC2Z+80TrVo7MhNkJ+WTkjMpJIsGYIihAXq8usKbcdw28CA3WQzvVb+BLu
         wer9w+Pm/yE8uuT/lxwewPTkvS8p1mTzvOXSeNTT43mcDb9NQVRiKMjdv0gsBwXyybOU
         NFlA==
X-Gm-Message-State: APjAAAV5EVezFi9GnMNuS2rf9qV8Bnwc4/r7bpnNYm83o4xNP6UJrV+c
        KPDkRj3q2CByoSXuMehyIno=
X-Google-Smtp-Source: APXvYqy/0frX3l9f3g/yrC98yEx9Qc8AtNmbR+vX8KqhVRxSh9CeEuw0YNszCXwsCT5cqVXJlW0CEw==
X-Received: by 2002:a2e:85d4:: with SMTP id h20mr26239716ljj.142.1563502250737;
        Thu, 18 Jul 2019 19:10:50 -0700 (PDT)
Received: from dimatab (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id u9sm4280278lfk.64.2019.07.18.19.10.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 19:10:50 -0700 (PDT)
Date:   Fri, 19 Jul 2019 05:14:26 +0300
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
Message-ID: <20190719051426.4e4145d8@dimatab>
In-Reply-To: <97f2a317-989a-bcad-dd45-ccf00ba18cca@samsung.com>
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223633epcas4p3873704f3199126be0e8d5cb7454c7a51@epcas4p3.samsung.com>
        <20190707223303.6755-13-digetx@gmail.com>
        <b5634fbe-8bc1-0f04-e13b-6345dfbb5615@samsung.com>
        <b7da3fa2-00d1-5bd6-408c-202c85be917d@gmail.com>
        <45621f73-2f86-cde7-a92e-2a34810b9c05@samsung.com>
        <20190719042251.37cc9cda@dimatab>
        <92f82420-5c50-468f-a403-7b4c36958076@samsung.com>
        <97f2a317-989a-bcad-dd45-ccf00ba18cca@samsung.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=D0=92 Fri, 19 Jul 2019 10:27:16 +0900
Chanwoo Choi <cw00.choi@samsung.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On 19. 7. 19. =EC=98=A4=EC=A0=84 10:24, Chanwoo Choi wrote:
> > On 19. 7. 19. =EC=98=A4=EC=A0=84 10:22, Dmitry Osipenko wrote: =20
> >> =D0=92 Thu, 18 Jul 2019 18:09:05 +0900
> >> Chanwoo Choi <cw00.choi@samsung.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> =20
> >>> On 19. 7. 16. =EC=98=A4=ED=9B=84 10:35, Dmitry Osipenko wrote: =20
> >>>> 16.07.2019 15:26, Chanwoo Choi =D0=BF=D0=B8=D1=88=D0=B5=D1=82:   =20
> >>>>> Hi Dmitry,
> >>>>>
> >>>>> I'm not sure that it is necessary.
> >>>>> As I knew, usally, the 'inline' is used on header file
> >>>>> to define the empty functions.
> >>>>>
> >>>>> Do we have to change it with 'inline' keyword?   =20
> >>>>
> >>>> The 'inline' attribute tells compiler that instead of jumping
> >>>> into the function, it should take the function's code and
> >>>> replace the function's invocation with that code. This is done
> >>>> in order to help compiler optimize code properly, please see
> >>>> [1]. There is absolutely no need to create a function call into
> >>>> a function that consists of a single instruction.
> >>>>
> >>>> [1] https://gcc.gnu.org/onlinedocs/gcc-9.1.0/gcc/Inline.html
> >>>>    =20
> >>>
> >>> If you want to add 'inline' keyword, I recommend that=20
> >>> you better to remove the modified function in this patch
> >>> and then just call the 'write_relaxed or read_relaxed' function
> >>> directly. It is same result when using inline keyword. =20
> >>
> >> That could be done, but it makes code less readable.
> >>
> >> See the difference:
> >>
> >> device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
> >> ACTMON_DEV_INTR_STATUS);
> >>
> >> writel_relaxed(ACTMON_INTR_STATUS_CLEAR,
> >> 	       dev->regs + ACTMON_DEV_INTR_STATUS); =20
> >=20
> > No problem if you add the detailed comment and you want to use
> > the 'inline' keyword. =20
>=20
> Basically, I think that 'inline' keyword is not necessary.

Sure, but I'm finding that it's always nicer to explicitly inline a very
simple functions because compiler may not do it properly itself in some
cases.

> But if you want to use 'inline' keyword, I recommend
> that call the 'write_relaxed or read_relaxed' function directly
> with detailed description.=20

Could you please reword this sentence? Not sure that I'm understanding
it correctly.

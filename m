Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD466D88B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 03:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfGSBq4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 21:46:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41847 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfGSBqz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 21:46:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id d24so29197075ljg.8;
        Thu, 18 Jul 2019 18:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sI36ppd+4vw5yRr/qfzItcT9H0vm+FouNUT+YAtFRhA=;
        b=lzdZ1Oi5yg4sVrJCQd6t3akMOvV8mAvnj/eqv/p1EJ4d6oUHu48Ayn5WP3L//G2PG+
         RR0ksx7MODmNrZePHoSy9xizXU+5UXlZwY9OG4lms4Gp2pSKznqaykiTQH846oaemTGa
         LwyfKsMcaEBoOY5BU7YIkVqljouuWMw4YTMu7jGS53uwZBCK49IW3RM4LZwvD8UEmlKd
         qtq8fGQfG6d8K4pRtIqSMvpXMd8CY9wFtjfcxQVpMD2s8SKdLco6oQ6gqykW7Lg9li++
         kTSDe6a4is3yBQ6kV3iXH33jz+xPrqKFSPkf6k/KC1NxRhZVTn015kD+4SZzEYeb31HF
         yvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sI36ppd+4vw5yRr/qfzItcT9H0vm+FouNUT+YAtFRhA=;
        b=ExsRV9fHywZ6B57KTJ1QcUzJmZCkaLLFcJ0h9m7SsU6RyJjWy3CZtiy50Hw1byGVD8
         sq4AJeJ6n1fJS4Zz9SmRasOPBBaTcGKDfkomGWeVEc0DWlWCz1XXZaEVJBEodNUMxE1R
         pS6pIlbEHuVUUzpXRUz9zuX7Tp9xmoe3Ov5iBO89fzmHbWLl70Z42r1CqHutswoVcuoG
         xQzE0QgpKzgRbgtd9uKuVMwllfjo0mRQolwge+xRnvqmIdE9DowCTVuCCKwUc19cx3tF
         VKLRqQYEReAMKyvhBmGT9DRKHDb7dPTPB4Q9gePq7e7ZAZSDJV8mLqDVdSSfvk5ZtglQ
         eRhw==
X-Gm-Message-State: APjAAAXg4njfAaPWmnRRPPM2asi8mzBj9ijxqlhiakw1q8VmrhTcia+s
        DAKsjEQG6xtSGt04bm1WcHA=
X-Google-Smtp-Source: APXvYqwImUugk0jDMae8IQv65b2Tpe/0EHgSiCj9SFg88aHscenKpCiuxOcK+TArjQ3mBzKfHe5a3Q==
X-Received: by 2002:a2e:8e83:: with SMTP id z3mr25651232ljk.98.1563500813319;
        Thu, 18 Jul 2019 18:46:53 -0700 (PDT)
Received: from dimatab (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id z85sm5352918ljb.101.2019.07.18.18.46.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 18:46:53 -0700 (PDT)
Date:   Fri, 19 Jul 2019 04:50:30 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/24] PM / devfreq: tegra30: Use tracepoints for
 debugging
Message-ID: <20190719045030.30b2fe67@dimatab>
In-Reply-To: <ffa24275-4499-c27a-8c60-a5f4d738913c@samsung.com>
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223623epcas4p13d01a60ae2b88dde4c4f7fdba04da170@epcas4p1.samsung.com>
        <20190707223303.6755-18-digetx@gmail.com>
        <209220ec-b677-3500-0e55-6cad57e97f88@samsung.com>
        <20190719034938.6382f989@dimatab>
        <ffa24275-4499-c27a-8c60-a5f4d738913c@samsung.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=D0=92 Fri, 19 Jul 2019 10:01:55 +0900
Chanwoo Choi <cw00.choi@samsung.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On 19. 7. 19. =EC=98=A4=EC=A0=84 9:49, Dmitry Osipenko wrote:
> > =D0=92 Thu, 18 Jul 2019 18:47:09 +0900
> > Chanwoo Choi <cw00.choi@samsung.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >  =20
> >> On 19. 7. 8. =EC=98=A4=EC=A0=84 7:32, Dmitry Osipenko wrote: =20
> >>> Debug messages create too much CPU and memory activity by
> >>> themselves, so it's difficult to debug lower rates and catch
> >>> unwanted interrupts that happen rarely. Tracepoints are ideal in
> >>> that regards because they do not contribute to the sampled date at
> >>> all. This allowed me to catch few problems which are fixed by the
> >>> followup patches, without tracepoints it would be much harder to
> >>> do.
> >>>
> >>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>> ---
> >>>  drivers/devfreq/tegra30-devfreq.c      |  43 +++-------
> >>>  include/trace/events/tegra30_devfreq.h | 105
> >>> +++++++++++++++++++++++++ 2 files changed, 117 insertions(+), 31
> >>> deletions(-) create mode 100644
> >>> include/trace/events/tegra30_devfreq.h   =20
> >>
> >> As I knew, 'include/trace/events' don't include the header file
> >> for only one device driver. Usually, the trace event is provided
> >> by framework instead of each devic driver. =20
> >=20
> > There are at least trace headers there for the tegra-apbdma,
> > tegra-host1x, intel-sst and intel-ish devices. I don't think that
> > there is a strict rule for the trace headers placement. =20
>=20
> OK.
>=20
> But, As I already replied on patch4, if you want to show the register
> dump, you better to add the debugfs feature to devfreq framework for
> showing the register dump instead of printing the register dump with
> debug level and this trace event.=20
>=20
> As I said, just register dump is not useful for all developers.
> Almost developer cannot understand the meaning of debug log for
> register dump.

I think there is some disconnect here. I'm finding that the raw
register values are essential for debugging of this driver. The
registers tracing is very trivial and self-explanatory, just can't see
any better variant.

The registers documentation is available for everyone, you can go to
NVIDIA website and download it (after registration).

We have registers tracing in other Tegra drivers, please see for the
quick example:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/dr=
ivers/staging/media/tegra-vde/trace.h
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/dr=
ivers/gpu/drm/tegra/trace.h

It's the first time I'm seeing complains about debug tracing and
currently having hard time trying to understand yours point.

> Also, it is not proper way that front patch adds the some code
> and then later patch removes the additional code in the same series.
> Before sending the patches, you can renew them.

Okay.

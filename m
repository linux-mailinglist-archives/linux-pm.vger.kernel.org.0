Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE7126685
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 17:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLSQSV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 11:18:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfLSQSV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 11:18:21 -0500
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33F1E24680;
        Thu, 19 Dec 2019 16:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576772300;
        bh=1G7FsQcIs7vqbkyh2F1vAEGEbbdVT8Ma5gTl6fOBv5w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e7keS3P1LwF4ZT2yhL3hUCAcyVJrTsIR9UzKe57oNdsSAbK91huuUmxw4uj5fehea
         NPASNTU1i78K0CrfxLQzQTqC8PFXyuK78gWLUe1LkPDzOG6vkj8LaNDRMqbIllRKcW
         T4iQc286CEEUti1oEOpDrf0yM1+lENmw2XdKNYw4=
Received: by mail-lj1-f182.google.com with SMTP id k8so6866223ljh.5;
        Thu, 19 Dec 2019 08:18:20 -0800 (PST)
X-Gm-Message-State: APjAAAU0x40zpci5J3G0cWwdsMzCLVSzYN6y7pKloPZCDf5nhEACZCB7
        baMj4YqOZTyOiPxL9dzDIy/OiQkKK0nmjVYW/gs=
X-Google-Smtp-Source: APXvYqzjT3A3BOaMem5ewvhYkhpvnQHmXadd3vZ1Bf2o2UnYr9PFiKmPucQrvExdBSOloWvbcQbzeuZa1+Z2P1vedZA=
X-Received: by 2002:a2e:2d01:: with SMTP id t1mr1311467ljt.36.1576772298339;
 Thu, 19 Dec 2019 08:18:18 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190724014230epcas5p371a5fdee330f91a646d619fbcc024acf@epcas5p3.samsung.com>
 <20190724014222.110767-1-saravanak@google.com> <cb0d4aad-81e4-0b8d-40f2-7f58ef1e38d9@samsung.com>
 <CAGETcx-tUtnX0T47YGdf7-cgp6e8K9Rgb34Mfe5Za9L4YMGS1g@mail.gmail.com> <754ec843-eb8f-5149-bf7f-ec4abf938821@samsung.com>
In-Reply-To: <754ec843-eb8f-5149-bf7f-ec4abf938821@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Fri, 20 Dec 2019 01:17:41 +0900
X-Gmail-Original-Message-ID: <CAGTfZH37ALwUHd8SpRRrBzZ6x1-++YtzS60_yRQvN-TN6rOzaA@mail.gmail.com>
Message-ID: <CAGTfZH37ALwUHd8SpRRrBzZ6x1-++YtzS60_yRQvN-TN6rOzaA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Add required-opps support to devfreq passive gov
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Saravana,

2019=EB=85=84 11=EC=9B=94 14=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 5:36, =
Chanwoo Choi <cw00.choi@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Saravana,
>
> On 11/14/19 5:23 PM, Saravana Kannan wrote:
> > On Wed, Nov 13, 2019 at 11:48 PM Chanwoo Choi <cw00.choi@samsung.com> w=
rote:
> >>
> >> Dear Saravana,
> >>
> >> Any other progress of this series?
> >
> > Hi Chanwoo,
> >
> > Thanks for checking. I haven't abandoned this patch series. This patch
> > series depends on "lazy linking" of required-opps to avoid a cyclic
> > dependency between devfreq and OPP table population. But Viresh wasn't
> > happy with my implementation of the lazy liking for reasonable
> > reasons.
> >
> > I had a chat with Viresh during one of the several conferences that I
> > met him at. To fix the lazy linking in the way he wanted it meant we
> > had to fix other issues in the OPP framework that arise when OPP
> > tables are shared in DT but not in memory. So he was kind enough to
> > sign up to add lazy linking support to OPPs so that I won't have to do
> > it. So, I'm waiting on that. So once that's added, I should be able to
> > drop a few patches in this series, do some minor updates and then this
> > will be good to go.
>
> Thanks for the detailed explanation. I'll expect the your next version.

As I know, the lazy linking issue was fixed by Viresh.
If possible, I want to know your plan about 'required-opp' with
passive governor.
Because I think that the patch[1] is good for devfreq device.

As you mentioned, you have the other idea to implement the 'cpu based
scaling support'
to passive governor without cpu notifier. Actually, if there are no
any other best solution,
I prefer to use cpu notifier for 'cpu based scaling support to
passive_governor'.

[1] https://patchwork.kernel.org/patch/11046147/
- [RFC,v2] PM / devfreq: Add cpu based scaling support to passive_governor

--=20
Best Regards,
Chanwoo Choi

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD39E43D0FC
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 20:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbhJ0SrE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 14:47:04 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:46024 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbhJ0SrD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Oct 2021 14:47:03 -0400
Received: by mail-ot1-f52.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so4903707otq.12;
        Wed, 27 Oct 2021 11:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rx9K7YTiB8OPYWtDVZrsTsAMzsDbnQQAwSnFdg7WWAU=;
        b=sILAz0fK6qlGamhL9f90KVcaDGofPwZWLsrmcRNNs8/Dt7DtCuUESVnDEXE1bXkdHA
         wowQnnMqojDukj2VAZII9UmO2o5RoNqAZztPVdqRYSH78d1kmVu8AEiazsdMyoFrmHpT
         XIbFJ7W4gN4+/jUFmRasB4mopy7P3Mk2kRSCpU3TGgMEFGWUxK+uAh/vE5NP+yToAL3l
         r8WVt9pM772xMqZh9eo3Jf/fdHifsZkR2eMMUKYs7+PxOQcDmnhCCDzt6TPbd4Mp9OKc
         9/50ifhE5A1rppdby0dYEXXmZtkf3TjeUlXVKyRgVKATOSDR2X2hnpQtL4DFX30+6mY9
         Pxsg==
X-Gm-Message-State: AOAM532s8W0HDifZE2CvWrmBpjr0p8BIIWAvPPZYBcPxz7t2EcGJ5rzH
        4Glxo4Tp5cPOkpkUEjcGDc083XDIKBre06ILWhA=
X-Google-Smtp-Source: ABdhPJxYDfBtLS/HLzWuu19VKWc4qrN8QE79g0jGT9xqhnNDN1AyLpRYCJINfE51FfajtU6a2+SsIhL9qoLkjCnwGUg=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr25634336oth.198.1635360277011;
 Wed, 27 Oct 2021 11:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAGTfZH22TzasJcVa65WXqXa_f_Wp03SGp5UOMRqkx3KO2KZhYw@mail.gmail.com>
In-Reply-To: <CAGTfZH22TzasJcVa65WXqXa_f_Wp03SGp5UOMRqkx3KO2KZhYw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Oct 2021 20:44:26 +0200
Message-ID: <CAJZ5v0he4wNK6uOUTXnjDbkfwt6uMgzj7A3eaX3zx0+gR2M+AQ@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for 5.16
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        "cwchoi00@gmai.co" <cwchoi00@gmai.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 27, 2021 at 11:10 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v5.16-rc1. I add detailed description of
> this pull request on the following tag. Please pull devfreq with
> following updates.
> - tag name : devfreq-next-for-5.16
>
> Best Regards,
> Chanwoo Choi
>
> The following changes since commit 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea:
>
>   Linux 5.15-rc7 (2021-10-25 11:30:31 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
> tags/devfreq-next-for-5.16
>
> for you to fetch changes up to 5cf79c293821d12fd88dee901692cd404247782e:
>
>   PM / devfreq: Strengthen check for freq_table (2021-10-27 14:22:12 +0900)

Pulled, thanks!

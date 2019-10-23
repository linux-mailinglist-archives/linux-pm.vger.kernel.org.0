Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7976EE1D66
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 15:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391927AbfJWNys (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 09:54:48 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57373 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390181AbfJWNys (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 09:54:48 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M1pfy-1iPSxS12ro-002GC9; Wed, 23 Oct 2019 15:54:46 +0200
Received: by mail-qk1-f170.google.com with SMTP id q70so12255704qke.12;
        Wed, 23 Oct 2019 06:54:45 -0700 (PDT)
X-Gm-Message-State: APjAAAWoErbG2vVzPG1ASGwUqNjiigXVXCYO+CmCrM6ASujv85zjVmHg
        7Zy4mtB+bKS5nRP2wftma5HH0gWUaO+zaFufcK8=
X-Google-Smtp-Source: APXvYqwg1GMH8QdNiqBQrXGE6tBmtG4ranjbu2NqBzx98xXXHvxcSSud6NSUY0ZDvcAUkWXJquc0IymGFTx7V0wKlHc=
X-Received: by 2002:a05:620a:4f:: with SMTP id t15mr8358153qkt.286.1571838884945;
 Wed, 23 Oct 2019 06:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-33-arnd@arndb.de> <20191023134956.GK11048@pi3>
In-Reply-To: <20191023134956.GK11048@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 15:54:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1LVo0vfngK_7z-a0nC_t_v85OE8epke2XAFYH9EW821g@mail.gmail.com>
Message-ID: <CAK8P3a1LVo0vfngK_7z-a0nC_t_v85OE8epke2XAFYH9EW821g@mail.gmail.com>
Subject: Re: [PATCH 33/36] ARM: s3c: move low-level clk reg access into
 platform code
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+Av+xoFVIkh4CH56GsaW7ZCFUxfyKXmDxn17ZfHzj78Rnv6BbZe
 nJvEfDkynb539c2dyFovr3KbiR2lWvNrB8g5Fj7aCvYtcecZUc+0sFg5Li/AdrRd4v6oswI
 tdrE2af8rwgXT8xZQBFNBPiJ4RKVCZIPz+NXib65BSX1NQQbaAXsK2i74vScoVBZ3UQT3w2
 Za92BQERlqrCdnzlroQvw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:g8zyAMASZJ4=:kXtUw3vCqlR/mK6YThXKVO
 j3EmAzd9kPfheebOTnhxgjXHq/tsW7rigG3saHPvB8QzySep4Bw+UZigTU9VHQN+pWiCPYr5V
 0AYfXtpnmqpwbhv9fNZwhN8qL/bdVI7hsqzktH9yo9sQlDVTLr/otE+9bD7GYvNS3MHfuC8fl
 +N1raW8tBfOTSPlF+XniHCze/ZHEZ1zjFZMzteJxfSz7INtF9ibDmG0JVkjQOJ/95WVcWjTmG
 ieb7/r/ee/NTXYCWeV41VH7P9SRQFjO9C7Aq6upS3ftkugo+77SGoZ1o0/2B4gcCsLfZ6liRg
 anwSOO8W+HiddRPOyIKef33OTZvY0o5WJj8fIzOglGl/3waHbALPn0E5RzgzijvCI70BofE+j
 7bw7MYPYgGakZ9qh8+la67Z8H12Ls4raiMvfKOSUmDlmWzxEiSFPZyb0O2Unie3q92w6v64DT
 vH0rN98PKLQuqdv+lA4VYl+lwEZUSo2w7vJGqoTB1QFUQl2+4abu3pSEBFSP1PFzW5tSnTXEN
 zca5NgGuWTuCeGWqVvTid9s+U9QJJnlJKDcd+4vuOt+qY6Q2bKeOO8FJykEZKdP8butsSLD6B
 p7sfc1zyepXdFlJ2SVjSS652JLZRIXL9wD8azwcfP4BsAgw0URclfuSqVFqciVQffhZvCdj37
 AAJewUrfVBjuuDpZkvie+ey2IcMsb3Mfth7mMaz530MFuYMdhybbKRK4alfkCLQAEf7/EyVFH
 hLrdDblzJwZmcNF1CQaUqZTi8QlEr4fzgNyQoVgvRoGiy+cmVtPwWAEfRf73IwKnLRqZ3SGRv
 tUCTeuGo7/pmeZRvVEA1urNZbw+I0mduroQA3pes9YrNrjLdIFNdgJi9QUPmuVU59k4WNs/Za
 qVc91JR4CXDYlKyaYv4Q==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 23, 2019 at 3:50 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> >  # common code
> >
> > -obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += cpufreq-utils.o
> > +obj-$(CONFIG_ARM_S3C24XX_CPUFREQ) += cpufreq-utils.o
>
> Drop also here S3C2410_CPUFREQ_UTILS entirely.
>

Ok, done.

      Arnd

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A36E1D7D
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 15:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390570AbfJWN6K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 09:58:10 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:53931 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389290AbfJWN6K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 09:58:10 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MIdS1-1iBStx1SNx-00EfYE; Wed, 23 Oct 2019 15:58:08 +0200
Received: by mail-qt1-f171.google.com with SMTP id r5so32455894qtd.0;
        Wed, 23 Oct 2019 06:58:07 -0700 (PDT)
X-Gm-Message-State: APjAAAUHBPMl9EohyXysWVLlzPzmvA3N+ajd/VQgQgL7DaGBNk85mXW4
        r7KjOcR/woMY3MxVJRSjygb2m018NHGsMDX2tnk=
X-Google-Smtp-Source: APXvYqxJH+IQGSDqFR3s406c31Lil6nKN+3+UehR3Vy6jXtDo7t9tSTK3nMWgp2PtcXo9B5NCXhOUradIyavMq47Rwo=
X-Received: by 2002:ac8:729a:: with SMTP id v26mr9069953qto.18.1571839087129;
 Wed, 23 Oct 2019 06:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-31-arnd@arndb.de> <20191023134420.GJ11048@pi3>
In-Reply-To: <20191023134420.GJ11048@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 15:57:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3qTgBkWnuVRa-90b1d6grGhm7R2ef92YdkVmUr0Fw23g@mail.gmail.com>
Message-ID: <CAK8P3a3qTgBkWnuVRa-90b1d6grGhm7R2ef92YdkVmUr0Fw23g@mail.gmail.com>
Subject: Re: [PATCH 31/36] ARM: s3c: cpufreq: use global s3c2412_cpufreq_setrefresh
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
X-Provags-ID: V03:K1:Pt6bOUMjlCPyImjCF7eJom9dRlD7n5jtt69gWPmGMzLglUM60aB
 obddhwUAS6nfjeo0KsSCRIZ2/JNNZHIszYuHeIEY1E0s8IkQthznVylnvumY6wRAv3bJCxj
 I9kzymYjyixCwm2EZXAFXAIChLFeDi50rSADx8zQM8xYg1utThex7JJSHMO3dTO4QReG6cL
 lRMG6oxjn/S8N9mYA33ZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ehGwi5ZwG4c=:o3eO2yHm2fIGZUhPLpnvIc
 bcY7UzggDnlnFFlkHNic0/SKpmLLMHdZX71RfQ9XcC9D1GaDCiMiV1UxXt/ggufpGwk1z7dzT
 nQEFr6BS5oQ0v8JszAg0BXR9d1050UXr/RXgcjK2VnyuR5bvo8wNjw0rsuby8fY0MPjrTHThW
 RJpFnypCPT6AiQvm1typpUWTuuI8FSU6mvpG9mFl+5xsbt0pdVr42muUFlBpV8OvqN6K8pBj1
 06s7qlex/nd7I6MaE/duNmCzpFXwVojea6uvxaSEP6c+PLFddwSOpSXYp53stEnU5EAssaIVF
 63w311r5wdqWzt4+6+vSS0lMUj/4uoV1mCZCLJasEfH7yOSyZefhwfw1zqw7v63eoj4ZD336Z
 vhCF6MFI/0VmRK5bgd9ZsJ9NtpgXhIOgglLAkV5Lv5X75jERdO+NoEu/Jw0O8BrQh53cJznh+
 paqDCeVlNF5VOzht2rAdMBEuKW81sRbWwCD30jAPEuzLRxco3ZRZyQQAR3r2Ua+CKch0vNOu4
 BF/slqK/5v5wNiJSYLbn+dCwsFX4tX2iiO00Sn1TXw3gYgriY21Hcb1ZI5amj4x9FHnI2N/Fy
 5wxdmOUdkdHZrb0j1djNZPdlIDXFPUy1ZlDWdPT6HBCA8wYR5uIbmvu907beiHZpYwjNHO8ju
 5a/v8+IpTHlV8TZMFsZkmicfMJ5HnNVI1XGWR9K+3r1tWinAQWBpwEg21075fxVXqxcyoFNuq
 vAMlX6eIHln4uf7fU0cigFhiG8oXrbOU6KUdD+TB9W0U81cn3I6vC7ZmoFUZwgIDgTwEpKOqq
 lb+R9dN1WhHTNbV8LlbLmjuIPfHcu92Y7+pjt3shAqvyAM4Ot31pURYMk1ac+VLYGjfZvzCZq
 TwVu89sty67GZBMzoqZA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 23, 2019 at 3:44 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 10, 2019 at 10:30:15PM +0200, Arnd Bergmann wrote:

> > @@ -246,6 +246,7 @@ extern int s3c2412_iotiming_calc(struct s3c_cpufreq_config *cfg,
> >
> >  extern void s3c2412_iotiming_set(struct s3c_cpufreq_config *cfg,
> >                                struct s3c_iotimings *iot);
> > +extern void s3c2412_cpufreq_setrefresh(struct s3c_cpufreq_config *cfg);
>
> I think that it does not cover the !CONFIG_S3C2412_IOTIMING case.
> Either you need to provide also the empty stub or add default=y to
> S3C2412_IOTIMING. Otherwise cpufreq driver might end up without this.

S3C2412_IOTIMING is not currently optional, it always gets selected
by ARM_S3C2412_CPUFREQ, unlike S3C2410_IOTIMING which is
only selected by specific boards for reasons I don't understand.

        Arnd

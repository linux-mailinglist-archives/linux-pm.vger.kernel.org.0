Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 626FAE1D35
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 15:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406085AbfJWNrL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 09:47:11 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:43823 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403782AbfJWNrK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 09:47:10 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MvryJ-1i7fje0dbr-00syHi; Wed, 23 Oct 2019 15:47:09 +0200
Received: by mail-qt1-f182.google.com with SMTP id u22so32282921qtq.13;
        Wed, 23 Oct 2019 06:47:08 -0700 (PDT)
X-Gm-Message-State: APjAAAXQMkDTl5SzJEHRA5lvIiBqcow04DQFAp/XrQqc7G9JAJBz1QzK
        1n/8rsJHTxIc2QUXJp1jhrEdTRrFhnpISuuaFoA=
X-Google-Smtp-Source: APXvYqz7PbcGsXeFYyvGyowaDFHTfI5KDbWhAt9grIvHRgmEgVC0Li/OGC7C/Oouqywkf4gr90cygIgYwHI1sOkpne0=
X-Received: by 2002:ac8:33d4:: with SMTP id d20mr9129615qtb.204.1571838427927;
 Wed, 23 Oct 2019 06:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-30-arnd@arndb.de> <20191023133800.GI11048@pi3>
In-Reply-To: <20191023133800.GI11048@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 15:46:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a10MkTdStasKjGF9OBOoW3ZJ8RVD4-SxML2qhKXXciH+Q@mail.gmail.com>
Message-ID: <CAK8P3a10MkTdStasKjGF9OBOoW3ZJ8RVD4-SxML2qhKXXciH+Q@mail.gmail.com>
Subject: Re: [PATCH 30/36] ARM: s3c: remove cpufreq header dependencies
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
X-Provags-ID: V03:K1:nU8GhVag8mG546m44yMwzxz+Fai6rwpvNgJIJnooaWq/qk2Kp4m
 cYlVRv/Qa4A0ZefusI/j+8naTS9nf45I4IkphOXAXNbY7JauQXMBNSPiTa+cT3k358CzmJS
 xPDI4yADbs/NtN4WFo8wTTqA5U2s2A+nOlm6cJWfaszDeg5GNa265lvXpTge4U8PCyVal/+
 b5Kk9xR4joDVxm0/Rbyuw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:G5/qfliTrb4=:k2bkVflhpLLuILcjMFYz+m
 9mdNPgOGtQ44XLqjHpL7SmznTu+7/QP1F3bH9Z8brIdcW1bb7vn043Co8rrK0wEt+Vl6Gn4pw
 JDw9HpaUYaZaXz3HYntahMEwB39HfyWXr2jON5dbkyUaBi2ESKX+GZ2Q5Sai9FbFEL4+zOtVf
 wujOK/SpxiUAwUxXJ6INj5AzOb1Sv9xh22uf3mLgJPYYN6/AKrMbqJd2SM8d5cRWw/AkTrm62
 oBzWy1Ts4koa53mz4tlsJguiNQOAxZNJoQn+d5MHnYxzngd6Zur1eA5fwhrGVkYGIFRJX9TG8
 as5s8xUukb7VwU5eirR7m5r7cBn1w/t97za9x7/CKpnySgG6kL+nL+Z9VEsCW3hWDIL2icM+y
 a1Pl9Yt+L8Ne9NM+d1cmEBJCsedFAtaubdsRh8OprKSFmk0pjs31jxN/5HiZCgNA3w/iSwi4G
 g+lmxUqrHvacv9ipKLCnkvNgfhSoixgmzHY4uG2gkMEyaRdNv3Pcep9K/uI1XOx3tzs786EIx
 fjvmviXCBXvKo2clufuPwmGr6WYJYKMHmmmKXEu5jGVT0CA5mcTh8dWez6LRKB5Yee1gGAt8i
 e05Qh2DFanCxF+GpOnkRVbDyF+TyquHd56gJFmI/m++nL/J9++n6sD2pS5uxrkcGXP6GnbKSW
 C/lpO2BjT7Hx1js8a7R7McLGy23VEF0qpw7o27y78zr27P7gXRSlmeyEOsS/Ntx9AmJngUuzh
 kgNgviwfExrP5pKXGcpEHY8Fx7SlVyizLbgrLCnTgaVq342qjUC4V+r78TdJ06ilPIgU2sPUF
 1ty23GMfuUbbFB4Nvep20D3GBbH0J4UdQ8mDhr2N5m5kUXB03oCVuoTFeyCg7yQ77rbyiYCgi
 4PJMfwgsTS1LXasvmA4A==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 23, 2019 at 3:38 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 10, 2019 at 10:30:14PM +0200, Arnd Bergmann wrote:
> > diff --git a/arch/arm/plat-samsung/include/plat/cpu-freq.h b/include/linux/soc/samsung/s3c-cpu-freq.h
> > similarity index 100%
> > rename from arch/arm/plat-samsung/include/plat/cpu-freq.h
> > rename to include/linux/soc/samsung/s3c-cpu-freq.h
> > diff --git a/arch/arm/plat-samsung/include/plat/cpu-freq-core.h b/include/linux/soc/samsung/s3c-cpufreq-core.h
> > similarity index 99%
> > rename from arch/arm/plat-samsung/include/plat/cpu-freq-core.h
> > rename to include/linux/soc/samsung/s3c-cpufreq-core.h
> > index 2c7cf2665634..4d22be1031b9 100644
>
> Can you also update the header guard names to match new location?

Neither of those files had header guards, added them now.

        Arnd

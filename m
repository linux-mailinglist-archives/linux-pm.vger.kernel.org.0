Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF623E1C6F
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 15:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405833AbfJWNXo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 09:23:44 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58323 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405812AbfJWNXo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 09:23:44 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MpDVx-1hf9pS47iR-00qfp4; Wed, 23 Oct 2019 15:23:42 +0200
Received: by mail-qt1-f178.google.com with SMTP id w14so32197503qto.9;
        Wed, 23 Oct 2019 06:23:41 -0700 (PDT)
X-Gm-Message-State: APjAAAUOEer4RSyYJoTiziHt8cYel+67LG9wADwnk7kk+F0IuyC1ktQY
        QG1Ro0Qn/r+hOJoQLOSWGVIi/mOzQpv60MzBVto=
X-Google-Smtp-Source: APXvYqwU3y5YqkOIsK2y7eYvy0ctJhOflxSMk/EdUo4ryq/EKaRqLWAAN8gOEJgyL2Cd6mKUElnaT6RSKuR35fFlkXE=
X-Received: by 2002:a0c:c70a:: with SMTP id w10mr8851889qvi.222.1571837020471;
 Wed, 23 Oct 2019 06:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-15-arnd@arndb.de> <20191023123722.GD11048@pi3>
In-Reply-To: <20191023123722.GD11048@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 15:23:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a13UWnsnTeDQPTDdAXjnwT+-UZchKqezqG+npEuFNK2vg@mail.gmail.com>
Message-ID: <CAK8P3a13UWnsnTeDQPTDdAXjnwT+-UZchKqezqG+npEuFNK2vg@mail.gmail.com>
Subject: Re: [PATCH 15/36] ARM: s3c: adc: move header to linux/soc/samsung
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hwmon@vger.kernel.org,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Kukjin Kim <kgene@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:giqxSs+A+LAWYj0Sxj5nusxA8wHxPgN5F7tmxIao8ABk3bArcf2
 zUzbNsCh/ELi1K0kYEtEHgESjQs8HH8mRSfd6UfgD6VoJILtQhIurqpPVu/Y7ppYgCxdeBO
 +KPW8WQc+3tYNDu+wtPaWzmF1d5joeNw55Bk/kXIYjEbT2M7JIc++gbj3x+D9b2+YVUHKmD
 CGd/U+YvZsxVeqmRKKhmQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:c23PmR9jg7U=:6laGSqdsRzet9T20EG8mhj
 lZQ2S+7Lre/1Kzv6tJnOjdHHK8EXjc/R15mmPPfPm5h+MuuAwjf1KuercXzl/j5MPe7UzUoo1
 C63FU6HnEhpnPHPYXb0KDFIlRTu9uAGEZC+XPCSGfbQEmEPYhQqHi/vgYSYfmYXIfzSDPpLN3
 f3cvZ13VuNbUM4x1o1VxHQ327ejTmy8a+Uf/oFKDLRsLl3qjxb+TxwMu0L2G63Sfr+ahQiHe1
 aJ852JJkqrYYBGDGft9v4qKqE2gmq6zGKoMVmFhc3hL2jC4I3GKFyufrGApIxZDOoJhCNjYmx
 OAFKxQB5OJDc4y6PMADDKi5eIUA2dJ5nI6F+Fvq9Y33vABOubg2B+kZgDjs6DrgNgLC1/LQNp
 5OhBo0KjulvjcuGLeXq9FHG6rzYEFhsQp8nX7/Z9SMlXOhDszKiI6ksfZrl4r4nnXErAPCJQP
 OM0F6N7qjKmaeeE++LrBmfw3YHyvGs3i+ITKviJOiAdL9cIGDI6Itw3jrbwftAbf64tA033LD
 gaFdIIOYwk40PqVyx4ETW/tTJ8EuPAseG17aDzKz8zDxIO5vA8+ubHKCfiONgh6P1oyHOLL6x
 uAmOBPPyB+e4uGE5Zz6LpAj7LOTsfo1gdm/iJMnqPEyfJjOXqwwdOaD3zvv6f1f3mzrt5Zx3b
 KaXpf7+ujMKJBRmpkAprsHhO42e0jXZQJnxNSei2NARCRKJ0Hi2hTtZNzLxPBOwaI3iSqX1Jc
 srxZWs+TDPV0QWZYr3puP+6ixTN95m/CXe0vJ34uuR42GfSxSvdmDFuaz0abdbvy8HQiPB2wA
 y72Fdtkd/7Dz81LMb3+g/uP4lwPBAX6bRtWRxXe0iklXLSqImDosSqnK/QmOlhVi5TG1Wkq13
 XXob4cq0+k4U7jH5cCPA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 23, 2019 at 2:41 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> > diff --git a/arch/arm/plat-samsung/include/plat/adc.h b/include/linux/soc/samsung/s3c-adc.h
> > similarity index 100%
> > rename from arch/arm/plat-samsung/include/plat/adc.h
> > rename to include/linux/soc/samsung/s3c-adc.h
>
> Can you update the name of header guard? __LINUX_SOC_SAMSUNG_S3C_ADC_H?

Ok, done.

       Arnd

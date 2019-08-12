Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 463CF89CC1
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 13:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfHLL0W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 07:26:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:49285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbfHLL0W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Aug 2019 07:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565609116;
        bh=v7b7BvrXciV3NBubwOpaemt2kAsPrl1BPe/Nz2NswBU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MGnSkv10s6bJr+2LYe0Vg+T5aQQgWun0XdWZhVJjH0OTeFdRRlBmS6Ih2lFLvyv5L
         vWF5UvQnSdqCZULmjwQ9RVEYSZYOAIXomyeYoAZIvUPv/MqCc2QtBZUOL0fxHIZnVy
         VqBXryDgJhswl2xOlxSt0waDs6QiYE7+ZufmluR4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.152.193] ([217.61.152.193]) by web-mail.gmx.net
 (3c-app-gmx-bs80.server.lan [172.19.170.228]) (via HTTP); Mon, 12 Aug 2019
 13:25:16 +0200
MIME-Version: 1.0
Message-ID: <trinity-0fa641df-f7bb-4627-a9ab-aac3cabc90ba-1565609115974@3c-app-gmx-bs80>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Lee Jones" <lee.jones@linaro.org>
Cc:     "Kate Stewart" <kstewart@linuxfoundation.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        "Richard Fontana" <rfontana@redhat.com>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        linux-rtc@vger.kernel.org, "Allison Randal" <allison@lohutok.net>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        "Sean Wang" <sean.wang@mediatek.com>,
        "Tianping . Fang" <tianping.fang@mediatek.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Eddie Huang" <eddie.huang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        "Josef Friedl" <josef.friedl@speed.at>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Sebastian Reichel" <sre@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Aw: Re: [PATCH v3 06/10] mfd: mt6323: some improvements of
 mt6397-core
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 12 Aug 2019 13:25:16 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20190812102209.GI26727@dell>
References: <20190729174154.4335-1-frank-w@public-files.de>
 <20190729174154.4335-7-frank-w@public-files.de>
 <20190812102209.GI26727@dell>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:+H+zrFxbX3u65Kz8Q14UR+W2QL6KWeuqbqDXcd/mwlEXxknDmP8VniBO4dlsPO8lvzAXn
 3Y5NyGNEFcxG/hiDEMdhlb6mGUuC2oM0phOjueOu2MDtHhyNSzKa7zzri7AaOrLyXgls+u8sTwPQ
 oAV/CbSBYlmUVInmmRiS2kzjJFgTPVlFkzP+Rwz8lHdNBK149VceMK36vw/RyB+IoFv+U8FKiztO
 yMwrHuIbMWrhlGq1Uj1J+0nxuOtWnyd5GyKRFUYsqojA8ecuYK6tOXNnVm1cb1FrnaNST1QYDBxU
 Mg=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Yj7l7CH0Mw=:gZd+QnMoJMQ46IbcpRg+69
 uYQ9PWSHzCb4jiQPAL0RN4XqGKUkZP7au9BlZu0WeAXvh2moFGkS+Qh6H/UHvlfwoK/zckQts
 cSjLWlFMupqJc7aAKUQfYQeemHELWiYqn7OHSi3fCzZ5BWFF4A3nQ4g4yoiqnt0pEuncDClxD
 qyoAVq9ArjxiVhYQYJA+PBrs7RziX5GkbBGDbwU5A9oGzVXvGiaDnBv6dUZOnhrW42dabqHS0
 lXU6xDXmrEAtePWxyeJZ40FbZOUl2nBhcn0Ctq5enGlq6vSuThfpLhU/cMvkVj9nHxdUkAeqy
 ASvjyoO1IKTe/Leg8l0X6YSD2sTyzyv7YXtP0U0sEOo1WUBWGayxs4gAzARxamymbaBjlhfx/
 OUyC1XD9pmsdx+kOvL61uobd2H29U8aF9pvGk1JBGdzDPzbNvzGqg7Oc1VOkBk9gGzSzeaCdw
 EWqUYj0GKkc5wRo4mB/yfqKK3ymFbRVrkA8YxocvAnR/cXIcxS+jvKmY2YyDG6p2BMGEPvXKZ
 7xzezeddUuOzzBfMo3wupso6yj2SDGjeO5OPEwTvJNjgdfUr8uCyYRFquSH5DsOvA7C4xYYjT
 gN3DvuN67PPM5sP0cvLOSC6YEijq4vcf44N36E+tBQs7z/K5g6lA0LQzCD7+B4ZjLv1wdYjDw
 06kiD9astcDCR5QcII++ExU97eegbwccVgVGX0HqIddrKtQ==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Gesendet: Montag, 12. August 2019 um 12:22 Uhr
> Von: "Lee Jones" <lee.jones@linaro.org>

> > - * Copyright (c) 2014 MediaTek Inc.
> > + * Copyright (c) 2014-2018 MediaTek Inc.
>
> This is out of date.  Please update it.

maybe i should drop change of this line completely (else it needs to be ad=
justed every year)

regards Frank

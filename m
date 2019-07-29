Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D75B79BA2
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 23:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfG2V4A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 17:56:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40298 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfG2V4A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 17:56:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so54825365wmj.5;
        Mon, 29 Jul 2019 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9J8GB0xhRh9txEG2lafqBYymsBmgmPy2F9KR/NPWds=;
        b=oN4DFXkGo5BiAvGR0K6DCAaYEbPbSFCUve3irIi2Ulp2uE/8nlxzlEVhB2Hk3ykMdh
         QgK8Ww6Mbcj5k9FS6UAd0OetuEYQ8xnZ/V4hyXdcm7jtHDnxqrO5gATYVhDyqThjO4ms
         lQQ4bPLJuumWO5s4QKgy9zbAocMuraXRW4VOc1PEQ0VF3B0iIzqqeLAbY2bg1BghVQ9T
         mhldSDLURapXKh20wwPLWPXm7M+R4zPlGHOrrg8SQVoQMfPmBE0JDnEc502rNMnX3rjp
         PiRHlolEy6Djq1tkUaTAxJI4YFaNWJhHgBvED2v2LGi7vDLg4VN6dug2nh6mrwEhLZD5
         9QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9J8GB0xhRh9txEG2lafqBYymsBmgmPy2F9KR/NPWds=;
        b=Do3RKuoYInt30fAvC8f0Z0qVS2PDiQG3D+Sao7HRV5uud2o2nOVyqTK+7SE3yXagfX
         lkW7BQHFJVJTxsGcx0McBw+UhJa+JBMJdQheo/m6787CJXgv0ABgI6ju1zf9FIi5mPwf
         j+ax+IHU8gpldzDRlrTUzWOASZVP3h6e58NX/cu7lP13RacBq7aK16FDJkrty0UmN0er
         ATrWVLM+5NKslOEsfrPVmn5iDv0zsvdEpcSGINrJv3LAavC6ModIEtmrCA6E4VwgEklB
         MSPezsa/xx8py9PvOeqPdX0lzWolm9WYrwE6QtL+oZYUn8dk62ApEW2FkdK6LOmNyQ/c
         dP5Q==
X-Gm-Message-State: APjAAAVe264g4McL6fz3ShzJGoLbhYXqGBCyfTyuD1RvDedjoCvjASZo
        VqfFuFgX5aROI074gTqCMmpWw9jHBtbLaJG0Hl4=
X-Google-Smtp-Source: APXvYqzXFDFvzgcJuqtb/pBjZayKskb/daHPAddpC5NNx1rTiJ1Kj+2Y+VeO1PjfbiAVpdoSN7LZ5uymb/xdUIN6HK4=
X-Received: by 2002:a7b:cae9:: with SMTP id t9mr100637562wml.126.1564437358263;
 Mon, 29 Jul 2019 14:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <1547808474-19427-1-git-send-email-uli+renesas@fpond.eu>
 <1547808474-19427-3-git-send-email-uli+renesas@fpond.eu> <20190726091325.GA13111@vmlxhi-102.adit-jv.com>
 <20190726094724.GA14913@vmlxhi-102.adit-jv.com> <CAMuHMdXiOBxUDXLcL6R7jHF4DMoH=72yMkSiv-51aV7cw3my9Q@mail.gmail.com>
 <20190729113244.GA12631@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190729113244.GA12631@e121166-lin.cambridge.arm.com>
From:   Eugeniu Rosca <roscaeugeniu@gmail.com>
Date:   Tue, 30 Jul 2019 00:55:46 +0300
Message-ID: <CAH3KO=19vy1D1cWUpxZ1+F=dyg=10F2UhytwsLxXG2Z=OnH=fg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] arm64: dts: r8a7795: Add cpuidle support for CA53 cores
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        "horms@verge.net.au" <horms@verge.net.au>,
        "khiem.nguyen.xt@renesas.com" <khiem.nguyen.xt@renesas.com>,
        "dien.pham.ry@renesas.com" <dien.pham.ry@renesas.com>,
        "takeshi.kihara.df@renesas.com" <takeshi.kihara.df@renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "Wischer, Timo (ADITG/ESM)" <twischer@de.adit-jv.com>,
        "Maik.Scholz@de.bosch.com" <Maik.Scholz@de.bosch.com>,
        "Dirk.Behme@de.bosch.com" <Dirk.Behme@de.bosch.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Geert, hello Lorenzo,

Many thanks for your comments and for the willingness to help.

For your information, we've recently discovered that, with all the
findings already described being absolutely valid for the reference
targets, disabling CPUidle on the customer HW is apparently not enough
to fix the audio dropouts. We will first try to identify those
differences (both HW and SW) which keep the issue reproducible on the
customer boards. Once this is hopefully understood, we'll come back
with feedback.

This investigation also happens to overlap with my vacation. Hence I
plan to update you on this topic in 2-4 weeks from now.

Thanks again.

Best regards,
Eugeniu.

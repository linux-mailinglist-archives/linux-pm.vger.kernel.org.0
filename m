Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD7812A6A2
	for <lists+linux-pm@lfdr.de>; Sat, 25 May 2019 20:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfEYSvs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 May 2019 14:51:48 -0400
Received: from mail-it1-f175.google.com ([209.85.166.175]:37580 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfEYSvs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 May 2019 14:51:48 -0400
Received: by mail-it1-f175.google.com with SMTP id m140so18597827itg.2;
        Sat, 25 May 2019 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lP3FpbfMIvuOQG07MVFCG4V/h3ywZ1BD5hmNfMR3J6E=;
        b=Gp3G/q69VktgJze77MTankb1LTSDnjZ2d51y/gCJd8y56hym+gHh1iKOTxaxI4VM/s
         f/cGlT2W+VhhMmbnMwo/Q/ivp/I1zuCj5w7qkNYD61dFERRvb26ZA6uq2kpPl8WDssnt
         ISgU7Vg5Npw9Cu8jKyjfft/xYixyMkNQ7oDXi0kM11AZHKobspRs0IAFQknwlwi1S0kk
         swMqg7WKqfLj1GP6YTNHfDuagrjMRTrSYQLjbE9bo0qzI/b1Ceyt4eX+Lq+UWQubQ3pk
         CVGK27DPIfFil6xfP7iMyfO9yUJz1lkM/qhDpDhsMefFOraSVRqB5QQK6oERvkP4GG4U
         RnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lP3FpbfMIvuOQG07MVFCG4V/h3ywZ1BD5hmNfMR3J6E=;
        b=TmXrp/jQa4Gv0n68f0Qze7rQ1KWQNZle6JxLHjl3TD31MT+0UJw1cv6jYAMGTfITo1
         y7jPXsLo2pH5Y6lLpMIeTrvzqbSSNYVDVB+NAlIn9d0RwOSa/MVX4BYhB8JeAvXQAsc4
         YmCvJKBAJoS4j8YixF16Xog9ozfyJLgo2IwTjE5Rc6r6D6darE9nrUBS+5lyTomk108K
         EH+lOpCmxm7PijWyYDxXiZ+on5f6UMAUWz56WCz65YviJrL7dvItDdSZszjWkIA4JbM2
         2WbT9rWWedJfE2uPm8guNSh6HlNXtc1gu+GxHRsQibdNiIz9DDRTgyffcROKUUaefED9
         K3zQ==
X-Gm-Message-State: APjAAAWqrcz0S1t2QhvOSqilC7RFJUlShjOlyzjI7jD3aK1u9Pe6lQ/k
        GUIevqdgNv/Z6NoFDFMlbH63IGlqEXbePe72xqc=
X-Google-Smtp-Source: APXvYqxDjHQ42yVP5kkUknPqUTdsPJqa8BjfguCPfpya8aOsIX6AQUF/JCUyPhWCfpTT3QHEbBKyxEpxTU8GUV8lVeg=
X-Received: by 2002:a24:6987:: with SMTP id e129mr22099229itc.105.1558810307628;
 Sat, 25 May 2019 11:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190512082614.9045-1-tiny.windzz@gmail.com> <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512221612.ubmknvim4utnqpl4@core.my.home> <CAEExFWv5A5mhpV7afQT=AaYx2ko5QnfbM6HvfuTgT1Na=ssOcw@mail.gmail.com>
 <20190516182936.h6xdzp3gtg4ikave@core.my.home> <CAEExFWvDO3wJd6wp1hFudf3EGF0NixgKAwAd5-b1=VLF+7-jCw@mail.gmail.com>
 <20190519142239.eolisexp5mrdyafz@core.my.home> <CAEExFWsc_YB8NORW4ULfuoicL=xr_oAdtHSaxz4ELv53qvCAsQ@mail.gmail.com>
In-Reply-To: <CAEExFWsc_YB8NORW4ULfuoicL=xr_oAdtHSaxz4ELv53qvCAsQ@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 26 May 2019 02:51:35 +0800
Message-ID: <CAEExFWuaEW9iKnpUdmkHMzjSMS1ichYQGhtWqGibOe3FD5Mt3g@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal: sun50i: add thermal driver for h6
To:     Frank Lee <tiny.windzz@gmail.com>, rui.zhang@intel.com,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, catalin.marinas@arm.com,
        will.deacon@arm.com, David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan.Cameron@huawei.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, Andy Gross <andy.gross@linaro.org>,
        olof@lixom.net, bjorn.andersson@linaro.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        marc.w.gonzalez@free.fr, stefan.wahren@i2se.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

HI,

Following the discussion above, I made some changes.
I think it's time to consider V3 and see what else needs to be modified.

Thx,
Yangtao

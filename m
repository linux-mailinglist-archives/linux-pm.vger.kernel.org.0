Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1802F152BB
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 19:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEFR1t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 13:27:49 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:32813 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfEFR1t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 13:27:49 -0400
Received: by mail-it1-f193.google.com with SMTP id u16so10067255itc.0;
        Mon, 06 May 2019 10:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hrn4nDHLtIMhzMGRLfGe5OwhTlrLcnKtSdjsnoP6xiM=;
        b=DkeyWD7RBFpR9tT6CP4d99Vm+FIBqsrtXbFyfCEIPIzWYYg9bbTURlXAU8G/p6U9w2
         GziT77do1ZGEqVTuzqStaSYxaynb3jE/5CRgWR+6HsUnK9wpDg9WoUmqleUe+7x9SmZ9
         KMN3fF4itf4zL0p6O8w5nwPtvotWnbJiPWTlES8b9AJiNShEel/YDJ+E3smvvFHgH2hD
         NYDI5nFzZArpKH0MyxzorQff6KMSg8JYschfAlDcc8RdBrh+12kZWEz9+Lcw8w2VqcMO
         /AYw0i9RgHqNlneApOcM/7Vs3X8OBziWx+ka5+cBzM/B79yWieEyYBuYoXqCqPo2tkLA
         QtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrn4nDHLtIMhzMGRLfGe5OwhTlrLcnKtSdjsnoP6xiM=;
        b=ibPdwpBZvEq7xvuFM02v/0OQdIL8Ce9O2f4B3qLaz9rREQYx2euUlrMJNXoozMA0q6
         FjjxN5eWt5WubTnkhFXWftLl1dXBFUIqQQWvGEbB2eDf7lr1zZZRhpq0cJAAwqQq/Qjn
         WPZ1QuP8fHM9oIxWBvOCdfV7tHbQLrpwPmZTRyCHRmDJxSfY/PLK+nJ6YKOMBOkiZ9yV
         QLhGDQr+Nl0IcTd0dQdEdB6OkNXwvBBg+U054CO9b3ZYU7wmVn/jciBM5bAHqvkkNkoE
         W8+J5zJv9EPGW3kq2V8WadmXQTUh+kiYXGPW3seVebkeZnUbuM3SJCI7znOimcZ+vMSn
         m3YQ==
X-Gm-Message-State: APjAAAX7wxep1D3AQG7vJjhThm2dNLNqi+MOhLn+j7+0dyVrZ6jdvAQ7
        /bkx3dUyDvDGhoXFTW6JmLKhEI9MObTY1hyIUes=
X-Google-Smtp-Source: APXvYqypzmeE+Qzmq7cAlI69wXa0fQ7lASmzZADHAmtTVDFoQy6R0N49XZu+0BmBEs+grTENfcg1LgcH5YN+XV/QXYg=
X-Received: by 2002:a24:6c54:: with SMTP id w81mr18770409itb.78.1557163668187;
 Mon, 06 May 2019 10:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190410174139.20012-1-tiny.windzz@gmail.com> <20190410174139.20012-3-tiny.windzz@gmail.com>
 <20190426211540.GA890@bogus> <CAEExFWs2UwPLzgyO0apMOZf56um5isdZmf+7-wj_TqMozxZJQg@mail.gmail.com>
 <CAL_Jsq+0mQYyAqfY3nmF-oFx2X4qHU567chQ1s8p-rgD2GEFnw@mail.gmail.com>
 <20190430044245.s4viduudej6q2eq6@vireshk-i7> <CAEExFWsAQ3b42YqfW-b8vuq_NZgfDe+0D5TzP09ber0Ljvv43g@mail.gmail.com>
In-Reply-To: <CAEExFWsAQ3b42YqfW-b8vuq_NZgfDe+0D5TzP09ber0Ljvv43g@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 7 May 2019 01:27:36 +0800
Message-ID: <CAEExFWsVgAV=br1kAfgMTLnS6ELfMjFegiusUYPK6A3k7Nq9Mg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: cpufreq: Document allwinner,cpu-operating-points-v2
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

PING...

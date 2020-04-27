Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7318C1BA192
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 12:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgD0Knt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 06:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726537AbgD0Knt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 06:43:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EFFC0610D5;
        Mon, 27 Apr 2020 03:43:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so19972310wrr.0;
        Mon, 27 Apr 2020 03:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=8VrvOpg1vEprgEJxlFupBjFgcQQNFTGZ6LU4Tz38GQo=;
        b=dXF9roYiDIYZjPSd2jGEHE9og4CQxpRwJtc76ja66qiCXiHh/uRRb0XIInTA/k28zZ
         Dh6RVCce4oD6EbqXH1Y5TzJtdUdIPI35WSA3sAPFZ06jy5lUiVq1w82xsFcamybOm4se
         obRdBmLrwOUzH8RJ+ex7abuj1Ah1zzBrhdcvKsebjVr4WFkKwTPZOMpI6Wpl65InNT8F
         i4fNZUkz8RvLnGvuLgD3XaTWYezh0pGVV5FnDIAanvo3YaiWcb03sb63X7MmKeCfRTYU
         uQyXNT0f3fnbMFJqi27+GYFSlQiLmvMh0RdLnXDhH1Sz0X1b30YRlIadeJUe64nxoC8X
         1WMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=8VrvOpg1vEprgEJxlFupBjFgcQQNFTGZ6LU4Tz38GQo=;
        b=o46B3gqTHESMsUOca4zsqFlP5o2USvfR5pYasZ3PpAExOKHIVvKRN9vDLRPkZ9NZMc
         e4sm6xTd+wkBcn14Oun6rfsFxsGLrxULbIFWrkXM8olMPRGtcnnYoUqLCSIlu36mY2rI
         /ZUMJkItf/P5s69IHNIXRJ5itXvH9WqiR06uQktiFp8WBtK6YwAk6eEUbCIPmtLIEsDX
         CW4aqspqPBulhmmRwPBnqgjMgVpSSsTYIIpedcS+kgOIynyqQOFgGva+by53TXK9pRkc
         VksQJpWUHlijErXE+q1yc0GNWEo48lvzkLcYC7hs+h0ycsq0HGg8IUS+9Uqz69PUKq8H
         5YMA==
X-Gm-Message-State: AGi0PuY5k+G35Ka0zspxGxWbVplvvLvnxokP7fPgCN9fslE6W5CiDBFu
        gO+Cgrr1RMcVafZwGejKVZ0=
X-Google-Smtp-Source: APiQypLo5rKIrkPgDi/F0qTznt4jwhBCY3AfHSXpG5DZtCW6uWuoOEl4kd6ym1UbbBTtgFBz9K+LTg==
X-Received: by 2002:a5d:42cf:: with SMTP id t15mr26270515wrr.354.1587984227110;
        Mon, 27 Apr 2020 03:43:47 -0700 (PDT)
Received: from AnsuelXPS ([79.37.253.240])
        by smtp.gmail.com with ESMTPSA id g186sm15672947wme.7.2020.04.27.03.43.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 03:43:46 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Viresh Kumar'" <viresh.kumar@linaro.org>
Cc:     "'Rob Herring'" <robh+dt@kernel.org>,
        "'Viresh Kumar'" <vireshk@kernel.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Ilia Lin'" <ilia.lin@kernel.org>, "'Nishanth Menon'" <nm@ti.com>,
        "'Stephen Boyd'" <sboyd@kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Sricharan R'" <sricharan@codeaurora.org>,
        "'linux-arm-msm'" <linux-arm-msm@vger.kernel.org>,
        "'open list:THERMAL'" <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200422201216.10593-1-ansuelsmth@gmail.com> <20200422201216.10593-2-ansuelsmth@gmail.com> <CAL_JsqLUbM7ed2q7so4Uibiz2URRg1juoGRExy9Ta3J-LWAFow@mail.gmail.com> <087301d61a86$68b6f950$3a24ebf0$@gmail.com> <20200427034951.xrk5ja3pg4anbg4s@vireshk-i7>
In-Reply-To: <20200427034951.xrk5ja3pg4anbg4s@vireshk-i7>
Subject: R: R: [PATCH v2 2/2] dt-bindings: opp: Fix wrong binding in qcom-nvmem-cpufreq
Date:   Mon, 27 Apr 2020 12:43:43 +0200
Message-ID: <016c01d61c80$ba1358b0$2e3a0a10$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQI2zLF6jE7E+qUxZ1JX975++E9sxAFV8SPrAaqC6P0CXGiiOwGPGxidp5QHXxA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> On 25-04-20, 00:19, ansuelsmth@gmail.com wrote:
> > > On Wed, Apr 22, 2020 at 3:12 PM Ansuel Smith
> <ansuelsmth@gmail.com>
> > > wrote:
> > > >
> > > > Update binding to new generic name "operating-points-v2-qcom-cpu"
> > > >
> > > > Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based
> socs")
> > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt |
> 2
> > > +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-
> > > cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-
> > > cpufreq.txt
> > > > index 64f07417ecfb..537e1774f589 100644
> > > > --- a/Documentation/devicetree/bindings/opp/qcom-nvmem-
> cpufreq.txt
> > > > +++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-
> > > cpufreq.txt
> > > > @@ -19,7 +19,7 @@ In 'cpu' nodes:
> > > >
> > > >  In 'operating-points-v2' table:
> > > >  - compatible: Should be
> > > > -       - 'operating-points-v2-kryo-cpu' for apq8096, msm8996,
> msm8974,
> > > > +       - 'operating-points-v2-qcom-cpu' for apq8096, msm8996,
> > > msm8974,
> > > >                                              apq8064, ipq8064,
msm8960 and ipq8074.
> > >
> > > This is not how you fix the backwards compatibility issue pointed out
> > > on the Fixes reference.
> > >
> > > Rob
> >
> > Sorry but can you give some directive? Should I use the old binding and
> change
> > the driver to use it instead of the new one (and drop it) ?
> 
> It is not about the name of the binding, you can rename it to whatever
> you want. The kernel needs to keep supporting all the previous
> bindings, so we can keep on changing the kernel but keep the same
> bootloader (with earlier bindings).
> 
> --
> viresh

Ok but still I can't understand why this is not right. 
In 1/2 of this patchset I added the check for the old binding in the driver
and 
here I updated the Documentation with the new one. This way the kernel 
should support all the previous bindings and I can use the new better name.


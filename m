Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDB01B81F6
	for <lists+linux-pm@lfdr.de>; Sat, 25 Apr 2020 00:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDXWT1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 18:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgDXWT1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 18:19:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9072AC09B049;
        Fri, 24 Apr 2020 15:19:26 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b11so13051638wrs.6;
        Fri, 24 Apr 2020 15:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=uQciE9sQ/Xrr7n64LqH8na5zfuBXDWo71KYedRmAEk8=;
        b=dyPDkFe9ZU8B+NLEmufBeGry2o41FWw0H0PHcHXjrjQdtWr66PP3j2ObuEXeWOYS8e
         q3DeADsJy0wLp4mvx4kZgYIZPIC+mpoZPhnOaJMuiYLA939taTbqQ+sC+yLYvzNTCRF4
         CwWBbN2w/4sPvRLFBKIxTEDhcq5CWfcp1JkXPwgjIwRW0dJlI6aR7Y0J/bqE5EdHujwD
         c1KqCe4GSoQAIFZirCLLN9H5q1VHflfUJYJq5r6hL5WdCDS668YpYV+b43yHprd0YoOO
         7CzjOx+Czkhaag5s6T4rZGTyNaGEFeBSySQub1SVAr1QnbFlJ54nWbcuT3rFDR0jK7l3
         NhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=uQciE9sQ/Xrr7n64LqH8na5zfuBXDWo71KYedRmAEk8=;
        b=F8jCzIIMtQRFHOXu7G33TpRzSI3CQdrslCgxUZVBE7ead39bQzERpZxiZCye/7isS3
         29C3ECcmxKg6uA/xCg1tL/lLCzJUNY0iBRTxKsx0/LfruPPMsf097N2fboAtVZUxmTBt
         Mc2kN9CT5gNa87YSB7aBNJMtKUTk9ZgfzE6lmDBTUwy2FfUOygYCtRRmYV1E/QqP3ALu
         LGExi+jAczFIrb1c8zgVv+Czg/FOZ8C+f5PO/9JSxZZmg/4RijjO7dfMYXx32xR3WDOI
         G4JbtftBmroc2zWFHvFR0sMXBiJo+nqehLhL+KQ0/elljGNfzgDEIOg6QfVgC/uCgb+7
         hAQA==
X-Gm-Message-State: AGi0PuYwoSBawRooZcbin8OAOelY/Ra5Tx7uOjuTsCrhIFPc6Q8WJLNS
        aBArnGhugaiucFylAysH/bk=
X-Google-Smtp-Source: APiQypJ7RnkY5hVI/pUo/8qEEJt8iQdG2jA0iTtsu6TvcVs3fn1IG692Es/BXiQsf87tu3tpxI/lmA==
X-Received: by 2002:adf:9d85:: with SMTP id p5mr14130705wre.101.1587766765002;
        Fri, 24 Apr 2020 15:19:25 -0700 (PDT)
Received: from AnsuelXPS (host36-18-dynamic.45-213-r.retail.telecomitalia.it. [213.45.18.36])
        by smtp.gmail.com with ESMTPSA id 5sm4526484wmg.34.2020.04.24.15.19.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 15:19:24 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Rob Herring'" <robh+dt@kernel.org>
Cc:     "'Viresh Kumar'" <vireshk@kernel.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Ilia Lin'" <ilia.lin@kernel.org>, "'Nishanth Menon'" <nm@ti.com>,
        "'Stephen Boyd'" <sboyd@kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Sricharan R'" <sricharan@codeaurora.org>,
        "'linux-arm-msm'" <linux-arm-msm@vger.kernel.org>,
        "'open list:THERMAL'" <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200422201216.10593-1-ansuelsmth@gmail.com> <20200422201216.10593-2-ansuelsmth@gmail.com> <CAL_JsqLUbM7ed2q7so4Uibiz2URRg1juoGRExy9Ta3J-LWAFow@mail.gmail.com>
In-Reply-To: <CAL_JsqLUbM7ed2q7so4Uibiz2URRg1juoGRExy9Ta3J-LWAFow@mail.gmail.com>
Subject: R: [PATCH v2 2/2] dt-bindings: opp: Fix wrong binding in qcom-nvmem-cpufreq
Date:   Sat, 25 Apr 2020 00:19:21 +0200
Message-ID: <087301d61a86$68b6f950$3a24ebf0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQI2zLF6jE7E+qUxZ1JX975++E9sxAFV8SPrAaqC6P2nr28mgA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> On Wed, Apr 22, 2020 at 3:12 PM Ansuel Smith <ansuelsmth@gmail.com>
> wrote:
> >
> > Update binding to new generic name "operating-points-v2-qcom-cpu"
> >
> > Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based =
socs")
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt | 2
> +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-
> cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-
> cpufreq.txt
> > index 64f07417ecfb..537e1774f589 100644
> > --- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> > +++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-
> cpufreq.txt
> > @@ -19,7 +19,7 @@ In 'cpu' nodes:
> >
> >  In 'operating-points-v2' table:
> >  - compatible: Should be
> > -       - 'operating-points-v2-kryo-cpu' for apq8096, msm8996, =
msm8974,
> > +       - 'operating-points-v2-qcom-cpu' for apq8096, msm8996,
> msm8974,
> >                                              apq8064, ipq8064, =
msm8960 and ipq8074.
>=20
> This is not how you fix the backwards compatibility issue pointed out
> on the Fixes reference.
>=20
> Rob

Sorry but can you give some directive? Should I use the old binding and =
change
the driver to use it instead of the new one (and drop it) ?


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD631A1DE1
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2019 16:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfH2OxF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Aug 2019 10:53:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33920 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfH2OxF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Aug 2019 10:53:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id d3so1706842plr.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2019 07:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=IVt1U8oT+FQK7aUwrMR2Tp9XbQQNNH4JQiQH6Rt7qf4=;
        b=cP79UUZk928DGL+GxphxoDqthoR4vlD+VEpiHJe8dJnI74dSK5hHZDn/8xoNtlwaLH
         IkL9g+CPoO3ERIm4twApQ3fSHH+/cFNlISlAnPCINnupwLmEXMmKVkw35ldVMfLUUOXK
         yToPL4+v5EmLSwhPC+E3qcL0teiSDB+eD/bXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=IVt1U8oT+FQK7aUwrMR2Tp9XbQQNNH4JQiQH6Rt7qf4=;
        b=Z6mq/VUlfUTszIRCwVg5s/qpvt889zTM+tzQh6teqMf+/DOrM/+4aeTSdllS53lMUg
         mtVFAU4S241jwfHIrB+6rKfDqCkH4l3Tl2gmVpdMDaH4nrvSbHj9i5rx8etedvkQQ3hM
         hLqSKtoqkKhYXLnYd+by6U9LE6HrCioFmJtx2odm5Uo309H5ifQLlAYF/N9XVFH0ciwc
         KAvgEDOAWTzqPV71nvR5V2owaHESLu1YAU/9Iw7n7rzSgjBJuY1y8pia6Mu3duEE5Agh
         fKxGlpBmDQZ3bC5hpRO9g+j2pEq5PVrz2SuL6zbi8HWKB9b4M6BPdrEzVZYRwAuax5xk
         DCnQ==
X-Gm-Message-State: APjAAAXJzVFJXuNhI6iOCLtkDOEubzbY/LIG9gFbFbaVkoFw9UQti4+g
        Xyokpk7ttKweeRPZYHTkPLay0A==
X-Google-Smtp-Source: APXvYqxCLdj3EhSbQwuRFHN9HLXmn0KH0bqkF8GZwr3xBMF5lOEAwyd/+Ll4gbD0AERbHDMcrTdDfg==
X-Received: by 2002:a17:902:f217:: with SMTP id gn23mr10280979plb.21.1567090384357;
        Thu, 29 Aug 2019 07:53:04 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id ev3sm16476457pjb.3.2019.08.29.07.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 07:53:03 -0700 (PDT)
Message-ID: <5d67e6cf.1c69fb81.5aec9.3b71@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP245DWWKsZBHnvSqC40XOH48kGd-hykd+fr-UZfWTmvuG2KaA@mail.gmail.com>
References: <cover.1566907161.git.amit.kucheria@linaro.org> <66ac3d3707d6296ef85bf1fa321f7f1ee0c02131.1566907161.git.amit.kucheria@linaro.org> <5d65cbe9.1c69fb81.1ceb.2374@mx.google.com> <CAP245DWWKsZBHnvSqC40XOH48kGd-hykd+fr-UZfWTmvuG2KaA@mail.gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Brian Masney <masneyb@onstation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 07/15] dt: thermal: tsens: Document interrupt support in tsens driver
To:     Amit Kucheria <amit.kucheria@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 29 Aug 2019 07:53:02 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2019-08-29 01:48:27)
> On Wed, Aug 28, 2019 at 6:03 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Amit Kucheria (2019-08-27 05:14:03)
> > > Define two new required properties to define interrupts and
> > > interrupt-names for tsens.
> > >
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt=
 b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > > index 673cc1831ee9d..686bede72f846 100644
> > > --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > > @@ -22,6 +22,8 @@ Required properties:
> > >
> > >  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a descr=
iption.
> > >  - #qcom,sensors: Number of sensors in tsens block
> > > +- interrupts: Interrupts generated from Always-On subsystem (AOSS)
> >
> > Is it always one? interrupt-names makes it sound like it.
> >
> > > +- interrupt-names: Must be one of the following: "uplow", "critical"
>=20
> Will fix to "one or more of the following"
>=20

Can we get a known quantity of interrupts for a particular compatible
string instead? Let's be as specific as possible. The index matters too,
so please list them in the order that is desired.


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF72130AAB
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 00:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgAEXH0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 18:07:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgAEXH0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 5 Jan 2020 18:07:26 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E0E024650;
        Sun,  5 Jan 2020 23:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578265645;
        bh=NIcC9yFq1/Q2UYS/x0ix+xDhGk3NlKlVY0V2e+tLt84=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mTuzOEG1v2XD5AOW+hjT5FuSDWWwZlUxoAVTusAUrGOF7s1qGcROgx9zS5N5h7+V9
         RNX9M4Hxyr4pZdrnetQw3m5DS4M6YygWax278j5/2doAcjmPs57vZvumAqpv4Ht0mG
         qmL5REZHAPGbWwpSAK0Wl9Au+ymmkEOnm0mLYV/c=
Received: by mail-qt1-f171.google.com with SMTP id d18so38484298qtj.10;
        Sun, 05 Jan 2020 15:07:25 -0800 (PST)
X-Gm-Message-State: APjAAAV1AJLzQMpJTXAg4nLA0LUipj+W+kIF+pilK+evGMbVzZib922W
        IkXg+A9dqBeSzia3z6vfgBaYGjiKzY3/ZBzyzg==
X-Google-Smtp-Source: APXvYqzdbTAKT6nfHNwFQzuY7xtfF7ulpPWWAYYDIujT3O2LaFFOnWL38RxCqg7Xtw+EYlScp1qm1OFzBcyrooIJl1g=
X-Received: by 2002:ac8:1415:: with SMTP id k21mr58902700qtj.300.1578265644230;
 Sun, 05 Jan 2020 15:07:24 -0800 (PST)
MIME-Version: 1.0
References: <1577782737-32068-1-git-send-email-okukatla@codeaurora.org>
 <1577782737-32068-2-git-send-email-okukatla@codeaurora.org>
 <20200104220142.GA28701@bogus> <20200104230830.GA27471@darkstar.musicnaut.iki.fi>
In-Reply-To: <20200104230830.GA27471@darkstar.musicnaut.iki.fi>
From:   Rob Herring <robh@kernel.org>
Date:   Sun, 5 Jan 2020 16:07:13 -0700
X-Gmail-Original-Message-ID: <CAL_JsqLExx1puQxWjT2CpiwttOZtaDay6yU=jwF1D2SGbzB4tg@mail.gmail.com>
Message-ID: <CAL_JsqLExx1puQxWjT2CpiwttOZtaDay6yU=jwF1D2SGbzB4tg@mail.gmail.com>
Subject: Re: [V2, 1/3] dt-bindings: interconnect: Add Qualcomm SC7180 DT bindings
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Odelu Kukatla <okukatla@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        Alex Elder <elder@linaro.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jan 4, 2020 at 4:09 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> Hi,
>
> On Sat, Jan 04, 2020 at 03:01:42PM -0700, Rob Herring wrote:
> > On Tue, Dec 31, 2019 at 02:28:55PM +0530, Odelu Kukatla wrote:
> > > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
> > > new file mode 100644
> > > index 0000000..487da5e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
> > > @@ -0,0 +1,155 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> >
> > Dual license new bindings:
> >
> > (GPL-2.0-only OR BSD-2-Clause)
>
> Just curious, is that mandatory for any new bindings?

Yes.

Rob

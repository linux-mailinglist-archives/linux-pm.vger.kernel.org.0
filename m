Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5BE99AF91
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 14:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389554AbfHWMfE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 08:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbfHWMfD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Aug 2019 08:35:03 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A833F21897;
        Fri, 23 Aug 2019 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566563702;
        bh=Z2I05m7SXtNJwNTlvQI5ywWzhVmXjRiklq17kPfyLhk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iiGYu6l9vWLPokyrIr6cKS2LVmGDARqpT7DVl+ptulFiy7Bo2nFagy1AU+sG/NkGJ
         MXudl9uTjJUUdCpbempJOE97i8iYaE3EgslDG06rRVj4iyw2cU4U/AWXTYGGRo7XhI
         GXf63yh+QBp5/OKjN3P5BZJRtg7zqz8QYHk3zjso=
Received: by mail-qt1-f171.google.com with SMTP id t12so10980398qtp.9;
        Fri, 23 Aug 2019 05:35:02 -0700 (PDT)
X-Gm-Message-State: APjAAAXeK6FAhd53ILHsNx0WzUkwEIYnGCG7HFzJpVuDf9smTdkbVlzR
        HfaTsozVRJ2nUFulTJoSq3/gGF7CjYElOpMa+A==
X-Google-Smtp-Source: APXvYqz0mGDc1DI17v6Z0Y7CzxhC0YIe0QPDxAOoBSFtPO2ZPZcQy+RuIt+LQXO6zdeHyqe/Omq9Zvrq2O6DUFy+F+U=
X-Received: by 2002:a0c:9782:: with SMTP id l2mr3681523qvd.72.1566563701854;
 Fri, 23 Aug 2019 05:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190725104144.22924-10-niklas.cassel@linaro.org> <20190819101238.17335-1-niklas.cassel@linaro.org>
In-Reply-To: <20190819101238.17335-1-niklas.cassel@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 23 Aug 2019 07:34:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ=nH3a9Jmj_Syrg0dmx3gB9vFgbMmZ4=ew_Pcz4EDrYw@mail.gmail.com>
Message-ID: <CAL_JsqJ=nH3a9Jmj_Syrg0dmx3gB9vFgbMmZ4=ew_Pcz4EDrYw@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] dt-bindings: opp: Add qcom-opp bindings with
 properties needed for CPR
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 19, 2019 at 5:12 AM Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> Add qcom-opp bindings with properties needed for Core Power Reduction
> (CPR).
>
> CPR is included in a great variety of Qualcomm SoCs, e.g. msm8916 and
> msm8996. CPR was first introduced in msm8974.
>
> Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
> Changes since V2:
> qcom,opp-fuse-level is really a required property and not an optional
> property, so properly define it as such.
>
>  .../devicetree/bindings/opp/qcom-opp.txt      | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt

Reviewed-by: Rob Herring <robh@kernel.org>

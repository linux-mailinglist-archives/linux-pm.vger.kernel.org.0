Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD6A686A2D
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 16:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBAPYN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 10:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjBAPYB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 10:24:01 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E739B73756
        for <linux-pm@vger.kernel.org>; Wed,  1 Feb 2023 07:23:36 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id h24so29796512lfv.6
        for <linux-pm@vger.kernel.org>; Wed, 01 Feb 2023 07:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoSqvQg1GJaKeyTfybVMaXngI5eDO0jVwAafYr5hVKU=;
        b=szZvNlMUdkP3w6JCsAuE79LB9wtOWg1++ZCq9iPKy7zka1EVmjEW3qqucNVH4T0hIZ
         P/iuNKWCU4tA9zIB++SviZhwWj707/txtO6ZnAZRKEcb2uB/mn6faxssRINs1Y3Zew7Q
         mPzQ7bPomVia69ZW5GlWu7yNk3/CyJ7d/EiySErugA+xYkHJHANOfoSKMqOFvZVP+Scx
         AUV1LcrKq1nQzs5lw2wavLulYJBvMqr0vzc/+MAl3JS/CUmN/GDbwfC6g8pJlJFUOv8k
         FGjixJ6rMQQ1i1Pw8brm6e+MrdaEfgdeqRE179snCFcC2+PiEhDWBo7+7rO7M9AYf4aN
         DvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoSqvQg1GJaKeyTfybVMaXngI5eDO0jVwAafYr5hVKU=;
        b=SvHQ9B7ibPvcJMZqvvF9mzsZNFUxhDR3Sc3DABR/Y6e1qQ5QxHBHfWpLRQ4T37Yf7v
         5RBMZ+XQViYbscXqOkzovhgTdaWsOgsK/jTDV2XqT4yZOu1ZaJQ7dEyGfigSFpq0z6WB
         NjH3GvCHtmewCL3DWHuWqA7NYVJ3G0HNhgAsGl/NRohMxfSXG09V3I1MUo5G47B2FM9k
         9LkBUWkQyYoa38cnbqCiOtfiek0U9houmabDtkQuNUCYnBmdUTSTiwrBHv6D8calmfsn
         h9JY7AYnbXcAF1zskoep3QACx3f42j+PxhEzi/C4wvo23sqdeIomg2uFk3kSw/shG2AD
         6Uvw==
X-Gm-Message-State: AO0yUKUgZhF4ZYo8qc+YiIuNKa6VIeAZgrTC3w6BC0L62pQABWaORPO/
        csI0N1QNXzAi8LsR/NTX47GSTmTTUmYcpfo7o9lbrA==
X-Google-Smtp-Source: AK7set8lD9RYwj5y3uPcFqci2GlPGZco2Qa5+WkHYRX4QzH3uKwz4E7Ay87dbJ4C6gpk1uhkVlIojtB/fQ/EflImrb4=
X-Received: by 2002:a05:6512:ba3:b0:4ca:f5a1:8898 with SMTP id
 b35-20020a0565120ba300b004caf5a18898mr331079lfv.29.1675265015202; Wed, 01 Feb
 2023 07:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20230201080227.473547-1-jun.nie@linaro.org> <20230201080227.473547-2-jun.nie@linaro.org>
 <515f4e9e-2804-e03a-26f5-f2d3ac331109@linaro.org>
In-Reply-To: <515f4e9e-2804-e03a-26f5-f2d3ac331109@linaro.org>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Wed, 1 Feb 2023 23:23:31 +0800
Message-ID: <CABymUCPiOFH_FM45bYt=zgFSP37xtVkLUW_mtAOp9SbdT05itA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / devfreq: qcom: Introduce CCI devfreq driver
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, bryan.odonoghue@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2023=E5=B9=B42=E6=
=9C=881=E6=97=A5=E5=91=A8=E4=B8=89 19:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On 01/02/2023 10:02, Jun Nie wrote:
> > Cache Coherent Interconnect (CCI) is used by some Qualcomm SoCs. This
> > driver is introduced so that its freqency can be adjusted. And regulato=
r
> > associated with opp table can be also adjusted accordingly which is
> > shared with cpu cluster.
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >   drivers/devfreq/Kconfig    |   9 +++
> >   drivers/devfreq/Makefile   |   1 +
> >   drivers/devfreq/qcom-cci.c | 162 ++++++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 172 insertions(+)
> >   create mode 100644 drivers/devfreq/qcom-cci.c
>
> Could you please describe in some additional details what are you trying
> to achieve? Should the CCI frequency be scaled manually or does it
> follow the cluster frequency? Do clusters vote on the CCI frequency?
>
> I'm inclined to ask if it is possible to shift this to the cpufreq OPP
> tables?
>
> --
> With best wishes
> Dmitry
>

The plan is to add CCI opp node as required-opp property in CPU opp, so tha=
t
CPU will vote CCI frequency when scaling CPU frequency.
The interconnect bandwidth side is not addressed yet. This patch only addre=
ss
CCI frequency and power voltage requirement with help of device tree.

- Jun

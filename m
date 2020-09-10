Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DDA263C8A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 07:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgIJFj5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 01:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIJFjw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 01:39:52 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D65C061573
        for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2020 22:39:51 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u21so6874625eja.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2020 22:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HrzEcI7tVL3wJrzvYvYurbe8HlqDLa+gfYaACY1yWxY=;
        b=bhCEnoHBe/islh9rGTTbTL9UmGoYOX4YjQy+u4S0jDc8tvCfCZPuq12wlUqD5DxX/A
         DVnQJSPh2rAIyK8r7nP1pvhDYZig3rqXa6aKOC9LHZDmXyVwSlXVY4a4pemvyKBDmlBz
         9LNR4dms2EHba6bPiwZ8UZW80oZDPrSDvgJRbjMRc3MP7JdrV7d92Iq4K5xEtJnk/nSx
         gXiEYLxcetotOAqQ9/2GtgrzIk09vMoWI+otVEmVEbCkQv8rYfDsboeSLoQ/1J9KYzOs
         LnKQQbE6s4k/N+6Wsel0rOYwTMYe3oAR4HdKGcFK02713bMTig6pBweNolDnQXB4S2YW
         aUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HrzEcI7tVL3wJrzvYvYurbe8HlqDLa+gfYaACY1yWxY=;
        b=eNOg7WX5/jyeaZ/vhkMxDhKoA4h0MMN0Ch+VEGAIL4JEKfCRaBTHg6P6Q+uteuPsqL
         eo3w0a9oO1RxPsj1u2K4X60oLAPPuyG5tq5PQdxYfyes1FTVBfnoDaQ535fMll+HV1dk
         hiSpR/3Vc7PFpAbZrhSGdP23FGhsn3QP3Un07GQeX+IvdAVFtyvT1sCqbW9WGv73KU5b
         0fS6fC393DabKWp9woPj8XrbOZV6ro60Nx0iJX99jzgCFVtAjEtUeFkf7hHgjjwt+aDf
         NT43LB1rxL8vyIOJF91g9V7Xbwgl/l4WthxnpNgbYywX3R2tP8sj4fynSNmWC/Q/Zsjk
         kAcA==
X-Gm-Message-State: AOAM533XcobFOOsIOjYhsg69TVej6TQ8yj2jMjiYDgEd057qowq6N9Yk
        w96RCGe8aIXfm6DelSZhJhdgxp0DhDH5THe4pGAVbA==
X-Google-Smtp-Source: ABdhPJxaieYVeSjCBFkQtp2/sEBfRSTYV5HJdwYX2Xm+2e2ACp56jmmfW9CNhScSeMYqLdBI/Z1zZ3kqVq7p6bXYPqA=
X-Received: by 2002:a17:906:eced:: with SMTP id qt13mr6926424ejb.357.1599716390242;
 Wed, 09 Sep 2020 22:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200831075329.30374-1-jun.nie@linaro.org> <20200831075329.30374-2-jun.nie@linaro.org>
 <0df97fbd-f0f5-3719-cebc-1d7525a43e60@linaro.org>
In-Reply-To: <0df97fbd-f0f5-3719-cebc-1d7525a43e60@linaro.org>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Thu, 10 Sep 2020 13:39:39 +0800
Message-ID: <CABymUCMHKXMExUUT3f=Loov=CVWSrJV0RoU8xfECgnKA6fUXvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] interconnect: qcom: Add MSM8939 interconnect provider driver
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Georgi Djakov <georgi.djakov@linaro.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=889:58=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hi Jun,
>
> Thanks for working on this!
>
> On 8/31/20 10:53, Jun Nie wrote:
> > Add driver for the Qualcomm interconnect buses found in MSM8939 based
> > platforms. The topology consists of four NoCs that are controlled by
> > a remote processor that collects the aggregated bandwidth for each
> > master-slave pairs.
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  drivers/interconnect/qcom/Kconfig   |   9 +
> >  drivers/interconnect/qcom/Makefile  |   2 +
> >  drivers/interconnect/qcom/msm8939.c | 576 ++++++++++++++++++++++++++++
>
> All this looks almost the same as msm8916. Do you think we can we move th=
e
> identical code into common file and leave just the topology and the msm89=
39-
> specific stuff in msm8939.c?
>
> Thanks,
> Georgi

Yes, good suggestion! I will work on this later.

Jun

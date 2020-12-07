Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69BB2D08D2
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 02:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgLGBVK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Dec 2020 20:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgLGBVK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Dec 2020 20:21:10 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58A2C0613D3
        for <linux-pm@vger.kernel.org>; Sun,  6 Dec 2020 17:20:23 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id cm17so11982645edb.4
        for <linux-pm@vger.kernel.org>; Sun, 06 Dec 2020 17:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bSpze0Ktx1a78HhY8N3JUw4+cmElw0CnjsvykxTs3x0=;
        b=iGKrqSZX3YAWdjC/ijOceS289SqjnC7RjMIpww70orwiNX3bdmHHiOwsx6de1viBoa
         NyKzhTyb8lHRisvObhjgqnGJqazeTpH52EWtk262VV5dk1vugJXeelcYLUlXJ1l3fxAr
         88FTIOV334hX/Z/9Xq9GzdhQXFvsCfM8C1o8tl/acgcdj0TM4IsRFe7Ay79uTgbY5SxS
         4utTXfsF2rczDIooGdCWppIudduMvgEir/1+3XRCaNAwJYs7aZCY44TG/EBaP1qmJzd+
         kZa3oFvQX8vhhxPt7hKBSh4xgi/jXdnMFmLxjqkfkS+5+GfBc2tzw0o5eC8y+K/vDKN6
         uM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bSpze0Ktx1a78HhY8N3JUw4+cmElw0CnjsvykxTs3x0=;
        b=cilGuumKNyDWIKyYMmR06bufW/oA8sME+66bn+UOTStCRn3+w4N/ARnv/yObuwgbHl
         0Ih5q1HzMtQ70aGHxAWFrO6IOHUy5k5UVTU3XvZMTIe/DMjjwomrZEOK65YsBDk4nPYf
         oQKMynIyU097Fy8alAi1QZJkTongjBf3lQdGHI5WOPwTHnuU15yPlu7/s50NM2utlcG5
         qXivOy9PtnkrQBbwN3aJAxAYlyn6dqKNi/OmkCuXUiL2ruKd4xuKVs/h98Fn6zzg6ZoX
         lvicwXAx1NbeJ4Ze62U2zpNi2KOFJ1gsx+dEM8xW65YFb8Sfp2sP+i417ktPl1jMCgkY
         V2MQ==
X-Gm-Message-State: AOAM532Q6g0/f8Z46dQkTdBWUnC3XWMqzzQ1hGt+C1szvOwK5D4OYKAz
        zZ5ZwtVGmaWo6WlIx+iONxeKPwpktry1RsaHjWyy6w==
X-Google-Smtp-Source: ABdhPJzobOYaAtrz0mVYekXANYxF4WBTuwyn5F+FgBpi+a+Bzggk4+NE2lxXKPn9ry9YRiXfW0QavF3RQSOdrXNudxE=
X-Received: by 2002:aa7:c652:: with SMTP id z18mr17190457edr.60.1607304022539;
 Sun, 06 Dec 2020 17:20:22 -0800 (PST)
MIME-Version: 1.0
References: <20201204075345.5161-1-jun.nie@linaro.org> <20201204075345.5161-2-jun.nie@linaro.org>
 <022b3f66-ae19-79f5-c59b-0cc703a29f15@somainline.org>
In-Reply-To: <022b3f66-ae19-79f5-c59b-0cc703a29f15@somainline.org>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Mon, 7 Dec 2020 09:20:11 +0800
Message-ID: <CABymUCOOMdR6EJyc96pVsxKF_hwf96-09NkvW8ftec9Ez63tRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] interconnect: qcom: Consolidate interconnect RPM support
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     devicetree@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        agross@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Shawn Guo <shawn.guo@linaro.org>, martin.botka@somainline.org,
        marijn.suijten@somainline.org, konrad.dybcio@somainline.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
=E4=BA=8E2020=E5=B9=B412=E6=9C=885=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=
=8D=882:04=E5=86=99=E9=81=93=EF=BC=9A
>
> Il 04/12/20 08:53, Jun Nie ha scritto:
> > Add RPM based interconnect driver implements the set and aggregate
> > functionalities that translates bandwidth requests into RPM messages.
> > These modules provide a common set of functionalities for all
> > Qualcomm RPM based interconnect providers and should help reduce code
> > duplication when adding new providers.
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Hello!
> I agree, the RPM based ICC should be commonized... in any case, I think
> that you should rebase your patch series over mine, where I am adding
> support for SDM660 and also introducing a mechanism to set QoS, which
> can actually be used by most platforms managing the ICC over RPM.
>
> Please, check it out: https://lore.kernel.org/patchwork/patch/1322131/
>
> Thanks,
> Angelo
>

Angelo,

Thanks for your contribution! It looks like a great new feature. But
they are not
ready for other qnoc icc drivers yet. It should not be included in
this commonization
patch set until someone add and test the feature for all qnoc drivers.

Regards,
Jun

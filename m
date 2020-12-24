Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44F02E27B8
	for <lists+linux-pm@lfdr.de>; Thu, 24 Dec 2020 15:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgLXOeb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Dec 2020 09:34:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbgLXOeb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Dec 2020 09:34:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38D83224B1;
        Thu, 24 Dec 2020 14:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608820430;
        bh=fkm1MmkKVX0X8W8b9MoXrIOtavhuaZcXNGosYz3rTuA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WTk8azkMFZpXRQN34mLBrDGokITdgvr3x5pIpTmC89MKcq1Ig7yCh5NY6qXeWj5Iw
         0Tjm0VXDw/eW6Fquc5EvegqBFjgBQhUDcttIno3+VN2eVTdBLbdce5BgY7VA7/zPqz
         u/Ta5wFmVYF063tmzS4MKBlcnaCzLjW+0hFepdiWBjCi8plEukNEWHhaYMaKZtGszF
         1AAsUKzVkRvaE0MmY4ZondREeqLOLJTp35yfW3u8e8z7R6XrpZuIvpSlyXOkx4Cx2e
         gLTSrxAUJSLbtM41Pjswb5U0K3IvSMHktIYdcTUltBGDWYE+ornsXXkLH5UYqOGvcm
         9XPXAa7EaqnjA==
Received: by mail-ej1-f52.google.com with SMTP id j22so3490961eja.13;
        Thu, 24 Dec 2020 06:33:50 -0800 (PST)
X-Gm-Message-State: AOAM531B58LKRnWbjSXz9CJn2J8HQLvo117c1fTRT/mHKk6kZqjKVjus
        ZGI3EBWzC1JwGmFhHrzgyQK8w8tLvufDDlpCUg==
X-Google-Smtp-Source: ABdhPJyYMY6zOIEeWk9zf3J20HOhFmag+QSOsC7kafdQzV1MNxjeoMc++rF1OktDc7lq7tS6cKOABNFFuW9Djjb8mf8=
X-Received: by 2002:a17:906:ae4e:: with SMTP id lf14mr29216615ejb.310.1608820428887;
 Thu, 24 Dec 2020 06:33:48 -0800 (PST)
MIME-Version: 1.0
References: <1608790134-27425-1-git-send-email-henryc.chen@mediatek.com> <1608790134-27425-4-git-send-email-henryc.chen@mediatek.com>
In-Reply-To: <1608790134-27425-4-git-send-email-henryc.chen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 24 Dec 2020 22:33:35 +0800
X-Gmail-Original-Message-ID: <CAAOTY__whne=DuaSv4rOv8f1qTebjqDOVjD5YGYw6eBkkWKmUw@mail.gmail.com>
Message-ID: <CAAOTY__whne=DuaSv4rOv8f1qTebjqDOVjD5YGYw6eBkkWKmUw@mail.gmail.com>
Subject: Re: [PATCH V6 03/13] soc: mediatek: add driver for dvfsrc support
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        DTML <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Henry:

Henry Chen <henryc.chen@mediatek.com> =E6=96=BC 2020=E5=B9=B412=E6=9C=8824=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:09=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Add dvfsrc driver for MT6873/MT8183/MT8192

Separate this patch for each SoC.

Regards,
Chun-Kuang.

>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig            |  12 +
>  drivers/soc/mediatek/Makefile           |   1 +
>  drivers/soc/mediatek/mtk-dvfsrc.c       | 538 ++++++++++++++++++++++++++=
++++++
>  include/linux/soc/mediatek/mtk_dvfsrc.h |  35 +++
>  4 files changed, 586 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
>  create mode 100644 include/linux/soc/mediatek/mtk_dvfsrc.h
>

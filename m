Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD65C2C86C8
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 15:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgK3OaN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 09:30:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgK3OaM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Nov 2020 09:30:12 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D1D220705;
        Mon, 30 Nov 2020 14:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606746571;
        bh=tz2tXXUVHDW/oupIcXQuwy8LaThl9KQ3jngCWB/BhoU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rW4tNdAA4d+ZcXaEBOgTrjG0Oiu0DNqTcoynBx8N2qopqtxoJgBf4puiuVKXcI+zf
         boOUk8mZaZVbwcthyPxCWOGX2MrxXYkwPWoYJa+S422R3GbYX+iCnCuPACGOIJc6aQ
         6sNzvJ4uQVrs2O56bpfkoWakriMJE1/JTpnwv9iI=
Received: by mail-ed1-f41.google.com with SMTP id v22so16354749edt.9;
        Mon, 30 Nov 2020 06:29:31 -0800 (PST)
X-Gm-Message-State: AOAM531wwTIy7ptpl6u9zUtiIWQAGEep6eM4+YQBzqnOn9Ay4Gi9Jjts
        EtXujp9yeUPX0KFcMAhDJfE3owJR1ml7xisGTQ==
X-Google-Smtp-Source: ABdhPJzeZ7cLk6PTmuaNZlIGi5vs6mibhKrj34FUCKMCv4s2hT6KQ3KjwX7ZdxA79u9HJ+DAh9LGDxfdM+WBXDmuXqk=
X-Received: by 2002:a50:f404:: with SMTP id r4mr6920719edm.62.1606746569792;
 Mon, 30 Nov 2020 06:29:29 -0800 (PST)
MIME-Version: 1.0
References: <20201017133718.31327-1-kholk11@gmail.com> <20201017133718.31327-2-kholk11@gmail.com>
 <20201019195807.GA3508546@bogus> <CADQ2G_HZ9nt88vW9MNiC-+Rdjzsu-hSHoqmqLC75vyiG2JKpQQ@mail.gmail.com>
In-Reply-To: <CADQ2G_HZ9nt88vW9MNiC-+Rdjzsu-hSHoqmqLC75vyiG2JKpQQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Nov 2020 07:29:18 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+ZsOP1=+N0yu1Dc+2ZpkJic8XSGhTf0H8yRzYfbk1T9g@mail.gmail.com>
Message-ID: <CAL_Jsq+ZsOP1=+N0yu1Dc+2ZpkJic8XSGhTf0H8yRzYfbk1T9g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: interconnect: Add bindings for
 Qualcomm SDM660 NoC
To:     Martin Botka <martin.botka1@gmail.com>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        devicetree <devicetree@vger.kernel.org>, marijns95@gmail.com,
        Konrad Dybcio <konradybcio@gmail.com>,
        phone-devel@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 19, 2020 at 2:45 PM Martin Botka <martin.botka1@gmail.com> wrote:
>
> > Documentation/devicetree/bindings/interconnect/qcom,sdm660.example.dts:20:18: fatal error: dt-bindings/clock/qcom,mmcc-sdm660.h: No such file or directory
> >    20 |         #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
> >       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> This patch depends on my MMCC patch (sent by angelo).

Seems this landed in linux-next now and the dependency is not there.
Revert, drop, or fix the dependency please.

Rob

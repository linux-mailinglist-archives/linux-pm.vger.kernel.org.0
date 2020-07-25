Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0BF22D780
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jul 2020 14:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgGYM0Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Jul 2020 08:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgGYM0Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jul 2020 08:26:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BAAC0619D3;
        Sat, 25 Jul 2020 05:26:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n22so12568608ejy.3;
        Sat, 25 Jul 2020 05:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OlvXoJseOiADtviMtYmz+LpUgheHS7cYbg7KIZ6CD5g=;
        b=GoJZ9Rft5yjvKSiQBsRg57B6XfLaQXpyVnzSaInh4K2RZzRf/A/Eko16oEbs2DlGMn
         zyF2ob48EOuVpURx+vlmAy28jOpiihL60ZGk4PP4fVqL6AccTmOF6LQ9D2pGepFkbbTS
         WmXbtTZnuTDJjAaJYTb4eQR0uadn/nzkUeoC8kekPAFFD9hDbY+sCWFFzE5ybr89CuuH
         Vw1YIi8fuiCpVJSC+msjIroyMkGGogL4/vWtux6rOSqAaEq/7SK6ahoK8jjF7ByMC8/H
         jjy/3OP6XpYsAgb0qPOR90s7akIYf/tRr7pVgogex5BGX/t7s3GinJMGTu2miQWnrgBa
         GVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OlvXoJseOiADtviMtYmz+LpUgheHS7cYbg7KIZ6CD5g=;
        b=pLhBxGHzYbN+5xg4bFrJl88xnYOW4p3Hth0ec0v05YC3bHFeSXyjwjiZS205TdElNK
         zv9MmAsZFoWQ9yv4yvzFhf2Hgn4JVg1aZgtuLk5qp3+yDAHhsjwsPlvHcYagNtPr1k4a
         3P2GrnoJtIBJE0Zsvw/uO40RIod5jHgYorkNmDIUlT4Fy/o4QkvqY1Gm0cIlgMVA/gkE
         udsVOae3mRM9pbpOpE/dXSEM4UNsMMIx/xuoKuxZzOT31YQ0Nod2WaltN5J4KqU3ocJb
         Ai3hLlnOLEW5aM5TP7KwjqLzsLs14GGD5OCEWgekk4o8qEs/Zum+DURQbx9/bIpnZzFB
         cGgA==
X-Gm-Message-State: AOAM53059iZvb8fJOcJ4af+ipM6tFqYKsz2G4xvDoYJbvNxMUhZkZsQD
        XlDLAdIrAkvkUM6s9FMC3+oVWuPTGftlz5/P27IIuMbDrXs=
X-Google-Smtp-Source: ABdhPJwPF+mmu2BJEfqw0WhQGYgPldEc/eIRR4f02IiziyzIPm98BljtWDDFW2CcCLvpAyvkDvrsVX/LSZjaRlPDdn4=
X-Received: by 2002:a17:906:6852:: with SMTP id a18mr13051614ejs.348.1595679983738;
 Sat, 25 Jul 2020 05:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200629144926.665-1-shawn.guo@linaro.org> <6615ee72-d222-b16b-df72-0f5117c3e7f5@linaro.org>
In-Reply-To: <6615ee72-d222-b16b-df72-0f5117c3e7f5@linaro.org>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Sat, 25 Jul 2020 14:25:48 +0200
Message-ID: <CAMS8qEWNrU64p1YeS2+G=aSj27eYgvdpEGGMb9syXmKYJciUUQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add msm8939 tsens support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tested-by: Konrad Dybcio <konradybcio@gmail.com> /* on Asus Z00T smartphone */
Acked-by: Konrad Dybcio <konradybcio@gmail.com>

Sorry for being (very) late with that, but I've been doing some
630/36/60 stuff. In case anyone's interested in the progress, I'll
leave it there. [1]


[1] https://github.com/konradybcio/linux/commits/ninges_labs

Regards
Konrad

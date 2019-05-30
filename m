Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0C42F771
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2019 08:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfE3G1z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 02:27:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39690 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3G1z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2019 02:27:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id i34so5663811qta.6
        for <linux-pm@vger.kernel.org>; Wed, 29 May 2019 23:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDB9NEzcrpM7vrzDugTKwabI3NuPP3IyLOyki6rb9uw=;
        b=TeMX9NEYaD2Qb/D8oQumCOS5CTT5UUG3au1rn0yH9MGA8q2jHPcpr5bZd7JUPdwRha
         m5ZvqEa54g94x1DtzRPQXWKXAZdSvFoMgS4B1EAeBL+A2iVZ3Rdip21Yh6WWJhg1s3dc
         r2HUIPMkLO6PQjVZQzMZFNnBB2IZuUatc64XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDB9NEzcrpM7vrzDugTKwabI3NuPP3IyLOyki6rb9uw=;
        b=sk7/hNMK1u0XmT+woWk0LEeQNUJa6efWS5Y01sGD+f0twjfn9GJvCNFEC2kKN4OVVm
         b8J2LVKMe/k1Ys8mxnxSAtDyuEz7CVGluvrUpexA0OLe6vxTyl98J4USDCLvOHVdHxhD
         Z1lBIrjvOEMdKnac1YtRk5aGewZdhyZSqGnmRJckBIkolAo+b4f8dDBZQLOAeM2UMxoY
         nhfUKK7vjXLxoMvoq4hdZwNAHLk7fM8yamXSYJh+0vFNYjUvO1Nztb2FRyCh2mjCcBde
         E0ZbkiY+IPvy4ZJUQ5uahWj2ni/U4C4tEQ4myB9jtHEROGUu6VZxg71fyShVoXKz+ePJ
         zvYA==
X-Gm-Message-State: APjAAAVM1mMQgWwVpetBulu2oRhJnnOPYXwFi9iZ/SAODl1kS0aIrwLf
        ER3/sNBNlSDDtcW1BI0qYSgqqij6+k7/WfdAyxwf4A==
X-Google-Smtp-Source: APXvYqzHDlQemfhL+uQX+PxIu9PwWEguqnHq/qbjiPCrDdlMTXx+BXHgxPzV/YR2FBce1yN3dYhDwycDzH8cXlXCGsc=
X-Received: by 2002:ac8:ecc:: with SMTP id w12mr1935044qti.344.1559197674339;
 Wed, 29 May 2019 23:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <1557494826-6044-1-git-send-email-michael.kao@mediatek.com> <1557494826-6044-2-git-send-email-michael.kao@mediatek.com>
In-Reply-To: <1557494826-6044-2-git-send-email-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 30 May 2019 14:27:28 +0800
Message-ID: <CAJMQK-giJTeERnqjxoSMjF-JXxW9SPmeARWf3f9ZyRgBsYN5fg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] arm64: dts: mt8183: add thermal zone node
To:     "michael.kao" <michael.kao@mediatek.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 10, 2019 at 9:27 PM michael.kao <michael.kao@mediatek.com> wrote:

> +
> +                       tzts1: tzts1 {
> +                               polling-delay-passive = <0>;
> +                               polling-delay = <0>;
> +                               thermal-sensors = <&thermal 1>;
> +                               sustainable-power = <0>;
> +                               trips {};
> +                               cooling-maps {};
> +                       };
> +
Is 0 a valid initial sustainable-power setting? Since we'll still get
warning[1] about this, though it might not be harmful.

If 0 is a valid setting, maybe we should consider showing the warning
of not setting this property in [2]?

[1] https://elixir.bootlin.com/linux/latest/source/drivers/thermal/power_allocator.c#L570
[2] https://elixir.bootlin.com/linux/latest/source/drivers/thermal/of-thermal.c#L1049

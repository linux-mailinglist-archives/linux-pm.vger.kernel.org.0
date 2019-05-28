Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0126E2C151
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2019 10:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfE1IaE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 May 2019 04:30:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41710 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfE1IaE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2019 04:30:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id q16so8447945ljj.8
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2019 01:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PMKt4bIgN1HEm/460cE5q68gl3N0MQbJchCnVYWm094=;
        b=kYz0De76bfu7bcWNDUNk28cvkNqBj2DDfPreMRu80+wNclg/Cq4CnbrKsvlyZw+IA7
         4mkUydxfD2Un3cbAhRSfyBoX/ptzp212sf6TWmOnoVmzw5hElpJ/xwBvEz6AuMZva6NF
         xFI5jFTk006v+f8iTbqEtzZisef/yc0VzN1HDMQHuexLTVvjEvw+WSw4oaHzQ1GwXyZP
         B7leIoFy7G91aK8+WgDqlV7Ul/TMeP8u7cjIErXIS/5EvMra0CKyf4nuqkqEf7iO+3Hz
         rYh62p8UD+6LgdQSbmGTNa66vWmZV2k9oSIIxhIecks0VtafIXXxBForI3acUOhb9ZfZ
         w67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PMKt4bIgN1HEm/460cE5q68gl3N0MQbJchCnVYWm094=;
        b=l5OnsE1FFrCUohyKbXD7f6npFEwnaJtaK24vQ6hPcfZ55T76Lo0K5enuwsXcpJxHAg
         5jeJzhU8qOtkwYLDtTfVY0LTGKzxQQ38QXue+G4U8w7kvmJogTJ2k21knFc/2flJw9/l
         foVDcoY2GjeY2JqD7Emqbgh32ateJviUD2TFKbqDIBhiCKJOsW91zavS0NCe/MQOAwrh
         uEVq+6ZqDTYowLDHETNJ3CMwo4J8lOeQJ73HowYk3a3WCpOXUyK/2Mz7VUIllwSqFQkE
         f8TtgbIvtFFsG474t4wbkpLVgIv8mo5WZmaZztTCc1OsjAtlh7wC6NMrXIe7IlWwW8ks
         4zDA==
X-Gm-Message-State: APjAAAUKSaB1asmOYVx4qtUAP5GwqjPxWtMe0ub5RBZg3zczL5JC6Gy/
        vVzSXrFGQ59/zyyNdQmkqfisTc7IpP1gCXqBlNFdxw==
X-Google-Smtp-Source: APXvYqy7veIzZ/Dja/15R5nCc1PW1p8U+rNxKMDmvhoEoTgcYhlfBi3GlLvtP/VxTSoMtFsVccJq+nIFR5XuK6elTvw=
X-Received: by 2002:a2e:1284:: with SMTP id 4mr32732859ljs.138.1559032202173;
 Tue, 28 May 2019 01:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <5cec74e8.1c69fb81.37335.9d7b@mx.google.com> <0edab48f-06e5-9ed8-09be-7c9976ae1afb@collabora.com>
In-Reply-To: <0edab48f-06e5-9ed8-09be-7c9976ae1afb@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 May 2019 10:29:49 +0200
Message-ID: <CACRpkdYN8_ZGd=FiV3nwbjmPPD9x5p=wTZ4SrCj5syLjYW0Ziw@mail.gmail.com>
Subject: Re: linusw/for-next boot bisection: v5.2-rc1-8-g73a790c68d7e on rk3288-veyron-jaq
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        mgalka@collabora.com, Mark Brown <broonie@kernel.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 28, 2019 at 9:13 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:

> This commit has now been reverted in mainline.  Would it be OK
> for you to rebase your for-next branch on v5.2-rc2 or cherry-pick
> the revert to avoid recurring bisections?

Sure I can do that, it's a one-off so why not. I rebased my
devel branch on -rc2.

> Ideally this should have been fixed or reverted in mainline
> before v5.2-rc1 was released, or even earlier when this was first
> found in -next on 13th May.  Unfortunately it was overlooked and
> then spread to other branches like yours.

Usually what we would want for development trees is to ignore
any errors coming from a commit on a release candidate
branch, like -rcN, as it is not directly under our control.

Yours,
Linus Walleij

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F8A26703
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2019 17:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfEVPey (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 May 2019 11:34:54 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37835 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbfEVPex (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2019 11:34:53 -0400
Received: by mail-vk1-f195.google.com with SMTP id j124so611013vkb.4
        for <linux-pm@vger.kernel.org>; Wed, 22 May 2019 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZ7wpIvoEkeLq6FBM1KkrI1MSDApRyeyZAyhjJ4c/Jg=;
        b=O/Wfywd0s4mY7h0+2IscQOPlZ/yTMmy48pO4ogf4j4wwWqwfIC1jNvI2xbSwImPtMN
         +1GU+Col/vGn1jOmS10cSTnnu3rj94VkxQSUaB8px/4eh//rFgLYdDJUrbOsWeGFLX9X
         /6K8P0wOjwVbBd8F59mzhYJ08e+4P7/hgx8Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZ7wpIvoEkeLq6FBM1KkrI1MSDApRyeyZAyhjJ4c/Jg=;
        b=tYtdK3IYCxlpLzswr2gpK4s4SWjYwiLBPHBb22UISwmBkkBzI+6HW5i+m9uc3lVTnQ
         vLvEsOMaVRiHaGEQyZ9B8uJE+CLkX0sJIPSswH+iMVcWtsMrHU+vTsJ9sg0Z/cx8cdeQ
         cfTUyjjKLni6D1cT2fDnoEIf9is7+rIwfhGEhY+knO2HdLadsVEacVApc0UeH8KeruK2
         6rEc08CDShv9DffOabUMntOrFb3oY9/FNLI82q4VRWqBCHSh5qN4fD1tylLG+enFZrSi
         wzD71iZs84lhuq8b1GFi068ZHyjJhKLKGvQO5h4AN0AXDT7/zI/rkJQgNUT8N2HsoVDM
         YF5w==
X-Gm-Message-State: APjAAAXHUEQwFi7/4gM0Jv762S1m/FKe6cvUxQR5d4IT2EWrY7Q6pZVB
        EEA1jUdhEhQQLm2sVhRyFFAW6hDXUEA=
X-Google-Smtp-Source: APXvYqzjd8BTXjfLNXgMtlg6EvsIhBaOxOn45xZLLkw34As7HSlbeMMmt5MzJ5JWG9ySi7Rbmma28g==
X-Received: by 2002:a1f:9d07:: with SMTP id g7mr15728479vke.40.1558539291568;
        Wed, 22 May 2019 08:34:51 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id 69sm8961163uas.0.2019.05.22.08.34.47
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 08:34:48 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id l73so610553vkl.8
        for <linux-pm@vger.kernel.org>; Wed, 22 May 2019 08:34:47 -0700 (PDT)
X-Received: by 2002:a1f:1e48:: with SMTP id e69mr15455909vke.16.1558539286538;
 Wed, 22 May 2019 08:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190522141236.26987-1-heiko@sntech.de>
In-Reply-To: <20190522141236.26987-1-heiko@sntech.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 May 2019 08:34:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UxwqkHpsxXhEHrQDY6MtymeT3Gn_G4Q5xSh6pZVWTRHA@mail.gmail.com>
Message-ID: <CAD=FV=UxwqkHpsxXhEHrQDY6MtymeT3Gn_G4Q5xSh6pZVWTRHA@mail.gmail.com>
Subject: Re: [PATCH] Revert "thermal: rockchip: fix up the tsadc pinctrl
 setting error"
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        zhangqing <zhangqing@rock-chips.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, May 22, 2019 at 7:12 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> This reverts commit 28694e009e512451ead5519dd801f9869acb1f60.
>
> The commit causes multiple issues in that:
> - the added call to ->control does potentially run unclocked
>   causing a hang of the machine
> - the added pinctrl-states are undocumented in the binding
> - the added pinctrl-states are not backwards compatible, breaking
>   old devicetrees.
>
> Fixes: 28694e009e51 ("thermal: rockchip: fix up the tsadc pinctrl setting error")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/thermal/rockchip_thermal.c | 36 +++---------------------------
>  1 file changed, 3 insertions(+), 33 deletions(-)

In case it helps with the urgency, there are lots of people who have
all independently needed to identify which commit stopped their boards
from booting mainline or broke temperature reading.  I'm aware of at
least these reports:

Reported-by: kernelci.org bot <bot@kernelci.org>
Reported-by: Enric Balletbo Serra <eballetbo@gmail.com>
Reported-by: Vicente Bergas <vicencb@gmail.com>
Reported-by: Jack Mitchell <ml@embed.me.uk>
Reported-by: Douglas Anderson <dianders@chromium.org>

I can confirm that my board boots again after this revert, thus:

Tested-by: Douglas Anderson <dianders@chromium.org>

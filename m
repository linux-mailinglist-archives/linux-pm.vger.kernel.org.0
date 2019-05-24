Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B84628F13
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2019 04:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbfEXCUr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 May 2019 22:20:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42203 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387654AbfEXCUr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 May 2019 22:20:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id go2so3497344plb.9;
        Thu, 23 May 2019 19:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8i6sdY7hQZvF0VE8bmdd+Eg6UX6pwW91eLCHd9wKizE=;
        b=cOX4GWm3SirJ0mfbzCgcw3AZqCJyholEQXV89WdBtgj14h6xZwMLjcZuoFGQqzIlBc
         d7tV/mEa2ulUXk9lU9t627pEmV9b/Xj0QFNnbi7vxGBTooW8bIuHGDXcevIn+sUypy9n
         ApLEVHIocW/Vn9FhI5Jjw80Cmr3T3y+dH4turBtTPjLJ2OmZ3nno5mdLJy9F56XxMZb0
         CgWolSYYG87kk8MnQdVuxeZQmDYfsmMEdBvpDgIHVrlSAItDAyhosEqq23ag8Ql9wIn9
         aIHLZMXNHeoafO/9zUYUbXIOT1EkcamcX3Uyt7zMMrITCgTq3e3b+XGgLcjvsgKT6F1o
         D/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8i6sdY7hQZvF0VE8bmdd+Eg6UX6pwW91eLCHd9wKizE=;
        b=D/vEy50xUDKoJKxiIBxCRZQI1kSFoLCAm4cE3QpXaXk40itBZxPvTptLBQTpm1F1sY
         wSCQvTE8NVBXpCqFB1dvlLYMXas8+K/XpUvEo/i/ESuYpdqda8NWVVu+XgYNW8vuppsj
         Z1zjOU5ulr8+MI8ne+WMJHGwwPCTkUF16K0gQpOiMaUAWNaptyGvmMHw7xqA/Z98sU9l
         WMxS/Krkx/OiMdpFc6ph8lg0klLo09lQ5T1jGfQSG4VPdP22LPHZXY95jKiQlN5T2oS7
         NpSGU8OYGbpQt3OcS5hge8qYSjhUGLyZ1OTxVVIAm4MFMbEhQ9XklL4Gt92Ge+LpZX9X
         5Vpg==
X-Gm-Message-State: APjAAAVHAdYoqGBrixPGbqZYZEDHsLfkWP14gbibjuxRA2SXAeHkfKnA
        ryiFFg2IK15XG4a/2lMaOSE=
X-Google-Smtp-Source: APXvYqy8IsUKhin/UgEK4yCtU0skPkff11e+FW8nFuiATBxaJlXG+/rqhfIN5xqSVctGKNxteeaTdA==
X-Received: by 2002:a17:902:a407:: with SMTP id p7mr12856160plq.41.1558664446375;
        Thu, 23 May 2019 19:20:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id c23sm880199pfp.0.2019.05.23.19.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 19:20:45 -0700 (PDT)
Date:   Thu, 23 May 2019 19:20:43 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Doug Anderson <dianders@chromium.org>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        zhangqing <zhangqing@rock-chips.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] Revert "thermal: rockchip: fix up the tsadc pinctrl
 setting error"
Message-ID: <20190524022042.GA1936@localhost.localdomain>
References: <20190522141236.26987-1-heiko@sntech.de>
 <CAD=FV=UxwqkHpsxXhEHrQDY6MtymeT3Gn_G4Q5xSh6pZVWTRHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UxwqkHpsxXhEHrQDY6MtymeT3Gn_G4Q5xSh6pZVWTRHA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 22, 2019 at 08:34:34AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 22, 2019 at 7:12 AM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > This reverts commit 28694e009e512451ead5519dd801f9869acb1f60.
> >
> > The commit causes multiple issues in that:
> > - the added call to ->control does potentially run unclocked
> >   causing a hang of the machine
> > - the added pinctrl-states are undocumented in the binding
> > - the added pinctrl-states are not backwards compatible, breaking
> >   old devicetrees.
> >
> > Fixes: 28694e009e51 ("thermal: rockchip: fix up the tsadc pinctrl setting error")
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  drivers/thermal/rockchip_thermal.c | 36 +++---------------------------
> >  1 file changed, 3 insertions(+), 33 deletions(-)
> 
> In case it helps with the urgency, there are lots of people who have
> all independently needed to identify which commit stopped their boards
> from booting mainline or broke temperature reading.  I'm aware of at
> least these reports:
> 
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Reported-by: Enric Balletbo Serra <eballetbo@gmail.com>
> Reported-by: Vicente Bergas <vicencb@gmail.com>
> Reported-by: Jack Mitchell <ml@embed.me.uk>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> 
> I can confirm that my board boots again after this revert, thus:
> 
> Tested-by: Douglas Anderson <dianders@chromium.org>

I see. I can collect this revert if that is what unblocks you guys.

Elaine, do you mind checking why these pinctrl changes are causing
boot issues?



Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82CF5185FDA
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 21:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgCOUvK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 16:51:10 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:32792 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgCOUvJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 16:51:09 -0400
Received: by mail-wr1-f49.google.com with SMTP id a25so18761177wrd.0;
        Sun, 15 Mar 2020 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=pVIJZ01kRyUz0WervvORQEAOjoKFhiiXL438wwnVzBw=;
        b=a9WNBFqXj/guJb8Wa03I69UqmQ4bZ7hLlR6LRAnCXbUmyihb7LFYumn8PLRtKVHKrf
         ugukeRGShN3t9Sz5An5yA/xGkDUMFbYTDME2p8gItXHJdM1s0hFQnndL6Eck+GZ6bmGH
         Q3QdtL2YGv9ybNwIa5RtXC1BvK0o+7q+RRVCoYLxMdIuCVUDFrGSUS7Ie8WLlUYYiQTW
         Gto0vt99ZDIENPNnGVr4Ft1sOAz2ZIo8aqHemtEWOh2OeiHpuNMi3OsSAwSW4aDFgjlw
         BuIdXbcbdO9/ecbbHtAjiXx2Ql/hh0pcOqAW4jzfj72xGVKxJJwpzE4doZRtm5whKMXJ
         PH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=pVIJZ01kRyUz0WervvORQEAOjoKFhiiXL438wwnVzBw=;
        b=c1tuhnWwyLOp7gUe847CMgV5F5ZCN+2x8gbMb/Rv/hU2/Epe5px3zXrKevQSLmVkk6
         6RKyf4NCGzsq5jq/9bHNRxfLqJL3WfFT3dPAzFV6HihKYwONwbE5Ht0EDDeW39uLpRZk
         LBZ5v4BD6xsWA/AUIREX10tVOiMVdjLRZo+I8RzLVESAsWKpZydQR9fbZPAKfOzduUNg
         IJRk0s27wXlNOqpH5sN84aY62tVNo09TVdEYzjMhtVzHUqX723a/cS35d1JyOIdN16K8
         xOFW1x9qjNKtYX6k4H3gkatm/Lb4TGu/K1xDNAbSDIztmJW/GTagRi4zbqh/JMHJexm4
         wJUA==
X-Gm-Message-State: ANhLgQ3y7FNdTIaa/PzujddbctOyDBKhMMF7cizTIw6EUiqWpwhnTLyL
        AC0nnEyrIOy/J0D7ltLVHfQ=
X-Google-Smtp-Source: ADFU+vtdaf4Twd7Id2yJhGmBdydZjQj88epWRZxCxYZT9HAdxqPi/4DcSH2AUl/d6blOhOC8RT5g7g==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr33233468wrp.249.1584305467577;
        Sun, 15 Mar 2020 13:51:07 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id g8sm16555797wmk.26.2020.03.15.13.51.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 15 Mar 2020 13:51:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To:     "Pavel Machek" <pavel@ucw.cz>
Cc:     "Tony Lindgren" <tony@atomide.com>,
        "Merlijn Wajer" <merlijn@wizzup.org>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 01/15] power: supply: cpcap-battery: Fix battery full
 status reporting
References: <20200315151206.30909-1-spinal.by@gmail.com>
 <20200315185857.GA4914@amd>
Date:   Sun, 15 Mar 2020 23:51:05 +0300
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Arthur D." <spinal.by@gmail.com>
Message-ID: <op.0hjf7fb5hxa7s4@supervisor.net28>
In-Reply-To: <20200315185857.GA4914@amd>
User-Agent: Opera Mail/12.16 (Linux)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Could we get some kind of explanations for the whole series? 100mA is
> rather high current for end of charge. If you stop updating
> full capacity when "your" end of charge is met, you'll have battery
> charged to more than 100%. I... don't think that makes sense.

The aim was to allow userspace to see accurate values for charge_now,
charge_full and capacity (percentage) of the battery. It will allow
the user to estimate how long the device can work on the battery
with current power consumption.

For this the user will need to do a battery calibration. I.e.
he will need to fully charge and then discharge the battery.
Or vice versa: discharge -> charge. Once the user completes the
calibration cycle, he will be able to see pretty accurate values
for charge_now, charge_full and capacity. This is similar to how
bq27200 IC from Nokia N900 works.

Also this patchset allows the userspace to restore the calibration
value after reboot. By the calibration value I mean charge_full.

We can't rely on restoring charge_now value, because the user may
have multiple operating systems installed and if he works in another
OS for a while the charge_now value will become invalid.

So, after a reboot the user may want to restore the charge_full
value, so the kernel will be able to estimate the percentage
and capacity values without forcing the user to do a full calib-
ration cycle again. The only thing the user will have to do
is to fully charge OR fully discharge the battery at least once.
And he will get all values set.

Now about the chosen limits. For some reason the charging is
interrupted (and restarted after a while) when the following
conditions are met:
1) the charging current is < 112 mA
2) the display backlight is off

This behaviour was observed in Maemo Leste with hildon-desktop
running. I tested these patches for several days, so I picked up
the parameters for optimal (from my point of view) work in practice
taking into account the current "features" of Droid 4 drivers.

If we could somehow fix this behaviour (charging interruption),
I'd reconsider the end of charge current value to be 50 mA.

Making it lower than 50 mA doesn't seem to make much sence
because of the extended charging time visibility without giving
significant improvement in charge_full accuracy.

> If you stop updating full capacity when "your" end of charge is met,
> you'll have battery charged to more than 100%.

No worries. With the implemented algorithm, the user will not notice
that the battery is more than 100% charged (which is just a convention
here). And this situation gives an advantage in that it has a slightly
pessimistic charge_full value, which in practice turns out to be good:
the user will be warned about low battery a little ahead of time.

--
Best regards, Spinal

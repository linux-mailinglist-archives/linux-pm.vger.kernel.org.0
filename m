Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504331104A3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 19:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfLCS6g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 13:58:36 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37753 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCS6g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 13:58:36 -0500
Received: by mail-ot1-f68.google.com with SMTP id k14so3930050otn.4;
        Tue, 03 Dec 2019 10:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GxlDyiyTvNHPwD/5kIUhhaapFW9F7yBPVFKFV7a4/pw=;
        b=HB35UKkNyH7sare+zLM7xxgIZHbV9F77Hwqwle8r3olGJNwEmcS4YBOV2SrL7oY14W
         re7JZrGn0neuL31R2CW39Gu7lI27Zr2qVst6tD9LMZulDxZw3p/8u0UY7AYKG/hwDeqJ
         pxP0rfi7J7RUomB9RobuGj8rc+zooK1DkOg/JRARhLSSeFOD0yXFnxkUh5SA+gA8Th6w
         UzQSqF7S3Q6fwQwYu6lDM+FVQzoGl5aEPcFO05eNQvFbRPjc+lvzN3vxxxOg2uVAqAHc
         pHcOr6xLWoVOJCn3jg4w8atr2yd0HqNKvUafns7F04pW2W8wt/CGNKPd5TFjQ11uI2OX
         R0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxlDyiyTvNHPwD/5kIUhhaapFW9F7yBPVFKFV7a4/pw=;
        b=oyni3ZS+rmSGM0how086bulaJx0fg8q0xfFLCotFCOiE7E+OGUzF537c1nh9qs+1HV
         hDxkJYSqchmhdH/AIH35/AKQX/iua2aqgNATHkDsFLv7/RmJIdM/1T7E7jRCXTx+bx5J
         SZjzTKz4DnUi8DIm/nisv9vRL+2RUJjDt5SfQTrDhVul+VpM2baWtge9TkMWuJgFCNLp
         kMsiQIlvIIsNnkvz3ySI0Am+9tHK3ahX5uuJ4UCNRXD/fZfJF30LTvAbon8xg3XvFAkF
         txPjwgoGxS7uVGAfeRSkPlACvZ0gkg+KSPpwZh+8Kt8rjIxE38qe8eIT9/7CY/LWRtpo
         4OWA==
X-Gm-Message-State: APjAAAXTBUnXjQGYIaN3+z+cObuwhquURqbKj33QLtHfgAoHuLn9+Ayd
        mLtf7yBoOi+UJ7jKOtRxca+jgywNX2/sMELaPU4=
X-Google-Smtp-Source: APXvYqxtxFVwUA9PHt22kKsy5Pk+gZ5ihfj7SKHIEPvxXfFe3Wf6YPRTIkje0C6BNgeCx/KGE9V8JNW1D7fVd9TT4EY=
X-Received: by 2002:a05:6830:1211:: with SMTP id r17mr4396976otp.157.1575399515579;
 Tue, 03 Dec 2019 10:58:35 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLh8dsSCq850afbj4OiHhZ2swBWZP=BTUrXrXhdpTjZs+A@mail.gmail.com>
In-Reply-To: <CAOuPNLh8dsSCq850afbj4OiHhZ2swBWZP=BTUrXrXhdpTjZs+A@mail.gmail.com>
From:   anish singh <anish198519851985@gmail.com>
Date:   Tue, 3 Dec 2019 10:58:24 -0800
Message-ID: <CAK7N6vpawfLSVcHCg_3aQ0M8L=j77ZeGfmUZ-J4hpUkWu0fkWA@mail.gmail.com>
Subject: Re: interrupt handler not getting called after resume
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 3, 2019 at 6:12 AM Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi All,
>
> I have one general query.
>
> If an interrupt handler is NOT getting called (for one device) after
> the system resume (from snapshot image), then what could be the issue?

Most likely during resume the interrupt was not enabled. So check
irq status registers to see in the working and non working case.

> Note:
> * The suspend worked perfectly fine.
> * The runtime suspend/resume of the system is also working fine.
>
> If anybody have experienced this situation and fixed it, please let us know.
> It will be a great input for further debugging.

Need more context.
>
> Regards,
> Pintu
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

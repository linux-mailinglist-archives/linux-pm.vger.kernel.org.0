Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3814E1A93D
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2019 21:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfEKTZF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 May 2019 15:25:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43717 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfEKTZF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 May 2019 15:25:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id t22so4642700pgi.10;
        Sat, 11 May 2019 12:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=koge2frMwY+TltXqt/qyrkfkpXH+dUytXf+ZhSr+NI0=;
        b=ju3UudD57ScsZshKrD3KFLS6n12pOfUK6z1Ujd2ZBAydDwIE+3sdp7ZXiv0mRrtc6N
         G36Qk2orxejN/NFYkMH9Pfd2xMR7EPJqQ+Kw2MjGRZqNsOozq7b24PVQVbUUJKAOiHn9
         oSieIoFkdkH48XFXiUrFqtKJTrV+oeVOznCmJhlxkcOSX/C6oZpZAEqWdr5wQkNBMDVs
         fea3h+4ZUqqrAgiQLPbx8ToVsDKZc2pTsPqqnZN8kBAkLbCvveOafgOsW2ddJnDhRGMT
         vZ7qC08ruxUXtgUiRnROuocxfjPqYYgFUG3ik1teFdBZuGAV8VqdORWJoqSbfk2WDakc
         Vtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=koge2frMwY+TltXqt/qyrkfkpXH+dUytXf+ZhSr+NI0=;
        b=qw1oAjl2V6PTz4EIa7HxJl5IKGn5xHmloTtyaWm8EqTRkAWOHnlvB2+Wu5cNZ8K2HF
         ISiDxqP32j+yjWFqahMIN/XeWABhxD4WCC8RByMgn7gNKtOzzO8ywtMip73Lf8SikNKt
         p02n1FcyDRqW+u5oG85VzuLwPQkHEas6La4I7apioh/HbF69H7Zn5k0inVNM3B/bERVP
         +R+p/6snn36adXHlmpKx7KP5iR0VDvpo/fFwVcRzwR2kyb1jlmFAytNukj80qi/04xdf
         RhLWLtLlbSiyJ5KgB131Jg6Gfc9POfvUzbk70JN9DIFRWjqOKP7ktGnHPmpdVSGHF9z2
         KwKw==
X-Gm-Message-State: APjAAAUmUrxSImReTpPIXXa/A3ih9ZOpliMJDZxkhCf38gPCXONwosPD
        F199vDTPxBlfrvLxcL0xx5ORA7Ec+Yw=
X-Google-Smtp-Source: APXvYqz5GFANMOLS2G8X55ATmWDTmtSRvrdy/Jn217NOAvKY/i4/+VQJGmG9QZBcwOsvErPFHPuTSQ==
X-Received: by 2002:a62:d044:: with SMTP id p65mr4107462pfg.37.1557602704436;
        Sat, 11 May 2019 12:25:04 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4e8b:2a8:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id a80sm25972795pfj.105.2019.05.11.12.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 12:25:03 -0700 (PDT)
Date:   Sat, 11 May 2019 12:25:00 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH - resend 1/3] thermal/drivers/cpu_cooling: Fixup the
 header and copyright
Message-ID: <20190511192451.GA15554@localhost.localdomain>
References: <20190428095106.5171-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190428095106.5171-1-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 28, 2019 at 11:51:03AM +0200, Daniel Lezcano wrote:
> The copyright format does not conform to the format requested by
> Linaro: https://wiki.linaro.org/Copyright
>=20
> Fix it.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Viresh Kumar <viresh.kumar@linaro.org>

Based on the series and other patches of it, I am assuming this is an
Acked-by..

Applied as Acked-by.

> ---
>  drivers/thermal/cpu_cooling.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index ee8419a6390c..42aeb9087cab 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -2,9 +2,11 @@
>   *  linux/drivers/thermal/cpu_cooling.c
>   *
>   *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.c=
om)
> - *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
>   *
> - *  Copyright (C) 2014  Viresh Kumar <viresh.kumar@linaro.org>
> + *  Copyright (C) 2012-2018 Linaro Limited.
> + *
> + *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
> + *		Viresh Kumar <viresh.kumar@linaro.org>
>   *
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
>   *  This program is free software; you can redistribute it and/or modify

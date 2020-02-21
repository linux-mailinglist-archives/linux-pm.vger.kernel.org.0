Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 185BF168183
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 16:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgBUP0C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 10:26:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43987 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgBUPZ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 10:25:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id r11so2495426wrq.10
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 07:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=39vzs+3PR2IOAxB8jmugcd50CTjNopkio/uzevne96U=;
        b=f2oIImdHZZlJrf4QHfYkk3mMK7o3ckEtdPUU2722QhXaVU6o3aLKEaGiNi0BoT5xZN
         1R9UmWWAYMeKAPihOLUQbRIIjw2dePaz0Rxr4rZ59/Jj0xwPAJfrZcc95Yuoc4G0YZ6J
         CtVZtZNkO8sjJqFetUCc2aSA4egpHYYOhRt3+8PhfH813kRoWrVfjMBwXNMV11Of0lmX
         mdOy1CzxNagrlstbUWAxXXsM+kt5Io5UwxX8NNQJ2f5hM81+ufcEnpTZ3zkY+nBVawMZ
         m15eWZWtwJ+CYorGk9zuCo5CDmlIK2JptPpm3KaxdU9aQGgrjRJco70p5PJE0TyD1cCM
         oQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=39vzs+3PR2IOAxB8jmugcd50CTjNopkio/uzevne96U=;
        b=L3M0bPCsc4TiaUuK+cgugWTk/y5VFoeoT1gWUDra4QxMaYR3P3sXxek2U6DB7JFZvt
         c7XboJRgQYXChlauAxAdSewe7B0neZ+KlAeuXUV0a7BQeMYJp+Ve21i7ZSNIaodXO5FX
         Eit/Bt0BbtfEpd/fvHuoWPBXfjO5oauN4LCSDdAFnTI3FRpuHiymZLZajdMYA3lpDm9Y
         uTCGWubkk9i+MOoXZj4BZ4L3yrIgkzQTUr3pqajE5HcnGkLXmjDhGLx00/9DDGkn4/wT
         aQxepx8EbgVZ/8ZxStjH0C3AWi+ehpXm2irEtcQBlI7KKs5EP9HcmyPvgBWt95tuojjW
         h8Cw==
X-Gm-Message-State: APjAAAWmA4xxmqSYRE4Emt29xwwN09YdzWmp3R+8+raLb8ZHfLZuiIlK
        dsZVselmKXECy2XuosAA94USIQ==
X-Google-Smtp-Source: APXvYqyJr8NTGiJQQEABfUSMNuPSEiSl7ArQY9B3ZpVk3cNArch9dZNZYuAjxmpIHDOpFQHfSlyZUQ==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr52112615wrt.229.1582298757617;
        Fri, 21 Feb 2020 07:25:57 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id d9sm4384193wrx.94.2020.02.21.07.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 07:25:57 -0800 (PST)
Date:   Fri, 21 Feb 2020 16:25:54 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 11/17] arm: tegra20/30: cpuidle: Remove unnecessary
 memory barrier
Message-ID: <20200221152554.GN10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-12-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212235134.12638-12-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 02:51:28AM +0300, Dmitry Osipenko wrote:
> There is no good justification for smp_rmb() after returning from LP2
> because there are no memory operations that require SMP synchronization.
> Thus remove the confusing barrier.
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Jasper Korten <jja2000@gmail.com>
> Tested-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE23C19EBA2
	for <lists+linux-pm@lfdr.de>; Sun,  5 Apr 2020 15:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgDENuW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Apr 2020 09:50:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34955 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgDENuV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Apr 2020 09:50:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id k21so11809138ljh.2;
        Sun, 05 Apr 2020 06:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uv0gJAJePFo80MkHUlxiyjcf0SQ/kT+ozQK6DRClyD0=;
        b=Pn2nPfw3fa/VzBCppjsY9oLHVVNDBWybYdBiswD/GCnrYEJ4RG7LOYtZBHAEr03War
         3pzJj/qyEl5StxNUxq1CMjLh8b9azV/EHDP6o1cgisLtM/97doYSWFoXZjzfI5diZH5v
         Y1t8f0Qk4HvVmXuIbGkw9mMg/WCdcMQQkh9UhX/TrCzIr3OZVsutwAV8+zfjl3esO6Mq
         nIL4tj7AptJEJ73E1Bdp4hUXtMDQZRhDCOiCzJ0Wl7A0Y2bDJKULFiutOWj22JtXMf/Z
         S/ybJbV8aN3eh7jtQDU3ESc8qx0uT4U36Np4ihU+eC4KxXzzvPHG7TysVDjfW/rnXtYW
         tFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uv0gJAJePFo80MkHUlxiyjcf0SQ/kT+ozQK6DRClyD0=;
        b=foSGslpQ/GWI3LEDWEBkTwOBruvi4ujmu0sj2xgXX+Zg4S+DPIQIoEWLhhX3ckDlvy
         9xbQ0XBR77eJRHt9rcvUjmqSXfO82muyIfiUKKoRo76f+p2Kplkf1hrTaJeOHoatgoXf
         KMDJcA014t2+SO8CJ1cMsn/J3SiURuy758FDTfo8FXmzqctwiPjMBvN0CwwwPSBpizSy
         q+4XMR782kr0r41sKSdY5gZbV6GotW4CK2SA10wBWy/9484wyRkx2+SAov5oxSTuOiHu
         N1hVKi/kSQ4m/SVtxX6/HA34pGKi7/ZgY3lY4rHgQ4oofBDqy4xI4gR9srsSd9X69stx
         7UYA==
X-Gm-Message-State: AGi0PuZ9OM/G16PF+zMB5qGKVzAqQ1E3eawr2COLAgudMHdddTfh2gnz
        L4LjLyU3jyoSex0x+nu0Uj0=
X-Google-Smtp-Source: APiQypI9e1yr2ND9ohdIUGxNvEo1UIOO0dT9J5Gy/HM2tG3hd+Jld+2dg1md4VFp2iAK418A70mIIg==
X-Received: by 2002:a05:651c:113:: with SMTP id a19mr9435045ljb.167.1586094618771;
        Sun, 05 Apr 2020 06:50:18 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id y20sm8555337ljd.35.2020.04.05.06.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 06:50:18 -0700 (PDT)
Subject: Re: PM / devfreq: tegra30: Delete an error message in
 tegra_devfreq_probe()
To:     Markus Elfring <Markus.Elfring@web.de>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
References: <ba67e238-43a7-6c53-363e-7a2c12f09949@web.de>
 <27bdd09b-0b8d-a6ef-2ffd-53421277fcca@gmail.com>
 <72e2319e-9b9b-9045-c007-320b2be1e886@web.de>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2af3ed08-3607-9ecf-e092-fc126d2abeab@gmail.com>
Date:   Sun, 5 Apr 2020 16:50:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <72e2319e-9b9b-9045-c007-320b2be1e886@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

05.04.2020 09:00, Markus Elfring пишет:
>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Thanks for your positive feedback.
> 
> Will the logging of error codes need any more clarification
> around such function calls?

In general no, but it could be different for some (more complex) drivers.

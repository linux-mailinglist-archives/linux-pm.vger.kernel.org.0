Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B31175092F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 12:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfFXKsv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 06:48:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43886 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfFXKsv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 06:48:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so12108210ljv.10;
        Mon, 24 Jun 2019 03:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=48NvXtBabkZpDIg0NQATjj0slskyhYI5TYmmHmBMw/4=;
        b=CCQ7OOK6KmaY6CBxd06O91+XGhNYzUiVrd02QObuEhjFtWbChUwNHSm6ZCJr6A4b+x
         kf7jD69xOS/4wro2CyYqhj7AHEMHp4kkcNhrpCPZMvpCNvkyQRisWPLFBV9ZceALq5h2
         feN/60rG8Q9yFX5X1ZmYALmthGQKEi27hq2KBFOpdoXkr9MZYcGQLEey3QqC058BNw4W
         K9J7NUj8GVIvawZyHVnRFZL7q4ktuqixVZ8dOvVIILcc75kBjLqDTU/oLKZol8jP7UVv
         7RKh5wrbufX/BSxyijqUzBblZE3QUoEA8UxbI0H2TTua/LBb41y6ST44HbOu2Ju7oRkN
         Ef8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=48NvXtBabkZpDIg0NQATjj0slskyhYI5TYmmHmBMw/4=;
        b=OZn34OSmdcuLHCmj33TYB2MwDo5k8n0mmgUah0QCE1tzoy7O0JgHfnxeXRTAhUvwT1
         6OvRBMmutIujaZo8gnd9e/Y8ymvkGukIcYN8t/TlC4wqOBeIPMEstmP2XSjgoHuMU/qL
         NH+PU9Le5ikSCGge9qLPfgJyx+Pfw472mVbH0c5SP6PuFkCejjIqPtaZR8oIA+zRgoDz
         LMZWBvIvFr/TUHhQfeYp8nfn+UnV/MJY8eBfzf3l+o9IwAwcqetuzFFrBvYKFHQ+J+E/
         baGeSsonjKP3O2+iAvdJJpaKB168qvqP51VwAZ1nbm9sdbP7/8Q2NOHEkpPLfzDgkONn
         GtHg==
X-Gm-Message-State: APjAAAUFFqtt9yPm0ccYssWmzdg+oFlMCMFAVukMieNMNloqczeBlEn+
        4IL6wn5L+lagpKAFC2ZkLJqGGRcM
X-Google-Smtp-Source: APXvYqxV9qkewxH7X5WZ24eDBmkXkh/BC7gnleOEwZM1Kk45jxPl6PvqKh1n7C/IJ4UGpC0Xp6J0gA==
X-Received: by 2002:a2e:639d:: with SMTP id s29mr9735048lje.172.1561373329535;
        Mon, 24 Jun 2019 03:48:49 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id n24sm1676156ljc.25.2019.06.24.03.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 03:48:48 -0700 (PDT)
Subject: Re: [PATCH v4 16/16] PM / devfreq: Introduce driver for NVIDIA
 Tegra20
To:     myungjoo.ham@samsung.com,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <CGME20190624072431epcms1p3bdfd41545e7daecb1f6472c1e6f9dcfc@epcms1p3>
 <20190624072431epcms1p3bdfd41545e7daecb1f6472c1e6f9dcfc@epcms1p3>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <162d4d78-7e1b-eca5-20b5-ee3f5a30499e@gmail.com>
Date:   Mon, 24 Jun 2019 13:48:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624072431epcms1p3bdfd41545e7daecb1f6472c1e6f9dcfc@epcms1p3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.06.2019 10:24, MyungJoo Ham пишет:
>> Add devfreq driver for NVIDIA Tegra20 SoC's. The driver periodically
>> reads out Memory Controller counters and adjusts memory frequency based
>> on the memory clients activity.
>>
>> Reviewed-by: Chanwoo Choi 
>> Signed-off-by: Dmitry Osipenko 
> 
> Could you please send a separate commit for MAINTAINERS?
> 
> I can add Ack to it, but I don't feel comfortable with sending
> a pull-request with MAINTAINERS entry updates.

Okay, I'll factor out the MAINTAINERS entry update into a separate patch.

I'll re-spin this series, appending the followup patches [1], and will
also squash the Tegra20 / Tegra30 MAINTAINERS update into a single patch.

[1] https://lore.kernel.org/lkml/20190623214658.11680-1-digetx@gmail.com/T/

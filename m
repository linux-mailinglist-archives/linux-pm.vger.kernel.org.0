Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCB26A99A
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 15:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfGPN0e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 09:26:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39258 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGPN0e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 09:26:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so19919397ljh.6;
        Tue, 16 Jul 2019 06:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i5eernLBaFGhyCIFa6yPKjvfBtf5hN1/5FhaLw6hzyI=;
        b=gvXucYZhO534m2RGH5gg/cG8eTfj3B6c32P1G69Wvuwp3O4k6rQrig+mRIYeJDgjlt
         Y7n0Ac1HxHnFYP09tfX6fnZe87kRm54UNadKFlRUThjA+VVJe6+1Ts/QXts++fWrfRp/
         iSb+ix8YNxR5z3Q0ivKHsxy8yAIxZ1xsdGm09CwPiKtbGBYudXbGdfKaKP5lHzttrFE+
         tblVAZazjR2NlOx5AMobqN8ypsbwbQi09AonLgfv91fBCrEAi4lJUjWKwUb/+cNzbYef
         9ZaX4dLpBtAh5MLT7nd15kmFr/Y9oFQ+SKszMJiaVaqNoCHkFCQ2SXYttJwQjbGIy7x+
         ovnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i5eernLBaFGhyCIFa6yPKjvfBtf5hN1/5FhaLw6hzyI=;
        b=pA5LNGK5Tg9DwmwkOcQwoAbyyZjDGQDi80Hse6Qdu8RcODLl5YvVYONtRqVOBEWfv7
         ExgGQBCzCxPoD9x3qH1IcdqY7Wv2IQY+iY0iHMRQH6WWp3ZKdQEgvlPb1FdU508ZJ125
         AToIsb9tzzJbuv4qHwfWtypdeJhuAP6eBBaMQyza+6jcfd22MqXr4DSSeehFtZYqQ/RO
         VIdUmiO/E/AgW0my2TnYOEAk6UREyl8Z+pW7h0LDT8g+uLvEI2MCTJG8JTbcTHtgGgK+
         KzT+otKuTRSzKnp4RZnCKsSl7L4o+Cyzj2ZrL1fQucSiW7cHktMbIY9sidlLVIkR74qm
         wCRA==
X-Gm-Message-State: APjAAAX9Tzqg4Qkp/D/Y/gCDsRNaV9sBWx8cdi2pd0l0HoC38EwwWar+
        SIaND9Yq5G5vpTBR8DHB87+19SxL
X-Google-Smtp-Source: APXvYqyW3ijl5BFSBz50w1dNQBMhm3ZSISRMKPZBneOo4V473+dhc7T7buMTUwKZAtM9Ljhj8oObHA==
X-Received: by 2002:a2e:96d5:: with SMTP id d21mr17883568ljj.170.1563283591701;
        Tue, 16 Jul 2019 06:26:31 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id a13sm2855146lfi.57.2019.07.16.06.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 06:26:31 -0700 (PDT)
Subject: Re: [PATCH v4 11/24] PM / devfreq: tegra30: Add debug messages
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190707223303.6755-1-digetx@gmail.com>
 <CGME20190707223640epcas4p15337f40466342832b731ad6a53be946e@epcas4p1.samsung.com>
 <20190707223303.6755-12-digetx@gmail.com>
 <c883bdbe-427f-35a1-9e63-5e4953a84286@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <53cd0ba5-f814-cd9b-19c5-1d42717ca58c@gmail.com>
Date:   Tue, 16 Jul 2019 16:26:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c883bdbe-427f-35a1-9e63-5e4953a84286@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.07.2019 15:23, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> Usually, the kernel log print for all users
> such as changing the frequency, fail or success.
> 
> But, if the log just show the register dump,
> it is not useful for all users. It is just used
> for only specific developer.
> 
> I recommend that you better to add more exception handling
> code on many points instead of just showing the register dump.

The debug messages are not users, but for developers. Yes, I primarily
made the debugging to be useful for myself and will be happy to change
the way debugging is done if there will be any other active developer
for this driver. The registers dump is more than enough in order to
understand what's going on, I don't see any real need to change anything
here for now.

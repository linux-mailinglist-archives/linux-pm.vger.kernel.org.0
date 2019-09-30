Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD60EC2345
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbfI3O3S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 10:29:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33793 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731686AbfI3O3S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 10:29:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id r22so7224125lfm.1;
        Mon, 30 Sep 2019 07:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/cUHoUaqss8qI6KXUvCsZN8O0fRZQEbP5/fl3QSwh1o=;
        b=a0TGinOg0c8hiInPfRkFhKcAI/pPy0nuNaJobXF+ErQ72uXQF0IISRHdV5KIfRKiC7
         glTMDeFvH8GoZxUb3rhz6SyfDHaoaiboEpIPcOGNUpnV3XFCSAlKJu/+HZDGetm93Q1n
         9M6z+TW3AAe/z4CeBn5/Enmwy5Gm6qRIKGSlbdIkCA3P8uOYoXX8QPBtlH3e4pXZBMdn
         EJrq0Mb008YwZ/t8h50HYz3DbR8exEIK0ouyE1uxF+8J3MRRiEWeyEkjJY5rGjpUlX9e
         QV83BlJtHyG4EjL0WVvijHCD0IxkNYSqD8+4T91bZIAA5wmo1Qp6pD0PPXD6aknBflsf
         U8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/cUHoUaqss8qI6KXUvCsZN8O0fRZQEbP5/fl3QSwh1o=;
        b=gEOdt+7eN4z0Ha40/HaGdsDzrbtkI2VUJHufnSBz7dXASQ0G8dr/1T58nh5xs80bC3
         M9tfVAw0o5VlwcPz8DhMFjJtXtVbqHE0jrlAb64CCPRZpTOt8zO7K+CYF3uQOuIYK+mC
         S9iyhePhG3NmCoZpP9miyucT474m9lUV9QFqrjdYS5K5mK3/yf58kmvxCZj6VLo/WHYX
         zrTsvdcAMbJUioEqYjDEdrDT9hGe8yhMjzFy79+aiH6DawhJcH77stQ4Kzo/wH6yVUVt
         oJ0+LrBLQ2nXRQdp6ZYefNgvAmKhFNh5K0u43ceH5poZiTDQBbQZ9VJsxc4OxI/Qw6bu
         60BQ==
X-Gm-Message-State: APjAAAV7dDyZNF6uoN3SV3b5jPJzxM8xtU/0djF/45q2YaoJLaRxuf08
        J8Jzn6pcfhw940Q/YsbiRdzQ8M5F
X-Google-Smtp-Source: APXvYqwFjlepUlfhs1IaHhMZu4sLyNS0YVja8fQhsmG6txfhULFCIZsY4a893MARc0PIh4ARbcSTUw==
X-Received: by 2002:ac2:5586:: with SMTP id v6mr11431654lfg.180.1569853755403;
        Mon, 30 Sep 2019 07:29:15 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.googlemail.com with ESMTPSA id w17sm3252756lfl.43.2019.09.30.07.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 07:29:14 -0700 (PDT)
Subject: Re: [PATCH v5 08/14] ARM: tegra: Make outer_disable() open-coded
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190929175952.22690-1-digetx@gmail.com>
 <20190929175952.22690-9-digetx@gmail.com> <20190930080511.GE1518582@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a23edc5b-97c6-9dae-589e-b71d07069b0c@gmail.com>
Date:   Mon, 30 Sep 2019 17:29:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190930080511.GE1518582@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

30.09.2019 11:05, Thierry Reding пишет:
> On Sun, Sep 29, 2019 at 08:59:46PM +0300, Dmitry Osipenko wrote:
>> The outer_disable() of Tegra's suspend code is open-coded now since
>> that helper produces spurious warning message about secondary CPUs being
>> online. The secondaries are actually halted by the cpuidle driver on
>> entering into LP2 idle-state. This fixes a storm of warnings once LP2
>> idling state is enabled on Tegra30.
> 
> If the cpuidle driver halts the secondaries, shouldn't it set it offline
> then so that outer_disable() can still work correctly?

No.. how would you know what CPU's should be resumed?

AFAIK, the online status should be only changed by the hotplug code and
nothing else. I don't think that it's a good idea to manually touch the
online mask.

It looks to me that the only purpose of outer_disable() checking for the
num_online_cpus is to prevent people from doing wrong things by
disabling L2 in a random places in their code. Hence it should be
absolutely fine to open code when you know what you're doing, which is
the case here.

We can check the rail status in tegra_sleep_cpu():

if (trusted_foundations_registered() && outer_cache.disable) {
	if (WARN_ON(!tegra_cpu_rail_off_ready()))
		return -EBUSY;

	outer_cache.disable();
}

Which is equal to the check for num_online_cpus. Does it sound good?

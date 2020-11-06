Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92462A96E1
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 14:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgKFNSW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 08:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgKFNSW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 08:18:22 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05142C0613CF;
        Fri,  6 Nov 2020 05:18:22 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id e27so1871104lfn.7;
        Fri, 06 Nov 2020 05:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/ZICzGQmqQbkGI6sIDsSebYSxfwSQo6dV5nLmzImzEM=;
        b=Th0FVcMtP7pzCAWxNyRhRsbrX5/KeAsZalB8SYcP9z7qA4uAUWIOnBO+RYQjT9mw5B
         cSnCXDppYrSJLZgShdLbGxiiceYc8ZWCpfcUrcVz+tw1h09HX2FE4qsP150aqCy85dc5
         8qSoqh0+MyaBsvcu/QZZPl1b0RjB79I+kibDCH9V0HbaoAFcqwL5ZHa0UgZpJAZQskNI
         I22Os1h8n1HcCncOkRjd/jNESppeHfwQu2XLYfZBi0/vqN8M/XyrHhxMeuEoWxoyOquY
         op/RfghaLweNpZvLVr9rOV6qz6Ko7N2EmN1qklkbGCDip2699Nzg5y2b+q5dOTtUG3GT
         6pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ZICzGQmqQbkGI6sIDsSebYSxfwSQo6dV5nLmzImzEM=;
        b=NcuLPpq7cVYksLizbJijo0uWoB+vk850EWVvLcrShdfHCVYlgSqJ83KBR3D5VRI6O1
         cYzvMMjtTDxZr8TwC2qGc7m+YG+8GEhgFAJueKYimJ2eW4h+IN9O9Z4sO71uDNclpd/y
         o3nKOlA/4DxrqkiDmbPedfBDEQfC2MpOrCEW9cc9rdRq9Kmu1MtlXnx/0LwsqUTldaCB
         cFTzJdDSCp32Vnj6AYYpeaPZyCurLJ2UNui+4rK9ohk+HN2w4iW1T0UHEuuCMdhpvnG/
         88oPkViAypHBGEqA/4RM76g2a2tujt80R56WZofs6TM20VvWC7yOVtKFx8S2nEzV+q1E
         zCTw==
X-Gm-Message-State: AOAM533nNnDSEg2yyVJ0XK0c8Qn64kc8jxzxufIB1xhHprHGGFFuiQa2
        RgcJTU/oLnG5ckMJEljUWMr5BfXKm7c=
X-Google-Smtp-Source: ABdhPJxTkP2nzxORo9hszBEzNCIz/b63bCFXVn0pFxEHE4HfsnE2LZI+v9lZTjqNnO8zjJcXihuvwg==
X-Received: by 2002:a19:3ce:: with SMTP id 197mr970993lfd.364.1604668700381;
        Fri, 06 Nov 2020 05:18:20 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.googlemail.com with ESMTPSA id p7sm138030ljj.47.2020.11.06.05.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 05:18:19 -0800 (PST)
Subject: Re: [PATCH 2/2] opp: Don't create an OPP table from
 dev_pm_opp_get_opp_table()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <684ff01900180c0a40ec307dacc673b24eab593b.1604643714.git.viresh.kumar@linaro.org>
 <1012a98950355bd5a52424668050a17c3430cbe0.1604643714.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ec9839dd-5d2d-0d6b-6563-b14da4af1a57@gmail.com>
Date:   Fri, 6 Nov 2020 16:18:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1012a98950355bd5a52424668050a17c3430cbe0.1604643714.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

06.11.2020 09:24, Viresh Kumar пишет:
> It has been found that some users (like cpufreq-dt and others on LKML)
> have abused the helper dev_pm_opp_get_opp_table() to create the OPP
> table instead of just finding it, which is the wrong thing to do. This
> routine was meant for OPP core's internal working and exposed the whole
> functionality by mistake.
> 
> Change the scope of dev_pm_opp_get_opp_table() to only finding the
> table. The internal helpers _opp_get_opp_table*() are thus renamed to
> _add_opp_table*(), dev_pm_opp_get_opp_table_indexed() is removed (as we
> don't need the index field for finding the OPP table) and so the only
> user, genpd, is updated.
> 
> Note that the prototype of _add_opp_table() was already left in opp.h by
> mistake when it was removed earlier and so we weren't required to add it
> now.

Hello Viresh,

It looks like this is not an entirely correct change because previously
it was possible to get an empty opp_table in order to use it for the
dev_pm_opp_set_rate(), which would fall back to clk_set_rate if table is
empty.

Now it's not possible to get an empty table and
dev_pm_opp_of_add_table() would error out if OPPs are missing in a
device-tree. Hence it's not possible to implement a fall back without
abusing opp_set_regulators() or opp_set_supported_hw() for getting the
empty table. Or am I missing something?

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969BA304838
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 20:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbhAZFsC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 00:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbhAYQB1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2021 11:01:27 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49CAC06174A;
        Mon, 25 Jan 2021 08:00:46 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id l12so13361965ljc.3;
        Mon, 25 Jan 2021 08:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JOoMcr6gXPOH11DZhT/CQoFTEMtxIzC/wwQvt5fOQcU=;
        b=s9ZsLNOMX3/ADc0QvUSgm9Yg1DqXKjdKMs4QAHCWpedsj9oiNKbnVgFXUsLEZ7bCN6
         PuK1JwHj/WUsJsEg8X6qiQw/0rB34XxNv74C+j7C9sVEYA0f1B3WiPGgvhoeZA+VtHdE
         y4bS90Sd/n/Wry31xnp0HN+INJtB7ARvtoP/ECQru3/eADWj2Y7N6ib55ByZ/ugmMvah
         MrUZhywSbV15i+xANr0NFQptn7RtEugQtZVCbY8HcHjCHAuD4SoFNJklB24Y1jBI8BkT
         ViLeIB5gGBJFTnE+o6fsMFlc651CMnaaJ6p9jEdQwUyxy0vudynIIYYJIiv7KNBrKlVP
         9avQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JOoMcr6gXPOH11DZhT/CQoFTEMtxIzC/wwQvt5fOQcU=;
        b=NqhywZt3sjk79lUEiFTpgza4vQX5Y5PL0v6bRP6NN4SaieKcJ8fPmg46gu3u4zcBAO
         eKJlH+lwa6tHGFeuDB/CaiyngHh9DaZlcgKh/29L6YotWZ/d4fOKU1TCr0or1IIuSjQm
         v2UA/KPtJSvC2fpI3PLRrHM3WGNiZhoC09DgDgM6xYt00CHxqfL2Qj8mb32Gg2qb+Scd
         5tFhDi35LK740nWr0qCcKXSc2IvE5HRZ+VPI7vzTsiHHlSym6Au5bNu6HEbfbt9dFeyq
         ZBaQW/42n+jJ8oHfCPn2J9yo/SU0obuIgK0gbVwj95vkgqvZRZGgqZUfWPHOT43yjqqj
         2muw==
X-Gm-Message-State: AOAM532G6JsF2PqtuLLBEhVd5ZSNqh3Hl5xUMkQcaHsK1x7IcgwrMFZm
        6zvSWRXdAbI5jw7wT/uRwEj/VGAKfvw=
X-Google-Smtp-Source: ABdhPJwuUl9XnI7wh5L2vZA9lC5YKKyuJ3rqG7nMeiXnigRzAbpYaNeFI51XmmRdCEu4EEaYw8iHug==
X-Received: by 2002:a2e:9bce:: with SMTP id w14mr510036ljj.120.1611590444956;
        Mon, 25 Jan 2021 08:00:44 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id r21sm831903ljk.1.2021.01.25.08.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 08:00:44 -0800 (PST)
Subject: Re: [PATCH 11/13] devfreq: tegra30: Migrate to dev_pm_opp_set_opp()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <3345fd49f7987d022f4f61edb6c44f230f7354c4.1611227342.git.viresh.kumar@linaro.org>
 <71451eb2-46b2-1ea0-efcc-0811568159a4@gmail.com>
 <20210122062659.qss3hef4kltfgciu@vireshk-i7>
 <f33334e7-bd28-af82-b557-681a2b4132da@gmail.com>
 <20210125031402.aqiwhlsozvakehxd@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <05eee5d4-9c89-e3fd-a716-efd44191231a@gmail.com>
Date:   Mon, 25 Jan 2021 19:00:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210125031402.aqiwhlsozvakehxd@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

25.01.2021 06:14, Viresh Kumar пишет:
> On 22-01-21, 18:28, Dmitry Osipenko wrote:
>> Either way will work, but maybe keeping the dev_pm_opp_set_bw() is a bit
>> more straightforward variant for now since it will avoid the code's
>> changes and it's probably a bit more obvious variant for the OPP users.
> 
> The problem is it creates unnecessary paths which we need to support. For
> example, in case of bandwidth itself we may want to update regulator/pm
> domain/required OPPs and this should all be done for everyone. I really do not
> want to keep separate paths for such stuff, it makes it hard to maintain..
> 

Maybe we could add dev_pm_opp_of_add_table_without_clock(), at least
that should be a bit nicer from a drivers perspective than having to
care about dev_pm_opp_clear_clk(), IMO.

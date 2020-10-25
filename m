Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D304C298284
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 17:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417170AbgJYQ3h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 12:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417168AbgJYQ3g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 12:29:36 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD49C0613CE;
        Sun, 25 Oct 2020 09:29:35 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id p15so7176503ljj.8;
        Sun, 25 Oct 2020 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8qSpxaySb+J1nC02XHO83Se4mRnezoN9KgwHpLD2zmI=;
        b=Se1LaPaznM5k8d7fvgW7bMX2O7jJtPZOeH1M+gU3n+lvA3do5YnINdA+Kyj52tf5yq
         /X0zDLr0nBFVOHtoHdEwwUgBu1KaAkLCciSJVUf/I2usoDkdPVq0Fx6lC4KzwhnyehwW
         /fbFJeJyanUYbL5/Ea1Js0iqXDZXvqotGxLrLhyZk3s4sdTBGVjdJxYmHI97FYEeacKu
         vRlkDDvOlZjO/YXQcduOPfWI9OY/1Kv87UxML8+m+fld9i5D6zRs74O4xgEHSEH6fk1i
         IpEPfoOQwhjcScOoshTdsN5dl9RNjSjcGODptIB8YyQcLTET/H3j0hip+DNjPVYwBopm
         GKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8qSpxaySb+J1nC02XHO83Se4mRnezoN9KgwHpLD2zmI=;
        b=m7Q3qflOBLO6OF2SZyJskTd4uIWM9CrFZzkb+zU4SuG+nUX7CKnajAKy3qqxDeK3aG
         TdgJqNnbYpSooe16SHszwS3X8JxMWL8bg0yhvgzENuaLvO1l4lBK6MInKvKR/sCwf16Y
         t6VCdnUuzveWY7Kzlhe1XiG3SZg/xLX5eMLBb5TXDW2iNF4oT9Kzrn2iWcZpB1ZSDpSs
         YcXJ2D3rkcUpN3DIeGkD0MPGswqD4YB5ED0cBWVqF6v1wRYYnthoG0ORsCCjK5sByq0H
         ihIBWHvnYYcIS8tpuyGV3aG3NM4e2Weh9ctpFV7KjlJSEr+frEg24t73tRb1EV1PUg3d
         PdcQ==
X-Gm-Message-State: AOAM531Iu7yhrgBbAw8IhoGv6T5swhZ2MX7MNHpzcSWWrSJyMXooL5hW
        oa/kqhXjFKF9ctWuJlwEExE=
X-Google-Smtp-Source: ABdhPJzzBC72dXIfQIn/FfwS/F0oDDauNBKMlkBBoHJ4W/XNOFPgiqlHxNd1rp03tpCABMF60Xjthg==
X-Received: by 2002:a2e:864c:: with SMTP id i12mr3978701ljj.396.1603643374287;
        Sun, 25 Oct 2020 09:29:34 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id v3sm769788lfa.211.2020.10.25.09.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2020 09:29:33 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] PM / devfreq: Add governor feature flag
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     lukasz.luba@arm.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        abel.vesa@nxp.com, k.konieczny@samsung.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
References: <20201023102632.740-1-cw00.choi@samsung.com>
 <CGME20201023101246epcas1p423f0444201300830fd63f33748dd8952@epcas1p4.samsung.com>
 <20201023102632.740-2-cw00.choi@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <622cd840-0b09-e377-fbff-dd3e8ef0ff4e@gmail.com>
Date:   Sun, 25 Oct 2020 19:29:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023102632.740-2-cw00.choi@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

23.10.2020 13:26, Chanwoo Choi пишет:
> The devfreq governor is able to have the specific flag as follows
> in order to implement the specific feature. For example, devfreq allows
> user to change the governors on runtime via sysfs interface.
> But, if devfreq device uses 'passive' governor, don't allow user to change
> the governor. For this case, define the DEVFREQ_GOV_FLAG_IMMUTABLE
> and set it to flag of passive governor.
> 
> [Definition for governor flag]
> - DEVFREQ_GOV_FLAG_IMMUTABLE
>   : If immutable flag is set, governor is never changeable to other governors.
> - DEVFREQ_GOV_FLAG_IRQ_DRIVEN
>   : Devfreq core won't schedule polling work for this governor if value is set.
> 
> [Table of governor flag for devfreq governors]
> ------------------------------------------------------------------------------
>                       | simple    | perfor | power | user | passive | tegra30
> 		      | ondemand  | mance  | save  | space|         |
> ------------------------------------------------------------------------------
> immutable             | X         | X      | X     | X    | O       | O
> interrupt_driven      | X(polling)| X      | X     | X    | X       | O (irq)
> ------------------------------------------------------------------------------
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>

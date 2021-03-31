Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B29350525
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 18:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhCaQyZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 12:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbhCaQyF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Mar 2021 12:54:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39174C06175F
        for <linux-pm@vger.kernel.org>; Wed, 31 Mar 2021 09:54:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b9so20344169wrt.8
        for <linux-pm@vger.kernel.org>; Wed, 31 Mar 2021 09:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xznif/MH/M9aiazIt+TNwkIsOPRFEi4pc4I4E7feLW4=;
        b=Wk926Zyt5NAXknc85ifZFdrd+TO9JoBNPnmY9WYuuQC33cRHUHTXCafLp14OfaJiok
         zMDuxi+Yb/lOZIUb5Rq3flGlAl8+qGNspGvohvQDQ/dLV/9RbLPegY3RSWH9PiRYgWed
         Xoo/3U7DcD62z7r/coj38fXgrNVhte++FvMmm4PsWijLOGrdGHLL9vtNNPE169Fm/1KV
         4axDbRRbn1T0aJVToDTbKoPlpZgiUKEqnM5ihaVnBqKxwEyPLqMzBqXcHqCe85WZjeyX
         4Xi6neCT47iRXCEEj51oa56gBGTXj4mP2dXtsCdQysbhDOdrK2XoWEt2W5Zq58wTjSgp
         sf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xznif/MH/M9aiazIt+TNwkIsOPRFEi4pc4I4E7feLW4=;
        b=WEDzpEOJUA8q/HXHS6uVXDDkbVZtGnYhStRC+LI8yYC/qCCwAWgnC+Rb/KvufJkw5r
         kU3M/4ebbKUyfoKaQMEG/zzfp/yW7gBz5DecTMwgvok7JD55nMIWq2ohJj6yseRKLRnf
         /TzEm2AGCMN7fHNuBDVpDs3YuRry9xDBb2P/uHzboLu/EQ7ZnUjVFKDCUOTL65aQ3vpQ
         Ue1keOAZYh0Sa+E4/PTxZvCfkWLbqvmoZ4xaLwSALGoToJQyL3xuKvVXGqXtuKGnUdum
         TU3b9ZtNQcsvoiqw/QhX4En2HD6z2aO/AitS1BSQbh3thRlIJXS+EuzlZV65KREunEvW
         EhiQ==
X-Gm-Message-State: AOAM530XR7XWgIgOhg+gBsrhPgzvcdXZXe1j537ApC5ThJILc+vEqx5V
        ZqvyJlPOa/q6LrKw/zPf0GwOJQ==
X-Google-Smtp-Source: ABdhPJz5xMvEY9p8BlcNg5+yfUOg7rpIqdqRGBYPoR4/ELJyxsX1WBqLykwzflMtZ5F7GPdFvcZwAg==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr4946180wrw.196.1617209642816;
        Wed, 31 Mar 2021 09:54:02 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1573:1dd5:899d:6362? ([2a01:e34:ed2f:f020:1573:1dd5:899d:6362])
        by smtp.googlemail.com with ESMTPSA id w6sm5388004wrl.49.2021.03.31.09.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 09:54:02 -0700 (PDT)
Subject: Re: [PATCH v2] thermal: cpufreq_cooling: fix slab OOB issue
To:     Michael Kao <michael.kao@mediatek.com>, fan.chen@mediatek.com,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        srv_heupstream@mediatek.com
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        brian-sy yang <brian-sy.yang@mediatek.com>
References: <20201229050831.19493-1-michael.kao@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b3616c67-c65e-d145-c9a3-e6c209849266@linaro.org>
Date:   Wed, 31 Mar 2021 18:54:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201229050831.19493-1-michael.kao@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/12/2020 06:08, Michael Kao wrote:
> From: brian-sy yang <brian-sy.yang@mediatek.com>
> 
> Slab OOB issue is scanned by KASAN in cpu_power_to_freq().
> If power is limited below the power of OPP0 in EM table,
> it will cause slab out-of-bound issue with negative array
> index.
> 
> Return the lowest frequency if limited power cannot found
> a suitable OPP in EM table to fix this issue.
> 
> Backtrace:
> [<ffffffd02d2a37f0>] die+0x104/0x5ac
> [<ffffffd02d2a5630>] bug_handler+0x64/0xd0
> [<ffffffd02d288ce4>] brk_handler+0x160/0x258
> [<ffffffd02d281e5c>] do_debug_exception+0x248/0x3f0
> [<ffffffd02d284488>] el1_dbg+0x14/0xbc
> [<ffffffd02d75d1d4>] __kasan_report+0x1dc/0x1e0
> [<ffffffd02d75c2e0>] kasan_report+0x10/0x20
> [<ffffffd02d75def8>] __asan_report_load8_noabort+0x18/0x28
> [<ffffffd02e6fce5c>] cpufreq_power2state+0x180/0x43c
> [<ffffffd02e6ead80>] power_actor_set_power+0x114/0x1d4
> [<ffffffd02e6fac24>] allocate_power+0xaec/0xde0
> [<ffffffd02e6f9f80>] power_allocator_throttle+0x3ec/0x5a4
> [<ffffffd02e6ea888>] handle_thermal_trip+0x160/0x294
> [<ffffffd02e6edd08>] thermal_zone_device_check+0xe4/0x154
> [<ffffffd02d351cb4>] process_one_work+0x5e4/0xe28
> [<ffffffd02d352f44>] worker_thread+0xa4c/0xfac
> [<ffffffd02d360124>] kthread+0x33c/0x358
> [<ffffffd02d289940>] ret_from_fork+0xc/0x18
> 
> Fixes: 371a3bc79c11b ("thermal/drivers/cpufreq_cooling: Fix wrong frequency converted from power")
> Signed-off-by: brian-sy yang <brian-sy.yang@mediatek.com>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

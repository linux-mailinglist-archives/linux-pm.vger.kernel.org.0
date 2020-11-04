Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7DF2A6315
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 12:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgKDLPF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 06:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgKDLPE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 06:15:04 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3555FC061A4A
        for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2020 03:15:04 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s9so21590438wro.8
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2020 03:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jeMweZUNbUX5xy7afLBKAbFJ+XGDZ/7f4ATvhlknOiE=;
        b=x4CoBlrHQoxPBxdN3h+ODMWfyWGwYjrXWz7X2xPcvgbZ/E//M2/D+NgZFXzP8x+lTt
         EGsKemyQLNYnQkOkqr+4gHOi/o5dGtqgCgak3DC6frcZ9Q6rM90Mki8a7jCrbLIbApAd
         SKBTwEbQ/ndCZw2Yo0nR+Z4poWTtzj6GUb+xS8xDphubPrrtAYSYxwGeBhxyH1H/S5jJ
         u0MR32nvU6ndWFAe9muRzqA3RtB+X8yZ5zsCPuPrFAtPY3JBClmUI3DPJ/UFtKafTR/a
         r7UY628knjMmMEKT5o56WqeAptCGvDtuBmXtuYHhPvd909MxGHB0L7SdRaAwuuSRoKTz
         ctjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jeMweZUNbUX5xy7afLBKAbFJ+XGDZ/7f4ATvhlknOiE=;
        b=l7SJkZsbcNO+Wxs8Hc+BW9u5EAyuWaHr6efpfnqo02V3LW2zrriZMiaUu0okTaoVoS
         b+qqF4BfH/DIcJKxKyAih6xlK4qwC2gVJfMJhC7RLayez24JTYcvakZJJP5EHQhcqozK
         GCAHD/4D89ZUTDkhbuNxuQFNFM6Z/Clxl3NBUJyyCQim6rj3ZhuVSzHptyAP+4Vqvl9B
         KG22crd0iVnkn8CJS0flNniV/NZofuDR5RBzNa98cs+xfBbq/cJduTQgbcQZQg5cm+l6
         gdD7nhjJTe8au5w++PEkp8WgIucuxHG5kGBmANpemRNLzPfmwR1w1Di5sqw5kTnV7l/X
         2xvw==
X-Gm-Message-State: AOAM532DuzP4GGKljN1ZUtURtURtPoVxrFCfELTBWOjw2lnTj/dkaC9Q
        9QobEWLWn7KWPFVDyW9hiZbnOA==
X-Google-Smtp-Source: ABdhPJzRUHCNVTLaeEzmCciwB9DjySmQ+hU7sK+DxC+GZ0/rKmuW13HzVAGT4Shgm0YLTjCiu5pjSA==
X-Received: by 2002:adf:e447:: with SMTP id t7mr31300398wrm.384.1604488502840;
        Wed, 04 Nov 2020 03:15:02 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:9024:99cb:b881:4beb? ([2a01:e34:ed2f:f020:9024:99cb:b881:4beb])
        by smtp.googlemail.com with ESMTPSA id y11sm1694491wmj.36.2020.11.04.03.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 03:15:02 -0800 (PST)
Subject: Re: [PATCH 4/4] powercap/drivers/dtpm: Add CPU energy model based
 support
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steven Price <steven.price@arm.com>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <20201006122024.14539-5-daniel.lezcano@linaro.org>
 <e8feea30-e5d5-9504-a42a-99fde9fdd64a@arm.com>
 <ebdd4728-9105-49ef-e2a6-a17c2a502f34@linaro.org>
 <58408860-1add-c7a3-4c7e-eafb0b6ae16c@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <74ab112e-d465-2e2f-84b6-23f968130998@linaro.org>
Date:   Wed, 4 Nov 2020 12:15:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <58408860-1add-c7a3-4c7e-eafb0b6ae16c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/11/2020 11:57, Lukasz Luba wrote:

[ ... ]

> Let me go again through the patches and then I will add my reviewed by.
> 
> I will also run LTP hotplug or LISA hotplug torture on this tree,
> just to check it's fine.

Ah yes, good idea. Thanks for doing that.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

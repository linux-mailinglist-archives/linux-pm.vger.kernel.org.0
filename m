Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2413539AC
	for <lists+linux-pm@lfdr.de>; Sun,  4 Apr 2021 22:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhDDUMa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Apr 2021 16:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhDDUMW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Apr 2021 16:12:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5490C061756
        for <linux-pm@vger.kernel.org>; Sun,  4 Apr 2021 13:12:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v11so9231737wro.7
        for <linux-pm@vger.kernel.org>; Sun, 04 Apr 2021 13:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oyHxbO3PUNNiO9rpGkiDw/KLrdxxFq2h9NV2xELqAZI=;
        b=qhRLFfFI3kt0wDjaLQK4K06CrUrjQt0wOzmG1OBXj+KCe2Kfbfa8Q3ZaCOv2U0jyLj
         q/yHkhYKUnyb1gMWQMvJfzK/D4W7Xl3Dxb3e7mvr0kQkuvXmha4bGVXYu2B5sxz9mXVi
         bOx45c1f88gJC6iBp7Jz1basoQ0DfxdFkVUpi10TGy6LcJrVdN9IlVuCbHayBPATqEcP
         Dla+HKiJdo+CLPrO1RwaWkZcuJ2C8CZ35ztcLJZhkVCY+jgGD6RrHztG3H6ZtJVhAdQr
         Ol2ob46wvz3NsyhLe46wBWrupVGMhWSXZq9QxH47LPpLd+pxuqnJa1Cne4+UnXNGLkIc
         OmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oyHxbO3PUNNiO9rpGkiDw/KLrdxxFq2h9NV2xELqAZI=;
        b=gRoNoaswWhV29OpZaHUX6SnPS7yu+p+UEpCJLhxdF7TPoYg44ZyvInU2VtNoT5G5cq
         Fm0savLH1HRCoTGIj8RXrIq+ei5PG8rrY3vMVCSoRNJl627Mt4oOkmOnJsiRkdOV8STo
         E1w65xIStH+ztkm3oxCImaAM7C5w5w31Hva+h3YAXOKXe7nx9D2uUKnvOjc6zedAOD+W
         zfnUVzisXEFnoGOjKByag+dQLXTN56N45od5PFX7ZzdfOqJBuhpWFvIPyDmGgYj5BiPi
         RFwQRgLucUHAVHg6Z3eiepG3voE0IWCnBncQldSbC7WT8K/CpEs9ME/v9XNsN3H1MbAi
         vpuA==
X-Gm-Message-State: AOAM531UKgKWSwSEVL3yldy8gbhk7efg2njDT6hgzIpbER29kj22elRj
        0026rVX3WNTaRTpGJxRi2QYDuQ==
X-Google-Smtp-Source: ABdhPJyhO8r8scHjRFIav4WlBDVzxSBbX4cqENuJU1BEdQ9L9gMjYA4KXNY7MjY0BqyrkKCwGCJHrw==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr26758160wrw.196.1617567135377;
        Sun, 04 Apr 2021 13:12:15 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6d68:6b9a:7a3c:4a9f? ([2a01:e34:ed2f:f020:6d68:6b9a:7a3c:4a9f])
        by smtp.googlemail.com with ESMTPSA id 21sm21237319wme.6.2021.04.04.13.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Apr 2021 13:12:14 -0700 (PDT)
Subject: Re: [PATCH][next] thermal/drivers/devfreq_cooling: Fix error return
 if kasprintf returns NULL
To:     Colin King <colin.king@canonical.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210325172148.485259-1-colin.king@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <101b8460-6488-88f7-9ccc-3af2c694cb48@linaro.org>
Date:   Sun, 4 Apr 2021 22:12:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210325172148.485259-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Colin,


On 25/03/2021 18:21, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when kasprintf fails and returns NULL, the error return -ENOMEM
> is being assigned to cdev instead of err causing the return via the label
> remove_qos_re to return the incorrect error code. Fix this by explicitly
> setting err before taking the error return path.
> 
> Addresses-Coverity: ("Unused valued")
> Fixes: f8d354e821b2 ("thermal/drivers/devfreq_cooling: Use device name instead of auto-numbering")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks for your patch. It was already fixed after being reported by
kbuild-test.

  -- Daniel



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

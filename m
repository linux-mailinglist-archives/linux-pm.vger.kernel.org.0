Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D6624F301
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 09:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgHXHTv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 03:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgHXHTt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 03:19:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8B7C061574
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 00:19:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o21so7172046wmc.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 00:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A4jrcUKhNyq6Ips6PWENqMHRhy4MlDm4qFkTIUeY6sU=;
        b=Zh2M+CReCdB2DseDfEg+S/ILDu5sh9phoSgnmyvis+VRzOt3gmJamiBVybr2DBJ0BY
         cikhFUufbOjs789a2MCxgb3HIjF5D3/xa9DbYXZ0kRAf8tfyA2EUfVcpGdTcK+FZOJ3a
         rjti/cvJ4St0QbexsEFngNr4lWMcMRkIyU1WhRatyXjQh4bPiTByH5oXVqfnHTU/AiuU
         gZAwrZL92ny/djvuJ23htyoYiQ7ATW6XAODpulq8J8gGmAaE3lUt49DwuCXZgQiTVgz+
         vMXraotcCTAvaMM2+fq3QYvAxb/HA0ah5c3QYsx4ZXyMlPXFLS/5OA0QGc7MwEeo0NbG
         Wi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A4jrcUKhNyq6Ips6PWENqMHRhy4MlDm4qFkTIUeY6sU=;
        b=U8SjrbxFXVqqNFsr8Fj/wxvaBpXapRkzK6q2K5m10q455h7rDY1QAiE5yk2jtBEpPa
         MXHg3k/+ZbrNhur3M7yrZJrZZwt5a1OELUAy7nPJaYBmvaX+CfUuS+0yenU746jOCFJw
         FnOlX9owGeyMckMzKhEQx6iL7eGScFjHekLJLWcpOmvXdsLlY/OVFEH0836llY1qGinB
         GwPF7c/6QSjPlXdG/FWiFzEUUxBxSGpDfy8Urtnpa6U7u2lZo1Tbtb97081k5hFT/rMv
         28eZUUUK0Q43ZUjUlQ2+AVvYXlPYoVkvn/V+oIqn1NuIoa4dgqRb4b/6+vYqsN9Dk15n
         RmTg==
X-Gm-Message-State: AOAM532OPWcSEWx1DSi++ZJHCfZce/fHvJ7Mpnd4OCIhoA8lrsHjSeyy
        jYLCh+CIuaS4GVzQrcTliBNyjfHomrkKfg==
X-Google-Smtp-Source: ABdhPJxSuUa0KM13DRe5+ateKWf+FPyJpUyDzLii4cr5Vd9MNz3oLrpbagXrGXXemMNa/KjKiddxrQ==
X-Received: by 2002:a1c:16:: with SMTP id 22mr2436523wma.75.1598253587747;
        Mon, 24 Aug 2020 00:19:47 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0? ([2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0])
        by smtp.googlemail.com with ESMTPSA id u13sm7501851wmm.20.2020.08.24.00.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 00:19:47 -0700 (PDT)
Subject: Re: [PATCH] drivers: thermal: Kconfig: fix spelling mistake "acces"
 -> "access"
To:     Colin King <colin.king@canonical.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200810082739.48007-1-colin.king@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c317ce98-c20d-3c24-2f77-1758dc784de9@linaro.org>
Date:   Mon, 24 Aug 2020 09:19:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810082739.48007-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/08/2020 10:27, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the Kconfig text, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

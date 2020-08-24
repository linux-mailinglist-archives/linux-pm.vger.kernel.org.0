Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822E024FB59
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 12:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgHXKYz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 06:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgHXKYx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 06:24:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9EBC061573
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 03:24:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c19so5835696wmd.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=88rYNQO2vAuDbFL4Zr72VxhSTkJHDLHyFALUrY1Jx3M=;
        b=S1rAxllXM8NmPWqTNAmPrqYQEaexd4ibOI1M/i/ad7A8sJ2B6eoQ7qBSleoFR+BlrU
         L1bJX+VHzrJmu9LITcGjyY0EyypTmu2+sYEQQ5NQKx4EtWBKX3D9M1rhSdsow5v2sX+t
         Hdgr5NwTyozcpRr3eVpj5M/KNiZLuVC+skcK6n2sEF1CZRWi5cDbsmw3aOwOro+UeaL6
         yRvsdfjsUfqvF4zxrEgv53v+D/QUvjr5UwFcomJbqOzza0z9q/oeQtSFsiPTLBHHWJyT
         vuR3yCo38ZZ7b2IaZFmbikf8RzrcUJk1QN/IsVQi+5ZiZqVJYZxLiUI14RYoIqvpnCqD
         anHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=88rYNQO2vAuDbFL4Zr72VxhSTkJHDLHyFALUrY1Jx3M=;
        b=CY5VoLamGvcyitjuPnfgH9LkVCNdaQuEtlqIe+QgiGqEQthR37Gad/7j3w7GA46KDK
         6fyLqYTbucImnmTKPIk8WdmjLim1VfwxocS4LUb+tMuzqMGzeiKaDjQiE+hB/0nJWWVg
         L2gBXuUIbB6mLQMqPEwfGEZpEuaaC8mR5yMT0gXhFIAl+N00CF4+Migr/PROZxMkpi5Z
         5uTzKsr+EAm6YYlVxtFr0682l7GblMJ+y9m5bFGu8Bl2qgkW3kpRavPsX3eEkB13nVau
         ++oPAkWd1IzHZJWAo9O7jK2YWoVxXMceSMzo3LRFI5s7REjj0KoEpAEi+86UPNMIxb1M
         nSfQ==
X-Gm-Message-State: AOAM533CqXzLqnqhdsOYvJsEKxWWJx3HIar07KPvIWWA6/smvnRsc4P+
        9bggSRrxT1acy9J95AKWHUxmfYwCIrjYEw==
X-Google-Smtp-Source: ABdhPJxy1n0g9PPSIDLHf5eSbRYiS7nJgwvlr6lxepatUt463NPbrkwL8lnKckTfYI9SzzzufHTm4A==
X-Received: by 2002:a1c:a506:: with SMTP id o6mr4907792wme.3.1598264692147;
        Mon, 24 Aug 2020 03:24:52 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0? ([2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0])
        by smtp.googlemail.com with ESMTPSA id l1sm24669111wrb.12.2020.08.24.03.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 03:24:51 -0700 (PDT)
Subject: Re: [PATCH] thermal: Use kobj_to_dev() instead of container_of()
To:     Tian Tao <tiantao6@hisilicon.com>, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1597799671-11530-1-git-send-email-tiantao6@hisilicon.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f418b13f-15cc-6b43-4544-1284f935e099@linaro.org>
Date:   Mon, 24 Aug 2020 12:24:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597799671-11530-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/08/2020 03:14, Tian Tao wrote:
> Use kobj_to_dev() instead of container_of()
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

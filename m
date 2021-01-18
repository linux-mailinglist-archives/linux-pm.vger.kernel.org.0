Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2108B2F9A3C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 07:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbhARGzj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 01:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbhARGzY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 01:55:24 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE32C0613D3
        for <linux-pm@vger.kernel.org>; Sun, 17 Jan 2021 22:54:24 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l23so9144065pjg.1
        for <linux-pm@vger.kernel.org>; Sun, 17 Jan 2021 22:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a61NDNRzrCDZjz9aAYnQH4fNU8BSU7I4o70F6b9RjWQ=;
        b=ZBp40ApONg5hlyM8Nk7lAci6DW4m+WmlSRC9QlC6GDBguXEjpMxSGY8CcXyGnRNU8m
         HgC08/FNRTgxB2Z/WVwSmVjPLsT1dWeGNvj6lM7qWlGj862MZrj9U0A04sNvjVO+Jbzx
         DVuY2fgRsHt63/AWb8q0p2YL0PkeDK6ZYgH4aHf5h89FHxGI+6e9feRBanMik5hnZTOz
         CGK/kYsOx8L8HpwdII9250VeS7/TqOKv3l5zcHVtP7ldcnFLs5o2xJQEjQne0NzKsMra
         Hve3vixCiO3CZ0mm1qr7PMXgSVBX+TLgX0OkflxfdhgbQ3UAesJS3C4VQQVJxN4r27o6
         MMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a61NDNRzrCDZjz9aAYnQH4fNU8BSU7I4o70F6b9RjWQ=;
        b=H9wYg/BURQNtmU1lzzoXfXmlPuPoAUN7thzbu5RPe+lYfxv/dlBL3okRyq+zcFWz4W
         GWWnGnhASiREyVPoqndg+C6elctrKe0q5sdKPYZvpnltyZ7cMMsS8hy5z5SojsHH4g50
         4/NhhBE/sPoyWhN1BAHPDzpZqIrk58y2vgkLEYa0bztXhuyEozq5Q+DegxWGWcEhWLQo
         KDOTzH6tHOcpxdM6lMS77x5aCqrzUnR5QL67v7iKqq7blt7BvNqTRmZwaWtNocthiR+y
         pbM8L+VaNV6aIfA9gT/XmVSsBP3aAmGh1XFX0Kg8ik02g9fZTyOnpYTvppYhJ6OqXfd0
         MALw==
X-Gm-Message-State: AOAM532evmxs1u2O5xe+2p2VGFIcWdid9QgEle4QCCdS7qvoTGXT0Zx7
        PxSMUOxIZhpJKqV2fK/DEWeHVw==
X-Google-Smtp-Source: ABdhPJwYtAGso1N2TmtCrggR0shnn3HjmPjH73YcgokUM5OA+NDMCJ0zZVt6nNgCaedNZkTsPsumBQ==
X-Received: by 2002:a17:902:c106:b029:de:af88:80ed with SMTP id 6-20020a170902c106b02900deaf8880edmr3614590pli.35.1610952864312;
        Sun, 17 Jan 2021 22:54:24 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id p13sm14049072pju.20.2021.01.17.22.54.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 22:54:23 -0800 (PST)
Date:   Mon, 18 Jan 2021 12:24:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        rjw@rjwysocki.net, f.fainelli@gmail.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cpufreq: brcmstb-avs-cpufreq: Fix some resource
 leaks in the error handling path of the probe function
Message-ID: <20210118065421.x5s54evpafq73ouk@vireshk-i7>
References: <20210117142635.568686-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117142635.568686-1-christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-01-21, 15:26, Christophe JAILLET wrote:
> If 'cpufreq_register_driver()' fails, we must release the resources
> allocated in 'brcm_avs_prepare_init()' as already done in the remove
> function.
> 
> To do that, introduce a new function 'brcm_avs_prepare_uninit()' in order
> to avoid code duplication. This also makes the code more readable (IMHO).
> 
> Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v1->v2: be less verbose when writing the error handling path of the probe
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

Applied both patches. Thanks.

-- 
viresh

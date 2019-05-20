Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEACE22AF4
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 06:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfETErI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 00:47:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43218 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfETErI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 00:47:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id t22so6126591pgi.10
        for <linux-pm@vger.kernel.org>; Sun, 19 May 2019 21:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=znPD6qSCRqBSVISTFwv2IDS0tUXtYPowDMtFJwfIVG4=;
        b=S6RC8/KF8MMJum/v07irupW0Jzz5U1cWZxnJgMBycQ7J895LZbEdp2S6H280gXSoa0
         SJ5+zv7fSANzrQNVh5LnV0BQn9+ZCCh0UNQnRg6VIf68xhokxw9TRlKz8vZ3/u0h7zq9
         oOhxl34eO8SRYCHxm57SuDWotd0GD9ObvR+77sI12lTOU4dHqSZjOWPMIMQYBpTQUS/f
         t+vlbGUb6r/jcyjTS9A5/DVvxWSHfBLDeTq1EPzFNxc/gvD4wFXOtLXUGJVEsGOG6BoH
         VcfIbzffj7ppyKXxEua+4ulXi/67rNtwR0vWGY1TmVrciBOjTa8cWJg5zsyHXsctJQ6W
         eJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=znPD6qSCRqBSVISTFwv2IDS0tUXtYPowDMtFJwfIVG4=;
        b=W9JvcpftNN1YRHIXXUP5QeiEZ9MOOAhKiePY36SGNNeP+paupYpJ9D9dnQCDlqhjLj
         a5QZq+C5q0h3Xn5ien/L13xm10tVPJmsTtS+0gKZAYRRPEqU8UF9bsnnjpqlnelxSKEF
         WyWJRu/cHrjFs6c0RR9g6uejszjlfLvIBqb/gwpvQQKx5D1bxQ1mKg+nvVOiQrD370t7
         D8kQOWt1uH4im/d4KvZZ/IMKMQNW0zQ+XKtEtClHh8LhzRJo/zmvwYCtMZ70jaZBW+hU
         FDCVLNVNKUvtjjFy0EHB3DuufmlAvlVPM1wSwESavoJyIzE501odQKkk5izONTqlKsuW
         ue0w==
X-Gm-Message-State: APjAAAW6ptEP0lJGoBcVozzzVFix6XivXrT+jO7XWq2u0q97k+7bkgyv
        hGfvaJlnBTpjNtLYbr3+Oich+A==
X-Google-Smtp-Source: APXvYqw2fylBLzNgfG8L7skLbYmkylnXBeuW32Xv1x+By0k9dxCCF49gfY26D3/iHYdXTo1cfNHHCQ==
X-Received: by 2002:a63:1c4:: with SMTP id 187mr46179260pgb.317.1558327627746;
        Sun, 19 May 2019 21:47:07 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id s28sm22716058pgl.88.2019.05.19.21.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 21:47:06 -0700 (PDT)
Date:   Mon, 20 May 2019 10:17:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, fan.chen@mediatek.com,
        Stephen Boyd <sboyd@codeaurora.org>,
        Roger Lu <roger.lu@mediatek.com>
Subject: Re: [PATCH 6/8] PM / OPP: Support adjusting OPP voltages at runtime
Message-ID: <20190520044704.unftq6q5vy73z5bo@vireshk-i7>
References: <1557997725-12178-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1557997725-12178-7-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557997725-12178-7-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-05-19, 17:08, Andrew-sh.Cheng wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> On some SoCs the Adaptive Voltage Scaling (AVS) technique is
> employed to optimize the operating voltage of a device. At a
> given frequency, the hardware monitors dynamic factors and either
> makes a suggestion for how much to adjust a voltage for the
> current frequency, or it automatically adjusts the voltage
> without software intervention. Add an API to the OPP library for
> the former case, so that AVS type devices can update the voltages
> for an OPP when the hardware determines the voltage should
> change. The assumption is that drivers like CPUfreq or devfreq
> will register for the OPP notifiers and adjust the voltage
> according to suggestions that AVS makes.
> 
> This patch is devired from [1] submitted by Stephen.
> [1] https://lore.kernel.org/patchwork/patch/599279/
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  drivers/opp/core.c     | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h | 11 +++++++
>  2 files changed, 89 insertions(+)

This is an rcu implementation which got removed long back from OPP core. Please
align this with the latest changes.

-- 
viresh

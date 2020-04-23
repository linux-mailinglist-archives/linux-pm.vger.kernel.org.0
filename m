Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939271B5F2F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 17:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgDWP3F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 11:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729014AbgDWP3E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2020 11:29:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E59C09B040
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2020 08:29:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so6871346wmc.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2020 08:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K0XwhvnZ5fHku+zX8bB/tqMgI8KM65JG7UKJ1LIe+hw=;
        b=f3HaI4v7q0s0ma9brDtDfqbZ273js/4jOfpcLSe86Rdc4863/LFECt156kdpFRFuFU
         /qAg5B9O+PLzlWP3310ATVRODsMIrhzfM6FRjI2ZfFrQh4TULq2AHJGPyPOzharxZjGs
         7nU7Xz0r39aTzO4K1n1DPslhQOZhvyuKKyIbf0lq4Ckrwalxc66TSGtchPiX+in6/vCG
         TN+C9llUiHzgI7809zQxurlbhQHWjyyCzDT1ymd5TPr0DGAHiwg0sY3T6f3iwZEMaYMz
         GyZiPpsxXPYpGo5h9qA9IliuLqsreuoUyXoDk50xYzX1M3L64josfqN4NbTZNRwbZFey
         lCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K0XwhvnZ5fHku+zX8bB/tqMgI8KM65JG7UKJ1LIe+hw=;
        b=ugIQPFiZBIAh7le7SgcY53e3hbdjL6lM5zb9jgFHxx2/XJiHMEJdCN9q2o4Upeo9ut
         lRz+eWo3Pm1i+tF82nja2NA7fQXcL6O86j0n5kOGgCDS6/bihajiB55CTFRWYjRGptcL
         UpsH22aZCUEil8HORc2/yGS2Q+h1Z9tJ3OECf18+MzyAkcbYvNGYMtXuWKwQsxcLnD7B
         WhQ9a+vQa50IN7zCTXiNn+0a1UiXxmzUyihD54yUGy+EgHW4OYm7EgfrtP186tvynLxq
         HbTC2YFGdr3znyUpGvL3aJphMAnWFC9I8qKPc7bixUVwVmA8yLpagY8gfC8VR2VVWD0W
         r7Qw==
X-Gm-Message-State: AGi0PuaAFQwf8/BNNtxw7zvq0WJvNVtTWL2roN+7qbZAcRwBRJvLbXA1
        4kIVYRgm6ZFxr9Nd9gYnWZxVUA==
X-Google-Smtp-Source: APiQypJgzi6SD42pIpK5DubH9kPf+0CuGHiKBJHzVOd+VDHdvOQf8wEqsCDznBChQjiLenoFM3eaig==
X-Received: by 2002:a1c:a794:: with SMTP id q142mr4732427wme.4.1587655741551;
        Thu, 23 Apr 2020 08:29:01 -0700 (PDT)
Received: from linaro.org ([37.167.216.250])
        by smtp.gmail.com with ESMTPSA id j13sm4361278wrq.24.2020.04.23.08.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 08:29:00 -0700 (PDT)
Date:   Thu, 23 Apr 2020 17:28:54 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        qperret@google.com, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
Subject: Re: [PATCH v6 06/10] PM / EM: change name of em_pd_energy to
 em_cpu_energy
Message-ID: <20200423152854.GD65632@linaro.org>
References: <20200410084210.24932-1-lukasz.luba@arm.com>
 <20200410084210.24932-7-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410084210.24932-7-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 10, 2020 at 09:42:06AM +0100, Lukasz Luba wrote:
> Energy Model framework supports now other devices than CPUs. Refactor some
> of the functions in order to prevent wrong usage. The old function
> em_pd_energy has to generic name. It must not be used without proper
> cpumask pointer, which is possible only for CPU devices. Thus, rename it
> and add proper description to warn of potential wrong usage for other
> devices.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

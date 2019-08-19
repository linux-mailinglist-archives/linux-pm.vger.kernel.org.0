Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41F7191D57
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 08:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfHSGyX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 02:54:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33131 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfHSGyX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 02:54:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so639018pgn.0
        for <linux-pm@vger.kernel.org>; Sun, 18 Aug 2019 23:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sWJlQTSBEOMCh5nB5DH6siEGtKeSyl6ScBGH9ifHyOQ=;
        b=b9uL31NcY/WwfuxOp5cPuq95N14dbd6KNGhcRQNo2BqseqQDuhhLTS571/TXal5NaB
         xcOaeMCtVeOj/u8L7L+NZsxgVrdJ5eJYzHN8KJla1coSoyV8sf87/OTYZHrK9vbw3pbs
         XcebGCvoaXgFduNAwQjASZC5BOB/HWQrCmXlJuK6aMRFtyGHTcypNsGLnmwjFq1v21I1
         VbcM9t0s5cZdQrYwdZbwsuzdURpOYBs9cbs62dJVSete1KAD/KXv8nVB5LimiECaHoPb
         LRbeaQRi/nZvRoVkJ/kEozuG4urdVr/ZKbI4UfeUmf22492iszcEfbytVCcWZaqdMFrs
         Ng9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sWJlQTSBEOMCh5nB5DH6siEGtKeSyl6ScBGH9ifHyOQ=;
        b=uHWHMpk4B7XFv41WIJlnV3+4HXRlxYyfGOvmtcdM3dYfbWkAlv/6pRU6+Qay9GUxsD
         H03PYOMgZRH5a9Dg+vUC4loOgi8jdgfoaxq8MrECUECWmUhdynTI+0wls3ntrvEuvNKJ
         j1XXrsSj6EYYUPTzIKNPcqFGvTNulXxMVASx+JhqvFYbgBuT+rXCr01dFEp5mGyjoP9e
         qpxgYBmAUcnAxY4lGpbHGkDhKnoWyxlnbCe881nOxcfEPhNKI818YqPLiyixGynA97Di
         RqsEw+exe1h/7bju/fud2hMkZ0OFMKXd+bm7b6HRB5CAysxBO2PD2grfye2x3qaVfBWY
         5i9w==
X-Gm-Message-State: APjAAAWmOTTb7AjqXl8lp3MZ5PGq0nLaGMDlV2jZdEXkGKBw4AvhgCdG
        hrlZCLk+P3hKNfxYKp8s9UMBfKg6aek=
X-Google-Smtp-Source: APXvYqyn6XNQMkA+NZOqYySmlT0/AvqE7dviESCrNc+0i71jmW58wFNIu2D2DzIxJxzZuwGu7xo6jg==
X-Received: by 2002:a17:90a:358a:: with SMTP id r10mr19651582pjb.30.1566197662461;
        Sun, 18 Aug 2019 23:54:22 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id m9sm14943320pfh.84.2019.08.18.23.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 23:54:21 -0700 (PDT)
Date:   Mon, 19 Aug 2019 12:24:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     tdas@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, rjw@rjwysocki.net, agross@kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: Update logic to detect turbo frequency
Message-ID: <20190819065420.3ch4cbfdsbbs67rz@vireshk-i7>
References: <20190807114543.7187-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807114543.7187-1-sibis@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-08-19, 17:15, Sibi Sankar wrote:
> The core count read back from the each domain's look up table serves
> as an indicator for the onset of the turbo frequency and not accurate
> representation of number of cores in a paticular domain. Update turbo
> detection logic accordingly to add support for SM8150 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Applied. Thanks.

-- 
viresh

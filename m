Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB4315A2FD
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 09:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgBLINo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 03:13:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34217 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgBLINn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 03:13:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id j7so674725plt.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2020 00:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5/XIkUC5xt608XQA38mKMGkwHHAPePjWb6+7/svVCz4=;
        b=N8yXAYthamMwjGoB3Fqo14OoXi1DjUjzGgv/Dof/FW8plapj2+7o8yLycCw4/BxRPk
         tUyVRH7jnPikfFvLzOv7EXAKF+CeDC52xEYcERN/yCbf8qiMA9Y3MABoxxHE2V/2omSI
         nuAo+Kj4ZgCF6B2zp8NaQzVBwVrwnRgZ+FltMa+k7keAFwwAedCLZB91BUVwh7B4JDVe
         VtmZBKZTaX0ilhcIQ6jPo91aVnO+qoTREGzeDxJjMsputR/ZvFLrf3TxwPgZFy89/m2i
         PqPrys78Ev063Jxp6Wgb4wu8GANjjb/9fFHvQBcZrGsC1wA5vpJGghd3VAxLICUzbHnP
         LLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5/XIkUC5xt608XQA38mKMGkwHHAPePjWb6+7/svVCz4=;
        b=QUftOevCZkAgSwjKRofSX/Y6lFkxiMofRU4AjWYPEEc6iwT3koRW/rjJaPmE+9dGEf
         IoYyQViGdW7eRIdLQaMIo+iwEF9EMvyTd/lrHhzCRTZFfvXU2kJocdlufxB+mKtdhjzn
         xNKPkHzeaOp4zj8kaNWspVxZ2nJJSRIA2fdrXRKhu+wxPtq2KwGskqxxZtsXseXhrD0q
         WQ0OrmbulLQLBepiz+1OoPTed7aEw2DQDPNSJkoocrtQrb+9zTUoprhrc09oEcC2eZkQ
         UULVmYW/lsQnYKhmC3VjKL1vm5ibsgTp7qFIR/f5wUKGfcrgZsMyFIVuN3aUfNv0V/Rn
         CI5g==
X-Gm-Message-State: APjAAAUM7p32dPo8FNuepNHVKjABAig9G5TQPhQHv8dyehCjPCixsGty
        x9mbf7lqmyAiNuJHyzESn7WpQA==
X-Google-Smtp-Source: APXvYqwiwlgquZSrfRRe9GXgzaxQNYsFdG2vBK3QHlEx7aqDRs5dqgE7Z/a58C9Y8QAnnT4cjgE0zw==
X-Received: by 2002:a17:90a:3243:: with SMTP id k61mr8843323pjb.43.1581495223019;
        Wed, 12 Feb 2020 00:13:43 -0800 (PST)
Received: from localhost ([122.167.210.63])
        by smtp.gmail.com with ESMTPSA id 17sm7101028pfv.142.2020.02.12.00.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 00:13:42 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:43:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / OPP: Add support for multiple regulators
Message-ID: <20200212081340.vcfd3t5w5pgxfuha@vireshk-i7>
References: <20200212075529.156756-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212075529.156756-1-drinkcat@chromium.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-02-20, 15:55, Nicolas Boichat wrote:
> The OPP table can contain multiple voltages and regulators, and
> implementing that logic does not add a lot of code or complexity,
> so let's modify _generic_set_opp_regulator to support that use
> case.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

This is already supported in a different way. See how following driver
does this (hint dev_pm_opp_register_set_opp_helper()).

drivers/opp/ti-opp-supply.c

The problem with a generic solution is that we can't assume an order
for programming of the regulators, as this can be complex on few
platforms.

-- 
viresh

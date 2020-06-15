Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584F51F9DF6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 18:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbgFOQ65 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 12:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbgFOQ64 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 12:58:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFDBC05BD43
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 09:58:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v14so2842039pgl.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gBuCFcr1c7ooxiwUbO0ya6INndghv2LyBVNZliL2uGw=;
        b=oejGwdjrw7F/9k7o+lXiX92BL1qKcWDV88mAc1fiU852jJImA+gWVoieEhjlqQ3ryH
         ssfZeisyS3tkrTn4uMfkW8Wyc5f2B4A+g4HPPkxWmIcZeyOXJDBaZSev4HgFISReeM56
         484Eh9oXtcE/h6d8Y/6jXuH0LUrhuQnFV18N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gBuCFcr1c7ooxiwUbO0ya6INndghv2LyBVNZliL2uGw=;
        b=UEvwBm+BV8UQBzGJTgUOEDAg2lmYhtoS4qsx5cR+kL1enad5sUvvV5EOqfr4RYfG8p
         +wCKUcZpnCzhR3JAz+eHmnM6N8Ojor60/PoVFt4bPx4AiC0VaB72LpdY4uzgTItDCDSB
         PvQQE1Unvkwv1dZM5GpHIzA3ntHUhevHWEYwpAjPryTRY6/IQ11ZsLRs3faxeIK2MSH/
         7PZ0kGXt9Lw0AndEYSW/3jlUFPDd9AF+VapkjepM9xZCqFwhHiprB4yWXCR6cZBK9NWZ
         c9/OvTSmmjY/bVUIY7h+3KVBprPGrlxW5MI+o7VSw9HAoZiC9r/ONqeN1Ta8HhiFNDYq
         N2HQ==
X-Gm-Message-State: AOAM531uCYxYh7w8DCk7u9y97Xc/RwrMWU+YgWR5Zdmi5IqpwKWtWNu0
        UfHRlLb0Xsu+iiY7Z1QSIxjZnA==
X-Google-Smtp-Source: ABdhPJxU9Bh85Kri2tWUmfVcR9ufNh16uRs+L3DH1Fs84oxdpMeR1Kn73BIg2cnnMMEi+sNaSAHEpw==
X-Received: by 2002:a63:cf03:: with SMTP id j3mr21673925pgg.24.1592240336288;
        Mon, 15 Jun 2020 09:58:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id s11sm13980521pfh.204.2020.06.15.09.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:58:55 -0700 (PDT)
Date:   Mon, 15 Jun 2020 09:58:53 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com, smasetty@codeaurora.org
Subject: Re: [PATCH v6 3/5] OPP: Add and export helper to set bandwidth
Message-ID: <20200615165853.GT4525@google.com>
References: <20200605213332.609-1-sibis@codeaurora.org>
 <20200605213332.609-4-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200605213332.609-4-sibis@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 06, 2020 at 03:03:30AM +0530, Sibi Sankar wrote:
> Add and export 'dev_pm_opp_set_bw' to set the bandwidth
> levels associated with an OPP.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

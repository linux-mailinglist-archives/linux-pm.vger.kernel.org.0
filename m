Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CD93FCAD8
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 17:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbhHaPbU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 11:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239225AbhHaPbT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 11:31:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562F2C061575
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 08:30:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d17so10829754plr.12
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 08:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/8QKngx6fYNXsVFXUD7bTIuyP3AXKmtCfncJgPUlXPI=;
        b=fC56+C0qMUV2NToCVEr2JQ+mW+2KLQnLhMtgiO+yyGK4Ur9jxb8KUtHA66mMKGpXxs
         JkEXpXSPjcq7Slcubo26ZeFQFgbt+1zfU3ZQS4G61g/Sxjo5xGSPT/gmEIOOOD+2TuAj
         I8jOxkYk7LxEjigOMuC5S2EB0uMxZWQ7HVh98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/8QKngx6fYNXsVFXUD7bTIuyP3AXKmtCfncJgPUlXPI=;
        b=sLY8UEVcFedIBPcr7nTRnkfiTLVlbYGyXQEVI00q4ElVrSQWFbUtbCsle+on/0zy+I
         UrVZM18Dt342Y6G2f/clBeYHiGNegBq3obSo18pNZ37eihIEjIdvDyugiNdm6gmnx5ra
         ieZNq4I48me6X64+d5VcxZAVgKSLjtnCMSSkbvgUOVyKFJwbXeGMkjASMX7VoMkTqwiD
         DK3YRt/t2Sh+eA4OSjUa5D/ZmnVGi4jsEIeyrq/AwF4kBfzD3ByuKWCTiVuOEpL7C+/g
         N5Zs5HcidJs6RGf03ZG1nNjPGkZcHKHp4ggC7sj/WyZ7GOYsKpLRbotNTSqfInmwfq+B
         f1Xg==
X-Gm-Message-State: AOAM531vhonFEaIT+D9DQKz7WbaSLl0+86U5pj1NUegX9DiNlmCfZr5/
        RgMHWQG2IqtUyQzr/8M9RQm7heW+Tpca4A==
X-Google-Smtp-Source: ABdhPJyIV524Xbc92XY555Tmny00GEGV8W56zWD1B0FkYhPwvzmWPRooO++MCwvgJJwBllurndNS1g==
X-Received: by 2002:a17:902:6846:b0:138:eea0:9261 with SMTP id f6-20020a170902684600b00138eea09261mr2824106pln.12.1630423823864;
        Tue, 31 Aug 2021 08:30:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:12d4:6054:aa38:6fe2])
        by smtp.gmail.com with UTF8SMTPSA id g12sm3306711pjh.33.2021.08.31.08.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 08:30:23 -0700 (PDT)
Date:   Tue, 31 Aug 2021 08:30:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, tdas@codeaurora.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc7280: Fixup the cpufreq node
Message-ID: <YS5LDb4KDFx/dRnM@google.com>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org>
 <1627581885-32165-4-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1627581885-32165-4-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 29, 2021 at 11:34:44PM +0530, Sibi Sankar wrote:
> Fixup the register regions used by the cpufreq node on SC7280 SoC to
> support per core L3 DCVS.
> 
> Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

This patch landed in the Bjorn's tree, however the corresponding driver
change ("cpufreq: qcom: Re-arrange register offsets to support per core
L3 DCVS" / https://patchwork.kernel.org/project/linux-arm-msm/patch/1627581885-32165-3-git-send-email-sibis@codeaurora.org/)
did not land in any maintainer tree yet AFAIK. IIUC the DT change alone
breaks cpufreq since the changed register regions require the changed
offset in the cpufreq driver.

Sibi, please confirm or clarify that my concern is unwarranted.

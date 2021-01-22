Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195342FFF7F
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 10:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbhAVJsM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 04:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbhAVJrd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 04:47:33 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE5CC061788
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 01:46:50 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id a20so387963pjs.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 01:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nDZ40u+Mp8IPm4Wsi7MFbKQZch/Ly4a0W1UugbF9hIQ=;
        b=fkfDLhouU0A5F2FETwiwfAofpJcauq2q9o5IuqMLv+NVYWf7kCwrHJJ8GEa4uBeDM5
         UE5+sPSmZs99XOnX29lYF2EEfMavC4L4QKVNqixkT3YKbm0CD8yLcyCEAmA5MT9ywAKq
         fnKcR4zvGnIhS+AmSPYChgqLFNyUg3BG9J/k+/jGvoNc/b23BcsKCbQlasjz0OSIoIem
         B0/Vsa50N2FcPPTeAPfapW59CJhsQXSqduzXWL8x9OHazt82snCtYDzPyimU6sz/kqkY
         QPp48VE6gwNqfCBmyU90yUneKjvzqaMKYw+pdhABLY3PSuKbBJ7q3cvoHUVuE/rXCCUo
         iNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nDZ40u+Mp8IPm4Wsi7MFbKQZch/Ly4a0W1UugbF9hIQ=;
        b=twidXUwj4FINJ0TNCz94wfKP+noJeSlheO2B+hIBrJSQLDBtu/SPF+r1cpebkmDFQl
         kx4/KURzeRkr/Aezgpvg28OrfGUvusDgVwiR+IDA4gDeRXtgtoS1m5ejOi3oivzCRkbR
         Kl7N3imtjn3wtVum4vjakUWBbJHjup3hOev3RU/COo3XoSrUm0y6E2mB+oRKO2vdHsIK
         jDgNZ+bhGaloTS6b3yh9ghMIzISr2UF8UgW+T1rNdg8rZe1x8uW5kU5PmGKCNnzOgFWj
         fgw4MkTfPhYtb8VXa/bBk3xeJ7sIh7z15yC0rE3Gz7Qda22zgc27V4UeoHR9pZ2mGU0L
         WtkA==
X-Gm-Message-State: AOAM531cDC9EwulCeYIP39/Owinx5ztXHFA4URuFx7CUSfWUN5/zLoOI
        U9EzMiKoW1KZkL1N4ebuiJ9kmg==
X-Google-Smtp-Source: ABdhPJzQsA8QTa66wOOHCZzU+Rkjzzm8m5oNtYJEyeuVnprKUJy0lnZxKJLpoIYKd2lT/xbihkbneQ==
X-Received: by 2002:a17:90a:1057:: with SMTP id y23mr4345818pjd.97.1611308809471;
        Fri, 22 Jan 2021 01:46:49 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id c3sm8077903pfj.105.2021.01.22.01.46.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 01:46:48 -0800 (PST)
Date:   Fri, 22 Jan 2021 15:16:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com
Subject: Re: [PATCH v5 0/7] cpufreq-qcom-hw: Implement full OSM programming
Message-ID: <20210122094646.35d6wrbj73jrhk7v@vireshk-i7>
References: <20210121195250.492500-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121195250.492500-1-angelogioacchino.delregno@somainline.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-01-21, 20:52, AngeloGioacchino Del Regno wrote:
>   **
>   ** NOTE: To "view the full picture", please look at the following
>   ** patch series:
>   ** https://patchwork.kernel.org/project/linux-arm-msm/list/?series=413355
>   **              This is a subset of that series.
>   **
> 
> Changes in v5:
> - Fixed OPP table API abuse, in conjunction with the CPR3 driver
> - Some minor cleanups

Tanya had some comments about the driver in the previous version,
please let such discussions close before sending any new versions. I
haven't seen any reviews for the major driver changes until this
version and we are already on V5. Please wait for some time for people
to review the patches.

-- 
viresh

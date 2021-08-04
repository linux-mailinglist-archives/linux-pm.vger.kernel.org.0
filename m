Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BEB3E0B08
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 01:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhHDX64 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 19:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbhHDX6z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 19:58:55 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA79C06179A
        for <linux-pm@vger.kernel.org>; Wed,  4 Aug 2021 16:58:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so6033154pjd.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Aug 2021 16:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AyH5fK9YwykBqKL3r6HFsxoexv4xoxybRmsUgoCLgm4=;
        b=XZQ5XsFA5qv4sJ6dN85gMsh8oqN+4uierylBokXiTKthmL+ETGpBA6gUyMEmTbOWHL
         uv4W9xO8CgDoS+PfMiIIO3IdQIrqaRbW0lTIDfdSusqOU1HfaftoK9TrZsIi+eATCNOH
         iKiHpjNSJfmhjp1DRKl1jDdbCqtP7UhPgEypY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AyH5fK9YwykBqKL3r6HFsxoexv4xoxybRmsUgoCLgm4=;
        b=nK000JVZYdehcDNuPOiM35Id4d1jt/9waAL8KaDhSRYhcIV7FufN3fv1tFwIVdQbU0
         rchuVQWYyk7ONLtG7EyOFQX2Ke88c1w/Wp8BAV5R+HIMI8LkfYLKrBkbkjaQQJhPdfT0
         xXbdyKMSNG0ugWOtUQqueU75TXxqi2ecJZT0TkoomuvGYSHHoGmynaMr96ckJwrHlXnb
         9K11IX6tsZS0QVAuPc6CRXgylCLYXAd85F8N0e7O3evewzMCQkltPxlsGnCo+hJoU/NT
         i8LJ/HdwT6eDHqmFTaUAth8UWY8Qpf/NhoKMn9WWwZVThPwTZuX1NtPAHLXMYHkAELwk
         9XMg==
X-Gm-Message-State: AOAM5315KGmCwlymwxd+1zE5XWKYuqwPVyR7BNdCp5u3/coHb6fzSNJ6
        1Yttw0whbnGzaZxe7l1iwkSIEQ==
X-Google-Smtp-Source: ABdhPJyHkrLrX4KNSdxcJ/Ncu3eMXjGxGupi+NcVQS/LpOIriok0qBjVJHQUGujqxAJcitUeUrgScA==
X-Received: by 2002:a63:4c0e:: with SMTP id z14mr1517251pga.427.1628121521087;
        Wed, 04 Aug 2021 16:58:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:8d26:a358:9898:4532])
        by smtp.gmail.com with UTF8SMTPSA id s36sm4910843pgk.64.2021.08.04.16.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 16:58:40 -0700 (PDT)
Date:   Wed, 4 Aug 2021 16:58:38 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, sboyd@kernel.org,
        robh+dt@kernel.org, viresh.kumar@linaro.org, agross@kernel.org,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        tdas@codeaurora.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8350: Fixup the cpufreq node
Message-ID: <YQsprr4rLVPwVfqR@google.com>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org>
 <1627581885-32165-5-git-send-email-sibis@codeaurora.org>
 <YQsbuN1xyAlCYRqK@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQsbuN1xyAlCYRqK@builder.lan>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 04, 2021 at 05:59:04PM -0500, Bjorn Andersson wrote:
> On Thu 29 Jul 13:04 CDT 2021, Sibi Sankar wrote:
> 
> > Fixup the register regions used by the cpufreq node on SM8350 SoC to
> > support per core L3 DCVS.
> > 
> 
> That sounds good, but why are you dropping the platform-specific
> compatible?
> 

I also stared at this and the patch that changes the code for a while.

My understanding is that removing the platform-specific compatible is part
of not breaking 'old' DTBs. Old DTBs for SM8350 contain the larger register
regions and must be paired with 'epss_sm8250_soc_data' (driver code) which
has the 'old' 'reg_perf_state' offset. New SM8350 DTs only have the
'qcom,cpufreq-epss' compatible, which pairs their smaller register regions
with 'epss_soc_data' with the new 'reg_perf_state' offset.

It is super-confusing that the platform-specific compatible string is
missing. The binding should probably mention that the two
platform-specific compatible strings are for backwards compatibility
only and should not be added to new or existing DT files that don't
have them already. Maybe a 'qcom,sm8350-cpufreq-epss-v2' or similar
should be added to avoid/reduce possible confusion and have to option
to add SM8350 specific code later.

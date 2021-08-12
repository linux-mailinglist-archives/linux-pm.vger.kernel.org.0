Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E013EA808
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbhHLPyI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 11:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbhHLPyG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 11:54:06 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B67C0613D9
        for <linux-pm@vger.kernel.org>; Thu, 12 Aug 2021 08:53:41 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id o20so10995683oiw.12
        for <linux-pm@vger.kernel.org>; Thu, 12 Aug 2021 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=YcXaUw4eDPSG+MibJUQlx8InS98N6ju4q2yiypQBbR0=;
        b=eY2VUXIqGp8kazDeOfHaMJ+g18TUO57eZ+LYouhkM9bLOIZGIQqdthPR9pXUSzOXAs
         JFyAknP7G/UmIXDn2QHn+S62dxwxfp41XkIYXCnsVAo/5CU5rsaPnneRg/+oZz8D7g8M
         DxzXd8KWkIbl6MeMzFskY63SMJLPnlyyMZ3lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=YcXaUw4eDPSG+MibJUQlx8InS98N6ju4q2yiypQBbR0=;
        b=j0d1IvjK+/Q4CMr+nNS5bvVFE+ZKDvOGTheBTN+mGtLqV26V7B3FceAJspYCMF/AhK
         gEvEAu8o0CQSaJGD9wN3cnEWrYCkJ8xdqE/I3Y7qEAa+BIhlWBWWUbGRy2b4lB8xGmP4
         TdDo0MqMEztvU4+aRzhfF7ZjUywC3Iu0gVsLgDyMBZV3OgoDd3KrRfy6YiIXspDdZ+7p
         moU1mXXHMmLlNV1AWldchJxZxtVoJi0K+yEkkJ3re13MGaR1Xb+xcS5u2dz9sLQY/ePj
         rl3patflTNWd020De1LBcL6eOSEj9b7L7rR4GK7dLGp3dmh9QTwevmgaN+wYJdWBZfzc
         ceHg==
X-Gm-Message-State: AOAM533uvJGlv+3zbZA1Y1/kfkqZ0mc0Y1Vaw8CUuctqyni5vy8LhAR+
        YLGBdFCtrDdugupvonmo54Ff/+5qHXBkMVr0Zqpt2A==
X-Google-Smtp-Source: ABdhPJynWHO9zzPKC9hMvlzNYdBNJqkKMc8hbKB5pdaY4JwKaHf1iPyzqrcRrL0iBn+5uP91BLlKpVvZ7fP36VKpn7I=
X-Received: by 2002:a05:6808:2193:: with SMTP id be19mr5050704oib.166.1628783620592;
 Thu, 12 Aug 2021 08:53:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Aug 2021 08:53:40 -0700
MIME-Version: 1.0
In-Reply-To: <1628777955-7198-1-git-send-email-tdas@codeaurora.org>
References: <1628777955-7198-1-git-send-email-tdas@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 12 Aug 2021 08:53:40 -0700
Message-ID: <CAE-0n52=8UnRMRS698TvTKG2bpFHqmLp5r4xc_dmSTA1V269oQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu
 cpufreq driver flag
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Taniya Das (2021-08-12 07:19:15)
> As remote cpufreq updates are supported on QCOM platforms, set
> dvfs_possible_from_any_cpu cpufreq driver flag.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

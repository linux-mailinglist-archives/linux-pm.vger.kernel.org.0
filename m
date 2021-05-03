Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE9D371921
	for <lists+linux-pm@lfdr.de>; Mon,  3 May 2021 18:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhECQVm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 May 2021 12:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhECQVl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 May 2021 12:21:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FA2C061761
        for <linux-pm@vger.kernel.org>; Mon,  3 May 2021 09:20:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h14-20020a17090aea8eb02901553e1cc649so6083806pjz.0
        for <linux-pm@vger.kernel.org>; Mon, 03 May 2021 09:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ky5VBISu+vykToqpdikhJHfiagjLwsfGTGizoIDmNDM=;
        b=XenStAF6BtbZZ1YqYSKpAdhx/9CGmbxAG2diftYlvCMEKqNTW3lolZarsPx8Zhe8Q3
         iOet87TsZRqxMA8DQ7eYxGkdhDJfuswGeup0nkM61FBYdKpoD/yaC7TMPYMc+RQljQ5N
         B2rCPmO9TfnAjxPc6CakCDw4/yKudujwaI0Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ky5VBISu+vykToqpdikhJHfiagjLwsfGTGizoIDmNDM=;
        b=cINzFyM+tXqMtkJHsbSVc/Wkpdu0XXaxFey1CvLrTUI6q1xns1POgzvVl+oOZkeh90
         YL8zRLPR/qSx+yIK2GNgZdBGf6ENDpLksz/fDCDta4EK4MM2UDh6CZUG4kZw7frZMaO7
         bQYpKrLxjxC03mwMj0g27eDiPMkOd5Io0vIIWppBc3mdAmR13k8qyuZm/Z1jQzXQ5dpE
         gstPM0nn15WKrRG8++po16aIZA4TH5uvSX3DlLYRePDE3ZKHyEixW623yRtTbpwhl5mI
         t80493Gwet5DLkp7isnyCI15vGnsFJNAHAxD5x860UjddTUEWm2C/en6xQTA3ftFN0Rr
         YPWw==
X-Gm-Message-State: AOAM531lVZNgI+CZ/KnXGlPCgyA5V6zlPmqbhpnQBL5S67XqhRI+qnC/
        ER3Zfz3cEIV9MPSBF05bRpExXw==
X-Google-Smtp-Source: ABdhPJzFqHJEruMYbvRurZFwgIixqV2VK2vmsewIn9wsezld2yIddak8fRRIlmccBRuOVw5rAh5wmQ==
X-Received: by 2002:a17:90a:6c62:: with SMTP id x89mr13633031pjj.213.1620058847816;
        Mon, 03 May 2021 09:20:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:8584:3fd:2adf:a655])
        by smtp.gmail.com with UTF8SMTPSA id f3sm281160pjo.3.2021.05.03.09.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 09:20:47 -0700 (PDT)
Date:   Mon, 3 May 2021 09:20:45 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        swboyd@chromium.org, agross@kernel.org, robh+dt@kernel.org,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH 1/2] cpufreq: blacklist SC7280 in cpufreq-dt-platdev
Message-ID: <YJAi3etO5bRlEA2p@google.com>
References: <1619792901-32701-1-git-send-email-sibis@codeaurora.org>
 <1619792901-32701-2-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1619792901-32701-2-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 30, 2021 at 07:58:20PM +0530, Sibi Sankar wrote:

> Subject: cpufreq: blacklist SC7280 in cpufreq-dt-platdev
>
> Add SC7280 to cpufreq-dt-platdev blacklist since the actual scaling is
> handled by the 'qcom-cpufreq-hw' driver.

The coding style recommends the use of "allowlist" or "passlist" of
"blacklist":

https://elixir.bootlin.com/linux/v5.12/source/Documentation/process/coding-style.rst#L338

It's existing code so you aren't necessarily expected to change it. But
you could still use the recommended terminology in the commit message.

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1547635C6B3
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 14:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241475AbhDLMt3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 12 Apr 2021 08:49:29 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:37734 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241326AbhDLMt3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 08:49:29 -0400
Received: by mail-ot1-f41.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so12655835otr.4
        for <linux-pm@vger.kernel.org>; Mon, 12 Apr 2021 05:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J78tSLg1dvJjIXmhQ2cWv2nOLeCZGup4Okg9kihENVQ=;
        b=S7NEx4XeYAeMZHoJkRH/QHePzw0FQubdUbL8Ty1zJOjeLZ6LavKm5XhsYJUIJL8WiF
         xRSP7tCCFOzWRr8NqG9fXbgzusARfM6sjooyVcRkAYmvLktvC0I1WQYTzecRpp1Dp143
         ggOwXMaEUo433DPG81nKln0rcKVAjf+vqjyjUhUagF4F0IleH+emXvNvr+BtQlovBXCb
         F0qkOJKz0K90rJJiljUVt4BSmW3WLu8bAsjmvRbxg6qCLsjByHyLuyjTx1ThLd53PXvW
         M1OdGfZDPd7HNswl1Hs3YXcWizUDZ4XyxCUhT9qX7rkm7wvDxz+uhcXVqpfPstDUkHyT
         tKNA==
X-Gm-Message-State: AOAM5333xukyyKBN8K3cmmGhRAeYc3QXrxSK8i+U8r607hixzLMIW1KI
        BtcrzjHAMOicaP/jVS8mv1tjmIdGhaz/+cMErnodDe9/
X-Google-Smtp-Source: ABdhPJxJVIBP/acSungnlFJdcAq8YOEVBM7TIn6nfVX7eYdLkP7eTeHtCxbs0oMYtwsu7KQfU1Vp4uYSlDsFx7aeThQ=
X-Received: by 2002:a9d:5a7:: with SMTP id 36mr3994607otd.321.1618231751068;
 Mon, 12 Apr 2021 05:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210412054832.6wxa7b5weu6upmxb@vireshk-i7>
In-Reply-To: <20210412054832.6wxa7b5weu6upmxb@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Apr 2021 14:48:55 +0200
Message-ID: <CAJZ5v0ggj4LP4D2FXs=CyFAcnfFFyqdjtuQjJ3xDJGNhjp8eSg@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 5.13
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 12, 2021 at 7:48 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains:
>
> - Fix typos in s5pv210 cpufreq driver (Bhaskar Chowdhury).
>
> - Armada 37xx: Fix cpufreq changing base CPU speed to 800 MHz from 1000 MHz
>   (Pali Rohár and Marek Behún).
>
> - cpufreq-dt: Return -EPROBE_DEFER on failure to add table (Quanyang Wang).
>
> - Minor cleanup in cppc driver (Tom Saeger).
>
> - Add frequency invariance support for CPPC driver and generalize freq
>   invariance support arch-topology driver (Viresh Kumar).
>
> Thanks.
>
> --
> Viresh
>
> -------------------------8<-------------------------
>
> The following changes since commit fbb31cb805fd3574d3be7defc06a7fd2fd9af7d2:
>
>   cpufreq: blacklist Arm Vexpress platforms in cpufreq-dt-platdev (2021-03-08 16:20:07 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
>
> for you to fetch changes up to dbbd49bade0548db87ceb1943951dea456af2e22:
>
>   cpufreq: armada-37xx: Fix module unloading (2021-04-09 15:17:33 +0530)

Pulled, thanks!

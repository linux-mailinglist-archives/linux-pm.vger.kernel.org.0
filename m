Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F2F19EBEA
	for <lists+linux-pm@lfdr.de>; Sun,  5 Apr 2020 16:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgDEOMB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Apr 2020 10:12:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33987 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgDEOMB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Apr 2020 10:12:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id f20so2270628lfm.1;
        Sun, 05 Apr 2020 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XleQO4WpERYdOmy1fbpTS+4ISogr+wHW1vFifmpyodE=;
        b=fdc5sH/cRUKo6KAsRvp4eot+aiIc/g0j3762pp9C2VfqdoxdmqNZgdydgkUyiN2A0F
         oqm0IIqKkpAuIQOrPqmltADM6jBPV7vgVfXksDLcDOGGO/v3d70hy2K8gMbo5Fve9+r4
         TWGRS38lmO4IZSspoUc47GIGnpu+oCO4MKv5UfHhRRLR6uYakbBmVw0RFjxqKSFWlFgz
         CAHCYGJGXeKgy9L6abus3eJNYJiMfS9Dci6cDgMC9OQUdGkSWcr5G9Pjzs1EY9tSTAsz
         ze+DpQHiyWaVPQAODkV+Fq96STmwwW/emOunpt+gYcrwn5qVWnPd56XKah9WW7dB8zsN
         nJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XleQO4WpERYdOmy1fbpTS+4ISogr+wHW1vFifmpyodE=;
        b=c1Z/TysVn4VAfGX7DlLD/rSl68L0RQWeMXcZ32K/tlWnf6xQwtEanh5SnJhFF1EQQZ
         OEboRhaInqr5uT0KBbECVF6J+FDQJorblWlfUw4m6ACW1imHsWo0u8G1TlSG0bmCRCar
         CSir7cT0jns8Sy/qTTh5cNh7c5mPqyU5lqF2dMaE5o5nyXvVjwJMLeKewL1ACchVGMDE
         jcR0VTYOuz7GtZ+/ygmHhoJ6SikU8vC4hl0/dSwTJ2uryp6kjGNciz3e2qrpFwW+y6S2
         wN1uMfco+c5w/dq38QzvaRriYpSMoPmuQs9PHL4EPeR4MAxPFhndQ+kb8E/uH6N4fE6n
         kSig==
X-Gm-Message-State: AGi0PubRvQCP1ibWBfwvGuQjbIDWbMvEGbCnD3kNbMe+ouqfjpiWTNqB
        JCIxaOUXDstB20OoD9Vf9B0=
X-Google-Smtp-Source: APiQypLVoKcshv+FiT9j3E9JOCfkZaibdzpWPVu3sNp1yGEE4gobEgWuAA1GCJX39Y527pWDdWS0xg==
X-Received: by 2002:a05:6512:308e:: with SMTP id z14mr10880297lfd.110.1586095918181;
        Sun, 05 Apr 2020 07:11:58 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id m193sm8047452lfa.39.2020.04.05.07.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 07:11:57 -0700 (PDT)
Subject: Re: [TEGRA194_CPUFREQ Patch v2 2/3] cpufreq: Add Tegra194 cpufreq
 driver
To:     Sumit Gupta <sumitg@nvidia.com>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bbasu@nvidia.com, mperttunen@nvidia.com
References: <1586028547-14993-1-git-send-email-sumitg@nvidia.com>
 <1586028547-14993-3-git-send-email-sumitg@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ba12496f-ac27-d4f2-dc69-d0a7e2d58679@gmail.com>
Date:   Sun, 5 Apr 2020 17:11:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1586028547-14993-3-git-send-email-sumitg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.04.2020 22:29, Sumit Gupta пишет:
...
> +static void tegra_read_counters(struct work_struct *work)
> +{
> +	struct read_counters_work *read_counters_work;
> +	struct tegra_cpu_ctr *c;
> +	u64 val;
> +
> +	/*
> +	 * ref_clk_counter(32 bit counter) runs on constant clk,
> +	 * pll_p(408MHz).

Is changing PLLP rate really impossible on T194? What makes you say that
it runs on a fixed 408MHz?

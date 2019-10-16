Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653BDD881D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 07:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfJPF1T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 01:27:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42715 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfJPF1T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 01:27:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id q12so13943017pff.9
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2019 22:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c+hURjTVo/aYLCfa/Hz0445uoq4DnBCPweYQaNg80RE=;
        b=YwMFAoU0heHyDD3IBl2x1cf1ZtcwEVCpkffQekoavrEeeW4lA1h7ksu5E+baEG875m
         /NQrOSXT5b6WEePqqi5KsA2ojc3RGJDXXkFUqDv9QW+u2IyGhO7DpJqzls4jo8vOztPn
         wFLEIdRAB9XNWMneT1KITqtxNPhB4hg7K2L2QLdA1TU/R58JNVLMeWyUz2Xg6BfhVK1B
         V2JoUByRubqBAg/2Q1oBbeFLTAPA4jyc6BXISrwjDmSxZ+fgUK8hJgIK0bSMjROSAgct
         qJ2c2Jk6LRa9rzSy1R+gQuKACuJOnHRUjAyifzTQJvo9dwZpYYbN8SVYPIH78QT7LjvX
         C72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c+hURjTVo/aYLCfa/Hz0445uoq4DnBCPweYQaNg80RE=;
        b=M0pNNEMpS/0cLAz6thrfGhkncN3D+pfnrP1K0f5ntydTf75ROog8Euqld1RXpEOtxa
         7Y4Q+DrZmTnyauIbKmYYt8vJNGwb50gwSUVvoEx9oL161EvH1U549EYsasOUb8STIEmt
         pDcOiEKJ6wp9QpQHyp9jT1sGNWhMwevl+MIyAkGP+kYwOfI2IYVnD5GLJZFG411MLIqD
         rFOgFnXq77yhfxnBB0qNFbU1jv+jCIYkaOvOuH1WSp0/cIH9MWb5Dg5VXk1mA2TodcGS
         sIhof4db9wlcaDZ/vB2OzQ3aUJopM6lVdChX1AuSzsXeDz1UfFGmZlHhO9LTcTjr5yR/
         vV6g==
X-Gm-Message-State: APjAAAWzSndrhk8oqMqjcW5K9u4ya4xzuKaiqItacPqlnEHwGIsCz3qA
        owy9zHCMD02TuGh/FoQwAz7khA==
X-Google-Smtp-Source: APXvYqwrC2hWVKfaRMlzUy8HycPTVMe+xH1vrIClOSut973FStL2ZIohmrOuxo+UhtZHAyb3vUdqTg==
X-Received: by 2002:a63:4d61:: with SMTP id n33mr41993243pgl.158.1571203638688;
        Tue, 15 Oct 2019 22:27:18 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id x65sm18642216pgb.75.2019.10.15.22.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 22:27:18 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:57:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/17] NVIDIA Tegra20 CPUFreq driver major update
Message-ID: <20191016052716.yipztnpg7bcuzhfn@vireshk-i7>
References: <20191015211618.20758-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-10-19, 00:16, Dmitry Osipenko wrote:
> Hello,
> 
> This series moves intermediate-clk handling from tegra20-cpufreq into
> tegra-clk driver, this allows us to switch to generic cpufreq-dt driver
> which brings voltage scaling, per-hardware OPPs and Tegra30 support out
> of the box. All boards need to adopt CPU OPPs in their device-trees in
> order to get cpufreq support. This series adds OPPs only to selective
> boards because there is assumption in a current device-trees that CPU
> voltage is set for 1GHz freq and this won't work for those CPUs that
> can go over 1GHz and thus require voltage regulators to be set up for
> voltage scaling support (CC'ed Marcel for Toradex boards). We could
> probably add delete-node for OPPs over 1GHz if there are not actively
> maintained boards.

How do you want to get these patches merged ? Can I just pick the cpufreq bits
alone ?

-- 
viresh

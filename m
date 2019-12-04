Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 101FD112940
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 11:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfLDK0j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 05:26:39 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:46670 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfLDK0j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 05:26:39 -0500
Received: by mail-pf1-f170.google.com with SMTP id y14so2971174pfm.13
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 02:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uzsef4KJrsS+vISRoINrm5pjWR4MnJsKKjbKbFFAkQw=;
        b=plcbcqfkYNxwTh9QWAJxdbLFK4r7wJFyd7D4RWeG7E7a0ApH3VV3/OG1vj3PObgRsx
         Hs05DsuSr5Q1FtNmT5oEoEgDmPsmc28+kpoANcgCVsc4pdYPjmlCH+78MzURD+7Vb3BM
         vh0LRMUtfzCvdojax+IS7luRhqOzQQgggw5MGfET5RfRdU0+9WunAeqNQOPI1v1EciAO
         fWXlySGPRZU1OIB7Rcmi+n32F4nE5mt7wONwQ4WCCD/s/fjF4IErHM0NynPe+UFoRyn9
         4zcj43XUBWvVdpXBUltIAq8DIHT0rgXEkzVx6KeOHbhiIzOzQ+PQMpeYstvCZz3gTOED
         3b5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uzsef4KJrsS+vISRoINrm5pjWR4MnJsKKjbKbFFAkQw=;
        b=gxW5V25jyuYS15AuDrCeFJOOmJ02QcSS5q7aM7K4ux1//Tn/jhBLT/MAwGP8oUIU6M
         +e1XKqYvXrYW+4EVgYQmJxJZAXhK9Lrhh4TpatOEDgRrzPPLPr8I1eXXmDL4/xGoEUs5
         X/rF/RGrHy6MD/C8j14V3+RQwnO8LUbo9sSzRE3n675r9I3IFTIcLM0ueXQPWMzrKabW
         khiqZDmtvp6kdEdHaA/NAavyELFbIhxDhF8SXzcv4+0cH91EHt8ySlZvmPq/95WVUgbJ
         lM1ZwwMNufaB2kJD2QfMzi8JSWd5YEeWMna/srmMo7Ezy1HRVuf1iMYlPVWhCP8HsxP2
         eq5g==
X-Gm-Message-State: APjAAAV0Ce4VznHiZZ0CQ7vFGlI61fup5f240km3zepNxV9EL6DGA9UQ
        UE6NYkvi8b/FjUg7psn8rLaPTA==
X-Google-Smtp-Source: APXvYqy0xchk5KDlqBbD2ez6El0z37utXxmTy0Z4siJZjd6n2+DLGWwd0SdK8poRbiZV/8sisN14SQ==
X-Received: by 2002:aa7:9988:: with SMTP id k8mr2637132pfh.200.1575455198334;
        Wed, 04 Dec 2019 02:26:38 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id z26sm6727403pgu.80.2019.12.04.02.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 02:26:37 -0800 (PST)
Date:   Wed, 4 Dec 2019 15:56:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sumit Gupta <sumitg@nvidia.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, jonathanh@nvidia.com,
        talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ Patch 1/3] firmware: tegra: adding function to
 get BPMP data
Message-ID: <20191204102635.4umxtgmishlijyn4@vireshk-i7>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <20191203174229.GA1721849@ulmo>
 <9404232d-84ce-a117-89dd-f2d8de80993e@kapsi.fi>
 <20191204091703.d32to5omdm3eynon@vireshk-i7>
 <cdb685a4-4d00-4635-df12-c67a6faa81e2@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdb685a4-4d00-4635-df12-c67a6faa81e2@kapsi.fi>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-12-19, 12:21, Mikko Perttunen wrote:
> Ah, it seems I was mistaken here. Thanks for the information.

Please avoid top-posting [1][2] for LKML discussions.

Thanks.

-- 
viresh

[1] https://en.wikipedia.org/wiki/Posting_style#Top-posting
[2] https://web.archive.org/web/20080722025748/http://www.zip.com.au/~akpm/linux/patches/stuff/top-posting.txt

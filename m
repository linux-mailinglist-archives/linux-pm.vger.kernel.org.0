Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26122DA976
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 11:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfJQJ5b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 05:57:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46248 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405646AbfJQJ5b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 05:57:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id q24so864438plr.13
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 02:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sLCQZl2uZTgyC0e1AE4wxLx4qwv7+sx5Ge5fKPEc3ow=;
        b=EWUpYjUiykFAgXJehiPU2yup8xsN2H+6gnRnd9wKMumIPnBFqlTsMtqXbgpzwt3pnm
         4PCXI636wtQzrku4j4/gFWHOraQPvWSUhaUEjWGQ3wM4Xba0artzZn/Iw3ny6aVNlVFX
         qRBox1w6nzzgJYLaYiAa0vtzMmm5m0+8QMUmci6IyYf3l1JQvaWxdDxv/RpWHg1XNEhm
         gKRLexIUg2QoSvz+30i4ePbfr27D0lsb0zJ3crJ1gINuWfO3IAbq+NKMKNp4+eBwlqcE
         xtgIwXPdeRfxWdhZwFhjMKR183Ky0W1Z9sjZ/P2E30xQP5iWz4fIFCPLHj/e6iNwISW3
         uNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sLCQZl2uZTgyC0e1AE4wxLx4qwv7+sx5Ge5fKPEc3ow=;
        b=b0uDW2I/98hqXhtPbezMSWYTe6qMAGjJnIR4QELbRCieBKFG5d4cuewhlb80KcsFEu
         /fVJN+ecDjz7BaRwxhQDmaVrzGx4k6vrRVnPY4sPNfOwMw6JPOpwC46i+q3IrlE6BUKz
         /PCtCK7jg6qK7Cb3WszWj4dSw7XZKABzl2QRi3St3a+a0XIlKlgzkCGrj1FfeMpoNhNN
         VPdz4pB9CUQIOZkb+adPGVh22xOP3Zz2vKP8u145JqwuHpF1dRIme6IGFYyG54CdLTrH
         Gbzj6jG1D0zqB1XcneZXUhn/H3+Su6gEudSfBoZKkcFqPvRsyTjUYzAm9HiV2632uGnt
         /RrA==
X-Gm-Message-State: APjAAAWCL7x9OddWIolJ+Vpbln0MND7mKBaGdskWKiXjg+iMI6w0nF8q
        Y+tU1i0iqLVEVYNgIXqVShQ3IZL3Ee4=
X-Google-Smtp-Source: APXvYqy/qqLbQIcBtpLWWk2oo5FGRRzCxHrb9Kn+KaBGCJ1gUIfUg0L1YFsSFUFmJgE4MnuSkVSmhw==
X-Received: by 2002:a17:902:9a44:: with SMTP id x4mr3116695plv.127.1571306248898;
        Thu, 17 Oct 2019 02:57:28 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id i74sm2956392pfe.28.2019.10.17.02.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 02:57:27 -0700 (PDT)
Date:   Thu, 17 Oct 2019 15:27:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Message-ID: <20191017095725.izchzl7enfylvpf3@vireshk-i7>
References: <2811202.iOFZ6YHztY@kreacher>
 <20191016142343.GB5330@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016142343.GB5330@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-10-19, 15:23, Sudeep Holla wrote:
> Thanks for the spinning these patches so quickly.
> 
> I did give it a spin, but unfortunately it doesn't fix the bug I reported.
> So I looked at my bug report in detail and looks like the cpufreq_driver
> variable is set to NULL at that point and it fails to dereference it
> while trying to execute:
> 	ret = cpufreq_driver->verify(new_policy);
> (Hint verify is at offset 0x1c/28)
> 
> So I suspect some race as this platform with bL switcher tries to
> unregister and re-register the cpufreq driver during the boot.
> 
> I need to spend more time on this as reverting the initial PM QoS patch
> to cpufreq.c makes the issue disappear.

Is this easily reproducible ? cpufreq_driver == NULL shouldn't be the case, it
get updated only once while registering/unregistering cpufreq drivers. That is
the last thing which can go wrong from my point of view :)

-- 
viresh

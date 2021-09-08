Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379DB4033E3
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 07:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhIHFqa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 01:46:30 -0400
Received: from mengyan1223.wang ([89.208.246.23]:36698 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243555AbhIHFq2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 01:46:28 -0400
Received: from [IPv6:240e:35a:103d:5100:dc73:854d:832e:2] (unknown [IPv6:240e:35a:103d:5100:dc73:854d:832e:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id 34A9D65A02;
        Wed,  8 Sep 2021 01:45:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1631079920;
        bh=skXpqGL8omTvkp37HgQuyUQoLphk9IsJFkc3Fq/tg6A=;
        h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
        b=kZAVUehMGhCegeoX9VZH7FTd8rDLpKPf79aGC7QfgyNfBe32QGh2IhdFHPNagCgUH
         FaSo38n+YRIqmMpD4XsQ9vA+KwPEf7xisg2ku1D9nrXgyuOjfg4XkJKxcC9+QETbOi
         O5PUW5BxiT3+G/KsTxJCgfAIL09J7mvhorxWp4dulNyYJl9RvulzcmAuZ99zBRxyOr
         bk1dg1icAw4X+SiYuLen51Aznq2xtrYeOT22KmszO29lp3g9bCIQgDfHLEJsEE/Xib
         zfLmRVZrSi589pwj/Imi09Wk5rAOJokid9BLvXYYYe8PnHXqOJNUQcK8Q1gfDNnCDG
         K2GUL8iAV+o9Q==
Message-ID: <cc0ea443d738f0e31c47cdc9661b824f27b0020b.camel@mengyan1223.wang>
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Process HWP Guaranteed
 change notification
From:   Xi Ruoyao <xry111@mengyan1223.wang>
Reply-To: xry111@mengyan1223.wang
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xry111@mengyan1223.wang
Date:   Wed, 08 Sep 2021 13:45:08 +0800
In-Reply-To: <7fa77e2239dd87004319a799dbea39988b718233.camel@linux.intel.com>
References: <20210820024006.2347720-1-srinivas.pandruvada@linux.intel.com>
         <20210820024006.2347720-2-srinivas.pandruvada@linux.intel.com>
         <00450b0a9efbfde513ea8b445d31657ce5ac2f37.camel@mengyan1223.wang>
         <7fa77e2239dd87004319a799dbea39988b718233.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2021-09-07 at 18:54 -0700, Srinivas Pandruvada wrote:
> Hi Wang,
> 
> I think this is Lenovo system. The FW sends some interrupts prematurely
> before driver is ready,

It's not Lenovo, but I think this kind of FW bugs exist in wild.

> There is a fix available but We have decided to revert the commit.
> 
> Please try the patch attached here.
> https://bugzilla.kernel.org/show_bug.cgi?id=214329

I can confirm it fixed the issue (at least on my machine :).

Thanks!

-- 
Xi Ruoyao <xry111@mengyan1223.wang>
School of Aerospace Science and Technology, Xidian University


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A86A3B1353
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 07:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhFWFsE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 01:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWFsD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 01:48:03 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58A2C061574;
        Tue, 22 Jun 2021 22:45:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4G8sgW4nkBz9sVm;
        Wed, 23 Jun 2021 15:45:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1624427145;
        bh=sXhcp1RB5kLyzObQe3C2zDzTOXxU5fzWiYuFkRLId/M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ayFUw5sRYFxzw/vSiU7c+4d+5MvSRPkxW7K6N4a8O71m1Vz0TV4kbCeYwsyKnmokT
         Q3y9tZ04R0DGWMmIEDlFkK80T4IpXfn23uUVWj2TA4CpuY6exw+6Xl5MJrKGYt2JNg
         kvQD20DF5hoQHBBKJAB5kG7jN2pD+1rJcKcrKLinJ2aUjKDb1AI1zqQaV9jQhwmGZd
         QjhJaeHofYn+lBWkELBB3MzrOkPpBg28kjf0r/r+CdwPqYP+qJGMgNqVbSnMt5NNF4
         kG13bbr3K6F6ZfK2/pTqgn3W2dNKLHWMvEcSakRMugUtsovkjbZ4fPqDytPGIDwJRm
         lmqwweHUh0nNQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/4] cpufreq: powerenv: Migrate to ->exit() callback
 instead of ->stop_cpu()
In-Reply-To: <e40e57a97735614941e9ca7fa2f221f8db9a12b2.1624421816.git.viresh.kumar@linaro.org>
References: <cover.1624421816.git.viresh.kumar@linaro.org>
 <e40e57a97735614941e9ca7fa2f221f8db9a12b2.1624421816.git.viresh.kumar@linaro.org>
Date:   Wed, 23 Jun 2021 15:45:38 +1000
Message-ID: <87v96516d9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:
>
> Subject: Re: [PATCH V4 3/4] cpufreq: powerenv: Migrate to ->exit() callback instead of ->stop_cpu()

Typo in subject should be "powernv".

cheers

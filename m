Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1813DEE35
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbhHCMun (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 08:50:43 -0400
Received: from ozlabs.org ([203.11.71.1]:35649 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235805AbhHCMun (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Aug 2021 08:50:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GfF8h75d1z9sRK;
        Tue,  3 Aug 2021 22:50:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1627995030;
        bh=+CYpznebU7Ex+1BJ7brPdLmFw2QBMoCXMi1ax8iYBt0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=diDFZ/UfenmPrIxFt+LNqTslMcGHsjOuyv75gr66REdBq+oLb/5HymeyVUlT+ovYR
         NZuZ3QNmrSdsKynLVVkXAgsJbrZrCus8CyRQp2TFqnMWMPK4S45XCHRXJHZW0ydFqt
         M4CVHXu0aQPpuwCVdWg/iyzQeVZFfE+gZw2pTrOi3tGKqzelfsC1+K8LTQ/o0Uj4Fu
         rvXrDmFQb3lLiWAjFR1X5AmsQF7ir3ZBT0ZP2Ra2vhvkYB2GF8D32Tud62zheS1Rox
         uzE+YRMMfvmdEq7FpWmX/ca4K2WokM3RX+Luo8yhjI+09igStqzuPRb77YGRtxrDz2
         FDb3GzWqruBzg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michal Suchanek <msuchanek@suse.de>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, joedecke@de.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 0/2] cpuidle/pseries: cleanup of the CEDE0 latency
 fixup code
In-Reply-To: <162798602812.163057.13114310314725073045.b4-ty@ellerman.id.au>
References: <1626676399-15975-1-git-send-email-ego@linux.vnet.ibm.com>
 <162798602812.163057.13114310314725073045.b4-ty@ellerman.id.au>
Date:   Tue, 03 Aug 2021 22:50:28 +1000
Message-ID: <87o8aeofor.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Michael Ellerman <patch-notifications@ellerman.id.au> writes:
> On Mon, 19 Jul 2021 12:03:17 +0530, Gautham R. Shenoy wrote:
>> 
>> Hi,
>> 
>> This is the v5 of the patchset to fixup CEDE0 latency only from
>> POWER10 onwards.
>> 
>> 
>> [...]
>
> Applied to powerpc/next.
>
> [1/2] cpuidle/pseries: Fixup CEDE0 latency only for POWER10 onwards
>       https://git.kernel.org/powerpc/c/7cbd631d4decfd78f8a17196dce9abcd4e7e1e94
> [2/2] cpuidle/pseries: Do not cap the CEDE0 latency in fixup_cede0_latency()
>       https://git.kernel.org/powerpc/c/4bceb03859c1a508669ce542c649c8d4f5d4bd93

First commit had a bad fixes tag, so now these are:

[1/2] cpuidle/pseries: Fixup CEDE0 latency only for POWER10 onwards
      https://git.kernel.org/powerpc/c/50741b70b0cbbafbd9199f5180e66c0c53783a4a
[2/2] cpuidle/pseries: Do not cap the CEDE0 latency in fixup_cede0_latency()
      https://git.kernel.org/powerpc/c/71737a6c2a8f801622d2b71567d1ec1e4c5b40b8

cheers

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40EA3DEABE
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 12:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhHCKVF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 06:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbhHCKVD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 06:21:03 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F878C06175F
        for <linux-pm@vger.kernel.org>; Tue,  3 Aug 2021 03:20:50 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Gf9r01DXFz9sRR; Tue,  3 Aug 2021 20:20:48 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, joedecke@de.ibm.com,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1626676399-15975-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1626676399-15975-1-git-send-email-ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 0/2] cpuidle/pseries: cleanup of the CEDE0 latency fixup code
Message-Id: <162798602812.163057.13114310314725073045.b4-ty@ellerman.id.au>
Date:   Tue, 03 Aug 2021 20:20:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 19 Jul 2021 12:03:17 +0530, Gautham R. Shenoy wrote:
> 
> Hi,
> 
> This is the v5 of the patchset to fixup CEDE0 latency only from
> POWER10 onwards.
> 
> 
> [...]

Applied to powerpc/next.

[1/2] cpuidle/pseries: Fixup CEDE0 latency only for POWER10 onwards
      https://git.kernel.org/powerpc/c/7cbd631d4decfd78f8a17196dce9abcd4e7e1e94
[2/2] cpuidle/pseries: Do not cap the CEDE0 latency in fixup_cede0_latency()
      https://git.kernel.org/powerpc/c/4bceb03859c1a508669ce542c649c8d4f5d4bd93

cheers

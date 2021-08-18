Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EB03F051C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbhHRNqs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Aug 2021 09:46:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42241 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237797AbhHRNqn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Aug 2021 09:46:43 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GqTgy4TBLz9t2g; Wed, 18 Aug 2021 23:46:06 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-pm@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20210803211547.1093820-1-nathan@kernel.org>
References: <20210803211547.1093820-1-nathan@kernel.org>
Subject: Re: [PATCH] cpuidle: pseries: Mark pseries_idle_proble() as __init
Message-Id: <162929392065.3619265.16135263225670762399.b4-ty@ellerman.id.au>
Date:   Wed, 18 Aug 2021 23:38:40 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 3 Aug 2021 14:15:47 -0700, Nathan Chancellor wrote:
> After commit 7cbd631d4dec ("cpuidle: pseries: Fixup CEDE0 latency only
> for POWER10 onwards"), pseries_idle_probe() is no longer inlined when
> compiling with clang, which causes a modpost warning:
> 
> WARNING: modpost: vmlinux.o(.text+0xc86a54): Section mismatch in
> reference from the function pseries_idle_probe() to the function
> .init.text:fixup_cede0_latency()
> The function pseries_idle_probe() references
> the function __init fixup_cede0_latency().
> This is often because pseries_idle_probe lacks a __init
> annotation or the annotation of fixup_cede0_latency is wrong.
> 
> [...]

Applied to powerpc/next.

[1/1] cpuidle: pseries: Mark pseries_idle_proble() as __init
      https://git.kernel.org/powerpc/c/d04691d373e75c83424b85c0e68e4a3f9370c10d

cheers

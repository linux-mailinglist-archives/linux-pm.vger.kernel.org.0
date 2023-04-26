Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432A46EF401
	for <lists+linux-pm@lfdr.de>; Wed, 26 Apr 2023 14:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbjDZMIz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Apr 2023 08:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbjDZMIy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Apr 2023 08:08:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0335BF3
        for <linux-pm@vger.kernel.org>; Wed, 26 Apr 2023 05:08:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Q5yMM22wyz4xMs;
        Wed, 26 Apr 2023 22:08:47 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     peterz@infradead.org, npiggin@gmail.com, linux-pm@vger.kernel.org
In-Reply-To: <20230406144535.3786008-1-mpe@ellerman.id.au>
References: <20230406144535.3786008-1-mpe@ellerman.id.au>
Subject: Re: [PATCH 1/4] powerpc/64: Mark prep_irq_for_idle() __cpuidle
Message-Id: <168251050530.3973805.3959525808657719536.b4-ty@ellerman.id.au>
Date:   Wed, 26 Apr 2023 22:01:45 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 07 Apr 2023 00:45:32 +1000, Michael Ellerman wrote:
> Code in the idle path is not allowed to be instrumented because RCU is
> disabled, see commit 0e985e9d2286 ("cpuidle: Add comments about
> noinstr/__cpuidle usage").
> 
> Mark prep_irq_for_idle() __cpuidle, which is equivalent to noinstr, to
> enforce that.
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc/64: Mark prep_irq_for_idle() __cpuidle
      https://git.kernel.org/powerpc/c/7640854d966449e5befeff02c45c799cfc3d4fcf
[2/4] powerpc/64: Don't call trace_hardirqs_on() in prep_irq_for_idle()
      https://git.kernel.org/powerpc/c/6fee130204650515af80c2786176da0fe7e94482
[3/4] cpuidle: pseries: Mark ->enter() functions as __cpuidle
      https://git.kernel.org/powerpc/c/88990745c934b14359e526033c5bc1daaf15267c
[4/4] powerpc/pseries: Always inline functions called from cpuidle
      https://git.kernel.org/powerpc/c/18b5e7170a33a985dc842ab24a690fa6ff0f50e4

cheers

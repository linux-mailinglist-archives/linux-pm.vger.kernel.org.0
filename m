Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AA0235722
	for <lists+linux-pm@lfdr.de>; Sun,  2 Aug 2020 15:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgHBNfF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Aug 2020 09:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHBNfE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Aug 2020 09:35:04 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C02C061756;
        Sun,  2 Aug 2020 06:35:04 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BKMT03XzZz9sTM; Sun,  2 Aug 2020 23:35:00 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Anton Blanchard <anton@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
In-Reply-To: <1596087177-30329-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1596087177-30329-1-git-send-email-ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/3] cpuidle-pseries: Parse extended CEDE information for idle.
Message-Id: <159637524065.42190.12857433342577768358.b4-ty@ellerman.id.au>
Date:   Sun,  2 Aug 2020 23:35:00 +1000 (AEST)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 30 Jul 2020 11:02:54 +0530, Gautham R. Shenoy wrote:
> This is a v3 of the patch series to parse the extended CEDE
> information in the pseries-cpuidle driver.
> 
> The previous two versions of the patches can be found here:
> 
> v2: https://lore.kernel.org/lkml/1596005254-25753-1-git-send-email-ego@linux.vnet.ibm.com/
> 
> [...]

Applied to powerpc/next.

[1/3] cpuidle: pseries: Set the latency-hint before entering CEDE
      https://git.kernel.org/powerpc/c/3af0ada7dd98c6da35c1fd7f107af3b9aa5e904c
[2/3] cpuidle: pseries: Add function to parse extended CEDE records
      https://git.kernel.org/powerpc/c/054e44ba99ae36918631fcbf5f034e466c2f1b73
[3/3] cpuidle: pseries: Fixup exit latency for CEDE(0)
      https://git.kernel.org/powerpc/c/d947fb4c965cdb7242f3f91124ea16079c49fa8b

cheers

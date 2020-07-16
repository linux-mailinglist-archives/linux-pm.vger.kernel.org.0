Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE84222308
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 14:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgGPM4U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 08:56:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728655AbgGPM4C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jul 2020 08:56:02 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vPq12B4z9sVB; Thu, 16 Jul 2020 22:55:58 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     rjw@rjwysocki.net, mpe@ellerman.id.au, ego@linux.vnet.ibm.com,
        daniel.lezcano@linaro.org
In-Reply-To: <20200706053258.121475-1-huntbag@linux.vnet.ibm.com>
References: <20200706053258.121475-1-huntbag@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/powernv : Remove dead code block
Message-Id: <159490400609.3805857.11882065929256574276.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:55:58 +1000 (AEST)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 6 Jul 2020 00:32:58 -0500, Abhishek Goel wrote:
> Commit 1961acad2f88559c2cdd2ef67c58c3627f1f6e54 removes usage of
> function "validate_dt_prop_sizes". This patch removes this unused
> function.

Applied to powerpc/next.

[1/1] cpuidle/powernv : Remove dead code block
      https://git.kernel.org/powerpc/c/c339f9be304c21da1c42899a824f84a2cc9ced30

cheers

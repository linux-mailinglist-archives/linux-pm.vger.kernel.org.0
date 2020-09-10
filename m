Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F229265452
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 23:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgIJVms (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 17:42:48 -0400
Received: from ozlabs.org ([203.11.71.1]:33465 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730878AbgIJM40 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Sep 2020 08:56:26 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BnJlT4jccz9sTr; Thu, 10 Sep 2020 22:55:33 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Joel Stanley <joel@jms.id.au>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
In-Reply-To: <1599125247-28488-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1599125247-28488-1-git-send-email-ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] cpuidle-pseries: Fix CEDE latency conversion from tb to us
Message-Id: <159974250748.1017939.3766182148722011711.b4-ty@ellerman.id.au>
Date:   Thu, 10 Sep 2020 22:55:33 +1000 (AEST)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 3 Sep 2020 14:57:27 +0530, Gautham R. Shenoy wrote:
> commit d947fb4c965c ("cpuidle: pseries: Fixup exit latency for
> CEDE(0)") sets the exit latency of CEDE(0) based on the latency values
> of the Extended CEDE states advertised by the platform. The values
> advertised by the platform are in timebase ticks. However the cpuidle
> framework requires the latency values in microseconds.
> 
> If the tb-ticks value advertised by the platform correspond to a value
> smaller than 1us, during the conversion from tb-ticks to microseconds,
> in the current code, the result becomes zero. This is incorrect as it
> puts a CEDE state on par with the snooze state.
> 
> [...]

Applied to powerpc/fixes.

[1/1] cpuidle: pseries: Fix CEDE latency conversion from tb to us
      https://git.kernel.org/powerpc/c/1d3ee7df009a46440c58508b8819213c09503acd

cheers

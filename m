Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179313306E9
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 05:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhCHEib (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Mar 2021 23:38:31 -0500
Received: from foss.arm.com ([217.140.110.172]:59210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234204AbhCHEiD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 7 Mar 2021 23:38:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95019D6E;
        Sun,  7 Mar 2021 20:38:02 -0800 (PST)
Received: from bogus (unknown [10.57.15.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06E3D3F73C;
        Sun,  7 Mar 2021 20:37:58 -0800 (PST)
Date:   Mon, 8 Mar 2021 04:37:55 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/5] dt-bindings: arm: Add cpu-idle-states to Tegra194
 CPU nodes
Message-ID: <20210308043755.llvdsuz2jwvweovb@bogus>
References: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
 <1614838092-30398-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614838092-30398-4-git-send-email-skomatineni@nvidia.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 03, 2021 at 10:08:10PM -0800, Sowjanya Komatineni wrote:
> This patch adds cpu-idle-states and corresponding state nodes to
> Tegra194 CPU in dt-binding document
>

I see that this platform has PSCI support. Can you care to explain why
you need additional DT bindings and driver for PSCI based CPU suspend.
Until the reasons are convincing, consider NACK from my side for this
driver and DT bindings. You should be really using those bindings and
the driver may be with minor changes there.

-- 
Regards,
Sudeep

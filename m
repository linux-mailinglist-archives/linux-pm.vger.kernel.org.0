Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A85B1EADC
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 11:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbfEOJWt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 05:22:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38912 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfEOJWs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 May 2019 05:22:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C126341;
        Wed, 15 May 2019 02:22:48 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBFCF3F703;
        Wed, 15 May 2019 02:22:45 -0700 (PDT)
Date:   Wed, 15 May 2019 10:22:44 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] arm64: defconfig: Enable CONFIG_ENERGY_MODEL
Message-ID: <20190515092242.azcracudtdnruwnz@queper01-lin>
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-2-quentin.perret@arm.com>
 <2f598ea3-752d-0f1d-fd33-f07cda3b7bd0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f598ea3-752d-0f1d-fd33-f07cda3b7bd0@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 15 May 2019 at 10:46:09 (+0200), Daniel Lezcano wrote:
> On 15/05/2019 10:23, Quentin Perret wrote:
> > The recently introduced Energy Model (EM) framework manages power cost
> > tables for the CPUs of the system. Its only user right now is the
> > scheduler, in the context of Energy Aware Scheduling (EAS).
> > 
> > However, the EM framework also offers a generic infrastructure that
> > could replace subsystem-specific implementations of the same concepts,
> > as this is the case in the thermal framework.
> > 
> > So, in order to prepare the migration of the thermal subsystem to use
> > the EM framework, enable it in the default arm64 defconfig, which is the
> > most commonly used architecture for IPA. This will also compile-in all
> > of the EAS code, although it won't be enabled by default -- EAS requires
> > to use the 'schedutil' CPUFreq governor while arm64 defaults to
> > 'performance'.
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks !
Quentin

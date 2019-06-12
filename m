Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB44742070
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407485AbfFLJOB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jun 2019 05:14:01 -0400
Received: from foss.arm.com ([217.140.110.172]:48082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407442AbfFLJOB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Jun 2019 05:14:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1069728;
        Wed, 12 Jun 2019 02:14:01 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 272A13F246;
        Wed, 12 Jun 2019 02:13:59 -0700 (PDT)
Date:   Wed, 12 Jun 2019 10:13:54 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        daniel.lezcano@linaro.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/3] Make IPA use PM_EM
Message-ID: <20190612091351.jet5sew5dnirsapz@queper01-lin>
References: <20190530092038.12020-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530092038.12020-1-quentin.perret@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thursday 30 May 2019 at 10:20:35 (+0100), Quentin Perret wrote:
> Changes in v5:
> **************
>  - Changed patch 02 to guard IPA-specific code in cpu_cooling.c with
>    appropriate ifdefery (Daniel)
>  - Rebased on 5.2-rc2

Is there anything else I can do on this series ? Should I send a v6 with
Viresh's and Daniel's Acked-by ?

Many thanks,
Quentin

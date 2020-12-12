Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097952D89E8
	for <lists+linux-pm@lfdr.de>; Sat, 12 Dec 2020 21:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407865AbgLLUJB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Dec 2020 15:09:01 -0500
Received: from cavan.codon.org.uk ([176.126.240.207]:53748 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgLLUI4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Dec 2020 15:08:56 -0500
X-Greylist: delayed 58674 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Dec 2020 15:08:49 EST
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 2C31741575; Sat, 12 Dec 2020 20:08:06 +0000 (UTC)
Date:   Sat, 12 Dec 2020 20:08:06 +0000
From:   Matthew Garrett <mjg59@codon.org.uk>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] thermal/core: Make 'forced_passive' as obsolete candidate
Message-ID: <20201212200806.GA19048@codon.org.uk>
References: <20201208153046.297456-1-daniel.lezcano@linaro.org>
 <cc2085ca-ada9-d616-eed5-3496889da3bb@linaro.org>
 <20201212035012.GA11926@codon.org.uk>
 <20015331-955b-756f-3dce-4eb78e473704@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20015331-955b-756f-3dce-4eb78e473704@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Dec 12, 2020 at 10:11:31AM +0100, Daniel Lezcano wrote:
> On 12/12/2020 04:50, Matthew Garrett wrote:
> > Yes - what's the reason to do so?
> 
> I'm cleaning up the thermal core code, so questioning every old ABI.
> 
> > The code isn't specific to ACPI,
> > so being able to override ACPI tables doesn't seem to justify it.
> 
> I agree, the code is no specific to ACPI.
> 
> What non-ACPI architecture, without device tree or platform data would
> need the 'passive' option today ?

Anything that provides a trip point that has no active notifications and
doesn't provide any information that tells the kernel to poll it.

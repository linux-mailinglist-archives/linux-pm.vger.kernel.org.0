Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A62C2D9827
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 13:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407519AbgLNMl1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 07:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407257AbgLNMlS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 07:41:18 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE7BC0613CF;
        Mon, 14 Dec 2020 04:40:38 -0800 (PST)
Received: from zn.tnic (p200300ec2f0a470045f2ad4f8d5ac204.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:4700:45f2:ad4f:8d5a:c204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A62F51EC0518;
        Mon, 14 Dec 2020 13:40:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607949636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GEjtONQLztM4l6fqlu0/p/U/N6XQIhTzVwLg91ABImU=;
        b=BENNIPNsDRYudHYbN0ot904umrFe64GAJovJIb9gbrPuMgUsbXmNIfrhti6TgbsIVQmDCV
        fNCewDuF45fiMtsoPpNEjqbYPIxcJHhYv9EZGoiJdRzG/Sbaok8Pcby3/F4/WzzRVt9Xq/
        G/FcXZK8QfehzOTIBFKFMme0p3S2qvw=
Date:   Mon, 14 Dec 2020 13:40:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     Wei Huang <whuang2@amd.com>, rjw@rjwysocki.net, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 2/4] cpufreq: acpi-cpufreq: Add processor to the
 ignore PSD override list
Message-ID: <20201214124023.GA25916@zn.tnic>
References: <20201125144847.3920-1-punitagrawal@gmail.com>
 <20201125144847.3920-3-punitagrawal@gmail.com>
 <cadb5d57-5aaf-79bc-e30e-502d5e522689@amd.com>
 <20201207202610.GG20489@zn.tnic>
 <e9b4ae11-1fe3-a660-bb65-d3ba55ffcc56@amd.com>
 <20201207223057.GJ20489@zn.tnic>
 <87a6unq3xv.fsf@stealth>
 <20201208233216.GH27920@zn.tnic>
 <871rfvoqy7.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871rfvoqy7.fsf@stealth>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Dec 12, 2020 at 08:36:48AM +0900, Punit Agrawal wrote:
> To me it suggests, that there are likely more systems from the family
> that show the characteristic described below.

Until we find a *single* system with a broken BIOS which has those
objects kaputt and then this heuristic would need an exception.

VS the clear statement from AMD that from zen3 onwards, all BIOS will be
tested. I hope they boot Linux at least before they ship.

> In all these systems, the override causes this topology information to
> be ignored - treating each core to be a separate domain. The proposed
> patch removes the override so that _PSD is taken into account.

You're still not answering my question: what does the coupling of the
SMT threads bring on those systems? Power savings? Perf improvement?
Anything palpable or measurable?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

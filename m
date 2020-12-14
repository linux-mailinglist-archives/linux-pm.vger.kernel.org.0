Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC222D99EC
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 15:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395242AbgLNO0d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 09:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405955AbgLNO00 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 09:26:26 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11238C0613CF;
        Mon, 14 Dec 2020 06:25:46 -0800 (PST)
Received: from zn.tnic (p200300ec2f0a4700a4e3f86bfec32453.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:4700:a4e3:f86b:fec3:2453])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A7671EC051E;
        Mon, 14 Dec 2020 15:25:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607955944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OKP/ZIb2SxC7wKCyqIoQ+2hJLxUxcqOf9Z7O8PkQ3uo=;
        b=R1HBPL99Ho1KrcwC1SUpf7jihXVYcrWye/RkgA4ht+kA1gt70LF9X0hDH//JUEbIP7EUiC
        sUa5FovgPiJ1dH3g4SSVBwu2tBVsoZZOHZ5pXM3nUdvk0DRuTo7kFfXfuUFB6NBezGJSXV
        iTlmJ959cRyI5n70haFrFQv6vdtVpMU=
Date:   Mon, 14 Dec 2020 15:25:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     Wei Huang <whuang2@amd.com>, rjw@rjwysocki.net, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 2/4] cpufreq: acpi-cpufreq: Add processor to the
 ignore PSD override list
Message-ID: <20201214142540.GB25916@zn.tnic>
References: <20201125144847.3920-3-punitagrawal@gmail.com>
 <cadb5d57-5aaf-79bc-e30e-502d5e522689@amd.com>
 <20201207202610.GG20489@zn.tnic>
 <e9b4ae11-1fe3-a660-bb65-d3ba55ffcc56@amd.com>
 <20201207223057.GJ20489@zn.tnic>
 <87a6unq3xv.fsf@stealth>
 <20201208233216.GH27920@zn.tnic>
 <871rfvoqy7.fsf@stealth>
 <20201214124023.GA25916@zn.tnic>
 <87sg88tt5e.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sg88tt5e.fsf@stealth>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 14, 2020 at 10:27:09PM +0900, Punit Agrawal wrote:
> IIUC, this suggests that Linux booting on anything prior to Zen3 is down
> to pure luck - I hope that wasn't the case.

WTF does this have to do with linux booting?!

> At the moment acpi thermals is bust on this and other affected AMD
> system I have access to. That'll need fixing before any sensible
> measurements can be run.

Nope, still not answering my questions.

> Tbh, I didn't quite expect the patch to the PSD exclusion list to be
> so controversial

It won't be if you explain properly what your patch is fixing. That is,
if it fixes anything.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

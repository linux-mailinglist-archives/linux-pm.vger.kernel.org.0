Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1E22D1D58
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 23:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgLGWbn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 17:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgLGWbn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 17:31:43 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09A4C061793;
        Mon,  7 Dec 2020 14:31:02 -0800 (PST)
Received: from zn.tnic (p200300ec2f0a3800f6520bb83eb81f06.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:3800:f652:bb8:3eb8:1f06])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 632601EC0391;
        Mon,  7 Dec 2020 23:31:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607380261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1pXP7Us+7n31k5o5RoCjT5roVSbCsK8S24nd3SAu6nM=;
        b=LX+vDVL0KwxEYHMvTNniRiIcWMWirj755BhWqUH6/TdDOrWciishdcFtbOZupUuoNjvEWF
        gZukmB/j2luqiJEaLk2wDHzvQ2dNrRWwHguZMjIIPyokBmBCkU4qJv1ohgyP4vrmGeF27a
        mGov61wUvrcTqIn/AhrUl4WTOqlf7UQ=
Date:   Mon, 7 Dec 2020 23:30:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Wei Huang <whuang2@amd.com>
Cc:     Punit Agrawal <punitagrawal@gmail.com>, rjw@rjwysocki.net,
        wei.huang2@amd.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 2/4] cpufreq: acpi-cpufreq: Add processor to the
 ignore PSD override list
Message-ID: <20201207223057.GJ20489@zn.tnic>
References: <20201125144847.3920-1-punitagrawal@gmail.com>
 <20201125144847.3920-3-punitagrawal@gmail.com>
 <cadb5d57-5aaf-79bc-e30e-502d5e522689@amd.com>
 <20201207202610.GG20489@zn.tnic>
 <e9b4ae11-1fe3-a660-bb65-d3ba55ffcc56@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9b4ae11-1fe3-a660-bb65-d3ba55ffcc56@amd.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 07, 2020 at 04:07:52PM -0600, Wei Huang wrote:
> I think we shouldn't override zen2 if _PSD is correct. In my opinion,
> there are two approaches:
> 
> * Keep override_acpi_psd()
> Let us keep the original quirk and override_acpi_psd() function. Over
> the time, people may want to add new CPUs to override_acpi_psd(). The
> maintainer may declare that only CPUs >= family 17h will be fixed, to
> avoid exploding the check-list.
> 
> * Remove the quirk completely
> We can completely remove commit acd316248205 ("acpi-cpufreq: Add quirk
> to disable _PSD usage on all AMD CPUs")? I am not sure what "AMD desktop
> boards" was referring to in the original commit message of acd316248205.
> Maybe such machines aren't in use anymore.

* Third option: do not do anything. Why?

- Let sleeping dogs lie and leave the workaround acd316248205 for old
machines.

- Make a clear cut that the override is not needed from Zen3 on, i.e.,
your patch

   5368512abe08 ("acpi-cpufreq: Honor _PSD table setting on new AMD CPUs")


Punit's commit message reads "...indicates that the override is not
required for Zen3 onwards, it seems that domain information can be
trusted even on certain earlier systems."

That's not nearly a justification in my book to do this on anything < Zen3.

This way you have a clear cut, you don't need to deal with adding any
more models to override_acpi_psd() and all is good.

Unless there's a better reason to skip the override on machines < Zen3
but I haven't heard any so far...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

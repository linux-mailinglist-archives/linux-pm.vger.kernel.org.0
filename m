Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A012D36F1
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 00:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbgLHXdC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 18:33:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44530 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731712AbgLHXdC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 18:33:02 -0500
Received: from zn.tnic (p200300ec2f0f08002eb81e5fb58e3a10.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:800:2eb8:1e5f:b58e:3a10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B1CD1EC0541;
        Wed,  9 Dec 2020 00:32:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607470341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=h6F5mNIGeKlh0IZESozg0IRBPpPLEFU2sE1qhXqTv/c=;
        b=o6CE/xXJ1x1btZz3VuWNrah2gnuv5ibCQBc4l3hkjxJmRU0yyET99LNlEX0ibRrUBcyei+
        foH1i8DQ94wYXCe1bKjv0Hvl9OwKZ445t2dKdM6Gq7l5YTLW3uCdNt/pWbhi1tpkqN54ja
        wrM1rQK8Y6k9AD5K9IwHU1i+SEkSfWI=
Date:   Wed, 9 Dec 2020 00:32:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     Wei Huang <whuang2@amd.com>, rjw@rjwysocki.net, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 2/4] cpufreq: acpi-cpufreq: Add processor to the
 ignore PSD override list
Message-ID: <20201208233216.GH27920@zn.tnic>
References: <20201125144847.3920-1-punitagrawal@gmail.com>
 <20201125144847.3920-3-punitagrawal@gmail.com>
 <cadb5d57-5aaf-79bc-e30e-502d5e522689@amd.com>
 <20201207202610.GG20489@zn.tnic>
 <e9b4ae11-1fe3-a660-bb65-d3ba55ffcc56@amd.com>
 <20201207223057.GJ20489@zn.tnic>
 <87a6unq3xv.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a6unq3xv.fsf@stealth>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 09, 2020 at 08:21:48AM +0900, Punit Agrawal wrote:
> According to the commit log, acd316248205 seems to be only targeted at
> powernow-K8 -

No, it is not targeted at powernow-k8 - acpi-cpufreq.c is what is used
on AMD hw. He means to make acpi-cpufreq's behavior consistent with
powernow-k8.

> But if that is not available, the only way we have is to include
> systems that have been verified to not need the override

You have verified exactly *one* system - yours. Or are you sure that
*all* family 0x17, model 0x60, stepping 0x1 machines don't need the
override?

Also, you still haven't explained what you're trying to fix here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA66290005
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 10:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394645AbgJPIiG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 04:38:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56576 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394643AbgJPIiG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Oct 2020 04:38:06 -0400
Received: from zn.tnic (p200300ec2f0d0d0027bddccd24e05386.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d00:27bd:dccd:24e0:5386])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 92E661EC04F3;
        Fri, 16 Oct 2020 10:38:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602837484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oGv65bZy4GkSDeLjS1LHeAjddyaBRir2G5MWWADWy/M=;
        b=JQVPeHjvm+BTMj1JifRtH/zO0dncstCNUWD8X1f5CCRRsuzXLsBBzqspnnq/wdXA3BmIon
        msbc9cYJXU6ulULgjtrbX2s0jH/fOD+6bmVkCA98hMouN2ogJmohU03ivfhDQjwMPSn3Mj
        MdWT8qkiQuUrb88hqZjE3/LqTH4F908=
Date:   Fri, 16 Oct 2020 10:37:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     X86 ML <x86@kernel.org>, Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] tools/power/cpupower: Read energy_perf_bias from
 sysfs
Message-ID: <20201016083754.GB8483@zn.tnic>
References: <20201015144603.27933-1-bp@alien8.de>
 <20201015144603.27933-2-bp@alien8.de>
 <7806e3c0-f435-18a0-c50d-eee3f1f7fccf@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7806e3c0-f435-18a0-c50d-eee3f1f7fccf@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 15, 2020 at 11:49:32AM -0600, Shuah Khan wrote:
> Is there a reason to move "int fd"?

Habit from tip - we sort function-local variables in a reverse fir tree
order. And since I'm adding cpupower_write_sysfs(), I made them look
consistent.

> > +	numwritten = write(fd, buf, buflen - 1);
> > +	if (numwritten < 1) {
> > +		perror("write failed");
> 
> Please add filename to the error message

	perror(path);

or do you want me to build a string with an error message and filename?

> Please add return check for snprintf, please add a define for
> "cpu%u/power/energy_perf_bias" since it is hardcoded in
> read/write functions.

None of the other snprintf() calls in cpupower do that. Nothing checks
snprintf() retval and the last part of the sysfs path is a naked string.

Why is this different?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

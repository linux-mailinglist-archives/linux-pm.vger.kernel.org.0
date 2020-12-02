Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCA22CC2E9
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 18:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbgLBQ6r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 11:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387406AbgLBQ6q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 11:58:46 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93450C0617A7;
        Wed,  2 Dec 2020 08:58:06 -0800 (PST)
Received: from zn.tnic (p200300ec2f161b00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:1b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 830941EC0445;
        Wed,  2 Dec 2020 17:58:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606928281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4SYz5A8E74jG9es8toNezShE0M+RoGJkzH20/QYIE8Q=;
        b=fpKVI19DRZhZmRzIpX8nD+aXjuLlXCOm02tH82sa9bq7Y6m+wbwlu3u8qBqv72UQiCr8JJ
        eCm5oO5T0c62yTbboKrocW20ScDjRb+QqpAf4VbxXc7Y14wKlKOvEb9qStOCrqq7PSY/Rw
        ojogo8+WDa62XDentxhYItfMIm1PgGE=
Date:   Wed, 2 Dec 2020 17:57:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     rjw@rjwysocki.net, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [RFC PATCH 3/4] x86/cpu: amd: Define processor families
Message-ID: <20201202165756.GE2951@zn.tnic>
References: <20201125144847.3920-1-punitagrawal@gmail.com>
 <20201125144847.3920-4-punitagrawal@gmail.com>
 <20201130140018.GC6019@zn.tnic>
 <87pn3s2t5d.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pn3s2t5d.fsf@stealth>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 02, 2020 at 11:13:02PM +0900, Punit Agrawal wrote:
> Didn't realize the core was internal only.

F10h is not internal only - all I'm saying is that "K10" wasn't use
inside AMD AFAIR.

> Makes sense - I will follow your suggestion in the next version.

Well, I don't think it is worth the churn, TBH.

I'd prefer comments over the f/m/s checks which explain what is matched
much better than defines for family numbers which are inadequate when
one needs to match the model too, for one.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

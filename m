Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893F91F6C0E
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jun 2020 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgFKQSG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jun 2020 12:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgFKQSG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2020 12:18:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C57C08C5C1;
        Thu, 11 Jun 2020 09:18:06 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bef0005d5b3018ae552bb.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ef00:5d5:b301:8ae5:52bb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 691831EC0301;
        Thu, 11 Jun 2020 18:18:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591892284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RJ7GoAEedrAK4DvGOTYw+36v89yWRwjmeXLTFyITpDc=;
        b=WEAA1RLryyys5lbBBt7AxdJlwbKkwhspyf6IM1ftPSqXfF0uBlIVnVAiu/Lf7bYVpg5e4Y
        OSSj1pDbnCZ6xJFhp+oa9qxHNYy1domqNK3LLw+x1ByEFS8wfQF986hpLMwP2XtAvUApZ3
        pg5E7+EOFrQDTa96aKwPOeosO1fKLu4=
Date:   Thu, 11 Jun 2020 18:17:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mario.Limonciello@dell.com
Cc:     pmenzel@molgen.mpg.de, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        ckellner@redhat.com, linux-pm@vger.kernel.org
Subject: Re: Intel laptop: Starting with `maxcpus=1` and then bringing other
 CPUs online freezes system
Message-ID: <20200611161758.GG30352@zn.tnic>
References: <125e904a-088e-f111-00a4-95c3b18d882f@molgen.mpg.de>
 <a0de2be2c9344980bce7190d19204316@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0de2be2c9344980bce7190d19204316@AUSX13MPC105.AMER.DELL.COM>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 11, 2020 at 01:13:27PM +0000, Mario.Limonciello@dell.com wrote:
> From some other similar reports I've heard this could be related to the ucode
> loading causing a freeze.  I would suggest trying to disable the Intel ucode
> loader with the initramfs as a debugging tactic.

There's a cmdline param for that: "dis_ucode_ldr".

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

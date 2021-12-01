Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F75465152
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 16:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243428AbhLAPWd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 10:22:33 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:35915 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350464AbhLAPWb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Dec 2021 10:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638371950; x=1669907950;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zGVC8wVHSH9HAuJ7vjpVU4Ne9Eidx6zcHD43QCrtk7A=;
  b=BG01s2bFDUExfiezt5U6CSTe9SLqf+IxmAsPtmI051Uf56QVjKBID6Cw
   4P0cbwu/TDogWjawr9r2A7zk/yNxf08m4fjBYT4fqC7b5iHpISWV3++ON
   ZioN9y1IMySrDUE/soHgdzP5HnVyNQia6G2aOR1hpvK2+ekJlPvlUBorr
   nr3JiKO1k0YNZ7ATUr8TAVFEGlXAVT1zXT4ixC6YHHnLk/xXEfYHiq7Sa
   PRUHciSbnrlO9X8I43gFo2Y5PCXljsRsJFDQu3SGOPCRSTqEDS19d4ZJ4
   9xxfW3F5AR3oaokVWVHnOhYBNUMumTneQf4JV/k99y0n6Jn1l+T19kbbO
   A==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20789565"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 01 Dec 2021 16:19:06 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 01 Dec 2021 16:19:06 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 01 Dec 2021 16:19:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638371946; x=1669907946;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zGVC8wVHSH9HAuJ7vjpVU4Ne9Eidx6zcHD43QCrtk7A=;
  b=azSSEmaimOIG/US1xH/JXkBUM4vrbqy1M05LiiRCScvRBVuQTAbSrS1X
   +of6hOrf3rvXXSbRjkt0P83JnxXS5dRfNVtkaCe80GstFtTLd/PikM8Qv
   8d4xndZlt6mCAFv6io7SHeot6gtV0zt1XH+r0lom6lE/k6dyjGLk5DD+Y
   qMqguOBCMv2hUfhfP/z5fQ6hkSbIMCub61ODUGIYVCn4gelAZWFYNFiZa
   ka83UPiXp2LZWUF3W4J1QDlw32vUSPIzNbD5cVMfYzgjnYMZHLX6mN4fc
   sYy1DFqHOs5lPFuhdSRrm48R7qqSOzXU2c3fE8KAny38Caru4L4pYj8b7
   g==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20789564"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Dec 2021 16:19:06 +0100
Received: from steina-w (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1B46E280065;
        Wed,  1 Dec 2021 16:19:06 +0100 (CET)
Message-ID: <3e01ffc0c938cd4f952c36051805d132af820afe.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH 1/1] thermal: imx8mm: enable ADC
 when enabling monitor
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Paul Gerber <Paul.Gerber@tq-group.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 01 Dec 2021 16:19:03 +0100
In-Reply-To: <f3248b92-c6db-c3a3-f26a-65a2fd272d4c@linaro.org>
References: <20211122114225.196280-1-alexander.stein@ew.tq-group.com>
         <2786750e-0556-a1b8-e464-30de05ce7cf2@linaro.org>
         <ea1af2b2091c0cab822c9ef5810db6936365d7ef.camel@ew.tq-group.com>
         <f3248b92-c6db-c3a3-f26a-65a2fd272d4c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Mittwoch, dem 01.12.2021 um 15:52 +0100 schrieb Daniel Lezcano:
> On 01/12/2021 15:45, Alexander Stein wrote:
> > Am Dienstag, dem 30.11.2021 um 15:49 +0100 schrieb Daniel Lezcano:
> > > On 22/11/2021 12:42, Alexander Stein wrote:
> > > > From: Paul Gerber <
> > > > Paul.Gerber@tq-group.com
> > > > 
> > > > 
> > > > The i.MX 8MP has a ADC_PD bit in the TMU_TER register that
> > > > controls
> > > > the
> > > > operating mode of the ADC:
> > > > * 0 means normal operating mode
> > > > * 1 means power down mode
> > > > 
> > > > When enabling/disabling the TMU, the ADC operating mode must be
> > > > set
> > > > accordingly.
> > > > 
> > > > i.MX 8M Mini & Nano are lacking this bit.
> > > > 
> > > > Signed-off-by: Paul Gerber <
> > > > Paul.Gerber@tq-group.com
> > > > 
> > > > 
> > > > Signed-off-by: Alexander Stein <
> > > > alexander.stein@ew.tq-group.com
> > > > 
> > > > 
> > > > ---
> > > > Often this bit is set already by the bootloader, but in case
> > > > this
> > > > is not
> > > > done, the file /sys/class/thermal/thermal_zone0/temp will
> > > > always
> > > > return
> > > > -EAGAIN.
> > > 
> > > Does it deserve a Fixes tag?
> > 
> > The more I think about it, the more I'm inclined to add one.
> > Please tell me if I shall iterate v2 adding a Fixes tag (or other
> > changes)
> 
> It is not necessary to send a V2 as the commit log will have a link
> to
> this thread. Just answer with the Fixes tag, I'll add it myself to
> the
> change log.

Thanks.

Fixes: 2b8f1f0337c5 ("thermal: imx8mm: Add i.MX8MP support")

imx8mm_tmu_enable() was introduced in this commit and the fix is about
i.MX8MP as well, so this seems even more reasonable to me.

Best regards,
Alexander



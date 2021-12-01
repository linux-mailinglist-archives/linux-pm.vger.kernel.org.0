Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDDA46504D
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 15:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351126AbhLAOtL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 09:49:11 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:17617 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350575AbhLAOsw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Dec 2021 09:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638369931; x=1669905931;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+m9wSZu9/s7I3SjswpXETp+qN4xor9JvYjd0U3he9pU=;
  b=eiCfmf60MGLCylSmQCmhb42fynXUPy+0tIdGUGQooLc0JVHu3Uu2xfuL
   6YfarSkqHFAXMOz68E9oMB5ZFlVFtcjUM4AsvmMrqxBSkxOdwFVtrinHp
   oxWNKRibkHWy0QkvkX8UPP58JW5uXkpWxX3mW6iAhT1b6kgfeuXmtP+pj
   0TO7c1lfxwY94/I9G7wM8KXio+KJ9TpqH+krWGLP4AZ+SFxt2G2khoj4X
   oZBySxFp1qJuTMz5jxlYdSbfxFXgowI8GjKQ4kaUIpMZMHK3gESmc6Ytl
   YWb8E5u9avxL33WlETC7CQhgq7sI0bsQgL5cXPzsiLQiQg5vckQAMohQX
   g==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20788362"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 01 Dec 2021 15:45:24 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 01 Dec 2021 15:45:24 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 01 Dec 2021 15:45:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638369924; x=1669905924;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+m9wSZu9/s7I3SjswpXETp+qN4xor9JvYjd0U3he9pU=;
  b=GlTEb95sFaVn0TWE78NK41I1IAyq2DOlbHeVMT2j4OA00W6q06hiKZxk
   RdSyxA4Tf939oZXaqKztG8Bc5mCzwwmdpP4vBC/by9PoqOkNVMAwwD6b2
   h4jwckFuatXLjsqGYioSXl/S59+1LcMFudNy6nDOBdXP/LhZJTayPC5BL
   HK/fW7Hiwd2Iky6TJ+whKCTQA1ovCfdGKarntgSIQpBpNkdZZkMNk42yK
   84dY4Qk1vSXPN1y2+OAFCxkymtbomDoBGZii2d0W9c3pNKCgUIerFeqUb
   OHfrsS4toeCd+5u6M1KTCj7N3sC2Tc4VlXsvTEulcshY1LWwBIv1zYO/u
   g==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20788361"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Dec 2021 15:45:24 +0100
Received: from steina-w (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 0B661280065;
        Wed,  1 Dec 2021 15:45:23 +0100 (CET)
Message-ID: <ea1af2b2091c0cab822c9ef5810db6936365d7ef.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH 1/1] thermal: imx8mm: enable ADC when enabling
 monitor
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Paul Gerber <Paul.Gerber@tq-group.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 01 Dec 2021 15:45:21 +0100
In-Reply-To: <2786750e-0556-a1b8-e464-30de05ce7cf2@linaro.org>
References: <20211122114225.196280-1-alexander.stein@ew.tq-group.com>
         <2786750e-0556-a1b8-e464-30de05ce7cf2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Dienstag, dem 30.11.2021 um 15:49 +0100 schrieb Daniel Lezcano:
> On 22/11/2021 12:42, Alexander Stein wrote:
> > From: Paul Gerber <
> > Paul.Gerber@tq-group.com
> > >
> > 
> > The i.MX 8MP has a ADC_PD bit in the TMU_TER register that controls
> > the
> > operating mode of the ADC:
> > * 0 means normal operating mode
> > * 1 means power down mode
> > 
> > When enabling/disabling the TMU, the ADC operating mode must be set
> > accordingly.
> > 
> > i.MX 8M Mini & Nano are lacking this bit.
> > 
> > Signed-off-by: Paul Gerber <
> > Paul.Gerber@tq-group.com
> > >
> > Signed-off-by: Alexander Stein <
> > alexander.stein@ew.tq-group.com
> > >
> > ---
> > Often this bit is set already by the bootloader, but in case this
> > is not
> > done, the file /sys/class/thermal/thermal_zone0/temp will always
> > return
> > -EAGAIN.
> 
> Does it deserve a Fixes tag?

The more I think about it, the more I'm inclined to add one.
Please tell me if I shall iterate v2 adding a Fixes tag (or other
changes)

Best regards,
Alexander



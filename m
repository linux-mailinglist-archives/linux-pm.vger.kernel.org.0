Return-Path: <linux-pm+bounces-28447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D50AD4CC5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147A81BC12D2
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 07:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E46F22F749;
	Wed, 11 Jun 2025 07:33:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF55229B38
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627185; cv=none; b=OTEMFFn8BxK4qrvuK6a8RzWI0h2Ay84iYBCg8CYcYSUcL91MtjEHHznE8bq/uyOzvbzq3hz0y+vqzgG8VxroYQklW0vfFvT1YPLOLRP/FLxKhT0o42CzmwVYdbJ22S2tnVD36kuHXKVN8FMov6eTV/K6ObnKdIediTLauiUqsKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627185; c=relaxed/simple;
	bh=EDJlGD4wfKphKeMYD141vWBxv2UxlZLo8grwzYmcu7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2aX3bUfUequj118GTjwiwu19xiTyBgUyphPDro16/gyAt/7W1shSW024NYILDxBLvMvotFLFmbyKu2W+yH4BdJ8yEEplDHDSDwnuALOmEadPhoO0WvGBecEA+rWJWvXuRJ0S5JCMCfZ3RC+EWJEvqbBMRYrkh41il4pE4+s3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1uPFwv-0007lf-9R; Wed, 11 Jun 2025 09:32:41 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1uPFwt-002uFg-1G;
	Wed, 11 Jun 2025 09:32:39 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1uPFwt-006l8F-0q;
	Wed, 11 Jun 2025 09:32:39 +0200
Date: Wed, 11 Jun 2025 09:32:39 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PM / devfreq: rockchip-dfi: add support for LPDDR5
Message-ID: <aEkxF2Q2lBdfmUuJ@pengutronix.de>
References: <20250530-rk3588-dfi-improvements-v1-0-6e077c243a95@collabora.com>
 <20250530-rk3588-dfi-improvements-v1-2-6e077c243a95@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530-rk3588-dfi-improvements-v1-2-6e077c243a95@collabora.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On Fri, May 30, 2025 at 03:38:09PM +0200, Nicolas Frattaroli wrote:
> The Rockchip RK3588 SoC can also support LPDDR5 memory. This type of
> memory needs some special case handling in the rockchip-dfi driver.
> 
> Add support for it in rockchip-dfi, as well as the needed GRF register
> definitions.
> 
> This has been tested as returning both the right cycle count and
> bandwidth on a LPDDR5 board where the CKR bit is 1. I couldn't test
> whether the values are correct on a system where CKR is 0, as I'm not
> savvy enough with the Rockchip tooling to know whether this can be set
> in the DDR init blob.
> 
> Downstream has some special case handling for a hardware version where
> not just the control bits differ, but also the register. Since I don't
> know whether that hardware version is in any production silicon, it's
> left unimplemented for now, with an error message urging users to report
> if they have such a system.
> 
> There is a slight change of behaviour for non-LPDDR5 systems: instead of
> writing 0 as the control flags to the control register and pretending
> everything is alright if the memory type is unknown, we now explicitly
> return an error.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 84 ++++++++++++++++++++++++++++--------
>  include/soc/rockchip/rk3588_grf.h    |  8 +++-
>  include/soc/rockchip/rockchip_grf.h  |  1 +
>  3 files changed, 73 insertions(+), 20 deletions(-)
> 
> @@ -147,21 +200,7 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
>  			       DDRMON_CTRL_SOFTWARE_EN | DDRMON_CTRL_HARDWARE_EN),
>  			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
>  
> -		/* set ddr type to dfi */
> -		switch (dfi->ddr_type) {
> -		case ROCKCHIP_DDRTYPE_LPDDR2:
> -		case ROCKCHIP_DDRTYPE_LPDDR3:
> -			ctrl = DDRMON_CTRL_LPDDR23;
> -			break;
> -		case ROCKCHIP_DDRTYPE_LPDDR4:
> -		case ROCKCHIP_DDRTYPE_LPDDR4X:
> -			ctrl = DDRMON_CTRL_LPDDR4;
> -			break;
> -		default:
> -			break;
> -		}
> -
> -		writel_relaxed(HIWORD_UPDATE(ctrl, DDRMON_CTRL_DDR_TYPE_MASK),
> +		writel_relaxed(HIWORD_UPDATE(ctrl, ctrl_mask),
>  			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);

You could move the HIWORD_UPDATE(ctrl, ctrl_mask) to
rockchip_dfi_ddrtype_to_ctrl() and by that you only have to pass one
u32* to that function.

That's just nitpicking though, so for the series:

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


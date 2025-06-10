Return-Path: <linux-pm+bounces-28378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1474FAD3865
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 15:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052151894B19
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 13:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611D52C375C;
	Tue, 10 Jun 2025 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ujDB7z68"
X-Original-To: linux-pm@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9382C17B0;
	Tue, 10 Jun 2025 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560350; cv=none; b=Y39wb7toxWXHPuyfdmb1sSxMRdHRMIwWgA5zCiFTdXO+XI9sCmBFnz5oKtT1sBDpwkjPitE1RBgXwuxahHIpgWWEsBbO1e0WesGGweVPGi+70CpTOzGw9kfJmwoi8OrNjKGmN2B6EwzBboQmMU8uhZvq7v7I2klBtG3bKhvP3ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560350; c=relaxed/simple;
	bh=oFMazrCuecngzoa++NkSmIOCoYRid8dS5A/ERnGJBpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWOOKWvX3q1WpRLyacAq9irJmo78J0Eo965EWeL24SXMzVx6EIlfIitRTjU0P5Qk6AzqK7iSdyhQWU5RV760ZEePfFOxfz5QuDSSQxMZZNVHunnjp20deeEEyFN9lKdM+JuQZ4eeyyZ6VUzrSbKJQ+aBd5/yS9EM9PUDqFqYh4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ujDB7z68; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0mN0Y6VG8wJwIHBPmUq5Ichmc5b23YwTM3GHpfC0Ov0=; b=ujDB7z68qrrQWLKAjGzbmCQGy3
	LdOtDJSTUvPJoAR+dlK+SCrvQO4qgGvAcvh2Obe7Xf1qUhfc6kUAHntYjvGObWD50/ANPKe97yd3y
	StFdUf5u32nQt5lMjBOlGoqnG9dJYy8rhkzxAKLYPIrFSRwObLsOO0zSTHB4qQv0slmA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uOyYu-00FGk5-Tp; Tue, 10 Jun 2025 14:58:44 +0200
Date: Tue, 10 Jun 2025 14:58:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: linux@fw-web.de, myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
	cw00.choi@samsung.com, djakov@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, jia-wei.chang@mediatek.com,
	johnson.wang@mediatek.com, arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
	daniel@makrotopia.org, lorenzo@kernel.org, nbd@nbd.name,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: Re: [PATCH v3 12/13] arm64: dts: mediatek: mt7988a-bpi-r4: add
 sfp cages and link to gmac
Message-ID: <e1a49ca7-f082-4983-89fe-1a8f8c8a3de1@lunn.ch>
References: <20250608211452.72920-1-linux@fw-web.de>
 <20250608211452.72920-13-linux@fw-web.de>
 <934b1515-2da1-4479-848e-cd2475ebe98d@lunn.ch>
 <trinity-b9ab960d-38f8-4524-b645-fc0832ce72ec-1749546239525@trinity-msg-rest-gmx-gmx-live-5d9b465786-6phds>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-b9ab960d-38f8-4524-b645-fc0832ce72ec-1749546239525@trinity-msg-rest-gmx-gmx-live-5d9b465786-6phds>

> > sff,sfp.yaml says:
> > 
> >   maximum-power-milliwatt:
> >     minimum: 1000
> >     default: 1000
> >     description:
> >       Maximum module power consumption Specifies the maximum power consumption
> >       allowable by a module in the slot, in milli-Watts. Presently, modules can
> >       be up to 1W, 1.5W or 2W.
> > 
> > I've no idea what will happen when the SFP core sees 3000. Is the
> > comment out of date?
> 
> at least sfp-core has no issue with the setting
> 
> root@bpi-r4-phy-8G:~# dmesg | grep sfp
> [    1.269437] sfp sfp1: Host maximum power 3.0W
> [    1.613749] sfp sfp1: module CISCO-FINISAR    FTLX8571D3BCL-C2 rev A    sn S2209167650      dc 220916  
> 
> imho some modules require more than 2W (some gpon/xpon and 10G copper ethernet).

Looking at the code:

static int sfp_module_parse_power(struct sfp *sfp)
{
        u32 power_mW = 1000;
        bool supports_a2;

        if (sfp->id.ext.sff8472_compliance >= SFP_SFF8472_COMPLIANCE_REV10_2 &&
            sfp->id.ext.options & cpu_to_be16(SFP_OPTIONS_POWER_DECL))
                power_mW = 1500;
        /* Added in Rev 11.9, but there is no compliance code for this */
        if (sfp->id.ext.sff8472_compliance >= SFP_SFF8472_COMPLIANCE_REV11_4 &&
            sfp->id.ext.options & cpu_to_be16(SFP_OPTIONS_HIGH_POWER_LEVEL))
                power_mW = 2000;

How does your module indicate it needs 3000 mW? Does this bit of code
need extending to read additional bits?

	Andrew


Return-Path: <linux-pm+bounces-30627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A92FB009F6
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 19:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99511AA702A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD3E2F0E31;
	Thu, 10 Jul 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="l0joj5Ns"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205E2F0E29;
	Thu, 10 Jul 2025 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168591; cv=none; b=qKCoo1cCed/sk7ermw9LSEKv68i+3pocTg8OLE6vq1MTXYRy2BHsxpJluK6doPR9QNhCOUtYlplHiXfF1hmuO5tYflhaJuDp38Py5YeYJkQ5JQv5UjLtVeDiHKfTqDotz6nbKcMgSUL3O8f+I6Lohrxko/bHRlP6GATlfZKKHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168591; c=relaxed/simple;
	bh=Y2QU6dhIoCpkxMjvh48d0GgwnQJLBzZYTZ+dfijuhDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YObu1UNzblpxzi/rNqx+68j4SyyiJjTUl6b9388eQTxpxE1wy1Sawn2QxnOV+LjoGRnLjjPDyB2d/kJXa0FVoqHFAfpuvGysFQOkGJZ7PIlPC+B6NQ1mX2BU8tqwNqDBoJWows4JJVG4bwhxupmLRmkpeF7NDVCF6L2F2KtABTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=l0joj5Ns; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 228F13D8759F;
	Thu, 10 Jul 2025 13:29:48 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id VJ1AFnWBo4HP; Thu, 10 Jul 2025 13:29:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7C6603D87659;
	Thu, 10 Jul 2025 13:29:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 7C6603D87659
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1752168587; bh=AlTPeyZEbvVpCppEtdbUfk6jkGSiu5jkvaQOyebiU3E=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=l0joj5NsGdhr4JzqNjXvyxIreXuCOJjtQYI2Bt4pPPUhjZ17z5+4hbo/irHByVcIe
	 o7mESkkRCA+K4mSLqMSeRS+i24hWWYAE5lFGAyNvq5k+GIc1BOpnsRs3Y5xMMy0nri
	 fg/4jzhW/adwz+L+BPOW0KBuwSIs6MkxEHH5qdJgm46F26mdZQ+wp+Rdz56JK5muwD
	 AJXx33bQ7Txb24+9KsF+CZL3kqggz9+NPATcPNI9O88PZUD0jtNdK91Of1C4yzBP3l
	 H3wJoFkb131aWPwl4JCYCLXln0qXsYGCwptbem4aI+7DMY/CrLu/8o2d886rqhuLad
	 WvfTfvdfcjPbg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 0VqTtdVW9Imo; Thu, 10 Jul 2025 13:29:47 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 0DBA83D8759F;
	Thu, 10 Jul 2025 13:29:47 -0400 (EDT)
Date: Thu, 10 Jul 2025 13:29:45 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v8 3/6] regulator: pf1550: add support for regulator
Message-ID: <aG_4ic277eGBgQb0@fedora>
References: <20250707-pf1550-v8-0-6b6eb67c03a0@savoirfairelinux.com>
 <20250707-pf1550-v8-3-6b6eb67c03a0@savoirfairelinux.com>
 <ni3bmj4ye3dp3opolk466r2ayx7iuk6hhyx4pdikydizqykfx7@nc5qdok32hsm>
 <aG_x8VELlUvLxezY@fedora>
 <ff3c3r336qgnlwfheelm6hjypnkjhw3txmeztv7mz2y6xdoxld@ecgifcvuihr3>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff3c3r336qgnlwfheelm6hjypnkjhw3txmeztv7mz2y6xdoxld@ecgifcvuihr3>

On Thu, Jul 10, 2025 at 05:11:14PM +0000, Sean Nyekjaer wrote:
> > > > +	for (i = 0; i < ARRAY_SIZE(pf1550_regulators); i++) {
> > > > +		struct regulator_desc *desc;
> > > > +
> > > > +		desc = &info->regulator_descs[i].desc;
> > > > +
> > > > +		if (desc->id == PF1550_SW2 && pf1550->dvs_enb) {
> > >
> > > We should enter here if dvs_enb == false.
> > > My A6 variant reported 0.625V instead of the correct 1.35V
> > >
> > Yeah, that would happen with the current if statement.
> > 
> > Since dvs_enb is true when DVS is enabled (OTP_SW2_DVS_ENB == 0), I should
> > modify the if statment to:
> > (desc->id == PF1550_SW2 && !pf1550->dvs_enb) /* OTP_SW2_DVS_ENB == 1 */
> 
> -		if (desc->id == PF1550_SW2 && pf1550->dvs_enb) {
> +		if (desc->id == PF1550_SW2 && !pf1550->dvs_enb) {
> 
> Yes that's what I have been running my tests with :)
> 
> I will continue with testing the onkey and battery charger
>
Thanks for testing!
> > 
> > I think that would be a more readable solution.
> > > > +			/* OTP_SW2_DVS_ENB == 1? */
> > > > +			desc->volt_table = pf1550_sw12_volts;
> > > > +			desc->n_voltages = ARRAY_SIZE(pf1550_sw12_volts);
> > > > +			desc->ops = &pf1550_sw1_ops;
> > > > +		}
> > > >

Thanks,
Sam


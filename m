Return-Path: <linux-pm+bounces-30344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36DCAFC504
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 10:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED00E174D50
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 08:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED7929B797;
	Tue,  8 Jul 2025 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/M7ElAp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689410A1F;
	Tue,  8 Jul 2025 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961955; cv=none; b=ZgKvyCgBFCYnKFa/HgXr260zW1ZVHWbrFI1tnoW9ks/1s0OkTnqFwwPBfl9xUoclyH16Z3dPlF/OniGkLiDv2/ZxGQA4uhKHUTEtZumviVqsKGb2wMYWihF95kt8VsRAKIjCwsWEL0PrGok4bQUa8FdHzW5CQH0CDt4yT39A5o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961955; c=relaxed/simple;
	bh=pR61KyM+qKZt65tV9gRAUety3LIBktxJjUCMLek7X1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF/ZrWTW/LhAwuZ6BCjCPDigQGVkoJA2eCDCUY+jfUsvWMWvSqPGpxcarwhEbEA6c6H/rZ4L9yzSO+NFAihrUNn0kU6jsikQjv1RCPBacp1/G9FjtLB/0fRJ53BDMIe2Lem4x5k3vqLAoqf/s1/R7Mzf6o86/JOf37aw9AOk8W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/M7ElAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6998FC4CEED;
	Tue,  8 Jul 2025 08:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751961955;
	bh=pR61KyM+qKZt65tV9gRAUety3LIBktxJjUCMLek7X1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/M7ElApJGkjJPAJa985F1T9IeZyU6zYLe2o+sxhfhsJOVEIQTBoQFPNGFxZhFi5d
	 P4aacDA8eERYuUeUxhXX1RZLcHXYaTg57tbC6HqIhoCrTq/1td5JI+bugvXM5Re0s+
	 BEuM9D/nGLB8h/AJ0LixKDhX0KwTeqNehCBqV7Xn/MnimZWSU1BslrpvlGG28xLFNZ
	 ObK7qgzi2CEUZ34IcCH5qpbojRtlvum4A5ST+B07svkXnYvetS8SKBKejAWQxQ3Ht5
	 2A5n34cbTokIKBJAllyGVivgtV25nv8YPiVn8MlMu+53YqY1bZpragoPGSbOI0QT0D
	 pdYb1MTrg5RBA==
Date: Tue, 8 Jul 2025 10:05:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pmdomain: qcom: rpmhpd: Add Milos power domains
Message-ID: <20250708-vengeful-bright-rhino-d8d5ea@krzk-bin>
References: <20250707-sm7635-rpmhpd-v2-0-b4aa37acb065@fairphone.com>
 <20250707-sm7635-rpmhpd-v2-2-b4aa37acb065@fairphone.com>
 <06760125-4800-4068-8936-dddf27c28d17@linaro.org>
 <DB5VDDKCAQQG.LDCMHXAZN17S@fairphone.com>
 <fe454257-aa21-4304-868f-aefbea9963c4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe454257-aa21-4304-868f-aefbea9963c4@linaro.org>

On Mon, Jul 07, 2025 at 04:42:13PM +0200, Casey Connolly wrote:
> > > > diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> > > > index 078323b85b5648e33dd89e08cf31bdc5ab76d553..e09552a469264f28952fc46c3ab8c125e87310da 100644
> > > > --- a/drivers/pmdomain/qcom/rpmhpd.c
> > > > +++ b/drivers/pmdomain/qcom/rpmhpd.c
> > > > @@ -217,6 +217,24 @@ static struct rpmhpd gmxc = {
> > > >    	.res_name = "gmxc.lvl",
> > > >    };
> > > > +/* Milos RPMH powerdomains */
> > > 
> > > I can't find any public docs telling us which SoC is Milos (the only
> > > relevant result is Bjorn's email asking you to use that name instead of
> > > SM7635). So for the sake of future generations could you reference both
> > > names in a comment somewhere? Or even the commit message would be enough
> > > tbh.
> > 
> > I don't know the full list of model numbers for Milos. I assume it's
> > SM7635, SM6650, SM6650P, QCM6690 and QCS6690 based on the info I could
> > fine, but such info is hard to get. So this is not a definite list that
> > all those are actually Milos, or that this is the full list of Milos
> > chipsets.
> 
> oof, I see... that complicates things. It sure would be good if this list
> was documented in the kernel though imo.

Kernel is not the place to store mappings or descriptions of some random
company products and their names, so no.

Also it's not a task of contributor of a new SoC to decipher Qualcomm
model numbering and document it anywhere.

Best regards,
Krzysztof



Return-Path: <linux-pm+bounces-12178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E39950D2A
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 21:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118FA1C23861
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 19:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626647F53;
	Tue, 13 Aug 2024 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBqLSCEm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691AA1DDF4;
	Tue, 13 Aug 2024 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577597; cv=none; b=hiXqT8Qm8ihHyVkZonHsWmF7KLoVpiIag2pVwAPUO7Jc4BPKFmQCLI+6VPXQPLqdP+0LCZdhsnm3hwq574YqrMZ6hU4xJ+IXTCI4j7Z/aP/bEuGqOk8SHcFPvhUm7uYh+aUs1GVtsJfJ6uck7zrLfMS+n8kb7k54goYtVWWF6uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577597; c=relaxed/simple;
	bh=0ZUUmkuphhv7Zn3xARGNWRNCqnW09TZsMn+lG/Ct23w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChZJcDOKA6RYa4w+Y0yYyUcaJB/zPD7tiJ0lBRKgAf0tPmY51MST8rWNVOlub4nlxZ2+VV0WbKMeUbqhG+zSPyLCBwXzjMhDezZ6h5Bm+Hq0ZHqYWFehyedKkGBdvr4r4618O8efGJXAeq9xla3nV/oLwTq3k8/Mmw/SLaDXAj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBqLSCEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E65BC32782;
	Tue, 13 Aug 2024 19:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723577597;
	bh=0ZUUmkuphhv7Zn3xARGNWRNCqnW09TZsMn+lG/Ct23w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBqLSCEmFcVZGcGVexKglivaMACeswDHBXwIG1ca/s9szXYP+VoNPl00uYiCRtQ+9
	 9LPECB1obZbUd80mwinjtzsSC/7jzyJNkoR2EoBkOTfIzlg1BF14m07WhBJCbkFbCv
	 bl6QV+grlYW7dxoape0aQcuvttHLcO42Ua8rws+bmXEHYDqalGtNDdJ6NoeLtjZhRg
	 1YK/X5KBxmVJn0NlVShV92zhB444WtdssGkIz0jjfFOhnG9xzcvUXID0uTdNX0KU9D
	 VLnW/rgDV9TStqG6/XTavY92MfZWG/pYbtL6BM4qjzBeGk1BpQ4FZiyI2FEdaIN0cf
	 kvkLBdzt9U5CA==
Date: Tue, 13 Aug 2024 13:33:15 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Danila Tikhonov <danila@jiaxyga.com>, krzk+dt@kernel.org,
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, rafael@kernel.org, viresh.kumar@linaro.org,
	kees@kernel.org, tony.luck@intel.com, gpiccoli@igalia.com,
	ulf.hansson@linaro.org, andre.przywara@arm.com,
	quic_rjendra@quicinc.com, davidwronek@gmail.com,
	neil.armstrong@linaro.org, heiko.stuebner@cherry.de,
	rafal@milecki.pl, macromorgan@hotmail.com, linus.walleij@linaro.org,
	lpieralisi@kernel.org, dmitry.baryshkov@linaro.org,
	fekz115@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 06/11] dt-bindings: nfc: nxp,nci: Document PN553
 compatible
Message-ID: <20240813193315.GA1614564-robh@kernel.org>
References: <20240808184048.63030-1-danila@jiaxyga.com>
 <20240808184048.63030-7-danila@jiaxyga.com>
 <493466e6-d83b-4d91-93a5-233d6da1fdd8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <493466e6-d83b-4d91-93a5-233d6da1fdd8@kernel.org>

On Fri, Aug 09, 2024 at 07:39:53AM +0200, Krzysztof Kozlowski wrote:
> On 08/08/2024 20:40, Danila Tikhonov wrote:
> > The PN553 is another NFC chip from NXP, document the compatible in the
> > bindings.
> > 
> > Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> > ---
> >  Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml b/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
> > index 6924aff0b2c5..364b36151180 100644
> > --- a/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
> > +++ b/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
> > @@ -17,6 +17,7 @@ properties:
> >            - enum:
> >                - nxp,nq310
> >                - nxp,pn547
> > +              - nxp,pn553
> 
> Keep the list ordered.

Looks ordered to me. n before p...

Rob


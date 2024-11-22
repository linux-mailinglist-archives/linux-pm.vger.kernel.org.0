Return-Path: <linux-pm+bounces-17949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D449D59FC
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 08:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95E20B221C4
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 07:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AA316EBE8;
	Fri, 22 Nov 2024 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owF4NObT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD98D1632F5;
	Fri, 22 Nov 2024 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732260648; cv=none; b=gTQJ8Piuep2t8m7nComEgnxhfz6uqbKB+uAm58c9dT+ez6+nZWLqILEmHOoOalYXGUNpkVFbzl1Qdf3OiW4Zd5IcwhZY4JAYb7fj1ogzmM97II+3yfvhvisdO1omdYHP2C7Bjeg1GZ6NRlgOxjGWEjjKr/n4XMfGpNUiyflt+wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732260648; c=relaxed/simple;
	bh=9FHokJBvilp2Maa1P56wWPmPxjN1yEESCPlKt2evFuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chGNZhdTaO1gzGx7hKxhfQAlTVxtvd+FhbSKHFwBUu0i/ShuH9IyR+yMN0U0bVIjr51VbijLmY17if7++uKNb1/s9oy9yu3KGLJyh1gUllCAKJaqmjj2yWpKPuDqH9PtqHLADeqH2TVUKyi8yJ17aLr7Mmb9fdTQn2glKAqoKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owF4NObT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FAFC4CECE;
	Fri, 22 Nov 2024 07:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732260648;
	bh=9FHokJBvilp2Maa1P56wWPmPxjN1yEESCPlKt2evFuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=owF4NObTxxbff9fN21+lqaNFdY4R8Lq9N0EZu8vaql89qNquvxf+h8ukmiXVtO57L
	 gyHAfAQ8onWvTQCqdIUEQ0KlVm8K1XAyX/01Vo+pY04G4dl6GFYXfENh7GG7Nmm2B8
	 jPX8+v/sgNqY6qZ5zfipSiIvCDsRUwS8yq78UbL/s5mrma4LR1yJ0pW+8UNR1X4U5m
	 DKd2JudpOjuJURw+R57IsXb9c1cC8XOyYw2ZwVPPcVmAjkqwSojHOu3P9r+t+NsUUS
	 /eLWFBsoqsbK3iJLIxOBTDIJ22dP9ThTZpDbp1sy004fz5F7c1bHstfS3kpY0INhN1
	 YqShz/oCiMyyQ==
Date: Fri, 22 Nov 2024 08:30:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Mike Tipton <quic_mdtipton@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 1/4] dt-bindings: interconnect: Add EPSS L3 compatible
 for SA8775P
Message-ID: <gxlgrgwscpz7fw57aj6cqbrcyr6ovv755bgb5ix656op6jr5h4@pnbx4ze4qv22>
References: <20241121113006.28520-1-quic_rlaggysh@quicinc.com>
 <20241121113006.28520-2-quic_rlaggysh@quicinc.com>
 <bda810ab-68d8-4265-87c3-a6d021092e62@kernel.org>
 <10e4fd4e-559d-4164-ab94-d5f0a60ffc22@quicinc.com>
 <53876db8-4401-481d-8684-af7e135d481e@kernel.org>
 <82fc7b99-bc3e-4a9b-a472-c1b70671f21a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82fc7b99-bc3e-4a9b-a472-c1b70671f21a@quicinc.com>

On Fri, Nov 22, 2024 at 12:46:37PM +0530, Raviteja Laggyshetty wrote:
> > 
> >> But received comment from konrad to add both SoC-specific and generic compatibles.
> > 
> > I went through the history and don't see anything like that. Point to
> > the specific email please, if you disagree.
> > 
> https://patchwork.kernel.org/project/linux-pm/patch/20241026123058.28258-2-quic_rlaggysh@quicinc.com/#26104591

I read this message and it does not say to use generic compatible.

Best regards,
Krzysztof



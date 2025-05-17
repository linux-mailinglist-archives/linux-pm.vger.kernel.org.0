Return-Path: <linux-pm+bounces-27270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3774BABACCF
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 00:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE1917D0F5
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 22:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580721E231F;
	Sat, 17 May 2025 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duJ9dqwL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2295234CDD;
	Sat, 17 May 2025 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747521462; cv=none; b=FIl6s3aWVCq/httOMcKZZTNfsdtdg1rKhAGvgVX+PfgL7Yur4B69+mXRDPS8TDRJAEZ8sCjq+ieIzHe8P6ikfcQXqeg7fTDefrgn5SXlsAKoWer5qt5WepVMQZIMmj5lM1Y5RUWzGlBMjV7uX1jRrVgh7OyBJk7fKUXogSW1kmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747521462; c=relaxed/simple;
	bh=5ssddi3ZYH35EgOAIDe01xbwCR+djAr8ZHv3VetzRA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sq7LX9r2iNJEsMNAV2F2P9i0lWNkE3euiMfr5anoMOGlVwJOsJbE3xWik+lk8Gcpf/kNDZ5qwyF0vkqSOFvitcp0A504IJLCZqP4ahYq6cf1S96fZQ+TpbH4+yAyCrjj34yB0Byd8CtWooJl2tgvgegCFTf+N84hc1BRSZlJVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duJ9dqwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B55BC4CEE3;
	Sat, 17 May 2025 22:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747521459;
	bh=5ssddi3ZYH35EgOAIDe01xbwCR+djAr8ZHv3VetzRA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=duJ9dqwLqOgwgL+tevc3L7sZRbiXi7pmj6KE1nMvNIZwhjsgvJHWggHWpC9uxBaN0
	 yRXV65O01yxahCvcTknKap6yXczMgYO1Vdgv5ztiYMcun8xr05pYvyP6Zz1Tw9hohO
	 zhYvQqk7GZBddEpmjUA87RigkfKqvwVrB9U0lAS8C0OMJT3oQOlQoApRiypGaSBhxh
	 qtTaYU5fe8y2fy+PhTtXJ2PzaSu57H+cJu3LlDGXPiWi8e6tSd+eWFclt+EqciQBs2
	 QEHgJ1j/L2btj7zhzxDj+aDhCmG/ZXzTMwovZLPlTM6FnJz8v+S7Gv3Vf35NktvPYC
	 IExBOmhdhXXMQ==
Date: Sat, 17 May 2025 17:37:18 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Melody Olvera <quic_molvera@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shivnandan Kumar <quic_kshivnan@quicinc.com>
Subject: Re: [PATCH v3] arm64: dts: qcom: sm8750: Add BWMONs
Message-ID: <cpwyee5bgu3r36sh76mfd2o7oc2dnm3weuvynkvbsklr5nhm7l@gb2utngj6vfl>
References: <20250304-sm8750_bwmon_master-v3-1-01a5cb330dd9@quicinc.com>
 <d2640b21-41f7-4bb4-a616-42b6bd9cab0b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2640b21-41f7-4bb4-a616-42b6bd9cab0b@oss.qualcomm.com>

On Sat, Mar 08, 2025 at 07:15:06PM +0100, Konrad Dybcio wrote:
> On 5.03.2025 1:33 AM, Melody Olvera wrote:
> > From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> > 
> > Add the CPU BWMONs for SM8750 SoCs.
> > 
> > Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> > Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> > ---
> > Changes in v3:
> > - Change cluster 1 destination interconnect to tag active only from tag
> >   always
> > - Link to v2: https://lore.kernel.org/r/20250304-sm8750_bwmon_master-v2-1-ead16909397d@quicinc.com
> > 
> > Changes in v2:
> > - Change destination interconnect to tag active only from tag always
> > - Link to v1: https://lore.kernel.org/r/20250113-sm8750_bwmon_master-v1-0-f082da3a3308@quicinc.com
> > ---
> 
> This looks good, but I found that this platform may require some more
> changes for bwmon, we're investigating that
> 

Did we reach a conclusion on this?

Regards,
Bjorn

> Konrad


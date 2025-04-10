Return-Path: <linux-pm+bounces-25151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3699A848E8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B624F4E75BD
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF071EB5CF;
	Thu, 10 Apr 2025 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VoeivUXQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E5F1EB5D0;
	Thu, 10 Apr 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300309; cv=none; b=t1/y25AACGRS0Lgd6rZ2JAKKo2kVKB7p+OyINDmwnG0xHwOHVlaW1zGp/wekbGPwunHi9LBOikUBAfxAM2Ldth2/ugxbYXSJtXKRBlD+IuEYzqp3cEFKpP86yV1yNlkCuDroHzILUTVuEmYRy5MDEy9mRDmtVrpnGgnzGvxHJDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300309; c=relaxed/simple;
	bh=S8/1bc+SSt/Lx/Up/59n5c8Pu6woNGwVv1gsX+uXOMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jr2eYLrCgvZaMb8oAFeDKTMx9P31d0tFbiKT0GQjRAoc9XY7jL7D81I9ydx33C87be+1VOfYe3BdX09XJ5rQmJI4jY1GfX7mG3Q1xylOCWfbtWAtzlItENEqPIA5D9NMD/vU8uSppiBoxzrRdruyX+m81futt90SVCFaa4+65N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VoeivUXQ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZYPSc0mxGz9shl;
	Thu, 10 Apr 2025 17:51:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1744300304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S8/1bc+SSt/Lx/Up/59n5c8Pu6woNGwVv1gsX+uXOMw=;
	b=VoeivUXQ7HdrLMa0PepurFK2LL+UJ3EIaqVSNiZtIopDYhg6x7+mRpAL/TJI4Ez0qU7pac
	jfDAGctGweLk4yFrby03iwcyMX4g+s4Wl+K4gfbm3WCsiUkT86ZXOOQBD2S4ZV06VkF2wu
	2ejAm8cihlNu+t5SO4oVxuz9T6N0iHOBh78P3qPUO6J6X+a9/n0Ui8VXho2NhR2ua+g2Ff
	ObKc5TqgDtJyhjKDRbfcI5IB5g8nRvQJgZvdlPFgQUwFA9ivuhwMP1f3J0ASGHjTujI0jw
	pGeRciSKR9W3ZB7Bncr9wPMZgGAG1a9/U+so/kw+v5ora64PUu5DXkDAcnuW7w==
Date: Thu, 10 Apr 2025 17:51:38 +0200
From: Anthony Ruhier <aruhier@mailbox.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Maya Matuszczyk <maccraft123mc@gmail.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Support for GPU ACD feature on Adreno X1-85
Message-ID: <dmzoooujjb4zojjlgovjt6lccxilnnc3yr4j24vj4hwpzf5ouf@e6qkdlekcsnm>
References: <20250109-gpu-acd-v4-0-08a5efaf4a23@quicinc.com>
 <dj256lrkc4s5ylqkqdrak6a6p3v62ckkd3orsg7ykz2w6ugllg@rbfkojacklvx>
 <0d1aaba8-7736-497e-8424-84489c637914@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d1aaba8-7736-497e-8424-84489c637914@oss.qualcomm.com>
X-MBO-RS-META: hnpqbkrht6pxthkfq3htpiw4uki4eng8
X-MBO-RS-ID: 74da413a3d37fd97626

Hi,

Sorry I should have gave an update on this: I don't think the lockups are
related to this patch series, the same problem happens without applying these
patches. It seems to increase by a lot the chances that a GPU lockup happens at
start, however, so I could use that to debug the real problem.

> What firmware files are you using? ZAP surely comes from the Windows
> package, but what about GMU and SQE? Linux-firmware?
>
> Specifically, please provide the GMU version which is printed to dmesg
> on first GPU open

I'm using the firmwares imported from Windows, the Yoga Slim 7x is not in
linux-firmware. I understood that the firmware files used by the Slim 7x are
quite old, maybe it could be the problem.

The GMU version:

> [drm] Loaded GMU firmware v4.3.17

Thanks

--
Anthony Ruhier


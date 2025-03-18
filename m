Return-Path: <linux-pm+bounces-24250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 513CEA6749D
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 14:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D86165DED
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 13:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463A020CCD9;
	Tue, 18 Mar 2025 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LRqoEGFD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9652F37;
	Tue, 18 Mar 2025 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303586; cv=none; b=W1+zVrgdQUH5zc6GNgEC2GuPg2nrPAiX8ndn3A4E4msTU6vaSLa/rBJohaWCE2T8Ifclspwt3nA9oNeGnkM5YFldZX6Cq0451ZLhPwF2b1EChTxZCFWM8ShS9WU8dCimtfln4Q5N6wavZ/cZLFJXaKeRtyw+/UPFzpr2bRqn8J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303586; c=relaxed/simple;
	bh=/HeK63g0iYyyasg3EaGVQTNugRUsBjZZuBQoSIDHybM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZ518YB2RQt5I/uyUWYkeR0VcxLGHdRO/NnsB+Tze0B2wIbzWsNM22nU2DRVce8vvwvwt51RTLCn2t6MQ3Z9PQL7ejkTPynOiEUq0SQNSiD9We1KO/1I0eqA5MTFNyhK9VsZGj2ybilxCcoPUf25nOGqn/jEyMfeirO1DdomBYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LRqoEGFD; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZHC1y2V9Sz9shl;
	Tue, 18 Mar 2025 14:12:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1742303574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nZg7KYseVqSzxe03YTERtCQVwxfRyFFBlFRftXqUL1w=;
	b=LRqoEGFDgNtB9nYw2DcqGDcXJN5bec93E0w7/Ic/1C6vK1KeYaDcaANLrNwH/N57tQerEs
	N+iG1EXTXpET6md2gbIidZ4WwEqtH9dfVFArrjVDPuEo4cD9xXZBddC6Em+6lbYzelgai0
	ZHrZcB1s7DAmnteVnGwyXWnbfL/rB5KbvwazDlwnnlre4IWqwfZx22KQuMKh0jeSUbkH98
	VlLUdnpgUWs1hDEppuqCOsnVzMqH1qulShQtRK79LJId7TMtY15Xcw6pNVLfGPQlO+Dx7T
	XERPteHtO9hwoe7pSLUPYQ3rPJG8jp53nomJtq+yrYLL6BoSCoepbNVVqepMsQ==
Date: Tue, 18 Mar 2025 14:12:48 +0100
From: Anthony Ruhier <aruhier@mailbox.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Maya Matuszczyk <maccraft123mc@gmail.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/7] Support for GPU ACD feature on Adreno X1-85
Message-ID: <dj256lrkc4s5ylqkqdrak6a6p3v62ckkd3orsg7ykz2w6ugllg@rbfkojacklvx>
References: <20250109-gpu-acd-v4-0-08a5efaf4a23@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-gpu-acd-v4-0-08a5efaf4a23@quicinc.com>
X-MBO-RS-META: g43o4q78m7rpfhcwdtfye1rj1q8t7sc6
X-MBO-RS-ID: 137da8c6ec8de9572e9

Using this patch serie on 6.14-rc (tested over multiple RCs, up to rc7) on a
Yoga Slim 7x (x1e80100), I often get a video output freeze a few seconds after
my wayland compositor loads. I can still ssh into the laptop. I get these
kernel errors in loop:

	msm_dpu ae01000.display-controller: [drm:hangcheck_handler [msm]] *ERROR* 67.5.12.1: hangcheck detected gpu lockup rb 0!
	msm_dpu ae01000.display-controller: [drm:hangcheck_handler [msm]] *ERROR* 67.5.12.1:     completed fence: 777
	msm_dpu ae01000.display-controller: [drm:hangcheck_handler [msm]] *ERROR* 67.5.12.1:     submitted fence: 778

Rob Clark recommended to me to remove the higher GPU frequencies added by this
patch (1.25Ghz and 1.175 Ghz). The lockups happen then less often, but are
still present. It is easily reproducible.

A way to mitigate the problem is by constantly moving my cursor during a few
seconds after my wayland session starts, then no freeze happens. Reverting this
patch serie fixes the problem.

Thanks,

--
Anthony Ruhier


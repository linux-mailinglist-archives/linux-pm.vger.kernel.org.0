Return-Path: <linux-pm+bounces-41213-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAvxN017cGktYAAAu9opvQ
	(envelope-from <linux-pm+bounces-41213-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 08:07:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ABC52983
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 08:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 964F64E24E7
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 07:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCE744CF42;
	Wed, 21 Jan 2026 07:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fmm91OLL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5B33F381
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979245; cv=none; b=IihMBz+kw5wZVViJsZBZzaWJJu9/1JMj0L40mIFxk4/NmeXbTPLwDR/3u0WDBbwuvNupPTfHrqmbeN+9tz2+pC68rsB8GZDyMMtqt5pi0O9punh6OfMD4xg6y1lpQpBVXA3PIG4sKubOUqWtu7b9nRd5NcAiwG6LdhcGpuxArms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979245; c=relaxed/simple;
	bh=3vZWeqb1PFQC1eAlnP8mrvwsQV20ikgQpMxSZkinDXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTEwAlM3I/qet51/RZSp+CA2pGyvtTTcKiiEGQzYzpneVY3aDkUjAKYL6dSrTi/rQzKGXU+W+gkpPKTTrTmIEaDLNxbrQa52PKWzgwLHG+ibPGfgOGA4OK3g7J5Pl9xRNbua5LjZr6dcborPCGviCSL4h9M53c9T1SuoaAxcCHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fmm91OLL; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c5513f598c0so2409801a12.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 23:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768979240; x=1769584040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EKCBa6LC63ySO6wxtyOEHj7+hfHaWtIUCg/hVqZDPyQ=;
        b=Fmm91OLLBUQtgi7PoVtjkJCzIHrr89hHI6aai530le0QiIew/Z1zbwDEUWuWrQiyWq
         jGcma/paQZNmXoUUkyNBY7YfYPX+55fMD+c7F4yJ4qxhWtz1a8QueXJ4OzxJOeD8GTgE
         H5kPk1AAOjHs1UxaAwjWRDgw2lzQRVkh2I9eWZOoEKBgNaiXCF8tavMCBGAT3DywwtUT
         CvaNRejNW0BFPLkSnURTPQ4gd4jq4P2Qej/QsoCveAeUtwlYz5ch3n1Gy5V2rY6lH6RY
         3tXQTR+dujKdDBwGUDOluNIQCFY5N1isJTIr0R05hN2IZwE10tmpJg+k1ywLTchlaoOQ
         p0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768979240; x=1769584040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKCBa6LC63ySO6wxtyOEHj7+hfHaWtIUCg/hVqZDPyQ=;
        b=T8lg5FtOgKiAUCwS9QnFwO25Q4wjbwkQkpylbLL0eSRVFny2R37vudjFOBl6zlhIxs
         thnOZ3wb1Uz5NWkX4o9xzVGmVhXSUu3ECwA+jfzeREFcRTj0dt9RMe4AsOos8B6awtTS
         cZ6HI7CLmxrWS3GJsuCP1NDNbtBf03r2DyPv/yZYieL8NyMTKC8I8szmCa40aH92hAmj
         i2yxZka6xTVXiq5ub4WDJVBUAVMe9IM15aR215OsD2W+6IdhiDu7A7if/t7uFoHJ/7kg
         99qCBdSUjfgWShRTmVVavbPFVZqDlLyKjNcbYAhcfVQhQXH9rvDRTYTKivmEwZPn51Of
         uQDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3e7lcrmfMIbN9hh9+NSZbHJq6Hfd/KdB3ckM0CLxaQzLH2fND9jgGkvIMawnqYRnUxgmURDf7Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzUQlhwLM3EujXWDDjRnoOT/ogZ1X6i2e/AnTtJqlWshZH+f5V
	rSd6oIBQySj2xFE11HEWAZo8q3FnI7ztHcq9gfAiIPiKILM1TeDzJ5zT3lZ/wceVcIs=
X-Gm-Gg: AZuq6aI8zj/3NUCndgvHIbNNaD5eWnJ8o9v7UDnLDhVo4rwsiVMFyFjr+KTEjMTgiB4
	bh986JnX9cJ26oxwRI2cVuewqrLQYXpPZyiKzg+imHjrPolwe2fhxYxg5FE87rl2od4b8O64xTC
	E5o3efk7j+ucoYfH/dvHA+/a6iYovIj56FOMCX4WkriDEC1X2dIbNBWPZLjM6tS7SSJNCmO2iBj
	h59pAaS/yiK9VNFbeLPxMbxT4Kvearg3NNdUiXVgXOMpBNhJr2UlEIzFsphRUJ3menEQJdaZuRV
	jsauZ26p8naEZXNAWioMyur+0fdHSVLmmfEs2A+LVPaxvpM4HUgw6ItgpW81RKxaSATIvnDU6wz
	265uhzt43p5k2C+NLMhrkOlQbDzfhqTFDvhBKzdAxLJJBSxavj+ICdwW5Zn5AKP1YtSrMlE7/BA
	ZY/JUPej8102Q=
X-Received: by 2002:a17:903:1110:b0:271:479d:3dcb with SMTP id d9443c01a7336-2a717518996mr160044275ad.6.1768979240300;
        Tue, 20 Jan 2026 23:07:20 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190c9f0dsm143860365ad.31.2026.01.20.23.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 23:07:19 -0800 (PST)
Date: Wed, 21 Jan 2026 12:37:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, Bryan Brattlof <bb@ti.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/3] cpufreq: ti: Add support for AM62L3 SoC
Message-ID: <jix4pxfxdxyald22fpobt2hmobox27z6fgroo4pevvt645kj44@s5lxh2ifo4q2>
References: <20260120-am62l-cpufreq-v3-0-8c69b80168a3@ti.com>
 <yjpk2duxzham3ky7bvsu3majkjlypkvnc23dsxenfx4ykejpcp@uuohmp63qhwk>
 <20260121063840.tngolbewageekveb@lcpd911>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121063840.tngolbewageekveb@lcpd911>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41213-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linaro.org,none];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,linaro.org:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 87ABC52983
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21-01-26, 12:08, Dhruva Gole wrote:
> On Jan 21, 2026 at 11:58:23 +0530, Viresh Kumar wrote:
> > On 20-01-26, 17:17, Dhruva Gole wrote:
> > > Hello,
> > > 
> > > This series adds CPU frequency scaling support for the TI AM62L3 SoC.
> > > 
> > > The AM62L3 is a low-power, low-cost SoC from Texas Instruments. This
> > > series enables cpufreq support by:
> > > 1. Adding the SoC to the cpufreq-dt-platdev blocklist to prevent the generic driver from probing.
> > > 2. Extending the ti-cpufreq driver to support AM62L3 speed grading by reading the efuse.
> > > 3. Updating the device tree with the necessary operating points and clock configurations.
> > > 
> > > Tested on AM62L3 EVM [1]
> > > 
> > > [1] https://gist.github.com/DhruvaG2000/6dcceb80cf7bbd1e624ec210532538cb
> > > 
> > > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > 
> > I should be applying only patch 1 and 3 ?

Ahh, I meant 1 and 2.

> >From what I spoke with Nishanth yesterday, the DT patch (3/3) will have to go via
> his tree as it's ti-k3.
> 
> The first 2 patches are the cpufreq subsystem ones, once you apply those
> and they are integrated Nishanth can pick up the DT patch.

Applied. Thanks.

-- 
viresh


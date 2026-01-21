Return-Path: <linux-pm+bounces-41211-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HK4FyxycGktYAAAu9opvQ
	(envelope-from <linux-pm+bounces-41211-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 07:29:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E2B520EA
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 07:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3AB244881BB
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 06:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D559C44104C;
	Wed, 21 Jan 2026 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sw6Umv+Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC4441036
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768976908; cv=none; b=LHjh4P+mlUDXg81sFZaveUCqEoy+GY4JYhy/qGjT578v/43cQn9Ois2KMAms2y5nDa0/jcMTOtsnwXx8GyH9XSL45XD6d8S/u1+icGvzrnknkpWVDkEXVfJQpOW+rz8ReDdIeHFeJXarUosyDvWnHYll5i4guT2bY01i8GlPEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768976908; c=relaxed/simple;
	bh=/mW7n+d/XrmZ+5y3MRLhUS4CokY126T3uBS0BXYSOS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RARFNBEK24O8SgO8JIs2FVx8fl/YldlCAmOyO3iBoCnmpHuYmJXRWUKbArdAwfg3Q7hfC8wfObe/JhNdL4yLbV9rkdACfdnBesllb/7ME6y39nwkBm1znsOEK9CcnO7hZw240hGbd/ym6oOq7JzZ8z3jfD149RsC43GgFYEqVnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sw6Umv+Z; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso2303509a12.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 22:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768976907; x=1769581707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S9uWl3rdprKmYKIlm9cQ5xrT6yJK0T/GUFytUde5C6o=;
        b=sw6Umv+ZvxpCWWPCAnZUjwQrx6Lp6swDCaCYwr2281hEYT4mCN4G/3tmqsM5CIZMnM
         sC2Z0gSUHInPKQSYLPaFeiC1U/+OuIupVQND07LhxtmP2MEAfIYqT0Ky7s1fyst3wPK5
         jusQkJrzLy3CDZ58bxW7d5jCGQI9mjFH9w4SR5U8fVSeTBCIG4cL1hfy4EoV/lNZs7Vk
         wvsbp8Ykcb530cJTnL2qr5G1tzad+x7bgAU/qcix7yo8AqgYXRsuUSZcNCys/FjbFT7N
         PMWdI9mrzOt2LXkc8f8OqC47OWI6B2PPgOGyn4AlbGPNMCzZmdyGaQR66RdUQLLwntGK
         ekbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768976907; x=1769581707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9uWl3rdprKmYKIlm9cQ5xrT6yJK0T/GUFytUde5C6o=;
        b=U4XBjLtb+2nexXXMbbx0xyOPlS/ik7/YkSVDhcGIWldsb1FY4H++2Z8iiXkIkB2Qef
         4AVXE+mkYYdTdqmV55hSz0/DKAwMUphRRotVslAMUdDbUcBP3Wux+stECZw2ZEEqjHZe
         /+7x8aZzOkacZCXlADlGnVoU39of+Et8YG+C+DmYsKzjoyyuHctR1D/2ukNnft/UZOFw
         gzMp6lF4egbLtrx7e31JhqMtwQEnlPKTNQsKPiia7XwYjwJLv8Vc/QGR/Z96pCvAwZ5f
         gil7EcZzusIMy2AOVr+Yxe6swxv9ObIqKQXV4MKJRzapFzE4/YyITVToVOecu6bN8+Qo
         YN5A==
X-Forwarded-Encrypted: i=1; AJvYcCWuvC4lSS0Z6+zj7poP+WO6ldHVBQT3pnSxH6kLEZXJF4AqvbiYAVJLH4iYaCP2Fq6YCCCsOtEbTA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym6vbIMlGmYWjz5Pt28MOTdR0qsk6MQlgqCvOLhSDxjHCyOLCr
	LlbbdVWIAAQme0ZV20NlMhzvIidwI3WkpU9jIoZFS4Z15HZyUOqdBmh4KBR4LVi6r3U=
X-Gm-Gg: AZuq6aJB7EvV9gcYcKMuT3YwdxTU8c7pbKIDV/CPlwYjphCuShfvPu839Gk4n508+Oo
	pIre/QWZOkceKBfCU3tgv3Sr+KYsctlia1ssrB7SH+ihR7JS6QBeDmJZX+dKQseFZ+PKsg7/1bV
	5ok2tJ4qZP2fd4SnZCUlZDH1hXX/5NO5J9291Vguw1HDH4NzMTf7/3v6H0WysWlaX8Ffve0DkAs
	Kb4k4VtmEGQ9A1PxFPxg3fgzRgyYPIBSNtX4T+6ZAfaSI27YYRowQJ2hbim64xDWYHjwNcu851x
	7B++kfdk5EmCiobNu57uMbi8trq0K6ZJEO38vQF3qgkz+bhhCOoeEHsTTbtE9NxuF27mqQWaTP0
	frMVvP0rN6ODQqP9sUdimSMF+4pcVjil+eznMXSNrD78CrMjJRMPkql7qpXI2+6DSx9ie4R2Bn3
	V7kgaC3/Yrxd0=
X-Received: by 2002:a17:90b:1e09:b0:34a:a1c1:90a0 with SMTP id 98e67ed59e1d1-35272fbe02amr13383022a91.28.1768976906418;
        Tue, 20 Jan 2026 22:28:26 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352c403b7e4sm3875019a91.6.2026.01.20.22.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 22:28:25 -0800 (PST)
Date: Wed, 21 Jan 2026 11:58:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, Bryan Brattlof <bb@ti.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/3] cpufreq: ti: Add support for AM62L3 SoC
Message-ID: <yjpk2duxzham3ky7bvsu3majkjlypkvnc23dsxenfx4ykejpcp@uuohmp63qhwk>
References: <20260120-am62l-cpufreq-v3-0-8c69b80168a3@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120-am62l-cpufreq-v3-0-8c69b80168a3@ti.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41211-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,ti.com:email]
X-Rspamd-Queue-Id: 42E2B520EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 20-01-26, 17:17, Dhruva Gole wrote:
> Hello,
> 
> This series adds CPU frequency scaling support for the TI AM62L3 SoC.
> 
> The AM62L3 is a low-power, low-cost SoC from Texas Instruments. This
> series enables cpufreq support by:
> 1. Adding the SoC to the cpufreq-dt-platdev blocklist to prevent the generic driver from probing.
> 2. Extending the ti-cpufreq driver to support AM62L3 speed grading by reading the efuse.
> 3. Updating the device tree with the necessary operating points and clock configurations.
> 
> Tested on AM62L3 EVM [1]
> 
> [1] https://gist.github.com/DhruvaG2000/6dcceb80cf7bbd1e624ec210532538cb
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

I should be applying only patch 1 and 3 ?

-- 
viresh


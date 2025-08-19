Return-Path: <linux-pm+bounces-32595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1452B2B8AC
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 07:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F5FF7A34F3
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 05:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7D827B34B;
	Tue, 19 Aug 2025 05:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnbZ3Fic"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B41DF254
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 05:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755581454; cv=none; b=IgITxrmIPCeTWSa7txnGzRkI6PA4Y4ftLQloGsXRatBgQjt2PJUSElX8vN27iXMEhXvYraM3BcGWyixurW1HNLiMlTi+GOYjlanCHR4quz5gogI+CYu63EeITU0nC6xbhCiVDCvTYgAV1admnguOGHB4l5y+hlakQS+J+N/rXfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755581454; c=relaxed/simple;
	bh=oNuneXdZUlONgY1eNYoigbQuliKO+uoIkFsryOlJJn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvkgi7cx3XNgGVzzzyzJWu59b6yxORxifzyvvdM4IBTkTPhdat4zEtkzbvZIT8m26ACcSsKPa0J4zO+DMyESHLU5lQOoQwBfy3EGhJXya2hbKny5nQaUN1eGA4m2nGafsUwIZcJlIjrRPyuC9VOZ4SgM3UtLbJ7Vw8TtuJaQaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hnbZ3Fic; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso308838a12.3
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 22:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755581451; x=1756186251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHADKkUG74H8DgiMJwyJ3n8CdyNUxQbiZqR+ru3KJ5g=;
        b=hnbZ3FicBWQkEZAt8mqK0GO8hIz5fuWZI+2XtjjQJsU+s8siymP4u9x+Kw2j4jsTsV
         XGpef7JJks/GdnRk2Y0Gfg/QBDTt1S/wnEFzsrKh4QDgfuD483t8Mfy2yo9cjEAkdwqI
         3ldddc0U6qxYys/0iXaxysfUZtR6TdZGVOl7DURwIc8qBPNnacSf1K4G5SB36hSrPh1t
         W3LsLyFCoh/Wb2cxNZWdA6YFPtUvYnPRpkHy94lpDX5HitlBdYwLlFFI3zUe+HMu9Hmf
         vdTCkJzxXtUVQhBFttkYEmxw3pNckby1XpUta9yUN4FsLk6FsTJhzAdCnAtBOL+vBtec
         B3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755581451; x=1756186251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHADKkUG74H8DgiMJwyJ3n8CdyNUxQbiZqR+ru3KJ5g=;
        b=HQpFoRB3Ot1Y0l91xZpbpn/YnnIIiqhGLnpD5CtFFxAINQJctX48XcAPnn00Xz/9tY
         G207yEFBA9Q1CAcPkiYtJyk2HS+hg8Qmhe3yEGPhnLx9f+RsegPKLDYtRBXtKNyWB+xe
         Mcsn1PFK2do2Zw5vICOyin7BN+sIu5QgkUsYUYOSZJHNxIbwfhwqMhL6r59YlDCrpUR2
         DkPm+MIpjb26wcRaXXMMDzIs+BYmLEqRDSn0L2GImCANw5cWltFlFWl1UqMaOXWAi7Wj
         RYU8TYc7smPTOCT6O3Zdwtrp/TRE9sZCYhaddzCcJArIjLQG1Fthmmh9no6Mcvb2r9c1
         P6wA==
X-Forwarded-Encrypted: i=1; AJvYcCXD+EqVe0yAUpwTOYsdiKNW3Oodg+LjluHnlLZ77YxXJgEoqpiXT9Jrin54C7Rb/fddg2HyjVJkPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNaHGAyL/bEkJ5jWOM4aTaDYBJL+8+3+fwwls521qMllnfO+X
	QWQgO310CB50jdTedPuOLx2LXf+8+Is65uOrzRI8dWZBTtJ+nKMGZlPjbITBFeXqaBE=
X-Gm-Gg: ASbGncupXQRae6L3npVmRWHvaXESLriXcAfBavZpaLjHH9A6Vbhn6XuJaZUzoRNki8i
	7GN22GB67ry/vxZnDH9PG4/9QDAciMDgYtY0u18JOdtZv7JXMuMPFPPupY+lp0Dz22QxDbmd5O9
	E2575ORxBV28ryLTtcJrUMDCSD+nS/NcOEb8/cxrMTE1MR0DwwAI9E9cciM4pDFjq9hUdFf9i5m
	vtTfggjkDWAEFpaQDHr/3+LdYCX3UMM/wamtWrVs9hmeAi7GiGnoZpkJPnJb4OVv4l8uESdK+0s
	deWeVpHharaJDviQC39attiLxQDqB7nzkucepMeQgDw84UDXPQPhQ+6HsHXjg/x7QmPg67kIEe4
	P8WYBiaZm6XadjgtDe4p0Mgii6MuNnk592qk=
X-Google-Smtp-Source: AGHT+IERt6oCE4RMNflHw7TCKFgdRx6IB0LQJLR9mIihyCp5VdPHl033jFifzhuL917Po4PZMKKnDg==
X-Received: by 2002:a17:903:290:b0:243:38d:b3c5 with SMTP id d9443c01a7336-245e04ca7bfmr18923145ad.47.1755581451291;
        Mon, 18 Aug 2025 22:30:51 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f55esm97139685ad.82.2025.08.18.22.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:30:50 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:00:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mike Tipton <quic_mdtipton@quicinc.com>,
	Peng Fan <peng.fan@nxp.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: scmi: Account for malformed DT in
 scmi_dev_used_by_cpus()
Message-ID: <20250819053048.t3dfmyu2xqd4ypef@vireshk-i7>
References: <20250818155048.551054-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818155048.551054-1-florian.fainelli@broadcom.com>

On 18-08-25, 08:50, Florian Fainelli wrote:
> Broadcom STB platforms were early adopters (2017) of the SCMI framework and as
> a result, not all deployed systems have a Device Tree entry where SCMI
> protocol 0x13 (PERFORMANCE) is declared as a clock provider, nor are the
> CPU Device Tree node(s) referencing protocol 0x13 as their clock
> provider. This was clarified in commit e11c480b6df1 ("dt-bindings:
> firmware: arm,scmi: Extend bindings for protocol@13") in 2023.
> 
> For those platforms, we allow the checks done by scmi_dev_used_by_cpus()
> to continue, and in the event of not having done an early return, we key
> off the documented compatible string and give them a pass to continue to
> use scmi-cpufreq.
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Fixes: 6c9bb8692272 ("cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Applied. Thanks.

-- 
viresh


Return-Path: <linux-pm+bounces-8338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2E48D2DDC
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 09:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6397D1F213C2
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 07:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9889F1649BE;
	Wed, 29 May 2024 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABCHHcqy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBDA17E8F0
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966768; cv=none; b=qqr4DkwJsXUUMKZ69yDs+zI3NqFOMIb5AJoYK7CYaElW1VB8I8tp4fXHxp2oTeNg3zAJLdT+uqRcLD+ljgEL9m6v0OoA0xaO01u28teIiPvQ2beoS6QvxNMSXYz9jGVwxaxOMauaiVXtjfJnPivL3VA0R9vYJ7A0/4GmYxxNvTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966768; c=relaxed/simple;
	bh=cAQbvBmUpMCA3gTxY1IDXFVX17vOV0Rw+rnvXDMYKiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O52AFulTewnZxfxUiePKhoUHBhmzyiIcy0yx4u2SPl2jgLnjAWkiuZJtuGU+2CLzjUQR9+Agm3Sjxe25nlaYoLP9erapBJK/3oUz3IB+GtxgLsNv4/7mMZSxIl5xPTehBfeJFIzZNxZw4dvEDIiCxTEnRS9L4gnrpyShMMGlrmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ABCHHcqy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f4c7b022f8so14643545ad.1
        for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 00:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716966766; x=1717571566; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q6bYzyZnFYI4qrsZB34ycSG1lMjbB+dLnkiJDJkyrtc=;
        b=ABCHHcqyf7tcOOdhjgl6YVaIW0brYMjmgedFmpqM0BzLF28Hp+Y8crXOpp+gymYupr
         fzObq6gNQ7Gnm556LEjXZh0AgaLdXYcGv8+ur9htYjxg/X9q+URJWe3d//Qv1ubsrP+J
         w/dA+ObFFTblwFO/kq38sAK9NYOhE/2EIISLEKZz1UuQ3m6IlzpUmfaOr6gR28zbVhzs
         SIMwIGF66Y4CzzyIWbJTpBT76WWRrVo3c8tz/XuQZch3/yG84Iudp5jGVKa9lm1fHIhM
         i/3PwXLIBtDJRyzhO4niEagOR+ESWBiXWzH48k7JLeRbkQvyUP44SXH065VZjnRq+HcI
         K3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716966766; x=1717571566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6bYzyZnFYI4qrsZB34ycSG1lMjbB+dLnkiJDJkyrtc=;
        b=WLCMd+Wnj9EmSXoyoaqDOV8MG5gYWxdYJi6+m1c628NTY5gx5b7ep6ENZBLFlWK3Ev
         SHDHp6a6wk+DggEGz3Ia5kvjKY53oULw7Rov20hUirTWdvZ1jGSvdnHAF2Jks+E9Tj5S
         U/wZwFXcYtp9rNTvjOvq0Mw132zFcsPVTImN++tjTVUm+v0e5zD8ONaCETcvEtnPNxdF
         JuVduB9ZZ21JAJdV67emlG9pnE2YHDVR5kEQxnUYCFLjXcP57HOK+bazPcTH8n3qKksS
         jBMub8R+NjS/8aQ/EWwlD1YzbLKWQZxN9Htjzrxudt8oRTFRxsgp2QKoC9nv8xr/6ery
         TDCw==
X-Forwarded-Encrypted: i=1; AJvYcCUTz8j9103hirlbfCPu4fvkvVCOFUNHS5SZSTafOIiKeUxy6qVhZlQbZx5RF4pRFUzSoI2hCt0aVOZ+wha8RUs4xnynQ5e6zww=
X-Gm-Message-State: AOJu0YyzVdxKayYcnUWgfmTqKS8YzgeOZ6slVdyXhnhFP6Ze1lrEcn04
	ZypYngWG6CKQWdSINFrnxXZxdR4kkNUu6sUzgSNqAmE6cO21WkDmBPbAnuKsZk0=
X-Google-Smtp-Source: AGHT+IGOx08QOgH9vGWV/sdBcKu2pC7HV9WSYJng84PKel9YyN7krOr89/wBNKSivHft3W7MyULAJg==
X-Received: by 2002:a17:902:e750:b0:1f4:7d47:b889 with SMTP id d9443c01a7336-1f47d47bd5emr119995205ad.30.1716966766454;
        Wed, 29 May 2024 00:12:46 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f477d337cdsm67413355ad.71.2024.05.29.00.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:12:45 -0700 (PDT)
Date: Wed, 29 May 2024 12:42:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Riwen Lu <luriwen@hotmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v2] cpufreq/cppc: Take policy->cur into judge when set
 target
Message-ID: <20240529071244.vwognqagaa4347dm@vireshk-i7>
References: <TYCP286MB24861BA890594C119892FB3DB1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
 <20240529053652.pzcjoyor7i23qc4i@vireshk-i7>
 <TYCP286MB248669BCAD7A7E54C5071EF9B1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCP286MB248669BCAD7A7E54C5071EF9B1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>

On 29-05-24, 14:53, Riwen Lu wrote:
> Yes, you are right， I didn't think it through. In this circumstance, the
> policy->cur is the highest frequency, desired_perf converted from
> target_freq is the same with cpu_data->perf_ctrls.desired_perf which
> shouldn't.

Please investigate more and see where the real problem is.

-- 
viresh


Return-Path: <linux-pm+bounces-30866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC8DB05DA1
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 15:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A099E500552
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 13:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D4C2EA470;
	Tue, 15 Jul 2025 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYThkK26"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F82E3AF6
	for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586421; cv=none; b=c0e/AS0ziLudSSbaZKrR5NvlC1m1Tf4bLNK3W6fUhBzxb1x1aSbd+QBSVhayEEwc+oEicCKydMrdkHzifD6kPqX99aIOhJtrDM7h8e4zf+PRFPYNt8BvW8XuHm/Ux4LZY0utHQr7AfM39f9gJ46L77eki1LcTDTDzJBHycpV2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586421; c=relaxed/simple;
	bh=rzsle0lYd4q3WFkhEa4uKuNyg+mZnvPoF11bTF7RytI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apbQb6sJR/hxur31M61ZGZF74U/eDHLzSGicPzhVkoPbcmxg4jZ+zAr7L95b/8CFVcXQYghJi0HPwhBL8xAkXSAuoI9z2yRtnxkzCoIqe2+2jatqWg0NCLBFB7jOqniBp9vHZv8TyLwkmpRTycTtuYvzjoLYDpPLsLkNNxQJBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WYThkK26; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455e6fb8057so41829855e9.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 06:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752586418; x=1753191218; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z+O2OICZ/PuWhWK3KhlIFVSdYJvPOM1EVW/PgJZfT+M=;
        b=WYThkK26Z7Ql11GhNHA5izeyQuY5s7b6yi7lhD7yjRlPbvptZHkgeNewrwPcS+pYVw
         1l1BkwnX00vGRAHEjAovJeF8otaJMtVvU9BZw4/8htpxshpNf1o6zLtJHBvnxOFkW/kU
         IEMmuSNhu1vsXhTCVi8yXzGGMfDoosNrVZHb4s/K6CjmLsma/rhqmrBBwPw3ElsDaDUB
         Ud7XP6E2Wh3j88qZKLEgtwfWjNWhyqP8xb+cF2QxPzwcMjywc1lYD/4rDfyzTCJAwk/r
         zer7cd/bykVGOFHOsxCc66QExUyhYNIJdO3ZhDqAbrhPZDH+cV5c5IHpI7pHLTvDbf+y
         MOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752586418; x=1753191218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+O2OICZ/PuWhWK3KhlIFVSdYJvPOM1EVW/PgJZfT+M=;
        b=gSci7IhA9r//w6P8914CfnRmDZlFDMItAv65Wj7L5DTTzJJ3OSNrmODtg+T5CaCk+P
         jpClDdavEPBv9iqRV89+cxyskWGxCcFQkxtplosqzLO/l/1GzrtUo3pv1ZbnjvyTrwVI
         4Dyt0anun8UytAJ+DRZ69VeYIpFkoYGIE+vtKr74tnYOd37U8NYRqGPxH3rFSRapAUnp
         Qilur7KKzTMrGkDGBqW2KvpsugJik08+AsSnE+U8/Xy/rAkBKaxMmbzJnSgV53wGKx/G
         ZTq7wpqdzwenJYaLi7S42Jy+owH3VjqwyJUnj2CRqAMpktVbanSmg6PXMaSUn7kDiTUg
         POHA==
X-Forwarded-Encrypted: i=1; AJvYcCUHuKS/kg4kGBSm+dDH67Tx76AGyaXA6UAMYqCehTpKqsygWGVL6DHILqDagLrXi8vE3M2Ej8oPcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2juKABSSZKUve/+0bnzbNhyNs5fUPGsC/jSBG/UshPKzIKdiB
	PSkr/rKw7L8gF+5Rgvh8gj/k5Nyu11fp9rKkvlL87+xxsj4ms2hmxFo3YHTsekvetQU=
X-Gm-Gg: ASbGncuIXd93UpMcfgqM0POc9oxKVXcKZT0DlQdnyN9vSfoHtKJACyXcJC4mmuPugmG
	pHdco9pJdJHIHBeNzhuFJXKkNIT4WdXjDk/8LAx/9BfH2Af0v0mOecv4IZYnxWJGPK2h2TmBDkl
	JCcs621Yj9x+4xp0DdVQe9id9X1ojqZvv5Vf0oFqHn+RIIqrA0g7CG/zHRzMq/nPsGRFenvMRtb
	Rn1HdqkhSKE5k63CTHuIc51VoCD4yb4uWjDokG75k2XuscMWNvQr3HYe8OcFIF1W++VvRbjxqJC
	MR+vGVO8LFa6GGA+0u6gyy3WxZ6LA1feCl4g3JCH2hM7kosFyimYKsXYuG5gHV0Xh6z9grZmj7L
	PYL+ECZxLOHsX46QLd0yLM2+E6HMrnx7Esb/1pJx0SCVOZPUh6RnW8H/99Cxr
X-Google-Smtp-Source: AGHT+IENtk1fZji7615Bpw3kcLK5xTHsi34/FWdDqEiS6WLHvSySQx5nMasrQRvOYBkeNVG7ZeVurg==
X-Received: by 2002:a05:600c:4e51:b0:455:eda0:8a8e with SMTP id 5b1f17b1804b1-455eda08c8dmr128078735e9.27.1752586418167;
        Tue, 15 Jul 2025 06:33:38 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50ded8csm199491555e9.20.2025.07.15.06.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:33:37 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:33:35 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal: Use dev_fwnode()
Message-ID: <aHZYrxabtU-7l2FB@mai.linaro.org>
References: <20250611104348.192092-1-jirislaby@kernel.org>
 <20250611104348.192092-20-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611104348.192092-20-jirislaby@kernel.org>

On Wed, Jun 11, 2025 at 12:43:48PM +0200, Jiri Slaby (SUSE) wrote:
> irq_domain_create_simple() takes fwnode as the first argument. It can be
> extracted from the struct device using dev_fwnode() helper instead of
> using of_node with of_fwnode_handle().
> 
> So use the dev_fwnode() helper.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> ---
> Cc: linux-pm@vger.kernel.org
> ---

Applied, thanks

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


Return-Path: <linux-pm+bounces-32212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDB2B21C35
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 06:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAD962631F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 04:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983BA28505D;
	Tue, 12 Aug 2025 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtEkAWmM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1012CDBE
	for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974014; cv=none; b=iqOBayTmJhyhCQfSqnG9+eA+cQz0R3MgfZ9J24WXcwuQzlGccNi3ZQhyGHa9rY6WYklp3e3i7UUl77TLMA0xdNGltbOdm+U4eXBnOorDwCidpuFjqtJordCtBZ50Gmn1sMJrtwKBzKAdSUYcPMKxPddREyFz31ggsWb987+vC/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974014; c=relaxed/simple;
	bh=wC3ytpNQLFhZ9ExmBiZv2b74og9kvNU1YGCPkEuFVYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tjf4raLQ39jvcDARSHtpSuFbtRnry1SZrTnHQ7B74clhAq1jXKCET/0F2kKXQlUHr1kdQBght5jsAHzJyyhXhDsy6S6PbgIpCyYfRrGADdm+NYcWL2zaOHZvh1ECi37b+/sg/d5ahZ4QXuJbWF1fCEFv97B7YLBFhxoJrrk4lJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mtEkAWmM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-321265ae417so5614400a91.2
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 21:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754974012; x=1755578812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/PAp/p0CKEU1PLaC2oOhrdXss1JcDMsVFpCnTxkIB8I=;
        b=mtEkAWmMoD3Trl0Q+VzN1HOiZcJw4vXeUCB5pfADvIHMbGRFsQXIxJu9T31YUGDv5T
         YH6KGH914GnyqyAYkgpWumapQdTT0u8r/7/yoANfqZnU7r1Sq6s1e6XNXWX1+B2PqziF
         mFm5TcP/EcgsWtUaJiDJvWgOCjNZDEeoLDHY5ijqbGIu2UJE4lgqCJKnUfR699X9dtW9
         IHo6PaWpcrQhR9UrNiyU9dZLq0/IgUOxxS+o6rI0ajnoSy7raBPEolSvnsNCoCJ7Vp/6
         YMO9ofWHfOeeiMZnUf89QcntlBKSSP6FBvNJbK5mQv190bgUo4Kl6VzfoWX5XlUy/VO7
         5OGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754974012; x=1755578812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PAp/p0CKEU1PLaC2oOhrdXss1JcDMsVFpCnTxkIB8I=;
        b=GYpDm5w4hTLMnVw2kQDVuKPINws2GgG0ZcX1tOOyO0iVANaOy330ct5PwqxAHKaamP
         PIWn+5f6dWaB24d4+Wcfzif7iD0pI5ePU3bfbsSbQ+LUgnTjOw8H/YBLLvYvAgtxVBJc
         4QokDJBvTbbOxZFwDyTmbyk/icw4VOo4OD/XK9eINasmkULrCGwHZhuBjH6dPWrf7z/c
         bDdDJy7n2XdQvTXRtdKTzX+wU3F6BKzFyfl18nFVOIV/PePrJvcehbw5BtEw6Qqn2SFS
         x98vkLvMZF+M4F22+QTknyHCgouI71xk7LI9rZE+HI2gI3E98gsfCaltrdPGLCVM0UCX
         uGlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVwX8Ql0RpE0E+tLq3qflrutRKEJk9dE6QOxGYBwrb4Of7zJW4UFmIr+5ZxCe5LyserZKm36SdJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzurfrM2hpZCyyAndnVhrvxswGck4IxmsKCapg/zoYWtqKS3D3V
	1wJ4fiNjtUOmrJyYrEHqeCfgzZgDmHSVfptED8Sa1QDh73F75wlvF/8JqoatGuvP5qg=
X-Gm-Gg: ASbGncuvmplAQcFZES4XSooth7rC0iYIgqF4Ee60StNNMZR8ilM+NjMI34eVya9pWxh
	EwYmQBZFcANW3aU3MaqTN/k0U9G8VAbWkk1GTGKVBe0uT1GR90hFtQGF2orHYJh+BZqy/AFCVbf
	P7TpCbYH1YbBfEW6iWWoZzy4ChWEsFj6EcLyvrH0o971RE7xbHGo1cKkHy27hLMHxZI9dpReLsc
	zf4/laEoae/HzyT0jMD2nb+mHA7r0IxGXbFMOn8qizMG/p96T3r1/FKKolfsTyyrjnGYYKgdPSF
	elpVdlbmoOvtznozYSbV5Zsc/tZ1EWFYJT+UJZNKSE+5ZSkj1Knu++BL9YSIHY2mhNhh/nasssK
	qmwBEXXcaSkzcZBRHSKa6VUHu
X-Google-Smtp-Source: AGHT+IGjPX0id8Dv8vez0mnwgena9eAtzVTtJZ9HyxZHou00TWOaELyAHtHLqaUQtbKMZdNuqWLIpA==
X-Received: by 2002:a17:90b:55ce:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-321c0a6d1c0mr3313417a91.15.1754974012349;
        Mon, 11 Aug 2025 21:46:52 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161282ab6sm16525053a91.26.2025.08.11.21.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 21:46:51 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:16:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Taniya Das <quic_tdas@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCS615
 compatible
Message-ID: <20250812044648.7rifiugfjrdso6f6@vireshk-i7>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250702-qcs615-mm-cpu-dt-v4-v5-1-df24896cbb26@quicinc.com>
 <3xki62glazqka7gngvrz3jifk36vkjlqjm6gv4mg7lqbhnnlsa@ryxyt2pcsfk2>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3xki62glazqka7gngvrz3jifk36vkjlqjm6gv4mg7lqbhnnlsa@ryxyt2pcsfk2>

On 11-08-25, 22:46, Bjorn Andersson wrote:
> On Wed, Jul 02, 2025 at 02:43:09PM +0530, Taniya Das wrote:
> > Document compatible for cpufreq hardware on Qualcomm QCS615 platform.
> > 
> 
> @Viresh, @Rafael. Please merge this binding patch through your trees.

Applied. Thanks.

-- 
viresh


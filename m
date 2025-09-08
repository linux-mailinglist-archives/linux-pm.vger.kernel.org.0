Return-Path: <linux-pm+bounces-34127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13706B48496
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 08:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63F83BB1AD
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 06:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFECB2E3B07;
	Mon,  8 Sep 2025 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCDATx/3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1A2E22B5
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314600; cv=none; b=qyil+wk+FsSFfVQ5/89TV8oI63ZFJpk3Cm/sv/sCrCtdc+sRwik9Up/97JVbK28gfDBBkOi772WMJCd3WCPQDMqPfbLMgH1pDc5B+lmyXRTYHVhsuVPcN8om3PwkOy+MlcmXO1LmzhiCLRmOiFHbgUle4uc0nOQiqRj0KbDFHwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314600; c=relaxed/simple;
	bh=Csq17eCLJmv7/7QqayNfbYw3ZtrTeNIABT5r2MMdoUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSPMXSqcr5r2hwh3MR/XsDUsi2/cW+MXdbfLyTY/3I9i3IRrLsB5vlmQOwclMHiKINkH2PI1yjm7wu9ERedVOz3nfRuBlOFL1Q+6piJ6Ieu6Glrs4Hyz4ZGUiovx8w0nDlyIBnI/t4IngesQ4I6bKayAhH5/t7jJNDw+4f2H3Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mCDATx/3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445806e03cso52728615ad.1
        for <linux-pm@vger.kernel.org>; Sun, 07 Sep 2025 23:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757314597; x=1757919397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vfO9YzOQHvlcLzI/Oqj9hLG6esUOkytAkeiwFxmfpUM=;
        b=mCDATx/3yiX1K5qsI/04JjsJivHS4KLolpgblY0iOgK/9Zq+BSieBrZtQLVO0Je/ke
         McavgOlHN+BUVOpD+oxZjjwEymV9gaD0mMBDdCr85p3TrUJlFjmbOdK43DBycCFsI3ZD
         Vjj23N7CES8gSNHEl8PutjuSWBoaZ+JbxFm6UhdF8X72cpLYI/vnxcgvsx/1/lBw7pb/
         lz0Y7BJmn9JPQj82NBmoxl79rKYZMoYbA/kMcfHGPLVCG8Mbzx7LisyXKuTPbn80mSzC
         cCgSLUMCPr0VFZZTUL0uTs0dBqjD6sNcvpCaz2GeEXb5q6aqBwrY9AmJ8NIJbaCr74bd
         QOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757314597; x=1757919397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfO9YzOQHvlcLzI/Oqj9hLG6esUOkytAkeiwFxmfpUM=;
        b=nSY4bh7iBlaxVqt4uRmxDF6pdzm1o49offyZBQ9hlepdd3vaR+0KA6cX3bXWqgEllB
         tMb+r9UbjYbnrT8bPAqkYl05Z9FJ7fFt75RC3bLcsFA8MxolGHZQRpD5jFbj8B7D613I
         KgbMbWU+cIQuCTTJHnBOaj7svoOg7EBU4x0+Po4u09s7iKH2UQbZFDe4YFeRvaToV997
         a789vjbd50Y2Uh3QMei0vIlwXe98HqunQaWESYtRSpm6fFqyxBIOo9e+EQBF4iUytQMC
         52q+8bn4VyBs/Yjj+pZzg5cQb5XhOu3HnvjCj5TgvQB37XjqlLfgvyH8MFIsfeFk1Myg
         +OTg==
X-Forwarded-Encrypted: i=1; AJvYcCU3GOQ3qtWl9I056PlF2JPC0LfKQDgf9qyeSkE+elYIxoz1cP/qlVId6EKm4eYbg7ADnLJ/jL96fg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTr735uwYxO8G1FXi1dMwoNvtKjOfP/c7PTXuQtSzlP/9CIlCg
	NfsVcwnD7/yR4O9sbnmedDcq2XrJxbplSzs/V3pCwXDj2nTHc26RoEl86DPsiFfHB2Q=
X-Gm-Gg: ASbGncuaIhnQzPwiGb+HJrEwPsfDWCbcxuLeeUsneMtW5XWKGTc+Ov1uCjEN+86L1fP
	p8ag8VfxKOqK3Y2xlnFYx/zZnm52DqVozQzIAHbTRmKZKmikbZ4hMLWPSTpce5fJpAPG/o+KMDJ
	zpxHivJlea4n5tesRMzXFtSwzbEuRo0+wsFcJV542HOH474gMuRVKUde5vse6jxMjRU7ZakzQiQ
	I5aaXEw7P3ke8D57SDpUmpgWhCZKkt0pO4mIvri8NRAWAWWmYkmj6M8JkY6DGcmM0UsysENEGr4
	c+Br7i10LS04q5RXqvsezbZaS81uToPBMdqCQnMf6hjaCna465xYUwZjmdXVpmEDr8e7fZvdhCP
	ioI1jHq/XPdojKKsGD2dbCuhcSZykOeKTnpk=
X-Google-Smtp-Source: AGHT+IEqN3OfxLAXjoh0BbnNn+jKgNAUzLVPIjM7aPLqTsUdL89FPCgDXAlE/ux9DfFsh6AFqBW7Pg==
X-Received: by 2002:a17:903:3805:b0:24a:9b12:5248 with SMTP id d9443c01a7336-25173ea1a3emr108269335ad.54.1757314597217;
        Sun, 07 Sep 2025 23:56:37 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b905689d1sm150907355ad.64.2025.09.07.23.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 23:56:36 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:26:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Vinod Koul <vkoul@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: cpufreq: qcom-hw: document Milos
 CPUFREQ Hardware
Message-ID: <20250908065634.m4p4tmjyb7h5bcfq@vireshk-i7>
References: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
 <20250905-sm7635-fp6-initial-v3-1-0117c2eff1b7@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-sm7635-fp6-initial-v3-1-0117c2eff1b7@fairphone.com>

On 05-09-25, 12:40, Luca Weiss wrote:
> Document the CPUFREQ Hardware on the Milos SoC.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh


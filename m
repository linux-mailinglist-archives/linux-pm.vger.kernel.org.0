Return-Path: <linux-pm+bounces-31249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8267FB0D0CB
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 06:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2A454076F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 04:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C98289E21;
	Tue, 22 Jul 2025 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wr/BPF+v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD323B60F
	for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 04:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753157451; cv=none; b=LEyErQTcXckG/81hux2rRncCXVsB+iYohR12AQXGZfhpsoVLC1Vh7hbzwL/1t6g6QPfstML5ms7gzTaa0ZY/HkfTe2Zql+xGHMar+SGzAOCxyfIki8N/N+3xVvqUK15dSzaFsZL9VnQ0T0WCUFwdynsbis4ug2a3rBOYAWm+pyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753157451; c=relaxed/simple;
	bh=OqCNRS+72uajszDzG6n+T34z5A+LL4ACekiWWd6EEzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfdR3Yo+E74QWROunb+xbEHAzl5YiVmwEhiQOaPdH7gnQuXbesoFR4lmyzrOf3BIg2blUDsml3KhHUV9NUHOK2vgBwiPhDzqX5u+1FNahXWupjGJoLB1LMSbJjIkEnc3S8mRMQVYpN9RQ9d0hhqUvyW4loiGPMeqbBBrBv8H9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wr/BPF+v; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b34a78bb6e7so3909522a12.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 21:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753157449; x=1753762249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nlBEY6HRx3gs6GmX9n8FOaCyjO7em88PtYwWGu+mg9c=;
        b=Wr/BPF+vf/8Jh980foQMoEUznzRA7ZAjuL3JQ+v8LvyydzqW1nNIZBWDXvAzE4qfAG
         xKz54LHvoq4IRfpFzYo2PWvqNb7t9Jsw5K5qRJl3rzI9EDyaMs+MAEx5wHm7BVGSJCni
         XBbs/wnGUmxlDyTtf6pIynJrBFtYJpk4pKxb7wvl/ct4gRuVTJXPB9WoVCdAMW3Z3RZK
         kA/r/AG90FM0V03YkXEJB5LwLCONJir1WUq7x2BkeFD/5LRLfr3bgZgBWqYN3ZGAQSsI
         uqa11XqJPLt0hXQmtGJHoCmLLj6v6MkaDP9QqdCCD5OrKqxIEpzhKbhOOWkiODpImmDh
         VqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753157449; x=1753762249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlBEY6HRx3gs6GmX9n8FOaCyjO7em88PtYwWGu+mg9c=;
        b=l+/jAgXx7KiXSEJazwFmSKzPZN6R8A82RCg5ZmMmQoeh4Ppl/NKwhL0Yvwae6QrUOY
         DAkbpvukiskyiV+vLUe2joBsylAOVxe4tiUYFlsI3xkoYyOU/fpUa1Nr19n8/gNr0x8E
         TMtvABBO0uiKqU6/E2lSLkE5tV8D+cFe+hR4rBWmchqiFDNe4uVD5Ql7p5/dj2+M9UuL
         uuEtG8nVOIgRdCeuXccc8odrpQLbza5XM6jjmYiJnoYEpSu6ALe59lA60wjNJAL6cS9D
         iTrxwpbabC9BVQwJpCsfPvImzuPcGrbwCnSioT3285TYBwNZ+7TIPV2Q4H+sT1rBHqJY
         BcSw==
X-Forwarded-Encrypted: i=1; AJvYcCXwdiqqSXrrUxal28LOm0eT0Yh5ZlClcqQkTzSOzwTB09HX702KmEwAlWazSDRIQMTGw+9UoUM6WA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzdMK+S2Lu0lvejSKAcvpdcJdfcMybyQik7hcx6X4HZi085JKd
	oDj9t2L5osOhDu1QhcIM1YqaunHvr402n3fuhVz1vnNTLWAGE5dazKASE81/NOSzKLY=
X-Gm-Gg: ASbGncsaV3ZXV7AGGpvMnZpYdD6B7UaP6Jc38r+m7n977aQoCUTVFuW3z7UhKTgdQvl
	1zCtorKHJhpUusBe//GzV1NoqnqHpGmKEAy7NRwc9VEx4iGqaiyRz33mjKr8kpTf6jiE3qBHHwE
	ni3uwgKA5y+6CMJcurFoD5ZQXTzvbSO8zFh4WKmOn1ynj++P/gF6klWUMeL1nrx6xKbbiRAAcOa
	oR+yqJJQ+pDNJO+vcUq6ipykx71Df9b5ioCviwVQxmsP5rdEwQTIsjGd7S6ENsTxm/Bif1X86Bs
	47LNOJUuppnHP/kJo1+7rfH0HpcXRurH/Z7bXIRaeZB79Vn/9On1m5nwz61jIYCNp9i4chZw74F
	ADUwg0QjF+uQ2km6WoweVxE37QiOrkAqbwA==
X-Google-Smtp-Source: AGHT+IHOKWMEzyu46KKsaJPjgo0xgycpcDzWx6CxVzgF6SZy+41yLFML71qXIxEHlqlltMpTlo5GzA==
X-Received: by 2002:a05:6a21:648a:b0:231:4bbc:ff09 with SMTP id adf61e73a8af0-2381313ca9bmr31553876637.36.1753157449486;
        Mon, 21 Jul 2025 21:10:49 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2c91sm6537501b3a.5.2025.07.21.21.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 21:10:48 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:40:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 0/4] MT8196 CPUFreq Support
Message-ID: <20250722041046.lf4b267bmolm4exq@vireshk-i7>
References: <20250716-mt8196-cpufreq-v3-0-d440fb810d7e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716-mt8196-cpufreq-v3-0-d440fb810d7e@collabora.com>

On 16-07-25, 19:51, Nicolas Frattaroli wrote:
> This series adds the necessary bindings and driver changes to integrate
> MT8196 CPUFreq into the existing mediatek-cpufreq-hw driver. This
> necessitated two preparatory cleanup patches to the driver.
> 
> The CPU frequency was verified to actually be changing by comparing
> sysbench cpu numbers between fdvfs being enabled and it not being
> enabled.
> 
> Enablement in the DT will be done once the MT8196 DT lands, so don't be
> surprised that no node uses these new compatibles so far.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
> Changes in v3:
> - bindings: changed title as per angelo's suggestions
> - bindings: dropped the fdvfs magic register range
> - bindings: dropped redundant description for #performance-domain-cells
> - driver: made fdvfs frequency divisor a `#define` instead of part of
>   the variant struct
> - driver: dropped fdvfs magic check
> - driver: reworked performance domain resource offset
> - Link to v2: https://lore.kernel.org/r/20250714-mt8196-cpufreq-v2-0-cc85e78855c7@collabora.com

Applied. Thanks.

-- 
viresh


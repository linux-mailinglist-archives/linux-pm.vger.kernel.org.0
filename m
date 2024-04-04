Return-Path: <linux-pm+bounces-5907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA4B898190
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 08:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494D52884E2
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 06:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF893838C;
	Thu,  4 Apr 2024 06:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DxEnoAYb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A822E62E
	for <linux-pm@vger.kernel.org>; Thu,  4 Apr 2024 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712212832; cv=none; b=JONfC7waN+GMw7ShenMy7tZLdgXF7UjFYKiUKn5Os3tLoepLbNgKmHB0R2gCmsXO8OGHC4yvhiDGp5e7/GTWEwVIpfj1KfQQ1sFpoCIgebkweN6xE/OklRb5QMFKgX3Nmsk5B5Ni8oz3gX+LOQv+QWlEjgH+TAKCQexLdwVBjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712212832; c=relaxed/simple;
	bh=345Y31+/CGyl0VNnjAwh/6woDFo67XzbRr5nBCDRsRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTpeGmrZyIpfx1GmfVeyDRlSeMaGBVBbpKJORXlfxJmv9PsBCyGU3fJEysInn1UNDq+weZ1hvAeAXWcQUt8SIpHDe7c68uohUHz2kmXJ9oGrdWwVFxS/c3YZTUbS05k+cFCIzn6RDzVKuPtRZOexex7nKZhtPAIqTVF6FqpflE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DxEnoAYb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6eae2b57ff2so580640b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Apr 2024 23:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712212831; x=1712817631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sTfKjM314F+9yuuvd2dnBl05a+EUksaSOuF5rUZDqRE=;
        b=DxEnoAYb+4VS+jtOFKkvFKnn+GzB++63XStiVdXS5E2f8BPeLnHTt60VRFcf77soW7
         6l9yoqap9HP1oNtqkYbC0WEBQx16o/9FtoG2vderiMe3sDM2FvnHnG3Kg18Csw2qk1o1
         c1UNDWeZW2Nj3+6VzVcyHcW85Z8OWf2yqV2qNztjBgra4uX5T1BCqAzH6p4KVn24hCu8
         f5G28i1aLlkw8MUk72nW6+2zU1awOoGbECioOvPRF24o8m+Mdev962oUUcWHMoSFC+vM
         VU5qYa0blN3Umxkm24p94g50eZGXoNc77l2f5khXOuqQd6NLdQqXYr8fnRUnq6ESC3Xl
         nOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712212831; x=1712817631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTfKjM314F+9yuuvd2dnBl05a+EUksaSOuF5rUZDqRE=;
        b=SX1uxIk08ETC8yj9SRU9a1QXCgLP04nNmmyiwngkTkBnDmni4Qn5SNN5kJE4TTojw6
         A3wViqEpb/Mbq86INwPSoc8YAaWKJ+rJfH2gJiop19AL4hnbQXL/qpuScnUZf6yffDRm
         TDxH1B7kS8Os2qrW7q7zuT/6yOJ6oOl/8wvFJighTr0Jt18HCdJzKrbiBdbtU59218cm
         o0srDTJDv2s0/k2SAwvMPk+p4ITsWEJKefKp93UTeNFTpNUxXyOCiKbs1FgIfBRP9+R0
         HfwU0LMuMizc3AupcsSccqqRmf/NfHB4gNIxS7LzBj6tdzWOiHITqlXLPK8cmJk3pi3p
         qtdA==
X-Forwarded-Encrypted: i=1; AJvYcCXUSHrOFEN/pDksx4c6o5qr6mRs6SQ6NK8RBR7pSfU9UpX0sIHFm7QdzxZYg+XT2PwWNL2DB3XDCZQ/6nDcUMfdwsj/PDAmt4E=
X-Gm-Message-State: AOJu0Yy5jXxYoz8sjdfH0EwzbLBdSJhZwPdvvpPoagZXK14vgoUQqtpN
	2UJK9uD+F1GvtdTvThpn/DyC+DqXjengIFBJUuBOQLm0/SuL6ysqQSIjg8Q+cyU=
X-Google-Smtp-Source: AGHT+IFVOKVaqyVx23c/MS763nz5MYjoPJ6L/5Bhuu+heY75JfG1zsfK6FvTXL+3XuILEy2awOITdA==
X-Received: by 2002:a05:6a20:9752:b0:1a3:ae4a:92f with SMTP id hs18-20020a056a20975200b001a3ae4a092fmr1526347pzc.32.1712212830512;
        Wed, 03 Apr 2024 23:40:30 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id kt1-20020a056a004ba100b006eae6c8d2c3sm11141871pfb.106.2024.04.03.23.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 23:40:30 -0700 (PDT)
Date: Thu, 4 Apr 2024 12:10:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Martin Botka <martin.botka@somainline.org>,
	Martin Botka <martin.botka1@gmail.com>,
	Chris Morgan <macroalpha82@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 0/8] cpufreq: sun50i: Add Allwinner H616 support
Message-ID: <20240404064027.shjqvqih7s5rnv2i@vireshk-i7>
References: <20240329141311.27158-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329141311.27158-1-andre.przywara@arm.com>

On 29-03-24, 14:13, Andre Przywara wrote:
> This series adds cpufreq support to the Allwinner H616 SoC.
> v4 allows compilation outside of arm/arm64, by making the SMCCC call
> optional, the rest of the changes are added tags and cosmetic fixes.
> This is based on Martin's original series from about half a year ago[1].
> Thanks for the comments on the list!
> See below for a changelog.

Is it okay to merge all the changes via the cpufreq tree ?

-- 
viresh


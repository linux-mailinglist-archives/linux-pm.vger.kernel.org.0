Return-Path: <linux-pm+bounces-9806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE38D9133D9
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 14:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DB51C20C3F
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 12:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429E715697B;
	Sat, 22 Jun 2024 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fas2CI4d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E968155C87
	for <linux-pm@vger.kernel.org>; Sat, 22 Jun 2024 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719058693; cv=none; b=uFXYeYpruYjR6zqW7FtuRW1SWOi88iR07t37dZdf/sAZPdqVDN7aCKMx6EDKpJ3RInME6JrlZ76gsw2cg2yzJQzdFMi1Ops05chToIeYW7KWVyakP7sC0qATMd+MX+ktT2bY6VhSuEBmlBwkSnqrWF7Ijs/rYY9spHh7gNuTSvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719058693; c=relaxed/simple;
	bh=Otb6+zEngAUMmis4Nlkn1ES3A3sfmU7/Ej1Gk2keYYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qral9tZQTYJgV3HxdSmPzWSrceuQ09F9x4J+d1L0HUohPky1fBhNYZ3XGfPfa1Qn0siBvR/ereQ/1y6ASlrujtKKq2+xVlUnhoYWVBk9WBIyWldfuIWRoImcfJuneL8TXq7D/Ut/XJ5lNYOrJ10d05sMXRZB8GAAoLWKtF08Mcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fas2CI4d; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso3535888a12.3
        for <linux-pm@vger.kernel.org>; Sat, 22 Jun 2024 05:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719058690; x=1719663490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n59nJmN+C9BkCOiovC6/MipUx07bbZy3iLIAiDBH9YA=;
        b=fas2CI4dntYWR3bs266/9/Hi2gPSG3LlA7YvkZJYZBytvjtGzEujcm3Uj/Nb/KHoUW
         B5GcoZo77nvJdlwmq2vjOBCafXCbZKG4Dm5ulnXDVz9kNQmUobY7iGG9A3taSV9ow8vs
         ZtmdHqS31n0Ou50nR6kOe7TuZtypwCmTLGdAhjJuttPBaio3heBxRr4LJ6KnFaG4kqpS
         9FoMSc9BoVBl29HjPSU00cbOihmIAW7lA+wPx8Q74ZPaZfq6/v1WzhMER4IQRx0qPP2W
         8OihWVLC9iAGcjuXhO1/lDk/NXTd9rwGNDe+ELNbV6cKNXPVbt549fjAtI4sWc0vcbvP
         HgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719058690; x=1719663490;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n59nJmN+C9BkCOiovC6/MipUx07bbZy3iLIAiDBH9YA=;
        b=dKLLptRGSU2aMLqIvmcJYWbBqCoWqujyUzwdKYIzzklg5TBPajHSMTIX04Nltfcq4+
         OZcb2nh7Juhf7dtvood8I/w1thH5NzqXAOYct3dDhqntjZM+JUbUQBZ/gZAflzg9NmiR
         lJT0LhqZGTibLnIDmUelfBzgki+isaNGkjwYz13RR2cqnvluEKKBKr2yTMB4Ghvd1w9z
         Bz2iTCH2htfVFymPeRdelmoGw0H/V70nJhaL1KPnJzDQbK+ZPbaL75zYGZrxsZd2Cr82
         rvsvD/UrTHeKNo7ZXMREaChJ8eAjLUXx8XknnuauhWQU43ckIwU9UKda5oskEkoCARlv
         R7lA==
X-Forwarded-Encrypted: i=1; AJvYcCWoDmV/5vUxzvJatlROBb6mFnPDYjEuoe9jask6/ZzJOLi+jBEZhBUk6UfIwoMnG68UTTSeb32tTDPdzBsBqmuSOB1RsVvhHE0=
X-Gm-Message-State: AOJu0Yy1QqqnUcVM2qQ/yk5/Hh2JoCtvZsCZo7qsVNocryp/xBGJq3ET
	jQFgDKKf0jgaUSEeVHDDHDVTXsGeO9XZr+Fvog5feN2fpxzeSMyi6CSHzMf7rKo=
X-Google-Smtp-Source: AGHT+IENERone71lR9wzU0gG+JyMgcrqWMxRFrgoSA5YiQ4c6l5ON4W8dLWobMJ5CAJfmFVITDnzyw==
X-Received: by 2002:a50:a693:0:b0:57c:cbe3:6331 with SMTP id 4fb4d7f45d1cf-57d4a2739f0mr216735a12.2.1719058688864;
        Sat, 22 Jun 2024 05:18:08 -0700 (PDT)
Received: from [192.168.128.35] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d303dad36sm2232721a12.19.2024.06.22.05.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 05:18:08 -0700 (PDT)
Message-ID: <12b17db6-2649-4b7e-a35e-797ba2d9f2aa@linaro.org>
Date: Sat, 22 Jun 2024 14:18:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] OPP/pmdomain: Assign required_devs for required OPPs
 through genpd
To: Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Nikunj Kela <nkela@quicinc.com>,
 Prasad Sodagudi <psodagud@quicinc.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240619140849.368580-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.06.2024 4:08 PM, Ulf Hansson wrote:
> Through dev_pm_opp_set_config() the _opp_attach_genpd() allows consumer
> drivers to hook up a device to its PM domains. This works for both a single
> and multiple PM domains. Their corresponding virtual devices that are
> created by genpd during attach, are later being assigned as the
> required_devs for the corresponding required OPPs.
> 
> In principle this works fine, but there are some problems. Especially as
> the index for a "required-opps" may not necessarily need to match the index
> for the "power-domain" in DT, in which case things gets screwed up.

So, is this series essentially tackling a problem like this:

pdp_A: power-domain-provider@aaaaaa {
	[...]

	opp-table {
		pdp_A_opp0: opp-0 {
			opp-level = <0>;
		};
	};
};

pdp_B: power-domain-provider@bbbbbbb {
	[...]

	opp-table {
		pdp_B_opp0: opp-0 {
			opp-level = <0>;
		};
	};
};

nice-device@ccccccc {
	[...]

	power-domains = <&pdp_A>,
			<&pdp_B>;
	// order doesn't match /\
	required-opps = <&pdp_B_opp0>,
			<&pdp_A_opp0>;
};


?

Konrad


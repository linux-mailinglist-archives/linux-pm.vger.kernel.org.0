Return-Path: <linux-pm+bounces-35533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1105BBA83E4
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 09:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2009166EF4
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 07:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE7E2BF017;
	Mon, 29 Sep 2025 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="trkjQjo3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1702AEE1
	for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759130937; cv=none; b=msinT2sDFS+L9qE8VuoG0BmDf6NEYSGIJ3Rn3EMdCv8HLpDqzOEw4Cy4HINmrWtNeKlneDhHF7O40WlrQSLPTS51a8Vid5B6iuq6JhK2evclK9SvrF8uh4KTL+02bj3T2UHbIBXuNWM3xUDzrzjYO7gHwMGBG6kw13r+1jYiNHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759130937; c=relaxed/simple;
	bh=7F4Bd412NUjkHLR4AZb/VhkbRK5cWLJC7xh1AlsvUNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BC3EwoVYiPbNPYApaZiccG6tCEqQEN4Y6brR0/ZyOGM7VY7Al757jiw6XHrUJifHNX6iDqLF1hfRn9l0U5l94AbGfz0cV8212GPOMrSz5Frj30R3nD/eDXkQP8vUfdQlkqaqCDpLCvLExkP5MAb+EGWpSJKz5TtGJU3bbA82OOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=trkjQjo3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27ee41e074dso38050295ad.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 00:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759130936; x=1759735736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vUgMt/Iu4HigVywPOVpy02As/ACdmcQ/LQX8wXFvh6s=;
        b=trkjQjo3Q2MEpSYrwvNmEMUqbWVJL/OxJtKREKXAxVUZ5AGXlMn0EFwKdUZCgLSyNF
         G/p67cvOdfzzPdzVhUiQXbnzncKP4XPV6Kk3aHj/fqIV5Knes7WGjXsc2MWWpjseMX3P
         N9pKj4HogYzZzZP/ytcnlMTFbDYIiex9p6WzZ/dLEvzINYFpX/E2bB8Ga7rg8SEvB5PP
         76p5bSuUjuCO38o51VNVaF+A4Ebhnn2EzUDACODNFkQGeDpTuSjHnQGBSn1Ld5Prcq+h
         sCxXuEH3VSagX2z9eWZuDYYGbeJV0WG9lo8T9Ow6gvrfZAz26XS9wA+q2ZWpuEmc/Lpp
         undA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759130936; x=1759735736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUgMt/Iu4HigVywPOVpy02As/ACdmcQ/LQX8wXFvh6s=;
        b=jOoZS6+dFnFTkpxjmBe3t29jOJgacosPH06qMWo+UP5IRbDP9l4ZE7fNra4Hvgfn1B
         8/AUma4CjijsZ9xZOqjcvsrX0Mf2fpbQBgWTlNdC6f2DgLggA4wyQ3WD3a5Poqjnj3Ol
         o7oS9zrSVewWaDivfZoGIWOAP2ZApsKcDFD0XJ1w7ceJe/6bVGkIG0bPGRXcc5it6QMP
         VHKOH9UaeiMVJCeuq1/SgenqzJALYakehdSzAwVner5r37vEb5x3wrl0Cj5Zpn6Oxzfh
         sYoTnQfLRmqDDPIEmErsNvKPuG9PntdQnXK1ksTCORAFLPOex5ElNX5KNSgW8WUlu3S9
         hkXg==
X-Gm-Message-State: AOJu0Yy4mQjWw0/wxiaP4LuBmfF34FzRirT2gcWn133ZXxI0NgHVcOIb
	EAqEXJzuok6Le2YYX5JPt3MjNf0Wl/TqD2+1uvsodmCslMYuPOKza51K5niQb3hkbTM=
X-Gm-Gg: ASbGncvzliY9LmEnlKxD7+XshtXMykHgozv+wAetSBlrpQZGxbXNeqaJJAlEDv1X4iJ
	6ewrwaf2Spj2mTxMvTkpMoxxxywJQKs8SLWHvK0iAaXZHjRla9itZMEJ9lJLw0QFmP1X7VUMhik
	amWEAICxqB8nXo3LEjpy3y36DbfS+HdnWFQ5tMKbKPhoyG7Km7EXAq90L4CjZ/zWtncS2HKMO/D
	KezEQiFDPrBin07faRFb7AUAMhl1Ifdw7tmpNjXoi78kxD4Uk5cmKu+CdI04L1rnx9NkKT72I6M
	nf1kw9K2cgwFJ/GzQG4q3pfEWcoACj8h5ZXfVq9sgVmFD1p9x9YbMReLuk4G16b5bAYzDj87kEu
	Ivyn8LA0K20IY8o3TULVeRkNP
X-Google-Smtp-Source: AGHT+IFV04UkDk6nLUCSmgZN+tUyoArW1g8+WIB0WCKL3KwMarnJ2CKoOoUMLY19056+D/VsX/c/Zg==
X-Received: by 2002:a17:902:e890:b0:24c:a269:b6d5 with SMTP id d9443c01a7336-27ed493e891mr151642625ad.0.1759130935564;
        Mon, 29 Sep 2025 00:28:55 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6997ae3sm123206695ad.106.2025.09.29.00.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 00:28:55 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:58:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Qais Yousef <qyousef@layalina.io>,
	LKML <linux-kernel@vger.kernel.org>,
	Prashanth Prakash <pprakash@codeaurora.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 0/4] cpufreq: Fixes and cleanups related to
 CPUFREQ_ETERNAL
Message-ID: <20250929072852.2krpxwaq2uxwj6cp@vireshk-i7>
References: <8605612.T7Z3S40VBb@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8605612.T7Z3S40VBb@rafael.j.wysocki>

On 25-09-25, 17:42, Rafael J. Wysocki wrote:
> Hi All,
> 
> The first patch in this series is meant to address the failure discussed in
> 
> https://lore.kernel.org/linux-pm/20250922125929.453444-1-shawnguo2@yeah.net/
> 
> but in a different way than proposed by Shawn.
> 
> The second one is a CPPC cpufreq driver fix preventing it from using an
> overly large transition delay in the cases when that delay cannot be
> obtained from the platform firmware.
> 
> Patch [3/4] makes CPPC use a specific symbol instead of CPUFREQ_ETERNAL for
> signaling error conditions while attempting to retrieve a transition latency
> value from the platform firmware.
> 
> The last patch removes CPUFREQ_ETERNAL (which has no users any more) from
> cpufreq, including all references to it in cpufreq documentation.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh


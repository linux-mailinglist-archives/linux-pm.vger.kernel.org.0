Return-Path: <linux-pm+bounces-36943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1C0C12EA9
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 06:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21FD2351C10
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 05:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C1A28507B;
	Tue, 28 Oct 2025 05:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahZ/ApeX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8C0226D1D
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 05:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761628432; cv=none; b=sCYECAJzdiG1WXn511B1NTEYUdKn6nAQdvlyRf2/BEx9+g1uw4vfjeOkzQgCgP4bgdFPRYOff1Ajm8UdRrZmMclxcdzcdm/UPs6OHMA6yy/OgwRXat1Lx+CmG4O2Wo9Ge7bJbUllnHnaIWX3J6CB8NsaFGESp/lNA6c1QRXFy+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761628432; c=relaxed/simple;
	bh=JzjopnCgRwMkOrIXUcs0apSqXyDx2AUYdNUeCiTo60o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERWEGyW5IAuVkiNVhaSmPO9xy+p0mwWSulWo6RZaHA3SPrpldyM213VQovECIH6pGcB5D2Kr5t7DcfFmeDy6lLJJtDEm2KT2ZViWP9OfK0fhMsmx+Sw1V3h+DJ5BuFxFAFhrquElWOPFIARBkUO0zhG8TY/ESA4AKUWIezdGJ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ahZ/ApeX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29476dc9860so42099335ad.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 22:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761628428; x=1762233228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMKDfhFuWhQebRAxT9YejjbQsAd2wDwWly97EhWdZpM=;
        b=ahZ/ApeXJcHxjMGIuThK/TYpDIMrlB974KbVA62weNBwS/URK2204TRPN88i7+HLk6
         P9D9+aAgHFBavwaEXttKRlpVdNu+NyW2pzMHJlRnUykeyfwPSVI+GRO8q4wwwxKkYvIh
         ansQe2bd+7dN44dC7mSLeB8fo5hdDPsghHCje0xZC6qUYD3NN2rz3DOudKfZOdPOXmRb
         FHWRFpScm2A3Ht6jF0j0zn1YZ+8sGg39UXlmjb5KfZ5OcTHhi+xxJI1g14Ny3U91q3r6
         xQ41KmrgndtcW6zDKldaMwD99+KfQfGhSbVHwdO3ADIVJhleg5Gh4QiwQcNsrgXh0tmq
         9seQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761628428; x=1762233228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMKDfhFuWhQebRAxT9YejjbQsAd2wDwWly97EhWdZpM=;
        b=rFSw+Pi49Rr4Sa5aw2fpOX5qN95E82wc+mH/b+RCLArAAVgSJrZ3a+IRKbDwnjlBFn
         U6SKqPQG4c0ll7CthyNBq16jUF8BseeH/vbaEBk0SZVG6EbuycXnxNHJ+8M8FYigdeec
         DH5ar/IFhiARy1ECFTz7pVEs2Rr0KlTWOPUSEcLBVNl+qpfPDx5Mq1vCrtMDrwiuiLX8
         kqdUDcGzpjR0QYLPrAnd+MBJnnmEvWkj8qFmOwjvRwVgpKa4GWgLVUe3Lo3jznjj0g2Q
         5p8wyFSQT79q+3djdaLWL0N6BhzLHkeYIW/YyREOzVAdKdLURZ2Ghee5ZDIbKH97Yz4y
         Q6ig==
X-Forwarded-Encrypted: i=1; AJvYcCULKoFRKwG1gTJshwP6bYCd/eMKsbBMavRidYOxP76WETjbIUZa7Z58/X8pICOaQTRFnh6mHRpxng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhFLpMBpUnEfF6vVyUsu93qsvGWlgt3xQPAtcLCPHFdsXgweXp
	S1AihX+Eplu33BjWzqkrlgRiJXrG3EyqeU/HFOPOwSdgGJVWi2Axf7QCVemx2gqF/TWmWT7Tloz
	QYyqq
X-Gm-Gg: ASbGncuhEFwpzQzmzW3f7QAtVP5YGo8wfcOR8+IZ7iIn2S0RZgyLS93PaXbE0vLJd1p
	Z8k9ka3so9Uwz6qerVgo0johmEDLl1LPeMrnWM0VXysBOMASzQ9TYal4hALI3CTxQoBn1tR/XQe
	Fv0s6bcID+PZ6G4EbmwqRfQF6ljTVMtNs+S9eYEebqknfVRRjoM8P0ue2kM2eJAepQX1SjYhd2v
	WgzxJ3lyLveR0UjbKgaWPrhnBh9jynph9srvtJe3Ft3Kn2ItGwIN9w5x1V1yWIZ0VFuVVhp8v4v
	sGlY29jjaixLNACiGZAfBpbT6u40csXgFwDEv6aGjSe5JzHwrlksPVkk3lUHQCzl9QRi4ULSyn2
	mAU/4A33+IKrlRnRBNLdK2+MqECKVhLqwv7a2ScmDVJgeu7siRLMoMQtn/RF7nS4uQLMd6IE8Cp
	bgvw==
X-Google-Smtp-Source: AGHT+IFv8BScqO2z2oq9pmjixKfhhFY8KhLHypHI2fFhnUIb23B+PdR7UKWT6j7I/gfPQdC79UF8/A==
X-Received: by 2002:a17:902:f682:b0:27e:eb98:9a13 with SMTP id d9443c01a7336-294cb3d7202mr25628145ad.22.1761628428297;
        Mon, 27 Oct 2025 22:13:48 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42ea7sm100637885ad.101.2025.10.27.22.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 22:13:47 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:43:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Zhan <zhanjie9@hisilicon.com>, ionela.voinescu@arm.com, 
	beata.michalska@arm.com, Sumit Gupta <sumitg@nvidia.com>, 
	Prashant Malani <pmalani@google.com>
Cc: rafael@kernel.org, zhenglifeng1@huawei.com, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Update FIE arch_freq_scale in
 ticks for non-PCC regs
Message-ID: <xpktefok4c5vsno5fkizsjirbygsict2or2biphj3ugqbdvdq5@f67kdijo66y3>
References: <20250828110212.2108653-1-zhanjie9@hisilicon.com>
 <20250828110212.2108653-3-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828110212.2108653-3-zhanjie9@hisilicon.com>

On 28-08-25, 19:02, Jie Zhan wrote:
> Currently, the CPPC Frequency Invariance Engine (FIE) is invoked from the
> scheduler tick but defers the update of arch_freq_scale to a separate
> thread because cppc_get_perf_ctrs() would sleep if the CPC regs are in PCC.
> 
> However, this deferred update mechanism is unnecessary and introduces extra
> overhead for non-PCC register spaces (e.g. System Memory or FFH), where
> accessing the regs won't sleep and can be safely performed from the tick
> context.  Also, reading perf counters of a remote CPU may return 0 if it's
> in a low-power idle state, e.g. power down or reset.
> 
> Update arch_freq_scale directly in ticks for non-PCC regs and keep the
> deferred update mechanism for PCC regs.
> 
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 52 +++++++++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 16 deletions(-)

Ionela, Beata, and others.

Can someone please review this one ? This has waiting for a long time already.

-- 
viresh


Return-Path: <linux-pm+bounces-5428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5154188C33A
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 14:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084941F3F1F2
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 13:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF273528;
	Tue, 26 Mar 2024 13:18:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0124D67A00;
	Tue, 26 Mar 2024 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459118; cv=none; b=uDKd4MZoog6OU229s0jPZzlDkH57GCiL2lsp3nljHSJRpkgmc1yxdfcDplNtTFM5szIFlF3mLPAShQVku2MC3VHND8bx36ml8Pdsg0PVJ6ig0/v0qOxf644cCq0m9hO9VjcAJZAL0FHM6ax6OH9usBBbu6o8o5VB4X2X8S3QbLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459118; c=relaxed/simple;
	bh=/nfUf4bHC6IkXOSSHYXmq0tI2QSlZiU0fQbaU71/T1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXF/+8OkEq//gqAy+wFcq/ZGNLn7VLfd0DBdwQckYlAzPqCQ/Hgl+THruKMIEEWP3GqN9R0+/8KfvFeJDhbL+rN5ktofiN8Ll24LVzvBaOEYdF+aVfJ3Q2YSOnVfXhLF2LMtpG5SB6KYNTzJjuLyRbHtJmLgnJg3ZKZ3gqxlfP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE9442F4;
	Tue, 26 Mar 2024 06:19:07 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 464C93F64C;
	Tue, 26 Mar 2024 06:18:31 -0700 (PDT)
Date: Tue, 26 Mar 2024 13:18:28 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Martin Botka <martin.botka@somainline.org>,
	Martin Botka <martin.botka1@gmail.com>,
	Chris Morgan <macroalpha82@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>
Subject: Re: [PATCH v3 1/8] firmware: smccc: Export revision soc_id function
Message-ID: <ZgLLJE0k7F3nGEuq@bogus>
References: <20240326114743.712167-1-andre.przywara@arm.com>
 <20240326114743.712167-2-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326114743.712167-2-andre.przywara@arm.com>

On Tue, Mar 26, 2024 at 11:47:36AM +0000, Andre Przywara wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> The "SoC ID revision" as provided via the SMCCC SOCID interface can be
> valuable information for drivers, when certain functionality depends
> on a die revision, for instance.
> One example is the sun50i-cpufreq-nvmem driver, which needs this
> information to determine the speed bin of the SoC.
> 
> Export the arm_smccc_get_soc_id_revision() function so that it can be
> called by any driver.
> 

Assuming sun50i cpufreq driver can be built as module,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep


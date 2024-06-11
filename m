Return-Path: <linux-pm+bounces-8952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E38903EF4
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 16:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1451C22099
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7138617D8A3;
	Tue, 11 Jun 2024 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="P/2jVEzS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F152176ABA;
	Tue, 11 Jun 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116797; cv=none; b=QU/DOPFK0hfQjwgYuYIXP//eMNwlljXY/+Hdsq6K2G9NORLQWH/pOa4eLlR5aObgE6zlD35rpuTfKfUBOE+BhcFFvIJTshO1D9xfjqix+ntRqNBK4Oj1aPX7kW0CSzSfvmppfQ8S+Ry6IqpQjhZP+KUhia2LHkZzEh7DdFoG9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116797; c=relaxed/simple;
	bh=ot7CZ7HwJaowjCZaeb71NVNfkvqVVfWH0xnchWOcjzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLZdL9Njo0XV3RDYoKGls8w1YJ/JZ5tCKXyUGbI8ATxSM+nVHeHeeTEG3bHCGMo1qvpLWfD8Q7qY3vZXx+hRaSyNowISpe/ug7FH7DQEQ/Zr7AUWCTyxDC3PgehyHbcT2/cjT5EiDpNTeqWdBTu9QBwB21fkTjsV71ggy169l64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=P/2jVEzS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EB7FE40E016E;
	Tue, 11 Jun 2024 14:39:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KotdDfLUrY6I; Tue, 11 Jun 2024 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718116789; bh=L+boU97tCCJX8neAbB/hea4OMvumD6JJl9Ec8iYQ7sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P/2jVEzSKyO1GmOUnPBGSXA1cL3GBo+CrOnRdrARo2rFCjFr+FJAH2W2JNJd93tSL
	 pozI3mIzIlnZQLiPfVC3mgfaTDrRCsm3mOUNhybfp1pZYmMahJXVXbLg0GTr5AFbrx
	 oeroAqbkqpAjlQM5+2R1sUx1KRJ9GN3oijGPS1hmj32jdEDqopd3/4YDTS2R84V9Qo
	 Hz8Jkn2kT1ORLFBbdQsMgURoZwUiX8jQiRLF6x87tmvHqyJGBuSjE6c4zYeLvpV2aA
	 FLZRIYmTo/W/M8J1PMlYwihv9/142svf/Yf7SKDYvnfu0V6/+++1VampnIaJ9PUd5F
	 C7yhJoA+nnkbWTx8Cof9tFDx8Cv3FLYvRZ99+8xr1WC0mt/cp06+dCoXFMadgWrRYu
	 ztmsZhM68gBwQxHshhx2gbb8P1+SaltPLZHf72dejhaOycIYQnnqKj2bGFeRRhG/YM
	 odGoMK80eLuOMMGWRB09MEw/9PXkMW0L9GsSD1rhrYFpmlgZti2zmSudS9B3FYZAP2
	 VyY6qeT5JkWjJ6mmDhdyTWHXG6KG0jsDOYzhne9ABl/ohuzGyjqRm0DSNaPaIoSbfV
	 lyzG5OeF5N1Ri6Z8yxsGqq8EMnGZDOxo6P9LburNuuvTqhVV/WGHsfZvM15EOR3mYt
	 0GfX47+tdDlo+MSNeDJiyJ4Y=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB82E40E0031;
	Tue, 11 Jun 2024 14:39:37 +0000 (UTC)
Date: Tue, 11 Jun 2024 16:39:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com,
	rafael.j.wysocki@intel.com, viresh.kumar@linaro.org,
	Ray.Huang@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] x86/cpufeatures: Add feature bits for AMD
 heterogeneous processor
Message-ID: <20240611143929.GEZmhhoW1qCvIWS0SK@fat_crate.local>
References: <cover.1718095377.git.perry.yuan@amd.com>
 <7a2817ce6e8e6a2787bed8285dba8d81423d8414.1718095377.git.perry.yuan@amd.com>
 <20240611105216.GAZmgsYC-J_yLfdupF@fat_crate.local>
 <e41fd460-6b50-4792-9328-3eda370672e4@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e41fd460-6b50-4792-9328-3eda370672e4@amd.com>

On Tue, Jun 11, 2024 at 09:31:54AM -0500, Mario Limonciello wrote:
> Another option is to upload it a non ephemeral location like a kernel
> Bugzilla and link to that.  I do recall there is a bug already opened for
> this purpose in the past.

You mean, after what, 30 years of search engine technology they can't do
one simple thing of finding a doc on the web after indexing its new
location each time the corporate website decides to update to the latest
fancy CRM glue?

:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


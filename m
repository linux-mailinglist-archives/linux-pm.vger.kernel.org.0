Return-Path: <linux-pm+bounces-8935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39103903954
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 12:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C2B288CBB
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 10:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB10C178CD9;
	Tue, 11 Jun 2024 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IrdXh91+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC24854750;
	Tue, 11 Jun 2024 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103181; cv=none; b=s4eA5EDLyS5dq08TBz+FB5D5x1RGmUTfwj31jrdDJ3DOMJNO5YPGI522jZyzBCa/RP2QOTm4BGUU/vv98IB2QRdYb1PgaCgyYORg+4UxJ3HuXxgfO5bpEraSwx2H2fUbPHsokhxbxlYOqHWUccWhxaF40+ytEwBPoyM9HIqtSdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103181; c=relaxed/simple;
	bh=O6yNQpzWFfgaAyg+bB1AWIYfafWraDPTiYeM6mLHIxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac9IIBHLS/2vPk57LWp8zIv/SHz7xIwU7vLhhPsT1OyQoftbeU1ErhlRL7bnAlEsftUCrbTsgsvvEbYMp2BZvG5RdwEXZFtQF1j1H2m2mSv9qKlEjvSmXfFDbNN3PsHLQuxTaRmIW2AOD1uba6MaOUAo6yafql3sAGctqlAf9Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IrdXh91+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B94FC40E016A;
	Tue, 11 Jun 2024 10:52:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zovfewP79hYC; Tue, 11 Jun 2024 10:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718103165; bh=69DDbIOUEaKauOUdmIvkH0n9o6MTqowJZDIBEqtYRjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IrdXh91+jkSK4fhTYch24LBKWGhy8KcHgXwD5Idj4eGY3qo8lcNxZCmVGrkVvqb+W
	 n3kgtn+0Le4fpSxtdfnApvEIdm7JWG2HJcEyQwmDzkMNc0OSAq71yts/PeqUwsoBA7
	 DlN/HVNHHIO5yCC3zvIpvTgBAkbXEWpcUPutOyeQhnBk+FocidZYj5/hQO1T3b0X+T
	 Noys+XLq0ZE/vWhLbQZK6tmRuUa6dr0krya6OlQ3gT5agJexoDGULmq+tbgawPsO/J
	 PR85bAkZmKR7stYniSsaDZunwXiZ6fy+WG9J8Uc0wMOAFtITLwplkW6QxXTZ2gqqx8
	 lNmwaVXzDY3l/jPCpYvofHCOkiItyslwrUNv2091Pk6mvMG+vsnlZO7hQmw5Hhlhxx
	 kNFlHVVtS0obEPQ2ziWrggDdmSug1sc/y5JbnJnjUh14hmY6SrJuF62LfT3vYjch6+
	 WIwWMhqL/rE16dN7rACVXpDRh6uyWBcyhj3C/p6Hq2EgrLE/VrEPrdmt7bMX5uo8C3
	 m/MXSIxyu+uDYMPJhEBasyyxoS+OaRNkIYoMfdk8+MvV3keFyBsA0QePIry+PChqyw
	 BpISeOBj1HUc0kCbYVNXK6ZBa3Qp9UhShj3QnqMZVUiR+k/pATuB2L6EwroIZ97cXT
	 irzKizVtcRwgdhUi+QWRcXsE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 14D0640E0081;
	Tue, 11 Jun 2024 10:52:33 +0000 (UTC)
Date: Tue, 11 Jun 2024 12:52:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Perry Yuan <perry.yuan@amd.com>
Cc: Mario.Limonciello@amd.com, gautham.shenoy@amd.com,
	rafael.j.wysocki@intel.com, viresh.kumar@linaro.org,
	Ray.Huang@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] x86/cpufeatures: Add feature bits for AMD
 heterogeneous processor
Message-ID: <20240611105216.GAZmgsYC-J_yLfdupF@fat_crate.local>
References: <cover.1718095377.git.perry.yuan@amd.com>
 <7a2817ce6e8e6a2787bed8285dba8d81423d8414.1718095377.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a2817ce6e8e6a2787bed8285dba8d81423d8414.1718095377.git.perry.yuan@amd.com>

On Tue, Jun 11, 2024 at 04:52:24PM +0800, Perry Yuan wrote:
> Subject: Re: [PATCH v3 08/10] x86/cpufeatures: Add feature bits for AMD heterogeneous processor

"... Add a heterogeneous core topology feature bit"

not "feature bits"

> CPUID leaf 0x80000026 advertises core types with different efficiency rankings
> 
> Bit 30 indicates the heterogeneous core topology feature, if the bit
> set, it means not all instances at the current hierarchical level have
> the same core topology.
> 
> For better utilization of feature words and help to identify core type,
> X86_FEATURE_HETERO_CORE_TOPOLOGY is added as a few scattered feature bits.

This sentence is not needed.

> PDF p274
> 
> Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf

This link will become obsolete, you can say instead

Search the web for "architecture programmer's manual volume 2 system
programming docID #25493" in order to find the official document.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


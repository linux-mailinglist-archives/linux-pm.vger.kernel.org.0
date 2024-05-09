Return-Path: <linux-pm+bounces-7691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0798C1306
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 18:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A030B1C21500
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 16:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923AA4A1E;
	Thu,  9 May 2024 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jf1R7ps9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E014C70;
	Thu,  9 May 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272493; cv=none; b=Y95HA9WWjnHhWsfzkborl4DXIP/MjEC5y+z0ciGfB0tHK9IoXc8EEz1LHAOuB7vqKYz7kkMYpxZt+cQvFB+DlJrGQ9RqROy/pY5opu7cXKchQuOeF+vem9BFOnDl9R3ihPoRDYtWwBVq6aYEgbWaSl74Znpr6HqU6dEGPDlXWpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272493; c=relaxed/simple;
	bh=q0AaOfH/xeZ1opuIwk+1614/WumleULWnD3ETLFHCUU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pj4HEbjiZFSwaq0jhJ9cLDpjNoeLddlEtk8u9qfe9In/Vh3l+tr7OacAOj7hiEi37cbUVeNbJfAML9dYgk4etxyZ78E0ln5Z2VXfUcjG2bOoN09XEFJy/xxoaiOPPkkzgKXYK+NbB4XB7R95sq+zOBvMFaNtPSXXF89t5lolBk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jf1R7ps9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9ACBA40E024D;
	Thu,  9 May 2024 16:34:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QP0d6lsQxiD7; Thu,  9 May 2024 16:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715272484; bh=pDCGskOSimKeyexxfwWubPEdlEM0VbPzNoGnc2/6mqM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=jf1R7ps9RHJlTXHsLhNfzpcklaWa1eCxh5Y0WyP3uMvgZuT1cvDI9jE1O7PcI91Pd
	 gtVS+JDqXIJa/GyNGF61YYGZ9FasMQd+MygnDgkQLKJF2VN/NNwuIAGULEFfZsYNnv
	 zH+l91E5hn9oP2iEe7hsIujWhc3DmGKTPKs0rPg90yNIrn82HsvUpS/EJyOZ3/Efv/
	 xGZFp5CS5mhDLTsD10omF2YeJDTA4+biemKphMRaZz94uTX52WORBNCtsmjPzBifCR
	 ghDyjOoPxy3VIsEHm2jqIC1NQmDxnYciNaKEWVBRaVI5hPJyq6MzIkluGzgcI6ICov
	 IwvmT9mr7MOiyd5JE9yffaVSn0jPT1gX/wPapo7yaiyQeXu6HtZCguYdQwxDx9lghc
	 Q9wFNFmZNelox/Prgf5n7vTfxFO7lIaKIJmuAKMSEC3UHd2cSuADIqOOBaUfajj8kU
	 d+wN2S9zqq6DMzv05wOcjhP6BgVftcaP9JLk+b9pkzY9TSqPcIRhbhRLpmuoVVgFxw
	 NN3cU1S0Xu2PWoJuUS98KqSt4dKIYX+qWgh8UuXnCbbqoZzkNO6oineVWXl2p4K5pW
	 VPJbkaPCcDfIxiXxCwDDkQ3qQMiBZFJerOt12/322SxSCgy4SausT4IIvffg/y9guC
	 M+iMfuWi5MRP+5OVvo1DRJsI=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3033:20b:71c3:4495:c4f9:c73d:fb52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE8BB40E0249;
	Thu,  9 May 2024 16:34:31 +0000 (UTC)
Date: Thu, 09 May 2024 18:12:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Yuan, Perry" <Perry.Yuan@amd.com>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "Huang, Ray" <Ray.Huang@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Shimmer" <Shimmer.Huang@amd.com>,
 "Du, Xiaojian" <Xiaojian.Du@amd.com>,
 "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 0/7] AMD Pstate Driver Core Performance Boost
User-Agent: K-9 Mail for Android
In-Reply-To: <CYYPR12MB865543653A46840345CFD2139CE62@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1715152592.git.perry.yuan@amd.com> <20240508081845.GAZjs1ZS7atvvdsOOd@fat_crate.local> <CYYPR12MB865543653A46840345CFD2139CE62@CYYPR12MB8655.namprd12.prod.outlook.com>
Message-ID: <CF8E8900-4CA5-47AD-B149-27F04087FEEA@alien8.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 9, 2024 6:01:09 PM GMT+02:00, "Yuan, Perry" <Perry=2EYuan@amd=2Ecom>=
 wrote:
>I understand your point,  the patch set has taken very long-time review s=
ince version 1,
>I would like to get this done as soon as possible with reviewers support,=
  then we can deliver the feature to users who have been waiting long enoug=
h=2E

Spamming maintainers with it is going to help with that how exactly?=20


--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 


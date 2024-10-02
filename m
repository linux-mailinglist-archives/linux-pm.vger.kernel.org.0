Return-Path: <linux-pm+bounces-15044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACD898CEB8
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 10:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7F11C212FD
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 08:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37675194A6B;
	Wed,  2 Oct 2024 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vhUXUy9F"
X-Original-To: linux-pm@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A490E193430;
	Wed,  2 Oct 2024 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727857473; cv=none; b=RcJxQWYxy+HjQ3mUd5z62xqvqelhRMabr/u0F67v3LOqTLqm7BSI+k/XJTtp5dr/6xUvfDGeiESeQEZt/8kLaF0GjpK/hpBgLIqya7L8p2iUajLGOsjZcsrOscBLrHg2SKEEryHx5Vaf0TBMdAL+ZAtFq56vXKCb0yKDE9xEHvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727857473; c=relaxed/simple;
	bh=/u/jfm3/qwaoY8xrrOI+K4ccbBqaESHARxnwj8bBIh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+10/JSYGHZyKQeBulPCysTKRGSEqEo92ETb8fFuGIfjCzbG7CJdCUaqDxzH8xrPJcNYrE+G/KLtJ/WYvHksLjHADVzWdmteRAmxuLrleBnTOAEA/URo9Vd2ggfE4rxXN0kyv6NYJfsgTpvJWHTpEAVneqF7zdObd3orhSBmZjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vhUXUy9F; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To:Content-ID:Content-Description;
	bh=sBwEgQ8rZHCopaQ9fm1IvXzQ4um7p5uh9+XaFpmgOus=; b=vhUXUy9Fp1++pTtfYyAEBnix9c
	VMdcXgBdg7ypfgBgZbi2N0UuQtJsA82vUNB5+gU44WfEqJcXW84O/cN6SgJg4C3oHP1I9nsrYA9Z8
	TVAOvb3h/n6Pmm6WGeFx/AMvq2aBdVumCtU2Qi9DBUKokCzTaQM4O27SmF582t0wFerFb771Lvi3u
	wO0H+SOuafp9ctEzP9I3HSJA/EZ+t290y9a1s5WS1QRDrm703qEWYttNAbFRaoPxIiic3+9nj6pBo
	JWlmNAwFWPNCrfbnId817H/ccZLLnb2OcltGeEcVYw/Ajffm38bJo4jcPYSpPBqkI+/f/labaEHgf
	jP+w/tkA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.94.2)
	(envelope-from <ukleinek@debian.org>)
	id 1svueS-009xvh-VR; Wed, 02 Oct 2024 08:24:05 +0000
Message-ID: <5cf6b249-d2d3-470e-874a-ba6b914f4b0b@debian.org>
Date: Wed, 2 Oct 2024 10:24:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: intel_pstate: Make hwp_notify_lock a raw
 spinlock
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-pm@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-rt-users@vger.kernel.org, xiao sheng wen <atzlinux@sina.com>
References: <20240919081121.10784-2-ukleinek@debian.org>
 <CAJZ5v0hz+w3eFYQpHqwe0Fv3axe8LBDEf+oMd01dEQMuN=Dy5g@mail.gmail.com>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@debian.org>
In-Reply-To: <CAJZ5v0hz+w3eFYQpHqwe0Fv3axe8LBDEf+oMd01dEQMuN=Dy5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Debian-User: ukleinek

Hello Rafael,

On 10/1/24 20:39, Rafael J. Wysocki wrote:
> Applied as 6.12-rc material, thanks!

Thanks. Triggered by this patch not being in today's next I looked at 
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git and 
didn't find it there. What am I missing?

Best regards
Uwe


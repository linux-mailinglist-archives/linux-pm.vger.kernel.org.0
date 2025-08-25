Return-Path: <linux-pm+bounces-33046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8765DB34AA5
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 20:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE461B217C0
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 18:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F056727A129;
	Mon, 25 Aug 2025 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDyt2QzX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC066270551
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756147858; cv=none; b=W3rLoEL80QcGxu82g3vPeuIcpnGb9M2KE0w9DRRigcEx/5HXJK7k1PW5iQ5cjLgl03X8ceMAVoYWhiM+toQAmnntQ36hI/eMclfVvsZEljxIiD/cP5Q1NWjXnETxp3UrJ3jP8lYkZZdLfZsPWq1a70SemvYylJX/LbVZWdB9tqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756147858; c=relaxed/simple;
	bh=eGPFKabw3mBVn+Cyb2/r6MMnUjQMyUJxa+UCNpAAiog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqPQKOsyPNMX9Z1r3WDrl7bfx/axfXiaoyiGFWjMAo+N72pWuyOWv2X3RkHbqsq1DX7iB7S2guXJxfxiN/EdAK9ssuA1y39Qza62fQu5Rr5n7U7FR0W8BYAgBK0YKHPU8K6107e3yWckAJO4s8ufZkzSovV01Azn6308iH07mkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDyt2QzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A312C113D0
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756147858;
	bh=eGPFKabw3mBVn+Cyb2/r6MMnUjQMyUJxa+UCNpAAiog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WDyt2QzXs6OWAsFzVupkZUolFjqKw0nEqVlb5/T7Sct95JId7tTKm3eeIGSz3kOGk
	 zWDVWQgRuZwXcgRx04Mhz6pEEd8Jw+ZU8q77Pj/efuwz+c5/L1+Tv4rmkmLIZnSOVI
	 Fn6SCkgF3lmiK4BpPeIk+ukaRbL2d4YMA6Thb1Cp4aFjjhHYOV2Op5LWVck1qujob3
	 uXadvfOONBWLRoB59YeS43UkC4jrP12mU9Oi8KvfZXCw6IBSjq4FRfGjy8yaUow44S
	 rZUeFT9BPFlx6W5UIcTPt4hoFlyk3dA4O+s9GlqGSHhQUMQmmV6nOwlCbbTMVj0eus
	 mLk6bAB1HX8+w==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61dc56dcd2dso1269444eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 11:50:58 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy1eXc+Ha5Fczq/EyXWtBCrSgAwqFf2juGg2ohGKtDkNDTse0SM
	voObSoeOZi+EjHZEEkLCKiMm8Ib0yzJRp+2wZtBa0NfNu3qBTATLCYMdmxzAnKY/Un1yOhFcybw
	qmUNMAS69I1RgXFPo2dBmP6W/y+UGokM=
X-Google-Smtp-Source: AGHT+IFKV+dItWd4Dl7AR2n/XIPNEAy2mljT+DpJ9DAcYYBUNJL6fRV6/fqTez9cAtTNElppQ9JSyoQ7i6c9A58xB84=
X-Received: by 2002:a05:6808:10d5:b0:40a:533c:c9cb with SMTP id
 5614622812f47-437852cd597mr6842053b6e.38.1756147857702; Mon, 25 Aug 2025
 11:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818085124.3897921-1-kaushlendra.kumar@intel.com> <8024bc1249dd1f6ec8496f46a119f009823259be.camel@linux.intel.com>
In-Reply-To: <8024bc1249dd1f6ec8496f46a119f009823259be.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 20:50:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g5ieXdFapviYDNjuO8LsnHx_ceW1kUaDG=zR+siVsKEA@mail.gmail.com>
X-Gm-Features: Ac12FXwMfApkb-te9RHgrHYLexHL5-sMagRrwS_0ngLm4hGmuoqehXsQfeTElFA
Message-ID: <CAJZ5v0g5ieXdFapviYDNjuO8LsnHx_ceW1kUaDG=zR+siVsKEA@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Remove unnecessary address-of operators
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 2:28=E2=80=AFPM Artem Bityutskiy
<artem.bityutskiy@linux.intel.com> wrote:
>
> On Mon, 2025-08-18 at 14:21 +0530, Kaushlendra Kumar wrote:
> > Remove redundant address-of operators (&) when assigning the intel_idle
> > function pointer to the .enter field in cpuidle_state structures.in C,
> > the & is not needed for function names. This change improves code
> > consistency and readability by using the more conventional form without
> > the & operator.
> >
> > No functional change intended.
> >
> > Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> > ---
>
> Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Applied as 6.18 material, thanks!


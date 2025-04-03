Return-Path: <linux-pm+bounces-24770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95524A7B1B3
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 23:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BACE7A62C0
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 21:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6CB18CBFB;
	Thu,  3 Apr 2025 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="heCR0QTK"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3302E62D1
	for <linux-pm@vger.kernel.org>; Thu,  3 Apr 2025 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743717586; cv=none; b=Vmg6Z39BCLBGRqsd5f/BPL74mRg+HqjvmdTgDK54GVfIXy9ujTFn8/IDwWgOcQJu8HHuHDhq/Bp6Ss0FFW1WNKC9MQ+QOQMlIEFV9fxwcERU6ZlILdlmsQEYgxbp6pAxmsardK2pqtxVHigLEtVpNNFAViWrwhv7n03UThtvu/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743717586; c=relaxed/simple;
	bh=xVOpi2NrysHijpOurSHwvEoJziXFVJnfKW/CtFYrl50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJFmLLJ01oQ8jmafxuCX+x/EhgITMplug/Xve+g6Ci5a21UpcSO0kK5t8cykeAE4DXIBtzrncp2ui+8TkkJGYfblv9fgNQhD0OXgFjRutOZPKLMrSf93YyuU9umiQ9ibhIifg9tEG9KDM3lel0b8EVEcs//cygBIU3jpvmUtn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=heCR0QTK; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Date: Thu, 3 Apr 2025 23:59:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1743717579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5gWVPsaMeVoq3PEOblosd8Uc4uwzdadJ+Lx1YrHoDlQ=;
	b=heCR0QTKCfdNHBAd6RcJd7HR4EPXeNDV86iCUlXot0NbT94u9r7zuNR/T4a7O00k1+WKqo
	oRtCLMfj6x4eFUN86Pp2l2dQI+XpAgksb32jVziMbcvmXk3YMgG8YsZgHyKudc4zLuR8JK
	H9IoEon6Qp+mN5MbkcVpCyUrO9TWmj9xLhwqZCEkreb3gTKlp6YCDlwJv3fLabnBg7ejTo
	5EB4aJlzOX4yLv0CZzwVNnpdSfYdEU0R1f5CGIODXTQFDHz4MU55sF3an9Md9tpXB8wCnh
	gAjT52jzelVE83+Boqtxp9hTFRkrp7Mmx3+RCuybMq74qOYcIoXPNu3xrJ+p2Q==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, ebiederm@xmission.com, rafael@kernel.org,
	pavel@ucw.cz, ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z-8EwQksGi36v-QQ@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z5bx7ZHNcyc5fM_L@darkstar.users.ipa.redhat.com>
 <CALu+AoSSKh=5ELgQyzDrGEDm5fm2XKteH1ZC70mm89pNSSPMHw@mail.gmail.com>
 <Z-c7V2hptt9U9UCl@desktop0a>
 <Z+dQZozsbdls6yqJ@MiWiFi-R3L-srv>
 <Z-hYWc9LtBU1Yhtg@desktop0a>
 <CALu+AoTrPZS7ukuLsCTCwKNKVd8=PUN8nXwh9BdicyV-==-W=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoTrPZS7ukuLsCTCwKNKVd8=PUN8nXwh9BdicyV-==-W=g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On 2025-03-31 11:22 +0800, Dave Young wrote:
> > With v4.9.337, kexec (via kexec_load) + hibernation works.
> > With v5.4.291 it doesn't.
> > I'm not sure how bisection could be done in this case.

I just found out that 5.0 is not what comes after 4.9 [facepalm].
With v4.14.336 kexec_load + hibernation doesn't work either.
I'm still having a bit of trouble finding the commits which fixed
various build and boot issues and cherry-picking them. But now at least
I have fewer bisection steps.

> Not confident, but maybe you can try latest mainline kernel see if the
> below commit helps:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a2498e5c453b3d8d054d77751487cd593332f8c2
> 
> I noticed the e820 export is different for v4.9.337 and v5.4.291

Unfortunately, this commit doesn't fix my issue. Latest mainline works
when using kexec_file_load (but not kexec_load) because it contains
https://lore.kernel.org/all/20250214090651.3331663-1-rppt@kernel.org/


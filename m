Return-Path: <linux-pm+bounces-30665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F2BB01366
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 08:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A12A7BB673
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 06:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B6319E826;
	Fri, 11 Jul 2025 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMjcboSk"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60129128395
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752214621; cv=none; b=LnLV9HL0k0SZQLwCniCeEhglwBFAi142ZJMhUp2HuSia9JlNcs/2909YbFX4vbPaDDXpRosCACDjgo4kz1ZvBur4GpjJEn+x0iPfxiJ/XfPz6yXS2bXLdjq6TxOMP3X5O3LmzJ2aogJHJTTCgT3HnF8jQg8scPEMmLpaU21PJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752214621; c=relaxed/simple;
	bh=tXvg6SNKb9TE15oM3BTjXarx6KwI2B/PB45W7PnV5uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMw/VAUP3D/awe1tX4+kX2NnfaO8Zea6xBNWCwVtZlCAP2T5ITWsrbeZhckCH1OEFeMz2eKSgaqeCTxjvyV/Cy1u8g60XWlVXEazlJZHyGWfYp7MnoFmdWsJ/Wl3eD7DkJFOgKHS/p/927c1t0R/bZpJFBds39Y7DR5CBe/lOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMjcboSk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752214618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeoEDjDU8a4IeYmps0ds8/3XOPMV0IgPKVsoQbtyLww=;
	b=WMjcboSkubftzBqCErD28KD5x7ATiSjGx/LlK6c0F1CYx+Cdr/KaEtddhYDZJtjyJKu9dU
	9GTk2t8U3FL8xvBBH+wX41aRVo/XTTkbdU6CPhubdmH60zR4tnYyqGD8eQ+khW/u8DYEIZ
	Aaf8ay0tw2aJeb82GHC/efjHzJcxs7Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-f_ewVtGgMG-LM5h8dmQEvw-1; Fri,
 11 Jul 2025 02:16:55 -0400
X-MC-Unique: f_ewVtGgMG-LM5h8dmQEvw-1
X-Mimecast-MFC-AGG-ID: f_ewVtGgMG-LM5h8dmQEvw_1752214614
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B617F18011DF;
	Fri, 11 Jul 2025 06:16:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.59])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 825DB1956094;
	Fri, 11 Jul 2025 06:16:52 +0000 (UTC)
Date: Fri, 11 Jul 2025 14:16:48 +0800
From: Baoquan He <bhe@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v1 1/2] kexec_core: Fix error code path in the KEXEC_JUMP
 flow
Message-ID: <aHCsUAhqRz5zJH2t@MiWiFi-R3L-srv>
References: <5046396.31r3eYUQgx@rjwysocki.net>
 <2396879.ElGaqSPkdT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396879.ElGaqSPkdT@rjwysocki.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/10/25 at 03:10pm, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If dpm_suspend_start() fails, dpm_resume_end() must be called to
> recover devices whose suspend callbacks have been called, but this
> does not happen in the KEXEC_JUMP flow's error path due to a confused
> goto target label.
> 
> Address this by using the correct target label in the goto statement in
> question.

Sounds very reasonable, thanks for the fix.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Fixes: 2965faa5e03d ("kexec: split kexec_load syscall from kexec core code")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/kexec_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1080,7 +1080,7 @@
>  		console_suspend_all();
>  		error = dpm_suspend_start(PMSG_FREEZE);
>  		if (error)
> -			goto Resume_console;
> +			goto Resume_devices;
>  		/*
>  		 * dpm_suspend_end() must be called after dpm_suspend_start()
>  		 * to complete the transition, like in the hibernation flows
> 
> 
> 



Return-Path: <linux-pm+bounces-30666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027ECB01368
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 08:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC23616DBB9
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 06:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3601CF5C0;
	Fri, 11 Jul 2025 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRGvcKwW"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF9288CC
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752214689; cv=none; b=Gusb72LmH6lbsC3dAzjzYHfvRuB2PCZTH+CvKTLCBjAi/vFkJuXfZ7HvxiRSt8uJ5YIvygs4m/IVfWXwOkeNW3mp8vUYYJdV7D2JEn1Tn5Gm9SwfCB++jV2OmjH2IF1ulTXaCLLJQCTkP+a+1SGQ4fzLyd0OSVXxrhfWmvAs5hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752214689; c=relaxed/simple;
	bh=iJvGXsU8ZFsvuOATqSXTXsnWM35j+ebjaav6tjmLkjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFDVzLvxCkwCrEM6oGB77LeqrM4zjEolWB/9Y8BjL2eW9/M5BroCBHvZMjpTcwnppGux6P/VVB6Xse1hhoQR4/DAE8t7IPi+3mRYlJfn9EwjTfcGGJNRa24CUne4/ib34UIxE7tz6qjEQEVm7mOWdrKeG15RVDpxFeKjyed9gNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cRGvcKwW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752214686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9G+ZmLUkUIQU/PXNQ1CgccQAS24d13cPf68AHxjj7PY=;
	b=cRGvcKwWCdQ4RnbthIj08tgCEwxOyjwVqyznZOYle3wEChbTximLOXoUWCDL+SlVAtqF41
	kicnjmXvVx5+/dD4iDASMcyi1HqK9N4ZGCDKBbPH08IbsJUEkL7FWOKs0S2WkdlOpHzE8X
	A/kNqLYzXKRIw88uJc2BQfUn/4BvKiE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-5GExp0KkMX6CZNK4_rjbCA-1; Fri,
 11 Jul 2025 02:18:02 -0400
X-MC-Unique: 5GExp0KkMX6CZNK4_rjbCA-1
X-Mimecast-MFC-AGG-ID: 5GExp0KkMX6CZNK4_rjbCA_1752214681
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDD74195608E;
	Fri, 11 Jul 2025 06:18:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.59])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C7781956094;
	Fri, 11 Jul 2025 06:17:58 +0000 (UTC)
Date: Fri, 11 Jul 2025 14:17:55 +0800
From: Baoquan He <bhe@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v1 2/2] kexec_core: Drop redundant pm_restore_gfp_mask()
 call
Message-ID: <aHCskzYNOG5WNltA@MiWiFi-R3L-srv>
References: <5046396.31r3eYUQgx@rjwysocki.net>
 <1949230.tdWV9SEqCh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1949230.tdWV9SEqCh@rjwysocki.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/10/25 at 03:12pm, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop the direct pm_restore_gfp_mask() call from the KEXEC_JUMP flow in
> kernel_kexec() because it is redundant.  Namely, dpm_resume_end()
> called beforehand in the same code path invokes that function and
> it is sufficient to invoke it once.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/kexec_core.c |    1 -
>  1 file changed, 1 deletion(-)

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1136,7 +1136,6 @@
>   Resume_devices:
>  		dpm_resume_end(PMSG_RESTORE);
>   Resume_console:
> -		pm_restore_gfp_mask();
>  		console_resume_all();
>  		thaw_processes();
>   Restore_console:
> 
> 
> 



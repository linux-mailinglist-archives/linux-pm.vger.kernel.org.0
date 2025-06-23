Return-Path: <linux-pm+bounces-29245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FFEAE33F0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 05:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C72D16C7AF
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 03:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F0C4CE08;
	Mon, 23 Jun 2025 03:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bc+DCLkA"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1EE4C83
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750649043; cv=none; b=lGyg1osXW/AF2H+kQY0I4gsRaAbVYQbRDhZxBOgwdWlYXhaOZThT3svejs+7RIQoEVUG5LLwd7/VcErAeh8rlkFhV+tub2Ss8E3obv0geJaNNfK+K4Qxak8yPsAbCSpJgJ3khj0+z/D05Q3jDiMrJoPCAOQJralWYu6sftm/VLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750649043; c=relaxed/simple;
	bh=YkFrTXRe6ZtAHBQw43PlXvc14q9FZUmxADkj+Fj5cCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5KhUuz1pO3hLziTpqh08AmBW4MO0yovqRbD0VeBqULxRFafYS3uKSEJQsk8OuSo+exuWjkhkqIpPRGxapBtedY5GbCeWqXZbEzWYT0xpiAhDUMMZ18mYKoGdTeEXd6kLL6Z/0AAiqASHPLjQH93YDYATrEmOf+abGOKAxt9yRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bc+DCLkA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750649040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mdx3+MXJ0hBfpTTv/vnHBu5EMqZQrUbHtYh1yI/4LFo=;
	b=bc+DCLkAziOlskulf3oRvohlrasGb9NO16AycmhNIk83z2Bm84nOluRshF6XDpGkgl+j++
	EydWJpphgIBs8oOo5t5sYfgZ1OheOqrgiihhRFwOQcHjtoi/p8rIQCWBzZnOoxK8gvTliH
	Hp9CHP3sfiXUiPfAYco2r8XhzKvabgk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-c-10POc5Mv6maAX83CVjaQ-1; Sun,
 22 Jun 2025 23:23:54 -0400
X-MC-Unique: c-10POc5Mv6maAX83CVjaQ-1
X-Mimecast-MFC-AGG-ID: c-10POc5Mv6maAX83CVjaQ_1750649032
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDF7119560B5;
	Mon, 23 Jun 2025 03:23:50 +0000 (UTC)
Received: from localhost (unknown [10.72.112.21])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1748319560B1;
	Mon, 23 Jun 2025 03:23:48 +0000 (UTC)
Date: Mon, 23 Jun 2025 11:23:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Mario Limonciello <superm1@kernel.org>, dwmw2@infradead.org
Cc: mario.limonciello@amd.com, rafael@kernel.org, len.brown@intel.com,
	pavel@kernel.org, gregkh@linuxfoundation.org, dakr@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, christian.koenig@amd.com,
	linux-pm@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] PM: Restrict swap use to later in the suspend sequence
Message-ID: <aFjIv5OqUyiSNrRi@MiWiFi-R3L-srv>
References: <20250613214413.4127087-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613214413.4127087-1-superm1@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 06/13/25 at 04:43pm, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Currently swap is restricted before drivers have had a chance to do their
> prepare() PM callbacks. Restricting swap this early means that if a driver
> needs to evict some content from memory into sawp in it's prepare callback
> it won't be able to.
> 
> On AMD dGPUs this can lead to failed suspends under memory pressure
> situations as all VRAM must be evicted to system memory or swap.
> 
> Move the swap restriction to right after all devices have had a chance to
> do the prepare() callback.  If there is any problem with the sequence,
> restore swap in the appropriate dpm resume callbacks or error handling
> paths.
> 
> Closes: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/base/power/main.c | 5 ++++-
>  include/linux/suspend.h   | 5 +++++
>  kernel/kexec_core.c       | 1 +
>  kernel/power/hibernate.c  | 3 ---
>  kernel/power/power.h      | 5 -----
>  kernel/power/suspend.c    | 3 +--
>  6 files changed, 11 insertions(+), 11 deletions(-)
> 
......snip...
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 9c59fa480b0b6..3a9a9f240dbc9 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1136,6 +1136,7 @@ int kernel_kexec(void)
>   Resume_devices:
>  		dpm_resume_end(PMSG_RESTORE);
>   Resume_console:
> +		pm_restore_gfp_mask();
>  		console_resume_all();
>  		thaw_processes();
>   Restore_console:

This change is inside KEXEC_JUMP scope, let David know this because he
ever tested and made change for KEXEC_JUMP.
......



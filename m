Return-Path: <linux-pm+bounces-20594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3598EA1488F
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 04:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DC43A437B
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 03:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7232E46434;
	Fri, 17 Jan 2025 03:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3qtqeEn"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74AA25A620
	for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737085288; cv=none; b=WXpAQ7fBoDg5lyLwNb6mJH9Wklq6N1T7JeCy+/u/y3TgnIPUxpvZASJUDMUD7aPScyY1k6AlliPe5r5HjKVLVlHTBTzY1Rg8m2n0jY9x64gA5BJocnwgyMabGe1ihXdlCdzu/RK9Gc/diBGWRTfmDu+Eyc9/kY8jgmZ/3RomE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737085288; c=relaxed/simple;
	bh=YMWd9WTCfl+pmp9VBwB8sa2KM+zbCZYG2YGhqW8vPvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcKFo/ZiIeTxDs4IX4sffwKB80BV6yQpTi1yEi80BO4MLKNKqdwAjWVSWXi7qVq2fqMH5Liyp+mqO8IMyaPT1O5wSFGxxHfA9jL0iC76kk7K64VitxSBpQ5EwFr35KlvYcX3d2xoD7yGm83ukLO/VxCbRA3bmoQbbBXcusE8uDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3qtqeEn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737085285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JicVrS6630U6GLKgttTEGLfxPYMVZnTHvkxIjdKwIR8=;
	b=E3qtqeEnogJSN4+upjpCq1rMIqc+C690YIkTCRUHbPcBA/Ec/KpzzPuuV1m/zvfZcA9USa
	j/JdQA5vc8qaR58eijeZPQTZFu2H94axMi8uFiuxy7el1+IDQAc2NepkiWCn/X5UgupaCp
	oeMePePw/B3F3kMaB0xMXdzdVOqx8ec=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-9Nugs1zqOY6ARK2pr1smzg-1; Thu,
 16 Jan 2025 22:41:23 -0500
X-MC-Unique: 9Nugs1zqOY6ARK2pr1smzg-1
X-Mimecast-MFC-AGG-ID: 9Nugs1zqOY6ARK2pr1smzg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A4D619560B7;
	Fri, 17 Jan 2025 03:41:21 +0000 (UTC)
Received: from localhost (unknown [10.72.112.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B113E30001BE;
	Fri, 17 Jan 2025 03:41:19 +0000 (UTC)
Date: Fri, 17 Jan 2025 11:41:14 +0800
From: Baoquan He <bhe@redhat.com>
To: Roberto Ricci <io@r-ricci.it>
Cc: Andrew Morton <akpm@linux-foundation.org>, ebiederm@xmission.com,
	rafael@kernel.org, pavel@ucw.cz, ytcoode@gmail.com,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z4nRWnysvuxLWU32@MiWiFi-R3L-srv>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z4Zjmva-pLbLjtQv@desktop0a>
 <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv>
 <Z4ejbdJr87V3IwV8@desktop0a>
 <Z4jy-NoLxpwaLfyD@desktop0a>
 <Z4m4q8yfIjfMRgZ+@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4m4q8yfIjfMRgZ+@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 01/17/25 at 09:55am, Baoquan He wrote:
> On 01/16/25 at 12:52pm, Roberto Ricci wrote:
> > On 2025-01-15 Wed 13:00:52 +0100, Roberto Ricci wrote:
> > > On 2025-01-15 Wed 12:04:10 +0800, Baoquan He wrote:
> > > > On 01/14/25 at 02:16pm, Roberto Ricci wrote:
> > > > > On 2025-01-13 Mon 22:28:48 +0100, Roberto Ricci wrote:
> ...snip...
> > Also, I can't reproduce with the default config (make defconfig),
> > therefore something in my config (I already sent it) may play a role.
> 
> What I tried is defconfig on 6.13-rc7, let me try your config again.

I tried your config on the latest kernel, reboot will fail during the
new kernel bootup after newly built kernel was installed.

I haven't compared your config with the defconfig to see their
difference. Wondering where your config comes from.



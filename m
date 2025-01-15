Return-Path: <linux-pm+bounces-20454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F417CA11838
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 05:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05653A7A9C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 04:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD7419CC21;
	Wed, 15 Jan 2025 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWn03VrA"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AF156676
	for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2025 04:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913867; cv=none; b=LrzdjMlNexLEaXUbBcbt7JuC3JxiOYoa542UrcnglkgAAFV6z3Z2EQxlwVEM2ZUC8XdhuLDs+9E5RqiIQ4xUrDBOrFWDJ4zntxkf/bEdoSRhAVROdoU6H8OefHFZWrZ9FqeH0wH+DDJ/8nZGE0z0qGjV1Wb8e6152ihRa4Mq8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913867; c=relaxed/simple;
	bh=OutPCBssKJH51fBJ7ANy7MsTaNa+Uu9yOZ3Iho1madA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVLy+qmkD7nOWxqSD2q4+bjxruXTc7G6NZWddfezpaD/YHIJvAfpUZYfNYcrvdf7m5qvT63y6dTwHrE2v7zjBRd8u2p23cmlkfmVfEX4XPNUbxNs6aGAHN+Pzb6M6gcKy9BqlGVcgNXKvvGYPEJVrvETpRQRgWuaJQCj7YirbVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWn03VrA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736913864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+unhOYBjiPAqZTRFood5aIiHdu2obot7zgKwQr1T8N4=;
	b=OWn03VrAPkWTz+qBIltYz+MCHrxN6uGSy+QQnTfYWTfsT5rbsvpZG/op6IqjHqI5rRzgrQ
	9GcBzLvMrdVp6OiWpGFPWVTiEsPtxxwWMu5qQnyE4RkoVusrg4e2i3nJ9K9/qw105ZIpSH
	8WzOVHNlV66UUzqStTvyd8JWJ6NmqqE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-D0RozbHVNbOEewaG-IRirA-1; Tue,
 14 Jan 2025 23:04:21 -0500
X-MC-Unique: D0RozbHVNbOEewaG-IRirA-1
X-Mimecast-MFC-AGG-ID: D0RozbHVNbOEewaG-IRirA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80ED71955DDF;
	Wed, 15 Jan 2025 04:04:18 +0000 (UTC)
Received: from localhost (unknown [10.72.112.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CE473003FD9;
	Wed, 15 Jan 2025 04:04:15 +0000 (UTC)
Date: Wed, 15 Jan 2025 12:04:10 +0800
From: Baoquan He <bhe@redhat.com>
To: Roberto Ricci <io@r-ricci.it>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z4Zjmva-pLbLjtQv@desktop0a>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Zjmva-pLbLjtQv@desktop0a>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 01/14/25 at 02:16pm, Roberto Ricci wrote:
> On 2025-01-13 Mon 22:28:48 +0100, Roberto Ricci wrote:
> > I can reproduce this with kernel 6.13-rc7 in a qemu x86_64 virtual machine
> > running Void Linux, with the following commands:
> > 
> > ```
> > # kexec -l /boot/vmlinuz-6.13.0-rc7 --initrd=/boot/initramfs-6.13.0-rc7 --reuse-cmdline
> > # reboot
> > # printf reboot >/sys/power/disk
> > # printf disk >/sys/power/state
> > ```
> 
> Looks like it's the kernel performing the kexec which causes the issue,
> not the target one. E.g.: kexec-ing 6.7 from 6.13-rc7 makes resume from
> hibernation fail; but if I kexec 6.13-rc7 from 6.7, then it works fine.

I tried the latest mainline kernel with your above command execution
series, I didn't see the problem you reported. Can you try kexec from
6.7 to 6.7 or something like that and try to bisect a specific criminal
commit?

As for below commit, it seems not a suspect.
18d565ea95fe ("kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()")

If possible, can you revert below two commits altogether to have a try?
I am not sure if they caused the problem.

18d565ea95fe kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()
816d334afa85 kexec: modify the meaning of the end parameter in kimage_is_destination_range()

Thanks
Baoquan



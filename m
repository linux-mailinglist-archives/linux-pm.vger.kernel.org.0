Return-Path: <linux-pm+bounces-20590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CBDA147CE
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 02:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A2D7A22F9
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 01:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE251E1041;
	Fri, 17 Jan 2025 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTNHDn3u"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B053B25A65B
	for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 01:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737078973; cv=none; b=hzreEMrJBxg/Ywu6pnDcPhOyEQKLV5oLLu0kkb+mAakVdwe7IphzjAxHVcgHuhXCR9FsQ2a9TupUOyRsL+Ck5zZzAGGRc8WkiU1N2/lWzUGHSm81Kotge3GFj8SIjd2PAt7MKP9N23DgO7CSxBsYXH4wDDaln7nOTRyLMmwMTs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737078973; c=relaxed/simple;
	bh=FBe3eeTEFS2c2V0/g2HvswYNSDDgWbxsTGLzAw3EfuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1qGODAuFbBydaEYTDfNs9uqzU2eRfN059U/kEO3VigZjHC2MoyLLOK7Kq/9h7ETztVg4BXTwPTPTInNRVNR9aQHAoRcWZ3lUSgQIPgTljZnOlMLXgCCv6KZKySRYbvCu7PNaMNVRP/IZqX6xYUIAr/qfPQpN1pZ2eMMuBXznIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTNHDn3u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737078970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FBe3eeTEFS2c2V0/g2HvswYNSDDgWbxsTGLzAw3EfuQ=;
	b=hTNHDn3uKL4s/ytdwiUKSj+C1ojwIAYe8JxfipRBd12PeH38hLg6DBkqV7StSbb8PxPbQM
	je2jpHTe16Dgfnxl6ik7ytFL1/eMNMptPbnASrA6xlQMBuOUOvt65V3AWiT08UWCXT5NOm
	i6I+WdqBKxbePAYAmO2+wBta0akTx9Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-84aStPJhPwWpmp7hpABuyA-1; Thu,
 16 Jan 2025 20:56:05 -0500
X-MC-Unique: 84aStPJhPwWpmp7hpABuyA-1
X-Mimecast-MFC-AGG-ID: 84aStPJhPwWpmp7hpABuyA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDDBA19560AB;
	Fri, 17 Jan 2025 01:56:02 +0000 (UTC)
Received: from localhost (unknown [10.72.112.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C485195608A;
	Fri, 17 Jan 2025 01:56:00 +0000 (UTC)
Date: Fri, 17 Jan 2025 09:55:55 +0800
From: Baoquan He <bhe@redhat.com>
To: Roberto Ricci <io@r-ricci.it>
Cc: Andrew Morton <akpm@linux-foundation.org>, ebiederm@xmission.com,
	rafael@kernel.org, pavel@ucw.cz, ytcoode@gmail.com,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z4m4q8yfIjfMRgZ+@MiWiFi-R3L-srv>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z4Zjmva-pLbLjtQv@desktop0a>
 <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv>
 <Z4ejbdJr87V3IwV8@desktop0a>
 <Z4jy-NoLxpwaLfyD@desktop0a>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4jy-NoLxpwaLfyD@desktop0a>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 01/16/25 at 12:52pm, Roberto Ricci wrote:
> On 2025-01-15 Wed 13:00:52 +0100, Roberto Ricci wrote:
> > On 2025-01-15 Wed 12:04:10 +0800, Baoquan He wrote:
> > > On 01/14/25 at 02:16pm, Roberto Ricci wrote:
> > > > On 2025-01-13 Mon 22:28:48 +0100, Roberto Ricci wrote:
...snip...
> Also, I can't reproduce with the default config (make defconfig),
> therefore something in my config (I already sent it) may play a role.

What I tried is defconfig on 6.13-rc7, let me try your config again.



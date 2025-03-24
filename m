Return-Path: <linux-pm+bounces-24461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FBFA6DF18
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 16:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5FA57A3394
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB5925F982;
	Mon, 24 Mar 2025 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hz5wVauC"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F4125EFA3
	for <linux-pm@vger.kernel.org>; Mon, 24 Mar 2025 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831722; cv=none; b=BCRoJ3SJQ/HntRRAjVPqc8czaU3h22OHzXR77CgoOMdzyjHaB4hPgso0qw6kdotpMhAOvDbsPm6PPDDSXZ7l9qOTMOhgeh3GVaYzvTVO8nqIc3K+7A8OLQYMwqkkfuU1NeOqQmjHZXWODYq3ibKTfQsJWzFHMObD7LKeYQLElDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831722; c=relaxed/simple;
	bh=QIR1hi05/g6GX5vJ8xyDI71SYDaIOdbfYqFTw6lDcnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAM0gUzE0x8jxBuHARzeF/mGWHZ+NzSgcDzPKb78G8gXVfBEnt6wzHdBynI38FZmDVY2M/6Q3nPbMppQt+fSxQBxoWdgrorY6EMaA0FHf9zKuSWqHJFRKdcVRNjhVjsyReqaqnT+iwf4D1g6RgmdQPz8D+9eA6YepP7XLPQewMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hz5wVauC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742831719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYGT7Xw83/YffP7iKf58y7BhkYDaYHktMM8ewPKTbKY=;
	b=hz5wVauCWnKhujBIvsRRQ5A9HWqjpb4Wfbxxy51vN12u/567fhZ78dliekbcf37CbtXAsF
	7krFbpYlMvE6RXeKF7JwQVuO6qUQO9v0Z4W+lnEfupSvrowIEnkwmuta7DtKf+pGmbxVez
	TUmvHJBYVqBZLzi4b3DpGhluJYIaTjM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-1uZ6_XTUNSaKA9QZc1wXSw-1; Mon, 24 Mar 2025 11:55:17 -0400
X-MC-Unique: 1uZ6_XTUNSaKA9QZc1wXSw-1
X-Mimecast-MFC-AGG-ID: 1uZ6_XTUNSaKA9QZc1wXSw_1742831717
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4766e03b92bso78252501cf.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Mar 2025 08:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742831717; x=1743436517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYGT7Xw83/YffP7iKf58y7BhkYDaYHktMM8ewPKTbKY=;
        b=OZRPqHNNNLAkiUmieIrwqV9M6lVmO+GqYehTjlHU6jzPAdYSyJEDjdy8jSIZV3DXGg
         uEpbeDaPyelzTD5QokKF4MnlWJoZlWByYwbTyNixAyh8R0fKEcv/LLT+AnBvCOX773bp
         hvwAlgukDX7D2NxHymWpt7ZqCYrSY9V+5zZXLtM6nYxEk/E3kvirrsYMj8pZYee8naS1
         NytlRbNCc9WziJEBu1uuJ41ip3gB/zGLDXy1EqGJOjat69hbayQYL+zO1+Gxvj3S63EX
         el3eLJ7nFMP2Ef80qa0R5w/h9dIwq8KSLmJ3Qam6Rx2zwpq0dUanvZR3i2/EBPiSmzKh
         g3gw==
X-Gm-Message-State: AOJu0YwBUz7DQll87hcOB3D40tHaicnKSQFKfs1Djn4lL4VPK+oxxlpf
	UDN2UgTQAps7zO1ahyT04CVqEp74BE4B/orrhpPs9fp/pUA46JxJ1YCWGwMO5oFYRR7uv5Y3QVu
	E4bAl+IxvPQGf2VkNvGU9DplN2RuSsMhWyltiHNLIAeDiPnk4SvrfVPXU4hAVRj7O3K8=
X-Gm-Gg: ASbGncub5pITwqaxthEfAFI2bTPe778A+bW1PKh6Rri8TbqA//0tcnL4xNw5nQLRfU1
	VQvloMPBYcoKTD7tEiFT9+B3I2HF017wHqElpc8RlQO6Aq4QAFBs+gXxVlmaz6qoMeqCZ13hKqr
	AdF7o79ii2WbLSKzOYtslMti6RdSb1kEtiocenT8xBoMVf4s2BuOAOcH6BEYEMBlDfqtffWK2fI
	D3NdBHyKNReIaDJudbA+GmdjHepTobaBHZ1OKWLwXv9oZ8OuwYItP90iJ2IHieJyIWtTevbYlna
	CiniLG59RGSF
X-Received: by 2002:ac8:6906:0:b0:474:db2f:bd32 with SMTP id d75a77b69052e-4771de10564mr217797911cf.38.1742831717021;
        Mon, 24 Mar 2025 08:55:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPqsb28S9uOXsT2TgN/D0qkwhTRrId3lYsVYEWbN0vZVqm+U5DDFdyNxX25YX1O0SLyOYYRg==
X-Received: by 2002:ac8:6906:0:b0:474:db2f:bd32 with SMTP id d75a77b69052e-4771de10564mr217797361cf.38.1742831716497;
        Mon, 24 Mar 2025 08:55:16 -0700 (PDT)
Received: from thinkpad2024 ([71.217.80.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d159a35sm48352431cf.15.2025.03.24.08.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:55:16 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:55:14 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Francesco Poli <invernomuto@paranoici.org>
Cc: linux-pm list <linux-pm@vger.kernel.org>,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>
Subject: Re: cpupower: systemd unit to run cpupower at boot
Message-ID: <Z-GAYiIY8plyqDk3@thinkpad2024>
References: <20250322180357.1c17a180f1808533de77f186@paranoici.org>
 <Z-FQwMuVf_p7FoHn@thinkpad2024>
 <20250324154247.7fff2ca1c0df263c16a0f397@paranoici.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324154247.7fff2ca1c0df263c16a0f397@paranoici.org>

On Mon, Mar 24, 2025 at 03:42:47PM +0100, Francesco Poli wrote:
> On Mon, 24 Mar 2025 08:32:00 -0400 John B. Wyatt IV wrote:
> 
> > On Sat, Mar 22, 2025 at 06:03:57PM +0100, Francesco Poli wrote:
> > > The attached files are tested on Debian GNU/Linux trixie (current
> > 
> > Would you please submit this in the form of a patch that we can apply
> > to the tree?
> 
> Thanks for your reply.

You are welcome.

> I can try to submit in the form of a patch.

Looking for to it. I have not read your patch so far; this will be the
first step towards review.

> 
> > 
> > Please read (note the no attachments):
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> 
> Wow, long document!
> I am beginning to read it.
> 
> A question: should I base the patch on the mainline tree
> <git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git>
> or should I clone another, more specific tree?

That is a good question. You can use Shuah's cpupower branch for this.

If you have already cloned the Linux kernel you can simply add the
remote into your local clone of the repo:

cd into your local clone of the kernel

git remote add shuah-cpupower https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git

git fetch shuah-cpupower && git switch cpupower

Otherwise you can git clone that url.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat



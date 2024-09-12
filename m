Return-Path: <linux-pm+bounces-14087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5D2976920
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 14:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064A3285804
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF7B1A4E9F;
	Thu, 12 Sep 2024 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZwVJlC8"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2331A4E99
	for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726144093; cv=none; b=pVO799/ZHykZ0EwCr15GJCghKyrgIuGCVLnO/oAtitiv8BT6Eo+tCuroxjuZip06tRU2XVU+nm2zMt4I/NYRHIsO6nxculaM9Qe0g8LQ7S/7ACLAhedglOjMPYOD5XknCRlywkWbRshm84vukn/B4ycNKdTNNZdnBjrMOMQi85Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726144093; c=relaxed/simple;
	bh=fEYiCcSX2cV8Z3LqfRf2jtY34QnJdae7Z4CSXtJ+2to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiGsd2j/cUNPSSf2/igsAnTzdaco+Hdi10cRLEUrNC90/fcljDcenxkrYfN09e9i4GRspL85vGX8oTjpaBCjD/W75HYLDyvPGbCqwAMzDbKjjFP9Mi17+nn0h44r3sW2vHWaLqOjJ3zg7Qdl2roV5mCTzuIMudIYeIpmPynns/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZwVJlC8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726144090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FwLzZkmd0ZQgN84oz03gWh6XczquwyNmIfnUG06CewU=;
	b=NZwVJlC8S3tzohxc6GKUqliU2zdcKSF0PtGIqjANRcH+5ktUnjESEKyARzcC+IEh2jWpgT
	uVe1fl1EAFKNmFoCxHnX/zoBXtoFXzxtDABzZI+020fFJ6ptKNn9Ogg0QVpdBFWfhU+pJL
	E8wEzoUhgbkv0CClkCO5iCAFH4eNx98=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-lBMqZLb1M2ONqij8gHMz3w-1; Thu, 12 Sep 2024 08:28:09 -0400
X-MC-Unique: lBMqZLb1M2ONqij8gHMz3w-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e165fc5d94fso1773996276.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 05:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726144089; x=1726748889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwLzZkmd0ZQgN84oz03gWh6XczquwyNmIfnUG06CewU=;
        b=gO9BKkknEspHNb/nwmQYSvvgU38pg5+3E9rs93N+qoPmF+qsdtH3qVnGs4lZuJqVHM
         c1//pRVUj7P9GJQEwiX2q4HGYpAnqPTWIBlNgpa5hz3og57lVQnl0QiNOilPYCi8rfYx
         jrP3FbYBTJ4DnBGGwHs9zbb/m5tIolFi9THMnWRlbQWI0Zm7h0lk6dQc4FBa7PHAw85Z
         aSd4Lxo1ToBmr6NIdRLQAAA3YVIQDDZxmtd08qH7jmHh4dY2HbVzLKSIM9siyqWhEzCa
         nj7ojXDMK2GDZHYJOEOkM3j0W3NJeGvdWxIAxgKnTK88pprsPbMttiAYL2IOtdfzSS1R
         bj6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkRtEUHY6jIbFNBwUlh0shovmOsgcqasao+GEwCgym4u9CPftVUjCeQRCeFMm00zSlZIEfa0gAwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5imDVkHhZr4ON7tGRb2K7FoRzJXP9JnGu2VfY9xxdxydKXn/7
	K1KGNua/wxOTvM/l7+qoprSUeOSX6hlDXtcpUpY4rCoGs8R2iqJukRC/tkL4D6s3PG5juHLPHpx
	jW8L4adAPjpXMOQCWiLNsJ/VyftvtsxEz15syQCwq+9pCkkl3ziLLemw70DHp+Jeq
X-Received: by 2002:a25:d8c6:0:b0:e1d:a163:1388 with SMTP id 3f1490d57ef6-e1da1631796mr1167340276.48.1726144088662;
        Thu, 12 Sep 2024 05:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhhzrxqO7X/GruaDObktRaDclR2OL3TS2/b52FR2g1yx9f2p0K7GyH5peWSzidW30OHXt1Ag==
X-Received: by 2002:a25:d8c6:0:b0:e1d:a163:1388 with SMTP id 3f1490d57ef6-e1da1631796mr1167293276.48.1726144087062;
        Thu, 12 Sep 2024 05:28:07 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f60a81sm52335231cf.67.2024.09.12.05.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 05:28:06 -0700 (PDT)
Date: Thu, 12 Sep 2024 08:28:04 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>, Peng Fan <peng.fan@nxp.com>,
	"open list:CPU POWER MONITORING SUBSYSTEM" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] pm: cpupower: bench: print path fopen failed
Message-ID: <ZuLeVCUx4S8mn-2z@rhfedora>
References: <20240912013846.3058728-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912013846.3058728-1-peng.fan@oss.nxp.com>

Hello Peng,

These two seem like two separate patches and usually a series has a
cover letter. Did you mean to send them separately or is something missing?

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat



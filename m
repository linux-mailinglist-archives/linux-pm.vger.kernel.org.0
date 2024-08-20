Return-Path: <linux-pm+bounces-12519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBC2957E85
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 08:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE4C1C241FA
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 06:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D0A18C011;
	Tue, 20 Aug 2024 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5CP4O46"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4029B18C009
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 06:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724136035; cv=none; b=m7pmyKzxC9V9QkZH4B6ek2eb5WUGUvdsue92ZjG68b9Gwyealb5BZv+2KovesarBIV5aei1zF3tAQBq6T/1KPNfNpQjsuuQc8W6wgoq2t+TdYeTKV+OYuffegugkhXwC0LLnDv/2pGJHEPo7me9vOePQt0QyvSFtmD5vE/z4B+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724136035; c=relaxed/simple;
	bh=15UH5N8RvByknQFgvTBOI7zYBxbzOSOr6Znak6JM2sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ke39L27EaI0aTmYPmJRbhH8YHkZFznBqIZUMo04Ce7YEBlousomxIMZGau6LJhxhVNSVHkYP4EmYi7r8QzMg64cTM0FHJ4n0UkNjSsl3P1VIb0T4xlvfKWlp7bPykO08BDNEk9Qj+uFtAJu0Zs5yYrT4K2uv226yrvaikkkBsm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5CP4O46; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724136033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTEWIGxuQjibL588vtu8KylgICyjhCyrybpbVqP9eqM=;
	b=N5CP4O46mV4eO/pWYrlvS6Eem406oTogwN+vAeHzHYuA2FHOkihIWZGLChI8xviDXPFhKJ
	Z4n4x1anXz92f8WU3/TLOjN09IgvQEObj0K0e5WGKF7kXqRQWMHwG83fR87PQOeI/tSLnk
	T9LNSWK7NiLyAlOyJExzcsCkI9znA3Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-HzVvRiF1PjyKU6kVTnp08g-1; Tue, 20 Aug 2024 02:40:31 -0400
X-MC-Unique: HzVvRiF1PjyKU6kVTnp08g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6bf6dc40a39so66010746d6.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 23:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724136031; x=1724740831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTEWIGxuQjibL588vtu8KylgICyjhCyrybpbVqP9eqM=;
        b=V8ZsviTputyMo0oFUs5fclz0Hq29BlPfCpX0WopU6SxtXYyARHqYJ1siwg5tMi3vV/
         wERZM53+2rmu04xpgKDDIeABQJvEft1Kbv0ZmezIVZP8+w2YYd5OryaHEkNTJHf5bozh
         4GEkh5lZvHvSWq1dpb3nlzCa+hE4OOzOZQXobj2kxOKmBg1DdBWClI9puPDTTRT1O4lX
         MgSTpuPo+MpjwDbcwjYLUAm1hdpVwKusgvNEVx2SGNzxd+P2FC3oQHhfwP6pN4bXMW3+
         c0ZHztb0wD2aFitjH0xFFlrZHdiFVuPvLKgifygBYnSwi+rT8idnGdwmGdIsinPNRD9Q
         XyJw==
X-Gm-Message-State: AOJu0YzM+t1Ce95mx9l3HB2OVzGZdBQDfYblpyPcyGsyHsIHULA+X8XD
	hnjoexhx9DRhZ7iaLkpxGg9d46CRNpPz+l7CTN9zK4bD3NHfEZXMNdV/iJQ4oQQrkwX8PmoWs4+
	JLlNTPHmdudWibv8AW7pGilYg3FQHxxl0anbVm+534xizkLDgFUYNFhj0
X-Received: by 2002:a05:6214:3d07:b0:6b5:e895:82f0 with SMTP id 6a1803df08f44-6bf7ce5f9c0mr177450866d6.43.1724136031402;
        Mon, 19 Aug 2024 23:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7IXov9rapEYo20mlC1Ac8XNsv4V0P307FJH1DBt4tDq1PP9/jepF/Dveyd/aAdyFYkAPCIg==
X-Received: by 2002:a05:6214:3d07:b0:6b5:e895:82f0 with SMTP id 6a1803df08f44-6bf7ce5f9c0mr177450726d6.43.1724136031061;
        Mon, 19 Aug 2024 23:40:31 -0700 (PDT)
Received: from rhfedora ([71.217.43.75])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec603fsm49544726d6.93.2024.08.19.23.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 23:40:30 -0700 (PDT)
Date: Tue, 20 Aug 2024 02:40:28 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH 0/2][RFC] Add SWIG Bindings to libcpupower
Message-ID: <ZsQ6XKQ4pRFYkGoS@rhfedora>
References: <20240724221122.54601-1-jwyatt@redhat.com>
 <1f5c24b6-f3ee-4863-8b7a-49344a550206@linuxfoundation.org>
 <Zqv9BOjxLAgyNP5B@hatbackup>
 <2024080405-roundish-casket-2474@gregkh>
 <ZrKOCLYvYklsPg1K@fedora.redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrKOCLYvYklsPg1K@fedora.redhat.com>

I wanted to follow up on this since I am close to sending out the v2 of
this patchset.

3 points I wanted to raise:

1) Does everyone understand, is okay with the SWIG license, and wants to
proceed with me sending in a more complete version of this as a candidate for
upstreaming?

2) About maintainership: if I am to be the maintainer of this, how would
myself and John Kacur be listed? As a CPU POWER MONITORING SUBSYSTEM
maintainer, a separate category below it called CPU POWER MONITORING SUBSYSTEM
PYTHON BINDINGS maintainer, or is not needed to be listed at this time?

A quick search for bindings shows what I believe to be all of them for device
tree. This may establish a new precedent.

If I was to be added, I assume it would be a separate commit in the v2
submission?

3) I had to comment out powercap_set_enabled

SWIG reported this symbol not being found despite being in powercap.h. I did a
quick search and was not able to find it's implementation in powercap.c. The
get equivalent powercap_get_enabled is in powercap.c. Wanted to check on this
just in case it is a bug or part of future functionality. I am assuming the
latter; I would send it v2 with that declaration commented out with a note
explaining it for users if there is no objection.
-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat



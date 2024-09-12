Return-Path: <linux-pm+bounces-14105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEF1976FE1
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 19:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9BA1C23E57
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 17:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7691BF7F2;
	Thu, 12 Sep 2024 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyJ9+rTU"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578D7149C50
	for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163956; cv=none; b=R/ImIBAjYKsslCnAumvDoA90clZ3E6AVermJihygFU+6o8agCSEY6rILsVm0v3FbIIhpbT2jz1OCF3ITw0ZsbZ1gn3pJBkCP8vcE5xo5z3+MZ0BRg1D8LMNpQu2skryaKm0jfNcK2qKEEph3k3j5qK9FfaTxRqfgN0CF9OZ16lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163956; c=relaxed/simple;
	bh=x7Slkk4UTVEhNOG7KY9whc2LQASGeUJWYs/+SpGCYuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F78NtqohGhU0JfkIyN5HAunUSJaSmSbkcjGwTrBZ1HnurA0LVB52SIbuRgP84nL0+Pzwe4duemSpjmM+zaixj1rxoW5LR/HNA//5Y4oqrCrtfPp3p2keRKdq/91HDjy+B8l7jYU1V41MV1UqbYvBF0wAWA3M+r/VdHAbQkdlygw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyJ9+rTU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726163953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q99gZYa7eGcgFNqfCTuKT2bHaiWalO32/+jaTz1Ui94=;
	b=MyJ9+rTU8Cv6RBYWCZNqmoF3itBJZIaqSIFhU9HvcXlnpoWTka/AzfU5XicwBylRZc5L2F
	lcW2y7dsJk0xSrYcCPlOqFsIXieRUtqf/uHpnwa1qkvT1WCQMS0M8+5cyFur13W0pqIcOY
	FuK95JXOCUfVrP2Ps2Rs0JFc/pyzsLs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-MaQeSItANqi3XJt_pgDT8w-1; Thu, 12 Sep 2024 13:59:12 -0400
X-MC-Unique: MaQeSItANqi3XJt_pgDT8w-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a99fcd374cso12162485a.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 10:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726163951; x=1726768751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q99gZYa7eGcgFNqfCTuKT2bHaiWalO32/+jaTz1Ui94=;
        b=hkKQEkgFvqPGVb1dF9mBKjXAoq7QEQTILp/WaPZw9uUUQed58Z2oGfWJLcwZyZegcB
         SzOyXlgeGmGAvTw29ql2DXOuG6vTXpCA5RlJXwd2XIjeV0uA9QcN1kra/I6hKe7Jq4rZ
         wI5e/t7FcMjXRG3NK/x1e0hmMft9phkFgZGUCC8VWk3vR9L6q/fyD0bwvdwKJeoxjm7u
         a/UcfF3v7cGTthQDnPf2N4boa6MHRKl8Cw5dGIGopDFZPkUQyAN1w7Ol042XEKnnGa9x
         v8gK0coUECXwZIArPrNhiKoy9W/UBpKyuaa/VAZpbXbsxJ9njbc4J2TxRoClrMmK53g7
         3SkA==
X-Gm-Message-State: AOJu0YwU0TBQ1pNwRZjU6zlpRVYYUhjLL/zvYeORAnjc1U+nixIO0Qvi
	Hl1iS0+PQJ1zOTywIJeLusI9nae00b4vdvcylDfVJ2ZpTUkgj8iFcVocYJMMtmEk3byCRIPKDXY
	WjL1ig7UUk/VLZbOK1bjSa/8tH+7xZ6cT7NL6oSXVdtpiA2YcYOD/l9LJ
X-Received: by 2002:a05:620a:170f:b0:7a9:b2dc:99a6 with SMTP id af79cd13be357-7ab30d18060mr12254485a.24.1726163951661;
        Thu, 12 Sep 2024 10:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuEm6eD0gm/9ouhc+EilxD/EAFO2XKFNasZ+lNN/4rvlaq3VMrgwZ0blUByTUSVbvCH/3FUA==
X-Received: by 2002:a05:620a:170f:b0:7a9:b2dc:99a6 with SMTP id af79cd13be357-7ab30d18060mr12251685a.24.1726163951220;
        Thu, 12 Sep 2024 10:59:11 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e61afbsm55554371cf.18.2024.09.12.10.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:59:10 -0700 (PDT)
Date: Thu, 12 Sep 2024 13:59:08 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH 1/1] pm:cpupower: Add error warning when SWIG is not
 installed
Message-ID: <ZuMr7DcmFqdkp9kx@rhfedora>
References: <20240906130010.93773-1-jwyatt@redhat.com>
 <29d23b0c-02ca-4087-b96b-c24767f64323@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29d23b0c-02ca-4087-b96b-c24767f64323@linuxfoundation.org>

On Fri, Sep 06, 2024 at 11:02:35AM -0600, Shuah Khan wrote:
> On 9/6/24 07:00, John B. Wyatt IV wrote:
> > Add error message to better explain to the user when SWIG and
> > python-config is missing from the path. Makefile was cleaned up
> > and unneeded elements were removed.
> > 
> 
> > Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> > Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> > Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> 
> Thank you. You don't need 1/1 in the prefix for single patches.
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/?h=cpupowe
> for Linux 6.12-rc1

You are welcome and thank you for the guidance on improving my make skills.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat



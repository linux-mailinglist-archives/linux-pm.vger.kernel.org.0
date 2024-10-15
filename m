Return-Path: <linux-pm+bounces-15681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E5199F460
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 19:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AECB1F2502A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 17:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CD31F76D9;
	Tue, 15 Oct 2024 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFVZ56TB"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150516EBE8
	for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014588; cv=none; b=QzvEOtbyofFiJb9BqhsRcl0cS+f6t8R8ASgzaEYN4lgegjnhQR00DcihyDbjP0fLQE3xp6yxKbnkwDr2fGuuW2yuqeFPgbthccuNsVNCPU8MX0OIfSGCZ25VJbie1y6nGLxdL+MC0mThzhgFv4toQN/TrYVSYsPc2T7HvC4VbU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014588; c=relaxed/simple;
	bh=7kWgrMEO6loNB7NygImGkJGahVPoGsbxQYMBnDobhbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abp3qL8ZLccW9d/gqtu4BYomhhqPT7BHZOBLQiKEpCscvKQWz1ktMjyVkOnk5k1svB0t0DAjtVlDYmLRdMxkOEw+FKKpwXERjX4FouuSjxOfEg3DTOk6V5kZEMw2JglFvnTE5VGvj2UBMQQJJ/HPwPkszOpNtLYQ72p/RJVosXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFVZ56TB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729014586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ALxALlMAvaOhrUQ5bqdkOgIzp0TotkHgbGrn2RsRYc=;
	b=cFVZ56TB5aWc5WN+P2zE80vq8K7rqFxFckyJm7J+c4u61V5op4KFjaCIPhLhlvW5/UM67s
	US1OxKKtyIZld1aWmlC9dVbH12LBZcx/OT3bsLBA4TlbripMa69IzBAFlIvKKPzgZNSXSt
	4Nqpxgs151MCHr1osAPszE9IHQ+8fB4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-BO-E0LN8PlKeca2yWw2Iyg-1; Tue, 15 Oct 2024 13:49:45 -0400
X-MC-Unique: BO-E0LN8PlKeca2yWw2Iyg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b02e01d8fcso19081585a.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 10:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729014584; x=1729619384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ALxALlMAvaOhrUQ5bqdkOgIzp0TotkHgbGrn2RsRYc=;
        b=J/6hVllP+ASxf34K/F2+J8lTtDTcaWLBp2CERd7acMwj8bvKgcwe4bvU76+CIr+66h
         gm7d845gwfUh6BLEw/p1wRXUlDnCbZctYD8W6WX1QZ6RoonumiETf4POySSGOqOYKAQR
         Dzvxw9e2NvmjZtl4WeVMQdHKtwZk/ielLdPifIKQGngiz8w+H/X7d5w5T82ruiyPqb/e
         9VhOMADmY4rgJdmg9DZTGygIrwr2Whhxh5nb2b9+2vD6L6gJOnxb3z2M1caABP6cKhcd
         9FA8wdoat6kxMsKPewZIz+7WTZl5pXDhIwApGkYGZX1vEmBD2ybIM5s0xH7KLVpjeZOB
         OL0g==
X-Forwarded-Encrypted: i=1; AJvYcCX0veNahojVhC/LzRL/l+C4W7t74vRr23/ndjDVT9kSLqyD2oke+oAoLrNvzA72tthFYkPbX7hPkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWf+Y1QaVaUpTf5mL0QXdQD680KO5hpMJqW5xNg/Ed19FCJQEz
	T0Hg1muKKmoTm6iitRRNu1m9ioknCitYAK3KRM2PS45vGSa8K1J5MSknYQNnSUk3OrnyBdnP6/f
	BjdokvO2xfgtjndx3Bdb85TGIdgLbNSA83WsJTEsingfjRTYp4/QTT2Rr
X-Received: by 2002:a05:620a:1910:b0:7ac:e8bf:894a with SMTP id af79cd13be357-7b1405b770bmr250425285a.20.1729014584508;
        Tue, 15 Oct 2024 10:49:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsEFdrNSJuBQeAX9fyCk8SxX05w8FCU1FeS0sIeKrrHMXo1X60fEcbio/fTOjmm626loQXpw==
X-Received: by 2002:a05:620a:1910:b0:7ac:e8bf:894a with SMTP id af79cd13be357-7b1405b770bmr250421785a.20.1729014584131;
        Tue, 15 Oct 2024 10:49:44 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b143c31d6dsm5333785a.52.2024.10.15.10.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 10:49:43 -0700 (PDT)
Date: Tue, 15 Oct 2024 13:49:41 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: shuah@kernel.org, trenn@suse.com, jkacur@redhat.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpupower: add checks for xgettext and msgfmt
Message-ID: <Zw6rNVJ1iIjLr1Y2@rhfedora>
References: <20241015163854.35204-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015163854.35204-1-simeddon@gmail.com>

On Tue, Oct 15, 2024 at 10:08:54PM +0530, Siddharth Menon wrote:
> Check whether xgettext and msgfmt are available on the system before
> attempting to generate the .pot and .gmo files and generate.
> In case of missing dependency, generate error message directing user
> to install the necessary package.

Thank you for your patch. Tried a quick few tests by running `make` without
gettext installed.

>  $(OUTPUT)po/$(PACKAGE).pot: $(UTIL_SRC)
>  	$(ECHO) "  GETTEXT " $@
> -	$(QUIET) xgettext --default-domain=$(PACKAGE) --add-comments \
> -		--keyword=_ --keyword=N_ $(UTIL_SRC) -p $(@D) -o $(@F)
> +	$(QUIET) if ! command -v xgettext > /dev/null; then \
> +		echo "Error: gettext not found. Please install gettext."; \
> +	else \
> +		xgettext --default-domain=$(PACKAGE) --add-comments \
> +		--keyword=_ --keyword=N_ $(UTIL_SRC) -p $(@D) -o $(@F); \
> +	fi

I tested this on a Fedora 40 server. I was not able to get this message to
print despite xgettext not being in the path.

>  
>  $(OUTPUT)po/%.gmo: po/%.po
>  	$(ECHO) "  MSGFMT  " $@
> -	$(QUIET) msgfmt -o $@ po/$*.po
> +	$(QUIET) if ! command -v msgfmt > /dev/null; then \
> +		echo "Error: msgfmt not found. Make sure gettext is set up correctly."; \
> +	else \
> +		msgfmt -o $@ po/$*.po; \
> +	fi

I was able to get this to print without the gettext pkg being installed
and it did not print with it installed. This ran fine.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat



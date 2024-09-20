Return-Path: <linux-pm+bounces-14515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EBD97D58C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 14:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE762853F5
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 12:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE45F14EC46;
	Fri, 20 Sep 2024 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6H2h41E"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3418B14EC42
	for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836106; cv=none; b=Cun+49GKr4CDBKmqmWzf0dbXGg8v/73uk+i2J62LGlkeZe637/UGzHQJZ+cNpi4VKvNjKfHOsIDx2GxqYDUTUhyfnPzNY0iOynJtiCrCY5wwuaJXt2ligFrl0js/JaElmEUNfY/6tJyEROK5MVeut3faQJWQ6DBI13bxUQ2RT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836106; c=relaxed/simple;
	bh=0WBFv8ZA/oo3j8ELhbh8DQGgWxcTm466AwnPjGt38mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFxELR8RVT5byFL8+knwQn0LfB8AYdvIK+EAskBSN8OtQ6WdqTfM8f2mbRYb/BkeGmcgmXJ6qDF/kr06iJr5BTqceLTHRCiXtdqCSGzgdSrccn+yr2lAmeR+77uCnjvr06Bb80JwGSyihaOOOZMwg5Ghf5RwPuu3d0lJm+k1Dck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6H2h41E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726836104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S8278FaFTM3d6Aw9sPU40vZ5+RejEtI0zdZPEAND+qI=;
	b=P6H2h41EgbdLX5qSnpXZ9far8Girvy9CcqPFlWL7LxBLX48Q/MAKvjetgjHuhLzwUUiRDj
	0UOO3zBqRMh/ADy+JM7//7W7XegsC0UdFDbo1FmjxcdU71n0uIajrdFUd0I73qecy2V0D8
	z092aYN5rF4blOhQxGdxPkpQJP3Pka8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-BDpQPVziNteN_V6DpoyKbQ-1; Fri, 20 Sep 2024 08:41:42 -0400
X-MC-Unique: BDpQPVziNteN_V6DpoyKbQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6c517e32a97so32351276d6.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2024 05:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836102; x=1727440902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8278FaFTM3d6Aw9sPU40vZ5+RejEtI0zdZPEAND+qI=;
        b=nssctbwwCKHXVVM9E/mEsebhxNH5403d5Fak7Ym9Dh2c9XRKYa9zVnQvZ9DL9bnXyx
         A5nIgITQA8+JjP9rd8e3OJl+aqFYba/Oh0hf+OTFZO+10vyRJCavVs/nVcia6SrFNMML
         U/gX8xc4ISg+L3sqLetVJfi3k1yqsOn4GwIFlrMfsXEwJwjMXtkB4tyS9BLlP3yszxiE
         0d4h4kq6ejREDyLR13Wb82ImOYuauuvufA/xdGoAcPBjvbd71EF+YttDnnuHVHR1JB26
         6pByosdsvX+KlIZu7WfYXszmTEFRy5v287cDrst3Bzdgfr5N4m9rxQCFOyn2EVsDo1dV
         nRHg==
X-Forwarded-Encrypted: i=1; AJvYcCU5vszAMrfJ538EHuLA1LHwhS5QxaffV7iw+8udA+f6j/Z+VKNcPch5qEfdczUnD1VbF+KDnq+u3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw070W3KK+TJ1zXn4WOGKilh3LaKrMz+6LPNpv7IENG4T1c6+hM
	Mi2EQ+Z4M8nw8O+wLxGV+sJFyMHlQGxe1iXSYV+J0lTnqJS4RuA4sw3HO5p530qVnBPrj1mCIjM
	7SAouE8JJcoKFL9XgVXFM7N/Tf4DzXyi09SYHqkwGcaYxqEfzCsGnYdPg
X-Received: by 2002:a05:6214:5bca:b0:6c5:acf0:400 with SMTP id 6a1803df08f44-6c7bc840d7bmr33864206d6.52.1726836102450;
        Fri, 20 Sep 2024 05:41:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeZYlCDagt49geOPi8bJoCNqqITveP2mhvBOTHqrlbKm5mYcL7GSCJ1GilaoYeitL7x0r7PA==
X-Received: by 2002:a05:6214:5bca:b0:6c5:acf0:400 with SMTP id 6a1803df08f44-6c7bc840d7bmr33863946d6.52.1726836102067;
        Fri, 20 Sep 2024 05:41:42 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e46142csm17151586d6.47.2024.09.20.05.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:41:41 -0700 (PDT)
Date: Fri, 20 Sep 2024 08:41:40 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] tools: power: cpupower: Allow overriding
 cross-compiling envs
Message-ID: <Zu1thIT0V11C4l-5@rhfedora>
References: <20240919-pm-v2-0-0f25686556b5@nxp.com>
 <ZuxTjy7I-pZBcXa0@rhfedora>
 <PAXPR04MB845910C56EA61D3215DA5452886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PAXPR04MB84591B0819F847D79548CFB0886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84591B0819F847D79548CFB0886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Fri, Sep 20, 2024 at 09:01:49AM +0000, Peng Fan wrote:
> > > > V2:
> > > >  subject update, commit log update in patch 1, 2  Use strerror in
> > > > patch 1  without patch 2, need update Makefile with 'CROSS =
> > [cross
> > > > toolchain path]/aarch64-poky-linux-'
> > >
> > > Version information is applied per commit patch. Not in the cover
> > > letter.
> > >
> 
> Just get this from the page:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format
> When sending a next version, add a patch changelog to the cover
> Letter or to individual patches explaining difference against
> previous submission
> 
> So it is fine to put changelog in cover-letter?

Ah, my mistake. It is fine.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat



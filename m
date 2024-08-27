Return-Path: <linux-pm+bounces-12995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1208C96162C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 19:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446841C2371F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E768D1D27B2;
	Tue, 27 Aug 2024 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBS15at/"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682881D279D
	for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781496; cv=none; b=tFuajtn31KJc8CFpXuf5mTky2plJ41EhIoSnCdmQmzFQwBh67UyUxBedziYXqcGlwB/Y/BhIBCb4RjfmJNbEhPBeIEstXAsRgAOBJlZLX2/hp/Ew9w5GSkcX0saei2wckUP4YdQRup3HNxe54whYYRozyC+oU/AGeZKlb5x4c1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781496; c=relaxed/simple;
	bh=fGB1KEKEkPkSR3Ku1aCpn1uMlK36034kJVp9jm5KFgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCkrk6u9t08la/v3g/yQAYPk/TfGfFppJ4ZbnFo8u6hQV/vCyD0R2AVFRQ0hdBmIjC/zzSFMO7Cl0nR71Lr09K5skC4v4pMY0P11GdZibQuNSJgpiGHp+y9JYiSWAAxycRULLnnwYT6a/aLWsFRlEUT0cxKqyEGVD6rN2u6PWtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBS15at/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724781494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DNE55uiPfv0rSAnNkK+dDLxJioGrxTnawTlM17hUAPo=;
	b=ZBS15at/UZ1eWzXNvcsxf5yyrOWBtYY2VX1LBN1aiP3HmD+dE6lvvaHjIz/m7lPNL3zzC+
	Pn+qlhrlAgWijF0tGg2hc5kPV0lQIXd9MZOxYpnTus6TAQgAjAV7tJ7rZ+y2OKKB0p6X5u
	iGp3cF9Ud8IR3/BblJCp2U2kntEvmh4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-PUjLlnQAPb2bc3EmvFCd7w-1; Tue, 27 Aug 2024 13:58:10 -0400
X-MC-Unique: PUjLlnQAPb2bc3EmvFCd7w-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6b2822668c2so112495047b3.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 10:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724781490; x=1725386290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNE55uiPfv0rSAnNkK+dDLxJioGrxTnawTlM17hUAPo=;
        b=M3AlLyZOCkVScLCTYNRVnIx02snP6QTb+R7jgxCIIdN4BLJASnoieCfbnFu1AvxNnF
         a049nJclCwDYK29IrBczK1K3l/ikNWdNRYJpzglj1NEkE0IjWHVge2ui7D63gYRw2/6H
         N+SxcCLuZnQCGp3rxdNmIhy2pNdXPLK71PzZQHl1W2P0mkHeqOKXDIO3u7T2jEewuONy
         e9ohjwn8L/XyZP/Ifw/sfz4aNfaombcEs7EDflo4iAyz+50D72L3dNP/qp326VU+Qh9z
         gqg3qhvbpA/6342zdwhWtjtpZSw/p2tndD647C+EbeQSnNjbNmt9wiVovXsCBMq0Ap3U
         HfmQ==
X-Gm-Message-State: AOJu0Yx5mJLwoM4MNcnRIizYbH+n9goD1uVCXTcYCM/84ZV78e7SjYOI
	kBteV38gZEAWgmuoSMSF9Zq2x61aogmXHF19CmkDkCmY7seQH6l2dWZHDFNg7xWiP5C3WE0e1R6
	CGWvKT3Y9Y278z1WI09oZQtPJoQf2P35AVDSNs4OmoXBvnTpfOe2IZKIY
X-Received: by 2002:a05:690c:6612:b0:6b3:a6ff:76a3 with SMTP id 00721157ae682-6cfb9dc2254mr38654597b3.6.1724781490120;
        Tue, 27 Aug 2024 10:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy81mn28ojVuK5Ks5wF0coC0hUnupw8DfXK3JRQ+ewZNXwflOkyOQQt5b98Z5LmX+zys0bRg==
X-Received: by 2002:a05:690c:6612:b0:6b3:a6ff:76a3 with SMTP id 00721157ae682-6cfb9dc2254mr38654377b3.6.1724781489854;
        Tue, 27 Aug 2024 10:58:09 -0700 (PDT)
Received: from rhfedora ([71.217.43.75])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39a753839sm20198267b3.50.2024.08.27.10.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 10:58:09 -0700 (PDT)
Date: Tue, 27 Aug 2024 13:58:07 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2][RFC] Add SWIG Bindings to libcpupower
Message-ID: <Zs4Tr0AzOqNNASGK@rhfedora>
References: <20240724221122.54601-1-jwyatt@redhat.com>
 <1f5c24b6-f3ee-4863-8b7a-49344a550206@linuxfoundation.org>
 <Zqv9BOjxLAgyNP5B@hatbackup>
 <2024080405-roundish-casket-2474@gregkh>
 <ZrKOCLYvYklsPg1K@fedora.redhat.com>
 <ZsQ6XKQ4pRFYkGoS@rhfedora>
 <c7259d79-4e66-48c2-922c-f6ab88b3af69@linuxfoundation.org>
 <61b180e2-6c88-4047-bad9-4d712bd5072d@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b180e2-6c88-4047-bad9-4d712bd5072d@linuxfoundation.org>

On Wed, Aug 21, 2024 at 09:25:52PM -0600, Shuah Khan wrote:
> On 8/21/24 01:08, Shuah Khan wrote:
> > On 8/20/24 00:40, John B. Wyatt IV wrote:
> > > A quick search for bindings shows what I believe to be all of them for device
> > > tree. This may establish a new precedent.
> > > 
> 
> I don't fully understand the above. Will this patch series include device tree
> changes? I didn't get that from the RFC.

I miswrote. I meant I could not find anything related to bindings for a
user-space program in the kernel repo. Device-bindings was the closest I
could find and it is not relevant. My apologies. Thank you for asking about
that.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat



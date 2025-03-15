Return-Path: <linux-pm+bounces-24099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9936A62A24
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 10:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947637A3BB8
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 09:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51F91F4734;
	Sat, 15 Mar 2025 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="c8QvqUxm"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82B15098F;
	Sat, 15 Mar 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742031169; cv=none; b=cOwtmjofANDQKpBnKqN2fT6GNJlr6KXEK6PXELndu38J+v79H7UnKDZe0DbxinL2JZNG2NFHy4h3l+u1sZcNwEEWilwOHj2vabdq3MmROiViZzjBwkGYpe8uRX2+3fzAPVZMmi63tmgHYpq9zXWCO9H3qBthZ1ZyZwsxXhh2JrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742031169; c=relaxed/simple;
	bh=pryyiKBIyUVztCcbzP+BvrYJp+LtmsNWgXRFzeW32ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWqUMo12/lSiOBtNgY8Neo1Rrin2svyWXHrxbU0kZvarMT2olJBvrGeLt6N95itqHUs176IipGe3ZTfiqlTbQBWGgPx1qJGFKn6UoKtuki3PkApYr62GDfW890BCwmqmV8WGADu76dD2J6nZHaFRlnTuOEC1cVb4fJGSPULugRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=c8QvqUxm; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8Zoqk4INoU43kv9K5QzIVVMAA5ggjljI6hMgiO9Zlw0=; b=c8QvqUxm2J2JjIlgHz766mu5J/
	mffYtXkcuTKG97lEgrc8jm6Mn7jEmNOb4ZmqoW8qNceSlD8mCYeVEKBpPcslIfotUbnsOmhLBylV5
	G9EPuk4YoF6zANuv3Mafg5fkXIMWUudA7O7rHF324n00aoUnJtUVSOup9MVX1J4mGVnbA+3wOMl+Z
	YuktbByACxhxm9aqZBUo1aJYa3Mgl4ozDysiBqmVm3lNzi/LZ7aLv+UEUA0R4JghQfTikOqCuRa8n
	ZImuNwTW9gP3tGuFl0fyLGAo7O8Sm/7+bx4XaLoJsyWMfZs3fhZCOxE7bufuy4H3nrnijAdoKtsFQ
	J2dVnXNQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttNsZ-006oI4-0l;
	Sat, 15 Mar 2025 17:32:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 17:32:27 +0800
Date: Sat, 15 Mar 2025 17:32:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [v4 PATCH 10/13] ubifs: Use crypto_acomp interface
Message-ID: <Z9VJK5npf_sMcVMd@gondor.apana.org.au>
References: <cover.1741954523.git.herbert@gondor.apana.org.au>
 <349a78bc53d3620a29cc6105b55985db51aa0a11.1741954523.git.herbert@gondor.apana.org.au>
 <e5792e49-588d-8dee-0e3e-9e73e4bedebf@huawei.com>
 <Z9VCPB_pcT4ycYyt@gondor.apana.org.au>
 <dfa799fd-5ece-4ea4-d5d0-8c1da39a3a8d@huawei.com>
 <Z9VEkEOul9bt4bc1@gondor.apana.org.au>
 <1b6176d7-31a8-7211-b648-a79bd25af6dc@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b6176d7-31a8-7211-b648-a79bd25af6dc@huawei.com>

On Sat, Mar 15, 2025 at 05:27:22PM +0800, Zhihao Cheng wrote:
>
> I think we should keep the warning, it would be better to distinguish the
> different error types.

Unfortunately that requires quite a bit of work.  If you would
like to restore the warning you will need to modify each algorithm
implementation to return a consistent error.  Right now it's all
over the place.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


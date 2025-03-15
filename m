Return-Path: <linux-pm+bounces-24095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B07A62977
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 10:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1633017A963
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 09:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE101DAC81;
	Sat, 15 Mar 2025 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="cfYyEErN"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391CB8828;
	Sat, 15 Mar 2025 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742029407; cv=none; b=sZ0Y7DFmSLf+JRn08tGBBzPIpS/2R9znLOrBl+66oXhq8zgTmdAWQfEhT2CQJQRXtMiN/YKXzp70K3oeQNJRKHOhYQSLWhUTK+JYFldmFeOregno+hffFAUWI89CTU5GNM1shnrGPKc+gX7i2PCX8JelzkZSGLWwLsSCsjx95h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742029407; c=relaxed/simple;
	bh=pk3x28CXJh62Nvdajf7sWsSjA78uDqAowKmta/aJJL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCZnG4X5fhOMiqtQObOvpPozY4P8vSss83Fsul5n8z2aQJpO3I2w6M+2XlLtqTL2N38VNJxO6Z4Z5l9ObjDCWlHSfUpsx7gLgRPn8oo/6IfJuXCqNQ1lZeaIdMl+qFdCrPAW7E5F1vT+FB4yFXiODqS4yCPecz9yqAbg1a501KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=cfYyEErN; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VXIab65iMh83UMf96eE59TaztDC5JUgOcqSXpaLANZQ=; b=cfYyEErNRnCiQ8fp4LXqPl+YAq
	unvh5ZPBJZUcURtsHcUtl7ZiDOJLaJ5ywqRfMQ+u2/luUD6AjlnMKwLMK2dDKnjWjGfE0Osp5+8np
	oKQ1vtvqmCgwxwbTUODBb1POzjDEw+8YzGSKrkUBSAG71T1grzJnmF3/VequM6K7uNbOFEJ9/tt3r
	x93OtwRG93hMYSd9UgUYP6vP+c/U7asFWMcW9a+yFelk7MHG6xKpKj0ruxp/SZ01dhxstIbGTc/DD
	AfLp0GRF2nuwTnGx1gnVLg6N0Wj1r+5g0iFvoDxqugNGWgOdkjSNIq2AHQnK2NNHMtCW51Srf/9CT
	/vv/XL5A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttNPx-006nth-00;
	Sat, 15 Mar 2025 17:02:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 17:02:52 +0800
Date: Sat, 15 Mar 2025 17:02:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [v4 PATCH 10/13] ubifs: Use crypto_acomp interface
Message-ID: <Z9VCPB_pcT4ycYyt@gondor.apana.org.au>
References: <cover.1741954523.git.herbert@gondor.apana.org.au>
 <349a78bc53d3620a29cc6105b55985db51aa0a11.1741954523.git.herbert@gondor.apana.org.au>
 <e5792e49-588d-8dee-0e3e-9e73e4bedebf@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5792e49-588d-8dee-0e3e-9e73e4bedebf@huawei.com>

On Sat, Mar 15, 2025 at 04:58:31PM +0800, Zhihao Cheng wrote:
>
> Hi, Herbert, I got some warning messages while running xfstests, it looks
> like the compressor returns error code.

Yes this is expected as incompressible data will now show up as
errors since we reduced the output buffer size due to LZO getting
fixed.  I'll silence that warning.

There are no reasons why compression should fail, other than the
data being incompressible.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


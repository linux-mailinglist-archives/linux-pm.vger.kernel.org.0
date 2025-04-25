Return-Path: <linux-pm+bounces-26214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F22A9C89C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 14:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868C31BA5E95
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C50248166;
	Fri, 25 Apr 2025 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ZAkWblRT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KeQvJ6Pt"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3646218EBA;
	Fri, 25 Apr 2025 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745583113; cv=none; b=DOyLwrgCeUZxSPpxG3xefvL7cSsdO2U+HqAFhw5RlnonRIBrEz/H9HxsIm/9D6vhPBSm5BU+svCkElR9f+QxBGm9C7nTUQuIChSe6DwYkdDkdI0AaXK3snCcL1e+l/QiCZOdKyYURiTXdLsi+tgZtkP5vNuUXZVewcSKH/ammRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745583113; c=relaxed/simple;
	bh=WmmW0IHWclTounifNSUtemyR1nHUbhUOcjwZ5ZoBFVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OU5J9L1Oi81ZtTIStDEIFbXZVJLEquRzW+0BKKiL40EQG52JqONNLUomjV59/gqBQBTWptTMq78MwZ9PM2agPU+NqgfS8sOeug70k7aiDo2ohjVJPhBpxwwoFO4FkuD7/1llKE4MFrrEUxn+zy6zsIbh4okPt606SkL/07saA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ZAkWblRT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KeQvJ6Pt; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8ED622540202;
	Fri, 25 Apr 2025 08:11:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 25 Apr 2025 08:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1745583108; x=
	1745669508; bh=EB/sg/VgUNtrfCqfzNTqoSG/O7x/uW7lya+Nhl3Jdqo=; b=Z
	AkWblRTxeLrtZL4lsbHJBVc2FQyyO8F5wSZgMYj7q1amHSUMvgmdcyEvQ0C8zlUM
	Ym2iGmY4NEHN2R5T5rEc+W2lcx4pRqZdX1yCYzHzUUIm4I9T82QGbt5w4DxggNZP
	cm9deS7r22Pyf2xNG8dxMHeaTxSsYqb/ckRWHnxhe5U8MITEdkNKxJBXQgsOUBAx
	GIqKFy0aDZudSiGM8qD8I+6kU0IPEdeeaY/fqN8zwfZca61ICLLkOX412w5I/aHA
	hBTgM0zbg9zQl1ZrhYTiUn8lSNdvzEt/Dq44gceehCCi5r/Sdwf0eEZhgEjUnX8a
	OD2zLt5UlctDAt0n/HTsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745583108; x=1745669508; bh=EB/sg/VgUNtrfCqfzNTqoSG/O7x/uW7lya+
	Nhl3Jdqo=; b=KeQvJ6PtaInmK6r+lAsb2Uir6eNKSJP73Vcb92/tLIwqTvODuRh
	bbgqcF4t0mm/TI8SMXls4mMrfbSJl6HqD8sQ7i5U1j7w5YFE+CRtS353uU1ByOyx
	5v97UGKKpFPRLDmVSc65LTjuHv3qMOh+dMJmGt9EP8k6TTua90f1qkW0a8IOIbMe
	lmPkQIUyI1v83xt2m9DUcmbiLxkJTD1180Kfs+Jmo7iN6KTPgZL2qqsW/DlCtHW9
	f5ZYKr86GXjOo00LVb4I2q5AwAV7y7ihEIoDt8Tx0fUe3Fa2Dw06zVh4W4vB+qG/
	zBikZxIi2t+Xm6bv3hDNNQkcKYeZW9dIueg==
X-ME-Sender: <xms:A3wLaEialxA_l_fysmZHryF4fDebLkiMD8kaIQizLEXMKW6e_OiQow>
    <xme:A3wLaNB8fzc0JBBamWUWL3tTnc4E5etbeFca-XxU1BKEx3KaArArirXuU7WR6gW-Y
    q4QpZQDYjZgBn9amrk>
X-ME-Received: <xmr:A3wLaMFci5J-y-AKyghueCGS3s05O47r8dxM9mV7vTtvYSk4MwKgOnzgfmxn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdef
    hfekgeetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgvrh
    gsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopehlihhn
    uhigqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrih
    gthhgrrhgusehnohgurdgrthdprhgtphhtthhopegthhgvnhhgiihhihhhrghoudeshhhu
    rgifvghirdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfh
    hrrgguvggrugdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgrvhgvlhesuhgtfidrtgiipdhrtghpthhtoheplhhinhhugidqph
    hmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghffhgvnhdrkhhl
    rghsshgvrhhtsehsvggtuhhnvghtrdgtohhm
X-ME-Proxy: <xmx:A3wLaFRQe7_guGjIwgkZymX2ZHd4S5z9BR4_hu7TXBEwNaOfcpPXZg>
    <xmx:A3wLaBxwYHM1NMGFrVSv-o4fcyyChZVMb6OCsmZ4w9o7RHEv1Liv6g>
    <xmx:A3wLaD6Af-espcLvZj-OjQF2WhxwdJNc1vJVrrzkS8tL_2O1onIcMw>
    <xmx:A3wLaOzfRo6hNLYY4qWOotzFSj6yWMVw--gedv7_a0t8b3t07HW1nA>
    <xmx:BHwLaP7eu4lWYrHeZg_N_X7zSzUkCuNnUJ_g2mKpOuSEqwSza19zu1Wd>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 08:11:46 -0400 (EDT)
Date: Fri, 25 Apr 2025 14:11:44 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [v5 PATCH 11/14] xfrm: ipcomp: Use crypto_acomp interface
Message-ID: <aAt8AIiFWZZwgCyj@krikkit>
References: <cover.1742034499.git.herbert@gondor.apana.org.au>
 <d7bccafdf38259c2b820be79763f66bfaad1497e.1742034499.git.herbert@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d7bccafdf38259c2b820be79763f66bfaad1497e.1742034499.git.herbert@gondor.apana.org.au>

Hi Herbert,

2025-03-15, 18:30:43 +0800, Herbert Xu wrote:
> +static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
> +{
> +	struct acomp_req *req = ipcomp_cb(skb)->req;
> +	struct ipcomp_req_extra *extra;
> +	const int plen = skb->data_len;
> +	struct scatterlist *dsg;
> +	int len, dlen;
>  
> -	len = dlen - plen;
> -	if (len > skb_tailroom(skb))
> -		len = skb_tailroom(skb);
> +	if (unlikely(err))
> +		goto out_free_req;
>  
> -	__skb_put(skb, len);
> +	extra = acomp_request_extra(req);
> +	dsg = extra->sg;
> +	dlen = req->dlen;
>  
> -	len += plen;
> -	skb_copy_to_linear_data(skb, scratch, len);
> +	pskb_trim_unique(skb, 0);
> +	__skb_put(skb, hlen);
>  
> -	while ((scratch += len, dlen -= len) > 0) {
> +	/* Only update truesize on input. */
> +	if (!hlen)
> +		skb->truesize += dlen - plen;

Are you sure we need to subtract plen here? When I run fragmented
traffic with ipcomp, I'm hitting the WARN from skb_try_coalesce during
reassembly, ie truesize is too small:

    delta = from->truesize - SKB_TRUESIZE(skb_end_offset(from));
    WARN_ON_ONCE(delta < len);

The splat goes away with

 	/* Only update truesize on input. */
 	if (!hlen)
-		skb->truesize += dlen - plen;
+		skb->truesize += dlen;
 	skb->data_len = dlen;
 	skb->len += dlen;

pskb_trim_unique ends up calling skb_condense, which seems to adjust
the truesize to account for all frags being dropped.

Does that look like the right fix to you?

-- 
Sabrina

